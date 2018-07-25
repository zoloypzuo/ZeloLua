using System;
using System.Collections.Generic;
using System.Diagnostics;
using zlua.VM;
using zlua.ISA;
using zlua.Stdlib;
using zlua.Configuration;
using System.Collections;

/// <summary>
/// 类型模型
/// </summary>
namespace zlua.TypeModel
{

    /// <summary>
    /// the general type of lua; T means "tagged";  size: TODO 8+8+4=20Byte
    /// 实现决策】Value完全展开，不用structLayout，因为不能一致，TObject是class，不能用
    /// light ud没了解足够，先不管
    /// </summary>
    public class TValue
    {
        #region value fields
        /// <summary>
        /// the reference type object
        /// </summary>
        TObject tobj;
        /// <summary>
        /// the number type of lua
        /// </summary>
        double n;
        /// <summary>
        /// the int type of lua
        /// </summary>
        bool b;
        #endregion
        /// <summary>
        /// the type tag; readonly externly, modified by setting `this as a specific value
        /// </summary>
        public LuaTypes Type { private set; get; }

        #region ctors getters setters
        public TValue()
        {
            Type = LuaTypes.Nil;
        }

        public TValue(TString tstr)
        {
            Type = LuaTypes.String;
            tobj = tstr;
        }
        public TValue(TTable table)
        {
            Type = LuaTypes.Table;
            tobj = table;
        }
        public TValue(bool b)
        {
            Type = LuaTypes.Boolean;
            this.b = b;
        }
        public TValue(double n)
        {
            Type = LuaTypes.Number;
            this.n = n;
        }
        public TValue(TThread thead)
        {
            Type = LuaTypes.Thread;
            this.tobj = Thread;
        }
        public TValue(Userdata userdata)
        {
            Type = LuaTypes.Userdata;
            tobj = userdata;
        }

        public static explicit operator TValue(string str) => new TValue((TString)str);
        public static explicit operator TValue(bool b) => new TValue(b);
        public static explicit operator TValue(double n) => new TValue(n);
        public static explicit operator TValue(TString tstr) => new TValue(tstr);
        public static explicit operator TValue(TTable table) => new TValue(table);
        public static explicit operator TValue(TThread thread) => new TValue(thread);
        public static explicit operator TValue(Userdata userdata)=>new TValue(userdata);

        public static explicit operator TString(TValue tval) { Debug.Assert(tval.IsString); return tval.tobj as TString; }
        public static explicit operator string(TValue tval) { Debug.Assert(tval.IsString); return (string)(TString)tval; }
        public static explicit operator bool(TValue tval) { Debug.Assert(tval.IsBool); return tval.b; }
        public static explicit operator double(TValue tval) { Debug.Assert(tval.IsNumber); return tval.n; }
        public static explicit operator TObject(TValue tval) => tval.tobj;
        public static explicit operator TTable(TValue tval) { Debug.Assert(tval.IsTable); return tval.tobj as TTable; }
        public static explicit operator Proto(TValue tval) { Debug.Assert(tval.IsLuaFunction); return tval.tobj as Proto; }
        public static explicit operator TThread(TValue tval) { Debug.Assert(tval.IsThread); return tval.tobj as TThread; }
        public static explicit operator Userdata(TValue tval) { Debug.Assert(tval.IsUserdata);return tval.tobj as Userdata; }
        public double N
        {
            get => (double)this;
            set
            {
                Type = LuaTypes.Number;
                n = value;
            }
        }
        public TString TStr
        {
            get => (TString)this;
            set
            {
                Type = LuaTypes.String;
                tobj = value;
            }
        }
        public TObject TObj
        {
            get => (TObject)this;
        }
        public string Str
        {
            get => (string)this;
            set
            {
                Type = LuaTypes.String;
                tobj = (TString)value;
            }
        }
        public Closure Cl
        {
            get => (Closure)this;
            set
            {
                Type = LuaTypes.Function;
                tobj = value;
            }
        }
        public bool B
        {
            get => (bool)this;
            set
            {
                Type = LuaTypes.Boolean;
                b = value;
            }
        }
        public TThread Thread
        {
            get => (TThread)this;
            set
            {
                Type = LuaTypes.Thread;
                tobj = value;
            }
        }
        public Proto P
        {
            get => (Proto)this;
            set
            {
                Type = LuaTypes.Function;
                tobj = value;
            }
        }
        public TTable Table
        {
            get => (TTable)this;
            set
            {
                Type = LuaTypes.Table;
                tobj = value;
            }
        }
        public Userdata Userdata
        {
            get => (Userdata)this;
            set
            {
                Type = LuaTypes.Userdata;
                tobj = value;
            }
        }
        public TValue TVal
        {
            get => this;
            set /*copy the value part and type part*/
            {
                Type = value.Type;
                tobj = value.tobj;
                n = value.n;
                b = value.b;
            }
        }
        public void SetNil() => Type = LuaTypes.Nil;
        #endregion
        #region operators

