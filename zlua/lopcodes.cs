using System;
using System.Collections.Generic;
using System.Diagnostics;
/// <summary>
/// 指令集
/// </summary>
namespace zlua.ISA
{
    /// <summary>
    /// 仅仅为了简洁地展示，并没有用这个接口
    /// </summary>
    interface IInstruction
    {
        int A { get; set; }
        int B { get; set; }
        int C { get; set; }
        int Bx { get; set; }
        Opcodes Opcode { get; set; }
    }

    /// <summary>
    /// byte code instruction
    /// </summary>
    [Serializable]
    struct Bytecode : IInstruction
    {
        uint i;
        /// <summary>
        /// 实现决策】struct本身语义就是与int相等，因此只允许使用cast
        /// </summary>
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
        #region Test
        class Assert
        {
            internal static void AreEqual<T>(T v1, T v2)
            {
                Debug.Assert(v1.Equals(v2));
            }
        }
        void CreateOprd2()
        {
            Assert.AreEqual<UInt32>(0x00000007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 0));
            Assert.AreEqual<UInt32>(0x00004007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 1));
            Assert.AreEqual<UInt32>(0x00008007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 2));
            Assert.AreEqual<UInt32>(0x00010001, (uint)new Bytecode(Opcodes.LoadK, 0, 4));
            Assert.AreEqual<UInt32>(0x0000C007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 3));
            Assert.AreEqual<UInt32>(0x00018001, (uint)new Bytecode(Opcodes.LoadK, 0, 6));
            Assert.AreEqual<UInt32>(0x00014007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 5));
            Assert.AreEqual<UInt32>(0x00020001, (uint)new Bytecode(Opcodes.LoadK, 0, 8));
            Assert.AreEqual<UInt32>(0x0001C007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 7));
            Assert.AreEqual<UInt32>(0x00000003, (uint)new Bytecode(Opcodes.LoadNil, 0, 0));
            Assert.AreEqual<UInt32>(0x000100C1, (uint)new Bytecode(Opcodes.LoadK, 3, 4));
            Assert.AreEqual<UInt32>(0x00018101, (uint)new Bytecode(Opcodes.LoadK, 4, 6));
            Assert.AreEqual<UInt32>(0x00020141, (uint)new Bytecode(Opcodes.LoadK, 5, 8));
            Assert.AreEqual<UInt32>(0x000101C1, (uint)new Bytecode(Opcodes.LoadK, 7, 4));
            Assert.AreEqual<UInt32>(0x00024201, (uint)new Bytecode(Opcodes.LoadK, 8, 9));
            Assert.AreEqual<UInt32>(0x000241C1, (uint)new Bytecode(Opcodes.LoadK, 7, 9));
            Assert.AreEqual<UInt32>(0x00028201, (uint)new Bytecode(Opcodes.LoadK, 8, 10));
            Assert.AreEqual<UInt32>(0x00000324, (uint)new Bytecode(Opcodes.Closure, 12, 0));
            Assert.AreEqual<UInt32>(0x00034307, (uint)new Bytecode(Opcodes.SetGlobal, 12, 13));
            Assert.AreEqual<UInt32>(0x00034305, (uint)new Bytecode(Opcodes.GetGlobal, 12, 13));
            Assert.AreEqual<UInt32>(0x00010341, (uint)new Bytecode(Opcodes.LoadK, 13, 4));
            Assert.AreEqual<UInt32>(0x00024381, (uint)new Bytecode(Opcodes.LoadK, 14, 9));
        }
        public void CreateOprd3()
        {

            Assert.AreEqual<UInt32>(0x00000002, (uint)new Bytecode(Opcodes.LoadBool, 0, 0, 0));
            Assert.AreEqual<UInt32>(0x00800002, (uint)new Bytecode(Opcodes.LoadBool, 0, 1, 0));
            Assert.AreEqual<UInt32>(0x00000042, (uint)new Bytecode(Opcodes.LoadBool, 1, 0, 0));
            Assert.AreEqual<UInt32>(0x00800082, (uint)new Bytecode(Opcodes.LoadBool, 2, 1, 0));
            Assert.AreEqual<UInt32>(0x0100018A, (uint)new Bytecode(Opcodes.NewTable, 6, 2, 0));
            Assert.AreEqual<UInt32>(0x010041A2, (uint)new Bytecode(Opcodes.SetList, 6, 2, 1));
            Assert.AreEqual<UInt32>(0x85C3024C, (uint)new Bytecode(Opcodes.Add, 9, 267, 268));
            Assert.AreEqual<UInt32>(0x82424057, (uint)new Bytecode(Opcodes.Eq, 1, 260, 265));
            Assert.AreEqual<UInt32>(0x00004282, (uint)new Bytecode(Opcodes.LoadBool, 10, 0, 1));
            Assert.AreEqual<UInt32>(0x00800282, (uint)new Bytecode(Opcodes.LoadBool, 10, 1, 0));
            Assert.AreEqual<UInt32>(0x000002C2, (uint)new Bytecode(Opcodes.LoadBool, 11, 0, 0));
            Assert.AreEqual<UInt32>(0x0180831C, (uint)new Bytecode(Opcodes.Call, 12, 3, 2));

            // TODO，这两条指令的C是省略为0的，另外jmp型是sbx，还没有考虑
            Assert.AreEqual<UInt32>(0x03000194, (uint)new Bytecode(Opcodes.Len, 6, 6, 0));
            Assert.AreEqual<UInt32>(0x0080001E, (uint)new Bytecode(Opcodes.Return, 0, 1, 0));


        }
        void TestA()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).A);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 1, 0).A);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 1, 0, 0).A);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.LoadBool, 2, 1, 0).A);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.NewTable, 6, 2, 0).A);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.SetList, 6, 2, 1).A);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.Add, 9, 267, 268).A);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.Eq, 1, 260, 265).A);
            Assert.AreEqual<Int32>(10, new Bytecode(Opcodes.LoadBool, 10, 1, 0).A);
            Assert.AreEqual<Int32>(11, new Bytecode(Opcodes.LoadBool, 11, 0, 0).A);
            Assert.AreEqual<Int32>(12, new Bytecode(Opcodes.Call, 12, 3, 2).A);
        }
        void TestB()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 0, 1, 0).B);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 1, 0, 0).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 2, 1, 0).B);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.NewTable, 6, 2, 0).B);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.SetList, 6, 2, 1).B);
            Assert.AreEqual<Int32>(267, new Bytecode(Opcodes.Add, 9, 267, 268).B);
            Assert.AreEqual<Int32>(260, new Bytecode(Opcodes.Eq, 1, 260, 265).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 10, 1, 0).B);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 11, 0, 0).B);
            Assert.AreEqual<Int32>(3, new Bytecode(Opcodes.Call, 12, 3, 2).B);
        }
        void TestC()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 1, 0, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 2, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.NewTable, 6, 2, 0).C);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.SetList, 6, 2, 1).C);
            Assert.AreEqual<Int32>(268, new Bytecode(Opcodes.Add, 9, 267, 268).C);
            Assert.AreEqual<Int32>(265, new Bytecode(Opcodes.Eq, 1, 260, 265).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 10, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 11, 0, 0).C);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.Call, 12, 3, 2).C);
        }
        void TestBx()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.SetGlobal, 0, 0).Bx);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.SetGlobal, 0, 1).Bx);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.SetGlobal, 0, 2).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 0, 4).Bx);
            Assert.AreEqual<Int32>(3, new Bytecode(Opcodes.SetGlobal, 0, 3).Bx);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.LoadK, 0, 6).Bx);
            Assert.AreEqual<Int32>(5, new Bytecode(Opcodes.SetGlobal, 0, 5).Bx);
            Assert.AreEqual<Int32>(8, new Bytecode(Opcodes.LoadK, 0, 8).Bx);
            Assert.AreEqual<Int32>(7, new Bytecode(Opcodes.SetGlobal, 0, 7).Bx);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadNil, 0, 0).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 3, 4).Bx);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.LoadK, 4, 6).Bx);
            Assert.AreEqual<Int32>(8, new Bytecode(Opcodes.LoadK, 5, 8).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 7, 4).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 8, 9).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 7, 9).Bx);
            Assert.AreEqual<Int32>(10, new Bytecode(Opcodes.LoadK, 8, 10).Bx);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.Closure, 12, 0).Bx);
            Assert.AreEqual<Int32>(13, new Bytecode(Opcodes.SetGlobal, 12, 13).Bx);
            Assert.AreEqual<Int32>(13, new Bytecode(Opcodes.GetGlobal, 12, 13).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 13, 4).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 14, 9).Bx);
        }
        #endregion

    }

    enum Opcodes
    {
        /* mov类*/
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
        /* 算术运算类*/
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        Pow,
        Unm,
        /* 关系运算 逻辑运算 jmp*/
        Not,
        Len,
        Concat,
        Jmp,
        Eq,
        Lt,
        Le,
        Test,
        Testset,
        /* 调用*/
        Call,
        TailCall,
        Return,
        /* 循环*/
        ForLoop,
        ForPrep,
        TForLoop,
        /* 特殊，最后补上即可*/
        SetList,

        Close,
        Closure,
        /* 特殊，最后补上即可*/
        VarArg,
        /*自定增加的指令*/
        LoadN, //loadN和loadS替代LoadK
        LoadS,
    }
}
