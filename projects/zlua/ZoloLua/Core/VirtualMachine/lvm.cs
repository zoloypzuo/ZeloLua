using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using ZoloLua.Core.InstructionSet;
using ZoloLua.Core.Lua;
using ZoloLua.Core.MetaMethod;
using ZoloLua.Core.ObjectModel;
using ZoloLua.Core.TypeModel;

namespace ZoloLua.Core.VirtualMachine
{
    /// <summary>
    ///     虚拟机
    /// </summary>
    /// <remarks>写成partial是分给各个API类</remarks>
    public partial class lua_State
    {
        /// <summary>
        ///     limit for table tag-method chains (to avoid loops)
        /// </summary>
        private const int MAXTAGLOOP = 100;

        /// <summary>
        ///     当前函数栈帧的基
        /// </summary>
        /// <remarks>
        ///     是相对于栈底的偏移，所有函数内索引局部变量以这个为基准
        /// </remarks>
        private StkId @base;
        /// <summary>
        ///     缓存cl
        /// </summary>
        /// <remarks>因为要写辅助方法，所以从局部变量变为字段</remarks>
        private LuaClosure cl;

        private Bytecode[] code;

        /// <summary>
        ///     缓存k
        /// </summary>
        /// <remarks>因为要写辅助方法，所以从局部变量变为字段</remarks>
        private TValue[] k;

        /// <summary>
        ///     调用函数时保存的pc
        /// </summary>
        /// <remarks>clua用指针算法，而zlua必须同时使用codes数组和pc索引来获取指令</remarks>
        private int savedpc;

        /// <summary>
        ///     栈顶
        /// </summary>
        /// <remarks>
        ///     栈顶约定：top指向第一个可用位置，每次push时 top++ = value
        /// </remarks>
        private StkId top;

        /// <summary>
        ///     当前函数调用信息
        /// </summary>
        private CallInfo ci {
            get {
                return CallStack.Peek();
            }
        }

        /// <summary>
        ///     栈最后空闲的索引
        /// </summary>
        /// <remarks>标记分配的大小,top永远小于stacklastfree</remarks>
        private StkId stack_last {
            get {
                return newStkId(stack.Count - EXTRA_STACK - 1);
            }
        }

        /// <summary>
        ///     调用栈
        /// </summary>
        private Stack<CallInfo> CallStack { get; }

        private List<TValue> stack { get; }

        public bool LessThan(TValue lhs, TValue rhs)
        {
            if (lhs.tt != rhs.tt) {
                throw new Exception();
            }
            if (lhs.IsNumber) {
                return lhs.N < rhs.N;
            }
            if (lhs.IsString) {
                return false; //TODO 字典序。或者你看标准库有没有
            }
            return false; //TODO 调用meta方法
        }

