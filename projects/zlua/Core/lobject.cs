// 类型模型

using Newtonsoft.Json;

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace zlua.Core
{
    // lua对象
    //
    // * 大小8+8+4=20B
    //   指针大小4B或8B
    //   enum大小默认4B，可以设置，但是没必要，现在的样子是对齐的
    //
    // TODO light ud没了解足够，先不管
    public class LuaObject : IEquatable<LuaObject>
    {
        #region 嵌套类型定义

        // lua值类型
        //
        // * 大小8B
        // * 是union，这个特性不允许引用类型，所以TObject放在外面
        //   https://docs.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.structlayoutattribute?view=netframework-4.7.2
        [StructLayout(LayoutKind.Explicit)]
        private struct Numeric
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
        private Numeric NumericValue { get; set; }

        #endregion 私有属性

        #region 公有属性

        // lua引用类型
        [JsonProperty]
        public TObject TObj { get; private set; }

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
                NumericValue = new Numeric { n = value };
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
                NumericValue = new Numeric { i = value };
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
                NumericValue = new Numeric { b = value };
            }
        }

        [JsonIgnore]
        public TString TStr {
            get {
                Debug.Assert(IsString);
                return TObj as TString;
            }
            set {
                Type = LuaTypes.String;
                TObj = value;
            }
        }

        [JsonIgnore]
        public string Str {
            get {
                Debug.Assert(IsString);
                return (TObj as TString).str;
            }
            set {
                Type = LuaTypes.String;
                // https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching
#pragma warning disable IDE0019 // Use pattern matching
                var tstr = TObj as TString;
#pragma warning restore IDE0019 // Use pattern matching
                if (tstr != null)
                    tstr.str = value;
                else
                    TObj = new TString(value);
            }
        }

        //public Closure Cl
        //{
        //    get => (Closure)this;
        //    set
        //    {
        //        Type = LuaTypes.Function;
        //        tobj = value;
        //    }
        //}

        //public TThread Thread
        //{
        //    get => (TThread)this;
        //    set
        //    {
        //        Type = LuaTypes.Thread;
        //        tobj = value;
        //    }
        //}

        //public Proto P
        //{
        //    get => (Proto)this;
        //    set
        //    {
        //        Type = LuaTypes.Function;
        //        tobj = value;
        //    }
        //}

        //public TTable Table
        //{
        //    get => (TTable)this;
        //    set
        //    {
        //        Type = LuaTypes.Table;
        //        tobj = value;
        //    }
        //}

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
        public LuaObject TVal {
            set {
                Type = value.Type;
                NumericValue = value.NumericValue;
                if (value.IsCollectable)
                    TObj = value.TObj;
                else
                    TObj = null;
            }
        }

        public void SetNil()
        {
            Type = LuaTypes.Nil;
            TObj = null;
        }

        #endregion 访问器与设置器

        #region 构造函数

        // 构造nil
        public LuaObject()
        {
            Type = LuaTypes.Nil;
        }

        public LuaObject(double n)
        {
            Type = LuaTypes.Number;
            NumericValue = new Numeric { n = new LuaNumber { Value = n } };
        }

        public LuaObject(LuaNumber n)
        {
            Type = LuaTypes.Number;
            NumericValue = new Numeric { n = n };
        }

        public LuaObject(Int64 i)
        {
            Type = LuaTypes.Integer;
            NumericValue = new Numeric { i = new LuaInteger { Value = i } };
        }

        public LuaObject(LuaInteger i)
        {
            Type = LuaTypes.Integer;
            NumericValue = new Numeric { i = i };
        }

        public LuaObject(bool b)
        {
            Type = LuaTypes.Boolean;
            NumericValue = new Numeric { b = b };
        }

        public LuaObject(string s)
        {
            Type = LuaTypes.String;
            TObj = new TString(s);
        }

        public LuaObject(TString tstr)
        {
            Type = LuaTypes.String;
            TObj = tstr;
        }

        public LuaObject(TTable table)
        {
            Type = LuaTypes.Table;
            TObj = table;
        }

        public LuaObject(TThread thread)
        {
            Type = LuaTypes.Thread;
            TObj = thread;
        }

        public LuaObject(Userdata userdata)
        {
            Type = LuaTypes.Userdata;
            TObj = userdata;
        }

        #endregion 构造函数

        #region 类型谓词

        public bool IsNil { get => Type == LuaTypes.Nil; }
        public bool IsInteger { get { return Type == LuaTypes.Integer; } }
        public bool IsNumber { get => Type == LuaTypes.Number; }
        public bool IsString { get => Type == LuaTypes.String; }
        public bool IsTable { get => Type == LuaTypes.Table; }
        public bool IsProto { get => Type == LuaTypes.Function; }
        public bool IsBool { get => Type == LuaTypes.Boolean; }
        public bool IsUserdata { get => Type == LuaTypes.Userdata; }
        public bool IsThread { get => Type == LuaTypes.Thread; }
        public bool IsLightUserdata { get => Type == LuaTypes.LightUserdata; }

        //public bool IsCSharpFunction { get => Type == LuaTypes.Function && (TObj as Closure) is CSharpClosure; }
        //public bool IsLuaFunction { get => Type == LuaTypes.Function && (TObj as Closure) is LuaClosure; }
        public bool IsFunction { get => Type == LuaTypes.Function; }

        #endregion 类型谓词

        #region 其他方法

        public bool IsCollectable { get => (int)Type >= (int)LuaTypes.String; }

        public bool IsFalse { get => IsNil || IsBool && B == false; }

        /// luaO_nilobject_; 单例
        public static readonly LuaObject NilObject = new LuaObject { Type = LuaTypes.Nil };

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
        public bool Equals(LuaObject other)
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
                        return TObj == other.TObj;
                }
        }

        public override bool Equals(object obj)
        {
            return (obj is LuaObject) && Equals(obj as LuaObject);
        }

        public override int GetHashCode()
        {
            switch (Type) {
                case LuaTypes.Number: return N.GetHashCode();
                case LuaTypes.Integer: return I.GetHashCode();
                case LuaTypes.String: return Str.GetHashCode();
                case LuaTypes.Boolean: return B.GetHashCode();
                default:
                    return TObj.GetHashCode();
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

    ///// <summary>
    ///// is gcobject, but is not a primitive type
    ///// </summary>
    //public class Proto : TObject
    //{
    //    //public Proto parent;
    //    internal List<Proto> pp = new List<Proto>();
    //    internal List<LuaObject> k = new List<LuaObject>();
    //    internal List<Bytecode> codes = new List<Bytecode>();

    //    /// <summary>
    //    /// 暂时这样
    //    /// </summary>
    //    internal int MaxStacksize { get => codes.Count; }
    //    internal int nParams;
    //    internal int nUpvals;

    //}
    //class ChunkProto : Proto
    //{
    //    internal List<string> strs = new List<string>();
    //    internal List<double> ns = new List<double>();
    //}
    //class LocVar
    //{
    //    public string var_name;
    //    public int startpc;
    //    public override string ToString()
    //    {
    //        return String.Join(", ", var_name, startpc);
    //    }
    //}

    //public class Closure : TObject
    //{
    //    public TTable env;
    //    public Closure(TTable env)
    //    {
    //        this.env = env;
    //    }
    //}
    //class LuaClosure : Closure
    //{
    //    public Proto p;
    //    public List<Upval> upvals;
    //    public int NUpvals { get => upvals.Count; }
    //    /// <summary>
    //    /// luaF_newLclosure
    //    /// called] f_parser in ldo.c; luaV_execute in lvm.c
    //    /// </summary>
    //    public LuaClosure(TTable env, int nUpvals, Proto p) : base(env)
    //    {
    //        this.p = p;
    //        upvals = new List<Upval>(nUpvals);
    //    }
    //}
    //class CSharpClosure : Closure
    //{
    //    public Lua.CSFunc f;
    //    public List<LuaObject> upvals;
    //    public int NUpvals { get => upvals.Count; }
    //    public CSharpClosure() : base(null)
    //    {
    //    }
    //}

    // the string type of lua, just warpper of C# string
    public class TString : TObject
    {
        public TString(string str)
        {
            this.str = str;
        }

        public string str; //可以设置str，这样复用TString对象，因为只是个warpper，

        public override string ToString()
        {
            return str.ToString();
        } // for debugging

        public override bool Equals(object obj)
        {
            return str.Equals((obj as TString)?.str);
        }

        public override int GetHashCode()
        {
            return str.GetHashCode();
        }

        public static explicit operator string(TString tstr) => tstr.str;

        public static explicit operator TString(string str) => new TString(str);

        public int Len { get => str.Length; }
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class TObject
    {
    }

    //TODO
    public class Userdata : TObject
    {
        public TTable metaTable;
        public TTable env;
    }

    public class TTable : TObject { }

    //public class TTable : TObject, IEnumerable<KeyValuePair<LuaObject, LuaObject>>
    //{
    //    public TTable metatable;
    //    Dictionary<LuaObject, LuaObject> hashTablePart;
    //    List<LuaObject> arrayPart;

    //    public TTable(int sizeArrayPart, int sizeHashTablePart)
    //    {
    //        hashTablePart = new Dictionary<LuaObject, LuaObject>(sizeHashTablePart);
    //        arrayPart = new List<LuaObject>(sizeArrayPart);
    //    }
    //    static int Double2Integer(double d)
    //       => (int)Math.Round(d, MidpointRounding.AwayFromZero); //目前来说只有这里需要用
    //    /// <summary>
    //    /// luaH_get
    //    /// </summary>
    //    public LuaObject Get(LuaObject key)
    //    {
    //        switch (key.Type) {
    //            case LuaTypes.Nil: return LuaObject.NilObject;
    //            case LuaTypes.String:
    //                return GetByStr((TString)key);
    //            case LuaTypes.Number:
    //                double n = (double)key;
    //                int k = Double2Integer(n);
    //                if ((double)k == n)
    //                    return GetByInt(k);
    //                goto default; // sigh, must have break or return, so ...
    //            default:
    //                if (hashTablePart.ContainsKey(key))
    //                    return hashTablePart[key];
    //                return LuaObject.NilObject;
    //        }
    //    }
    //    /// <summary>
    //    /// luaH_set, return tvalue found with `key,
    //    /// else create a new pair and return the new tvalue
    //    /// </summary>
    //    public LuaObject Set(TThread L, LuaObject key)
    //    {
    //        var tval = Get(key);
    //        if (tval != LuaObject.NilObject) return tval;
    //        else {
    //            Debug.Assert(key.IsNil, "table index is nil");
    //            Debug.Assert(key.IsNumber && Double.IsNaN((double)key), "table index is NaN");
    //            var new_val = new LuaObject();
    //            hashTablePart[key] = new_val;
    //            return new_val;
    //        }
    //    }
    //    public LuaObject GetByStr(TString key)
    //    {
    //        var k = (LuaObject)key;
    //        if (hashTablePart.ContainsKey(k))
    //            return hashTablePart[k];
    //        return LuaObject.NilObject;
    //    }
    //    /// <summary>
    //    /// luaH_getnum
    //    /// </summary>
    //    public LuaObject GetByInt(int key)
    //    {
    //        if (key - 1 < arrayPart.Count) return arrayPart[key - 1];
    //        else {
    //            double k = (double)key;
    //            if (hashTablePart.ContainsKey((LuaObject)key))
    //                return hashTablePart[(LuaObject)k];
    //            return LuaObject.NilObject;
    //        }
    //    }
    //    LuaObject SetStr(TString key)
    //    {
    //        var tval = GetByStr(key);
    //        if (tval != LuaObject.NilObject)
    //            return tval;
    //        else {
    //            var new_val = new LuaObject();
    //            hashTablePart[(LuaObject)key] = new_val;
    //            return new_val;
    //        }
    //    }
    //    LuaObject SetInt(int key)
    //    {
    //        var tval = GetByInt(key);
    //        if (tval != LuaObject.NilObject) return tval;
    //        else {
    //            var new_val = new LuaObject();
    //            hashTablePart[(LuaObject)key] = new_val;
    //            return new_val; //TODO 这里是错的。应该有分配到arraypart的逻辑
    //        }
    //    }
    //    /// <summary>
    //    /// luaH_getn; 返回一个int索引作为bound，本身不为空，下一个位置为空
    //    /// </summary>
    //    /// <returns></returns>
    //    public int GetN()
    //    {
    //        return 1;
    //    }

    //    IEnumerator<KeyValuePair<LuaObject, LuaObject>> IEnumerable<KeyValuePair<LuaObject, LuaObject>>.GetEnumerator()
    //    {
    //        int index = 0;
    //        foreach (var item in arrayPart) {
    //            yield return new KeyValuePair<LuaObject, LuaObject>((LuaObject)(++index), item);
    //        }
    //        foreach (var item in hashTablePart) {
    //            yield return item;
    //        }
    //    }

    //    public IEnumerator GetEnumerator() => this.GetEnumerator();
    //}
    public class Upval : TObject
    {
        public LuaObject val;
    }
}