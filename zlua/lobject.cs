using System;
using System.Collections.Generic;
using System.Diagnostics;
using zlua.VM;
using zlua.ISA;
/// <summary>
/// lua类型模型
/// </summary>
namespace zlua.TypeModel
{
    using TNumber = Double;
    /// <summary>
    /// the general type of lua. T means "tagged". 
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
        /// size: 8+8+4=20Byte
        /// </summary>
        class Value
        {
            /// <summary>
            /// the GC collectable object
            /// </summary>
            public GCObject gc { get; set; }

            /// <summary>
            /// the number type of lua
            /// </summary>
            public TNumber n { get; set; }

            /// <summary>
            /// the int type of lua
            /// </summary>
            public int i { get; set; }  //用于index等

            public bool b { get; set; }

        }
        Value value;
        LuaType type;
        public override string ToString()
        {
            switch (type) {
                case LuaType.NIL: return "nil";
                case LuaType.NUMBER: return n.ToString();
                case LuaType.BOOLEAN: return b.ToString();
                case LuaType.STRING: return tstr.ToString();
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
        public static TValue tstring_factory(string s)
        {
            var _ret = new TValue() {
                type = LuaType.STRING,
                value = new Value {
                    gc = new TString(s)
                }
            };
            return _ret;
        }
        public static TValue runtime_func_factory(CompiledFunction func)
        {
            var _ret = new TValue() {
                type = LuaType.FUNCTION,
                value = new Value {
                    gc = new RuntimeFunction(func)
                }
            };
            return _ret;
        }
        public static TValue bool_factory(bool b)
        {
            var _ret = new TValue() {
                type = LuaType.BOOLEAN,
                value = new Value {
                    b = b  //注意 C# 能区分这两个b
                }
            };
            return _ret;
        }
        public static TValue compiled_func_factory(CompiledFunction compiledFunction)
        {
            var _ret = new TValue {
                type = LuaType.FUNCTION,
                value = new Value {
                    gc = compiledFunction
                }
            };
            return _ret;
        }
        public static TValue i_factory(int i)
        {
            var _ret = new TValue {
                type = LuaType.INT,
                value = new Value {
                    i = i
                }
            };
            return _ret;
        }
        public static TValue b_factory(bool b)
        {
            var _ret = new TValue {
                type = LuaType.BOOLEAN,
                value = new Value {
                    b = b
                }
            };
            return _ret;
        }
        public static TValue n_factory(TNumber n)
        {
            var _ret = new TValue() {
                type = LuaType.NUMBER,
                value = new Value {
                    n = n
                }
            };
            return _ret;
        }
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
        public TString tstr { get => value.gc.tstr; }
        public CompiledFunction compiled_func { get => value.gc.compiled_func; }
        public int i { get => value.i; }
        public TNumber n { get => value.n; }
        public bool b { get => value.b; }
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
        /*<lua_src>const TValue luaO_nilobject_;</lua_src>*/
        public static readonly TValue nil = new TValue { value = null, type = LuaType.NIL };
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
        public bool ttisnil() => type == LuaType.NIL;
        public bool ttisstring() => type == LuaType.STRING;
        #endregion
    }
    /* <lua_src> struct Proto; </lua_src>*/
    /// <summary>
    /// is gcobject, but is not a primitive type
    /// </summary>
    public class CompiledFunction : GCObject
    {
        public List<string> param_names;
        public CompiledFunction parent;
        public List<AssembledInstr> instrs = new List<AssembledInstr>();
        public List<CompiledFunction> inner_funcs = new List<CompiledFunction>();
        public Dictionary<string, int> label2pc = new Dictionary<string, int>(); //label table
        public CompiledFunction(CompiledFunction parent, List<string> param_names)
        {
            this.parent = parent;
            this.param_names = param_names;
        }
    }
    /* <lua_src> union Closure<lua_src>*/
    public class RuntimeFunction : GCObject
    {
        public CompiledFunction func;
        public int ret_addr;
        public Dictionary<TString, TValue> local_data = new Dictionary<TString, TValue>();
        public Stack<TValue> stack = new Stack<TValue>();
        public RuntimeFunction(CompiledFunction func)
        {
            this.func = func;
        }
    }
    /* <lua_src> union TString</lua_src>*/
    /// <summary>
    /// the string type of lua, just warpper of C# string
    /// </summary>
    public class TString : GCObject /*: TString_tsv*/
    {

        public TString(string str) { this.str = str; }
        public string str;
        public override string ToString() { return str.ToString(); } // for debugging
    }
    /* <lua_src>
    // union GCObject {
    //   GCheader gch;
    //   union TString ts;
    //   union Udata u;
    //   union Closure cl;
    //   struct Table h;
    //   struct Proto p;
    //   struct UpVal uv;
    //   struct lua_State th;
    // };
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
        public CompiledFunction compiled_func { get { return this as CompiledFunction; } }
        public RuntimeFunction runtime_func { get { return this as RuntimeFunction; } }
    }
    public class TTable : GCObject
    {

    }
    public class UpValue : GCObject
    {

    }
}
