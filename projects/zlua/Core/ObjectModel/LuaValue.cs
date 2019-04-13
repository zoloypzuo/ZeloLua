using Newtonsoft.Json;

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

using zlua.Core.Lua;
using zlua.Core.VirtualMachine;

namespace zlua.Core.ObjectModel
{
    // lua对象
    //
    // * 大小8+8+4=20B
    //   指针大小4B或8B
    //   enum大小默认4B，可以设置，但是没必要，现在的样子是对齐的
    //
    // TODO light ud没了解足够，先不管
    public class TValue : IEquatable<TValue>
    {
        #region 嵌套类型定义

        // lua值类型
        //
        // * 大小8B
        // * 是union，这个特性不允许引用类型，所以TObject放在外面
        //   https://docs.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.structlayoutattribute?view=netframework-4.7.2
        [StructLayout(LayoutKind.Explicit)]
        private struct LuaNumeric
        {
            [FieldOffset(0)]
            public lua_Integer i;

            [FieldOffset(0)]
            public lua_Number n;

            [FieldOffset(0)]
            public bool b;
        }

        #endregion 嵌套类型定义

        #region 私有属性

        [JsonProperty]
        private LuaNumeric NumericValue { get; set; }

        #endregion 私有属性

        #region 公有属性

        // lua引用类型
        [JsonProperty]
        public LuaReference ReferenceValue { get; private set; }

        // 类型标签
        [JsonProperty]
        public LuaType Type { get; private set; }

        #endregion 公有属性

        #region 访问器与设置器

        [JsonIgnore]
        public lua_Number N {
            get {
                Debug.Assert(IsNumber);
                return NumericValue.n;
            }
            set {
                Type = LuaType.LUA_TNUMBER;
                NumericValue = new LuaNumeric { n = value };
            }
        }

        [JsonIgnore]
        public lua_Integer I {
            get {
                Debug.Assert(IsInteger);
                return NumericValue.i;
            }
            set {
                Type = LuaType.LUA_TNUMINT;
                NumericValue = new LuaNumeric { i = value };
            }
        }

        [JsonIgnore]
        public bool B {
            get {
                Debug.Assert(IsBool);
                return NumericValue.b;
            }
            set {
                Type = LuaType.LUA_TBOOLEAN;
                NumericValue = new LuaNumeric { b = value };
            }
        }

        [JsonIgnore]
        public TString TStr {
            get {
                Debug.Assert(IsString);
                return ReferenceValue as TString;
            }
            set {
                Type = LuaType.LUA_TSTRING;
                ReferenceValue = value;
            }
        }

        [JsonIgnore]
        public string Str {
            get {
                Debug.Assert(IsString);
                return (ReferenceValue as TString).str;
            }
            set {
                Type = LuaType.LUA_TSTRING;
                var tstr = ReferenceValue as TString;
                if (tstr != null) {
                    tstr.str = value;
                } else {
                    ReferenceValue = new TString(value);
                }
            }
        }

        public Closure Cl {
            get {
                return ReferenceValue as Closure;
            }
            set {
                Type = LuaType.LUA_TFUNCTION;
                ReferenceValue = value;
            }
        }

        public lua_State Thread {
            get { return ReferenceValue as lua_State; }
            set {
                Type = LuaType.LUA_TTHREAD;
                ReferenceValue = value;
            }
        }

        public Table Table {
            get { return ReferenceValue as Table; }
            set {
                Type = LuaType.LUA_TTABLE;
                ReferenceValue = value;
            }
        }

        //public Userdata Userdata
        //{
        //    get => (Userdata)this;
        //    set
        //    {
        //        Type = LuaTypes.Userdata;
        //        tobj = value;
        //    }
        //}

        // 拷贝函数
        public TValue Value {
            set {
                Type = value.Type;
                NumericValue = value.NumericValue;
                if (value.IsCollectable)
                    ReferenceValue = value.ReferenceValue;
                else
                    ReferenceValue = null;
            }
        }

        public void SetNil()
        {
            Type = LuaType.LUA_TNIL;
            ReferenceValue = null;
        }

        #endregion 访问器与设置器

        #region 构造函数

        // 构造nil
        public TValue()
        {
            Type = LuaType.LUA_TNIL;
        }

        public TValue(lua_Number n)
        {
            Type = LuaType.LUA_TNUMBER;
            NumericValue = new LuaNumeric { n = n };
        }

        public TValue(lua_Integer i)
        {
            Type = LuaType.LUA_TNUMINT;
            NumericValue = new LuaNumeric { i = i };
        }

        public TValue(bool b)
        {
            Type = LuaType.LUA_TBOOLEAN;
            NumericValue = new LuaNumeric { b = b };
        }

        public TValue(string s)
        {
            Type = LuaType.LUA_TSTRING;
            ReferenceValue = new TString(s);
        }

        public TValue(TString tstr)
        {
            Type = LuaType.LUA_TSTRING;
            ReferenceValue = tstr;
        }

        public TValue(Table table)
        {
            Type = LuaType.LUA_TTABLE;
            ReferenceValue = table;
        }

