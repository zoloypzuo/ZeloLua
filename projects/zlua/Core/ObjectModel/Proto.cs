using System.Collections.Generic;

using zlua.Core.Instruction;

namespace zlua.Core.ObjectModel
{
    // binchunk中函数原型
    //
    // 字段顺序对应binchunk中的字段顺序
    // s gcobject, but is not a primitive type
    internal class Proto
    {
        // 源文件名
        //
        // * 调试用
        // * 没必要继承出ChunkProto类
        public string Source;

        // 起止行号
        public uint LineDefined;

        public uint LastLineDefined;

        // 固定参数个数
        public byte numparams;

        // 是vararg函数
        public byte IsVararg;

        // 寄存器数量
        public byte MaxStackSize;

        // 指令表
        public Bytecode[] Code;

        // 常量表
        public TValue[] Constants;

        // Upvalue表
        public Upvalue[] Upvalues;

        // 内嵌Proto表
        public Proto[] Protos;

        // 行号表
        //
        // * 指令与对应的源文本行号
        // * 调试用
        public uint[] LineInfo;

        // 局部变量表
        //
        // * 调试用
        public LocVar[] LocVars;

        // Upvalue名字表
        //
        // * 调试用
        public string[] UpvalueNames;

        #region 公有访问器
        public int nUpvals { get { return Upvalues.Length; } }
        #endregion
    }

    internal class ChunkProto : Proto
    {
        internal List<string> strs = new List<string>();
        internal List<double> ns = new List<double>();
    }
}