using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Newtonsoft.Json;
using ZoloLua.Core.Lua;
using ZoloLua.Core.VirtualMachine;

namespace ZoloLua.Core.ObjectModel
{
    // TODO light ud没了解足够，先不管
    /// <summary>
    ///     lua对象
    /// </summary>
    /// <remarks>TODO大小8+8+4=20B，其中指针大小4B或8B，enum大小默认4B，现在的样子是对齐的</remarks>
    public class TValue : IEquatable<TValue>
    {
        /// <summary>
        ///     构造nil
        /// </summary>
        public TValue()
        {
            tt = LuaTag.LUA_TNIL;
        }

        public TValue(lua_Number n)
        {
            tt = LuaTag.LUA_TNUMBER;
            NumericValue = new LuaNumeric { n = n };
        }

        public TValue(bool b)
        {
            tt = LuaTag.LUA_TBOOLEAN;
            NumericValue = new LuaNumeric { b = b };
        }

        public TValue(string s)
        {
            tt = LuaTag.LUA_TSTRING;
            gc = new TString(s);
        }

        public TValue(TString tstr)
        {
            tt = LuaTag.LUA_TSTRING;
            gc = tstr;
        }

        public TValue(Table table)
        {
            tt = LuaTag.LUA_TTABLE;
            gc = table;
        }

        public TValue(lua_State thread)
        {
            tt = LuaTag.LUA_TTHREAD;
            gc = thread;
        }

        public TValue(Userdata userdata)
        {
            tt = LuaTag.LUA_TUSERDATA;
            gc = userdata;
        }

        public TValue(Closure closure)
        {
            tt = LuaTag.LUA_TFUNCTION;
            gc = closure;
        }

        /// <summary>
        ///     lua值类型的值
        /// </summary>
        [JsonProperty]
        private LuaNumeric NumericValue { get; set; }


        /// <summary>
        ///     lua引用类型的值
        /// </summary>
        [JsonProperty]
        public GCObject gc { get; private set; }

        /// <summary>
        ///     light userdata
        /// </summary>
        [JsonProperty]
        private object p { get; set; }

        /// <summary>
        ///     类型标签
        /// </summary>
        [JsonProperty]
        public LuaTag tt { get; private set; }


        [JsonIgnore]
        public lua_Number N {
            get {
                Debug.Assert(IsNumber);
                return NumericValue.n;
            }
            set {
                tt = LuaTag.LUA_TNUMBER;
                NumericValue = new LuaNumeric { n = value };
            }
        }

        [JsonIgnore]
        public bool B {
            get {
                Debug.Assert(IsBool);
                return NumericValue.b;
            }
            set {
                tt = LuaTag.LUA_TBOOLEAN;
                NumericValue = new LuaNumeric { b = value };
            }
        }

        [JsonIgnore]
        public TString TStr {
            get {
                Debug.Assert(IsString);
                return gc as TString;
            }
            set {
                tt = LuaTag.LUA_TSTRING;
                gc = value;
            }
        }

        [JsonIgnore]
        public string Str {
            get {
                Debug.Assert(IsString);
                return (gc as TString).str;
            }
            set {
                tt = LuaTag.LUA_TSTRING;
                TString tstr = gc as TString;
                if (tstr != null)
                    tstr.str = value;
                else
                    gc = new TString(value);
            }
        }

        [JsonIgnore]
        public Closure Cl {
            get {
                return gc as Closure;
            }
            set {
                tt = LuaTag.LUA_TFUNCTION;
                gc = value;
            }
        }

        [JsonIgnore]
        public lua_State Thread {
            get { return gc as lua_State; }
            set {
                tt = LuaTag.LUA_TTHREAD;
                gc = value;
            }
        }

        [JsonIgnore]
        public Table Table {
            get { return gc as Table; }
            set {
                tt = LuaTag.LUA_TTABLE;
                gc = value;
            }
        }

        [JsonIgnore]
        public Userdata Userdata {
            get {
                return gc as Userdata;
            }
            set {
                tt = LuaTag.LUA_TUSERDATA;
                gc = value;
            }
        }

