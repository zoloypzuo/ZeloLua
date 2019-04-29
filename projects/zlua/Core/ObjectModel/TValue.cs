using Newtonsoft.Json;

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

using zlua.Core.Lua;
using zlua.Core.VirtualMachine;

namespace zlua.Core.ObjectModel
{
    // TODO light ud没了解足够，先不管
    /// <summary>
    /// lua对象
    /// <list type="bullet">
    ///     <item>item1</item>
    ///     <item>item2</item>
    /// </list>
    /// </summary>
    /// <remarks>TODO大小8+8+4=20B，其中指针大小4B或8B，enum大小默认4B，现在的样子是对齐的</remarks>
    public class TValue : IEquatable<TValue>
    {
        #region 嵌套类型定义

        // TODO 删除int类型
        /// <summary>
        /// lua值类型
        /// </summary>
        /// <remarks>
        /// <list>
        ///     <item>大小8B</item>
        ///     <item>
        ///     是union，这个特性不允许引用类型，所以TObject放在外面
        ///     https://docs.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.structlayoutattribute?view=netframework-4.7.2
        ///     </item>
        /// </list>
        /// </remarks>
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
        public GCObject gc { get; private set; }

        /// <summary>
        /// light userdata
        /// </summary>
        [JsonProperty]
        private object p { get; set; }

        // 类型标签
        [JsonProperty]
        public LuaTag tt { get; private set; }

        #endregion 公有属性

        #region 访问器与设置器

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
                var tstr = gc as TString;
                if (tstr != null) {
                    tstr.str = value;
                } else {
                    gc = new TString(value);
                }
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
        /// 拷贝函数
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

        [DebuggerStepThrough]
        public void SetNil()
        {
            tt = LuaTag.LUA_TNIL;
            gc = null;
        }

        #endregion 访问器与设置器

        #region 构造函数

        // 构造nil
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

        #endregion 构造函数

        #region 类型谓词

        public bool IsNil { get { return tt == LuaTag.LUA_TNIL; } }
        public bool IsNumber { get { return tt == LuaTag.LUA_TNUMBER; } }
        public bool IsString { get { return tt == LuaTag.LUA_TSTRING; } }
        public bool IsTable { get { return tt == LuaTag.LUA_TTABLE; } }
        public bool IsProto { get { return tt == LuaTag.LUA_TFUNCTION; } }
        public bool IsBool { get { return tt == LuaTag.LUA_TBOOLEAN; } }
        public bool IsUserdata { get { return tt == LuaTag.LUA_TUSERDATA; } }
        public bool IsThread { get { return tt == LuaTag.LUA_TTHREAD; } }
        public bool IsLightUserdata { get { return tt == LuaTag.LUA_TLIGHTUSERDATA; } }
        public bool IsCSharpFunction { get { return tt == LuaTag.LUA_TFUNCTION && gc is CSharpClosure; } }
        public bool IsLuaFunction { get { return tt == LuaTag.LUA_TFUNCTION && gc is LuaClosure; } }
        public bool IsFunction { get { return tt == LuaTag.LUA_TFUNCTION; } }

        #endregion 类型谓词

        #region 其他方法

        public bool IsCollectable { get { return (int)tt >= (int)LuaTag.LUA_TSTRING; } }

        // lua值都可以作为条件测试，只有false和nil是条件为假
        public bool IsFalse { get { return IsNil || IsBool && B == false; } }

        // lua值都可以作为条件测试，只有false和nil是条件为假
        public bool IsTrue { get { return !IsFalse; } }

        internal bool i;

        /// luaO_str2d; 简单地包装Parse，返回成功和double
        /// src返回bool用参数返回double，我改了】他除了了x结尾的”hex const“没空研究，放弃
        public static bool Str2Num(string s, out double n)
        {
            // 类似于这种地方，就暴露了LuaNumber是double
            // 然而这是没办法的。。
            // out LuaNumber时无法隐式转换，所以此函数参数使用out double，为了方便
            return Double.TryParse(s, out n);
        }

        #endregion 其他方法

        #region 重载基本方法

        public static bool luaO_rawequalObj(TValue t1, TValue t2)
        {
            if (t1.tt != t2.tt) {
                return false;
            } else
                switch (t2.tt) {
                    case LuaTag.LUA_TNIL:
                        return true;

                    case LuaTag.LUA_TNUMBER:
                        return t1.N == t2.N;

                    case LuaTag.LUA_TBOOLEAN:
                        return t1.B == t2.B;

                    case LuaTag.LUA_TSTRING:
                        return t1.Str == t2.Str;

                    default:
                        Debug.Assert(t2.IsCollectable);
                        return t1.gc == t2.gc;
                }
        }

        public bool Equals(TValue other)
        {
            return luaO_rawequalObj(this, other);
        }

        public override bool Equals(object obj)
        {
            return (obj is TValue) && Equals(obj as TValue);
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

        // TODO 懒得写了。。你调试时需要再写
        public override string ToString()
        {
            switch (tt) {
                case LuaTag.LUA_TNONE:
                    break;

                case LuaTag.LUA_TNIL:
                    break;

                case LuaTag.LUA_TBOOLEAN:
                    break;

                case LuaTag.LUA_TLIGHTUSERDATA:
                    break;

                case LuaTag.LUA_TNUMBER:
                    break;

                case LuaTag.LUA_TSTRING:
                    return $"{tt} {Str}";

                case LuaTag.LUA_TTABLE:
                    break;

                case LuaTag.LUA_TFUNCTION:
                    break;

                case LuaTag.LUA_TUSERDATA:
                    break;

                case LuaTag.LUA_TTHREAD:
                    break;

                case LuaTag.LUA_TPROTO:
                    break;

                case LuaTag.LUA_TUPVAL:
                    break;

                case LuaTag.LUA_TDEADKEY:
                    break;

                default:
                    break;
            }
            return tt.ToString();
        }

        #endregion 重载基本方法
    }
}