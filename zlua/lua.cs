using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using zlua.API;
using zlua.TypeModel;
using zlua.VM;
using zlua.AuxLib;
namespace zlua
{
    /// <summary>
    /// differ from clua: const int... => enum
    /// </summary>
    public enum LuaTypes
    {
        None = -1,
        Nil = 0,
        Boolean = 1,
        LightUserdata = 2,
        Number = 3,
        String = 4,
        Table = 5,
        Function = 6,
        Userdata = 7,
        Thread = 8,
        /*extra tags*/
        Proto=9,
        Upval=10
    }
    /// <summary>
    /// lua接口
    /// </summary>
    public static class lua
    {
        public const string Version = "zlua 1.0, based on lua 5.1.4";
        /// <summary>
        /// luaL_dofile, luaB_dofile, dofile
        /// 实现决策】dofile在src中共有三处，luaB的实现简单，从luaD_call开始，lua.c的dofile不知道包装了什么鬼，不允许实现;但是lua.c是独立解释器，因此把实现放在这里
        /// </summary>
        /// <param name="path"></param>
        public static void DoFile(this TThread L, string path)
        {
            L.LoadFile(path);
            lapi.Call(L, 0, 0);
        }
        /// <summary>
        /// LUA_MULTRET, an option for lua_pcall and lua_call
        /// </summary>
        public const int MultiRet = -1;
        #region pseudo indicdes
        public const int RegisteyIndex = -10000;
        public const int EnvIndex = -10001;
        public const int GlobalsIndex = -10002;
        public static int UpvalIndex(int index) => GlobalsIndex - index;
        #endregion
        public static void GetGlobal(this TThread L, TString s) => L.GetField(GlobalsIndex, (string)s);
        public delegate int CSharpFunction(TThread L);
    }
}
