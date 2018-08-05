using System;
using System.Collections.Generic;
using System.Diagnostics;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.Configuration;
using zlua.Gen;
using zlua.ISA;
using zlua.TypeModel;
namespace zlua.Parser
{

    enum RetType
    {
        Name,
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
    [DebuggerStepThroughAttribute]
    class Ret //你可以试试class还是struct好。
    {
        public string Name { get; private set; }
        public int KIndex { get; private set; }
        public bool B { get; private set; }
        public RetType RetType { get; private set; }
        public Ret(int index, RetType retType)
        {
            KIndex = index;
            RetType = retType;
        }
        public Ret(string name)
        {
            Name = name;
            RetType = RetType.Name;
        }
        Ret()
        {

        }
        /// <summary>
        /// 单例，表示没有返回值，比如语句
        /// </summary>
        public static readonly Ret Void = new Ret { RetType = RetType.None };
        public static readonly Ret Nil = new Ret { RetType = RetType.Nil };
        public static readonly Ret True = new Ret { RetType = RetType.B, B = true };
        public static readonly Ret False = new Ret { RetType = RetType.B, B = false };
    }

    class LParser : LuaBaseVisitor<Ret>
    {
        #region 辅助parse的数据结构和函数s
        class BlockStack
        {
            Stack<Block> blocks = new Stack<Block>();
            public Block Top { get => blocks.Peek(); }
            /// <summary>
            /// 传入chunkprot看起来比较奇怪。是因为第一个必须栈底必须是一个FuncBlock带一个ChunkProto，
            /// 不这样的话要提供一个返回chunkproto的property，更奇怪
            /// </summary>
            /// <param name="chunkProto"></param>
            public BlockStack(ChunkProto chunkProto)
            {
                blocks.Push(new FuncBlock() { p = chunkProto });
            }
            public void EnterNewBlock()
            {
                blocks.Push(new Block());
            }
            public void EnterNewFuncBlock()
            {
                var top = blocks.Peek();
                var newFb = new FuncBlock();
                Debug.Assert(top is FuncBlock);
                (top as FuncBlock).p.pp.Add(newFb.p);
                blocks.Push(newFb);
            }
            public void ExitBlock() { blocks.Pop(); }
        }
        /// <summary>
        /// 作用域处理的基本单位。do end是一个块，func也是一个块，while，if else，for也是一个块
        /// 直接作为单链表栈的对象来使用。就像学数据结构时的C单链表Node对象一样
        /// </summary>
        class Block
        {
            /// <summary>
            /// 反向索引局部变量名的左值；重复声明直接覆盖，所以不用管；这个结构替代了LocVar。
            /// </summary>
            public Dictionary<string, Tuple<int, int>> localName2RegIndexAndStartPc = new Dictionary<string, Tuple<int, int>>();
        }
        /// <summary>
        /// 当前正在编译的函数块的编译期信息
        /// </summary>
        class FuncBlock : Block
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
        }
        #region  处理scope
        BlockStack blockStack;
        Block CurrBlock { get => blockStack.Top; }
        FuncBlock CurrFB { get => blockStack.Top as FuncBlock; }
        Proto CurrP { get => CurrFB.p; }
        int FreeRegIndex { get => CurrFB.freeRegIndex; set => CurrFB.freeRegIndex = value; }
        int CurrPc { get => CurrFB.CurrPc; }
        internal ChunkProto ChunkProto { get; } = new ChunkProto();
        internal List<string> Strs { get => ChunkProto.strs; }
        internal List<double> Ns { get => ChunkProto.ns; }
        Dictionary<double, int> n2NsIndex = new Dictionary<double, int>();
        Dictionary<string, int> s2StrsIndex = new Dictionary<string, int>();
        /// <summary>
        /// name通过scope映射到lvalue（龙书第二章重点），因此还要有反向索引表
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        int Name2RegIndex(string name)
        {
            if (CurrFB.localName2RegIndexAndStartPc.ContainsKey(name)) /*name is local*/
                return CurrBlock.localName2RegIndexAndStartPc[name].Item1;
            else {
                /*name is not local to all functions from current function to the chunk, so it is global*/
                return name.GetHashCode(); //暂时这样。事实上先check uv再。
                /*name is upval?*/
                throw new NotImplementedException();//TODO
                //var fs = CurrFB;
                //while (fs != null) {
                //    if (fs.localName2RegIndex.ContainsKey(name))
                //        return fs.localName2RegIndex[name];
                //    fs = fs.prev;
                //}
            }

        }
        public LParser()
        {
            blockStack = new BlockStack(ChunkProto);//初始化一个Chunk FuncBlock作为最初的块
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
                int index = Ns.Count;
                n2NsIndex.Add(n, index);
                Ns.Add(n);
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
                int index = Strs.Count;
                s2StrsIndex.Add(s, index);
                Strs.Add(s);
                return index;
            }
            return s2StrsIndex[s];
        }
        #endregion

