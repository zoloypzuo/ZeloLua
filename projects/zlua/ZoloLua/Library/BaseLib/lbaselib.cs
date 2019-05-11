using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ZoloLua.Core.Lua;
using ZoloLua.Core.TypeModel;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        private static int luaB_assert(lua_State L)
        {
            //luaL_checkany(L, 1);
            if (!L.lua_toboolean(1))
                throw new Exception();
            //return luaL_error(L, "%s", luaL_optstring(L, 2, "assertion failed!"));
            return L.lua_gettop();
        }

        static int luaB_print(lua_State L)
        {
            //int n = lua_gettop(L);  /* number of arguments */
            //int i;
            //lua_getglobal(L, "tostring");
            //for (i = 1; i <= n; i++) {
            //    const char* s;
            //    lua_pushvalue(L, -1);  /* function to be called */
            //    lua_pushvalue(L, i);   /* value to print */
            //    lua_call(L, 1, 1);
            //    s = lua_tostring(L, -1);  /* get result */
            //    if (s == NULL)
            //        return luaL_error(L, LUA_QL("tostring") " must return a string to "

            //                             LUA_QL("print"));
            //    if (i > 1) fputs("\t", stdout);
            //    fputs(s, stdout);
            //    lua_pop(L, 1);  /* pop result */
            //}
            //fputs("\n", stdout);
            //return 0;

            // pop arg
            TValue s = L.pop();
            Console.WriteLine(s.ToString());
            // return 0 result
            return 0;
        }
        static int luaB_setmetatable(lua_State L)
        {
            LuaType t = L.lua_type(2);
            //luaL_checktype(L, 1, LUA_TTABLE);
            //luaL_argcheck(L, t == LUA_TNIL || t == LUA_TTABLE, 2,
            //                  "nil or table expected");
            if (L.luaL_getmetafield(1, "__metatable"))
                throw new Exception();
            //luaL_error(L, "cannot change a protected metatable");
            L.lua_settop(2);
            L.lua_setmetatable(1);
            return 1;
        }

        public int luaopen_base()
        {
            //base_open();
            //luaL_register(LUA_COLIBNAME, co_funcs);
            return 2;
        }

        private void base_open()
        {
            ///* set global _G */
            //lua_pushvalue(L, LUA_GLOBALSINDEX);
            //lua_setglobal(L, "_G");
            ///* open lib into global table */
            //luaL_register(L, "_G", base_funcs);
            //lua_pushliteral(L, LUA_VERSION);
            //lua_setglobal(L, "_VERSION");  /* set global _VERSION */
            //                               /* `ipairs' and `pairs' need auxliliary functions as upvalues */
            //auxopen(L, "ipairs", luaB_ipairs, ipairsaux);
            //auxopen(L, "pairs", luaB_pairs, luaB_next);
            ///* `newproxy' needs a weaktable as upvalue */
            //lua_createtable(L, 0, 1);  /* new table `w' */
            //lua_pushvalue(L, -1);  /* `w' will be its own metatable */
            //lua_setmetatable(L, -2);
            //lua_pushliteral(L, "kv");
            //lua_setfield(L, -2, "__mode");  /* metatable(w).__mode = "kv" */
            //lua_pushcclosure(L, luaB_newproxy, 1);
            //lua_setglobal(L, "newproxy");  /* set global `newproxy' */
        }
    }
}
