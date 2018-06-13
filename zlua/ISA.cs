using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.DataModel;
using zlua.VM;
/// <summary>
/// 指令集和实现
/// </summary>
namespace zlua.ISA
{
    /// <summary>
    /// base class for all instructions 
    /// </summary>
    public abstract class AssembledInstr
    {
        protected List<lua_TValue> operands = new List<lua_TValue>();
        public abstract string ToString();
        /// <summary>
        /// differ from py ver: C# dont have meta programming, so must use polymorphic to implement visitor pattern
        /// and cause execution is in Instr env (IOC)
        /// </summary>
        /// <param name="thread"></param>
        public abstract void execute(lua_Thread thread);
    }
    class mov : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            var var_name = operands[0];
            Debug.Assert(var_name.is_tstring());
            thread.curr_func.local_data[var_name.str] = thread.curr_func.stack.Pop();
        }

        public override string ToString() => "mov " + string.Join(",", operands);
        public mov(string var_name)
        {
            operands.Add(lua_TValue.tstring_factory(var_name));
        }
    }
    class closure : AssembledInstr
    {
        public closure(int i)
        {
            operands.Add(lua_TValue.i_factory(i));
        }
        public override void execute(lua_Thread thread)
        {
            var compiled_func = lua_TValue.compiled_func_factory(thread.curr_func.func.inner_funcs[operands[0].i]);
            thread.push(compiled_func);
        }

        public override string ToString() => "closure " + string.Join(",", operands);

    }
    class call : AssembledInstr
    {
        public call(string func_name)
        {
            var var = lua_TValue.tstring_factory(func_name);
            operands.Add(var);
        }
        public override void execute(lua_Thread thread)
        {
            var callee = new RuntimeFunc(thread.curr_func.local_data[operands[0].str].compiled_func);
            callee.ret_addr = thread.pc;

            foreach (var item in callee.func.param_names) {
                callee.local_data[item] = thread.pop();
            }
            thread.stack.Push(callee);
            thread.pc = -1;
        }

        public override string ToString() => "call " + operands[0].str;
    }
    class ret : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            if (thread.curr_func.ret_addr == -1) {
                Console.WriteLine("Exit from Main");
                Environment.Exit(0);
            } else {
                thread.pc = thread.curr_func.ret_addr;
                var ret_val = thread.pop();
                thread.stack.Pop();
                thread.push(ret_val);
            }
        }

        public override string ToString() => "ret";
    }
    class add : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(a0 + a1);
        }

        public override string ToString() => "add ";
    }

    class mul : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(a0 * a1);
        }

        public override string ToString() => "mul ";
    }

    class eq : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(lua_TValue.eq(a0, a1));
        }

        public override string ToString() => "eq ";
    }

    class and : AssembledInstr
    {
        public override void execute(lua_Thread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(lua_TValue.and(a0, a1));
        }

        public override string ToString() => "and ";
    }

    class push_var : AssembledInstr
    {
        public push_var(string var_name)
        {
            var var = lua_TValue.tstring_factory(var_name);
            operands.Add(var);
        }
        public override void execute(lua_Thread thread)
        {
            var var = operands[0].str;
            var val = thread.curr_func.local_data[var];
            thread.push(val);
        }

        public override string ToString() => "push_var " + operands[0].str;
    }
    class push : AssembledInstr
    {
        public push(lua_TValue item)
        {
            operands.Add(item);
        }
        public override void execute(lua_Thread thread)
        {
            thread.push(operands[0]);
        }

        public override string ToString() => "push " + operands[0].ToString();
    }
    class pop : AssembledInstr
    {
        public pop()
        {

        }
        public override void execute(lua_Thread thread)
        {
            thread.pop();
        }


        public override string ToString() => "pop " + operands[0].ToString();
    }
}
