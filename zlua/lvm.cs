using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua
{
    //using TValue = Lua.lua_TValue;
    //using StkId = Lua.lua_TValue;
    using lua_Number = System.Double;
    using lu_byte = System.Byte;
    using ptrdiff_t = System.Int32;
    using Instruction = System.UInt32;
    /// <summary>
    /// vm
    /// </summary>
    public partial class Lua
    {

        public class lua_Thread : GCObject
        {
            RuntimeFunc rt_main_func;
            public Stack<RuntimeFunc> stack = new Stack<RuntimeFunc>();
            public Dictionary<string, lua_TValue> global_data;
            public int pc = 0;
            public lua_Thread(CompiledFunction main_func)
            {
                rt_main_func = new RuntimeFunc(main_func);
                global_data = rt_main_func.local_data;
                stack.Push(rt_main_func);
            }
            public RuntimeFunc curr_func { get { return stack.Peek(); } }
            public void run()
            {
                while (true)
                {
                    var curr_instr = curr_func.func.instrs[pc];
                    curr_instr.execute(this);
                    pc++;
                }
            }
        }
























        //public static void luaV_execute(lua_Thread thread, int nexeccalls)
        //{

        //}

    }
}
