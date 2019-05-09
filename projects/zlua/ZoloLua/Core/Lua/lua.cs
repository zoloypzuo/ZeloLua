using System;
using System.Diagnostics;
using System.IO;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;
using ZoloLua.Core.Undumper;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        // lua语言基本信息
        public const string LUA_VERSION = "Lua 5.1";
        public const string LUA_RELEASE = "Lua 5.1.4";
        public const int LUA_VERSION_NUM = 501;
        public const string LUA_COPYRIGHT = "Copyright (C) 1994-2008 Lua.org, PUC-Rio";
        public const string LUA_AUTHORS = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";


        /* mark for precompiled code (`<esc>Lua') */
        public const string LUA_SIGNATURE = "\x01bLua";

        /* option for multiple returns in `lua_pcall' and `lua_call' */
        public const int LUA_MULTRET = -1;


        /*
        ** pseudo-indices
        */
        public const int LUA_REGISTRYINDEX = -10000;
        public const int LUA_ENVIRONINDEX = -10001;
        public const int LUA_GLOBALSINDEX = -10002;


        /* thread status; 0 is OK */
        public const int LUA_YIELD = 1;
        public const int LUA_ERRRUN = 2;
        public const int LUA_ERRSYNTAX = 3;
        public const int LUA_ERRMEM = 4;
        public const int LUA_ERRERR = 5;

        /*
        ** basic types
        */
        public const int LUA_TNONE = -1;

        public const int LUA_TNIL = 0;
        public const int LUA_TBOOLEAN = 1;
        public const int LUA_TLIGHTUSERDATA = 2;
        public const int LUA_TNUMBER = 3;
        public const int LUA_TSTRING = 4;
        public const int LUA_TTABLE = 5;
        public const int LUA_TFUNCTION = 6;
        public const int LUA_TUSERDATA = 7;
        public const int LUA_TTHREAD = 8;


        /* minimum Lua stack available to a C function */
        public const int LUA_MINSTACK = 20;

        public static int lua_upvalueindex(int i) { return LUA_GLOBALSINDEX - i; }

        public static lua_State lua_open()
        {
            return luaL_newstate();
        }

        /// 注册一个C#函数，在lua代码中用name调用
        /// 被调用函数被包装成closure，在G中，key是`name
        /// no upval，你要自己设置（永远用不到）
        public void Register(lua_CFunction csFunc, string name)
        {
            CSharpClosure newFunc = new CSharpClosure
                { f = csFunc };
            gt.Table.luaH_getstr(name).Cl = newFunc;
        }

        /// <summary>
        ///     helper，帮助调试
        ///     直接用assert没法看a==b的a和b的值
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="expected"></param>
        /// <param name="acutal"></param>
        private void AssertEqual<T>(T expected, T acutal) where T : IEquatable<T>
        {
            Debug.Assert(expected.Equals(acutal));
        }

        private bool IsBinaryChunk(string path)
        {
            using (FileStream f = new FileStream(path, FileMode.Open)) {
                // TODO check and throw file open error
                char c = (char)f.ReadByte();
                return c == lundump.FirstChar;
            }
        }

    }
}