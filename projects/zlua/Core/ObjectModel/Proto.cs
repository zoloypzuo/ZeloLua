using System.Collections.Generic;

using zlua.Core.InstructionSet;

namespace zlua.Core.ObjectModel
{
    /// <summary>
    /// 函数原型
    /// </summary>
    internal class Proto
    {
        /// <summary>
        /// 源文件名
        /// </summary>
        /// <remarks>
        /// 调试用，只有chunk才有值，其他函数都是空串
        /// 不过没有必要设计一个ChunkProto类
        /// </remarks>
        public string source;

        /// <summary>
        /// 开始行号
        /// </summary>
        public int linedefined;

        /// <summary>
        /// 结束行号
        /// </summary>
        public int lastlinedefined;

        /// <summary>
        /// Upvalue数量
        /// </summary>
        public byte nups;  /* number of upvalues */

        /// <summary>
        /// 固定参数个数
        /// </summary>
        public byte numparams;

        /// <summary>
        /// 是vararg函数
        /// </summary>
        public byte is_vararg;

        public bool IsVararg { get { return is_vararg != 0; } }

        /// <summary>
        /// 寄存器数量
        /// </summary>
        public byte maxstacksize;

        /// <summary>
        /// 指令表
        /// </summary>
        public Bytecode[] code;

        /// <summary>
        /// 常量表
        /// </summary>
        public TValue[] k;

        /// <summary>
        /// 内嵌Proto表
        /// </summary>
        public Proto[] p;

        #region 调试信息

        /// <summary>
        /// 行号表
        /// </summary>
        /// <remarks>指令与对应的源文本行号</remarks>
        public int[] lineinfo;

        /// <summary>
        /// 局部变量表
        /// </summary>
        public LocVar[] locvars;

        /// <summary>
        /// Upvalue名字表
        /// </summary>
        public string[] upvalues;

        #endregion 调试信息
    }

    internal class ChunkProto : Proto
    {
        internal List<string> strs = new List<string>();
        internal List<double> ns = new List<double>();
    }
}