// 加载预编译chunk

using System;
using System.IO;
using System.Text;

using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.Undumper
{
    // * chunk的数据格式是lua内部实现细节，并没有标准，以lua源代码实现为准
    // * 当校验失败时，简单地拒接chunk
    // * chunk中字符串编码是utf8
    // * chunk数值类型规格表如下：
    //   lua类型 | c语言类型 | c#类型 | 大小
    //   ====== | ======== | ===== | ====
    //   字节 | unsigned char | byte | 1
    //   整数 | int | Int32 | 4
    //   size_t | size_t | int | 4 or 8
    //   LuaInteger | long long | Int64 | 8
    //   LuaNumber | double | double | 8
    // * chunk支持4B和8B的size_t大小，但zlua中使用int代替size_t
    //   参见 https://stackoverflow.com/questions/32906774/what-is-equal-to-the-c-size-t-in-c-sharp
    //   chunk使用的size_t时被cast到int，有抛出溢出异常的可能
    //   这里只是用checked语法简单地保证抛出，但是概率很小，除非使用超过2G大小的数组
    internal static class luaU
    {
        #region 用于校验的常量

        // ASCII字符串 ESC L u a
        private const string LUA_SIGNATURE = "\x1bLua";

        private const byte LUAC_VERSION = 0x53;
        private const byte LUAC_FORMAT = 0;

        // "\x19\x93\r\n\x1a\n"
        private static readonly byte[] LUAC_DATA = new byte[] { 0x19, 0x93, 0x0d, 0x0a, 0x1a, 0x0a };

        private const uint CINT_SIZE = 4;
        private const uint CSIZET_SIZE_32 = 4;
        private const uint CSIZET_SIZE_64 = 8;
        private const uint INSTRUCTION_SIZE = 4;
        private const uint LUA_INTEGER_SIZE = 8;
        private const uint LUA_NUMBER_SIZE = 8;
        private static readonly lua_Integer LUAC_INT = 0x5678;
        private static readonly lua_Number LUAC_NUM = 370.5f;

        #endregion 用于校验的常量

        #region 常量表类型枚举

        private const byte TAG_NIL = 0x00;
        private const byte TAG_BOOLEAN = 0x01;
        private const byte TAG_NUMBER = 0x03;
        private const byte TAG_INTEGER = 0x13;
        private const byte TAG_SHORT_STR = 0x04;
        private const byte TAG_LONG_STR = 0x14;

        #endregion 常量表类型枚举

        #region 公有属性

        public static bool IsSizeofCSizeT8 { get; private set; } = true;

        // chunk文件首字符，用于/loadfile/检查文件是否是chunk
        public const char FirstChar = '\x1b'; // LUA_SIGNATURE[0]

        #endregion 公有属性

        #region 公有方法

        public static Proto Undump(Stream data)
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

        private static lua_Integer ReadLuaInteger(BinaryReader reader)
        {
            return reader.ReadInt64();
        }

        private static lua_Number ReadLuaNumber(BinaryReader reader)
        {
            return reader.ReadDouble();
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
                throw new UndumperException("not a precompiled header");
            }
            if (header.version != LUAC_VERSION) {
                throw new UndumperException("version mismatch");
            }
            if (header.format != LUAC_FORMAT) {
                throw new UndumperException("format mismatch");
            }
            // 数组并没有将相等实现为所有元素相等，因此必须用这个方法
            // 有必要避免Linq的话可以手写一个
            if (!System.Linq.Enumerable.SequenceEqual(header.luacData, LUAC_DATA)) {
                throw new UndumperException("corrupted");
            }
            if (header.cintSize != CINT_SIZE) {
                throw new UndumperException("int size mismatch");
            }
            if (!(header.sizetSize == CSIZET_SIZE_32 || header.sizetSize == CSIZET_SIZE_64)) {
                throw new UndumperException("size_t size mismatch");
            } else {
                IsSizeofCSizeT8 = header.sizetSize == CSIZET_SIZE_64;
            }
            if (header.instructionSize != INSTRUCTION_SIZE) {
                throw new UndumperException("instruction size mismatch");
            }
            if (header.luaIntegerSize != LUA_INTEGER_SIZE) {
                throw new UndumperException("lua_Integer size mismatch");
            }
            if (header.luaNumberSize != LUA_NUMBER_SIZE) {
                throw new UndumperException("lua_Number size mismatch");
            }
            if (header.luacInt != LUAC_INT) {
                throw new UndumperException("endianness mismatch");
            }
            if (header.luacNum != LUAC_NUM) {
                throw new UndumperException("float format mismatch");
            }
        }

        private static Proto ReadProto(BinaryReader reader, string parentSource)
        {
            string source = ReadString(reader);
            if (source == "") {
                source = parentSource;
            }

            return new Proto
            {
                Source = source,
                LineDefined = reader.ReadUInt32(),
                LastLineDefined = reader.ReadUInt32(),
                numparams = reader.ReadByte(),
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

        private static Proto[] ReadProtos(BinaryReader reader, string parentSouce)
        {
            var protos = new Proto[reader.ReadUInt32()];
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

        private static TValue[] ReadConstants(BinaryReader reader)
        {
            var k = new TValue[reader.ReadUInt32()];
            for (int i = 0; i < k.Length; i++) {
                k[i] = ReadConstant(reader);
            }
            return k;
        }

        private static TValue ReadConstant(BinaryReader reader)
        {
            switch (reader.ReadByte()) {
                case TAG_NIL:
                    return new TValue();

                case TAG_BOOLEAN:
                    return new TValue(reader.ReadByte() != 0);

                case TAG_INTEGER:
                    return new TValue(ReadLuaInteger(reader));

                case TAG_NUMBER:
                    return new TValue(ReadLuaNumber(reader));

                case TAG_SHORT_STR:
                    return new TValue(ReadString(reader));

                case TAG_LONG_STR:
                    return new TValue(ReadString(reader));

                default:
                    throw new UndumperException("corrupted");
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

    public class UndumperException : Exception
    {
        public UndumperException(string msg) : base(msg)
        {
        }
    }
}