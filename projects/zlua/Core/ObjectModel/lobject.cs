// 类型模型

using System;
using System.Collections;
using System.Collections.Generic;

using zlua.Core.Lua;
using zlua.Core.VirtualMachine;

namespace zlua.Core.ObjectModel
{
    internal class LocVar
    {
        public string VarName;
        public uint StartPc;
        public uint EndPc;
    }

    // the string type of lua, just warpper of C# string
    public class LuaString : LuaReference
    {
        public LuaString(string str)
        {
            this.str = str;
        }

        public string str; //可以设置str，这样复用TString对象，因为只是个warpper，

        public override string ToString()
        {
            return str.ToString();
        }

        public override bool Equals(object obj)
        {
            return obj is LuaString && str.Equals((obj as LuaString).str);
        }

        public override int GetHashCode()
        {
            return str.GetHashCode();
        }

        public static implicit operator string(LuaString tstr) => tstr.str;

        public static implicit operator LuaString(string str) => new LuaString(str);

        public int Len { get { return str.Length; } }
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