using System;
using System.Collections.Generic;

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
            //public int i { get; set; }  ???怎么区别？？？

            public bool b { get; set; }

        }
        /// <summary>
        /// the general type of lua. T means "tagged" 
        /// </summary>
        public class lua_TValue
        {
            public Value value;
            /// <summary>
            /// type tag, defined in lua.cs
            /// </summary>
            public LuaType type;
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
            public static lua_TValue NIL() => new lua_TValue();
            public static lua_TValue TString(string s)
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
            public static lua_TValue RuntimeFunc(CompiledFunction func)
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
            public static lua_TValue Bool(bool b)
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
        }
        /// <summary>
        /// "Proto in lua.c"
        /// proto is gcobject, but is not a primitive type
        /// </summary>
        public class CompiledFunction : GCObject
        {
            public List<string> param_names;
            public CompiledFunction parent;
            public List<AssembledInstr> instrs;
            public List<CompiledFunction> inner_funcs;
            public Dictionary<string, int> label2pc; //label table
        }
        /// <summary>
        /// "Clousure" in lua.c
        /// </summary>
        public class RuntimeFunc : GCObject
        {
            public CompiledFunction func;
            public int ret_addr;
            public Dictionary<string, lua_TValue> local_data;
            public List<lua_TValue> stack;
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
            //public lua_Thread thread { get { return this as lua_Thread; } }
            public CompiledFunction compiled_func { get { return this as CompiledFunction; } }
            public RuntimeFunc runtime_func { get { return this as RuntimeFunc; } }
        }
        public class AssembledInstr
        {
            string opcode;
            List<lua_TValue> operands;
            public override string ToString() => opcode + " " + string.Join(",", operands);
        }
    }
}