        #endregion
        #region propertys to test type 不做源代码引用，因为太简单了。不要浪费时间增加累赘
        public bool IsNil { get => Type == LuaTypes.Nil; }
        public bool IsNumber { get => Type == LuaTypes.Number; }
        public bool IsString { get => Type == LuaTypes.String; }
        public bool IsTable { get => Type == LuaTypes.Table; }
        public bool IsProto { get => Type == LuaTypes.Function; }
        public bool IsBool { get => Type == LuaTypes.Boolean; }
        public bool IsUserdata { get => Type == LuaTypes.Userdata; }
        public bool IsThread { get => Type == LuaTypes.Thread; }
        public bool IsLightUserdata { get => Type == LuaTypes.LightUserdata; }
        public bool IsCSharpFunction { get => Type == LuaTypes.Function && (tobj as Closure).IsCharp; }
        public bool IsLuaFunction { get => Type == LuaTypes.Function && !(tobj as Closure).IsCharp; }
        #endregion
        #region other functions
        public bool IsCollectable { get => (int)Type >= (int)LuaTypes.String; }
        public bool IsFalse { get => IsNil || IsBool && (bool)this == false; }
        /// <summary>
        /// luaO_nilobject_; 单例
        /// </summary>
        public static readonly TValue NilObject = new TValue { Type = LuaTypes.Nil };
        /// <summary>
        /// luaO_str2d; 简单地包装Parse，返回成功和double
        /// src返回bool用参数返回double，我改了】他除了了x结尾的”hex const“没空研究，放弃
        /// </summary>
        public static double Str2Num(string s, out bool canBeConvertedToNum)
        {
            double _ret;
            canBeConvertedToNum = Double.TryParse(s, out _ret);
            return _ret;
        }
        #endregion
        #region overload basic functions
        /// <summary>
        /// luaO_rawequalObj
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override bool Equals(object obj)
        {
            var other = obj as TValue;
            if (Type != other.Type) return false;
            else
                switch (other.Type) {
                    case LuaTypes.Nil: return true;
                    case LuaTypes.Number:
                        return (double)this == (double)other;
                    case LuaTypes.Boolean:
                        return (bool)this == (bool)other;
                    case LuaTypes.String:
                        return (string)this == (string)other;
                    default:
                        Debug.Assert(other.IsCollectable);
                        return (TObject)this == (TObject)other;
                }
        }
        public override int GetHashCode()
        {
            switch (Type) {
                case LuaTypes.Number: return ((double)this).GetHashCode();
                case LuaTypes.String: return ((TString)this).GetHashCode();
                case LuaTypes.Boolean: return ((bool)this).GetHashCode();
                default: return base.GetHashCode();
            }
        }

        public override string ToString()
        {
            var type = Type.ToString() + ": ";
            string more = " 要么补充，要么看watch下拉去吧";
            switch (Type) {
                case LuaTypes.None:
                    break;
                case LuaTypes.Nil:
                    return "Nil";
                    break;
                case LuaTypes.Boolean:
                    more = b.ToString();
                    break;
                case LuaTypes.LightUserdata:
                    break;
                case LuaTypes.Number:
                    more = n.ToString();
                    break;
                case LuaTypes.String:
                    more = Str.ToString();
                    break;
                case LuaTypes.Table:
                    break;
                case LuaTypes.Function:
                    break;
                case LuaTypes.Userdata:
                    break;
                case LuaTypes.Thread:
                    break;
            }
            return type + more;
        }
        #endregion
    }
    /// <summary>
    /// is gcobject, but is not a primitive type
    /// </summary>
    public class Proto : TObject
    {
        //public Proto parent;
        public List<Proto> inner_funcs = new List<Proto>();
        public List<TValue> k;
        public List<Bytecode> codes;
        public List<LocVar> locvars;
        public bool isVararg;
        public int maxStacksize;
        public int nParams;
        public int nUpvals;
    }
    //TODO
    public class LocVar { public string var_name; public int startpc; public int endpc; }
    //TODO
    public class FuncState
    {
        Proto f;
        Dictionary<string, TConst> consts;
        FuncState prev;
    }
    //TODO
    public class TConst { double n; TString tstr; }

