using System;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Core.VirtualMachine
{
    // manual.html#3.4.3
    public partial class lua_State
    {


        // luaV_tointeger
        public static bool tointeger(TValue val, out lua_Integer i)
        {
            switch (val.tt) {
                case LuaTag.LUA_TNUMBER:
                    FloatToInteger(val.N, out i);
                    return true;

                case LuaTag.LUA_TSTRING:
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