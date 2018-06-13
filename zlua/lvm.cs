using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.DataModel;
/// <summary>
/// 虚拟机
/// </summary>
namespace zlua.VM
{

    public class lua_Thread : GCObject
    {
        RuntimeFunc rt_main_func;
        public Stack<RuntimeFunc> stack = new Stack<RuntimeFunc>();
        public Dictionary<string, lua_TValue> global_data;
        public int pc = 0;
        public lua_Thread(CompiledFunction main_func)
        {
            rt_main_func = new RuntimeFunc(main_func) { ret_addr = -1 };
            global_data = rt_main_func.local_data;
            stack.Push(rt_main_func);
        }
        public void run()
        {
            while (true) {
                var curr_instr = curr_func.func.instrs[pc];
                curr_instr.execute(this);
                pc++;
            }
        }
        public RuntimeFunc curr_func => stack.Peek();
        public void push(lua_TValue item) => curr_func.stack.Push(item);
        public lua_TValue pop() => curr_func.stack.Pop();
    }
}