        public TValue(lua_State thread)
        {
            Type = LuaType.LUA_TTHREAD;
            ReferenceValue = thread;
        }

        public TValue(Userdata userdata)
        {
            Type = LuaType.LUA_TUSERDATA;
            ReferenceValue = userdata;
        }

        public TValue(Closure closure)
        {
            Type = LuaType.LUA_TFUNCTION;
            ReferenceValue = closure;
        }

        #endregion 构造函数

        #region 类型谓词

        public bool IsNil { get { return Type == LuaType.LUA_TNIL; } }
        public bool IsInteger { get { return Type == LuaType.LUA_TNUMINT; } }
        public bool IsNumber { get { return Type == LuaType.LUA_TNUMBER; } }
        public bool IsString { get { return Type == LuaType.LUA_TSTRING; } }
        public bool IsTable { get { return Type == LuaType.LUA_TTABLE; } }
        public bool IsProto { get { return Type == LuaType.LUA_TFUNCTION; } }
        public bool IsBool { get { return Type == LuaType.LUA_TBOOLEAN; } }
        public bool IsUserdata { get { return Type == LuaType.LUA_TUSERDATA; } }
        public bool IsThread { get { return Type == LuaType.LUA_TTHREAD; } }
        public bool IsLightUserdata { get { return Type == LuaType.LUA_TLIGHTUSERDATA; } }
        public bool IsCSharpFunction { get { return Type == LuaType.LUA_TFUNCTION && ReferenceValue is CSharpClosure; } }
        public bool IsLuaFunction { get { return Type == LuaType.LUA_TFUNCTION && ReferenceValue is LuaClosure; } }
        public bool IsFunction { get { return Type == LuaType.LUA_TFUNCTION; } }

        #endregion 类型谓词

        #region 其他方法

        public bool IsCollectable { get { return (int)Type >= (int)LuaType.LUA_TSTRING; } }

        // lua值都可以作为条件测试，只有false和nil是条件为假
        public bool IsFalse { get { return IsNil || IsBool && B == false; } }

        // lua值都可以作为条件测试，只有false和nil是条件为假
        public bool IsTrue { get { return !IsFalse; } }

        /// luaO_nilobject_; 单例
        public static readonly TValue NilObject = new TValue { Type = LuaType.LUA_TNIL };
        internal bool i;

        /// luaO_str2d; 简单地包装Parse，返回成功和double
        /// src返回bool用参数返回double，我改了】他除了了x结尾的”hex const“没空研究，放弃
        public static bool Str2Num(string s, out double n)
        {
            // 类似于这种地方，就暴露了LuaNumber是double
            // 然而这是没办法的。。
            // out LuaNumber时无法隐式转换，所以此函数参数使用out double，为了方便
            return Double.TryParse(s,out n);
        }

        #endregion 其他方法

        #region 重载基本方法

        // luaO_rawequalObj
        public bool Equals(TValue other)
        {
            if (Type != other.Type)
                return false;
            else
                switch (other.Type) {
                    case LuaType.LUA_TNIL:
                        return true;

                    case LuaType.LUA_TNUMBER:
                        return I == other.I;

                    case LuaType.LUA_TNUMINT:
                        return I == other.I;

                    case LuaType.LUA_TBOOLEAN:
                        return B == other.B;

                    case LuaType.LUA_TSTRING:
                        return Str == other.Str;

                    default:
                        Debug.Assert(other.IsCollectable);
                        return ReferenceValue == other.ReferenceValue;
                }
        }

        public override bool Equals(object obj)
        {
            return (obj is TValue) && Equals(obj as TValue);
        }

        public override int GetHashCode()
        {
            switch (Type) {
                case LuaType.LUA_TNUMBER: return N.GetHashCode();
                case LuaType.LUA_TNUMINT: return I.GetHashCode();
                case LuaType.LUA_TSTRING: return Str.GetHashCode();
                case LuaType.LUA_TBOOLEAN: return B.GetHashCode();
                default:
                    return ReferenceValue.GetHashCode();
            }
        }

        // TODO 懒得写了。。你调试时需要再写
        public override string ToString()
        {
            switch (Type) {
                case LuaType.LUA_TNONE:
                    break;

                case LuaType.LUA_TNIL:
                    break;

                case LuaType.LUA_TBOOLEAN:
                    break;

                case LuaType.LUA_TLIGHTUSERDATA:
                    break;

                case LuaType.LUA_TNUMBER:
                    break;

                case LuaType.LUA_TSTRING:
                    break;

                case LuaType.LUA_TTABLE:
                    break;

                case LuaType.LUA_TFUNCTION:
                    break;

                case LuaType.LUA_TUSERDATA:
                    break;

                case LuaType.LUA_TTHREAD:
                    break;

                case LuaType.LUA_TPROTO:
                    break;

                case LuaType.Upval:
                    break;

                case LuaType.LUA_TNUMINT:
                    break;
            }
            return Type.ToString();
        }

        #endregion 重载基本方法
    }
}