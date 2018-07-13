using System;
using System.Collections.Generic;
using System.Diagnostics;
using zlua.VM;
using zlua.ISA;
using zlua.Stdlib;
using zlua.Configuration;
/// <summary>
/// lua类型模型
/// </summary>
namespace zlua.TypeModel
{
    using TNumber = Double;
    using TInteger = Int32;
    using Instruction = UInt32;
    /// <summary>
    /// the general type of lua. T means "tagged".  size: 8+8+4=20Byte
    /// methods brief:
    /// 1. factorys: return a new specified lua type value; cast C# type to lua type (eg. string => tstring)
    /// 2. propertys: get or set a specified lua type value
    /// 3. casts: among lua types; is not needed
    /// 4. operators: foo
    /// 5. propertys: test type
    /// </summary>
    public class TValue
    {

        /// <summary>
        /// the GC collectable object
        /// </summary>
        GCObject gc { get; set; }

        /// <summary>
        /// the number type of lua
        /// </summary>
        TNumber n { get; set; }

        /// <summary>
        /// the int type of lua
        /// </summary>
        TInteger i { get; set; }  //用于index等

        bool b { get; set; }

        public LuaTypes Type { get; set; }

        public override string ToString()
        {
            switch (Type) {
                case LuaTypes.Nil: return "nil";
                case LuaTypes.Number: return n.ToString();
                case LuaTypes.Boolean: return b.ToString();
                case LuaTypes.String: return Str.ToString();
                default: return "要么补充，要么看watch下拉去吧";
            }
        }

        public TValue()
        {

        }

        TValue(TString tstr)
        {
            Type = LuaTypes.String;
            gc = tstr;
        }
        #region factorys

        static TValue tstring_factory(string s)
        {
            var _ret = new TValue() {
                Type = LuaTypes.String,
                gc = new TString(s)
            };
            return _ret;
        }
        static TValue runtime_func_factory(Proto func)
        {
            var _ret = new TValue() {
                Type = LuaTypes.Function,
                gc = new Closure(func)
            };
            return _ret;
        }

        public static TValue compiled_func_factory(Proto compiledFunction)
        {
            var _ret = new TValue {
                Type = LuaTypes.Function,
                gc = compiledFunction
            };
            return _ret;
        }
        static TValue i_factory(int i)
        {
            var _ret = new TValue {
                Type = LuaTypes.Int,
                i = i
            };
            return _ret;
        }
        static TValue b_factory(bool b)
        {
            var _ret = new TValue {
                Type = LuaTypes.Boolean,
                b = b
            };
            return _ret;
        }
        static TValue n_factory(TNumber n)
        {
            var _ret = new TValue() {
                Type = LuaTypes.Number,
                n = n
            };
            return _ret;
        }
        /*TODO 我目前认为值类型这样比较自然（string也是）。引用不该。*/
        public static implicit operator TValue(string str) => tstring_factory(str);
        public static implicit operator TValue(bool b) => b_factory(b);
        public static implicit operator TValue(int i) => i_factory(i);
        public static implicit operator TValue(TNumber n) => n_factory(n);
        public static implicit operator string(TValue tval) => tval.Str;
        public static implicit operator TString(TValue tval) => tval.Str;
        public static explicit operator TValue(TString tstr) => new TValue(tstr);
        public static implicit operator bool(TValue tval) => tval.b;
        public static implicit operator int(TValue tval) => tval.i;
        public static implicit operator TNumber(TValue tval) => tval.n;
        public static explicit operator GCObject(TValue tval) => tval.gc;
        #endregion
        #region propertys to get or set value
        // # getter APIs are divided into 2 parts: value types use implicit cast operator
        //   and reference types use simple property (ie. method) TODO not right

        // 1. note that this is private, because string is someway more like value type
        // 2. rawtsvalue, tsvalue is not needed because C# string is used as subsititute
        TString Str { get { Stdlib.Stdlib.assert(tt_is_string); return gc.Str; } }
        public Proto Proto { get { Stdlib.Stdlib.assert(tt_is_proto); return gc.Proto; } }

