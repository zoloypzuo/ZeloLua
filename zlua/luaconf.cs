using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/// <summary>
/// 配置
/// </summary>
namespace zlua.Configuration
{
    using TNumber = Double;
    public static class luaconf
    {
        public const int MaxCalls = 200;
        public const int MaxRegs = 200;
        public const int MaxUpVals = 60;
        public static bool IsNaN(TNumber a) => !(a != a);
        /// <summary>
        /// lua_number2integer, lua_number2int; 四舍五入
        /// </summary>

                public static int Double2Integer(double d) => (int)Math.Round(d, MidpointRounding.AwayFromZero);
    }
}
