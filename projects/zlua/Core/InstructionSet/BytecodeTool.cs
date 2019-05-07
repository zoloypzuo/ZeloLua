namespace ZoloLua.Core.InstructionSet
{
    internal class BytecodeTool
    {
        private static readonly opmode[] luaP_opmodes =
        {
            // 我不是制表大师┑(￣Д ￣)┍
            /*       T  A    B       C     mode		   opcode	*/
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) /* OP_MOVE */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx) /* OP_LOADK */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC) /* OP_LOADBOOL */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) /* OP_LOADNIL */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC) /* OP_GETUPVAL */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx) /* OP_GETGLOBAL */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC) /* OP_GETTABLE */,
            new opmode(false, false, OperandMode.OpArgK, OperandMode.OpArgN, OpMode.IABx) /* OP_SETGLOBAL */,
            new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC) /* OP_SETUPVAL */,
            new opmode(false, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_SETTABLE */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC) /* OP_NEWTABLE */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgK, OpMode.IABC) /* OP_SELF */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_ADD */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_SUB */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_MUL */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_DIV */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_MOD */,
            new opmode(false, true, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_POW */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) /* OP_UNM */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) /* OP_NOT */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IABC) /* OP_LEN */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgR, OpMode.IABC) /* OP_CONCAT */,
            new opmode(false, false, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx) /* OP_JMP */,
            new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_EQ */,
            new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_LT */,
            new opmode(true, false, OperandMode.OpArgK, OperandMode.OpArgK, OpMode.IABC) /* OP_LE */,
            new opmode(true, true, OperandMode.OpArgR, OperandMode.OpArgU, OpMode.IABC) /* OP_TEST */,
            new opmode(true, true, OperandMode.OpArgR, OperandMode.OpArgU, OpMode.IABC) /* OP_TESTSET */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC) /* OP_CALL */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC) /* OP_TAILCALL */,
            new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC) /* OP_RETURN */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx) /* OP_FORLOOP */,
            new opmode(false, true, OperandMode.OpArgR, OperandMode.OpArgN, OpMode.IAsBx) /* OP_FORPREP */,
            new opmode(true, false, OperandMode.OpArgN, OperandMode.OpArgU, OpMode.IABC) /* OP_TFORLOOP */,
            new opmode(false, false, OperandMode.OpArgU, OperandMode.OpArgU, OpMode.IABC) /* OP_SETLIST */,
            new opmode(false, false, OperandMode.OpArgN, OperandMode.OpArgN, OpMode.IABC) /* OP_CLOSE */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABx) /* OP_CLOSURE */,
            new opmode(false, true, OperandMode.OpArgU, OperandMode.OpArgN, OpMode.IABC) /* OP_VARARG */
        };


        public static opmode GetOpmode(Opcode opcode)
        {
            return luaP_opmodes[(int)opcode];
        }


   
    }

    internal enum OpMode
    {
        IABC,
        IABx,
        IAsBx,
        IAx
    }

    internal enum OperandMode 
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

    /// <summary>
    ///     指令约束
    /// </summary>
    internal class opmode
    {
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

        /// <summary>
        /// 是测试指令，下一条指令一定是jump
        /// </summary>
        public bool IsTest { get; }

        /// <summary>
        /// 这条指令会设置RA
        /// </summary>
        public bool SetA { get; }

        public OperandMode ArgBMode { get; }
        public OperandMode ArgCMode { get; }
        public OpMode OpMode { get; }
    }
}