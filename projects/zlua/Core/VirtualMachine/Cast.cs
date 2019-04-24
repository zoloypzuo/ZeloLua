using System;

using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    // manual.html#3.4.3
    public partial class lua_State
    {
        // luaV_tonumber
        //
        // number直接返回
        // string尝试解析成number返回
        // 其他类型不能转换成number
        // 这里不要参考clua，写的很复杂很乱
        public static bool tonumber(TValue val, out lua_Number n)
        {
            switch (val.Type) {
                case LuaType.LUA_TNUMINT:
                    n = (double)val.I;
                    return true;

                case LuaType.LUA_TNUMBER:
                    n = val.N;
                    return true;

                case LuaType.LUA_TSTRING:
                    double outN;
                    bool b = TValue.Str2Num(val.Str, out outN);
                    n = outN;
                    return b;

                default:
                    n = 0;
                    return false;
            }
        }

        // luaV_tointeger
        public static bool tointeger(TValue val, out lua_Integer i)
        {
            switch (val.Type) {
                case LuaType.LUA_TNUMINT:
                    i = val.I;
                    return true;

                case LuaType.LUA_TNUMBER:
                    FloatToInteger(val.N, out i);
                    return true;

                case LuaType.LUA_TSTRING:
                    return lua_Integer.TryParse(val.Str, out i);

                default:
                    i = 0;
                    return false;
            }
        }

        // 浮点转整数时若溢出则返回false
        public static bool FloatToInteger(lua_Number n, out lua_Integer i)
        {
            bool b = true;
            try {
                i = (lua_Integer)n;
            }
            catch (OverflowException) {
                i = 0;
                b = false;
            }
            return b;
        }

        // TODO 删除此函数，使用LuaInteger.TryParse
        public static bool ParseInteger(string s, out lua_Integer i)
        {
            i = 0;
            return false;
        }
    }
}