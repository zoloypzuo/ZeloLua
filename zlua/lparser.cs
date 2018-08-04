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
    class Ret //你可以试试class还是struct好。
    {
        public string Name { get; private set; }
        public int KIndex { get; private set; }
        public bool B { get; private set; }
        public RetType RetType { get; private set; }
        public Ret(int index, RetType retType)
        {
            KIndex = index;
            RetType = RetType;
        }
        public Ret(string name)
        {
            Name = name;
            RetType = RetType.Name;
        }
        public Ret()
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
            /// 反向索引局部变量名的左值；重复声明直接覆盖，所以不用管
            /// </summary>
            public Dictionary<string, int> localName2RegIndex = new Dictionary<string, int>();
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
            if (CurrFB.localName2RegIndex.ContainsKey(name)) /*name is local*/
                return CurrFB.localName2RegIndex[name];
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
            blockStack = new BlockStack(ChunkProto);
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
        public override Ret VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            double n = Double.Parse(context.GetText());
            return new Ret(AppendN(n), RetType.NIndex);
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
        /// 针对的是double，因此concat单独实现
        /// </summary>
        /// <param name="context"></param>
        /// <param name="binaryOp"></param>
        /// <returns></returns>
        Ret VisitBinaryExp(Func<double, double, double> binaryOp, Op opcode,
            Ret lhs, Ret rhs)
        {
            switch (lhs.RetType) {
                case RetType.Name:
                    switch (rhs.RetType) {//这里确实可以简化，因为nindex和regindex共用的index，所以大概的逻辑是lhs是n生成loadn否则mov regindex；参考concat
                        case RetType.Name: //a ^ b
                            FreeRegIndex--; //push 2 oprds
                            FreeRegIndex--;
                            Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, false, Name2RegIndex(lhs.Name), false, Name2RegIndex(rhs.Name)));
                            return new Ret(FreeRegIndex++, RetType.Name); //不要因为两句话相同而合并，这里就像是分类讨论一样，正确性和可读性最重要
                        case RetType.NIndex: //a ^ 1
                            FreeRegIndex--; //push 1 oprd
                            Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, false, Name2RegIndex(lhs.Name), true, rhs.KIndex));
                            return new Ret(FreeRegIndex++, RetType.Name);
                        default:
                            break;
                    }
                    break;
                case RetType.NIndex:
                    switch (rhs.RetType) {
                        case RetType.Name: //1 ^ a
                            FreeRegIndex--; //push 1 oprd
                            Emit(Bytecode.RaRKbRkc(opcode, FreeRegIndex, true, lhs.KIndex, false, Name2RegIndex(rhs.Name)));
                            return new Ret(FreeRegIndex++, RetType.Name);
                        case RetType.NIndex: // 3 ^ 2
                            var l = Ns[lhs.KIndex];
                            var r = Ns[lhs.KIndex];
                            return new Ret(AppendN(binaryOp(l, r)), RetType.NIndex);
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
        public override Ret VisitPowExp([NotNull] LuaParser.PowExpContext context)
        {
            var lhs = Visit(context.lhs); // lhs result
            var rhs = Visit(context.rhs);
            return VisitBinaryExp(LuaConf.Pow, Op.Pow, lhs, rhs);
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
                    return VisitBinaryExp(LuaConf.Mul, Op.Mul, lhs, rhs);
                case LuaLexer.DivKW:
                    return VisitBinaryExp(LuaConf.Div, Op.Div, lhs, rhs);
                case LuaLexer.ModKW:
                    return VisitBinaryExp(LuaConf.Mod, Op.Mod, lhs, rhs);
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
                    return VisitBinaryExp(LuaConf.Add, Op.Add, lhs, rhs);
                case LuaLexer.MinusKW:
                    return VisitBinaryExp(LuaConf.Sub, Op.Sub, lhs, rhs);
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
            throw new NotImplementedException(); //这里是暂时做不好的。concat和loadnil一样，RA=String.Join(RB~RC)
            var lhs = Visit(context.lhs);
            var rhs = Visit(context.rhs);
            if (lhs.RetType == RetType.SIndex && rhs.RetType == RetType.SIndex) {
                var l = Strs[lhs.KIndex];
                var r = Strs[rhs.KIndex];
                return new Ret(AppendS(l + r), RetType.SIndex);
            } else if (lhs.RetType == RetType.Name && rhs.RetType == RetType.SIndex) {
                FreeRegIndex--;
                //Emit(new Bytecode(Op.Concat, FreeRegIndex, lh, rhs.KIndex));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == RetType.SIndex && rhs.RetType == RetType.Name) {
                FreeRegIndex--;
                Emit(new Bytecode(Op.Concat, FreeRegIndex, lhs.KIndex, rhs.KIndex));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == RetType.Name && rhs.RetType == RetType.Name) {
                FreeRegIndex--;
                FreeRegIndex--;
                Emit(new Bytecode(Op.Concat, FreeRegIndex, lhs.KIndex, rhs.KIndex));
                return new Ret(FreeRegIndex++, RetType.Name);
            } else
                throw new OprdTypeException(Op.Concat);
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
            throw new NotFiniteNumberException();
            switch (context.operatorComparison.Type) {
                case LuaLexer.LtKW:
                case LuaLexer.MtKW:
                case LuaLexer.LeKW:
                case LuaLexer.MeKW:
                case LuaLexer.NeKW:
                case LuaLexer.EqKW:
                default:
                    throw new GodDamnException();
            }
        }
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
