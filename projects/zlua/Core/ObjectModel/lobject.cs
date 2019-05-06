// 类型模型

namespace ZoloLua.Core.ObjectModel
{
    internal class lobject
    {
        /// <summary>
        ///     单例
        /// </summary>
        public static TValue luaO_nilobject { get; } = new TValue();
    }

    internal class LocVar
    {
        public int endpc;
        public int startpc;
        public string varname;
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class GCObject
    {
    }

    //TODO
    public class Userdata : GCObject
    {
        public Table env;
        public Table metatable;
    }

    internal class UpVal : GCObject
    {
        public byte Idx;
        public byte Instack;
        public TValue v;
    }
}