        /* <lua_src>
        #define setobj(L,obj1,obj2) \
          { const TValue *o2=(obj2); TValue *o1=(obj1); \
            o1->value = o2->value; o1->tt=o2->tt; \
            checkliveness(G(L),o1); }

        #define setnilvalue(obj) ((obj)->tt=LUA_TNIL)

        #define setnvalue(obj,x) \
          { TValue *i_o=(obj); i_o->value.n=(x); i_o->tt=LUA_TNUMBER; }

        #define setpvalue(obj,x) \
          { TValue *i_o=(obj); i_o->value.p=(x); i_o->tt=LUA_TLIGHTUSERDATA; }

        #define setbvalue(obj,x) \
          { TValue *i_o=(obj); i_o->value.b=(x); i_o->tt=LUA_TBOOLEAN; }

        #define setsvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TSTRING; \
            checkliveness(G(L),i_o); }

        #define setuvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TUSERDATA; \
            checkliveness(G(L),i_o); }

        #define setthvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TTHREAD; \
            checkliveness(G(L),i_o); }

        #define setclvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TFUNCTION; \
            checkliveness(G(L),i_o); }

        #define sethvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TTABLE; \
            checkliveness(G(L),i_o); }

        #define setptvalue(L,obj,x) \
          { TValue *i_o=(obj); \
            i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TPROTO; \
            checkliveness(G(L),i_o); }
        <lua_src>*/

        // # L is still included in parameters in case of refactor
        //TODO




        #endregion
        #region operators
        public static TValue operator +(TValue lhs, TValue rhs)
        {

            Debug.Assert(lhs.Type == rhs.Type);
            return TValue.n_factory(lhs.n + rhs.n);
        }

        public static TValue operator *(TValue lhs, TValue rhs)
        {
            Debug.Assert(lhs.Type == rhs.Type);
            return n_factory(lhs.n * rhs.n);
        }
        public static TValue and(TValue lhs, TValue rhs)
        {
            return b_factory(lhs.b && rhs.b);
        }
        public static TValue eq(TValue lhs, TValue rhs)
        {
            return b_factory(lhs.b == rhs.b);
        }
        #endregion

        #region propertys to test type
        public bool tt_is_nil { get => Type == LuaTypes.Nil; }
        public bool tt_is_number { get => Type == LuaTypes.Number; }
        public bool tt_is_string { get => Type == LuaTypes.String; }
        public bool tt_is_table { get => Type == LuaTypes.Table; }
        public bool tt_is_proto { get => Type == LuaTypes.Function; }
        public bool tt_is_boolean { get => Type == LuaTypes.Boolean; }
        public bool tt_is_userdata { get => Type == LuaTypes.Userdata; }
        public bool tt_is_thread { get => Type == LuaTypes.Thread; }
        public bool tt_is_light_userdata { get => Type == LuaTypes.LightUserdata; }
        public bool is_cs_function { get => Type == LuaTypes.Function && (gc as Closure).IsCharp; }
        public bool is_lua_function { get => Type == LuaTypes.Function && !(gc as Closure).IsCharp; }
        #endregion
        #region other functions
        public bool is_collectable { get => (int)Type >= (int)LuaTypes.String; }
        public bool is_false { get => tt_is_nil || tt_is_boolean && this == false; }


        // NO NEED TO IMPLEMENT, about gc 
        /* <lua_src>
        // for internal debug only
        #define checkconsistency(obj) \
        lua_assert(!iscollectable(obj) || (ttype(obj) == (obj)->value.gc->gch.tt))

        #define checkliveness(g,obj) \
          lua_assert(!iscollectable(obj) || \
          ((ttype(obj) == (obj)->value.gc->gch.tt) && !isdead(g, (obj)->value.gc)))
        <lua_src>*/


        /*<lua_src>const TValue luaO_nilobject_;</lua_src>*/
        public static readonly TValue NilObject = new TValue { Type = LuaTypes.Nil };

