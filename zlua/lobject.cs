using System;
using System.Collections.Generic;
using System.Diagnostics;
using zlua.VM;
using zlua.ISA;
using zlua.Stdlib;
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
        /* <lua_src> 
           #define setttype(obj, tt) (ttype(obj) = (tt))
           #define ttype(o)	((o)->tt)
        </lua_src>*/
        LuaTypes type { get; set; }

        public override string ToString()
        {
            switch (type) {
                case LuaTypes.Nil: return "nil";
                case LuaTypes.Number: return n.ToString();
                case LuaTypes.Boolean: return b.ToString();
                case LuaTypes.String: return tstr.ToString();
                default: return "要么补充，要么看watch下拉去吧";
            }
        }

        /// <summary>
        /// ctor is private ie. must use following factorys
        /// </summary>
        private TValue()
        {

        }

        #region factorys

        public static TValue nil_factory() => new TValue();
        static TValue tstring_factory(string s)
        {
            var _ret = new TValue() {
                type = LuaTypes.String,
                gc = new TString(s)
            };
            return _ret;
        }
        static TValue runtime_func_factory(Proto func)
        {
            var _ret = new TValue() {
                type = LuaTypes.Proto,
                gc = new Closure(func)
            };
            return _ret;
        }

        public static TValue compiled_func_factory(Proto compiledFunction)
        {
            var _ret = new TValue {
                type = LuaTypes.Proto,
                gc = compiledFunction
            };
            return _ret;
        }
        static TValue i_factory(int i)
        {
            var _ret = new TValue {
                type = LuaTypes.Int,
                i = i
            };
            return _ret;
        }
        static TValue b_factory(bool b)
        {
            var _ret = new TValue {
                type = LuaTypes.Boolean,
                b = b
            };
            return _ret;
        }
        static TValue n_factory(TNumber n)
        {
            var _ret = new TValue() {
                type = LuaTypes.Number,
                n = n
            };
            return _ret;
        }
        /*TODO 我目前认为值类型这样比较自然（string也是）。引用不该。*/
        public static implicit operator TValue(string str) => tstring_factory(str);
        public static implicit operator TValue(bool b) => b_factory(b);
        public static implicit operator TValue(int i) => i_factory(i);
        public static implicit operator TValue(TNumber n) => n_factory(n);
        public static implicit operator string(TValue tval) => tval.tstr;
        public static implicit operator TString(TValue tval) => tval.tstr;
        public static implicit operator bool(TValue tval) => tval.b;
        public static implicit operator int(TValue tval) => tval.i;
        public static implicit operator TNumber(TValue tval) => tval.n;
        #endregion
        #region propertys to get or set value
        /* <lua_src>
        // #define gcvalue(o)	check_exp(iscollectable(o), (o)->value.gc)
        // #define pvalue(o)	check_exp(ttislightuserdata(o), (o)->value.p)
        // #define nvalue(o)	check_exp(ttisnumber(o), (o)->value.n)
        // #define rawtsvalue(o)	check_exp(ttisstring(o), &(o)->value.gc->ts)
        // #define tsvalue(o)	(&rawtsvalue(o)->tsv)
        // #define rawuvalue(o)	check_exp(ttisuserdata(o), &(o)->value.gc->u)
        // #define uvalue(o)	(&rawuvalue(o)->uv)
        // #define clvalue(o)	check_exp(ttisfunction(o), &(o)->value.gc->cl)
        // #define hvalue(o)	check_exp(ttistable(o), &(o)->value.gc->h)
        // #define bvalue(o)	check_exp(ttisboolean(o), (o)->value.b)
        // #define thvalue(o)	check_exp(ttisthread(o), &(o)->value.gc->th)
        </lua_src>*/

        // # getter APIs are divided into 2 parts: value types use implicit cast operator
        //   and reference types use simple property (ie. method) TODO not right
        
        // 1. note that this is private, because string is someway more like value type
        // 2. rawtsvalue, tsvalue is not needed because C# string is used as subsititute
        TString tstr { get { Stdlib.Stdlib.assert(tt_is_string); return gc.tstr; } } 
        public Proto compiled_func { get { Stdlib.Stdlib.assert(tt_is_proto); return gc.compiled_func; } }

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
        




        #endregion
        #region operators
        public static TValue operator +(TValue lhs, TValue rhs)
        {

            Debug.Assert(lhs.type == rhs.type);
            return TValue.n_factory(lhs.n + rhs.n);
        }

        public static TValue operator *(TValue lhs, TValue rhs)
        {
            Debug.Assert(lhs.type == rhs.type);
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
        /* <lua_src>
        // #define ttisnil(o)	(ttype(o) == LUA_TNIL)
        // #define ttisnumber(o)	(ttype(o) == LUA_TNUMBER)
        // #define ttisstring(o)	(ttype(o) == LUA_TSTRING)
        // #define ttistable(o)	(ttype(o) == LUA_TTABLE)
        // #define ttisfunction(o)	(ttype(o) == LUA_TFUNCTION)
        // #define ttisboolean(o)	(ttype(o) == LUA_TBOOLEAN)
        // #define ttisuserdata(o)	(ttype(o) == LUA_TUSERDATA)
        // #define ttisthread(o)	(ttype(o) == LUA_TTHREAD)
        // #define ttislightuserdata(o)	(ttype(o) == LUA_TLIGHTUSERDATA)
        </lua_src>*/
        public bool tt_is_nil { get => type == LuaTypes.Nil; }
        public bool tt_is_string { get => type == LuaTypes.String; }
        public bool tt_is_proto { get => type == LuaTypes.Proto; }
        public bool tt_is_boolean { get => type == LuaTypes.Boolean; }
        #endregion
        #region other functions
        /* <lua_src> #define iscollectable(o)	(ttype(o) >= LUA_TSTRING)*/
        public bool is_collectable { get => (int)type >= (int)LuaTypes.String; }
        /* <lua_src> #define l_isfalse(o)	(ttisnil(o) || (ttisboolean(o) && bvalue(o) == 0))*/
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
        public static readonly TValue nil = new TValue { type = LuaTypes.Nil };
        #endregion

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
        public List<TValue> consts; //k
        public List<Instruction> codes;
        public List<LocVar> local_vars;
    }
    public class LocVar { public string var_name;public int startpc;public int endpc; }
    public class FuncState
    {
        Proto f;
        Dictionary<string, TConst> consts;
        FuncState prev;
    }
    public class TConst { TNumber n;TString tstr; }
    /* <lua_src> union Closure<lua_src>*/
    public class Closure : GCObject
    {
        public Proto func;
        public int ret_addr;
        public Dictionary<TString, TValue> local_data = new Dictionary<TString, TValue>();
        public Stack<TValue> stack = new Stack<TValue>();
        public Closure(Proto func)
        {
            this.func = func;
        }
    }
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
    /* <lua_src>
     union GCObject {
       GCheader gch;
       union TString ts;
       union Udata u;
       union Closure cl;
       struct Table h;
       struct Proto p;
       struct UpVal uv;
       struct lua_State th;
     };
    </lua_src>*/
    /// <summary>
    /// base class of all GC objects
    /// </summary>
    public class GCObject
    {
        /// <summary>
        /// for convenience (eg. TString is subclass of GCObject）
        /// </summary>
        public TString tstr { get { return this as TString; } }
        public TTable table { get { return this as TTable; } }
        public UpValue upval { get { return this as UpValue; } }
        public TThread thread { get { return this as TThread; } }
        public Proto compiled_func { get { return this as Proto; } }
        public Closure runtime_func { get { return this as Closure; } }
    }




    /* <lua_src>     typedef struct Table {       CommonHeader;       lu_byte flags;  /* 1<<p means tagmethod(p) is not present 
       lu_byte lsizenode;  /* log2 of size of `node' array        struct Table * metatable;
       TValue* array;  /* array part 
       Node* node;
       Node* lastfree;  /* any free position is before this position 
       GCObject* gclist;
       int sizearray;  /* size of `array' array 
     } Table;
    </lua_src> */
    public class TTable : GCObject
    {
        byte flags;
        TTable metatable;
        Dictionary<TValue, TValue> hash_table;

        /* <lua_src> Table *luaH_new (lua_State *L, int narray, int nhash) </lua_src>*/
        public TTable(TThread L, int nhash)
        {

        }
        /*<lua_src> const TValue *luaH_get (Table *t, const TValue *key) </lua_src>*/
        public TValue get(TValue key) => hash_table[key];
        /* <lua_src> TValue *luaH_set (lua_State *L, Table *t, const TValue *key) </lua_src>*/
        public TValue set(TThread L, TValue key)
        {
            return null;
        }
    }
    public class UpValue : GCObject
    {

    }
}
