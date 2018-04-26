using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua {
    using TValue = Lua.lua_TValue;
    using StkId = Lua.lua_TValue;
    using lua_Number = System.Double;
    using lu_byte = System.Byte;
    using ptrdiff_t = System.Int32;
    using Instruction = System.UInt32;

    public partial class Lua {
        public static void luaV_execute(lua_Thread thread, int nexeccalls)
        {

        }
    }
}
