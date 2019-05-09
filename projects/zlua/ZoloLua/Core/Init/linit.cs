using ZoloLua.Library.AuxLib;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        public static readonly luaL_Reg[] lualibs = new luaL_Reg[]
        {
            //{"", luaopen_base},
            //{LUA_LOADLIBNAME, luaopen_package},
            //{LUA_TABLIBNAME, luaopen_table},
            //{LUA_IOLIBNAME, luaopen_io},
            //{LUA_OSLIBNAME, luaopen_os},
            //{LUA_STRLIBNAME, luaopen_string},
            //{LUA_MATHLIBNAME, luaopen_math},
            //{LUA_DBLIBNAME, luaopen_debug},
        };
    }
}
