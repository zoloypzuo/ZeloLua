// 运算符

using System;
using System.Diagnostics;
using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    public partial class lua_State
    {
        // 算术运算符和按位运算符
        //
        // 辅助函数，没什么为什么
        private void Arith(
            Bytecode instr,
            Func<lua_Integer, lua_Integer, lua_Integer> IOp,
            Func<lua_Number, lua_Number, lua_Number> FOp,
            TMS @event)
        {
            TValue ra = RA(instr);
            TValue rb = RKB(instr);
            TValue rc = RKC(instr);
            if (rb.IsInteger && rc.IsInteger) {
                ra.I = IOp(rb.I, rc.I);
            } else {
                lua_Number nb;
                lua_Number nc;
                bool b = tonumber(rb, out nb);
                bool c = tonumber(rc, out nc);
                if (b && c) {
                    ra.N = FOp(nb, nc);
                } else {
                    trybinTM(rb, rc, ra, @event);
                }
            }
        }

        private void Arith(
            Bytecode instr,
            Func<lua_Integer, lua_Integer, lua_Integer> IOp,
            TMS @event)
        {
            TValue ra = RA(instr);
            TValue rb = RKB(instr);
            TValue rc = RKC(instr);
            if (rb.IsInteger && rc.IsInteger) {
                ra.I = IOp(rb.I, rc.I);
            } else {
                trybinTM(rb, rc, ra, @event);
            }
        }

        void Arith(
            Bytecode instr,
            Func<lua_Number, lua_Number, lua_Number> FOp,
            TMS @event)
        {
            TValue ra = RA(instr);
            TValue rb = RKB(instr);
            TValue rc = RKC(instr);
            lua_Number nb;
            lua_Number nc;
            bool b = tonumber(rb, out nb);
            bool c = tonumber(rc, out nc);
            if (b && c) {
                ra.N = FOp(nb, nc);
            } else {
                trybinTM(rb, rc, ra, @event);
            }
        }

        void Relation(Bytecode instr, Func<TValue, TValue, bool> predicate)
        {
            TValue rb = RKB(instr);
            TValue rc = RKC(instr);
            if (predicate(rb, rc) != (instr.A != 0)) {
                pc++;
            } else {
                int a = (int)instr.A;
                if (a != 0) {
                    //  luaF_close(L, ci->u.l.base + a - 1);
                }
                pc += instr.SignedBx + 1;
            }

        }

        // int floor div
        public static lua_Integer IFloorDiv(lua_Integer a, lua_Integer b)
        {
            if (a > 0 & b > 0 || a < 0 && b < 0 || a % b == 0) {
                return a / b;
            } else {
                return a / b - 1;
            }
        }

        // float floor div
        public static lua_Number FFloorDiv(lua_Number a, lua_Number b)
        {
            return Math.Floor(a / b);
        }

        // int mod
        public static lua_Integer IMod(lua_Integer a, lua_Integer b)
        {
            return a - IFloorDiv(a, b) * b;
        }

        // float mod
        public static lua_Number FMod(lua_Number a, lua_Number b)
        {
            return a - Math.Floor(a / b) * b;
        }

        public static lua_Integer ShiftLeft(lua_Integer a, lua_Integer n)
        {
            return a << (int)n;
        }

        public static lua_Integer ShiftRight(lua_Integer a, lua_Integer n)
        {
            return a >> (int)n;
        }

        public static lua_Number Pow(lua_Number a, lua_Number b)
        {
            return Math.Pow(a, b);
        }

        // luaV_objlen
        //
        // Main operation 'ra' = #rb'.
        public static void objlen(TValue ra, TValue rb)
        {
            TValue tm;
            switch (rb.Type) {
                case LuaType.LUA_TTABLE: {
                        Table h = rb.Table;
                        // TODO
                        //tm = fasttm(L, h->metatable, TM_LEN);
                        //if (tm) break;  /* metamethod? break switch to call it */
                        //setivalue(ra, luaH_getn(h));  /* else primitive len */
                        return;
                    }
                case LuaType.LUA_TSHRSTR: {
                        // TODO setivalue(ra, tsvalue(rb)->shrlen);
                        ra.I = rb.Str.Length;
                        return;
                    }
                case LuaType.LUA_TLNGSTR: {
                        // TODO setivalue(ra, tsvalue(rb)->u.lnglen);
                        ra.I = rb.Str.Length;
                        return;
                    }
                default: { /* try metamethod */
                        //tm = luaT_gettmbyobj(L, rb, TM_LEN);
                        //if (ttisnil(tm))  /* no metamethod? */
                        //    luaG_typeerror(L, rb, "get length of");
                        break;
                    }
            }
            //luaT_callTM(L, tm, rb, rb, ra, 1);
        }

        // luaV_concat
        /*
        ** Main operation for concatenation: concat 'total' values in the stack,
        ** from 'L->top - total' up to 'L->top - 1'.
        */
        // TODO 太复杂了
        public void concat(int total)
        {
            Debug.Assert(total >= 2);
            //do {
            int n = 2;  /* number of elements handled in this pass (at least 2) */
            var o = Stack[top - 2];
            if (!(o.IsString) || o.IsNumber || !Stack[top - 1].IsString)
                trybinTM(Stack[top - 2], Stack[top - 1], Stack[top - 2], TMS.TM_CONCAT);
            //else if (isemptystr(top - 1))  /* second operand is empty? */
            //  cast_void(tostring(L, top - 2));  /* result is first operand */
            //else if (isemptystr(top - 2)) {  /* first operand is an empty string? */
            //  setobjs2s(L, top - 2, top - 1);  /* result is second op. */
            //    }
            //    else {
            //        /* at least two non-empty string values; get as many as possible */
            //        int tl = Stop - 1);
            //        TString* ts;
            //        /* collect total length and number of strings */
            //        for (n = 1; n < total && tostring(L, top - n - 1); n++) {
            //            size_t l = vslen(top - n - 1);
            //            if (l >= (MAX_SIZE / sizeof(char)) - tl)
            //                luaG_runerror(L, "string length overflow");
            //            tl += l;
            //        }
            //        if (tl <= LUAI_MAXSHORTLEN) {  /* is result a short string? */
            //            char buff[LUAI_MAXSHORTLEN];
            //            copy2buff(top, n, buff);  /* copy strings to buffer */
            //            ts = luaS_newlstr(L, buff, tl);
            //        } else {  /* long string; copy strings directly to final result */
            //            ts = luaS_createlngstrobj(L, tl);
            //            copy2buff(top, n, getstr(ts));
            //        }
            //        setsvalue2s(L, top - n, ts);  /* create result */
            //    }
            //    total -= n - 1;  /* got 'n' strings to create 1 new */
            //    L->top -= n - 1;  /* popped 'n' strings and pushed one */
            //} while (total > 1);  /* repeat until only 1 result left */
        }

        /// equalobj
        /// 实现决策】不调用元方法的rawequal作为Equals重载，这个是调用的，单独写一个函数
        public bool EqualObj(TValue o1, TValue o2) => (o1.Type == o2.Type) && EqualVal(o1, o2);

        /// luaV_equalval
        public bool EqualVal(TValue t1, TValue t2)
        {
            Debug.Assert(t1.Type == t2.Type);
            switch (t1.Type) {
                case LuaType.LUA_TNIL: return true;
                case LuaType.LUA_TNUMBER: return t1.N == t2.N;
                case LuaType.LUA_TBOOLEAN: return t1.B == t2.B; //为什么cast多余，不应该啊。要么得改成字段访问
                case LuaType.LUA_TUSERDATA: return false;//TODO 有meta方法
                case LuaType.LUA_TTABLE: {
                        if (t1.Table == t2.Table)
                            return true;
                        return false;//TODO metatable compare
                    }
                default:
                    return t1.ReferenceValue == t2.ReferenceValue;
                    //TODO metatable compare???
            }
        }
    }
}
