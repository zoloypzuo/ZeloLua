using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
/// <summary>
/// 配置
/// 进度】完整地浏览了src，并且把应该搬运过来的都搬运过来了（包括注释，也阅读并裁剪过来了)，完成度99%
/// </summary>
namespace zlua.Configuration
{
    static class LuaConf
    {
        #region consts
        /// <summary>
        /// LUAI_MAXCALLS limits the number of nested calls.
        /// its only purpose is to stop infinite recursion before exhausting memory.
        /// </summary>
        public const int MaxCalls = 20000;
        /// <summary>
        /// LUAI_MAXCCALLS is the maximum depth for nested C calls (short) and
        /// </summary>
        public const int MaxCSharpCalls = 200;
        /// <summary>
        /// LUAI_MAXCSTACK limits the number of Lua stack slots that a C function can use.
        /// its only purpose is to stop C functions to consume unlimited stack space.(must be smaller than -LUA_REGISTRYINDEX)
        /// </summary>
        public const int LUAI_MAXCSTACK = 8000;
        /// <summary>
        /// LUAI_MAXUPVALUES is the maximum number of upvalues per function (must be smaller than 250).
        /// </summary>
        public const int MaxUpVals = 60;
        /// <summary>
        /// LUAI_MAXVARS is the maximum number of local variables per function (must be smaller than 250).
        /// </summary>
        public const int MaxNLocals = 200;
        #endregion
        #region functions
        public static double Add(double a, double b) => ((a) + (b));
        public static double Sub(double a, double b) => ((a) - (b));
        public static double Mul(double a, double b) => ((a) * (b));
        public static double Div(double a, double b) => ((a) / (b));
        public static double Mod(double a, double b) => a % b;     //((a) - Math.Floor((a) / (b)) * (b)); //src是这样实现的，没有用a%b
        public static double Pow(double a, double b) => (Math.Pow(a, b));
        public static double Unm(double a) => (-(a));
        public static bool Eq(double a, double b) => ((a) == (b));
        public static bool Lt(double a, double b) => ((a) < (b));
        public static bool Le(double a, double b) => ((a) <= (b));
        public static bool IsNaN(double a) => Double.IsNaN(a);// src使用 !(a==a)，是相对底层的方法，应该是一样的
        /// <summary>
        /// lua_number2integer, lua_number2int; 四舍五入
        /// </summary>
        public static int Double2Integer(double d) => (int)Math.Round(d, MidpointRounding.AwayFromZero);
        #endregion
    }
}
