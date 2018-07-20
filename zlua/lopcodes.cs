using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
/// <summary>
/// 指令集
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
        static int Mask1(int n, int pos) => (~((~0) << n)) << pos;
        static int Mask0(int n, int pos) => ~Mask0(n, pos);
        static int Get(int i, int n, int pos) => (i >> pos) & Mask1(n, pos);
        static void Set(ref int i, int x, int n, int pos) => i = i & Mask0(n, pos) | (x << pos) & Mask1(n, pos);

        public Opcodes Opcode
        {
            get => (Opcodes)Get(i, size_Op, pos_Op);
            set => Set(ref i, (int)value, size_Op, pos_Op);
        }

        public int A
        {
            get => Get(i, size_A, pos_A);
            set => Set(ref i, value, size_A, pos_A);
        }

        public int B
        {
            get => Get(i, size_B, pos_B);
            set => Set(ref i, value, size_B, pos_B);
        }

        public int C
        {
            get => Get(i, size_C, pos_C);
            set => Set(ref i, value, size_C, pos_C);
        }

        public int Bx
        {
            get => Get(i, size_Bx, pos_Bx);
            set => Set(ref i, value, size_Bx, pos_Bx);
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
}
