// 类型模型

namespace zlua.Core.ObjectModel
{
    internal class lobject
    {
        /// luaO_nilobject_; 单例
        public static readonly TValue NilObject = new TValue();
    }

    internal class LocVar
    {
        public string VarName;
        public uint StartPc;
        public uint EndPc;
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class LuaReference
    {
    }

    //TODO
    public class Userdata : LuaReference
    {
        public Table metaTable;
        public Table env;
    }

    internal class UpVal : LuaReference
    {
        public TValue v;
        public byte Instack;
        public byte Idx;
    }
}