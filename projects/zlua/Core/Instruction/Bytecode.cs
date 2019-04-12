using Newtonsoft.Json;

using System;
using System.Diagnostics;

using zlua.Core.Lua;
using zlua.Core.VirtualMachine;

namespace zlua.Core.Instruction
{
    // byte code instruction，
    //
    // [x] 没有搞清楚sbx的问题
    // [x] 另外我删除了RK机制，不使用这种编码 => 真香，还是按照标准来
    // * 这个类非常在意uint和int的区别，如果一个变量是非负的话，一定使用uint
    // * 注意<<运算符的规格
    //   * https://docs.microsoft.com/zh-cn/dotnet/csharp/language-reference/operators/left-shift-operator
    //   * rhs必须是int，所以这里要cast
    //   * <<优先级比-低，所以这里要加括号
    internal struct Bytecode
    {
        #region 内嵌类型定义

        /// 一个仅用于warp args的struct
        internal struct RK
        {
            public bool isK;
            public int val;

            public RK(bool isK, int val)
            {
                this.isK = isK;
                this.val = val;
            }
        }

        #endregion 内嵌类型定义

        #region 公有属性

        public uint Value { get; set; }

        #endregion 公有属性

        #region 构造函数

        public Bytecode(uint i)
        {
            Value = i;
        }

        #endregion 构造函数

        #region 访问器和设置器

        // TODO 名字改成Opcode
        [JsonIgnore]
        public Opcode Opcode {
            get { return (Opcode)Get(SizeOp, PosOp); }
            set { Set((uint)value, SizeOp, PosOp); }
        }

        // 想法很好，但是
        // c#7之前没有解包语法
        // 没必要传tuple，用单个访问器就很好
        [JsonIgnore]
        public Tuple<uint, uint, uint> ABC {
            get {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IABC);
                return new Tuple<uint, uint, uint>(A, B, C);
            }
            set {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IABC);
                A = value.Item1; B = value.Item2; C = value.Item3;
            }
        }

        [JsonIgnore]
        public Tuple<uint, uint> ABx {
            get {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IABx);
                return new Tuple<uint, uint>(A, C);
            }
            set {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IABx);
                A = value.Item1; Bx = value.Item2;
            }
        }

        [JsonIgnore]
        public Tuple<uint, int> AsBx {
            get {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IAsBx);
                return new Tuple<uint, int>(A, SignedBx);
            }
            set {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IAsBx);
                A = value.Item1; SignedBx = value.Item2;
            }
        }

        [JsonIgnore]
        public uint Ax {
            get {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IAx);
                return Get(SIZE_Ax, POS_Ax);
            }
            set {
                Debug.Assert(BytecodeTool.GetOpConstraint(Opcode).OpMode == OpMode.IAx);
                Set(value, SIZE_Ax, POS_Ax);
            }
        }

        #endregion 访问器和设置器

        // TODO

        #region handle RK

        // if x[7] (in bit) is 1, return true, and RKB returns KB
        public static bool IsK(int x)
        {
            return (x & (1 << (int)(SizeB - 1))) != 0;
        }

        public static int IndexK(int x)
        {
            return x & ~(1 << (int)(SizeB - 1));
        }

        #endregion handle RK

        #region 私有方法

        // 创建一个从某一位置开始若干位1的掩码
        private static uint Mask1(uint n, uint pos)
        {
            return (~((~(uint)0) << (int)n)) << (int)pos;
        }

        // 创建一个从某一位置开始若干位0的掩码
        private static uint Mask0(uint n, uint pos)
        {
            return ~Mask0(n, pos);
        }

        // 得到从某一位置开始若干位的无符号整数值
        private uint Get(uint n, uint pos)
        {
            var a = (Value >> (int)pos);
            var b = Mask1(n, 0);
            return (a & b);
        }

        // 将某一位置开始若干位设为x
        private void Set(uint x, uint n, uint pos)
        {
            var a = Value & Mask0(n, pos);
            var b = (x << (int)pos) & Mask1(n, pos);
            Value = a | b;
        }

        public uint A {
            get {
                return Get(SizeA, PosA);
            }
            set {
                Set(value, SizeA, PosA);
            }
        }

        public uint B {
            get {
                return Get(SizeB, PosB);
            }
            set {
                Set(value, SizeB, PosB);
            }
        }

        public uint C {
            get {
                return Get(SizeC, PosC);
            }
            set {
                Set(value, SizeC, PosC);
            }
        }

        public uint Bx {
            get {
                return Get(SizeBx, PosBx);
            }
            set {
                Set(value, SizeBx, PosBx);
            }
        }

        // sBx
        //
        // sBx是把无符号的Bx解释为有符号的移码
        public int SignedBx {
            get {
                return (int)(Bx - MaxArgSignedBx);
            }
            set {
                Bx = (uint)(value + MaxArgSignedBx);
            }
        }

        #endregion 私有方法

        #region 私有常量

        #region 指令各部分的大小和位置

        // 这一片因为是去年写的，全部使用帕斯卡，换成现在我更愿意写成C的全大写形式
        private const uint SizeC = 9;

        private const uint SizeB = 9;
        private const uint SizeBx = SizeC + SizeB;
        private const uint SizeA = 8;
        private const uint SIZE_Ax = (SizeC + SizeB + SizeA);
        private const uint SizeOp = 6;

        private const uint PosOp = 0;
        private const uint PosA = PosOp + SizeOp;
        private const uint PosC = PosA + SizeA;
        private const uint PosB = PosC + SizeC;
        private const uint PosBx = PosC;
        private const uint POS_Ax = PosA;

        #endregion 指令各部分的大小和位置

        #region 指令参数的最大值

        private const uint MaxArgBx = (1 << (int)SizeBx) - 1;
        private const uint MaxArgSignedBx = MaxArgBx >> 1;
        private const uint MaxArgA = (1 << (int)SizeA) - 1;
        private const uint MaxArgB = (1 << (int)SizeB) - 1;
        private const uint MaxArgC = (1 << (int)SizeC) - 1;

        #endregion 指令参数的最大值

        #endregion 私有常量

        public override string ToString()
        {
            var c = BytecodeTool.GetOpConstraint(Opcode);
            var op = c.Name;
            switch (c.OpMode) {
                case OpMode.IABC:
                    return $"{op} A: {A} B: {B} C: {C}";

                case OpMode.IABx:
                    return $"{op} A: {A} Bx: {Bx}";

                case OpMode.IAsBx:
                    return $"{op} A: {A} sBx: {SignedBx}";

                case OpMode.IAx:
                    return $"{op} Ax: {Ax}";

                default:
                    throw new GodDamnException();
            }
        }
    }
}