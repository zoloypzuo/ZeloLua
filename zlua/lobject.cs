using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace zlua
{
    using lua_Number = System.Double;

    /// <summary>
    /// some generic functions over lua objects (lobject.c）
    /// 1. interface] TValue, and other 9 specific types  
    /// 2. GC不实现，使用C# GC
    /// </summary>
    public partial class Lua
    {

        /// <summary>
        /// (C# simulated) union of all lua values
        /// how it simulate union?: use extra fields
        /// size: 8+8+4=20B
        /// differ from clua: light userdata is removed because C# use GC
        /// TODO如何访问修饰符不被外卖呢看到
        /// </summary>
        public class Value
        {
            /// <summary>
            /// the GC collectable object
            /// </summary>
            public GCObject gcobject { get; set; }

            /// <summary>
            /// the number type of lua
            /// </summary>
            public lua_Number n { get; set; }

            /// <summary>
            /// the int type of lua
            /// </summary>
            public int i { get; set; }  //用于index等

            public bool b { get; set; }

        }
        /// <summary>
        /// the general type of lua. T means "tagged" 
        /// method brief:
        /// 1. factory: return a new specified lua type value; cast C# type to lua type (eg. string => tstring)
        /// 2. property: get, set a specified lua type value
        /// 3. cast among lua types is not needed
        /// </summary>
        public class lua_TValue
        {
            Value value;
            /// <summary>
            /// type tag, defined in lua.cs
            /// </summary>
            LuaType type;
            public override string ToString()
            {
                if (type == LuaType.NIL) return "nil";
                else if (type == LuaType.NUMBER) return value.n.ToString();
                else if (type == LuaType.BOOLEAN) return value.b.ToString();
                else if (type == LuaType.STRING) return value.gcobject.tstring.ToString();
                else return "看watch下拉去吧";
            }
            /// <summary>
            /// ctor is private ie. must use following factorys
            /// </summary>
            private lua_TValue()
            {

            }
            public static lua_TValue nil_factory() => new lua_TValue();
            public static lua_TValue tstring_factory(string s)
            {
                var _ret = new lua_TValue()
                {
                    type = LuaType.STRING,
                    value = new Value
                    {
                        gcobject = new TString(s)
                    }
                };
                return _ret;
            }
            public static lua_TValue runtime_func_factory(CompiledFunction func)
            {
                var _ret = new lua_TValue()
                {
                    type = LuaType.FUNCTION,
                    value = new Value
                    {
                        gcobject = new RuntimeFunc(func)
                    }
                };
                return _ret;
            }
            public static lua_TValue bool_factory(bool b)
            {
                var _ret = new lua_TValue()
                {
                    type = LuaType.BOOLEAN,
                    value = new Value
                    {
                        b = b  //注意 C# 能区分这两个b
                    }
                };
                return _ret;
            }
            public bool is_tstring() => type == LuaType.STRING;
            public static lua_TValue compiled_func_factory(CompiledFunction compiledFunction)
            {
                var _ret = new lua_TValue
                {
                    type = LuaType.FUNCTION,
                    value = new Value
                    {
                        gcobject = compiledFunction
                    }
                };
                return _ret;
            }
            public string str { get => value.gcobject.tstring.str; }
            public CompiledFunction compiled_func { get => value.gcobject.compiled_func; }
            public int i { get => value.i; }
            public static lua_TValue i_factory(int i){
                var _ret = new lua_TValue
                {
                    type = LuaType.INT,
                    value = new Value
                    {
                        i=i
                    }
                };
                return _ret;
            }
            public static lua_TValue operator +(lua_TValue lhs, lua_TValue rhs)
            {
                Debug.Assert(lhs.type == rhs.type);
                return lua_TValue.n_factory(lhs.n + rhs.n);
            }
            public lua_Number n { get => value.n; }
            public static lua_TValue n_factory(lua_Number n)
            {
                var _ret = new lua_TValue()
                {
                    type = LuaType.NUMBER,
                    value = new Value
                    {
                        n = n
                    }
                };
                return _ret;
            }
            public static lua_TValue operator *(lua_TValue lhs, lua_TValue rhs)
            {
                Debug.Assert(lhs.type == rhs.type);
                return n_factory(lhs.n * rhs.n);
            }
            public static lua_TValue and(lua_TValue lhs,lua_TValue rhs)
            {
                return b_factory(lhs.b && rhs.b);
            }
            public static lua_TValue eq(lua_TValue lhs,lua_TValue rhs)
            {
                return b_factory(lhs.b == rhs.b);
            }
            public bool b { get => value.b; }
            public static lua_TValue b_factory(bool b)
            {
                var _ret = new lua_TValue
                {
                    type = LuaType.BOOLEAN,
                    value = new Value
                    {
                        b = b
                    }
                };
                return _ret;
            }
        }

        /// <summary>
        /// "Proto in lua.c"
        /// proto is gcobject, but is not a primitive type
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
        /// <summary>
        /// "Clousure" in lua.c
        /// </summary>
        public class RuntimeFunc : GCObject
        {
            public CompiledFunction func;
            public int ret_addr;
            public Dictionary<string, lua_TValue> local_data = new Dictionary<string, lua_TValue>();
            public Stack<lua_TValue> stack = new Stack<lua_TValue>();
            public RuntimeFunc(CompiledFunction func)
            {
                this.func = func;
            }
        }
        /// <summary>
        /// the string type of lua, just warpper of C# string
        /// </summary>
        public class TString : GCObject /*: TString_tsv*/
        {
            //public L_Umaxalign dummy;  /* ensures maximum alignment for strings */			
            //public TString_tsv tsv { get { return this; } }

            public TString(string str) { this.str = str; }
            public string str;
            //public override string ToString() { return str.ToString(); } // for debugging
        };
        /// <summary>
        /// (C# simulated) union of GC objects
        /// how it simulates union: polymorphic
        /// 1. inheritance graph: GCheader > GCObject > TString, Udata ... (all GC types of lua) 
        /// 2. GCObject use property to return specific type of value with polymorphic
        /// </summary>
        public class GCObject
        {
            /// <summary>
            /// for convenience (eg. TString is subclass of GCObject）
            /// </summary>
            public TString tstring { get { return this as TString; } }
            //public Table h { get { return (Table)this; } }
            //public UpVal uv { get { return (UpVal)this; } }
            public lua_Thread thread { get { return this as lua_Thread; } }
            public CompiledFunction compiled_func { get { return this as CompiledFunction; } }
            public RuntimeFunc runtime_func { get { return this as RuntimeFunc; } }
        }

    }
}