        #endregion
        #region 自动生成的部分

        #region literal，最简单的部分，一切都从这里开始
        /// <summary>
        /// 纯数字literal
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            double n = Double.Parse(context.GetText());
            var a = new Ret(AppendN(n), RetType.NIndex);
            return a;
        }
        /// <summary>
        /// string literal
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            var s = context.GetText().Trim(new char[] { '\'', '\"' });//strip quotes on both sides
            return new Ret(AppendS(s), RetType.SIndex);
        }
        /// <summary>
        /// nil, false, true, vararg
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            switch (context.nilfalsetruevararg.Type) {
                case LuaLexer.NilKW: return Ret.Nil;
                case LuaLexer.FalseKW: return Ret.False;
                case LuaLexer.TrueKW: return Ret.True;
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
        public override Ret VisitUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            var result = Visit(context.exp());
            switch (context.operatorUnary.Type) {
                case LuaLexer.NotKW:
                    switch (result.RetType) {
                        case RetType.Name:
                            FreeRegIndex--; //pop one oprd
                            Emit(Bytecode.RaRb(Op.Not, FreeRegIndex, result.KIndex));
                            return new Ret(FreeRegIndex++, RetType.Name); //push result
                        case RetType.NIndex:
                            return Ret.False; //接下来是返回常量的not结果，
                        case RetType.SIndex:
                            return Ret.False;
                        case RetType.B:
                            return result.B ? Ret.False : Ret.True;
                        case RetType.Nil:
                            return Ret.True;
                        default:
                            throw new GodDamnException();
                    }
                case LuaLexer.LenKW:
                    //len针对字符串和表，而且可以有元方法（exp不可能有元方法，因此代码生成不用管）
                    //string我们仍然编译时计算，但是表就不了，因为这样要在result里加一个类型，然而只有这种情况，不值得（事实上很难做）
                    switch (result.RetType) {
                        case RetType.Name:
                            FreeRegIndex--;
                            Emit(Bytecode.RaRb(Op.Len, FreeRegIndex, result.KIndex));
                            return new Ret(FreeRegIndex++, RetType.Name);
                        case RetType.SIndex:
                            var s = Strs[result.KIndex];
                            return new Ret(AppendN(s.Length), RetType.NIndex);
                        default:
                            throw new OprdTypeException(Op.Len);//#1，#nil，#false
                    }
                case LuaLexer.MinusKW:
                    //-针对number
                    switch (result.RetType) {
                        case RetType.Name:
                            FreeRegIndex--;
                            Emit(Bytecode.RaRb(Op.Unm, FreeRegIndex, 0));
                            return new Ret(FreeRegIndex++, RetType.Name);
                        case RetType.NIndex:
                            var n = Ns[result.KIndex];
                            return new Ret(AppendN(n), RetType.NIndex);
                        default:
                            throw new OprdTypeException(Op.Unm);
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
        /// 使用general的方式，switch不能用了，因为case必须是const不能是参数传入的变量
        /// 不得不用了dynamic，因为dynamic这个位置可能是bool，double，string
        /// 另一种方式是用重载，重载三次。这样会有repeat。这里的问题在于如何对类型进行编程。我根据类型来执行一些事情，不得已dynamic
        /// </summary>
        /// <param name="context"></param>
        /// <param name="binaryOp"></param>
        /// <returns></returns>
        Ret VisitBinaryExp(Func<dynamic, dynamic, dynamic> binaryOp, Op opcode, RetType KType, Ret lhs, Ret rhs)
        {
            if (lhs.RetType == KType && rhs.RetType == KType) { // 2^3, "hello".."world", "1<=3"
                switch (KType) {
                    case RetType.NIndex: {
                            var l = Ns[lhs.KIndex];
                            var r = Ns[rhs.KIndex];
                            return new Ret(AppendN(binaryOp(l, r)), RetType.NIndex);
                        }
                    case RetType.SIndex: {
                            var l = Strs[lhs.KIndex];
                            var r = Strs[rhs.KIndex];
                            return new Ret(AppendN(binaryOp(l, r)), RetType.SIndex);
                        }
                    case RetType.B: {
                            var l = lhs.B;
                            var r = rhs.B;
                            return new Ret(binaryOp(l, r), RetType.B);
                        }
                    default:
                        throw new OprdTypeException(opcode);
                }
            } else if (lhs.RetType == RetType.Name && rhs.RetType == KType) {
                FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, false, Name2RegIndex(lhs.Name), true, rhs.KIndex));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == KType && rhs.RetType == RetType.Name) {
                FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, true, lhs.KIndex, false, Name2RegIndex(rhs.Name)));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == RetType.Name && rhs.RetType == RetType.Name) {
                FreeRegIndex--;
                FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, false, Name2RegIndex(lhs.Name), false, Name2RegIndex(rhs.Name)));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else
                throw new OprdTypeException(Op.Concat);
        }
        /// <summary>
        /// ^
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitPowExp([NotNull] LuaParser.PowExpContext context)
        {
            var lhs = Visit(context.lhs); // lhs result
            var rhs = Visit(context.rhs);
            return VisitBinaryExp((l, r) => Math.Pow(l, r), Op.Pow, RetType.NIndex, lhs, rhs);
        }
        /// <summary>
        /// */
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitMuldivExp([NotNull] LuaParser.MuldivExpContext context)
        {
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            switch (context.operatorMulDivMod.Type) {
                case LuaLexer.MulKW:
                    return VisitBinaryExp((l, r) => l * r, Op.Mul, RetType.NIndex, lhs, rhs);
                case LuaLexer.DivKW:
                    return VisitBinaryExp((l, r) => l / r, Op.Div, RetType.NIndex, lhs, rhs);
                case LuaLexer.ModKW:
                    return VisitBinaryExp((l, r) => l % r, Op.Mod, RetType.NIndex, lhs, rhs);
                default:
                    throw new GodDamnException();
            }
        }
        /// <summary>
        /// +-
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitAddsubExp([NotNull] LuaParser.AddsubExpContext context)
        {
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            switch (context.operatorAddSub.Type) {
                case LuaLexer.AddKW:
                    return VisitBinaryExp((l, r) => l + r, Op.Add, RetType.NIndex, lhs, rhs);
                case LuaLexer.MinusKW:
                    return VisitBinaryExp((l, r) => l - r, Op.Sub, RetType.NIndex, lhs, rhs);
                default:
                    throw new GodDamnException();
            }
        }
        /// <summary>
        /// ..
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitConcatExp([NotNull] LuaParser.ConcatExpContext context)
        {
            //结论】没法和double的arith混在一起，这里用了第二种写法，效果差不多
            //这里在设计上repeat了，但是很难做好。oprd的type有double和str两种，分别有常量池，
            //你要区分类型，那么传入一个bool，就是控制耦合，然后会有几处?:运算符，而且挺难懂的。不如手写第二遍。
            //至于if else的写法，上面是switch，这个ifelse版已经好一些了，试图去简化条件，或者优化条件是比较得不偿失的
            //这里是暂时做不好的。concat和loadnil一样，RA=String.Join(RB~RC)
            //但是我放弃，改成基本的二元
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            return VisitBinaryExp((l, r) => l + r, Op.Concat, RetType.SIndex, lhs, rhs);
        }
        #endregion
        #region 逻辑与关系运算
        //| lhs=exp operatorComparison=('<' | '>' | '<=' | '>=' | '~=' | '==') rhs=exp #cmpExp   要单独写，和转移有关
        //| lhs=exp operatorAnd='and' rhs=exp #andExp                                            同上
        //| lhs=exp operatorOr='or' rhs=exp #orExp                                               同上
        public override Ret VisitCmpExp([NotNull] LuaParser.CmpExpContext context)
        {
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            switch (context.operatorComparison.Type) {
                case LuaLexer.LtKW:
                    return VisitBinaryExp((l, r) => l < r, Op.Lt, RetType.B, lhs, rhs);
                case LuaLexer.MtKW:
                    return VisitBinaryExp((l, r) => l > r, Op.Lt, RetType.B, rhs, lhs);
                case LuaLexer.LeKW:
                    return VisitBinaryExp((l, r) => l <= r, Op.Le, RetType.B, lhs, rhs);
                case LuaLexer.MeKW:
                    return VisitBinaryExp((l, r) => l >= r, Op.Le, RetType.B, rhs, lhs);
                case LuaLexer.NeKW:
                    return VisitBinaryExp((l, r) => l != r, Op.Ne, RetType.B, lhs, rhs);
                case LuaLexer.EqKW:
                    return VisitBinaryExp((l, r) => l == r, Op.Le, RetType.B, lhs, rhs);
                default:
                    throw new GodDamnException();
            }
        }
        #endregion
        /// <summary>
        /// 这里写不好的。分类讨论太多了。 测试通过
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        {
            var names = context.namelist().NAME();
            //context.GetToken(2, 0) == null if no equal，没有正确判断，有=也返回true，大概是token不对
            if (context.explist() == null) { // , eg. local a,b,c 只声明不赋值，freereg+=n，names加入符号表
                int _nilStart = FreeRegIndex;
                foreach (var item in names) {
                    CurrBlock.localName2RegIndexAndStartPc[item.GetText()] =
                        Tuple.Create(FreeRegIndex++, CurrPc);
                }
                Emit(new Bytecode(Op.LoadNil, _nilStart, FreeRegIndex - 1));
                return Ret.Void;
            }

            var exps = context.explist().exp();
            // local a,b,c=1 右侧不足，同上
            // local a,b=1,2,3,4 截断

            //先遍历一遍名字，不允许重复声明，这里还要想一想。嵌入循环不好，因为后面其实分类讨论了
            foreach (var item in names) {
                var name = item.GetText();
                if (CurrBlock.localName2RegIndexAndStartPc.ContainsKey(name))
                    throw new Exception("不允许重复声明局部变量" + name); //嗯，全局也是，学习python
            }
            var tempSymbolTable = new Dictionary<string, Tuple<int, int>>();
            // iterate exps
            for (int i = 0; i < Math.Min(names.Length, exps.Length); i++) {
                var result = Visit(exps[i]);
                switch (result.RetType) {
                    case RetType.Name:
                        FreeRegIndex--; //pop the result
                        break;
                    case RetType.NIndex:
                        Emit(new Bytecode(Op.LoadN, FreeRegIndex, result.KIndex));
                        break;
                    case RetType.SIndex:
                        Emit(new Bytecode(Op.LoadS, FreeRegIndex, result.KIndex));
                        break;
                    case RetType.B:
                        Emit(new Bytecode(Op.LoadBool, FreeRegIndex, Convert.ToInt32(result.B), 0));//<no frills> p11，要处理pc++，想一想
                        break;
                    case RetType.Nil:
                        Emit(new Bytecode(Op.LoadNil, FreeRegIndex, FreeRegIndex, 0));
                        break;
                    default:
                        throw new Exception();
                }
                //详见《2018-08-05 22-15-41.971398.lua》，reg会分配给新local，但是它还没声明（没加入符号表）
                //，这里简单地，先存起来然后loop外加给符号表
                tempSymbolTable[names[i].GetText()] = Tuple.Create(FreeRegIndex++, CurrPc);
            }
            int nilStart = FreeRegIndex;
            for (int i = Math.Min(names.Length, exps.Length); i < names.Length; i++) {
                tempSymbolTable[names[i].GetText()] = Tuple.Create(FreeRegIndex++, CurrPc);
            }
            if (names.Length > exps.Length)
                Emit(new Bytecode(Op.LoadNil, nilStart, FreeRegIndex - 1));
            foreach (var item in tempSymbolTable) {
                CurrBlock.localName2RegIndexAndStartPc[item.Key] = item.Value;
            }
            return Ret.Void; //statements return void
        }
        #region function def
        //| 'function' funcname funcbody #functiondefStat
        //| 'local' 'function' NAME funcbody #localfunctiondefStat
        //| functiondef #functiondefExp

        //相关的几个子规则
        //functiondef: 'function' funcbody;  //定义函数;
        //funcbody: '(' parlist? ')' block 'end';
        //parlist: namelist(',' '...')? | '...' ; //param list，一堆param后vararg或单独vararg;

        //显然也是local最简单（因为name固定就是个id），相当于local f=funcion （）。。。end
        //所以我们要处理prefixexp里的函数部分，提取出一个生成表达式的方法。因为这几个规则要共用

        public override Ret VisitFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context)
        {
            return base.VisitFunctiondefExp(context);
        }
        public override Ret VisitFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context)
        {
            return base.VisitFunctiondefStat(context);
        }
        public override Ret VisitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {
            return base.VisitLocalfunctiondefStat(context);
        }
        #endregion

    }

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
    #endregion
}

