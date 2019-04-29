// 运算符

using System;
using System.Diagnostics;

using zlua.Core.InstructionSet;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    public partial class lua_State
    {
        // 算术运算符和按位运算符
        //
        // 辅助函数，没什么为什么
        private void arith_op(
            Bytecode i,
            Func<lua_Number, lua_Number, lua_Number> op,
            TMS @event)
        {
            TValue ra = RA(i);
            TValue rb = RKB(i);
            TValue rc = RKC(i);
            lua_Number nb;
            lua_Number nc;
            bool b = tonumber(rb, out nb);
            bool c = tonumber(rc, out nc);
            if (b && c) {
                ra.N = op(nb, nc);
            } else if (call_binTM(rb, rc, ra, @event)) {
            } else {
                //luaG_aritherror(L, rb, rc);
                throw new Exception();
            }
        }

        private void Relation(Bytecode i, Func<TValue, TValue, bool> predicate)
        {
            TValue rb = RKB(i);
            TValue rc = RKC(i);
            if (predicate(rb, rc) != (i.A != 0)) {
                savedpc++;
            } else {
                savedpc += code[savedpc].SignedBx;
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
        public static lua_Number luai_nummod(lua_Number a, lua_Number b)
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

        public static lua_Number luai_numpow(lua_Number a, lua_Number b)
        {
            return Math.Pow(a, b);
        }

        /// 实现决策】不调用元方法的rawequal作为Equals重载，这个是调用的，单独写一个函数
        public bool equalobj(TValue o1, TValue o2)
        {
            return (o1.tt == o2.tt) && luaV_equalval(o1, o2);
        }

        public bool luaV_equalval(TValue t1, TValue t2)
        {
            TValue tm;
            Debug.Assert(t1.tt == t2.tt);
            switch (t1.tt) {
                case LuaTag.LUA_TNIL: return true;
                case LuaTag.LUA_TNUMBER: return t1.N == t2.N;
                case LuaTag.LUA_TBOOLEAN: return t1.B == t2.B;
                case LuaTag.LUA_TLIGHTUSERDATA: return Object.ReferenceEquals(t1.LightUserdata, t2.LightUserdata);
                case LuaTag.LUA_TUSERDATA: {
                        if (Object.ReferenceEquals(t1.Userdata, t2.Userdata)) {
                            return true;
                        }
                        tm = get_compTM(t1.Userdata.metatable, t2.Userdata.metatable, TMS.TM_EQ);
                        break;  /* will try TM */
                    }
                case LuaTag.LUA_TTABLE: {
                        if (Object.ReferenceEquals(t1.Table, t2.tt)) return true;
                        tm = get_compTM(t1.Table.metatable, t2.Table.metatable, TMS.TM_EQ);
                        break;  /* will try TM */
                    }
                default: return Object.ReferenceEquals(t1.gc, t2.gc);
            }
            if (tm == null) return false;  /* no TM? */
            callTMres(top, tm, t1, t2);  /* call TM */
            return !stack[top.index].IsFalse;
        }

        public bool luaV_lessthan(TValue l, TValue r)
        {
            if (l.tt != r.tt)
                //return luaG_ordererror(L, l, r);
                throw new Exception();
            else if (l.IsNumber)
                return l.N < r.N;
            else if (l.IsString)
                return l_strcmp(l.TStr, r.TStr) < 0;
            else {
                int res = call_orderTM(l, r, TMS.TM_LT);
                if (res != -1) {
                    return res == 1 ? false : true;
                } else {
                    //return luaG_ordererror(L, l, r);
                    throw new Exception();
                }
            }
        }

        private int l_strcmp(TString ls, TString rs)
        {
            string l = ls.str;
            int ll = ls.len;
            string r = rs.str;
            int lr = rs.len;
            for (; ; ) {
                // http://www.cplusplus.com/reference/cstring/strcoll/
                // https://docs.microsoft.com/en-us/dotnet/api/system.string.compare?view=netframework-4.8
                int temp = String.Compare(l, r);
                if (temp != 0) return temp;
                else {  /* strings are equal up to a `\0' */
                    int len = l.Length;  /* index of first `\0' in both strings */
                    if (len == lr)  /* r is finished? */
                        return (len == ll) ? 0 : 1;
                    else if (len == ll)  /* l is finished? */
                        return -1;  /* l is smaller than r (because r is not finished) */
                                    /* both strings longer than `len'; go on comparing (after the `\0') */
                    len++;
                    l += len; ll -= len; r += len; lr -= len;
                }
            }
        }

        private bool lessequal(TValue l, TValue r)
        {
            int res;
            if (l.tt != r.tt)
                //return luaG_ordererror(L, l, r);
                throw new Exception();
            else if (l.IsNumber)
                return l.N <= r.N;
            else if (l.IsString)
                return l_strcmp(l.TStr, r.TStr) <= 0;
            else if ((res = call_orderTM(l, r, TMS.TM_LE)) != -1)  /* first try `le' */
                return res == 1 ? true : false;
            else if ((res = call_orderTM(r, l, TMS.TM_LT)) != -1)  /* else try `lt' */
                return res == 0 ? true : false;
            else {
                //return luaG_ordererror(L, l, r);
                throw new Exception();
            }
        }
    }
}