using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.ISA;
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
        Closure rt_main_func;
        public Stack<Closure> stack = new Stack<Closure>();
        public Dictionary<TString, TValue> global_data;
        public int pc = 0;

        public List<TValue> _stack;
        /// <summary>
        /// = callinfo_stack.top().top 
        /// </summary>
        public int top { get; } //StkId top, but you know, use "pointer + int" to get array element
        /// <summary>
        /// = callinfo_stack.top()._base
        /// </summary>
        public int _base { get; }
        CallInfo curr_callinfo { get; }
        public Stack<CallInfo> callinfo_stack;


        public TThread(Proto main_func)
        {
            rt_main_func = new Closure(main_func) { ret_addr = -1 };
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
        /// <summary>
        /// TODO 这是一个重新开始的地方，命名可以稍微参考一下。但是指令集要思考一下。要紧凑。理论上和寄存器式应该是一致的
        /// </summary>
        public void new_run(int level)
        {
            while (true) {
                const Instruction pc = 1;
            }
            //var curr_instr = curr_func.func.instrs[pc];
            //var opcode = opcode(curr_instr);
            //switch(opcode) {
            //    case Mov:
            //        foo;
            //        continue;
            //    case ...
            //}
        }
        public Closure curr_func => stack.Peek();
        public void push(TValue item) => curr_func.stack.Push(item);
        public TValue pop() => curr_func.stack.Pop();


        public void load_file(string fn) { }
        public void pcall(int n_args, int n_retvals)
        {
            var cs = new CallS();
            cs.func = _stack[top - (n_args + 1)];
        }
        public void pre_call()
        {
            //TODO save pc to caller CallInfo, create new CallInfo for callee
        }
        public void pos_call()
        {

        }
        public void single_var_aux()
        {
            // in parse stage, use tree<FuncState> to find reference of variable:
            //            a.local scope/ curr func => local var

            //        b.outer scope/ enclosing func => upvalue
            //the outest/ virtual main/ global scope => global var
        }
    }
    /// <summary>
    /// protected call
    /// </summary>
    public class CallS { public TValue func; public int n_retvals; }
    public class CallInfo
    {
        public TValue func;
        public int _base; // = func+1
        public int top;
    }
}
