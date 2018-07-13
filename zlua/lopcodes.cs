using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
/// <summary>
/// 指令集和实现
/// </summary>
namespace zlua.ISA
{
    /// <summary>
    /// byte code instruction
    /// </summary>
    public class Instruction
    {
        int i;
        Instruction(int i)
        {
            this.i = i;
        }
        public Instruction(Opcodes opcode, int A, int B, int C)
        {
            i = (int)opcode << pos_Op | A << pos_A | B << pos_B | C << pos_C;
        }
        public Instruction(Opcodes opcode, int A, int Bx)
        {
            i = (int)opcode << pos_Op | A << pos_A | Bx << pos_Bx;
        }
        public static implicit operator int(Instruction i) => i.i;
        public static implicit operator Instruction(int i) => new Instruction(i);
        #region size and position of instruction arguments

        const int size_C = 9;
        const int size_B = 9;
        const int size_Bx = size_C + size_B;
        const int size_A = 8;
        const int size_Op = 6;

        const int pos_Op = 0;
        const int pos_A = pos_Op + size_Op;
        const int pos_C = pos_A + size_A;
        const int pos_B = pos_C + size_C;
        const int pos_Bx = pos_C;

        #endregion

        #region max size of instrucion arguments

        const int max_argBx = (1 << size_Bx) - 1; // 1. "<<" is less prior to "-" 2. "1<<n" = 2**n 
        const int max_argsBx = max_argBx >> 1;
        const int max_argA = (1 << size_A) - 1;
        const int max_argB = (1 << size_B) - 1;
        const int max_argC = (1 << size_C) - 1;
        #endregion
        #region getter and setter of instruction
        static int mask1(int n, int pos) => (~((~0) << n)) << pos;
        static int mask0(int n, int pos) => ~mask0(n, pos);
        static int get(int i, int n, int pos) => (i >> pos) & mask1(n, pos);
        static void set(ref int i, int x, int n, int pos) => i = i & mask0(n, pos) | (x << pos) & mask1(n, pos);

        public Opcodes opcode
        {
            get => (Opcodes)get(i, size_Op, pos_Op);
            set => set(ref i, (int)value, size_Op, pos_Op);
        }

        public int A
        {
            get => get(i, size_A, pos_A);
            set => set(ref i, value, size_A, pos_A);
        }

        public int B
        {
            get => get(i, size_B, pos_B);
            set => set(ref i, value, size_B, pos_B);
        }

        public int C
        {
            get => get(i, size_C, pos_C);
            set => set(ref i, value, size_C, pos_C);
        }

        public int Bx
        {
            get => get(i, size_Bx, pos_Bx);
            set => set(ref i, value, size_Bx, pos_Bx);
        }

        public int sBx
        {
            get => Bx - max_argsBx;
            set => Bx = value + max_argsBx;
        }
        #endregion
        #region other things
        const int n_opcodes = (int)Opcodes.VarArg + 1;
        /// <summary>
        /// if x[7] (in bit) is 1, return true, and RKB returns KB
        /// </summary>
        /// <param name="x">B or C</param>
        /// <returns></returns>
        public static bool is_k(int x) => (x & (1 << (size_B - 1)))!=0;
        public static int index_k(int x)=>x&~(1 << (size_B - 1));
        #endregion
    }

    public enum Opcodes
    {
        Move,
        LoadK,
        LoadBool,
        LoadNil,
        GetUpVal,
        GetGlobal,
        GetTable,
        SetGlobal,
        SetUpval,
        SetTable,
        NewTable,
        Self,
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        Pow,
        Unm,
        Not,
        Len,
        Concat,
        Jmp,
        Eq,
        Lt,
        Le,
        Test,
        Testset,
        Call,
        TailCall,
        Return,
        ForLoop,
        ForPrep,
        TForLoop,
        SetList,
        Close,
        Closure,
        VarArg,

        And,
        PushVar,
        Push,
        Pop,
    }

    /// <summary>
    /// base class for all instructions 
    /// </summary>
    public abstract class AssembledInstr
    {
        protected List<TValue> operands = new List<TValue>();
        public new abstract string ToString();
        /// <summary>
        /// differ from py ver: C# dont have meta programming, so must use polymorphic to implement visitor pattern
        /// and cause execution is in Instr env (IOC)
        /// </summary>
        /// <param name="thread"></param>
        public abstract void execute(TThread thread);
    }
    class mov : AssembledInstr
    {
        public override void execute(TThread thread)
        {
            var var_name = operands[0];
            Debug.Assert(var_name.tt_is_string);
            thread.curr_func.local_data[var_name] = thread.curr_func.stack.Pop();
        }

        public override string ToString() => "mov " + string.Join(",", operands);
        public mov(string var_name)
        {
            operands.Add(var_name);
        }
    }
    class closure : AssembledInstr
    {
        public closure(int i)
        {
            operands.Add(i);
        }
        public override void execute(TThread thread)
        {
            var compiled_func = TValue.compiled_func_factory(thread.curr_func.func.inner_funcs[operands[0]]);
            thread.push(compiled_func);
        }

        public override string ToString() => "closure " + string.Join(",", operands);

    }
    class call : AssembledInstr
    {
        public call(string func_name)
        {
            operands.Add(func_name);
        }
        public override void execute(TThread thread)
        {
            var callee = new Closure(thread.curr_func.local_data[operands[0]].Proto);
            callee.ret_addr = thread.pc;

            foreach (var item in callee.func.param_names) {
                callee.local_data[new TString(item)] = thread.pop();
            }
            thread.stack.Push(callee);
            thread.pc = -1;
        }

        public override string ToString() => "call " + operands[0];
    }
    class ret : AssembledInstr
    {
        public override void execute(TThread thread)
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
        public override void execute(TThread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(a0 + a1);
        }

        public override string ToString() => "add ";
    }

    class mul : AssembledInstr
    {
        public override void execute(TThread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(a0 * a1);
        }

        public override string ToString() => "mul ";
    }

    class eq : AssembledInstr
    {
        public override void execute(TThread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(TValue.eq(a0, a1));
        }

        public override string ToString() => "eq ";
    }

    class and : AssembledInstr
    {
        public override void execute(TThread thread)
        {
            var a0 = thread.pop();
            var a1 = thread.pop();
            thread.push(TValue.and(a0, a1));
        }

        public override string ToString() => "and ";
    }

    class push_var : AssembledInstr
    {
        public push_var(string var_name)
        {
            operands.Add(var_name);
        }
        public override void execute(TThread thread)
        {
            var var = operands[0];
            var val = thread.curr_func.local_data[var];
            thread.push(val);
        }

        public override string ToString() => "push_var " + operands[0];
    }
    class push : AssembledInstr
    {
        public push(TValue item)
        {
            operands.Add(item);
        }
        public override void execute(TThread thread)
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
        public override void execute(TThread thread)
        {
            thread.pop();
        }


        public override string ToString() => "pop " + operands[0].ToString();
    }
}
