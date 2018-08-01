using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.ISA;
using System.Diagnostics;
using zlua.API;
using zlua.CallSystem;
using zlua.FuncAux;
using zlua.Metamethod;
/// <summary>
/// 虚拟机
/// </summary>
namespace zlua.VM
{
    /// <summary>
    /// 相比src，几乎没用，从L里脱离出来的，维护多个L共享的DS；没法internal，详见《internal规则》
    /// </summary>
    public class GlobalState
    {
        public TValue registry = new TValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0));
        public TThread mainThread;
        public TTable[] metaTableForBasicType = new TTable[(int)LuaTypes.Thread + 1];
        public TString[] metaMethodNames = new TString[(int)MetamethodTypes.N];
    }
    public class TThread : TObject
    {
        #region fields
        List<TValue> Stack;
        /// <summary>
        /// lua栈遵循栈约定：top指向第一个可用位置，每次push时 top++ = value；几乎所有文件都要用，因为你用这个来维护栈这个行为
        /// </summary>
        public int topIndex;
        /// <summary>
        /// 当前函数的base：Ido要使用，我希望他是private
        /// </summary>
        public int baseIndex;
        /// <summary>
        /// 标记分配的大小,topIndex永远<stackLastFree
        /// </summary>
        public int StackLastFree { get => Stack.Count; }
        /// <summary>
        /// 当前函数；ido和lvm用的都多，我希望迁移到ido
        /// </summary>
        public Callinfo Ci { get => ciStack.Peek(); }
        public Stack<Callinfo> ciStack; //ido用的多，希望迁移到ido

        /// <summary>
        /// consts
        /// </summary>
        public List<TValue> k;
        /// <summary>
        /// _G
        /// </summary>
        public readonly TValue globalsTable = new TValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0));
        /// <summary>
        /// saved pc when call a function; index of instruction array；因为src用指针的原因，而zlua必须同时使用codes和pc来获取指令
        /// </summary>
        public int savedpc;
        public List<Bytecode> codes;
        public int nCSharpCalls;
        public GlobalState globalState;
        /// <summary>
        /// "temp place for env", 仅被index2adr调用;除此之外，thread通过分支创建时，和父thread共享环境（然而并没有看到引用）
        /// </summary>
        public TValue env;
        short nCcalls;  /* number of nested C calls */
        short baseCcalls;  /* nested C calls when resuming coroutine */
        #endregion

        /// <summary>
        /// lua_newstate    
        /// </summary>
        public TThread()
        {
            globalState = new GlobalState() { mainThread = this };
            const int BasicCiStackSize = 8;
            const int BasicStackSize = 40;
            ciStack = new Stack<Callinfo>(BasicCiStackSize);
            ciStack.Push(new Callinfo());
            Stack = new List<TValue>();
            for (int i = 0; i < BasicStackSize; i++) {
                Stack.Add(new TValue());
            }
            Ci.baseIndex = baseIndex = topIndex = 1;
        }
        /// <summary>
        /// luaV_execute; 执行一个深度为level的lua函数，chunk深度为1；没有level就不知道什么时候结束了（事实上可以，用callinfo栈）
        /// </summary>
        /// <param name="level">1 is the first level</param>
        public void Execute(int level)
        {
            reentry:
            Debug.Assert(this[Ci.funcIndex].IsLuaFunction);
            int pc = savedpc;
            LuaClosure cl = this[Ci.funcIndex].Cl as LuaClosure;
            int baseIndex = this.baseIndex;
            List<TValue> k = cl.p.k;
            while (true) {
                Bytecode instr = codes[pc++];
                Debug.Assert(baseIndex == this.baseIndex && this.baseIndex == Ci.baseIndex);
                Debug.Assert(baseIndex <= topIndex && topIndex < StackLastFree); //这里始终没有。
                TValue ra = RA(instr);
                switch (instr.Opcode) {
                    case Opcodes.Move:
                        ra.TVal = RB(instr);
                        continue;
                    case Opcodes.LoadK:
                        ra.TVal = KBx(instr);
                        continue;
                    case Opcodes.LoadBool:
                        ra.B = Convert.ToBoolean(instr.B);
                        if (Convert.ToBoolean(instr.C)) pc++;
                        continue;
                    case Opcodes.LoadNil: {
                            int a = instr.A;
                            int b = instr.B;
                            do {
                                R(b--).SetNil();
                            } while (b >= a);
                            continue;
                        }
                    case Opcodes.GetUpVal: {
                            int b = instr.B;
                            ra.TVal = cl.upvals[b].val;
                            continue;
                        }
                    case Opcodes.GetGlobal: {
                            TValue rb = KBx(instr);
                            Debug.Assert(rb.IsString);
                            GetTable((TValue)cl.env, rb, ra);
                            continue;
                        }
                    case Opcodes.GetTable:
                        GetTable(RB(instr), RKC(instr), ra);
                        continue;
                    case Opcodes.SetGlobal:
                        Debug.Assert(KBx(instr).IsString);
                        SetTable((TValue)cl.env, KBx(instr), ra);
                        continue;
                    case Opcodes.SetUpval: {
                            Upval upval = cl.upvals[instr.B];
                            upval.val.TVal = ra;
                            continue;
                        }
                    case Opcodes.SetTable:
                        SetTable(ra, RKB(instr), RKC(instr));
                        continue;
                    case Opcodes.NewTable: {
                            int b = instr.B;
                            int c = instr.C;
                            ra.Table = new TTable(c, b);
                            continue;
                        }
                    case Opcodes.Self: {
                            TValue rb = RB(instr);
                            R(instr.A + 1).TVal = rb;
                            GetTable(rb, RKC(instr), ra);
                            continue;
                        }
                    case Opcodes.Add: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = nb + nc;
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Add))
                                throw new ArithmeticException("operands cannot be added");
                            continue;
                        }
                    case Opcodes.Sub: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = nb - nc;
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Sub))
                                throw new ArithmeticException("operands cannot be subtracted");
                            continue;
                        }
                    case Opcodes.Mul: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = nb * nc;
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Mul))
                                throw new ArithmeticException("operands cannot be multiplied");
                            continue;
                        }
                    case Opcodes.Div: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = nb / nc;
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Div))
                                throw new ArithmeticException("operands cannot be divided");
                            continue;
                        }
                    case Opcodes.Mod: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = nb % nc;
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Mod))
                                throw new ArithmeticException("operands cannot be moded");
                            continue;
                        }
                    case Opcodes.Pow: {
                            TValue rb = RKB(instr);
                            TValue rc = RKC(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            double nc = (double)ToNumber(rc, out bool c);
                            if (b && c) ra.N = Math.Pow(nb, nc);
                            else
                                if (!CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Pow))
                                throw new ArithmeticException("operands cannot be powered");
                            continue;
                        }
                    case Opcodes.Unm: {
                            TValue rb = RB(instr);
                            double nb = (double)ToNumber(rb, out bool b);
                            if (b) ra.N = -nb;
                            else
                                if (!CallBinaryMetamethod(rb, rb, ra, MetamethodTypes.Unm))
                                throw new ArithmeticException("operand cannot be unmed");
                            continue;
                        }
                    case Opcodes.Not:
                        ra.B = RB(instr).IsFalse; //TODO  /* next assignment may change this value */
                        continue;
                    case Opcodes.Len: {
                            TValue rb = RB(instr);
                            switch (rb.Type) {
                                case LuaTypes.Table:
                                    ra.N = rb.Table.GetN();
                                    break;
                                case LuaTypes.String:
                                    ra.N = rb.TStr.Len;
                                    break;
                                default:
                                    if (!CallBinaryMetamethod(rb, TValue.NilObject, ra, MetamethodTypes.Len))
                                        throw new ArithmeticException("operand cannot be lened");
                                    break;
                            }
                            continue;
                        }
                    case Opcodes.Concat: {
                            int b = instr.B;
                            int c = instr.C;
                            Concat(c - b + 1, c);
                            RA(instr).TVal = this[this.baseIndex + b];
                            continue;
                        }
                    case Opcodes.Jmp:
                        continue;
                    case Opcodes.Eq:
                        continue;
                    case Opcodes.Lt:
                        continue;
                    case Opcodes.Le:
                        continue;
                    case Opcodes.Test:
                        continue;
                    case Opcodes.Testset:
                        continue;
                    case Opcodes.Call: {
                            int b = instr.B;
                            int n_retvals = instr.C - 1;
                            if (b != 0) topIndex = this.baseIndex + instr.A + b;
                            savedpc = pc;
                            switch (ldo.PreCall(this, this.baseIndex + instr.A, n_retvals)) {
                                case ldo.PCRLUA: {
                                        level++;
                                        goto reentry;
                                    }
                                case ldo.PCRC:
                                    if (n_retvals >= 0)
                                        topIndex = Ci.topIndex;
                                    this.baseIndex = this.baseIndex; //TODO???
                                    continue;
                                default:
                                    return;
                            }
                        }
                    case Opcodes.TailCall:
                        continue;
                    case Opcodes.Return: {
                            int b = instr.B;
                            if (b != 0) topIndex = this.baseIndex + instr.A + b - 1;
                            savedpc = pc;
                            int i = ldo.PosCall(this, instr.A);
                            if (--level == 0) /* chunk executed, return*/
                                return;
                            else { /*continue the execution*/
                                if (i != 0)
                                    topIndex = Ci.topIndex;
                                goto reentry;
                            }
                            continue;
                        }
                    case Opcodes.ForLoop:
                        continue;
                    case Opcodes.ForPrep:
                        continue;
                    case Opcodes.TForLoop:
                        continue;
                    case Opcodes.SetList:
                        continue;
                    case Opcodes.Close:
                        continue;
                    case Opcodes.Closure: { /*用Proto简单new一个LuaClosure，提前执行之后的指令s来初始化upvals*/
                            Proto p = cl.p.inner_funcs[instr.Bx];
                            LuaClosure ncl = new LuaClosure(cl.env, p.nUpvals, p);
                            // 后面一定跟着一些getUpval或mov指令用来初始化upvals，分情况讨论，把这些指令在这个周期就执行掉
                            for (int j = 0; j < p.nUpvals; j++, pc++) { /*从父函数的upvals直接取upvals*/
                                var next_instr = codes[pc];
                                if (next_instr.Opcode == Opcodes.GetUpVal) 
                                    ncl.upvals[j] = cl.upvals[codes[pc].B];
                                else { /*否则得用复杂的方法确定upval的位置*/
                                    Debug.Assert(codes[pc].Opcode == Opcodes.Move);
                                    ncl.upvals[j] = lfunc.FindUpval(this, this.baseIndex + next_instr.B);
                                }
                            }
                            ra.Cl = ncl as Closure;
                            continue;
                        }

                    case Opcodes.VarArg:
                        continue;
                    default:
                        continue;
                }
            }

        }
        /// <summary>
        /// 让栈扩展到`size大小
        /// </summary>
        /// <param name="topIndex"></param>
        internal void Alloc(int size)
        {
            for (int i = Stack.Count; i < size; i++)
                Stack.Add(new TValue());
        }

        #region get operands from instruction args
        /// <summary>
        /// NO NEED TO IMPLEMENT check opmode of B, C
        /// </summary>
        [DebuggerStepThroughAttribute]
        TValue R(int i) => Stack[baseIndex + i];
        [DebuggerStepThroughAttribute]
        TValue RA(Bytecode i) => Stack[baseIndex + i.A];
        [DebuggerStepThroughAttribute]
        TValue RB(Bytecode i) => Stack[baseIndex + i.B];
        [DebuggerStepThroughAttribute]
        TValue RC(Bytecode i) => Stack[baseIndex + i.C];

        [DebuggerStepThroughAttribute]
        TValue RKB(Bytecode i) => Bytecode.IsK(i.B) ? k[Bytecode.IndexK(i.B)] : RB(i);
        [DebuggerStepThroughAttribute]
        TValue RKC(Bytecode i) => Bytecode.IsK(i.C) ? k[Bytecode.IndexK(i.C)] : RC(i);
        [DebuggerStepThroughAttribute]
        TValue KBx(Bytecode i) => k[i.Bx];
        #endregion
        #region other things

        /// <summary>
        /// luaV_tonumber; number直接返回，string如果能parse返回新的转成double的TValue，否则返回null
        /// src的参数n是没有必要的
        /// </summary>
        public TValue ToNumber(TValue obj, out bool convertibleToNum)
        {
            convertibleToNum = true;
            if (obj.IsNumber) return obj;
            if (obj.IsString) {
                double num = TValue.Str2Num((string)obj, out convertibleToNum);
                if (convertibleToNum)
                    return (TValue)num;
            }
            convertibleToNum = false;
            return null;
        }
        /// <summary>
        /// tonumber；返回是否能转成number（number和能转的string），如果是后者，原地修改为number类型
        /// 原来的命名令人困惑，因为他确实是tonumber，有副作用】实现决策】放弃这个函数，没有任何意义，让人困惑。他只是为了短路求值对luaV tonumber包装了
        /// 而且是错的。我确认过了。他的n没有malloc就访问字段。所以彻底放弃，只实现API为目的
        /// </summary>
        //bool TryToNumber(TValue obj) => obj.IsNumber || ToNumber(obj) != null;

        /// <summary>
        /// luaV_tostring
        /// </summary>
        public bool ToString(TValue obj)
        {
            return false;
        }
        /// <summary>
        /// luaV_concat
        /// </summary>
        public void Concat(int total, int last)
        {

        }
        /// <summary>
        /// equalobj
        /// 实现决策】不调用元方法的rawequal作为Equals重载，这个是调用的，单独写一个函数
        /// </summary>
        public bool EqualObj(TValue o1, TValue o2) => (o1.Type == o2.Type) && EqualVal(o1, o2);
        /// <summary>
        /// luaV_equalval
        /// </summary>
        public bool EqualVal(TValue t1, TValue t2)
        {
            Debug.Assert(t1.Type == t2.Type);
            switch (t1.Type) {
                case LuaTypes.Nil: return true;
                case LuaTypes.Number: return (double)t1 == (double)t2;
                case LuaTypes.Boolean: return (bool)t1 == (bool)t2; //为什么cast多余，不应该啊。要么得改成字段访问
                case LuaTypes.Userdata: return false;//TODO 有meta方法
                case LuaTypes.Table: {
                        if ((TTable)t1 == (TTable)t2) return true;
                        return false;//TODO metatable compare
                    }
                default:
                    return (TObject)t1 == (TObject)t2;
                    //TODO metatable compare???
            }
        }
        /// <summary>
        /// luaV_gettable
        /// </summary>
        public void GetTable(TValue t, TValue key, TValue val)
        {
            //TODO, 要无限查元表。
        }
        public void SetTable(TValue t, TValue key, TValue val)
        {

        }

        public bool LessThan(TValue lhs, TValue rhs)
        {
            if (lhs.Type != rhs.Type) throw new Exception();
            if (lhs.IsNumber) return (double)lhs < (double)rhs;
            if (lhs.IsString) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
        }
       
        /// <summary>
        /// indexer是只读的，因为直接修改栈上变量是错误的行为。（改了的瞬间报出两个error）
        /// </summary>
        /// <param name="i"></param>
        /// <returns></returns>
        public TValue this[int i]
        {
            get => Stack[i];
        }
        /// <summary>
        /// Arith; call metamethod
        /// 实现决策】src为什么使用亢余的写法。莫名其妙，我把cast str到num的部分转移到execute里了，这个函数删除，直接使用callTMmeta
        /// </summary>
        //void Arith(TValue ra, TValue rb, TValue rc, MetamethodTypes metamethodType)
        //{

        //}
        /// <summary>
        /// call_binTM; result = __add(lhs, rhs); __add从lhs和rhs的元表查找出，如果都没找到返回false
        /// </summary>
        bool CallBinaryMetamethod(TValue lhs, TValue rhs, TValue result, MetamethodTypes metamethodType)
        {
            result = null;
            TValue metamethod = ltm.GetMetamethod(this, lhs, metamethodType);
            if (metamethod.IsNil)
                metamethod = ltm.GetMetamethod(this, rhs, metamethodType);
            if (metamethod.IsNil)
                return false;
            result.TVal = CallMetamethod(metamethod, lhs, rhs);
            return true;
        }
        /// <summary>
        /// callTMres; `metamethod(lhs, rhs)，使用lua通用调用协议，可以去Ido.Call的文档看；调用后top恢复到原处，就像没有调用过一样
        /// </summary>
        TValue CallMetamethod(TValue metamethod, TValue lhs, TValue rhs)
        {
            /* push func and 2 args*/
            this[topIndex++].TVal = metamethod;
            this[topIndex++].TVal = lhs;
            this[topIndex++].TVal = rhs;
            ldo.Call(this, topIndex - 3, 1);
            return this[--topIndex]; //TODO call做了什么，result放在哪里
        }
        #endregion

    }

    /// <summary>
    /// 栈帧信息，或者说是一次调用的信息
    /// </summary>
    public class Callinfo
    {
        public int funcIndex;
        public int baseIndex; // = func+1
        public int topIndex;
        /// <summary>
        /// saved pc when call function, index of instruction array
        /// </summary>
        public int savedpc;
        public int nRetvals; //期望的返回值个数
        int nTailCalls;/* number of tail calls lost under this entry ???*/
    }

}
