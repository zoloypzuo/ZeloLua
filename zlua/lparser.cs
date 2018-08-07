using System;
using System.Collections.Generic;
using System.Diagnostics;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.Configuration;
using System.Linq;
using zlua.Gen;
using zlua.ISA;
using zlua.TypeModel;
namespace zlua.Parser
{

    enum RetType
    {
        Name,
        RegIndex, //加回来了，我很可能错了
        NIndex,
        SIndex,
        PIndex, //proto index
        B,
        Nil,
        None, //没有返回值，比如语句
    }
    /// <summary>
    /// return type of `Visit* methods，递归时要获取结果，比如构建表达式
    /// 设计策略】通过ctor一次初始化，之后只读；
    /// 任何常量都会加入常量池，但是只有一份，因为会复用，
    /// bool在uniton语义下其实可以和int合并（TValue中也是）但是不。
    /// </summary>
    [DebuggerStepThroughAttribute]
    class Ret //你可以试试class还是struct好。
    {
        public string Name { get; private set; }
        public int KIndex { get; private set; }
        public bool B { get; private set; } //可以优化到int里
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
        /// <summary>
        /// 一个管理“块栈”的结构，形象地，{[[{}]]}：最外层一定是func block；
        /// 第二个栈标记了各个func block的indexes
        /// block和func block必须维护两个栈否则你新建enclosed函数时找不到父函数
        /// 注意这个和EBNF里那个"block"不是一样的，这里管scope，指do end块和func end块
        /// stack不够自由。因为要处理local最为特殊情况，stack的foreach没法用
        /// </summary>
        class BlockStack
        {
            public List<Block> blockStack = new List<Block>();
            public List<int> funcBlockIndexes = new List<int>();
            public Block Top { get => blockStack.Last(); }
            public FuncBlock FBTop
            {
                get
                {
                    var fbtop = blockStack[funcBlockIndexes.Last()] as FuncBlock;
                    Debug.Assert(fbtop != null);
                    return fbtop;
                }
            }
            public ChunkProto ChunkProto { get; private set; } //set only in ctor once
            public int _LastKProtoIndex { get => FBTop.p.pp.Count - 1; } //kproto[-1]的index，emit closure用
            /// <summary>
            /// 传入chunkprot看起来比较奇怪。是因为第一个必须栈底必须是一个FuncBlock带一个ChunkProto，
            /// 不这样的话要提供一个返回chunkproto的property，更奇怪 =>真香
            /// </summary>
            /// <param name="chunkProto"></param>
            public BlockStack()
            {
                ChunkProto = new ChunkProto();
                var chunk = new FuncBlock() { p = ChunkProto };
                funcBlockIndexes.Add(blockStack.Count);
                blockStack.Add(chunk);
            }
            public void EnterNewBlock()
            {
                blockStack.Add(new Block());
            }
            public void EnterNewFuncBlock()
            {
                var newFb = new FuncBlock() { p = new Proto() };//这里分开new，因为第一次chunkproto是单独new的
                FBTop.p.pp.Add(newFb.p);
                funcBlockIndexes.Add(blockStack.Count);
                blockStack.Add(newFb);
            }
            public void ExitBlock() { blockStack.RemoveAt(blockStack.Count - 1); }
            public void ExitFuncBlock()
            {
                blockStack.RemoveAt(blockStack.Count - 1);
                funcBlockIndexes.RemoveAt(funcBlockIndexes.Count - 1);
            }

        }
        /// <summary>
        /// 作用域处理的基本单位。do end是一个块，func也是一个块，while，if else，for也是一个块
        /// 直接作为单链表栈的对象来使用。就像学数据结构时的C单链表Node对象一样
        /// </summary>
        class Block
        {
            /// <summary>
            /// 反向索引局部变量名的左值；重复声明直接覆盖，所以不用管；这个结构替代了LocVar，现在不需要startpc了，因为不允许重复声明（傻逼设计）
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
            public int _CurrPc { get => p.codes.Count; }
        }
        #region  处理scope
        BlockStack Blocks { get; } = new BlockStack();
        Block _CurrBlock { get => Blocks.Top; }
        FuncBlock _CurrFB { get => Blocks.FBTop; }
        Proto _CurrP { get => _CurrFB.p; }
        int _FreeRegIndex { get => _CurrFB.freeRegIndex; set => _CurrFB.freeRegIndex = value; }
        int _CurrPc { get => _CurrFB._CurrPc; }
        internal ChunkProto ChunkProto { get => Blocks.ChunkProto; }
        internal List<string> Strs { get => ChunkProto.strs; }
        internal List<double> Ns { get => ChunkProto.ns; }
        Dictionary<double, int> n2NsIndex = new Dictionary<double, int>();
        Dictionary<string, int> s2StrsIndex = new Dictionary<string, int>();
        internal enum NameType
        {
            /// <summary>
            /// Name2RegIndex returns RegInex
            /// </summary>
            Local,
            /// <summary>
            /// Name2RegIndex returns SIndex
            /// </summary>
            Global,
            /// <summary>
            /// Name2RegIndex returns UIndex
            /// </summary>
            Upval
        }
        /// <summary>
        /// local直接返回其reg index，global返回str key 的SIndex，upval返回UIndex
        /// 当然不应该直接emit加载指令，应该交给caller。eg a=1对upval会生成setupval，要你生成getupval当然是错的
        /// name通过scope映射到lvalue（龙书第二章重点），因此还要有反向索引表
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        int Name2RegIndex(string name, out NameType nameType)
        {
            var localFBIndex = Blocks.funcBlockIndexes.Last();
            for (int i = Blocks.blockStack.Count - 1; i > localFBIndex - 1; i--) {
                var a = Blocks.blockStack[i].localName2RegIndex;
                if (a.ContainsKey(name)) {
                    nameType = NameType.Local;
                    return a[name].Item1;
                }
            }
            //现在不要管upval，基于一个简单的假设，不是local就是gloabl，也没有error
            nameType = NameType.Global;
            return AppendS(name);
            /*name is not local to all functions from current function to the chunk, so it is global*/
            /*name is upval?*/
        }

