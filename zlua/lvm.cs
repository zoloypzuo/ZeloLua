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
    /// <summary>
    /// vm
    /// </summary>
    public partial class Lua {
        class RuntimeFunc
        {
            public RuntimeFunc()
            {

            }
        }
        class Thread
        {
            public Thread()
            {

            }
            public void run()
            {

            }
        }
























        //public static void luaV_execute(lua_Thread thread, int nexeccalls)
        //{

        //}

    }
}