        [JsonIgnore]
        public object LightUserdata {
            get {
                return p;
            }
            set {
                tt = LuaTag.LUA_TLIGHTUSERDATA;
                p = value;
            }
        }

        /// <summary>
        ///     拷贝函数
        /// </summary>
        [JsonIgnore]
        public TValue Value {
            set {
                tt = value.tt;
                NumericValue = value.NumericValue;
                if (value.IsCollectable)
                    gc = value.gc;
                else
                    gc = null;
            }
        }


        public bool IsNil {
            get {
                return tt == LuaTag.LUA_TNIL;
            }
        }

        public bool IsNumber {
            get {
                return tt == LuaTag.LUA_TNUMBER;
            }
        }

        public bool IsString {
            get {
                return tt == LuaTag.LUA_TSTRING;
            }
        }

        public bool IsTable {
            get {
                return tt == LuaTag.LUA_TTABLE;
            }
        }

        public bool IsProto {
            get {
                return tt == LuaTag.LUA_TFUNCTION;
            }
        }

        public bool IsBool {
            get {
                return tt == LuaTag.LUA_TBOOLEAN;
            }
        }

        public bool IsUserdata {
            get {
                return tt == LuaTag.LUA_TUSERDATA;
            }
        }

        public bool IsThread {
            get {
                return tt == LuaTag.LUA_TTHREAD;
            }
        }

        public bool IsLightUserdata {
            get {
                return tt == LuaTag.LUA_TLIGHTUSERDATA;
            }
        }

        public bool IsCSharpFunction {
            get {
                return tt == LuaTag.LUA_TFUNCTION && gc is CSharpClosure;
            }
        }

        public bool IsLuaFunction {
            get {
                return tt == LuaTag.LUA_TFUNCTION && gc is LuaClosure;
            }
        }

        public bool IsFunction {
            get {
                return tt == LuaTag.LUA_TFUNCTION;
            }
        }


        public bool IsCollectable {
            get {
                return (int)tt >= (int)LuaTag.LUA_TSTRING;
            }
        }

        /// <summary>
        ///     lua值都可以作为条件测试，只有false和nil是条件为假
        /// </summary>
        public bool IsFalse {
            get {
                return IsNil || IsBool && B == false;
            }
        }

        /// <summary>
        ///     lua值都可以作为条件测试，只有false和nil是条件为假
        /// </summary>
        public bool IsTrue {
            get {
                return !IsFalse;
            }
        }


        public bool Equals(TValue other)
        {
            return lobject.luaO_rawequalObj(this, other);
        }

        [DebuggerStepThrough]
        public void SetNil()
        {
            tt = LuaTag.LUA_TNIL;
            gc = null;
        }

        public override bool Equals(object obj)
        {
            return obj is TValue && Equals(obj as TValue);
        }

        public override int GetHashCode()
        {
            switch (tt) {
                case LuaTag.LUA_TNUMBER: return N.GetHashCode();
                case LuaTag.LUA_TSTRING: return Str.GetHashCode();
                case LuaTag.LUA_TBOOLEAN: return B.GetHashCode();
                default:
                    return gc.GetHashCode();
            }
        }

        public override string ToString()
        {
            switch (tt) {
                case LuaTag.LUA_TBOOLEAN:
                    return $"{tt} {B}";
                case LuaTag.LUA_TNUMBER:
                    return $"{tt} {N.Value}";
                case LuaTag.LUA_TSTRING:
                    return $"{tt} {Str}";
            }
            return tt.ToString();
        }

        /// <summary>
        ///     lua值类型
        /// </summary>
        /// <remarks>
        ///     <list>
        ///         <item>大小8B</item>
        ///         <item>
        ///             是union，这个特性不允许使用c#引用类型，所以放在外面
        ///             https://docs.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.structlayoutattribute?view=netframework-4.7.2
        ///         </item>
        ///     </list>
        /// </remarks>
        [StructLayout(LayoutKind.Explicit)]
        private struct LuaNumeric
        {
            [FieldOffset(0)]
            public lua_Number n;

            [FieldOffset(0)]
            public bool b;
        }
    }
}