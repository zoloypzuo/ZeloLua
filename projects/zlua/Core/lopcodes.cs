// 指令
//
//

using Newtonsoft.Json;

using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace zlua.Core
{
    // byte code instruction，
    //
    // TODO 没有搞清楚sbx的问题
    // 另外我删除了RK机制，不使用这种编码 => 真香
    // 这个类非常在意uint和int的区别，如果一个变量是非负的话，一定使用uint
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
        public Op Opcode {
            get { return (Op)Get(SizeOp, PosOp); }
            set { Set((uint)value, SizeOp, PosOp); }
        }

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
        public static bool IsK(int x) => (x & (1 << (int)(SizeB - 1))) != 0;

        public static int IndexK(int x) => x & ~(1 << (int)(SizeB - 1));

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

        private uint A {
            get {
                return Get(SizeA, PosA);
            }
            set {
                Set(value, SizeA, PosA);
            }
        }

        private uint B {
            get {
                return Get(SizeB, PosB);
            }
            set {
                Set(value, SizeB, PosB);
            }
        }

        private uint C {
            get {
                return Get(SizeC, PosC);
            }
            set {
                Set(value, SizeC, PosC);
            }
        }

        private uint Bx {
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
        private int SignedBx {
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

    // 将指令编码和解码成虚拟机需要的格式
    //
    // 虚拟机要的是操作码和操作数，操作数？？？有一部分还是得写到TThread中
    internal class BytecodeTool
    {
        private static OpConstraint[] OpcodeConstraints = new OpConstraint[]
        {
            // 我不是制表大师┑(￣Д ￣)┍
            /*     T  A    B       C     mode         name    */
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC , "MOVE    "), // R(A) := R(B)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx , "LOADK   "), // R(A) := Kst(Bx)
			new OpConstraint(false, true, OperandMode.OpArgN, OperandMode.OpArgN, OpMode.IABx , "LOADKX  "), // R(A) := Kst(extra arg)
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC , "LOADBOOL"), // R(A) := (bool)B; if (C) pc++
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC , "LOADNIL "), // R(A), R(A+true), ..., R(A+B) := nil
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC , "GETUPVAL"), // R(A) := UpValue[B]
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgK, OpMode.IABC , "GETTABUP"), // R(A) := UpValue[B][RK(C)]
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC , "GETTABLE"), // R(A) := R(B)[RK(C)]
			new OpConstraint(false, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "SETTABUP"), // UpValue[A][RK(B)] := RK(C)
			new OpConstraint(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC , "SETUPVAL"), // UpValue[B] := R(A)
			new OpConstraint(false, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "SETTABLE"), // R(A)[RK(B)] := RK(C)
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC , "NEWTABLE"), // R(A) := () (size = B,C)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC , "SELF    "), // R(A+true) := R(B); R(A) := R(B)[RK(C)]
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "ADD     "), // R(A) := RK(B) + RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "SUB     "), // R(A) := RK(B) - RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "MUL     "), // R(A) := RK(B) * RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "MOD     "), // R(A) := RK(B) % RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "POW     "), // R(A) := RK(B) ^ RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "DIV     "), // R(A) := RK(B) / RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "IDIV    "), // R(A) := RK(B) // RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "BAND    "), // R(A) := RK(B) & RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "BOR     "), // R(A) := RK(B) | RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "BXOR    "), // R(A) := RK(B) ~ RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "SHL     "), // R(A) := RK(B) << RK(C)
			new OpConstraint(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "SHR     "), // R(A) := RK(B) >> RK(C)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC , "UNM     "), // R(A) := -R(B)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC , "BNOT    "), // R(A) := ~R(B)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC , "NOT     "), // R(A) := not R(B)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC , "LEN     "), // R(A) := length of R(B)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgR, OpMode.IABC , "CONCAT  "), // R(A) := R(B).. ... ..R(C)
			new OpConstraint(false, false, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx , "JMP     "), // pc+=sBx; if (A) close all upvalues >= R(A - true)
			new OpConstraint(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "EQ      "), // if ((RK(B) == RK(C)) ~= A) then pc++
			new OpConstraint(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "LT      "), // if ((RK(B) <  RK(C)) ~= A) then pc++
			new OpConstraint(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC , "LE      "), // if ((RK(B) <= RK(C)) ~= A) then pc++
			new OpConstraint(true, false, OperandMode.OpArgN, OperandMode.OpArgU, OpMode.IABC , "TEST    "), // if not (R(A) <=> C) then pc++
			new OpConstraint(true, true, OperandMode.OpArgR, OperandMode.OpArgU, OpMode.IABC , "TESTSET "), // if (R(B) <=> C) then R(A) := R(B) else pc++
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC , "CALL    "), // R(A), ... ,R(A+C-2) := R(A)(R(A+true), ... ,R(A+B-true))
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC , "TAILCALL"), // return R(A)(R(A+true), ... ,R(A+B-true))
			new OpConstraint(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC , "RETURN  "), // return R(A), ... ,R(A+B-2)
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx , "FORLOOP "), // R(A)+=R(A+2); if R(A) <?= R(A+true) then ( pc+=sBx; R(A+3)=R(A) )
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx , "FORPREP "), // R(A)-=R(A+2); pc+=sBx
			new OpConstraint(false, false, OperandMode.OpArgN, OperandMode.OpArgU, OpMode.IABC , "TFORCALL"), // R(A+3), ... ,R(A+2+C) := R(A)(R(A+true), R(A+2));
			new OpConstraint(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx , "TFORLOOP"), // if R(A+true) ~= nil then ( R(A)=R(A+true); pc += sBx )
			new OpConstraint(false, false, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC , "SETLIST "), // R(A)[(C-true)*FPF+i] := R(A+i), true <= i <= B
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABx , "CLOSURE "), // R(A) := closure(KPROTO[Bx])
			new OpConstraint(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC , "VARARG  "), // R(A), R(A+true), ..., R(A+B-2) = vararg
			new OpConstraint(false, false, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IAx , "EXTRAARG"), // extra (larger) argument for previous new OpcodeConstraint
        };

        #region 公有方法

        public static OpConstraint GetOpConstraint(Op opcode)
        {
            return OpcodeConstraints[(int)opcode];
        }

        public static List<Bytecode> Gen(uint[] hexs)
        {
            var a = new List<Bytecode>();
            foreach (var item in hexs) {
                a.Add(new Bytecode(item));
            }
            return a;
        }

        #endregion 公有方法

        //public Bytecode(Op opcode, int a, int b, int c)
        //{
        //    uint A = (uint)a;
        //    uint B = (uint)b;
        //    uint C = (uint)c;
        //    Debug.Assert(A < (1 << 8));
        //    Debug.Assert(B < (1 << 9));
        //    Debug.Assert(C < (1 << 9));
        //    Value = (uint)opcode << PosOp | A << PosA | B << PosB | C << PosC;
        //}
        //public Bytecode(Op opcode, int a, int bx)
        //{
        //    uint A = (uint)a;
        //    uint Bx = (uint)bx;
        //    Debug.Assert(A < (1 << 8));
        //    Debug.Assert(Bx < (1 << 18));
        //    Value = (uint)opcode << PosOp | A << PosA | Bx << PosBx;
        //}
        ///// <summary>
        ///// 基于ctor的工厂，因为RA RKB RKC这种指令格式最好有通用函数，opcode会被检查
        ///// bool中K是true，R是false
        ///// 设计决策】没有办法提供很好的设计。所以只能提供这种简单的包装的辅助函数
        ///// </summary>
        //public static Bytecode RaRKbRkc(Op opcode, int a, bool isKorR1, int b, bool isKorR2, int c)
        //{
        //    //检查opcode范围
        //    Debug.Assert((int)opcode >= (int)Op.Add && (int)opcode <= (int)Op.Le);
        //    Debug.Assert(!((int)opcode >= (int)Op.Unm && (int)opcode <= (int)Op.Jmp));
        //    int rkb = b | (Convert.ToInt32(isKorR1) << 8);
        //    int rkc = c | (Convert.ToInt32(isKorR2) << 8);
        //    return new Bytecode(opcode, a, rkb, rkc);
        //}
        ///// <summary>
        ///// loadnil, move, unm, not, len,  return, get/setupval
        ///// </summary>
        //public static Bytecode RaRb(Op opcode, int a, int b)
        //{
        //    return new Bytecode(opcode, a, b, 0);
        //}
        ///// <summary>
        ///// local a, b = 10; b = a
        ///// 1. 为函数调用，get/setTable，concat移动oprd，因为栈顺序重要
        ///// 2. 为函数返回值移动到局部变量
        ///// 3. 作为closure后的伪指令
        ///// </summary>
        //public static Bytecode Mov(int a, int b) => RaRb(Op.Move, a, b);
        //public static Bytecode LoadNil(int a, int b) => RaRb(Op.LoadNil, a, b);
        //public static Bytecode LoadN(int a, int bx) => new Bytecode(Op.LoadN, a, bx);
        //public static Bytecode LoadS(int a, int bx) => new Bytecode(Op.LoadS, a, bx);
        ///// <summary>
        ///// RA = B, if C then pc++
        ///// </summary>
        //public static Bytecode LoadB(int a, bool b, bool c = false) =>
        //    new Bytecode(Op.LoadBool, a, Convert.ToInt32(b), Convert.ToInt32(c));
        //public static Bytecode GetG(int a, int bx) => new Bytecode(Op.GetGlobal, a, bx);
        //public static Bytecode SetG(int a, int bx) => new Bytecode(Op.SetGlobal, a, bx);
        //public static Bytecode GetU(int a, int b) => RaRb(Op.GetUpVal, a, b);
        //public static Bytecode SetU(int a, int b) => RaRb(Op.SetUpval, a, b);
        //public static Bytecode GetL(int a, int bx) => new Bytecode(Op.GetLocal, a, bx);
        //public static Bytecode SetL(int a, int bx) => new Bytecode(Op.SetLocal, a, bx);
        /// RA = RB[RKC]
        //public static Bytecode GetTable(int a, int b, RK rkc)
        //{
        //    int c = rkc.val | (Convert.ToInt32(rkc.isK) << 8);
        //    return new Bytecode(Op.GetTable, a, b, c);
        //}
        ///// RA[RKB] = RKC
        //public static Bytecode SetTable(int a, RK rkb, RK rkc)
        //{
        //    int b = rkb.val | (Convert.ToInt32(rkb.isK) << 8);
        //    int c = rkc.val | (Convert.ToInt32(rkc.isK) << 8);
        //    return new Bytecode(Op.SetTable, a, b, c);
        //}
        //public static Bytecode Unm(int a, int b) => RaRb(Op.Unm, a, b);
        //public static Bytecode Not(int a, int b) => RaRb(Op.Not, a, b);
        //public static Bytecode Len(int a, int b) => RaRb(Op.Len, a, b);
        ///// RA = String.Join(RB, ..., RC)
        //public static Bytecode Concat(int a, int b, int c) => new Bytecode(Op.Concat, a, b, c);
        //public static Bytecode Jmp(int sbx) => new Bytecode(Op.Jmp, 0, sbx);
        //public static Bytecode Call(int a, int b, int c) => new Bytecode(Op.Call, a, b, c);
        ///// return A  => mov RA, ...,R[L.topIndex] to R[ci.funcIndex], ...
        ///// 我修改了指令和函数调用的语义。现在不需要RB了
        //public static Bytecode Ret(int a) => new Bytecode(Op.Return, a, 0, 0);
        ///// RA, RA+1, ...,RA+B-2 = vararg
        //public static Bytecode Vararg(int a, int b) => RaRb(Op.VarArg, a, b);
        ///// RA+1 = RB, RA = RB[RKC]: load function from table RB to RA, put table RB iteself at RA+1 as the first arg
        //public static Bytecode Self(int a, int b, int c) => new Bytecode(Op.Self, a, b, c);
    }

    internal enum Op : byte
    {
        OP_MOVE = 0,
        OP_LOADK = 1,
        OP_LOADKX = 2,
        OP_LOADBOOL = 3,
        OP_LOADNIL = 4,
        OP_GETUPVAL = 5,
        OP_GETTABUP = 6,
        OP_GETTABLE = 7,
        OP_SETTABUP = 8,
        OP_SETUPVAL = 9,
        OP_SETTABLE = 10,
        OP_NEWTABLE = 11,
        OP_SELF = 12,
        OP_ADD = 13,
        OP_SUB = 14,
        OP_MUL = 15,
        OP_MOD = 16,
        OP_POW = 17,
        OP_DIV = 18,
        OP_IDIV = 19,
        OP_BAND = 20,
        OP_BOR = 21,
        OP_BXOR = 22,
        OP_SHL = 23,
        OP_SHR = 24,
        OP_UNM = 25,
        OP_BNOT = 26,
        OP_NOT = 27,
        OP_LEN = 28,
        OP_CONCAT = 29,
        OP_JMP = 30,
        OP_EQ = 31,
        OP_LT = 32,
        OP_LE = 33,
        OP_TEST = 34,
        OP_TESTSET = 35,
        OP_CALL = 36,
        OP_TAILCALL = 37,
        OP_RETURN = 38,
        OP_FORLOOP = 39,
        OP_FORPREP = 40,
        OP_TFORCALL = 41,
        OP_TFORLOOP = 42,
        OP_SETLIST = 43,
        OP_CLOSURE = 44,
        OP_VARARG = 45,
        OP_EXTRAARG = 46,
    }

    internal enum OpMode : byte
    {
        IABC,
        IABx,
        IAsBx,
        IAx
    }

    internal enum OperandMode : byte
    {
        // 不使用该参数
        OpArgN,

        // 使用该参数
        OpArgU,

        // 该参数是寄存器或jump偏移
        OpArgR,

        // 该参数是常量表或寄存器的索引
        OpArgK
    }

    internal class OpConstraint
    {
        // 是测试指令
        //
        // 下一条指令一定是jump
        public bool IsTest { get; }

        // 这条指令会设置RA
        public bool SetA { get; }

        public OperandMode ArgBMode { get; }
        public OperandMode ArgCMode { get; }
        public OpMode OpMode { get; }
        public string Name { get; }

        public OpConstraint(
            bool isTest, bool setA,
            OperandMode argBMode, OperandMode argCMode,
            OpMode opMode, string name)
        {
            IsTest = isTest;
            SetA = setA;
            ArgBMode = argBMode;
            ArgCMode = argCMode;
            OpMode = opMode;
            Name = name;
        }
    }
}