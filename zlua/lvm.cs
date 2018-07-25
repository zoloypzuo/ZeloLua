using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.ISA;
using zlua.GlobalState;
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
    public class TThread : TObject
    {
        #region fields
        public List<TValue> Stack;
        /// <summary>
        /// callinfo_stack.top().top 
        /// </summary>
        public int top;
        /// <summary>
        /// callinfo_stack.top()._base
        /// </summary>
        public int _base; // "base" is a C# keyword, ...
        public int stackLastFree;
        public CallInfo CurrCallInfo { get => callinfoStack.Peek(); }
        public Stack<CallInfo> callinfoStack;
        const int BasicCISize = 8;
        const int BasicStackSize = 40;
        /// <summary>
        /// consts
        /// </summary>
        public List<TValue> k;
        /// <summary>
        /// _G
        /// </summary>
        public TValue globalsTable;
        /// <summary>
        /// saved pc when call a function; index of instruction array
        /// </summary>
        public int savedpc;
        public List<Bytecode> codes;
        public int nCSharpCalls;
        public GlobalState.GlobalState globalState;
        /// <summary>
        /// "temp place for env", used only in index2adr currently
        /// </summary>
        public TValue env;
        #endregion

        /// <summary>
        /// lua_newstate    
        /// </summary>
        public TThread()
        {
            globalState = new GlobalState.GlobalState() {
                mainThread = this,
                registry = new TValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0))
            };
            globalsTable = new TValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0));
            callinfoStack = new Stack<CallInfo>(BasicCISize);
            callinfoStack.Push(new CallInfo());
            Stack = new List<TValue>();
            for (int i = 0; i < BasicStackSize; i++) {
                Stack.Add(new TValue());
            }
            CurrCallInfo._base = _base = top = 1;
        }
        /// <summary>
        /// luaV_execute
        /// </summary>
        /// <param name="level">1 is the first level</param>
        public void Execute(int level)
        {
            LuaClosure cl;
            List<TValue> k;
            Bytecode instr;
            int pc;
            reentry:
            //Debug.Assert(CurrCallInfo.func.IsLuaFunction);
            pc = savedpc;
            cl = this[CurrCallInfo.funcIndex].Cl as LuaClosure;
            k = cl.p.k;
            while (true) {
                instr = codes[pc++];
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
                                CallBinaryMetamethod(rb, rc, ra, MetamethodTypes.Add);
                            continue;
                        }
                    case Opcodes.Sub:
                        continue;
                    case Opcodes.Mul:
                        continue;
                    case Opcodes.Div:
                        continue;
                    case Opcodes.Mod:
                        continue;
                    case Opcodes.Pow:
                        continue;
                    case Opcodes.Unm:
                        continue;
                    case Opcodes.Not:
                        ra.B = RB(instr).IsFalse; //TODO  /* next assignment may change this value */
                        continue;
                    case Opcodes.Len:
                        continue;
                    case Opcodes.Concat:
                        continue;
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
                            //TODO
                            savedpc = pc;
                            ldo.PreCall(this, _base + instr.A, n_retvals);
                            ++level;
                            goto reentry;
                            continue;
                        }
                    case Opcodes.TailCall:
                        continue;
                    case Opcodes.Return: {
                            int b = instr.B;
                            if (b != 0) top = instr.A + b - 1;
                            savedpc = pc;
                            int i = ldo.PosCall(this, instr.A);
                            if (--level == 0) /* chunk executed, return*/
                                return;
                            else { /*continue the execution*/
                                if (i != 0)
                                    top = CurrCallInfo.top;
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
                    case Opcodes.Closure: { /*用Proto简单new一个LuaClosure，提前执行下面的指令初始化upvals*/
                            Proto p = cl.p.inner_funcs[instr.Bx];
                            LuaClosure ncl = new LuaClosure(cl.env, p.nUpvals, p);
                            // 后面一定跟着一些getUpval或mov指令用来初始化upvals，分情况讨论，把这些指令在这个周期就执行掉
                            for (int j = 0; j < p.nUpvals; j++, pc++) { /*从父函数的upvals直接取upvals*/
                                var next_instr = codes[pc];
                                if (next_instr.Opcode == Opcodes.GetUpVal)
                                    ncl.upvals[j] = cl.upvals[codes[pc].B];
                                else { /*否则得用复杂的方法确定upval的位置*/
                                    Debug.Assert(codes[pc].Opcode == Opcodes.Move);
                                    ncl.upvals[j] = lfunc.FindUpval(this, _base + next_instr.B);
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

        #region get operands from instruction args
        /// <summary>
        /// NO NEED TO IMPLEMENT check opmode of B, C
        /// </summary>
        /// <param name="i"></param>
        /// <returns></returns>
        [DebuggerStepThroughAttribute]
        TValue R(int i) => Stack[_base + i];
        [DebuggerStepThroughAttribute]
        TValue RA(Bytecode i) => Stack[_base + i.A];
        [DebuggerStepThroughAttribute]
        TValue RB(Bytecode i) => Stack[_base + i.B];
        [DebuggerStepThroughAttribute]
        TValue RC(Bytecode i) => Stack[_base + i.C];

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
        /// <param name="index"></param>
        /// <returns></returns>
        public TValue ToNumber(TValue obj, out bool canBeConvertedToNum)
        {
            canBeConvertedToNum = true;
            if (obj.IsNumber) return obj;
            if (obj.IsString) {
                double num = TValue.Str2Num((string)obj, out canBeConvertedToNum);
                if (canBeConvertedToNum)
                    return (TValue)num;
            }
            canBeConvertedToNum = false;
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
        /// <param name="obj"></param>
        /// <returns></returns>
        public bool ToString(TValue obj)
        {
            return false;
        }
        /// <summary>
        /// luaV_concat
        /// </summary>
        /// <param name="total"></param>
        /// <param name="last"></param>
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
        /// <param name="t1"></param>
        /// <param name="o"></param>
        /// <param name=""></param>
        /// <returns></returns>
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
        /// <param name="t"></param>
        /// <param name="key"></param>
        /// <param name="val"></param>
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
        public TValue this[int i]
        {
            get => Stack[i];
            set => Stack[i] = value;
        }
        /// <summary>
        /// Arith; call metamethod
        /// 实现决策】src为什么使用亢余的写法。莫名其妙，我把cast str到num的部分转移到execute里了，这个函数删除，直接使用callTMmeta
        /// </summary>
        //void Arith(TValue ra, TValue rb, TValue rc, MetamethodTypes metamethodType)
        //{

        //}
        /// <summary>
        /// call_binTM
        /// </summary>
        /// <param name="lhs"></param>
        /// <param name="rhs"></param>
        /// <param name="result"></param>
        /// <param name="metamethodType"></param>
        /// <returns></returns>
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
        /// callTMres
        /// </summary>
        /// <param name="result"></param>
        /// <param name="metamethod"></param>
        /// <param name="lhs"></param>
        /// <param name="rhs"></param>
        TValue CallMetamethod(TValue metamethod, TValue lhs, TValue rhs)
        {
            /* push func and 2 args*/
            this[top++].TVal = metamethod;
            this[top++].TVal = lhs;
            this[top++].TVal = rhs;
            ldo.Call(this, top - 3, 1);
            return this[--top]; //TODO call做了什么，result放在哪里
        }
        #endregion

    }
    /// <summary>
    /// protected call
    /// </summary>
    //public class CallS { public TValue func; public int n_retvals; }
    public class CallInfo
    {
        public int funcIndex;
        public int _base; // = func+1
        public int top;
        /// <summary>
        /// saved pc when call function, index of instruction array
        /// </summary>
        public int savedpc;
        public int nRetvals;
    }
}
