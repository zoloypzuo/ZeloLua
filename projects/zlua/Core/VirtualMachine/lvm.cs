// 虚拟机

using System;
using System.Collections.Generic;
using System.Diagnostics;

using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    internal class GlobalState
    {
        public TValue registry = new TValue(new Table(sizeHashTablePart: 2, sizeArrayPart: 0));

        //internal TThread mainThread;
        internal Table[] metaTableForBasicType = new Table[(int)LuaType.LUA_TTHREAD + 1];

        internal TString[] metaMethodNames = new TString[(int)TMS.TM_N];
    }

    // lua_State
    //
    // * partial是分给lapi
    public partial class lua_State : LuaReference
    {
        #region 私有访问器

        private List<TValue> Stack { get { return stack.slots; } }

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
        public TValue GlobalsTable { get; } = new TValue(new Table(sizeHashTablePart: 2, sizeArrayPart: 0));

        /// saved pc when call a function
        /// index of instruction array；因为src用指针的原因，而zlua必须同时使用codes和pc来获取指令
        internal int pc;

        private Bytecode[] codes { get; set; }
        private int NumCSharpCalls { get; set; }
        internal /*static readonly*/ GlobalState globalState = new GlobalState(); //注册表是一个L一个吗？

        #endregion 私有属性

        /// lua_newstate
        public lua_State()
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
                Stack.Add(new TValue());
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
        private TValue[] k;

        #region 从指令取出参数的辅助方法

        private TValue R(int i)
        {
            return Stack[@base + i];
        }

        // R(A)
        private TValue RA(Bytecode i)
        {
            return Stack[@base + (int)i.A];
        }

        // R(B)
        private TValue RB(Bytecode i)
        {
            return Stack[@base + (int)i.B];
        }

        // R(C)
        private TValue RC(Bytecode i)
        {
            return Stack[@base + (int)i.C];
        }

        // RK(B)
        private TValue RKB(Bytecode i)
        {
            int B = (int)i.B;
            var rb = Bytecode.IsK(B) ?
                k[Bytecode.IndexK(B)] :
                Stack[@base + B];
            return rb;
        }

        // RK(C)
        private TValue RKC(Bytecode instr)
        {
            int C = (int)instr.C;
            var rc = Bytecode.IsK(C) ?
                k[Bytecode.IndexK(C)] :
                Stack[@base + C];
            return rc;
        }

        // UpValue[A]
        private TValue UpValueA(Bytecode instr)
        {
            var upa = cl.upvals[(int)instr.A].v;
            return upa;
        }

        // UpValue[B]
        private TValue UpValueB(Bytecode instr)
        {
            var upb = cl.upvals[(int)instr.B].v;
            return upb;
        }

        private TValue KBx(Bytecode i)
        {
            Debug.Assert(BytecodeTool.GetOpConstraint(i.Opcode).ArgBMode == OperandMode.OpArgK);
            return k[i.Bx];
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
                Bytecode i = codes[pc++];
                Debug.Assert(@base == ci.@base);
                Debug.Assert(@base <= top && top < StackLastFree); //这里始终没有。
                TValue ra = RA(i);
                switch (i.Opcode) {

                    #region 赋值类指令 数据传输指令

                    // A B R(A) := R(B)
                    case Opcode.OP_MOVE: {
                            ra.Value = RB(i);
                            continue;
                        }
                    // A Bx R(A) := Kst(Bx)
                    // 从常量表取出常量写入R(A)
                    case Opcode.OP_LOADK: {
                            ra.Value = KBx(i);
                            continue;
                        }
                    // A B C R(A) := (Bool)B; if (C) pc++
                    case Opcode.OP_LOADBOOL: {
                            ra.B = i.B != 0;
                            continue;
                        }
                    // A B R(A) := ... := R(B) := nil
                    case Opcode.OP_LOADNIL: {
                            int raIndex = (int)i.A;
                            int rbIndex = (int)i.B;
                            do {
                                Stack[rbIndex--].SetNil();
                            } while (rbIndex >= raIndex);
                            continue;
                        }
                    // A B R(A) := UpValue[B]
                    case Opcode.OP_GETUPVAL: {
                            ra.Value = UpValueB(i);
                            continue;
                        }
                    // A Bx R(A) := Gbl[Kst(Bx)]
                    case Opcode.OP_GETGLOBAL: {
                            TValue g = new TValue(cl.env);
                            TValue rb = KBx(i);
                            Debug.Assert(rb.IsString);
                            GetTable(g, rb, ra);
                            continue;
                        }
                    // A B C R(A) := R(B)[RK(C)]
                    case Opcode.OP_GETTABLE: {
                            GetTable(RB(i), RKC(i), ra);
                            continue;
                        }
                    // A Bx Gbl[Kst(Bx)] := R(A)
                    case Opcode.OP_SETGLOBAL: {
                            TValue g = new TValue(cl.env);
                            Debug.Assert(KBx(i).IsString);
                            SetTable(g, KBx(i), ra);
                            continue;
                        }
                    // A B UpValue[B] := R(A)
                    case Opcode.OP_SETUPVAL: {
                            UpVal uv = cl.upvals[(int)i.B];
                            uv.v.Value = ra;
                            continue;
                        }
                    // A B C R(A)[RK(B)] := RK(C)
                    case Opcode.OP_SETTABLE: {
                            SetTable(ra, RKB(i), RKC(i));
                            continue;
                        }

                    // A B C R(A) := {} (size = B,C)
                    case Opcode.OP_NEWTABLE: {
                            int b = (int)i.B;
                            int c = (int)i.C;
                            ra.Table = new Table(b, c);
                            //TODO
                            //ra.Table= luaH_new(L, luaO_fb2int(b), luaO_fb2int(c)));
                            continue;
                        }
                    // A B C R(A+1) := R(B); R(A) := R(B)[RK(C)]
                    // self指令为lua提供了oop范式
                    // 方法调用obj:f()会生成一条self指令
                    // self指令的执行分为两步：
                    // * 从obj表中查找"f"键的值作为被调用方法
                    // * 将obj设为f的第一个实参
                    // self指令后会有一条move指令，再是一条call指令
                    case Opcode.OP_SELF: {
                            // 将obj设为f的第一个实参
                            TValue rb = RB(i);
                            R((int)i.A + 1).Value = rb;
                            // 从obj表中查找"f"键的值作为被调用方法
                            GetTable(rb, RKC(i), ra);
                            continue;
                        }

                    #endregion 赋值类指令 数据传输指令

                    #region 算术运算符 数值计算类指令

                    // A B C R(A) := RK(B) + RK(C)
                    case Opcode.OP_ADD: {
                            //TODO
                            //arith_op(luai_numadd, TM_ADD);

                            Arith(i, (a, b) => a + b, (a, b) => a + b, TMS.TM_ADD);
                            continue;
                        }
                    // A B C R(A) := RK(B) - RK(C)
                    case Opcode.OP_SUB: {
                            Arith(i, (a, b) => a - b, (a, b) => a - b, TMS.TM_SUB);
                            continue;
                        }
                    // A B C R(A) := RK(B) * RK(C)
                    case Opcode.OP_MUL: {
                            Arith(i, (a, b) => a * b, (a, b) => a * b, TMS.TM_MUL);
                            continue;
                        }
                    // A B C R(A) := RK(B) / RK(C)
                    case Opcode.OP_DIV: {
                            Arith(i, (lua_Number a, lua_Number b) => a / b, TMS.TM_DIV);
                            continue;
                        }
                    // A B C R(A) := RK(B) % RK(C)
                    case Opcode.OP_MOD: {
                            Arith(i, IMod, FMod, TMS.TM_MOD);
                            continue;
                        }
                    // A B C R(A) := RK(B) ^ RK(C)
                    case Opcode.OP_POW: {
                            Arith(i, Pow, TMS.TM_POW);
                            continue;
                        }

                    // A B R(A) := -R(B)
                    case Opcode.OP_UNM: {
                            //TODO
                            TValue rb = RB(i);
                            lua_Number nb;
                            if (rb.IsInteger) {
                                lua_Integer ib = rb.I;
                                ra.I = -ib;
                            } else if (tonumber(rb, out nb)) {
                                ra.N = -nb;
                            } else {
                                // TODO 这样写对不对
                                trybinTM(rb, rb, ra, TMS.TM_UNM);
                            }
                            continue;
                        }

                    #endregion 算术运算符 数值计算类指令

                    #region 逻辑运算符

                    // A B R(A) := not R(B)
                    case Opcode.OP_NOT: {
                            TValue rb = RB(i);
                            bool res = rb.IsFalse;  /* next assignment may change this value */
                            ra.B = res;
                            continue;
                        }

                    #endregion 逻辑运算符

                    // A B R(A) := length of R(B)
                    case Opcode.OP_LEN: {
                            //objlen(ra, RB(i));
                            TValue rb = RB(i);
                            switch (rb.Type) {
                                case LuaType.LUA_TTABLE: {
                                        //ra.N
                                        break;
                                    }
                                case LuaType.LUA_TSTRING: {
                                        break;
                                    }
                                // try metamethod
                                default: {
                                        break;
                                    }
                            }
                            continue;
                        }
                    // A B C R(A) := R(B).. ... ..R(C)
                    case Opcode.OP_CONCAT: {
                            //TODO
                            int b = (int)i.B;
                            int c = (int)i.C;
                            TValue rb;
                            top = @base + c + 1;  /* mark the end of concat operands */
                            concat(c - b + 1);
                            ra = RA(i);  /* 'luaV_concat' may invoke TMs and move the stack */
                            rb = Stack[@base + b];
                            ra.Value = rb;
                            continue;
                        }
                    // sBx pc+=sBx
                    case Opcode.OP_JMP: {
                            pc += i.SignedBx;
                            if (i.A != 0) {
                                // luaF_close(L, ci->u.l.base + a - 1);
                            }
                            continue;
                        }

                    #region 比较运算符 关系逻辑类指令

                    // A B C if ((RK(B) == RK(C)) ~= A) then pc++
                    case Opcode.OP_EQ: {
                            Relation(i, EqualVal);
                            continue;
                        }
                    // A B C if ((RK(B) <  RK(C)) ~= A) then pc++
                    case Opcode.OP_LT: {
                            continue;
                        }
                    // A B C if ((RK(B) <= RK(C)) ~= A) then pc++
                    case Opcode.OP_LE: {
                            continue;
                        }
                    // A C if not (R(A) <=> C) then pc++
                    case Opcode.OP_TEST: {
                            continue;
                        }
                    // A B C if (R(B) <=> C) then R(A) := R(B) else pc++
                    case Opcode.OP_TESTSET: {
                            continue;
                        }

                    #endregion 比较运算符

                    #region 函数相关指令

                    // A B C R(A), ... ,R(A+C-2) := R(A)(R(A+1), ... ,R(A+B-1))
                    // A指定被调用函数对象的寄存器索引
                    // A后面紧跟实参列表，实参个数为B
                    // 返回值个数为C
                    // call指令对应于lua脚本中的函数调用
                    // 执行完该指令后，被调用函数和它的栈帧被清空，返回值被留在栈上
                    // 《自己动手实现Lua》p154
                    case Opcode.OP_CALL: {
                            int b = (int)i.B;
                            int nresults = (int)i.C - 1;
                            int func = @base + (int)i.A;
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
                    // A B return R(A), ... ,R(A+B-2) (see note)
                    case Opcode.OP_RETURN: {
                            int b = (int)i.B;
                            int a = (int)i.A;
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
                    // A B C return R(A)(R(A+1), ... ,R(A+B-1))
                    // 形如return f()的返回语句被优化成尾递归
                    case Opcode.OP_TAILCALL: {
                            // TODO clua太多了，书上没讲
                            continue;
                        }

                    #endregion 函数相关指令

                    #region 循环类指令

                    // A sBx R(A)+=R(A+2); if R(A) <?= R(A+1) then { pc+=sBx; R(A+3)=R(A) }
                    case Opcode.OP_FORLOOP: {
                            continue;
                        }
                    // A sBx R(A)-=R(A+2); pc+=sBx
                    case Opcode.OP_FORPREP: {
                            continue;
                        }
                    // A C R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2)); if R(A+3) ~= nil then R(A+2)=R(A+3) else pc++
                    case Opcode.OP_TFORLOOP: {
                            continue;
                        }
                    #endregion

                    // A B C R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B
                    case Opcode.OP_SETLIST: {
                            continue;
                        }
                    // A  close all variables in the stack up to (>=) R(A)
                    case Opcode.OP_CLOSE: {
                            continue;
                        }
                    // A Bx R(A) := closure(KPROTO[Bx], R(A), ... ,R(A+n))
                    // closure指令的执行分为以下两步：
                    // * 从内嵌Proto列表中取出Proto实例，来构造Closure实例ncl
                    // * 提前执行后面的move指令或get upval指令来初始化ncl的upvals
                    case Opcode.OP_CLOSURE: {
                            /*用Proto简单new一个LuaClosure，提前执行之后的指令s来初始化upvals*/
                            Proto p = cl.p.Protos[i.Bx];
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
                    // A B R(A), R(A+1), ..., R(A+B-1) = vararg
                    // 将vararg加载到连续多个寄存器中
                    // 开始索引为A，个数为B
                    // vararg指令很像call指令
                    case Opcode.OP_VARARG: {
                            int a = (int)i.A;
                            int b = (int)i.B - 1;
                            CallInfo ci = this.ci;
                            int n = ci.@base - ci.funcIndex - cl.p.numparams;
                            if (b == LUA_MULTRET) {
                                stack.check(n);
                                ra = RA(i);  /* previous call may change the stack */
                                b = n;
                                top = a + n;
                            }
                            for (int j = 0; j < b; j++) {
                                if (j < n) {
                                    Stack[a + j].Value = Stack[ci.@base - n + j];
                                } else {
                                    Stack[a + j].SetNil();
                                }
                            }
                            continue;
                        }
                    default:
                        continue;
                }
            }
        }

        /// 让栈扩展到`size大小
        /// TODO 删除 stack.check
        internal void Alloc(int size)
        {
            for (int i = Stack.Count; i < size; i++)
                Stack.Add(new TValue());
        }

        #region other things

        /// <summary>
        /// luaV_tostring
        /// </summary>
        public bool ToString(TValue obj)
        {
            return false;
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
            if (lhs.IsNumber) return lhs.N < rhs.N;
            if (lhs.IsString) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
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
        public List<TValue> slots;
        public int top;

        public LuaStack(int size)
        {
            slots = new List<TValue>(size);
            for (int i = 0; i < size; i++) {
                slots.Add(new TValue());
            }
            top = 0;
        }

        // 检查栈的空闲空间是否还可以容纳（推入）至少n个值，如若不然，扩容
        public void check(int n)
        {
            int free = slots.Count - top;
            for (int i = free; i < n; i++) {
                slots.Add(new TValue());
            }
        }

        // 压栈，溢出时抛出异常
        public void push(TValue val)
        {
            if (top == slots.Count) {
                throw new Exception("stack overflow");
            } else {
                slots[top] = val;
                top++;
            }
        }

        // 弹栈，若栈为空，抛出异常
        public TValue pop()
        {
            if (top < 1) {
                throw new Exception("stack underflow");
            } else {
                top--;
                var val = slots[top];
                slots[top] = new TValue();
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
        public TValue get(int idx)
        {
            var absIdx = absIndex(idx);
            if (absIdx > 0 && absIdx <= top) {
                return slots[absIdx - 1];
            } else {
                return new TValue();
            }
        }

        // 写值，索引无效则抛出异常
        public void set(int idx, TValue val)
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
                slots[absIdx - 1].Value = val;
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