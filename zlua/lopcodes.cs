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
    using Instruction = UInt32;
    /* <lua_src> enum OpMode {iABC, iABx, iAsBx};  </lua_src>*/
    public enum OpMode { iABC, iABx, iAsBx }
    class ISA
    {
        #region size and position of instruction arguments
        /* <lua_src>
            #define SIZE_C		9
            #define SIZE_B		9
            #define SIZE_Bx		(SIZE_C + SIZE_B)
            #define SIZE_A		8

            #define SIZE_OP		6

            #define POS_OP		0
            #define POS_A		(POS_OP + SIZE_OP)
            #define POS_C		(POS_A + SIZE_A)
            #define POS_B		(POS_C + SIZE_C)
            #define POS_Bx		POS_C
        </lua_src>*/
        public const int size_C = 9;
        public const int size_B = 9;
        public const int size_Bx = size_C + size_B;
        public const int size_A = 8;
        public const int size_Op = 6;

        public const int pos_Op = 0;
        public const int pos_A = pos_Op + size_Op;
        public const int pos_C = pos_A + size_A;
        public const int pos_B = pos_C + size_C;
        public const int pos_Bx = pos_C;

        #endregion

        #region max size of instrucion arguments
        /* <lua_src>
            #if SIZE_Bx < LUAI_BITSINT-1
            #define MAXARG_Bx        ((1<<SIZE_Bx)-1)
            #define MAXARG_sBx        (MAXARG_Bx>>1)        
            #else
            #define MAXARG_Bx        MAX_INT
            #define MAXARG_sBx        MAX_INT
            #endif


            #define MAXARG_A        ((1<<SIZE_A)-1)
            #define MAXARG_B        ((1<<SIZE_B)-1)
            #define MAXARG_C        ((1<<SIZE_C)-1)
        </lua_src>*/

        #endregion
        #region getter and setter of instruction
        /* <lua_src>
            #define GET_OPCODE(i)	(cast(OpCode, ((i)>>POS_OP) & MASK1(SIZE_OP,0)))
            #define SET_OPCODE(i,o)	((i) = (((i)&MASK0(SIZE_OP,POS_OP)) | \
                    ((cast(Instruction, o)<<POS_OP)&MASK1(SIZE_OP, POS_OP))))

            #define GETARG_A(i)	(cast(int, ((i)>>POS_A) & MASK1(SIZE_A,0)))
            #define SETARG_A(i,u)	((i) = (((i)&MASK0(SIZE_A,POS_A)) | \
		            ((cast(Instruction, u)<<POS_A)&MASK1(SIZE_A, POS_A))))

            #define GETARG_B(i)	(cast(int, ((i)>>POS_B) & MASK1(SIZE_B,0)))
            #define SETARG_B(i,b)	((i) = (((i)&MASK0(SIZE_B,POS_B)) | \
		            ((cast(Instruction, b)<<POS_B)&MASK1(SIZE_B, POS_B))))

            #define GETARG_C(i)	(cast(int, ((i)>>POS_C) & MASK1(SIZE_C,0)))
            #define SETARG_C(i,b)	((i) = (((i)&MASK0(SIZE_C,POS_C)) | \
		            ((cast(Instruction, b)<<POS_C)&MASK1(SIZE_C, POS_C))))

            #define GETARG_Bx(i)	(cast(int, ((i)>>POS_Bx) & MASK1(SIZE_Bx,0)))
            #define SETARG_Bx(i,b)	((i) = (((i)&MASK0(SIZE_Bx,POS_Bx)) | \
		            ((cast(Instruction, b)<<POS_Bx)&MASK1(SIZE_Bx, POS_Bx))))

            #define GETARG_sBx(i)	(GETARG_Bx(i)-MAXARG_sBx)
            #define SETARG_sBx(i,b)	SETARG_Bx((i),cast(unsigned int, (b)+MAXARG_sBx))


            #define CREATE_ABC(o,a,b,c)	((cast(Instruction, o)<<POS_OP) \
			            | (cast(Instruction, a)<<POS_A) \
			            | (cast(Instruction, b)<<POS_B) \
			            | (cast(Instruction, c)<<POS_C))

            #define CREATE_ABx(o,a,bc)	((cast(Instruction, o)<<POS_OP) \
			            | (cast(Instruction, a)<<POS_A) \
			            | (cast(Instruction, bc)<<POS_Bx))
        </lua_src>*/
        // # get_*, set_*, * = Op, A, C, B, sBx
        //   create_abc, create_abx
        //TODO foo 
        #endregion
    }
    public enum Opcodes
    {
        Mov,
        Closure,
        Call,
        Ret,
        Add,
        Mul,
        Eq,
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
            var callee = new Closure(thread.curr_func.local_data[operands[0]].compiled_func);
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
