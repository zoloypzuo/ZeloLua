using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    // manual.html#3.4.3
    public partial class LuaState
    {
        // luaV_tonumber
        //
        // number直接返回
        // string尝试解析成number返回
        // 其他类型不能转换成number
        // 这里不要参考clua，写的很复杂很乱
        public static bool tonumber(LuaValue val, out LuaNumber n)
        {
            switch (val.Type) {
                case LuaTypes.Integer:
                    n = (double)val.I;
                    return true;
                case LuaTypes.Number:
                    n = val.N;
                    return true;
                case LuaTypes.String:
                    double outN;
                    bool b = LuaValue.Str2Num(val.Str, out outN);
                    n = outN;
                    return b;
                default:
                    n = 0;
                    return false;
            }
        }

        // luaV_tointeger
        public static bool tointeger(LuaValue val, out LuaInteger i)
        {
            switch (val.Type) {
                case LuaTypes.Integer:
                    i = val.I;
                    return true;
                case LuaTypes.Number:
                    FloatToInteger(val.N, out i);
                    return true;
                case LuaTypes.String:
                    return LuaInteger.TryParse(val.Str, out i);
                default:
                    i = 0;
                    return false;
            }
        }

        // 浮点转整数时若溢出则返回false
        public static bool FloatToInteger(LuaNumber n, out LuaInteger i)
        {
            bool b = true;
            try {
                i = (LuaInteger)n;
            }
            catch (OverflowException) {
                i = 0;
                b = false;
            }
            return b;
        }

        // TODO 删除此函数，使用LuaInteger.TryParse
        public static bool ParseInteger(string s, out LuaInteger i)
        {
            i = 0;
            return false;
        }
    }
}