    public class Closure : TObject
    {
        public bool IsCharp;
        public TTable env;
        public Closure(TTable env)
        {
            this.env = env;
            this.IsCharp = false;
        }
    }
    public class LuaClosure : Closure
    {
        public Proto p;
        public List<Upval> upvals;
        public int NUpvals { get => upvals.Count; }
        /// <summary>
        /// luaF_newLclosure
        /// called] f_parser in ldo.c; luaV_execute in lvm.c
        /// </summary>
        public LuaClosure(TTable env, int nUpvals, Proto p) : base(env)
        {
            this.p = p;
            upvals = new List<Upval>(nUpvals);
        }
    }
    public class CSharpClosure : Closure
    {
        public lua.CSharpFunction f;
        public List<TValue> upvals;
        public int NUpvals { get => upvals.Count; }
        public CSharpClosure() : base(null)
        {

        }
    }
    /// <summary>
    /// the string type of lua, just warpper of C# string
    /// </summary>
    public class TString : TObject
    {

        public TString(string str) { this.str = str; }
        string str;
        public override string ToString() { return str.ToString(); } // for debugging
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
    }
    /// <summary>
    /// GCObject; base class of all reference type objects in lua
    /// </summary>
    public class TObject
    {
    }
    //TODO
    public class Userdata : TObject
    {
        public TTable metaTable;
        public TTable env;
    }

    public class TTable : TObject, IEnumerable<KeyValuePair<TValue, TValue>>
    {
        public TTable metatable;
        Dictionary<TValue, TValue> hashTablePart;
        List<TValue> arrayPart;

        public TTable(int sizeArrayPart, int sizeHashTablePart)
        {
            hashTablePart = new Dictionary<TValue, TValue>(sizeHashTablePart);
            arrayPart = new List<TValue>(sizeArrayPart);
        }
        /// <summary>
        /// luaH_get
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public TValue Get(TValue key)
        {
            switch (key.Type) {
                case LuaTypes.Nil: return TValue.NilObject;
                case LuaTypes.String: return GetByStr((TString)key);
                case LuaTypes.Number:
                    double n = (double)key;
                    int k = (int)Math.Round(n);
                    if ((double)k == n) return GetByInt(k);
                    goto default; // sigh, must have break or return, so ...
                default:
                    if (hashTablePart.ContainsKey(key))
                        return hashTablePart[key];
                    return TValue.NilObject;
            }
        }
        /// <summary>
        /// luaH_set, return tvalue found with `key, 
        /// else create a new pair and return the new tvalue
        /// TODO try to return void, because "new TValue" and set outside is not controlable. bad smell.
        /// </summary>
        /// <param name="L"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        public TValue Set(TThread L, TValue key)
        {
            var tval = Get(key);
            if (tval != TValue.NilObject) return tval;
            else {
                Debug.Assert(key.IsNil, "table index is nil");
                Debug.Assert(key.IsNumber && luaconf.IsNaN((double)key), "table index is NaN");
                var new_val = new TValue();
                hashTablePart[key] = new_val;
                return new_val;
            }
        }
        public TValue GetByStr(TString key)
        {
            var k = (TValue)key;
            if (hashTablePart.ContainsKey(k))
                return hashTablePart[k];
            return TValue.NilObject;
        }
        /// <summary>
        /// luaH_getnum
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public TValue GetByInt(int key)
        {
            if (key - 1 < arrayPart.Count) return arrayPart[key - 1];
            else {
                double k = (double)key;
                if (hashTablePart.ContainsKey((TValue)key))
                    return hashTablePart[(TValue)k];
                return TValue.NilObject;
            }
        }
        TValue SetStr(TString key)
        {
            var tval = GetByStr(key);
            if (tval != TValue.NilObject)
                return tval;
            else {
                var new_val = new TValue();
                hashTablePart[(TValue)key] = new_val;
                return new_val;
            }
        }
        TValue SetInt(int key)
        {
            var tval = GetByInt(key);
            if (tval != TValue.NilObject) return tval;
            else {
                var new_val = new TValue();
                hashTablePart[(TValue)key] = new_val;
                return new_val; //TODO 这里是错的。应该有分配到arraypart的逻辑
            }
        }



        IEnumerator<KeyValuePair<TValue, TValue>> IEnumerable<KeyValuePair<TValue, TValue>>.GetEnumerator()
        {
            int index = 0;
            foreach (var item in arrayPart) {
                yield return new KeyValuePair<TValue, TValue>((TValue)(++index), item);
            }
            foreach (var item in hashTablePart) {
                yield return item;
            }
        }

        public IEnumerator GetEnumerator() => this.GetEnumerator();
    }
    //TODO
    public class Upval : TObject
    {
        public TValue val;
    }


}