        public int str2d(string s, TNumber result)
        {
            return 1;
        }
        #endregion
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
                        return (TNumber)this == (TNumber)other;
                    case LuaTypes.Boolean:
                        return (bool)this == (bool)other;
                    case LuaTypes.String:
                        return (TString)this == (TString)other;
                    default:
                        Debug.Assert(other.is_collectable);
                        return (GCObject)this == (GCObject)other;
                }
        }
        public override int GetHashCode()
        {
            switch (Type) {
                case LuaTypes.Number: return ((TNumber)this).GetHashCode();
                case LuaTypes.String: return ((TString)this).GetHashCode();
                case LuaTypes.Boolean: return ((bool)this).GetHashCode();
                default: return base.GetHashCode();
            }
        }
    }
    /* <lua_src> struct Proto; </lua_src>*/
    /// <summary>
    /// is gcobject, but is not a primitive type
    /// </summary>
    public class Proto : GCObject
    {
        public List<string> param_names;
        public Proto parent;
        public List<AssembledInstr> instrs = new List<AssembledInstr>();
        public List<Proto> inner_funcs = new List<Proto>();
        public Dictionary<string, int> label2pc = new Dictionary<string, int>(); //label table
        public Proto(Proto parent, List<string> param_names)
        {
            this.parent = parent;
            this.param_names = param_names;
        }
        public List<TValue> k;
        public List<Instruction> codes;
        public List<LocVar> local_vars;
        public bool is_vararg;
        public int max_stacksize;
    }
    public class LocVar { public string var_name; public int startpc; public int endpc; }
    public class FuncState
    {
        Proto f;
        Dictionary<string, TConst> consts;
        FuncState prev;
    }
    public class TConst { TNumber n; TString tstr; }
    /* <lua_src> union Closure<lua_src>*/
    public class Closure : GCObject
    {
        public bool IsCharp;
        public Proto func;
        public int ret_addr;
        public Dictionary<TString, TValue> local_data = new Dictionary<TString, TValue>();
        public Stack<TValue> stack = new Stack<TValue>();
        public Closure(Proto func)
        {
            this.func = func;
        }
    }
    //public class LuaClosure : Closure
    //{

    //}
    //public class CSharpClosure : Closure
    //{

    //}
    /* <lua_src> union TString</lua_src>*/
    /// <summary>
    /// the string type of lua, just warpper of C# string
    /// </summary>
    public class TString : GCObject
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
        public static implicit operator string(TString tstr) => tstr.str;
        public static implicit operator TString(string str) => new TString(str);
    }
    /// <summary>
    /// base class of all GC objects
    /// </summary>
    public class GCObject
    {
        /// <summary>
        /// for convenience (eg. TString is subclass of GCObject）
        /// </summary>
        public TString Str { get { return this as TString; } }
        public TTable Table { get { return this as TTable; } }
        public UpValue Upval { get { return this as UpValue; } }
        public TThread Thread { get { return this as TThread; } }
        public Proto Proto { get { return this as Proto; } }
        public Closure Closure { get { return this as Closure; } }
        public UserData UserData { get { return this as UserData; } }
    }
    public class UserData : GCObject
    {

    }

    public class TTable : GCObject
    {
        List<TValue> metatable;
        Dictionary<TValue, TValue> hashTablePart;
        List<TValue> arrayPart;

        public TTable(TThread L, int sizeHashTablePart, int sizeArrayPart)
        {
            hashTablePart = new Dictionary<TValue, TValue>(sizeHashTablePart);
            arrayPart = new List<TValue>(sizeArrayPart);
        }/// <summary>
         /// luaH_get
         /// </summary>
         /// <param name="key"></param>
         /// <returns></returns>
        public TValue Get(TValue key)
        {
            switch (key.Type) {
                case LuaTypes.Nil: return TValue.NilObject;
                case LuaTypes.String: return GetByStr(key);
                case LuaTypes.Number:
                    TNumber n = key;
                    int k = (int)Math.Round(n);
                    if ((TNumber)k == n) return GetByInt(k);
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
                Debug.Assert(key.tt_is_nil, "table index is nil");
                Debug.Assert(key.tt_is_number && luaconf.IsNaN(key), "table index is NaN");
                var new_key = new TValue();
                hashTablePart[key] = new_key;
                return new_key;
            }
        }
        TValue GetByStr(TString key)
        {
            var k = (TValue)key;
            if (hashTablePart.ContainsKey(k))
                return hashTablePart[k];
            return TValue.NilObject;
        }
        TValue GetByInt(int key)
        {
            if (key - 1 < arrayPart.Count) return arrayPart[key - 1];
            else {
                TNumber k = (TNumber)key;
                if (hashTablePart.ContainsKey(key))
                    return hashTablePart[k];
                return TValue.NilObject;
            }
        }
        TValue SetStr(TString key)
        {

        }
        TValue SetInt(int key)
        {
            var tval = GetByInt(key);
            if(tval!=TValue.NilObject)
        }
    }
    public class UpValue : GCObject
    {

    }


}