using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
/// <summary>
/// 虚拟机
/// </summary>
namespace zlua.VM
{
    /*<lua_src>struct lua_State;</lua_src>*/
    /// <summary>
    /// TODO，thread整合入lobject
    /// </summary>
    public class TThread : GCObject
    {
        RuntimeFunction rt_main_func;
        public Stack<RuntimeFunction> stack = new Stack<RuntimeFunction>();
        public Dictionary<TString, TValue> global_data;
        public int pc = 0;
        public TThread(CompiledFunction main_func)
        {
            rt_main_func = new RuntimeFunction(main_func) { ret_addr = -1 };
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
        public RuntimeFunction curr_func => stack.Peek();
        public void push(TValue item) => curr_func.stack.Push(item);
        public TValue pop() => curr_func.stack.Pop();
    }
}