        #endregion
        #region 其他辅助函数
        /// <summary>
        /// 添加新指令
        /// </summary>
        /// <param name="bytecode"></param>
        void Emit(Bytecode bytecode)
        {
            _CurrP.codes.Add(bytecode);
        }
        /// <summary>
        /// 增加新n常量，返回index（可能新分配，可能是复用的）
        /// 这里设计可能是有问题的，我假设C#的Parse能得到互相相等的double，
        /// 如果不行，这个函数再传入一个getText的str作为key；但是这样是没error的，最差也就是所有的都是新常量，没有复用
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
                            _FreeRegIndex--; //pop one oprd
                            Emit(Bytecode.RaRb(Op.Not, _FreeRegIndex, Name2RegIndex(result.Name, out NameType)));
                            return new Ret(_FreeRegIndex++, RetType.Name); //push result
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
                            _FreeRegIndex--;
                            Emit(Bytecode.RaRb(Op.Len, _FreeRegIndex, result.KIndex));
                            return new Ret(_FreeRegIndex++, RetType.Name);
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
                            _FreeRegIndex--;
                            Emit(Bytecode.RaRb(Op.Unm, _FreeRegIndex, 0));
                            return new Ret(_FreeRegIndex++, RetType.Name);
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
                _FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, _FreeRegIndex, false, Name2RegIndex(lhs.Name, out NameType nameType), true, rhs.KIndex));
                return new Ret(_FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == KType && rhs.RetType == RetType.Name) {
                _FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, _FreeRegIndex, true, lhs.KIndex, false, Name2RegIndex(rhs.Name, out NameType nameType)));
                return new Ret(_FreeRegIndex++, RetType.Name);
            } else if (lhs.RetType == RetType.Name && rhs.RetType == RetType.Name) {
                _FreeRegIndex--;
                _FreeRegIndex--;
                Emit(Bytecode.RaRKbRkc(opcode, _FreeRegIndex, false, Name2RegIndex(lhs.Name, out NameType nameType), false, Name2RegIndex(rhs.Name, out NameType nameType1)));
                return new Ret(_FreeRegIndex++, RetType.Name);
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
                int _nilStart = _FreeRegIndex;
                foreach (var item in names) {
                    _CurrBlock.localName2RegIndex[item.GetText()] =
                        Tuple.Create(_FreeRegIndex++, _CurrPc);
                }
                Emit(new Bytecode(Op.LoadNil, _nilStart, _FreeRegIndex - 1));
                return Ret.Void;
            }

            var exps = context.explist().exp();
            // local a,b,c=1 右侧不足，同上
            // local a,b=1,2,3,4 截断

            //先遍历一遍名字，不允许重复声明，这里还要想一想。嵌入循环不好，因为后面其实分类讨论了
            foreach (var item in names) {
                var name = item.GetText();
                if (_CurrBlock.localName2RegIndex.ContainsKey(name))
                    throw new Exception("不允许重复声明局部变量" + name); //嗯，全局也是，学习python
            }
            var tempSymbolTable = new Dictionary<string, Tuple<int, int>>();
            // iterate exps
            for (int i = 0; i < Math.Min(names.Length, exps.Length); i++) {
                var result = Visit(exps[i]);
                switch (result.RetType) {
                    case RetType.Name:
                        _FreeRegIndex--; //pop the result
                        break;
                    case RetType.NIndex:
                        Emit(new Bytecode(Op.LoadN, _FreeRegIndex, result.KIndex));
                        break;
                    case RetType.SIndex:
                        Emit(new Bytecode(Op.LoadS, _FreeRegIndex, result.KIndex));
                        break;
                    case RetType.B:
                        Emit(new Bytecode(Op.LoadBool, _FreeRegIndex, Convert.ToInt32(result.B), 0));//<no frills> p11，要处理pc++，想一想
                        break;
                    case RetType.Nil:
                        Emit(new Bytecode(Op.LoadNil, _FreeRegIndex, _FreeRegIndex, 0));
                        break;
                    default:
                        throw new Exception();
                }
                //详见《2018-08-05 22-15-41.971398.lua》，reg会分配给新local，但是它还没声明（没加入符号表）
                //，这里简单地，先存起来然后loop外加给符号表
                tempSymbolTable[names[i].GetText()] = Tuple.Create(_FreeRegIndex++, _CurrPc);
            }
            int nilStart = _FreeRegIndex;
            for (int i = Math.Min(names.Length, exps.Length); i < names.Length; i++) {
                tempSymbolTable[names[i].GetText()] = Tuple.Create(_FreeRegIndex++, _CurrPc);
            }
            if (names.Length > exps.Length)
                Emit(new Bytecode(Op.LoadNil, nilStart, _FreeRegIndex - 1));
            foreach (var item in tempSymbolTable) {
                _CurrBlock.localName2RegIndex[item.Key] = item.Value;
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
        //funcname: NAME ('.' NAME)* (':' NAME)?; //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name

        //显然也是local最简单（因为name固定就是个id），相当于local f=funcion （）。。。end
        //所以我们要处理prefixexp里的函数部分，提取出一个生成表达式的方法。因为这几个规则要共用

        /// <summary>
        /// 处理函数块，emit closure加载到freereg
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {
            //进出新函数
            Blocks.EnterNewFuncBlock();
            if (context.parlist() != null) { //劣化一点把
                foreach (var item in context.parlist().namelist().NAME()) {
                    _CurrBlock.localName2RegIndex[item.GetText()] =
                     Tuple.Create(_FreeRegIndex++, _CurrPc);
                }
            }
            Visit(context.block());
            Emit(new Bytecode(Op.Return, 0, 1, 0));
            Blocks.ExitFuncBlock();
            //closure指令加载到局部变量
            Emit(new Bytecode(Op.Closure, _FreeRegIndex++, Blocks._LastKProtoIndex)); //还是push和pop一下
            return Ret.Void; //no need，func必须单独声明，类似于f=function()end =》 真香，还是到ret里新增了enum
        }
        public override Ret VisitFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context)
        {
            ////进出新函数
            //Blocks.EnterNewFuncBlock();
            //if (context.funcbody().parlist() != null) { //劣化一点把
            //    foreach (var item in context.funcbody().parlist().namelist().NAME()) {
            //        CurrBlock.localName2RegIndexAndStartPc[item.GetText()] =
            //         Tuple.Create(FreeRegIndex++, CurrPc);
            //    }
            //}
            //Visit(context.funcbody().block());
            //Emit(new Bytecode(Op.Return, 0, 1, 0));
            //Blocks.ExitFuncBlock();
            ////closure指令加载到局部变量
            //Emit(new Bytecode(Op.Closure, FreeRegIndex, Blocks._LastKProtoIndex));
            ////name添加符号表
            return Ret.Void;
        }
        /// <summary>
        /// "local and non local function def" handle funcname only
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public override Ret VisitFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context)
        {
            //这里非常丑。method必须单独处理，而且Visit funcbody也要改，因为要传入this
            if (context.funcname().methodname() != null) {
                var funcbody = context.funcbody();
                //处理名字
                var methodname = context.funcname().methodname().NAME().GetText();
                var names = context.funcname().tableOrFunc().NAME();
                var tableIndex = Name2RegIndex(context.funcname().NAME().GetText(), out NameType nameType); //first name is a table
                if (nameType == NameType.Global) {
                    Emit(new Bytecode(Op.GetGlobal, _FreeRegIndex++, tableIndex));
                    _FreeRegIndex--; //pop table 局部变量直接，所以不需要pop
                }
                for (int i = 0; i < names.Length; i++) {
                    _FreeRegIndex--; //pop result
                    Emit(Bytecode.GetTable(_FreeRegIndex++, tableIndex, Tuple.Create(true, AppendS(names[i].GetText())))); //设计上。默认strk，double才需要loadk
                }
                //进出新函数
                Blocks.EnterNewFuncBlock();

                if (funcbody.parlist() != null) { //劣化一点把
                    foreach (var item in funcbody.parlist().namelist().NAME()) {
                        _CurrBlock.localName2RegIndex[item.GetText()] =
                         Tuple.Create(_FreeRegIndex++, _CurrPc);
                    }
                }
                Visit(funcbody.block());
                Emit(new Bytecode(Op.Return, 0, 1, 0));
                Blocks.ExitFuncBlock();
                //closure指令加载到局部变量
                Emit(new Bytecode(Op.Closure, _FreeRegIndex++, Blocks._LastKProtoIndex)); //还是push和pop一下
                return Ret.Void; //no need，func必须单独声明，类似于f=function()end =》 真香，还是到ret里新增了enum
            }

            Visit(context.funcbody());
            var funcInex = _FreeRegIndex--; //pop func def

            //handle func name
            //funcname: NAME0 ('.' NAMEn-1)* (':' NAMEn)?; 
            //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name
            // 1. Name0 : function f()end, _G[f]=def
            // 2. Name0.Name1.Name2 : function T1.T2.T3.f()end, gettable* to get f, f=def
            // 3. Name0.....:Namen : function T1.T2.obj.f()end, gettale* to get obj, obj[f]=def(obj, ...)
            //修改了语法
            //funcname: NAME tableOrFunc methodname; //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name
            //tableOrFunc: ('.' NAME)*;
            var funcname = context.funcname();
            //这里的逻辑要清晰，其实是有methodname决定前面的意思的
            if (funcname.methodname() == null)
                if (funcname.tableOrFunc() == null)
                    // case 1.
                    Emit(new Bytecode(Op.SetGlobal, _FreeRegIndex++, AppendS(funcname.NAME().GetText())));
                else {
                    // case 2.
                    var names = funcname.tableOrFunc().NAME();
                    var tableIndex = Name2RegIndex(funcname.NAME().GetText(), out NameType nameType); //first name is a table
                    if (nameType == NameType.Global) {
                        Emit(new Bytecode(Op.GetGlobal, _FreeRegIndex++, tableIndex));
                        _FreeRegIndex--; //pop table 局部变量直接，所以不需要pop
                    }
                    for (int i = 0; i < names.Length - 1; i++) {
                        _FreeRegIndex--; //pop result
                        Emit(Bytecode.GetTable(_FreeRegIndex++, tableIndex, Tuple.Create(true, AppendS(names[i].GetText())))); //设计上。默认strk，double才需要loadk
                    }
                }
            return Ret.Void;
        }
        public override Ret VisitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {
            Visit(context.funcbody());
            //name添加符号表
            var name = context.NAME().GetText();
            if (_CurrBlock.localName2RegIndex.ContainsKey(name))
                throw new Exception("不允许重复声明局部变量" + name); //嗯，全局也是，学习python
            _FreeRegIndex--; //pop func
            _CurrBlock.localName2RegIndex[name] = Tuple.Create(_FreeRegIndex++, _CurrPc);
            return Ret.Void;
        }
        public override Ret VisitChunk([NotNull] LuaParser.ChunkContext context)
        {
            //这句之前ctor初始化了一个chunkblock
            VisitChildren(context); //visit之后栈会恢复到chunkblock
            Emit(new Bytecode(Op.Return, 0, 1, 0)); //加入最后一句return
            return Ret.Void;
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

