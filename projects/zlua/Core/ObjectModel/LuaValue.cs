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
    public class LuaValue : IEquatable<LuaValue>
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
            public LuaInteger i;

            [FieldOffset(0)]
            public LuaNumber n;

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
        public LuaTypes Type { get; private set; }

        #endregion 公有属性

        #region 访问器与设置器

        [JsonIgnore]
        public LuaNumber N {
            get {
                Debug.Assert(IsNumber);
                return NumericValue.n;
            }
            set {
                Type = LuaTypes.Number;
                NumericValue = new LuaNumeric { n = value };
            }
        }

        [JsonIgnore]
        public LuaInteger I {
            get {
                Debug.Assert(IsInteger);
                return NumericValue.i;
            }
            set {
                Type = LuaTypes.Integer;
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
                Type = LuaTypes.Boolean;
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
                Type = LuaTypes.String;
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
                Type = LuaTypes.String;
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
                Type = LuaTypes.Function;
                ReferenceValue = value;
            }
        }

        public LuaState Thread {
            get { return ReferenceValue as LuaState; }
            set {
                Type = LuaTypes.Thread;
                ReferenceValue = value;
            }
        }

        public TTable Table {
            get { return ReferenceValue as TTable; }
            set {
                Type = LuaTypes.Table;
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
        public LuaValue TValue {
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
            Type = LuaTypes.Nil;
            ReferenceValue = null;
        }

        #endregion 访问器与设置器

        #region 构造函数

        // 构造nil
        public LuaValue()
        {
            Type = LuaTypes.Nil;
        }

        public LuaValue(LuaNumber n)
        {
            Type = LuaTypes.Number;
            NumericValue = new LuaNumeric { n = n };
        }

        public LuaValue(LuaInteger i)
        {
            Type = LuaTypes.Integer;
            NumericValue = new LuaNumeric { i = i };
        }

        public LuaValue(bool b)
        {
            Type = LuaTypes.Boolean;
            NumericValue = new LuaNumeric { b = b };
        }

        public LuaValue(string s)
        {
            Type = LuaTypes.String;
            ReferenceValue = new TString(s);
        }

        public LuaValue(TString tstr)
        {
            Type = LuaTypes.String;
            ReferenceValue = tstr;
        }

        public LuaValue(TTable table)
        {
            Type = LuaTypes.Table;
            ReferenceValue = table;
        }

        public LuaValue(LuaState thread)
        {
            Type = LuaTypes.Thread;
            ReferenceValue = thread;
        }

        public LuaValue(Userdata userdata)
        {
            Type = LuaTypes.Userdata;
            ReferenceValue = userdata;
        }

        public LuaValue(Closure closure)
        {
            Type = LuaTypes.Function;
            ReferenceValue = closure;
        }
        #endregion 构造函数

        #region 类型谓词

        public bool IsNil { get { return Type == LuaTypes.Nil; } }
        public bool IsInteger { get { return Type == LuaTypes.Integer; } }
        public bool IsNumber { get { return Type == LuaTypes.Number; } }
        public bool IsString { get { return Type == LuaTypes.String; } }
        public bool IsTable { get { return Type == LuaTypes.Table; } }
        public bool IsProto { get { return Type == LuaTypes.Function; } }
        public bool IsBool { get { return Type == LuaTypes.Boolean; } }
        public bool IsUserdata { get { return Type == LuaTypes.Userdata; } }
        public bool IsThread { get { return Type == LuaTypes.Thread; } }
        public bool IsLightUserdata { get { return Type == LuaTypes.LightUserdata; } }
        public bool IsCSharpFunction { get { return Type == LuaTypes.Function && ReferenceValue is CSharpClosure; } }
        public bool IsLuaFunction { get { return Type == LuaTypes.Function && ReferenceValue is LuaClosure; } }
        public bool IsFunction { get { return Type == LuaTypes.Function; } }

        #endregion 类型谓词

        #region 其他方法

        public bool IsCollectable { get { return (int)Type >= (int)LuaTypes.String; } }

        public bool IsFalse { get { return IsNil || IsBool && B == false; } }

        /// luaO_nilobject_; 单例
        public static readonly LuaValue NilObject = new LuaValue { Type = LuaTypes.Nil };

        /// luaO_str2d; 简单地包装Parse，返回成功和double
        /// src返回bool用参数返回double，我改了】他除了了x结尾的”hex const“没空研究，放弃
        public static double Str2Num(string s, out bool canBeConvertedToNum)
        {
            double _ret;
            canBeConvertedToNum = Double.TryParse(s, out _ret);
            return _ret;
        }

        #endregion 其他方法

        #region 重载基本方法

        // luaO_rawequalObj
        public bool Equals(LuaValue other)
        {
            if (Type != other.Type)
                return false;
            else
                switch (other.Type) {
                    case LuaTypes.Nil:
                        return true;

                    case LuaTypes.Number:
                        return I == other.I;

                    case LuaTypes.Integer:
                        return I == other.I;

                    case LuaTypes.Boolean:
                        return B == other.B;

                    case LuaTypes.String:
                        return Str == other.Str;

                    default:
                        Debug.Assert(other.IsCollectable);
                        return ReferenceValue == other.ReferenceValue;
                }
        }

        public override bool Equals(object obj)
        {
            return (obj is LuaValue) && Equals(obj as LuaValue);
        }

        public override int GetHashCode()
        {
            switch (Type) {
                case LuaTypes.Number: return N.GetHashCode();
                case LuaTypes.Integer: return I.GetHashCode();
                case LuaTypes.String: return Str.GetHashCode();
                case LuaTypes.Boolean: return B.GetHashCode();
                default:
                    return ReferenceValue.GetHashCode();
            }
        }

        // TODO 懒得写了。。你调试时需要再写
        public override string ToString()
        {
            switch (Type) {
                case LuaTypes.None:
                    break;

                case LuaTypes.Nil:
                    break;

                case LuaTypes.Boolean:
                    break;

                case LuaTypes.LightUserdata:
                    break;

                case LuaTypes.Number:
                    break;

                case LuaTypes.String:
                    break;

                case LuaTypes.Table:
                    break;

                case LuaTypes.Function:
                    break;

                case LuaTypes.Userdata:
                    break;

                case LuaTypes.Thread:
                    break;

                case LuaTypes.Proto:
                    break;

                case LuaTypes.Upval:
                    break;

                case LuaTypes.Integer:
                    break;
            }
            return Type.ToString();
        }

        #endregion 重载基本方法
    }
}