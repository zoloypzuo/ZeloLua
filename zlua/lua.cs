using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//using zlua.API;
using zlua.TypeModel;
using zlua.VM;
using System.Diagnostics;
using zlua.ISA;
using zlua.CallSystem;
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
        /// 在这个函数中测试所有`Test*函数
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

        public static void DoFile(this TThread L, string path)
        {
            //L.LoadFile(path);
            LDo.Call(L, 0);
        }
        public static void DoString(this TThread L, string luaCode)
        {
            //L.LoadString(luaCode);
            LDo.Call(L, 0);
        }
        /// <summary>
        /// 注册一个C#函数，在lua代码中用name调用
        /// 被调用函数被包装成closure，在G中，key是`name
        /// no upval，你要自己设置（永远用不到）
        /// </summary>
        public static void Register(this TThread L, CSFunc csFunc, string name)
        {
            var newFunc = new CSharpClosure() { f = csFunc };
            ((TTable)L.globalsTable).GetByStr((TString)name).Cl = newFunc;
        }
        /// <summary>
        /// 基于L.top，压函数，压args，返回1个值
        /// </summary>
        /// <param name="L"></param>
        public delegate void CSFunc(TThread L);
    }
}
