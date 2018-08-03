using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.Gen;
using zlua.ISA;
using zlua.TypeModel;
namespace zlua.Parser
{
    /// <summary>
    /// 见鬼了异常，因为有些分支根本不可能走到
    /// </summary>
    class GodDamnException : Exception { }
    /// <summary>
    /// 错误的操作数类型，我们用opcode作为提示
    /// </summary>
    class OprdTypeException : Exception
    {
        public OprdTypeException(Opcodes opcode) : base(opcode.ToString() + "错误的操作数") { }
    }
    enum ResultTypes
    {
        RegIndex,
        NIndex,
        SIndex,
        B,
        Nil,
        None, //没有返回值，比如语句
    }
    /// <summary>
    /// return type of `Visit* methods，递归时要获取结果，比如构建表达式；需要Reg
    /// 设计策略】通过ctor一次初始化，之后只读；
    /// 一开时设计成包含了double，string，bool，现在用一个int。非常省。设计思路改为，任何常量都会加入常量池，但是只有一份，因为会复用，
    /// Visit*返回index来通信，bool在uniton语义下其实可以和int合并（TValue中也是）但是不。相比于原来，如果1+2，1，2不会加入常量池（这是没办法的，你写了就知道，你传index那么中间的literal必须也加入常量池）
    /// </summary>
    class Result //你可以试试class还是struct好。
    {
        public int Index { get; private set; }
        public bool B { get; private set; }
        public ResultTypes ResultType { get; private set; }
        public Result(int index, ResultTypes resultType)
        {
            Index = index;
            ResultType = ResultType;
        }
        public Result()
        {

        }
        /// <summary>
        /// 单例，表示没有返回值，比如语句
        /// </summary>
        public static readonly Result Void = new Result { ResultType = ResultTypes.None };
        public static readonly Result Nil = new Result { ResultType = ResultTypes.Nil };
        public static readonly Result True = new Result { ResultType = ResultTypes.B, B = true };
        public static readonly Result False = new Result { ResultType = ResultTypes.B, B = false };
    }

    class LParser : LuaBaseVisitor<Result>
    {
        #region 辅助parse的数据结构和函数s
        /// <summary>
        /// 当前正在编译的函数块的编译期信息；编译时函数块s是一个同质的嵌套结构,这里用单链表实现一个栈
        /// </summary>
        class FuncState
        {
            public Proto p;
            /// <summary>
            /// first free register index
            /// </summary>
            public int freeRegIndex = 0;
            /// <summary>
            /// 指向第一个指令数组的第一个可用位置
            /// </summary>
            public int CurrPc { get => p.codes.Count; }
            public FuncState prev;
            /// <summary>
            /// 反向索引局部变量名的左值；重复声明直接覆盖，所以不用管
            /// </summary>
            public Dictionary<string, int> localName2RegIndex = new Dictionary<string, int>();

            public FuncState()
            {

            }
        }
        #region 处理FS
        /// <summary>
        /// 进入新函数块
        /// </summary>
        void EnterNewFunc()
        {
            var new_fs = new FuncState();
            currFs.p.inner_funcs.Add(new_fs.p);
            currFs = new_fs;
        }
        /// <summary>
        /// 离开当前函数块
        /// </summary>
        void ExitCurrFunc()
        {
            Debug.Assert(currFs.prev != null, "");
            currFs = currFs.prev;
        }
        FuncState currFs;
        Proto CurrP { get => currFs.p; }
        int FreeRegIndex { get => FreeRegIndex; set => FreeRegIndex = value; }
        public ChunkProto ChunkProto { get; } = new ChunkProto();
        public Dictionary<double, int> n2NsIndex = new Dictionary<double, int>();
        public Dictionary<string, int> s2StrsIndex = new Dictionary<string, int>();
        #endregion
        #region  处理scope
        /// <summary>
        /// name通过scope映射到lvalue（龙书第二章重点），因此还要有反向索引表
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        int Name2RegIndex(string name)
        {
            if (currFs.localName2RegIndex.ContainsKey(name)) /*name is local*/
                return currFs.localName2RegIndex[name];
            else {
                /*name is not local to all functions from current function to the chunk, so it is global*/
                return name.GetHashCode(); //暂时这样。事实上先check uv再。
                /*name is upval?*/
                throw new NotImplementedException();//TODO
                var fs = currFs;
                while (fs != null) {
                    if (fs.localName2RegIndex.ContainsKey(name))
                        return fs.localName2RegIndex[name];
                    fs = fs.prev;
                }
            }

        }
        #endregion
        #region 其他辅助函数
        /// <summary>
        /// 添加新指令
        /// </summary>
        /// <param name="bytecode"></param>
        void Emit(Bytecode bytecode)
        {
            CurrP.codes.Add(bytecode);
        }
        /// <summary>
        /// 增加新n常量，返回index（可能新分配，可能是复用的）
        /// </summary>
        /// <param name="n"></param>
        int AppendN(double n)
        {
            if (!n2NsIndex.ContainsKey(n)) {  //常量池里没有再新加，这样复用
                int index = ChunkProto.ns.Count;
                n2NsIndex.Add(n, index);
                ChunkProto.ns.Add(n);
                return index;
            }
            return n2NsIndex[n];
        }
        /// <summary>
        /// 增加新s常量
        /// </summary>
        /// <param name="s"></param>
        int AppendS(string s)
        {
            if (!s2StrsIndex.ContainsKey(s)) {
                int index = ChunkProto.strs.Count;
                s2StrsIndex.Add(s, index);
                ChunkProto.strs.Add(s);
                return index;
            }
            return s2StrsIndex[s];
        }
        #endregion
        int nLabels = 0;
        public LParser()
        {
            currFs = new FuncState() { p = ChunkProto };
        }
        #endregion
        #region 自动生成的部分
        //public override Result VisitCmpExp([NotNull] LuaParser.CmpExpContext context)
        //{
        //    switch (context.operatorComparison.Type) {
        //        case LuaLexer.LtKW:
        //            Console.WriteLine("Lt " + (nTemps++) + Visit(context.exp(0)) + Visit(context.exp(1)));
        //            Console.WriteLine("Jmp " + "foo");
        //            break;
        //        case LuaLexer.MtKW:
        //            Console.WriteLine("Lt " + (nTemps++) + Visit(context.exp(1)) + Visit(context.exp(0)));
        //            Console.WriteLine("Jmp " + "foo");
        //            break;
        //        default:
        //            break;
        //    }
        //    return nTemps;
        //}

