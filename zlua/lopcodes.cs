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
    public interface IInstruction
    {
        int A { get; set; }
        int B { get; set; }
        int C { get; set; }
        int Bx { get; set; }
        Opcodes Opcode { get; set; }
    }
    /// <summary>
    /// eaiser to use than `Bytecode
    /// </summary>
    public class NonBytecode : IInstruction
    {
        public int A { get; set; }
        public int B { get; set; }
        public int C { get; set; }
        public int Bx { get; set; }
        public Opcodes Opcode { get; set; }
        public NonBytecode(Opcodes op, int a, int b, int c)
        {
            Opcode = op;
            A = a;
            B = b;
            C = c;
        }
        public NonBytecode(Opcodes op, int a, int bx)
        {
            Opcode = op;
            A = a;
            Bx = bx;
        }
    }


    /// <summary>
    /// byte code instruction
    /// </summary>
    public struct Bytecode : IInstruction
    {
        uint i;
        /// <summary>
        /// 实现决策】struct本身语义就是与int相等，因此只允许使用cast
        /// </summary>
        /// <param name="i"></param>
        Bytecode(uint i)
        {
            this.i = i;
        }
        public Bytecode(Opcodes opcode, int a, int b, int c)
        {
            uint A = (uint)a;
            uint B = (uint)b;
            uint C = (uint)c;
            Debug.Assert(A < (1 << 8));
            Debug.Assert(B < (1 << 9));
            Debug.Assert(C < (1 << 9));
            i = (uint)opcode << PosOp | A << PosA | B << PosB | C << PosC;
        }
        public Bytecode(Opcodes opcode, int a, int bx)
        {
            uint A = (uint)a;
            uint Bx = (uint)bx;
            Debug.Assert(A < (1 << 8));
            Debug.Assert(Bx < (1 << 18));
            i = (uint)opcode << PosOp | A << PosA | Bx << PosBx;
        }
        public static explicit operator uint(Bytecode i) => i.i;
        public static explicit operator Bytecode(uint i) => new Bytecode(i);
        #region size and position of instruction arguments

        const int SizeC = 9;
        const int SizeB = 9;
        const int SizeBx = SizeC + SizeB;
        const int SizeA = 8;
        const int SizeOp = 6;

        const int PosOp = 0;
        const int PosA = PosOp + SizeOp;
        const int PosC = PosA + SizeA;
        const int PosB = PosC + SizeC;
        const int PosBx = PosC;

        #endregion

        #region max size of instrucion arguments

        const int max_argBx = (1 << SizeBx) - 1; // 1. "<<" is less prior to "-" 2. "1<<n" = 2**n 
        const int MaxArgSignedBx = max_argBx >> 1;
        const int max_argA = (1 << SizeA) - 1;
        const int max_argB = (1 << SizeB) - 1;
        const int max_argC = (1 << SizeC) - 1;
        #endregion
        #region getter and setter of instruction
        static uint Mask1(int n, int pos) => (~((~(uint)0) << n)) << pos;
        static uint Mask0(int n, int pos) => ~Mask0(n, pos);

        int Get(int n, int pos)
        {
            var a = (i >> pos);
            var b = Mask1(n, 0);
            return (int)(a & b);
        }

        void Set(int x, int n, int pos)
        {
            var a = i & Mask0(n, pos);
            var b = ((uint)x << pos) & Mask1(n, pos); // "(uint)"是必要的。
            i = a | b;
        }


        public Opcodes Opcode
        {
            get => (Opcodes)Get(SizeOp, PosOp);
            set => Set((int)value, SizeOp, PosOp);
        }

        public int A
        {
            get => Get(SizeA, PosA);
            set => Set(value, SizeA, PosA);
        }

        public int B
        {
            get => Get(SizeB, PosB);
            set => Set(value, SizeB, PosB);
        }

        public int C
        {
            get => Get(SizeC, PosC);
            set => Set(value, SizeC, PosC);
        }

        public int Bx
        {
            get => Get(SizeBx, PosBx);
            set => Set(value, SizeBx, PosBx);
        }
        /// <summary>
        /// sBx
        /// </summary>
        public int SignedBx
        {
            get => Bx - MaxArgSignedBx;
            set => Bx = value + MaxArgSignedBx;
        }
        #endregion
        #region other things
        const int NOpcodes = (int)Opcodes.VarArg + 1;
        /// <summary>
        /// if x[7] (in bit) is 1, return true, and RKB returns KB
        /// </summary>
        /// <param name="x">B or C</param>
        /// <returns></returns>
        public static bool IsK(int x) => (x & (1 << (SizeB - 1))) != 0;
        public static int IndexK(int x) => x & ~(1 << (SizeB - 1));
        public static List<Bytecode> Gen(uint[] hexs)
        {
            var a = new List<Bytecode>();
            foreach (var item in hexs) {
                a.Add(new Bytecode(item));
            }
            return a;
        }
        public override string ToString()
        {
            return Opcode.ToString() + " A: " + A.ToString() +
               " B: " + B.ToString() + " C: " + C.ToString() + 
               " Bx: " + Bx.ToString();
        }
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
    }
}
