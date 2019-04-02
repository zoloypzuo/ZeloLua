// 加载预编译chunk
//
// * binchunk支持4B和8B的size_t大小，但zlua中使用int代替size_t
//   参见 https://stackoverflow.com/questions/32906774/what-is-equal-to-the-c-size-t-in-c-sharp
// * binchunk使用的size_t时被cast到int，有抛出溢出异常的可能
//   这里只是用checked语法简单地保证抛出，但是概率很小，除非使用超过2G的数组
// * binchunk中字符串编码是utf8
// * 因为这里的ReadLuaInteger调用ReadInt64，LuaInteger不支持配置成比如int32
// * binchunk仅支持小端，大端拒接

using System;
using System.IO;
using System.Text;

namespace zlua.Core.BinaryChunk
{
    // binchunk中函数原型
    //
    // 字段顺序对应binchunk中的字段顺序
    internal class Prototype
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
        public byte NumParams;

        // 是vararg函数
        public byte IsVararg;

        // 寄存器数量
        public byte MaxStackSize;

        // 指令表
        public Bytecode[] Code;

        // 常量表
        public LuaObject[] Constants;

        // Upvalue表
        public Upvalue[] Upvalues;

        // 子Proto表
        public Prototype[] Protos;

        // 行号表
        //
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
    }

    internal struct Upvalue
    {
        public byte Instack;
        public byte Idx;
    }

    internal struct LocVar
    {
        public string VarName;
        public uint StartPc;
        public uint EndPc;
    }

    internal class BinaryChunk
    {
        #region 用于校验的常量

        // ASCII字符串 ESC L u a
        public const string LUA_SIGNATURE = "\x1bLua";

        public const byte LUAC_VERSION = 0x53;
        public const byte LUAC_FORMAT = 0;

        // "\x19\x93\r\n\x1a\n"
        //
        // 不要使用字符串，因为必须指定编码，而这个其实不是字符串，只是byte数组
        // 0x93不符合ASCII编码，也不能用utf8，不管怎么样，使用字符串不合适
        public static readonly byte[] LUAC_DATA = new byte[] { 0x19, 0x93, 0x0d, 0x0a, 0x1a, 0x0a };

        public const uint CINT_SIZE = 4;
        public const uint CSIZET_SIZE_32 = 4;
        public const uint CSIZET_SIZE_64 = 8;
        public const uint INSTRUCTION_SIZE = 4;
        public const uint LUA_INTEGER_SIZE = 8;
        public const uint LUA_NUMER_SIZE = 8;
        public static readonly LuaInteger LUAC_INT = new LuaInteger { Value = 0x5678 };
        public static readonly LuaNumber LUAC_NUM = new LuaNumber { Value = 370.5f };

        #endregion 用于校验的常量

        #region 常量表类型枚举

        public const byte TAG_NIL = 0x00;
        public const byte TAG_BOOLEAN = 0x01;
        public const byte TAG_NUMBER = 0x03;
        public const byte TAG_INTEGER = 0x13;
        public const byte TAG_SHORT_STR = 0x04;
        public const byte TAG_LONG_STR = 0x14;

        #endregion 常量表类型枚举

        #region 公有属性

        public static bool IsSizeofCSizeT8 { get; private set; } = true;

        #endregion 公有属性

        #region 公有方法

        public static Prototype Undump(Stream data)
        {
            using (BinaryReader reader = new BinaryReader(
                data, Encoding.UTF8)) {
                // check header
                CheckHeader(reader);
                // 跳过Upvalue数量
                reader.ReadByte();
                // 读取函数原型并返回
                return ReadProto(reader, "");
            }
        }

        #endregion 公有方法

        #region 私有方法

        private static int ReadSizeT(BinaryReader reader)
        {
            if (IsSizeofCSizeT8) {
                return checked((int)reader.ReadUInt64());
            } else {
                return checked((int)reader.ReadUInt32());
            }
        }

        private static string ReadString(BinaryReader reader)
        {
            // 确定字符串长度
            int size = reader.ReadByte();
            if (size == 0) {  // null string
                return "";
            } else if (size == 0xFF) {
                size = ReadSizeT(reader);
            }

            return new String(reader.ReadChars(size - 1));
        }

        private static LuaInteger ReadLuaInteger(BinaryReader reader)
        {
            return new LuaInteger { Value = reader.ReadInt64() };
        }

        private static LuaNumber ReadLuaNumber(BinaryReader reader)
        {
            return new LuaNumber { Value = reader.ReadDouble() };
        }

        private static void CheckHeader(BinaryReader reader)
        {
            var header = new
            {
                signature = Encoding.ASCII.GetString(reader.ReadBytes(4)),
                version = reader.ReadByte(),
                format = reader.ReadByte(),
                luacData = reader.ReadBytes(6),
                cintSize = reader.ReadByte(),
                sizetSize = reader.ReadByte(),
                instructionSize = reader.ReadByte(),
                luaIntegerSize = reader.ReadByte(),
                luaNumberSize = reader.ReadByte(),
                luacInt = ReadLuaInteger(reader),
                luacNum = ReadLuaNumber(reader)
            };

            if (header.signature != LUA_SIGNATURE) {
                throw new UndumpException("not a precompiled header");
            }
            if (header.version != LUAC_VERSION) {
                throw new UndumpException("version mismatch");
            }
            if (header.format != LUAC_FORMAT) {
                throw new UndumpException("format mismatch");
            }
            // 数组并没有将相等实现为所有元素相等，因此必须用这个方法
            // 有必要避免Linq的话可以手写一个
            if (!System.Linq.Enumerable.SequenceEqual(header.luacData, LUAC_DATA)) {
                throw new UndumpException("corrupted");
            }
            if (header.cintSize != CINT_SIZE) {
                throw new UndumpNumericTypeInconsistencyException("int size mismatch");
            }
            if (!(header.sizetSize == CSIZET_SIZE_32 || header.sizetSize == CSIZET_SIZE_64)) {
                throw new UndumpNumericTypeInconsistencyException("size_t size mismatch");
            } else {
                IsSizeofCSizeT8 = header.sizetSize == CSIZET_SIZE_64;
            }
            if (header.instructionSize != INSTRUCTION_SIZE) {
                throw new UndumpException("instruction size mismatch");
            }
            if (header.luaIntegerSize != LUA_INTEGER_SIZE) {
                throw new UndumpNumericTypeInconsistencyException("lua_Integer size mismatch");
            }
            if (header.luaNumberSize != LUA_NUMER_SIZE) {
                throw new UndumpNumericTypeInconsistencyException("lua_Number size mismatch");
            }
            if (header.luacInt != LUAC_INT) {
                throw new UndumpNumericTypeInconsistencyException("endianness mismatch");
            }
            if (header.luacNum != LUAC_NUM) {
                throw new UndumpNumericTypeInconsistencyException("float format mismatch");
            }
        }

        private static Prototype ReadProto(BinaryReader reader, string parentSource)
        {
            string source = ReadString(reader);
            if (source == "") {
                source = parentSource;
            }

            return new Prototype
            {
                Source = source,
                LineDefined = reader.ReadUInt32(),
                LastLineDefined = reader.ReadUInt32(),
                NumParams = reader.ReadByte(),
                IsVararg = reader.ReadByte(),
                MaxStackSize = reader.ReadByte(),
                Code = ReadCode(reader),
                Constants = ReadConstants(reader),
                Upvalues = ReadUpvalues(reader),
                Protos = ReadProtos(reader, source),
                LineInfo = ReadLineInfo(reader),
                LocVars = ReadLocVars(reader),
                UpvalueNames = ReadUpvalueNames(reader)
            };
        }

        private static string[] ReadUpvalueNames(BinaryReader reader)
        {
            var names = new string[reader.ReadUInt32()];
            for (int i = 0; i < names.Length; i++) {
                names[i] = ReadString(reader);
            }
            return names;
        }

        private static LocVar[] ReadLocVars(BinaryReader reader)
        {
            var locVars = new LocVar[reader.ReadUInt32()];
            for (int i = 0; i < locVars.Length; i++) {
                locVars[i] = new LocVar
                {
                    VarName = ReadString(reader),
                    StartPc = reader.ReadUInt32(),
                    EndPc = reader.ReadUInt32()
                };
            }
            return locVars;
        }

        private static uint[] ReadLineInfo(BinaryReader reader)
        {
            var lineInfo = new uint[reader.ReadUInt32()];
            for (int i = 0; i < lineInfo.Length; i++) {
                lineInfo[i] = reader.ReadUInt32();
            }
            return lineInfo;
        }

        private static Prototype[] ReadProtos(BinaryReader reader, string parentSouce)
        {
            var protos = new Prototype[reader.ReadUInt32()];
            for (int i = 0; i < protos.Length; i++) {
                protos[i] = ReadProto(reader, parentSouce);
            }
            return protos;
        }

        private static Upvalue[] ReadUpvalues(BinaryReader reader)
        {
            var upvals = new Upvalue[reader.ReadUInt32()];
            for (int i = 0; i < upvals.Length; i++) {
                upvals[i] = new Upvalue
                {
                    Instack = reader.ReadByte(),
                    Idx = reader.ReadByte()
                };
            }
            return upvals;
        }

        private static LuaObject[] ReadConstants(BinaryReader reader)
        {
            var k = new LuaObject[reader.ReadUInt32()];
            for (int i = 0; i < k.Length; i++) {
                k[i] = ReadConstant(reader);
            }
            return k;
        }

        private static LuaObject ReadConstant(BinaryReader reader)
        {
            switch (reader.ReadByte()) {
                case TAG_NIL:
                    return new LuaObject();

                case TAG_BOOLEAN:
                    return new LuaObject(reader.ReadByte() != 0);

                case TAG_INTEGER:
                    return new LuaObject(ReadLuaInteger(reader));

                case TAG_NUMBER:
                    return new LuaObject(ReadLuaNumber(reader));

                case TAG_SHORT_STR:
                    return new LuaObject(ReadString(reader));

                case TAG_LONG_STR:
                    return new LuaObject(ReadString(reader));

                default:
                    throw new UndumpException("corrupted");
            }
        }

        private static Bytecode[] ReadCode(BinaryReader reader)
        {
            Bytecode[] code = new Bytecode[reader.ReadUInt32()];
            for (int i = 0; i < code.Length; i++) {
                code[i] = new Bytecode(reader.ReadUInt32());
            }
            return code;
        }

        #endregion 私有方法
    }

    // 头部校验错误
    public class UndumpException : Exception
    {
        public UndumpException(string msg) : base(msg)
        {
        }
    }

    // 数值类型校验错误
    public class UndumpNumericTypeInconsistencyException : UndumpException
    {
        public UndumpNumericTypeInconsistencyException(string msg) : base(msg)
        {
        }
    }
}