        /// <summary>
        ///     元表查找算法
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
                    TValue res = h.luaH_get(key); /* do a primitive get */
                    tm = fasttm(h.metatable, TMS.TM_INDEX);
                    if (!res.IsNil || /* result is no nil? */
                        tm == null) { /* or no TM? */
                        val.Value = res;
                        return;
                    }
                    /* else will try the tag method */
                } else {
                    tm = luaT_gettmbyobj(t, TMS.TM_INDEX);
                    if (tm.IsNil) {
                        throw new Exception();
                    }
                    if (tm.IsFunction) {
                        callTMres(val, tm, t, key);
                        return;
                    }
                    t = tm; /* else repeat with `tm' */
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
                    TValue oldval = h.luaH_set(key); /* do a primitive set */
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
                        t = tm; /* else repeat with `tm' */
                    }
                }
            }
            //luaG_runerror(L, "loop in settable");
        }

        // 弹栈，若栈为空，抛出异常
        /// <summary>
        ///     The pop
        /// </summary>
        /// <returns>The <see cref="TValue" /></returns>
        public TValue pop()
        {
            //if (top < 1) {
            //    throw new Exception("stack underflow");
            //} else {
            //    top--;
            //    var val = stack[top];
            //    stack[top] = new TValue();
            //    return val;
            //}
            return --top;
        }

        // 压栈，溢出时抛出异常
        /// <summary>
        ///     The push
        /// </summary>
        /// <param name="val">The val<see cref="TValue" /></param>
        public void push(TValue val)
        {
            //if (top == stack.Count) {
            //    throw new Exception("stack overflow");
            //} else {
            //    stack[top] = val;
            //    top++;
            //}
            top++.Set(val);
        }


        public static bool tonumber(TValue val, out lua_Number n)
        {
            switch (val.tt) {
                case LuaType.LUA_TNUMBER:
                    n = val.N;
                    return true;

                case LuaType.LUA_TSTRING:
                    return lobject.luaO_str2d(val.Str, out n);

                default:
                    n = 0;
                    return false;
            }
        }

        /// <summary>
        ///     拼接栈上连续<c>total</c>个寄存器，<c>last</c>是最后一个元素的索引
        /// </summary>
        /// <param name="total"></param>
        /// <param name="last"></param>
        private void luaV_concat(int total, int last)
        {
            // 如果total为0，返回空串
            do {
                // 这里因为。。不改成StkId，除非不对
                int top = @base.index + last + 1;
                int n = 2; /* number of elements handled in this pass (at least 2) */
                if (!stack[top - 2].IsString || stack[top - 2].IsNumber || !tostring(stack[top - 1])) {
                    if (!call_binTM(stack[top - 2], stack[top - 1], stack[top - 2], TMS.TM_CONCAT))
                        //luaG_concaterror(L, top - 2, top - 1);
                    {
                        throw new Exception();
                    }
                } else if (stack[top - 1].Str.Length == 0) /* second op is empty? */ {
                    tostring(stack[top - 2]); /* result is first op (as string) */
                } else {
                    /* at least two string values; get as many as possible */
                    int tl = stack[top - 1].Str.Length;
                    StringBuilder buffer = new StringBuilder();
                    int i;
                    /* collect total length */
                    for (n = 1; n < total && tostring(stack[top - n - 1]); n++) {
                        int l = stack[top - n - 1].Str.Length;
                        if (l >= int.MaxValue - tl)
                            //luaG_runerror(L, "string length overflow");
                        {
                            throw new Exception();
                        }
                        tl += l;
                    }
                    tl = 0;
                    for (i = n; i > 0; i--) { /* concat all strings */
                        int l = stack[top - i].Str.Length;
                        buffer.Append(stack[top - i].Str);
                        tl += l;
                    }
                    stack[top - n] = new TValue(buffer.ToString());
                }
                total -= n - 1; /* got `n' strings to create 1 new */
                last -= n - 1;
            } while (total > 1); /* repeat until only 1 result left */
        }

        /// <summary>
        ///     执行一个深度为level的lua函数，chunk深度为1
        /// </summary>
        /// <remarks>没有level就不知道什么时候结束了（事实上可以，用callinfo栈）</remarks>
        /// <param name="nexeccalls"></param>
        private void luaV_execute(int nexeccalls)
        {
            int pc = 0;
            StkId @base;
            reentry:
            TValue funcValue = ci.func;
            Debug.Assert(funcValue.IsLuaFunction);
            pc = savedpc;
            cl = funcValue.Cl as LuaClosure;
            @base = this.@base;
            k = cl.p.k;
            while (true) {
                Bytecode i = code[pc++];
                Debug.Assert(@base == this.@base && this.@base == ci.@base);
                Debug.Assert(@base <= top && top < newStkId(stack.Count));
                TValue ra = RA(i);
                switch (i.Opcode) {

                    #region 赋值类指令 数据传输指令

                    // A B R(A) := R(B)
                    case Opcode.OP_MOVE:
                        {
                            ra.Value = RB(i);
                            continue;
                        }
                    // A Bx R(A) := Kst(Bx)
                    // 从常量表取出常量写入R(A)
                    case Opcode.OP_LOADK:
                        {
                            ra.Value = KBx(i);
                            continue;
                        }
                    // A B C R(A) := (Bool)B; if (C) pc++
                    case Opcode.OP_LOADBOOL:
                        {
                            ra.B = i.B != 0;
                            if (GETARG_C(i) != 0) {
                                pc++;
                            }
                            continue;
                        }
                    // A B R(A) := ... := R(B) := nil
                    case Opcode.OP_LOADNIL:
                        {
                            int raIndex = (int)i.A;
                            int rbIndex = (int)i.B;
                            do {
                                stack[rbIndex--].SetNil();
                            } while (rbIndex >= raIndex);
                            continue;
                        }
                    // A B R(A) := UpValue[B]
                    case Opcode.OP_GETUPVAL:
                        {
                            ra.Value = UpValueB(i);
                            continue;
                        }
                    // A Bx R(A) := Gbl[Kst(Bx)]
                    case Opcode.OP_GETGLOBAL:
                        {
                            TValue g = new TValue(cl.env);
                            TValue rb = KBx(i);
                            Debug.Assert(rb.IsString);
                            luaV_gettable(g, rb, ra);
                            continue;
                        }
                    // A B C R(A) := R(B)[RK(C)]
                    case Opcode.OP_GETTABLE:
                        {
                            luaV_gettable(RB(i), RKC(i), ra);
                            continue;
                        }
                    // A Bx Gbl[Kst(Bx)] := R(A)
                    case Opcode.OP_SETGLOBAL:
                        {
                            TValue g = new TValue(cl.env);
                            Debug.Assert(KBx(i).IsString);
                            luaV_settable(g, KBx(i), ra);
                            continue;
                        }
                    // A B UpValue[B] := R(A)
                    case Opcode.OP_SETUPVAL:
                        {
                            UpVal uv = cl.upvals[(int)i.B];
                            uv.v.Value = ra;
                            continue;
                        }
                    // A B C R(A)[RK(B)] := RK(C)
                    case Opcode.OP_SETTABLE:
                        {
                            luaV_settable(ra, RKB(i), RKC(i));
                            continue;
                        }
                    // A B C R(A) := {} (size = B,C)
                    case Opcode.OP_NEWTABLE:
                        {
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
                    case Opcode.OP_SELF:
                        {
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
                    case Opcode.OP_ADD:
                        {
                            arith_op(i, (a, b) => a + b, TMS.TM_ADD);
                            continue;
                        }
                    // A B C R(A) := RK(B) - RK(C)
                    case Opcode.OP_SUB:
                        {
                            arith_op(i, (a, b) => a - b, TMS.TM_SUB);
                            continue;
                        }
                    // A B C R(A) := RK(B) * RK(C)
                    case Opcode.OP_MUL:
                        {
                            arith_op(i, (a, b) => a * b, TMS.TM_MUL);
                            continue;
                        }
                    // A B C R(A) := RK(B) / RK(C)
                    case Opcode.OP_DIV:
                        {
                            arith_op(i, (a, b) => a / b, TMS.TM_DIV);
                            continue;
                        }
                    // A B C R(A) := RK(B) % RK(C)
                    case Opcode.OP_MOD:
                        {
                            arith_op(i, luai_nummod, TMS.TM_MOD);
                            continue;
                        }
                    // A B C R(A) := RK(B) ^ RK(C)
                    case Opcode.OP_POW:
                        {
                            arith_op(i, luai_numpow, TMS.TM_POW);
                            continue;
                        }

                    // A B R(A) := -R(B)
                    case Opcode.OP_UNM:
                        {
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
                    case Opcode.OP_NOT:
                        {
                            TValue rb = RB(i);
                            bool res = rb.IsFalse; /* next assignment may change this value */
                            ra.B = res;
                            continue;
                        }

                    #endregion 逻辑运算符

                    // A B R(A) := length of R(B)
                    case Opcode.OP_LEN:
                        {
                            TValue rb = RB(i);
                            switch (rb.tt) {
                                case LuaType.LUA_TTABLE:
                                    {
                                        ra.N = rb.Table.luaH_getn();
                                        break;
                                    }
                                case LuaType.LUA_TSTRING:
                                    {
                                        ra.N = rb.Str.Length;
                                        break;
                                    }
                                // try metamethod
                            }
                            continue;
                        }
                    // A B C R(A) := R(B).. ... ..R(C)
                    case Opcode.OP_CONCAT:
                        {
                            int b = (int)i.B;
                            int c = (int)i.C;
                            luaV_concat(c - b + 1, c);
                            ra.Value = RB(i);
                            continue;
                        }
                    // sBx pc+=sBx
                    case Opcode.OP_JMP:
                        {
                            pc += i.SignedBx;
                            continue;
                        }

                    #region 比较运算符 关系逻辑类指令

                    // A B C if ((RK(B) == RK(C)) ~= A) then pc++
                    case Opcode.OP_EQ:
                        {
                            Relation(i, equalobj);
                            continue;
                        }
                    // A B C if ((RK(B) <  RK(C)) ~= A) then pc++
                    case Opcode.OP_LT:
                        {
                            Relation(i, luaV_lessthan);
                            continue;
                        }
                    // A B C if ((RK(B) <= RK(C)) ~= A) then pc++
                    case Opcode.OP_LE:
                        {
                            Relation(i, lessequal);
                            continue;
                        }
                    // A C if not (R(A) <=> C) then pc++
                    // 与testset类似
                    case Opcode.OP_TEST:
                        {
                            if (ra.IsFalse != (i.C == 1 ? true : false)) {
                                pc += code[pc].SignedBx;
                            } else {
                                pc++;
                            }
                            continue;
                        }
                    // A B C if (R(B) <=> C) then R(A) := R(B) else pc++
                    // 判断RB的条件值是否与C相等，是则RA=RB，否则pc++
                    // <=>表示bool比较
                    case Opcode.OP_TESTSET:
                        {
                            if (ra.IsFalse != (i.C == 1 ? true : false)) {
                                ra.Value = RB(i);
                                pc += code[pc].SignedBx;
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
                    case Opcode.OP_CALL:
                        {
                            int a = GETARG_A(i);
                            int b = GETARG_B(i);
                            int nresults = GETARG_C(i) - 1;
                            StkId raIndex = @base + a;
                            if (b != 0) {
                                top = raIndex + b; /* else previous instruction set top */
                            }
                            savedpc = pc;
                            switch (luaD_precall(raIndex, nresults)) {
                                case PCRLUA:
                                    {
                                        nexeccalls++;
                                        goto reentry; /* restart luaV_execute over new Lua function */
                                    }
                                case PCRC:
                                    {
                                        /* it was a C function (`precall' called it); adjust results */
                                        if (nresults >= 0) {
                                            top = ci.top;
                                        }
                                        @base = this.@base;
                                        continue;
                                    }
                                default:
                                    {
                                        return; /* yield */
                                    }
                            }
                        }
                    // A B return R(A), ... ,R(A+B-2) (see note)
                    case Opcode.OP_RETURN:
                        {
                            int a = GETARG_A(i);
                            int b = GETARG_B(i);
                            StkId raIndex = @base + a;
                            if (b != 0) {
                                top = raIndex + b - 1;
                            }
                            savedpc = pc;
                            //TODO
                            //if (L->openupval) luaF_close(L, base);
                            b = luaD_poscall(@base + a);
                            if (--nexeccalls == 0) /* was previous function running `here'? */ {
                                return; /* no: return */
                            }
                            /* yes: continue its execution */
                            if (b != 0) {
                                top = ci.top;
                            }
                            Debug.Assert(((TValue)ci.func).IsLuaFunction);
                            Debug.Assert(code[ci.savedpc - 1].Opcode == Opcode.OP_CALL);
                            goto reentry;
                        }
                    // A B C return R(A)(R(A+1), ... ,R(A+B-1))
                    // 形如return f()的返回语句被优化成尾递归
                    case Opcode.OP_TAILCALL:
                        {
                            int a = GETARG_A(i);
                            int b = GETARG_B(i);
                            StkId raIndex = @base + a;

                            if (b != 0) {
                                top = raIndex + b; /* else previous instruction set top */
                            }
                            savedpc = pc;
                            Debug.Assert((int)i.C - 1 == LUA_MULTRET);
                            switch (luaD_precall(raIndex, LUA_MULTRET)) {
                                case PCRLUA:
                                    {
                                        /* tail call: put new frame in place of previous one */
                                        CallInfo ciplus1 = CallStack.Pop();
                                        CallInfo ci = this.ci; /* previous frame */
                                        //CallStack.Push(ciplus1);
                                        int aux;
                                        StkId func = ci.func;
                                        StkId pfunc = ciplus1.func; /* previous function index */
                                        //if (L->openupval) luaF_close(L, ci.@base);
                                        this.@base = ci.@base = ci.func + (ciplus1.@base - pfunc);
                                        for (aux = 0; pfunc + aux < top; aux++) /* move frame down */
                                            (func + aux).Set(pfunc + aux);
                                        ci.top = top = func + aux; /* correct top */
                                        AssertEqual(top, this.@base + (((TValue)func).Cl as LuaClosure).p.maxstacksize);
                                        ci.savedpc = savedpc;
                                        ci.tailcalls++; /* one more call lost */
                                        //CallStack.Pop();  /* remove new frame */
                                        goto reentry;
                                    }
                                case PCRC:
                                    { /* it was a C function (`precall' called it) */
                                        @base = this.@base;
                                        continue;
                                    }
                                default:
                                    {
                                        return; /* yield */
                                    }
                            }
                        }

                    #endregion 函数相关指令

                    #region 循环类指令

                    // A sBx R(A)+=R(A+2); if R(A) <?= R(A+1) then { pc+=sBx; R(A+3)=R(A) }
                    // for index+=for step，
                    // if for index <= for limit {跳转到循环体第一行代码，并i=for index}
                    // <?=表示，当step为正数时，<=，当step为负数时，>=
                    case Opcode.OP_FORLOOP:
                        {
                            StkId raIndex = @base + (int)i.A;
                            lua_Number step = (raIndex + 2).Value.N;
                            lua_Number idx = ra.N + step; /* increment index */
                            lua_Number limit = (raIndex + 1).Value.N;
                            if (0 < step ? idx <= limit : limit <= idx) {
                                pc += i.SignedBx; /* jump back */
                                ra.N = idx; /* update internal index... */
                                (raIndex + 3).Value.N = idx; /* ...and external index */
                            }
                            continue;
                        }
                    // A sBx R(A)-=R(A+2); pc+=sBx
                    // forprep相当于循环的初始化
                    // for index-=for step，并跳转到forloop指令
                    // 参见2019-04-28 09-19-40.947648-for_num.lua
                    case Opcode.OP_FORPREP:
                        {
                            StkId raIndex = @base + (int)i.A;
                            TValue init = ra;
                            TValue plimit = raIndex + 1;
                            TValue pstep = raIndex + 2;
                            savedpc = pc; /* next steps may throw errors */
                            lua_Number n1;
                            lua_Number n2;
                            lua_Number n3;
                            if (!tonumber(init, out n1))
                                //luaG_runerror(L, LUA_QL("for") " initial value must be a number");
                            {
                                throw new Exception();
                            }
                            if (!tonumber(plimit, out n2))
                                //luaG_runerror(L, LUA_QL("for") " limit must be a number");
                            {
                                throw new Exception();
                            }
                            if (!tonumber(pstep, out n3))
                                //luaG_runerror(L, LUA_QL("for") " step must be a number");
                            {
                                throw new Exception();
                            }
                            init.N = n1;
                            plimit.N = n2;
                            pstep.N = n3;
                            ra.N = ra.N - pstep.N;
                            pc += i.SignedBx;
                            continue;
                        }
                    // A C R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2)); if R(A+3) ~= nil then R(A+2)=R(A+3) else pc++
                    case Opcode.OP_TFORLOOP:
                        {
                            int a = (int)i.A;
                            StkId raIndex = @base + a;
                            StkId cb = @base + a + 3; /* call base */
                            (cb + 2).Set(raIndex + 2);
                            (cb + 1).Set(raIndex + 1);
                            cb.Set(raIndex);
                            top = cb + 3; /* func. + 2 args (state and index) */
                            luaD_call(cb, GETARG_C(i));
                            top = ci.top;
                            raIndex = @base + a;
                            cb = raIndex + 3; /* previous call may change the stack */
                            if (!((TValue)cb).IsNil) { /* continue loop? */
                                (cb - 1).Set(cb); /* save control variable */
                                pc += code[pc].SignedBx; /* jump back */
                            }
                            pc++;
                            continue;
                        }

                    #endregion 循环类指令

                    // A B C R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B
                    case Opcode.OP_SETLIST:
                        {
                            int a = GETARG_A(i);
                            int n = GETARG_B(i);
                            int c = GETARG_C(i);
                            StkId raIndex = @base + a;
                            int last;
                            Table h;
                            if (n == 0) {
                                n = top - raIndex - 1;
                                top = ci.top;
                            }
                            if (c == 0) {
                                c = (int)code[pc++].Value;
                            }
                            // runtime_check，只用这里一次，就内联了
                            if (!ra.IsTable) {
                                break;
                            }
                            h = ra.Table;
                            /* number of list items to accumulate before a SETLIST instruction */
                            const int LFIELDS_PER_FLUSH = 50;
                            last = (c - 1) * LFIELDS_PER_FLUSH + n;
                            if (last > h.sizearray) /* needs more space? */ {
                                h.luaH_resizearray(last); /* pre-alloc it at once */
                            }
                            for (; n > 0; n--) {
                                TValue val = raIndex + n;
                                h.luaH_setnum(last--).Value = val;
                            }
                            continue;
                        }
                    // A  close all variables in the stack up to (>=) R(A)
                    case Opcode.OP_CLOSE:
                        {
                            //luaF_close(ra);
                            continue;
                        }
                    // A Bx R(A) := closure(KPROTO[Bx], R(A), ... ,R(A+n))
                    // closure指令的执行分为以下两步：
                    // * 从内嵌Proto列表中取出Proto实例，来构造Closure实例ncl
                    // * 提前执行后面的move指令或get upval指令来初始化ncl的upvals
                    case Opcode.OP_CLOSURE:
                        {
                            /*用Proto简单new一个LuaClosure，提前执行之后的指令s来初始化upvals*/
                            Proto p = cl.p.p[i.Bx];
                            int nup = p.nups;
                            LuaClosure ncl = new LuaClosure(cl.env, nup, p);
                            // 后面一定跟着一些getUpval或mov指令用来初始化upvals，分情况讨论，把这些指令在这个周期就执行掉
                            for (int j = 0; j < nup; j++, pc++) {
                                Bytecode next_instr = code[pc];
                                // 从父Proto的upvals直接取upvals
                                if (next_instr.Opcode == Opcode.OP_GETUPVAL) {
                                    ncl.upvals[j] = cl.upvals[(int)code[pc].B];
                                }
                                // 否则得用复杂的方法确定upval的位置
                                else {
                                    Debug.Assert(code[pc].Opcode == Opcode.OP_MOVE);
                                }
                            }
                            ra.Cl = ncl;
                            continue;
                        }
                    // A B R(A), R(A+1), ..., R(A+B-1) = vararg
                    // 将vararg加载到连续多个寄存器中
                    // 开始索引为A，个数为B
                    // vararg指令很像call指令
                    case Opcode.OP_VARARG:
                        {
                            throw new NotImplementedException();
                            continue;
                        }
                    default:
                        continue;
                }
            }
        }

        private TValue luaV_tonumber(TValue obj, TValue n)
        {
            lua_Number num;
            if (obj.IsNumber) {
                return obj;
            }
            if (obj.IsString && lobject.luaO_str2d(obj.Str, out num)) {
                n.N = num;
                return n;
            }
            return null;
        }

        private bool luaV_tostring(TValue obj)
        {
            if (!obj.IsNumber) {
                return false;
            }
            obj.Str = obj.N.ToString();
            return true;
        }

        private bool tostring(TValue o)
        {
            return o.IsString || luaV_tostring(o);
        }


        #region 从指令取出参数的辅助方法

        [DebuggerStepThrough]
        private int GETARG_A(Bytecode i)
        {
            return (int)i.A;
        }

        [DebuggerStepThrough]
        private int GETARG_B(Bytecode i)
        {
            return (int)i.B;
        }

        [DebuggerStepThrough]
        private int GETARG_C(Bytecode i)
        {
            return (int)i.C;
        }

        [DebuggerStepThrough]
        private TValue R(int i)
        {
            return @base + i;
        }

        // R(A)
        [DebuggerStepThrough]
        private TValue RA(Bytecode i)
        {
            return @base + (int)i.A;
        }

        // R(B)
        [DebuggerStepThrough]
        private TValue RB(Bytecode i)
        {
            return @base + (int)i.B;
        }

        // R(C)
        [DebuggerStepThrough]
        private TValue RC(Bytecode i)
        {
            return @base + (int)i.C;
        }

        // RK(B)
        [DebuggerStepThrough]
        private TValue RKB(Bytecode i)
        {
            int B = (int)i.B;
            TValue rb = Bytecode.IsK(B) ?
                k[Bytecode.IndexK(B)] :
                @base + B;
            return rb;
        }

        // RK(C)
        [DebuggerStepThrough]
        private TValue RKC(Bytecode instr)
        {
            int C = (int)instr.C;
            TValue rc = Bytecode.IsK(C) ?
                k[Bytecode.IndexK(C)] :
                @base + C;
            return rc;
        }

        // UpValue[A]
        [DebuggerStepThrough]
        private TValue UpValueA(Bytecode instr)
        {
            TValue upa = cl.upvals[(int)instr.A].v;
            return upa;
        }

        // UpValue[B]
        [DebuggerStepThrough]
        private TValue UpValueB(Bytecode instr)
        {
            TValue upb = cl.upvals[(int)instr.B].v;
            return upb;
        }

        [DebuggerStepThrough]
        private TValue KBx(Bytecode i)
        {
            Debug.Assert(BytecodeTool.GetOpmode(i.Opcode).ArgBMode == OperandMode.OpArgK);
            return k[i.Bx];
        }

        #endregion 从指令取出参数的辅助方法
    }
}