using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
