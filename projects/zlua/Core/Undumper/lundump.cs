using System;
using System.IO;
using System.Text;
using ZoloLua.Core.InstructionSet;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Core.Undumper
{
    /// <summary>
    ///     加载预编译chunk
    /// </summary>
    /// <remarks>
    ///     《Lua设计与实现》p57
    ///     <list type="bullet">
    ///         <item>chunk的数据格式是lua内部实现细节，并没有标准，以lua源代码实现为准</item>
    ///         <item>当校验失败时，简单地拒接chunk</item>
    ///         <item>chunk中字符串编码是utf8</item>
    ///         <item>
    ///             chunk数值类型规格表如下：
    ///             lua类型 | c语言类型 | c#类型 | 大小
    ///             ====== | ======== | ===== | ====
    ///             字节 | unsigned char | byte | 1
    ///             整数 | int | Int32 | 4
    ///             size_t | size_t | int | 4 or 8
    ///             LuaInteger | long long | Int64 | 8
    ///             LuaNumber | double | double | 8
    ///         </item>
    ///         <item>
    ///             chunk支持4B和8B的size_t大小，但zlua中使用int代替size_t
    ///             参见 https://stackoverflow.com/questions/32906774/what-is-equal-to-the-c-size-t-in-c-sharp
    ///             chunk使用的size_t时被cast到int，有抛出溢出异常的可能
    ///             这里只是用checked语法简单地保证抛出，但是概率很小，除非使用超过2G大小的数组
    ///         </item>
    ///     </list>
    /// </remarks>
    internal static class lundump
    {
        // chunk文件首字符，用于/loadfile/检查文件是否是chunk
        public const char FirstChar = '\x1b'; // LUA_SIGNATURE[0]


        // ASCII字符串 ESC L u a
        private const string LUA_SIGNATURE = "\x1bLua";

        private const byte LUAC_VERSION = 0x51;
        private const byte LUAC_FORMAT = 0;

        private const uint CINT_SIZE = 4;
        private const uint CSIZET_SIZE_32 = 4;
        private const uint CSIZET_SIZE_64 = 8;
        private const uint INSTRUCTION_SIZE = 4;
        private const uint LUA_NUMBER_SIZE = 8;

        // "\x19\x93\r\n\x1a\n"
        private static readonly byte[] LUAC_DATA = { 0x19, 0x93, 0x0d, 0x0a, 0x1a, 0x0a };
        private static readonly lua_Integer LUAC_INT = 0x5678;
        private static readonly lua_Number LUAC_NUM = 370.5f;


        public static bool IsSizeofCSizeT8 { get; private set; } = true;

        public static Proto Undump(Stream data)
        {
            using (BinaryReader reader = new BinaryReader(
                data, Encoding.UTF8)) {
                CheckHeader(reader);
                return ReadProto(reader, "");
            }
        }


        private static int ReadSizeT(BinaryReader reader)
        {
            if (IsSizeofCSizeT8)
                return checked((int)reader.ReadUInt64());
            return checked((int)reader.ReadUInt32());
        }

        private static string ReadString(BinaryReader reader)
        {
            // 确定字符串长度
            int size = ReadSizeT(reader);
            if (size == 0) return null;
            string s = new string(reader.ReadChars(size - 1));
            reader.ReadChar(); /* remove trailing '\0' */
            return s;
        }

        private static lua_Number ReadLuaNumber(BinaryReader reader)
        {
            return reader.ReadDouble();
        }


        private static void CheckHeader(BinaryReader reader)
        {
            //------------------------------
            //Pos   Hex Data           Description or Code
            //------------------------------------------------------------------------
            //0000 * *source chunk: luac.out
            //                         **global header start **
            //0000  1B4C7561 header signature: "\27Lua"
            //0004  51                 version(major: minor hex digits)
            //0005  00                 format(0 = official)
            //0006  01                 endianness(1 = little endian)
            //0007  04                 size of int(bytes)
            //0008  04                 size of size_t(bytes)
            //0009  04                 size of Instruction(bytes)
            //000A  08                 size of number(bytes)
            //000B  00                 integral(1 = integral)
            //                         * number type: double
            //                         * x86 standard(32 - bit, little endian, doubles)
            //                         * *global header end **
            var header = new
            {
                signature = Encoding.ASCII.GetString(reader.ReadBytes(4)),
                version = reader.ReadByte(),
                format = reader.ReadByte(),
                endianness = reader.ReadByte(),
                cintSize = reader.ReadByte(),
                sizetSize = reader.ReadByte(),
                instructionSize = reader.ReadByte(),
                luaNumberSize = reader.ReadByte(),
                numberFlag = reader.ReadByte()
            };

            if (header.signature != LUA_SIGNATURE) throw new UndumpException("not a precompiled header");
            if (header.version != LUAC_VERSION) throw new UndumpException("version mismatch");
            if (header.format != LUAC_FORMAT) throw new UndumpException("format mismatch");
            if (header.endianness != 1) throw new UndumpException("");
            if (header.cintSize != CINT_SIZE) throw new UndumpException("int size mismatch");
            if (!(header.sizetSize == CSIZET_SIZE_32 || header.sizetSize == CSIZET_SIZE_64))
                throw new UndumpException("size_t size mismatch");
            IsSizeofCSizeT8 = header.sizetSize == CSIZET_SIZE_64;
            if (header.instructionSize != INSTRUCTION_SIZE) throw new UndumpException("instruction size mismatch");
            if (header.luaNumberSize != LUA_NUMBER_SIZE) throw new UndumpException("lua_Number size mismatch");
            if (header.numberFlag != 0) throw new UndumpException("=?");
        }

        private static Proto ReadProto(BinaryReader reader, string parentSource)
        {
            string source = ReadString(reader);
            if (source == null) source = parentSource;
            Proto p = new Proto
            {
                source = source,
                linedefined = reader.ReadInt32(),
                lastlinedefined = reader.ReadInt32(),
                nups = reader.ReadByte(),
                numparams = reader.ReadByte(),
                is_vararg = reader.ReadByte(),
                maxstacksize = reader.ReadByte(),
                code = ReadCode(reader),
                k = ReadConstants(reader),
                p = ReadProtos(reader, source),
                lineinfo = ReadLineInfo(reader),
                locvars = ReadLocVars(reader),
                upvalues = ReadUpvalueNames(reader)
            };
            return p;
        }

        private static string[] ReadUpvalueNames(BinaryReader reader)
        {
            string[] names = new string[reader.ReadInt32()];
            for (int i = 0; i < names.Length; i++) names[i] = ReadString(reader);
            return names;
        }

        private static LocVar[] ReadLocVars(BinaryReader reader)
        {
            LocVar[] locVars = new LocVar[reader.ReadInt32()];
            for (int i = 0; i < locVars.Length; i++)
                locVars[i] = new LocVar
                {
                    varname = ReadString(reader),
                    startpc = reader.ReadInt32(),
                    endpc = reader.ReadInt32()
                };
            return locVars;
        }

        private static int[] ReadLineInfo(BinaryReader reader)
        {
            int[] lineInfo = new int[reader.ReadInt32()];
            for (int i = 0; i < lineInfo.Length; i++) lineInfo[i] = reader.ReadInt32();
            return lineInfo;
        }

        private static Proto[] ReadProtos(BinaryReader reader, string parentSouce)
        {
            Proto[] protos = new Proto[reader.ReadInt32()];
            for (int i = 0; i < protos.Length; i++) protos[i] = ReadProto(reader, parentSouce);
            return protos;
        }

        private static UpVal[] ReadUpvalues(BinaryReader reader)
        {
            UpVal[] upvals = new UpVal[reader.ReadUInt32()];
            for (int i = 0; i < upvals.Length; i++)
                upvals[i] = new UpVal
                {
                    Instack = reader.ReadByte(),
                    Idx = reader.ReadByte()
                };
            return upvals;
        }

        private static TValue[] ReadConstants(BinaryReader reader)
        {
            TValue[] k = new TValue[reader.ReadInt32()];
            for (int i = 0; i < k.Length; i++) k[i] = ReadConstant(reader);
            return k;
        }

        private static TValue ReadConstant(BinaryReader reader)
        {
            switch ((LuaType)reader.ReadByte()) {
                case LuaType.LUA_TNIL:
                    return new TValue();

                case LuaType.LUA_TBOOLEAN:
                    return new TValue(reader.ReadByte() != 0);

                case LuaType.LUA_TNUMBER:
                    return new TValue(ReadLuaNumber(reader));

                case LuaType.LUA_TSTRING:
                    return new TValue(ReadString(reader));

                default:
                    throw new UndumpException("bad constant");
            }
        }

        private static Bytecode[] ReadCode(BinaryReader reader)
        {
            Bytecode[] code = new Bytecode[reader.ReadInt32()];
            for (int i = 0; i < code.Length; i++) code[i] = new Bytecode(reader.ReadUInt32());
            return code;
        }
    }

    public class UndumpException : Exception
    {
        public UndumpException(string msg) : base(msg)
        {
        }
    }
}