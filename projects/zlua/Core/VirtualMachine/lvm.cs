// 虚拟机

using System;
using System.Collections.Generic;
using System.Diagnostics;

using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.MetaMethod;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    internal class GlobalState
    {
        public LuaValue registry = new LuaValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0));

        //internal TThread mainThread;
        internal TTable[] metaTableForBasicType = new TTable[(int)LuaTypes.Thread + 1];

        internal TString[] metaMethodNames = new TString[(int)MMType.N];
    }

    // lua_State
    //
    // * partial是分给lapi
    public partial class LuaState : LuaReference
    {
        #region 私有访问器

        private List<LuaValue> Stack { get { return stack.slots; } }

        /// top指向第一个可用位置，每次push时 top++ = value
        /// 几乎所有文件都要用，因为你用这个来维护栈这个行为
        private int top {
            get { return stack.top; }
            set { stack.top = value; }
        }

        /// 当前函数栈帧的base
        /// Ido要使用，我希望他是private
        /// 是相对于栈底的偏移，所有函数内索引局部变量以这个为基准
        private int @base {
            get { return ci.@base; }
            set { /*CallInfo.BaseIndex = value;*/ }
        }

        /// 标记分配的大小,topIndex永远小于stackLastFree
        private int StackLastFree { get { return Stack.Count; } }

        /// 当前函数
        private CallInfo ci { get { return CallInfoStack.Peek(); } }

        #endregion 私有访问器

        #region 私有属性

        private Stack<CallInfo> CallInfoStack { get; }

        /// _G
        public LuaValue GlobalsTable { get; } = new LuaValue(new TTable(sizeHashTablePart: 2, sizeArrayPart: 0));

        /// saved pc when call a function
        /// index of instruction array；因为src用指针的原因，而zlua必须同时使用codes和pc来获取指令
        internal int pc;

        private Bytecode[] codes { get; set; }
        private int NumCSharpCalls { get; set; }
        internal /*static readonly*/ GlobalState globalState = new GlobalState(); //注册表是一个L一个吗？

        #endregion 私有属性

        /// <summary>
        /// lua_newstate
        /// </summary>
        public LuaState()
        {
            const int BasicCiStackSize = 8;
            const int BasicStackSize = 40;
            CallInfoStack = new Stack<CallInfo>(BasicCiStackSize);
            // 基本的CallInfo，在chunk之前
            // 因为调用函数之前要有一个CallInfo保存savedpc
            // 因此构造LuaState时构造一个基本的CallInfo
            CallInfoStack.Push(new CallInfo());
            stack = new LuaStack(20);
            for (int i = 0; i < BasicStackSize; i++) {
                Stack.Add(new LuaValue());
            }
            top = 0;

            //注册assert，这样可以测试了
            //void Assert(LuaState L)
            //{
            //    Debug.Assert(L[L.topIndex - 1].B);
            //}
            //lua.Register(this, Assert, "assert");


            // TODO OpenLibs()
        }

        // 缓存cl
        //
        // 因为要写辅助方法，所以从局部变量变为字段
        private LuaClosure cl;

        // 缓存k
        //
        // 因为要写辅助方法，所以从局部变量变为字段
        private LuaValue[] k;

        #region 从指令取出参数的辅助方法
        private LuaValue R(int i)
        {
            return Stack[@base + i];
        }

        // R(A)
        private LuaValue RA(Bytecode i)
        {
            return Stack[@base + (int)i.A];
        }

        // R(B)
        private LuaValue RB(Bytecode i)
        {
            return Stack[@base + (int)i.B];
        }

        // R(C)
        private LuaValue RC(Bytecode i)
        {
            return Stack[@base + (int)i.C];
        }

        // RK(C)
        private LuaValue RKC(Bytecode instr)
        {
            int C = (int)instr.C;
            var rc = Bytecode.IsK(C) ?
                k[Bytecode.IndexK(C)] :
                Stack[@base + C];
            return rc;
        }

        // UpValue[A]
        private LuaValue UpValueA(Bytecode instr)
        {
            var upa = cl.upvals[(int)instr.A].val;
            return upa;
        }

        // UpValue[B]
        private LuaValue UpValueB(Bytecode instr)
        {
            var upb = cl.upvals[(int)instr.B].val;
            return upb;
        }

        #endregion 从指令取出参数的辅助方法

        // luaV_execute
        // 执行一个深度为level的lua函数，chunk深度为1
        // 没有level就不知道什么时候结束了（事实上可以，用callinfo栈）
        private void Execute(int nexeccalls)
        {
            // clua5.3缓存了ci
            // clua5.1缓存了base和pc
            // 我们都不缓存，因为这造成了代码混乱
            //CallInfo ci = this.ci;
            //int @base;
            //int pc;
            reentry:
            Debug.Assert(Stack[ci.funcIndex].IsLuaFunction);
            // 缓存cl
            cl = Stack[ci.funcIndex].Cl as LuaClosure;
            // 缓存k
            k = cl.p.Constants;
            // 缓存savedpc

            while (true) {
                Bytecode instr = codes[pc++];
                Debug.Assert(@base == ci.@base);
                Debug.Assert(@base <= top && top < StackLastFree); //这里始终没有。
                LuaValue ra = RA(instr);
                switch (instr.Opcode) {
                    case Opcode.OP_MOVE: {
                            ra.TValue = RB(instr);
                            continue;
                        }
                    // A Bx	R(A) := Kst(Bx)
                    // 从常量表取出常量写入R(A)
                    case Opcode.OP_LOADK: {
                            LuaValue rb = k[instr.Bx];
                            ra.TValue = rb;
                            continue;
                        }
                    // A B C	R(A) := UpValue[B][RK(C)]
                    // UpValue[B]是一个表，RK(C)取得常量，再查表，将结果写入R(A)
                    case Opcode.OP_GETTABUP: {
                            var upval = UpValueA(instr);
                            var rkc = RKC(instr);
                            ra.TValue = upval.Table.Get(rkc);
                            continue;
                        }
                    // A B C	R(A), ... ,R(A+C-2) := R(A)(R(A+1), ... ,R(A+B-1))
                    // A指定被调用函数对象的寄存器索引
                    // A后面紧跟实参列表，实参个数为B
                    // 返回值个数为C
                    // call指令对应于lua脚本中的函数调用
                    // 执行完该指令后，被调用函数和它的栈帧被清空，返回值被留在栈上
                    // 《自己动手实现Lua》p154
                    case Opcode.OP_CALL: {
                            int b = (int)instr.B;
                            int nresults = (int)instr.C - 1;
                            int func = @base + (int)instr.A;
                            if (b != 0) top = func + b;  /* else previous instruction set top */
                            switch (PreCall(func, nresults)) {
                                case PCRLUA: {
                                        nexeccalls++;
                                        goto reentry;  /* restart luaV_execute over new Lua function */
                                    }
                                case PCRC:
                                    if (nresults >= 0)
                                        top = ci.top;
                                    continue;
                                default:
                                    return;
                            }
                        }
                    // A B	return R(A), ... ,R(A+B-2)	(see note)
                    case Opcode.OP_RETURN: {
                            int b = (int)instr.B;
                            int a = (int)instr.A;
                            if (b != 0) top = @base + a + b - 1;
                            PosCall(a);
                            if (--nexeccalls == 0) /* chunk executed, return*/
                                return;
                            else { /*continue the execution*/
                                //if (i != 0)
                                //    topIndex = Ci.topIndex;
                                goto reentry;
                            }
                        }
                    // A B C	R(A+1) := R(B); R(A) := R(B)[RK(C)]
                    // self指令为lua提供了oop范式
                    // 方法调用obj:f()会生成一条self指令
                    // self指令的执行分为两步：
                    // * 从obj表中查找"f"键的值作为被调用方法
                    // * 将obj设为f的第一个实参
                    // self指令后会有一条move指令，再是一条call指令
                    case Opcode.OP_SELF: {
                            // 将obj设为f的第一个实参
                            LuaValue rb = RB(instr);
                            R((int)instr.A + 1).TValue = rb;
                            // 从obj表中查找"f"键的值作为被调用方法
                            GetTable(rb, RKC(instr), ra);
                            continue;
                        }
                    // A Bx	R(A) := closure(KPROTO[Bx])
                    // closure指令的执行分为以下两步：
                    // * 从内嵌Proto列表中取出Proto实例，来构造Closure实例ncl
                    // * 提前执行后面的move指令或get upval指令来初始化ncl的upvals
                    case Opcode.OP_CLOSURE: {
                            /*用Proto简单new一个LuaClosure，提前执行之后的指令s来初始化upvals*/
                            Proto p = cl.p.Protos[instr.Bx];
                            int nup = p.nUpvals;
                            LuaClosure ncl = new LuaClosure(cl.env, nup, p);
                            // 后面一定跟着一些getUpval或mov指令用来初始化upvals，分情况讨论，把这些指令在这个周期就执行掉
                            for (int j = 0; j < nup; j++, pc++) {
                                Bytecode next_instr = codes[pc];
                                // 从父Proto的upvals直接取upvals
                                if (next_instr.Opcode == Opcode.OP_GETUPVAL)
                                    ncl.upvals[j] = cl.upvals[(int)codes[pc].B];
                                // 否则得用复杂的方法确定upval的位置
                                else {
                                    Debug.Assert(codes[pc].Opcode == Opcode.OP_MOVE);
                                    // TODO
                                    //ncl.upvals[j] = lfunc.FindUpval(this, this.baseIndex + next_instr.B);
                                }
                            }
                            ra.Cl = ncl;
                            continue;
                        }
                    // A B	R(A), R(A+1), ..., R(A+B-2) = vararg
                    // 将vararg加载到连续多个寄存器中
                    // 开始索引为A，个数为B
                    // vararg指令很像call指令
                    case Opcode.OP_VARARG: {
                            int a = (int)instr.A;
                            int b = (int)instr.B - 1;
                            CallInfo ci = this.ci;
                            int n = ci.@base - ci.funcIndex - cl.p.numparams;
                            if (b == LUA_MULTRET) {
                                stack.check(n);
                                ra = RA(instr);  /* previous call may change the stack */
                                b = n;
                                top = a + n;
                            }
                            for (int j = 0; j < b; j++) {
                                if (j < n) {
                                    Stack[a + j].TValue = Stack[ci.@base - n + j];
                                } else {
                                    Stack[a + j].SetNil();
                                }
                            }
                            continue;
                        }
                    // A B C	return R(A)(R(A+1), ... ,R(A+B-1))
                    // 形如return f()的返回语句被优化成尾递归
                    case Opcode.OP_TAILCALL: {
                            // TODO clua太多了，书上没讲
                            continue;
                        }
                    // A B	R(A) := UpValue[B]
                    case Opcode.OP_GETUPVAL: {
                            RA(instr).TValue = UpValueB(instr);
                            continue;
                        }

                    //case Opcode.LoadBool:
                    //    ra.B = Convert.ToBoolean(instr.B);
                    //    if (Convert.ToBoolean(instr.C)) pc++;
                    //    continue;
                    //case Opcode.LoadNil: {
                    //        int a = instr.A;
                    //        int b = instr.B;
                    //        do {
                    //            R(b--).SetNil();
                    //        } while (b >= a);
                    //        continue;
                    //    }
                    //case Opcode.OP_GETUPVAL: {
                    //        int b = instr.B;
                    //        ra.TVal = cl.upvals[b].val;
                    //        continue;
                    //    }
                    //case Opcode.GetGlobal: {
                    //        LuaValue rb = KBx(instr);
                    //        Debug.Assert(rb.IsString);
                    //        GetTable((LuaValue)cl.env, rb, ra);
                    //        continue;
                    //    }
                    //case Opcode.OP_GETTABLE:
                    //    throw new NotImplementedException();
                    //    //GetTable(RB(instr), RKC(instr), ra);
                    //    continue;
                    //case Opcode.SetGlobal:
                    //    Debug.Assert(KBx(instr).IsString);
                    //    SetTable((LuaValue)cl.env, KBx(instr), ra);
                    //    continue;
                    //case Opcode.OP_SETUPVAL: {
                    //        Upvalue upval = cl.upvals[instr.B];
                    //        upval.val.TVal = ra;
                    //        continue;
                    //    }
                    case Opcode.OP_SETTABLE:
                        throw new NotImplementedException();
                        //SetTable(ra, RKB(instr), RKC(instr));
                        continue;
                    case Opcode.OP_NEWTABLE: {
                            //int b = instr.B;
                            //int c = instr.C;
                            //ra.Table = new TTable(c, b);
                            continue;
                        }

                    case Opcode.OP_ADD: {
                            Arith(instr, (a, b) => a + b, MMType.Add);
                            continue;
                        }
                    case Opcode.OP_SUB: {
                            Arith(instr, (a, b) => a - b, MMType.Sub);
                            continue;
                        }
                    case Opcode.OP_MUL: {
                            Arith(instr, (a, b) => a * b, MMType.Mul);
                            continue;
                        }
                    case Opcode.OP_DIV: {
                            Arith(instr, (a, b) => a / b, MMType.Div);
                            continue;
                        }
                    case Opcode.OP_MOD: {
                            Arith(instr, (a, b) => a % b, MMType.Mod);
                            continue;
                        }
                    case Opcode.OP_POW: {
                            Arith(instr, Math.Pow, MMType.Pow);
                            continue;
                        }
                    case Opcode.OP_UNM: {
                            //LuaValue rb = RB(instr);
                            ////double nb = (double)ToNumber(rb, out bool b);
                            //if (b) ra.N = -nb;
                            //else
                            //    if (!CallBinaryMetamethod(rb, rb, ra, MMType.Unm))
                            //    throw new ArithmeticException("operand cannot be unmed");
                            continue;
                        }
                    case Opcode.OP_NOT:
                        //ra.B = RB(instr).IsFalse; //TODO  /* next assignment may change this value */
                        continue;
                    case Opcode.OP_LEN: {
                            //LuaValue rb = RB(instr);
                            //switch (rb.Type) {
                            //    case LuaType.Table:
                            //        ra.N = rb.Table.GetN();
                            //        break;

                            //    case LuaType.String:
                            //        ra.N = rb.TStr.Len;
                            //        break;

                            //    default:
                            //        if (!CallBinaryMetamethod(rb, LuaValue.NilObject, ra, MMType.Len))
                            //            throw new ArithmeticException("operand cannot be lened");
                            //        break;
                            //}
                            continue;
                        }
                    case Opcode.OP_CONCAT: { // RA = String.Join(RB~RC)
                            //int b = instr.B;
                            //int c = instr.C;
                            //Concat(c - b + 1, c);
                            //RA(instr).TVal = this[this.BaseIndex + b];
                            continue;
                        }



                    default:
                        continue;
                }
            }
        }

        private void Arith(Bytecode instr, Func<double, double, double> func, MMType mtType)
        {
            //LuaValue ra = RA(instr); //重算一遍
            //LuaValue rb = RNB(instr);
            //LuaValue rc = RNC(instr);
            //double nb = (double)ToNumber(rb, out bool b); //Tonumber把str转换成double，我分离两种k之后，这里其实没用了
            //double nc = (double)ToNumber(rc, out bool c); //我也不希望可以随便把str转换成double
            //if (b && c) ra.N = func(nb, nc);
            //else if (!CallBinaryMetamethod(rb, rc, ra, mtType))
            //    throw new OprdTypeException(instr.Opcode);
            //else
            //    throw new GodDamnException();
        }

        /// <summary>
        /// 让栈扩展到`size大小
        /// </summary>
        /// <param name="topIndex"></param>
        internal void Alloc(int size)
        {
            for (int i = Stack.Count; i < size; i++)
                Stack.Add(new LuaValue());
        }

        #region other things

        // luaV_tonumber
        // number直接返回，string如果能parse返回新的转成double的TValue，否则返回null
        // src的参数n是没有必要的
        //public /*luaValue*/LuaNumber ToNumber(LuaValue obj, out bool convertibleToNum)
        //{
        //    // 可以看到混乱，这件事不难，只是规格不清楚

        //    //convertibleToNum = true;
        //    //switch (obj.Type) {
        //    //    case LuaType.Number:
        //    //        return obj.N;
        //    //    case LuaType.Integer:
        //    //        return new LuaNumber { Value = obj.I.Value };
        //    //    case LuaType.String:
        //    //        //return Double.
        //    //    default:
        //    //        return null;
        //    //}
        //    //if (obj.IsNumber) {
        //    //    return obj.n;
        //    //} else if (obj.IsString) {
        //    //    double num = luaValue.Str2Num((string)obj, out convertibleToNum);
        //    //    if (convertibleToNum)
        //    //        return (luaValue)num;
        //    //}
        //    //convertibleToNum = false;
        //    //return null;
        //}

        /// <summary>
        /// tonumber；返回是否能转成number（number和能转的string），如果是后者，原地修改为number类型
        /// 原来的命名令人困惑，因为他确实是tonumber，有副作用】实现决策】放弃这个函数，没有任何意义，让人困惑。他只是为了短路求值对luaV tonumber包装了
        /// 而且是错的。我确认过了。他的n没有malloc就访问字段。所以彻底放弃，只实现API为目的
        /// </summary>
        //bool TryToNumber(TValue obj) => obj.IsNumber || ToNumber(obj) != null;

        /// <summary>
        /// luaV_tostring
        /// </summary>
        public bool ToString(LuaValue obj)
        {
            return false;
        }

        /// <summary>
        /// luaV_concat, RA = String.Join(RB~RC)
        /// </summary>
        public void Concat(int total, int last)
        {
        }

        /// <summary>
        /// equalobj
        /// 实现决策】不调用元方法的rawequal作为Equals重载，这个是调用的，单独写一个函数
        /// </summary>
        public bool EqualObj(LuaValue o1, LuaValue o2) => (o1.Type == o2.Type) && EqualVal(o1, o2);

        /// <summary>
        /// luaV_equalval
        /// </summary>
        public bool EqualVal(LuaValue t1, LuaValue t2)
        {
            Debug.Assert(t1.Type == t2.Type);
            switch (t1.Type) {
                case LuaTypes.Nil: return true;
                case LuaTypes.Number: return t1.N == t2.N;
                case LuaTypes.Boolean: return t1.B == t2.B; //为什么cast多余，不应该啊。要么得改成字段访问
                case LuaTypes.Userdata: return false;//TODO 有meta方法
                case LuaTypes.Table: {
                        if (t1.Table == t2.Table)
                            return true;
                        return false;//TODO metatable compare
                    }
                default:
                    return t1.ReferenceValue == t2.ReferenceValue;
                    //TODO metatable compare???
            }
        }

        /// <summary>
        /// luaV_gettable
        /// </summary>
        public void GetTable(LuaValue t, LuaValue key, LuaValue val)
        {
            //TODO, 要无限查元表。
        }

        public void SetTable(LuaValue t, LuaValue key, LuaValue val)
        {
        }

        public bool LessThan(LuaValue lhs, LuaValue rhs)
        {
            if (lhs.Type != rhs.Type) throw new Exception();
            if (lhs.IsNumber) return lhs.N < rhs.N;
            if (lhs.IsString) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
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
        private bool CallBinaryMetamethod(LuaValue lhs, LuaValue rhs, LuaValue result, MMType metamethodType)
        {
            result = null;
            LuaValue metamethod = LTm.GetMetamethod(this, lhs, metamethodType);
            if (metamethod.IsNil)
                metamethod = LTm.GetMetamethod(this, rhs, metamethodType);
            if (metamethod.IsNil)
                return false;
            result.TValue = CallMetamethod(metamethod, lhs, rhs);
            return true;
        }

        /// <summary>
        /// callTMres
        /// `metamethod(lhs, rhs)，使用lua通用调用协议，可以去Ido.Call的文档看；调用后top恢复到原处，就像没有调用过一样
        /// </summary>
        private LuaValue CallMetamethod(LuaValue metamethod, LuaValue lhs, LuaValue rhs)
        {
            /* push func and 2 args*/
            Stack[top++].TValue = metamethod;
            Stack[top++].TValue = lhs;
            Stack[top++].TValue = rhs;
            Call(top - 3);
            return Stack[--top]; //TODO call做了什么，result放在哪里
        }

        #endregion other things

        private LuaStack stack;
    }

    /// 栈帧信息，或者说是一次调用的信息
    internal class CallInfo
    {
        public int funcIndex;

        public int @base {
            get {
                return funcIndex + 1;
            }
        }

        public int top;

        /// saved pc when call function, index of instruction array
        /// 调用别的函数时保存LuaState的savedpc
        public int savedpc;
    }

    // lua栈
    //
    // * 注意还是要手工扩容的
    //   用数组是不行的，用list后还得手工扩容，扩容是添加新的luaValue实例
    // * 栈索引参见p54
    internal class LuaStack
    {
        public List<LuaValue> slots;
        public int top;

        public LuaStack(int size)
        {
            slots = new List<LuaValue>(size);
            for (int i = 0; i < size; i++) {
                slots.Add(new LuaValue());
            }
            top = 0;
        }

        // 检查栈的空闲空间是否还可以容纳（推入）至少n个值，如若不然，扩容
        public void check(int n)
        {
            int free = slots.Count - top;
            for (int i = free; i < n; i++) {
                slots.Add(new LuaValue());
            }
        }

        // 压栈，溢出时抛出异常
        public void push(LuaValue val)
        {
            if (top == slots.Count) {
                throw new Exception("stack overflow");
            } else {
                slots[top] = val;
                top++;
            }
        }

        // 弹栈，若栈为空，抛出异常
        public LuaValue pop()
        {
            if (top < 1) {
                throw new Exception("stack underflow");
            } else {
                top--;
                var val = slots[top];
                slots[top] = new LuaValue();
                return val;
            }
        }

        // 转换成绝对索引，不考虑索引是否有效
        public int absIndex(int idx)
        {
            if (idx >= 0) {
                return idx;
            } else {
                return idx + top + 1;
            }
        }

        // 索引有效
        public bool isValid(int idx)
        {
            var absIdx = absIndex(idx);
            return absIdx > 0 && absIdx <= top;
        }

        // 取值，索引无效返回nil
        public LuaValue get(int idx)
        {
            var absIdx = absIndex(idx);
            if (absIdx > 0 && absIdx <= top) {
                return slots[absIdx - 1];
            } else {
                return new LuaValue();
            }
        }

        // 写值，索引无效则抛出异常
        public void set(int idx, LuaValue val)
        {
            var absIdx = absIndex(idx);
            if (absIdx > 0 && absIdx <= top) {
                // 比较下面两种写法
                // 作者用go object实现lua object
                // 而这里是拷贝语义，我必须拷贝而不是
                // set会在类似于lua中的a=b赋值时发生，这里当然是拷贝，两个不是一个对象
                // a=b时，如果b是引用类型，那么我调用a=1时，不影响b，所以一定是新的luaValue，拷贝而已
                // python对a=b赋值后a is b，这是怎么回事。。如果copy，是两个luaValue，id应该不同
                // 所以这个id应该是标识luaValue的引用部分的
                // 然而b=1，a=b之后a is b，所以我就想不通
                // 不管，拷贝一定是对的
                //slots[absIdx - 1] = val;
                slots[absIdx - 1].TValue = val;
            } else {
                throw new Exception("invalid index");
            }
        }

        internal void reverse(int from, int to)
        {
            for (; from < to; from++, to--) {
                // swap
                var t = slots[from];
                slots[from] = slots[to];
                slots[to] = slots[from];
            }
        }
    }
}