        //public override Result VisitIfelseStat([NotNull] LuaParser.IfelseStatContext context)
        //{
        //    Visit(context.exp());
        //    Visit(context.block());
        //    Console.WriteLine("L" + nLabels + ":");
        //    foreach (var item in context.elseifBlock()) {
        //        Visit(item);
        //        Console.WriteLine("L" + nLabels + ":");
        //    }
        //    Visit(context.elseBlock());
        //    Console.WriteLine("L" + nLabels + ":");
        //    return -1;
        //}
        #region literal，最简单的部分，一切都从这里开始
        /// <summary>
        /// 纯数字literal
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            double n = Double.Parse(context.GetText());
            return new Result(AppendN(n), ResultTypes.NIndex);
        }
        /// <summary>
        /// string literal
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            var s = context.GetText().Trim(new char[] { '\'', '\"' });//strip quotes on both sides
            return new Result(AppendS(s), ResultTypes.SIndex);
        }
        /// <summary>
        /// nil, false, true, vararg
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            switch (context.nilfalsetruevararg.Type) {
                case LuaLexer.NilKW: return Result.Nil;
                case LuaLexer.FalseKW: return Result.False;
                case LuaLexer.TrueKW: return Result.True;
                case LuaLexer.VarargKW:
                    throw new NotImplementedException();
                default:
                    throw new GodDamnException();
            }
        }
        #endregion
        #region 算术运算    
        //| <assoc=right> lhs=exp operatorPower='^' rhs=exp #powExp                              完成
        //| operatorUnary=('not' | '#' | '-' /*| '~' not in 5.1*/) exp #unmExp                   完成
        //| lhs=exp operatorMulDivMod=('*' | '/' | '%' /*| '//' not in 5.1*/) rhs=exp #muldivExp 完成
        //| lhs=exp operatorAddSub=('+' | '-') rhs=exp #addsubExp                                完成
        //| <assoc=right> lhs=exp operatorStrcat='..' rhs=exp #concatExp                         要单独写，str，完成


        /// <summary>
        /// - # not，单目运算的oprd类型特殊，还是得一个一个处理
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            var result = Visit(context.exp());
            switch (context.operatorUnary.Type) {
                case LuaLexer.NotKW:
                    switch (result.ResultType) {
                        case ResultTypes.RegIndex:
                            //新分配reg，RA= not RB，c永远是0，不用
                            Emit(new Bytecode(Opcodes.Not, FreeRegIndex, result.Index, 0));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex);
                        case ResultTypes.NIndex:
                            return Result.False; //接下来是返回常量的not结果，
                        case ResultTypes.SIndex:
                            return Result.False;
                        case ResultTypes.B:
                            return result.B ? Result.False : Result.True;
                        case ResultTypes.Nil:
                            return Result.True;
                        default:
                            throw new GodDamnException();
                    }
                case LuaLexer.LenKW:
                    //len针对字符串和表，而且可以有元方法（exp不可能有元方法，因此代码生成不用管）
                    //string我们仍然编译时计算，但是表就不了，因为这样要在result里加一个类型，然而只有这种情况，不值得
                    switch (result.ResultType) {
                        case ResultTypes.RegIndex:
                            //新分配，RA=#RB，RC永远不用
                            Emit(new Bytecode(
                                Opcodes.Len, FreeRegIndex, result.Index, 0));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex);
                        case ResultTypes.SIndex:
                            var s = ChunkProto.strs[result.Index];
                            return new Result(AppendN(s.Length), ResultTypes.NIndex);
                        default:
                            throw new OprdTypeException(Opcodes.Len);//#1，#nil，#false
                    }
                case LuaLexer.MinusKW:
                    //-针对number
                    switch (result.ResultType) {
                        case ResultTypes.RegIndex:
                            //同not指令的格式
                            Emit(new Bytecode(Opcodes.Unm, FreeRegIndex, 0));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex);
                        case ResultTypes.NIndex:
                            var n = ChunkProto.ns[result.Index];
                            return new Result(AppendN(n), ResultTypes.NIndex);
                        default:
                            throw new OprdTypeException(Opcodes.Unm);
                    }
                default:
                    throw new GodDamnException();
            }
        }
        /// <summary>
        /// 一个通用的处理算术运算的函数
        /// 按lhs和rhs的类型分类讨论，lhs和rhs可能是name或num，共四种情况，其他的是异常
        /// Func用于真实的算术运算，opcode用于生成指令，lhs和rhs替代了传入context，因为不能修改生成的代码（否则你会后悔的，重新生成就火葬场了）
        /// ，ANLR也没法对所有binary op提取父类（接口），因为alternative用来区别优先级了
        /// 针对的是double，因此concat单独实现
        /// </summary>
        /// <param name="context"></param>
        /// <param name="binaryOp"></param>
        /// <returns></returns>
        Result VisitBinaryExp(Func<double, double, double> binaryOp, Opcodes opcode,
            Result lhs, Result rhs)
        {
            switch (lhs.ResultType) {
                case ResultTypes.RegIndex:
                    switch (rhs.ResultType) {//这里确实可以简化，因为nindex和regindex共用的index，所以大概的逻辑是lhs是n生成loadn否则mov regindex；参考concat
                        case ResultTypes.RegIndex: //a ^ b
                            Emit(new Bytecode(Opcodes.Move, FreeRegIndex++, lhs.Index, 0));
                            Emit(new Bytecode(Opcodes.Move, FreeRegIndex, rhs.Index, 0));
                            Emit(new Bytecode(opcode, FreeRegIndex, lhs.Index, rhs.Index));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex); //不要因为两句话相同而合并，这里就像是分类讨论一样，正确性和可读性最重要
                        case ResultTypes.NIndex: //a ^ 1
                            Emit(new Bytecode(Opcodes.Move, FreeRegIndex++, lhs.Index, 0));
                            Emit(new Bytecode(Opcodes.LoadN, FreeRegIndex, rhs.Index));
                            Emit(new Bytecode(opcode, FreeRegIndex, lhs.Index, rhs.Index));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex);
                        default:
                            break;
                    }
                    break;
                case ResultTypes.NIndex:
                    switch (rhs.ResultType) {
                        case ResultTypes.RegIndex: //1 ^ a
                            Emit(new Bytecode(Opcodes.LoadN, FreeRegIndex++, lhs.Index));
                            Emit(new Bytecode(Opcodes.Move, FreeRegIndex, rhs.Index, 0));
                            Emit(new Bytecode(opcode, FreeRegIndex, lhs.Index, rhs.Index));
                            return new Result(FreeRegIndex++, ResultTypes.RegIndex);
                        case ResultTypes.NIndex: // 3 ^ 2
                            var l = ChunkProto.ns[lhs.Index];
                            var r = ChunkProto.ns[lhs.Index];
                            return new Result(AppendN(binaryOp(l, r)), ResultTypes.NIndex);
                        default:
                            break;
                    }
                    break;
                default:
                    throw new OprdTypeException(opcode); //这里就粗粒度一些，我也不细到lhs还是rhs。管他呢
            }
            throw new GodDamnException();
        }
        /// <summary>
        /// ^
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitPowExp([NotNull] LuaParser.PowExpContext context)
        {
            var lhs = Visit(context.lhs); // lhs result
            var rhs = Visit(context.rhs);
            return VisitBinaryExp(Math.Pow, Opcodes.Pow, lhs, rhs);
        }
        /// <summary>
        /// */
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitMuldivExp([NotNull] LuaParser.MuldivExpContext context)
        {
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            switch (context.operatorMulDivMod.Type) {
                case LuaLexer.MulKW:
                    return VisitBinaryExp((x, y) => x * y, Opcodes.Mul, lhs, rhs);
                case LuaLexer.DivKW:
                    return VisitBinaryExp((x, y) => x / y, Opcodes.Div, lhs, rhs);
                case LuaLexer.ModKW:
                    return VisitBinaryExp((x, y) => x % y, Opcodes.Mod, lhs, rhs);
                default:
                    throw new GodDamnException();
            }
        }
        /// <summary>
        /// +-
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitAddsubExp([NotNull] LuaParser.AddsubExpContext context)
        {
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            switch (context.operatorAddSub.Type) {
                case LuaLexer.AddKW:
                    return VisitBinaryExp((x, y) => x + y, Opcodes.Add, lhs, rhs);
                case LuaLexer.MinusKW:
                    return VisitBinaryExp((x, y) => x - y, Opcodes.Sub, lhs, rhs);
                default:
                    throw new GodDamnException();
            }
        }
        /// <summary>
        /// ..
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Result VisitConcatExp([NotNull] LuaParser.ConcatExpContext context)
        {
            //这里在设计上repeat了，但是很难做好。oprd的type有double和str两种，分别有常量池，
            //你要区分类型，那么传入一个bool，就是控制耦合，然后会有几处?:运算符，而且挺难懂的。不如手写第二遍。
            //至于if else的写法，上面是switch，这个ifelse版已经好一些了，试图去简化条件，或者优化条件是比较得不偿失的
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            if (lhs.ResultType == ResultTypes.SIndex && rhs.ResultType == ResultTypes.SIndex) {
                var l = ChunkProto.strs[lhs.Index];
                var r = ChunkProto.strs[rhs.Index];
                return new Result(AppendS(l + r), ResultTypes.SIndex);
            } else if (lhs.ResultType == ResultTypes.RegIndex && rhs.ResultType == ResultTypes.SIndex) {
                Emit(new Bytecode(Opcodes.Move, FreeRegIndex++, lhs.Index, 0));
                Emit(new Bytecode(Opcodes.LoadS, FreeRegIndex, rhs.Index));
                Emit(new Bytecode(Opcodes.Concat, FreeRegIndex, lhs.Index, rhs.Index));
                return new Result(FreeRegIndex++, ResultTypes.RegIndex);
            } else if (lhs.ResultType == ResultTypes.SIndex && rhs.ResultType == ResultTypes.RegIndex) {
                Emit(new Bytecode(Opcodes.LoadS, FreeRegIndex++, lhs.Index, 0));
                Emit(new Bytecode(Opcodes.Move, FreeRegIndex, rhs.Index));
                Emit(new Bytecode(Opcodes.Concat, FreeRegIndex, lhs.Index, rhs.Index));
                return new Result(FreeRegIndex++, ResultTypes.RegIndex);
            } else if (lhs.ResultType == ResultTypes.RegIndex && rhs.ResultType == ResultTypes.RegIndex) {
                Emit(new Bytecode(Opcodes.Move, FreeRegIndex++, lhs.Index, 0));
                Emit(new Bytecode(Opcodes.Move, FreeRegIndex, rhs.Index));
                Emit(new Bytecode(Opcodes.Concat, FreeRegIndex, lhs.Index, rhs.Index));
                return new Result(FreeRegIndex++, ResultTypes.RegIndex);
            } else
                throw new OprdTypeException(Opcodes.Concat);
        }
        #endregion
        #region 逻辑与关系运算
        //| lhs=exp operatorComparison=('<' | '>' | '<=' | '>=' | '~=' | '==') rhs=exp #cmpExp   要单独写，和转移有关
        //| lhs=exp operatorAnd='and' rhs=exp #andExp                                            同上
        //| lhs=exp operatorOr='or' rhs=exp #orExp                                               同上
        #endregion
        //public override Result VisitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        //{
        //    var namelist = context.namelist().NAME();
        //    bool no_equal = context.GetToken(2, 0) == null;
        //    // local a,b,c=1,2,3 左侧加符号表，加初始化指令；右侧要从某个地方（exp栈可能）拿到exp的位置，而且不知道指令类型TODO
        //    // local a,b,c 只声明不赋值，根据有没有=判断，freereg+=n，names加入符号表
        //    // local a,b,c=1 右侧不足，同上
        //    // local a,b=1,2,3,4 截断
        //    //初始化locvar
        //    for (int i = 0; i < namelist.Length; i++) {
        //        var lv = new LocVar() {
        //            var_name = namelist[i].GetText(),
        //            startpc = Fs.CurrPc,
        //        };
        //        CurrP.locvars.Add(lv);
        //    }
        //    nNames = namelist.Length;
        //    return -1;
        //}
        //public override Result VisitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        //{
        //    EnterNewFunc();
        //    return -1;
        //}


        #endregion
    }
}
