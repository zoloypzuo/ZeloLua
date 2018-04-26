using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua {
    using TValue = Lua.lua_TValue;
    using lua_Number = System.Double;
    /// <summary>
    /// some generic functions over lua objects (lobject.c）
    /// 1. interface] TValue, and other 9 specific types  
    /// 2. GC不实现，使用C# GC
    /// </summary>
    partial class Lua {
       
        /// <summary>
        /// (C# simulated) union of all lua values
        /// how it simulate union?: use extra fields
        /// size: 8+8+4=20B
        /// differ from clua: light userdata is removed because C# use GC
        /// TODO如何访问修饰符不被外卖呢看到
        /// </summary>
        public class Value {
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
            public int i { get; set; }
        }
        /// <summary>
        /// the general type of lua. T means "tagged" 
        /// </summary>
        public class lua_TValue {
            public Value value = new Value();
            /// <summary>
            /// type tag, defined in lua.cs
            /// </summary>
            public LuaType type;
        }
        /// <summary>
        /// TODO:搞清楚怎么回事，既然C# lua不分GC，那么简单实现？问题在于很可能要等到你实现交互再解决
        /// </summary>
        public class Userdata:GCObject {
            public Table metatable;
            public Table env;
        }
        /// <summary>
        /// the function prototype type of lua
        /// </summary>
        public class FuncProto:GCObject {
            public TValue[] constants;
            public Instruction[] codes;
            public FuncProto[] inner_funcprotos;
            //public int[] lineinfo; //TOUnderstand
            public LocVar[] locvars;
            public TString[] upvalues;
            //public TString[] source;//TOUnderStand
            //public int linedefined;
            //public int lastlinedefined;
            //public GCObject gclist;
            //public byte nups;
            //public byte numparams;
            //public byte is_vararg;
            //public byte maxstacksize;
        }


        public class LocVar {
            public TString varname;
            public int startpc; //TOUnderstancs
            public int endpc;
        }




        /*
        ** Closures
        */
        public class CClosure {
            public GCObject next;
            public byte tt;
            public byte marked;
            public byte isC;
            public byte nupvalues;
            public GCObject gclist;
            public Table env;
            public lua_CFunction f;
            public lua_TValue[] upvalue = Arrays.InitializeWithDefaultInstances<lua_TValue>(1);
        }
        public class LClosure {
            public GCObject next;
            public byte tt;
            public byte marked;
            public byte isC;
            public byte nupvalues;
            public GCObject gclist;
            public Table env;
            public Proto[] p;
            public UpVal[] upvals = Arrays.InitializeWithDefaultInstances<UpVal>(1);
        }
        //[StructLayout(LayoutKind.Explicit)]
        //public struct Closure {
        //    [FieldOffset(0)]
        //    public CClosure c;
        //    [FieldOffset(0)]
        //    public LClosure l;
        //}
        ///*
        //** Tables
        //*/
        //public struct TKey {
        //    public class AnonymousClass4 {
        //        public Value value = new Value();
        //        public int tt;
        //        public Node next;
        //    }
        //    public AnonymousClass4 nk;
        //    public lua_TValue tvk;
        //}
        //public class Node {
        //    public lua_TValue i_val = new lua_TValue();
        //    public TKey i_key = new TKey();
        //}
        /// <summary>
        /// TODO: use dictionary如果不实现的话
        /// TOUnderstand
        /// </summary>
        public class Table : GCObject {
            public byte flags;
            public byte lsizenode;
            public Table metatable;
            public lua_TValue[] array;
            /// <summary>
            /// TOUnderstand 没什么软用的类
            /// </summary>
            public Node[] node;
            public Node lastfree; //int in Kopi,why?
            public GCObject gclist;
            public int sizearray;
        }
        /// <summary>
        /// upvalue type
        /// </summary>
        public class UpVal : GCObject {
            public lua_TValue v; //points to stack or to its own value
            /// <summary>
            /// 匿名类
            /// </summary>
            public class _u {  //原来这里是union，TODO，TOUnderstand：自己打算怎么实现，他是怎么实现的，名字要改
                public TValue value = new TValue();  /* the value (when closed) */

                public class _l {  /* double linked list (when open) */
                    public UpVal prev;
                    public UpVal next;
                };

                public _l l = new _l();
            }
            public new _u u = new _u();
        }

        ///// <summary>
        ///// string header
        ///// </summary>
        //public class TString_tsv : GCObject {
        //    public lu_byte reserved;
        //    public uint hash;
        //    public uint len;
        //};
        /// <summary>
        /// the string type of lua, just warpper of C# string
        /// </summary>
        public class TString:GCObject /*: TString_tsv*/ {
            //public L_Umaxalign dummy;  /* ensures maximum alignment for strings */			
            //public TString_tsv tsv { get { return this; } }

            public TString(string str) { this.str = str; }
            public string str;
            //public override string ToString() { return str.ToString(); } // for debugging
        };
    }
}
