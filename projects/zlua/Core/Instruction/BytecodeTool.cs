namespace zlua.Core.Instruction
{
    // 将指令编码和解码成虚拟机需要的格式
    //
    // 虚拟机要的是操作码和操作数，操作数？？？有一部分还是得写到TThread中
    internal class BytecodeTool
    {
        private static opmode[] OpcodeConstraints = new opmode[]
        {
            // 我不是制表大师┑(￣Д ￣)┍
            /*       T  A    B       C     mode		   opcode	*/
              new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) 		/* OP_MOVE */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx)		/* OP_LOADK */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC)		/* OP_LOADBOOL */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC)		/* OP_LOADNIL */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC)		/* OP_GETUPVAL */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx)		/* OP_GETGLOBAL */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC)		/* OP_GETTABLE */
             ,new opmode(false, false, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx)		/* OP_SETGLOBAL */
             ,new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC)		/* OP_SETUPVAL */
             ,new opmode(false, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_SETTABLE */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC)		/* OP_NEWTABLE */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC)		/* OP_SELF */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_ADD */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_SUB */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_MUL */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_DIV */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_MOD */
             ,new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_POW */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC)		/* OP_UNM */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC)		/* OP_NOT */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC)		/* OP_LEN */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgR, OpMode.IABC)		/* OP_CONCAT */
             ,new opmode(false, false, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx)		/* OP_JMP */
             ,new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_EQ */
             ,new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_LT */
             ,new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC)		/* OP_LE */
             ,new opmode(true, true, OperandMode.OpArgR, OperandMode.OpArgU, OpMode.IABC)		/* OP_TEST */
             ,new opmode(true, true, OperandMode.OpArgR, OperandMode.OpArgU, OpMode.IABC)		/* OP_TESTSET */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC)		/* OP_CALL */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC)		/* OP_TAILCALL */
             ,new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC)		/* OP_RETURN */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx)		/* OP_FORLOOP */
             ,new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx)		/* OP_FORPREP */
             ,new opmode(true, false, OperandMode.OpArgN, OperandMode.OpArgU, OpMode.IABC)		/* OP_TFORLOOP */
             ,new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC)		/* OP_SETLIST */
             ,new opmode(false, false, OperandMode.OpArgN, OperandMode.OpArgN, OpMode.IABC)		/* OP_CLOSE */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABx)		/* OP_CLOSURE */
             ,new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC)		/* OP_VARARG */
        };

        #region 公有方法

        public static opmode GetOpConstraint(Opcode opcode)
        {
            return OpcodeConstraints[(int)opcode];
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

    internal class opmode
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

        public opmode(
            bool isTest, bool setA,
            OperandMode argBMode, OperandMode argCMode,
            OpMode opMode)
        {
            IsTest = isTest;
            SetA = setA;
            ArgBMode = argBMode;
            ArgCMode = argCMode;
            OpMode = opMode;
        }
    }
}