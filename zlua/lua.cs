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
using System.Diagnostics;
using zlua.ISA;
namespace zlua
{
    /// <summary>
    /// 见鬼了异常，因为有些分支根本不可能走到，用于占位
    /// </summary>
    class GodDamnException : Exception { }
    /// <summary>
    /// 错误的操作数类型，我们用opcode作为提示
    /// </summary>
    class OprdTypeException : Exception
    {
        public OprdTypeException(Op opcode) : base(opcode.ToString() + "错误的操作数") { }
    }
    class Assert
    {
        /// <summary>
        /// 替代单元测试的该函数，因为一般的没法。对于内部的类，仍然需要测试。
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="expected"></param>
        /// <param name="actual"></param>
        internal static void AreEqual<T>(T expected, T actual)
        {
            Debug.Assert(expected.Equals(actual));
        }
    }
    interface ITest
    {
        /// <summary>
        /// 在这个函数中测试所有Test*函数
        /// </summary>
        void Test();
    }
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
        /// <summary>
        /// C and Lua functions
        /// </summary>
        Function = 6,
        Userdata = 7,
        Thread = 8,
        /*extra tags*/
        Proto = 9,
        Upval = 10
    }
    /// <summary>
    /// lua接口
    /// </summary>
    public static class Lua
    {
        public const string Version = "zlua 1.0, based on lua 5.1.4";
        /// <summary>
        /// luaL_dofile, luaB_dofile, dofile
        /// 实现决策】dofile在src中共有三处，luaB的实现简单，从luaD_call开始，lua.c的dofile不知道包装了什么鬼，不允许实现;但是lua.c是独立解释器，因此把实现放在这里
        /// </summary>
        public static void DoFile(this TThread L, string path)
        {
            L.LoadFile(path);
            LApi.Call(L, nArgs: 0, nRetvals: 0);
        }
        public static void DoString(this TThread L,string luaCode)
        {
            L.LoadString(luaCode);
            LApi.Call(L, nArgs: 0, nRetvals: 0);
        }
        /// <summary>
        /// LUA_MULTRET, an option for lua_pcall and lua_call；两处引用。最好能删掉
        /// </summary>
        public const int MultiRet = -1;
        #region 伪索引（pseudo indicdes），预计会删掉。
        public const int RegisteyIndex = -10000;
        public const int EnvIndex = -10001;
        public const int GlobalsIndex = -10002;
        public static int UpvalIndex(int index) => GlobalsIndex - index;
        #endregion

        public delegate int CSharpFunction(TThread L);

    }
}
