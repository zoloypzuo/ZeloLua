// 类型模型

namespace zlua.Core.ObjectModel
{
    internal class lobject
    {
        /// <summary>
        /// 单例
        /// </summary>
        public static TValue luaO_nilobject { get; } = new TValue();
    }

    internal class LocVar
    {
        public string varname;
        public int startpc;
        public int endpc;
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class GCObject
    {
    }

    //TODO
    public class Userdata : GCObject
    {
        public Table metatable;
        public Table env;
    }

    internal class UpVal : GCObject
    {
        public TValue v;
        public byte Instack;
        public byte Idx;
    }
}