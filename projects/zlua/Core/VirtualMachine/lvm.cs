using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

/// <summary>
/// 虚拟机
/// </summary>
namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// 虚拟机
    /// </summary>
    /// <remarks>写成partial是分给各个API类</remarks>
    public partial class lua_State : GCObject
    {
        #region 私有访问器

        private List<TValue> Stack { get { return LuaStack.slots; } }

        /// top指向第一个可用位置，每次push时 top++ = value
        /// 几乎所有文件都要用，因为你用这个来维护栈这个行为
        private int top {
            get { return LuaStack.top; }
            set { LuaStack.top = value; }
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
        private int pc;

        private Bytecode[] codes { get; set; }
        private int NumCSharpCalls { get; set; }
        internal global_State globalState = new global_State(); //注册表是一个L一个吗？

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
            LuaStack = new lua_State(20);
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

        /// <summary>
        /// 缓存cl
        /// </summary>
        /// <remarks>因为要写辅助方法，所以从局部变量变为字段</remarks>
        private LuaClosure cl;

        /// <summary>
        /// 缓存k
        /// </summary>
        /// <remarks>因为要写辅助方法，所以从局部变量变为字段</remarks>
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
            Debug.Assert(BytecodeTool.GetOpmode(i.Opcode).ArgBMode == OperandMode.OpArgK);
            return k[i.Bx];
        }

        #endregion 从指令取出参数的辅助方法

        /// <summary>
        /// 执行一个深度为level的lua函数，chunk深度为1
        /// </summary>
        /// <remarks>没有level就不知道什么时候结束了（事实上可以，用callinfo栈）</remarks>
        /// <param name="nexeccalls"></param>
        private void luaV_execute(int nexeccalls)
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
            k = cl.p.k;
            // 缓存savedpc

            while (true) {
                Bytecode i = codes[pc++];
                Debug.Assert(@base == ci.@base);
                //TODO helloworld程序在call指令执行后这个断言失败，top=0，base=1
                //getg，loadk，call执行了两次，然后栈帧为空，
                //Debug.Assert(@base <= top && top < StackLastFree); //这里始终没有。
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
                            luaV_gettable(g, rb, ra);
                            continue;
                        }
                    // A B C R(A) := R(B)[RK(C)]
                    case Opcode.OP_GETTABLE: {
                            luaV_gettable(RB(i), RKC(i), ra);
                            continue;
                        }
                    // A Bx Gbl[Kst(Bx)] := R(A)
                    case Opcode.OP_SETGLOBAL: {
                            TValue g = new TValue(cl.env);
                            Debug.Assert(KBx(i).IsString);
                            luaV_settable(g, KBx(i), ra);
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
                            luaV_settable(ra, RKB(i), RKC(i));
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
                            luaV_gettable(rb, RKC(i), ra);
                            continue;
                        }

                    #endregion 赋值类指令 数据传输指令

                    #region 算术运算符 数值计算类指令

                    // A B C R(A) := RK(B) + RK(C)
                    case Opcode.OP_ADD: {
                            //TODO
                            //arith_op(luai_numadd, TM_ADD);

                            arith_op(i, (a, b) => a + b, TMS.TM_ADD);
                            continue;
                        }
                    // A B C R(A) := RK(B) - RK(C)
                    case Opcode.OP_SUB: {
                            arith_op(i, (a, b) => a - b, TMS.TM_SUB);
                            continue;
                        }
                    // A B C R(A) := RK(B) * RK(C)
                    case Opcode.OP_MUL: {
                            arith_op(i, (a, b) => a * b, TMS.TM_MUL);
                            continue;
                        }
                    // A B C R(A) := RK(B) / RK(C)
                    case Opcode.OP_DIV: {
                            arith_op(i, (a, b) => a / b, TMS.TM_DIV);
                            continue;
                        }
                    // A B C R(A) := RK(B) % RK(C)
                    case Opcode.OP_MOD: {
                            arith_op(i, luai_nummod, TMS.TM_MOD);
                            continue;
                        }
                    // A B C R(A) := RK(B) ^ RK(C)
                    case Opcode.OP_POW: {
                            arith_op(i, luai_numpow, TMS.TM_POW);
                            continue;
                        }

                    // A B R(A) := -R(B)
                    case Opcode.OP_UNM: {
                            //TODO
                            TValue rb = RB(i);
                            if (rb.IsNumber) {
                                lua_Number nb = rb.N;
                                ra.N = -nb;
                            } else {
                                call_binTM(ra, rb, rb, TMS.TM_UNM);
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
                            TValue rb = RB(i);
                            switch (rb.tt) {
                                case LuaTag.LUA_TTABLE: {
                                        ra.N = rb.Table.luaH_getn();
                                        break;
                                    }
                                case LuaTag.LUA_TSTRING: {
                                        ra.N = rb.Str.Length;
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
                            int b = (int)i.B;
                            int c = (int)i.C;
                            luaV_concat(c - b + 1, c);
                            ra.Value = RB(i);
                            continue;
                        }
                    // sBx pc+=sBx
                    case Opcode.OP_JMP: {
                            pc += i.SignedBx;
                            continue;
                        }

                    #region 比较运算符 关系逻辑类指令

                    // A B C if ((RK(B) == RK(C)) ~= A) then pc++
                    case Opcode.OP_EQ: {
                            Relation(i, equalobj);
                            continue;
                        }
                    // A B C if ((RK(B) <  RK(C)) ~= A) then pc++
                    case Opcode.OP_LT: {
                            Relation(i, luaV_lessthan);
                            continue;
                        }
                    // A B C if ((RK(B) <= RK(C)) ~= A) then pc++
                    case Opcode.OP_LE: {
                            Relation(i, lessequal);
                            continue;
                        }
                    // A C if not (R(A) <=> C) then pc++
                    // 与testset类似
                    case Opcode.OP_TEST: {
                            if (ra.IsFalse != (i.C == 1 ? true : false)) {
                                pc += codes[pc].SignedBx;
                            } else {
                                pc++;
                            }
                            continue;
                        }
                    // A B C if (R(B) <=> C) then R(A) := R(B) else pc++
                    // 判断RB的条件值是否与C相等，是则RA=RB，否则pc++
                    // <=>表示bool比较
                    case Opcode.OP_TESTSET: {
                            if (ra.IsFalse != (i.C == 1 ? true : false)) {
                                ra.Value = RB(i);
                                pc += codes[pc].SignedBx;
                            } else {
                                pc++;
                            }
                            continue;
                        }

                    #endregion 比较运算符 关系逻辑类指令

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
                    // for index+=for step，
                    // if for index <= for limit {跳转到循环体第一行代码，并i=for index}
                    // <?=表示，当step为正数时，<=，当step为负数时，>=
                    case Opcode.OP_FORLOOP: {
                            lua_Number step = Stack[(int)i.A + 2].N;
                            lua_Number idx = ra.N + step; /* increment index */
                            lua_Number limit = Stack[(int)i.A + 1].N;
                            if ((0 < step) ? idx <= limit : limit <= idx) {
                                pc += i.SignedBx;  /* jump back */
                                ra.N = idx;  /* update internal index... */
                                Stack[(int)i.A + 3].N = idx;  /* ...and external index */
                            }
                            continue;
                        }
                    // A sBx R(A)-=R(A+2); pc+=sBx
                    // forprep相当于循环的初始化
                    // for index-=for step，并跳转到forloop指令
                    // 参见2019-04-28 09-19-40.947648-for_num.lua
                    case Opcode.OP_FORPREP: {
                            TValue init = ra;
                            TValue plimit = Stack[(int)i.A + 1];
                            TValue pstep = Stack[(int)i.A + 2];
                            //savedpc = pc;  /* next steps may throw errors */
                            lua_Number n1;
                            lua_Number n2;
                            lua_Number n3;
                            if (!tonumber(init, out n1))
                                //luaG_runerror(L, LUA_QL("for") " initial value must be a number");
                                throw new Exception();
                            else if (!tonumber(plimit, out n2))
                                //luaG_runerror(L, LUA_QL("for") " limit must be a number");
                                throw new Exception();
                            else if (!tonumber(pstep, out n3))
                                //luaG_runerror(L, LUA_QL("for") " step must be a number");
                                throw new Exception();
                            init.N = n1;
                            plimit.N = n2;
                            pstep.N = n3;
                            ra.N = ra.N - pstep.N;
                            pc += i.SignedBx;
                            continue;
                        }
                    // A C R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2)); if R(A+3) ~= nil then R(A+2)=R(A+3) else pc++
                    case Opcode.OP_TFORLOOP: {
                            int a = (int)i.A;
                            int cb = (int)i.A + 3;  /* call base */
                            Stack[cb + 2].Value = Stack[a + 2];
                            Stack[cb + 1].Value = Stack[a + 1];
                            Stack[cb].Value = ra;
                            top = cb + 3;  /* func. + 2 args (state and index) */
                            luaD_call(cb, (int)i.C);
                            top = ci.top;
                            //cb = i.A + 3;  /* previous call may change the stack */
                            if (!Stack[cb].IsNil) {  /* continue loop? */
                                Stack[cb - 1].Value = Stack[cb];  /* save control variable */
                                pc += codes[pc].SignedBx;  /* jump back */
                            }
                            pc++;
                            continue;
                        }

                    #endregion 循环类指令

                    // A B C R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B
                    case Opcode.OP_SETLIST: {
                            int n = (int)i.B;
                            int c = (int)i.C;
                            int last;
                            Table h;
                            if (n == 0) {
                                n = top - (int)i.A - 1;
                                top = ci.top;
                            }
                            if (c == 0) c = (int)codes[pc++].Value;
                            // runtime_check
                            if (!ra.IsTable) {
                                break;
                            }
                            h = ra.Table;
                            /* number of list items to accumulate before a SETLIST instruction */
                            const int LFIELDS_PER_FLUSH = 50;
                            last = ((c - 1) * LFIELDS_PER_FLUSH) + n;
                            if (last > h.sizearray)  /* needs more space? */
                                h.luaH_resizearray(last);  /* pre-alloc it at once */
                            for (; n > 0; n--) {
                                TValue val = Stack[(int)i.A + n];
                                h.luaH_setnum(last--).Value = val;
                            }
                            continue;
                        }
                    // A  close all variables in the stack up to (>=) R(A)
                    case Opcode.OP_CLOSE: {
                            //luaF_close(ra);
                            continue;
                        }
                    // A Bx R(A) := closure(KPROTO[Bx], R(A), ... ,R(A+n))
                    // closure指令的执行分为以下两步：
                    // * 从内嵌Proto列表中取出Proto实例，来构造Closure实例ncl
                    // * 提前执行后面的move指令或get upval指令来初始化ncl的upvals
                    case Opcode.OP_CLOSURE: {
                            /*用Proto简单new一个LuaClosure，提前执行之后的指令s来初始化upvals*/
                            Proto p = cl.p.p[i.Bx];
                            int nup = p.nups;
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
                                LuaStack.check(n);
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
        /// limit for table tag-method chains (to avoid loops)
        /// </summary>
        private const int MAXTAGLOOP = 100;

        /// <summary>
        /// 无限查元表
        /// </summary>
        /// <param name="t"></param>
        /// <param name="key"></param>
        /// <param name="val"></param>
        public void luaV_gettable(TValue t, TValue key, TValue val)
        {
            for (int loop = 0; loop < MAXTAGLOOP; loop++) {
                TValue tm;
                if (t.IsTable) {
                    Table h = t.Table;
                    TValue res = h.luaH_get(key);/* do a primitive get */
                    tm = fasttm(h.metatable, TMS.TM_INDEX);
                    if (!res.IsNil ||  /* result is no nil? */
                            tm == null) {  /* or no TM? */
                        val.Value = res;
                        return;
                    }
                    /* else will try the tag method */
                } else {
                    tm = luaT_gettmbyobj(t, TMS.TM_INDEX);
                    if (tm.IsNil) {
                        //TODO
                        //luaG_typeerror(L, t, "index");
                        throw new Exception();
                    } else if (tm.IsFunction) {
                        callTMres(val, tm, t, key);
                        return;
                    } else {
                        t = tm; /* else repeat with `tm' */
                    }
                }
            }
            //TODO
            //luaG_runerror(L, "loop in gettable");
        }

        public void luaV_settable(TValue t, TValue key, TValue val)
        {
            for (int loop = 0; loop < MAXTAGLOOP; loop++) {
                TValue tm;
                if (t.IsTable) {
                    Table h = t.Table;
                    TValue oldval = h.luaH_set(key);  /* do a primitive set */
                    tm = fasttm(h.metatable, TMS.TM_NEWINDEX);
                    if (!oldval.IsNil ||
                        tm == null) {
                        oldval.Value = val;
                        return;
                    }
                    /* else will try the tag method */
                } else {
                    tm = luaT_gettmbyobj(t, TMS.TM_NEWINDEX);
                    if (tm.IsNil) {
                        //luaG_typeerror(L, t, "index");
                    } else if (tm.IsFunction) {
                        callTM(tm, t, key, val);
                        return;
                    } else {
                        t = tm;  /* else repeat with `tm' */
                    }
                }
            }
            //luaG_runerror(L, "loop in settable");
        }

        /// <summary>
        /// 拼接栈上连续<c>total</c>个寄存器，<c>last</c>是最后一个元素的索引
        /// </summary>
        /// <param name="total"></param>
        /// <param name="last"></param>
        private void luaV_concat(int total, int last)
        {
            // 如果total为0，返回空串
            do {
                int top = @base + last + 1;
                int n = 2;  /* number of elements handled in this pass (at least 2) */
                if (!Stack[top - 2].IsString || Stack[top - 2].IsNumber || !tostring(Stack[top - 1])) {
                    if (!call_binTM(Stack[top - 2], Stack[top - 1], Stack[top - 2], TMS.TM_CONCAT))
                        //luaG_concaterror(L, top - 2, top - 1);
                        throw new Exception();
                } else if (Stack[top - 1].Str.Length == 0)  /* second op is empty? */
                    tostring(Stack[top - 2]);  /* result is first op (as string) */
                else {
                    /* at least two string values; get as many as possible */
                    int tl = Stack[top - 1].Str.Length;
                    StringBuilder buffer = new StringBuilder();
                    int i;
                    /* collect total length */
                    for (n = 1; n < total && tostring(Stack[top - n - 1]); n++) {
                        int l = Stack[top - n - 1].Str.Length;
                        if (l >= int.MaxValue - tl)
                            //luaG_runerror(L, "string length overflow");
                            throw new Exception();
                        tl += l;
                    }
                    tl = 0;
                    for (i = n; i > 0; i--) {  /* concat all strings */
                        int l = Stack[top - i].Str.Length;
                        buffer.Append(Stack[top - i].Str);
                        tl += l;
                    }
                    Stack[top - n] = new TValue(buffer.ToString());
                }
                total -= n - 1;  /* got `n' strings to create 1 new */
                last -= n - 1;
            } while (total > 1);  /* repeat until only 1 result left */
        }

        public bool LessThan(TValue lhs, TValue rhs)
        {
            if (lhs.tt != rhs.tt) throw new Exception();
            if (lhs.IsNumber) return lhs.N < rhs.N;
            if (lhs.IsString) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
        }

        private bool tostring(TValue o)
        {
            return o.IsString || luaV_tostring(o);
        }

        private bool luaV_tostring(TValue obj)
        {
            if (!obj.IsNumber) {
                return false;
            } else {
                obj.Str = obj.N.ToString();
                return true;
            }
        }

        #endregion other things

        private lua_State LuaStack { get; set; }
    }
}