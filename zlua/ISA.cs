using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua
{
    /// <summary>
    /// ISA
    /// </summary>
    partial class Lua
    {
        public abstract class AssembledInstr
        {
            protected List<lua_TValue> operands=new List<lua_TValue>();
            public abstract string ToString();
            /// <summary>
            /// differ from py ver: C# dont have meta programming, so must use 多态 to implement visitor pattern
            /// and cause execution is in Instr env (IOC)
            /// </summary>
            /// <param name="thread"></param>
            public abstract void execute(lua_Thread thread);
        }
        public class mov : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {
                var var_name = operands[0];
                Debug.Assert(var_name.is_tstring());
                thread.curr_func.local_data[var_name.value.gcobject.tstring.str] = thread.curr_func.stack.Pop();
            }

            public override string ToString() => "mov " + string.Join(",", operands);
            public mov(lua_TValue var_name)
            {
                operands.Add(var_name);
            }
        }
        public class closure : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {
                var compiled_func = Lua.lua_TValue.CompiledFunc(thread.curr_func.func.inner_funcs[operands[0].value.i]);
                thread.push(compiled_func);
            }

            public override string ToString() => "closure " + string.Join(",", operands);

        }
        public class call : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {
                var callee = thread.curr_func.local_data[operands[0].value.gcobject.tstring.str];
                callee.
            }

            public override string ToString()
            {

            }
        }
        public class ret : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }
        public class load_arg : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }
        public class load_ret_val : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }
        public class add : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }

        public class mul : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }

        public class eq : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }

        public class and : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }

        public class push_var : AssembledInstr
        {
            public override void execute(lua_Thread thread)
            {

            }

            public override string ToString()
            {

            }
        }
    }
}
