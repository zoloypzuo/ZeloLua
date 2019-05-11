using ZoloLua.Library.AuxLib;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        /* Key to file-handle type */
        public const string LUA_FILEHANDLE = "FILE*";

        public const string LUA_COLIBNAME = "coroutine";
        public const string LUA_TABLIBNAME = "table";
        public const string LUA_IOLIBNAME = "io";
        public const string LUA_OSLIBNAME = "os";
        public const string LUA_STRLIBNAME = "string";
        public const string LUA_MATHLIBNAME = "math";
        public const string LUA_DBLIBNAME = "debug";
        public const string LUA_LOADLIBNAME = "package";

        public static readonly luaL_Reg[] lualibs = new luaL_Reg[]
        {
            //new luaL_Reg {name="", func=luaopen_base},
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
