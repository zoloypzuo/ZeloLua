using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using Antlr4.Runtime;
using ZoloLua.Core.ObjectModel;
using ZoloLua.Core.Undumper;
using ZoloLua.Library.AuxLib;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        // 《Lua设计与实现》p39
        public void luaL_dofile(string path)
        {
            luaL_loadfile(path);
            //lua_pcall(0, LUA_MULTRET, 0);
            lua_call(0, LUA_MULTRET);
        }

        /// <summary>
        ///     zlua和clua这点不同，clua的dofile和dostring都会调用lua_load，后者用lookahead判断是否是二进制，再用parser或unudmp
        ///     zlua的dostring只能parse，不能undump
        ///     主要是ANTLRStream，太烦了
        /// </summary>
        /// <param name="s"></param>
        public void luaL_dostring(string s)
        {
            luaL_loadstring(s);
            //lua_pcall(0, LUA_MULTRET, 0);
            lua_call(0, LUA_MULTRET);
        }

        public void luaL_loadfile(string path)
        {
            Proto p;
            if (IsBinaryChunk(path)) {
                p = lundump.Undump(new FileStream(path, FileMode.Open));
                Table env = new Table(1, 1);
                env.luaH_set(new TValue("print")).Cl = new CSharpClosure
                {
                    // c print
                    f = L =>
                    {
                        // pop arg
                        TValue s = L.pop();
                        Debug.Assert(s.IsString);
                        Console.WriteLine(s.Str);
                        // return 0 result
                        return 0;
                    }
                };
                LuaClosure cl = new LuaClosure(env, 1, p);
                push(new TValue(cl));
            } else {
                lua_load(new AntlrFileStream(path, Encoding.UTF8), $"@{path}");
            }
        }

        public void luaL_loadstring(string s)
        {
            lua_load(new AntlrInputStream(s), s);
        }

        /// <summary>
        ///     构造新的lua解释器
        ///     与lua_open宏同义
        /// </summary>
        /// <returns></returns>
        /// <remarks>注意这和lua_State的ctor不同，比如要设置g.mainthread=this</remarks>
        public static lua_State luaL_newstate()
        {
            lua_State L = lua_newstate();
            //TODOlua_atpanic(L, &panic);
            return L;
        }

        public void luaL_openlibs()
        {
            luaL_Reg[] lib = lualibs;
            for (int i = 0; i < lib.Length; i++) {
                lua_pushcfunction(lib[i].func);
                lua_pushstring(lib[i].name);
                lua_call(1, 0);
            }
        }
    }
}