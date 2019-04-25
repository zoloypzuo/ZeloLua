﻿// 类型模型

namespace zlua.Core.ObjectModel
{
    internal class lobject
    {
        /// luaO_nilobject_; 单例
        public static readonly TValue NilObject = new TValue();
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