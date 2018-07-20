using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;

/// <summary>
/// 辅助库
/// </summary>
namespace zlua.AuxLib
{
    static class lauxlib
    {
        public static void loadfile(this TThread L,string filename)
        {

        }
        /// <summary>
        /// luaL_checkany
        /// </summary>
        public static void CheckAny(this TThread L,int n_arg)
        {
        }
        /// <summary>
        /// lua_CFunction
        /// </summary>
        public delegate void CSharpFunction(TThread L);
        /// <summary>
        /// lua_Reader
        /// </summary>
        public delegate string Reader(TThread L, object ud, int size);
        /// <summary>
        /// 
        /// </summary>
        public delegate void Writer(TThread L, object p, int size, object ud);
        /// <summary>
        /// lua_call
        /// </summary>
        public static void Call(TThread L,int n_args,int n_retvals)
        {

        }
    }
}
