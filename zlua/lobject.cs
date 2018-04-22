using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua {
    using TValue = Lua.lua_TValue;  //有些地方因为生成代码没用到
    using lua_Number = System.Double;
    /// <summary>
    /// some generic functions over lua objects (lobject.c in lua stc)
    /// </summary>
    partial class Lua {
        /// <summary>
        /// info for GC
        /// </summary>
        public class GCheader {
            public GCObject next;
            public byte tt;
            public byte marked;
        }
        /// <summary>
        /// (C# simulated) union of all lua values
        /// how it simulate union?:
        /// 1. p is actual value of the type
        /// 2. when p is used as a specific type of value, it is casted to the type, boxing and unboxing may happen 
        /// </summary>
        public class Value {
            /// <summary>
            /// gc is GC collectable object...
            /// </summary>
            public GCObject gc {
                get { return (GCObject)this.p; }
                set { this.p = value; }
            }
            /// <summary>
            /// in clua, p is light userdata, here used both as light userdata and to simulate union
            /// </summary>
            public object p;
            /// <summary>
            /// the number type of lua
            /// </summary>
            public lua_Number n {
                get { return (lua_Number)this.p; }
                set { this.p = (object)value; }
            }
            /// <summary>
            /// the int type of lua
            /// </summary>
            public int b {
                get { return (int)this.p; }
                set { this.p = (object)value; }
            }
        }
        /// <summary>
        /// the general type of lua. T means "tagged" 
        /// </summary>
        public class lua_TValue {
            public Value value = new Value();
            /// <summary>
            /// type tag. defined in lua.cs
            /// </summary>
            public int tt;
        }
        //public struct Udata {
        //    public L_Umaxalign dummy;
        //    public class AnonymousClass2 {
        //        public GCObject next;
        //        public byte tt;
        //        public byte marked;
        //        public Table metatable;
        //        public Table env;
        //        public size_t len = new size_t();
        //    }
        //    public AnonymousClass2 uv;
        //}
        ///*
        //** Function Prototypes
        //*/
        //public class Proto {
        //    public GCObject next;
        //    public byte tt;
        //    public byte marked;
        //    public lua_TValue[] k;
        //    public LUAI_UINT32[] code;
        //    public Proto[] p;
        //    public int[] lineinfo;
        //    public LocVar[] locvars;
        //    public TString[] upvalues;
        //    public TString[] source;
        //    public int sizeupvalues;
        //    public int sizek;
        //    public int sizecode;
        //    public int sizelineinfo;
        //    public int sizep;
        //    public int sizelocvars;
        //    public int linedefined;
        //    public int lastlinedefined;
        //    public GCObject gclist;
        //    public byte nups;
        //    public byte numparams;
        //    public byte is_vararg;
        //    public byte maxstacksize;
        //}
        ///* masks for new-style vararg */
        //public class LocVar {
        //    public TString varname;
        //    public int startpc;
        //    public int endpc;
        //}
        



        ///*
        //** Closures
        //*/
        //public class CClosure {
        //    public GCObject next;
        //    public byte tt;
        //    public byte marked;
        //    public byte isC;
        //    public byte nupvalues;
        //    public GCObject gclist;
        //    public Table env;
        //    public lua_CFunction f;
        //    public lua_TValue[] upvalue = Arrays.InitializeWithDefaultInstances<lua_TValue>(1);
        //}
        //public class LClosure {
        //    public GCObject next;
        //    public byte tt;
        //    public byte marked;
        //    public byte isC;
        //    public byte nupvalues;
        //    public GCObject gclist;
        //    public Table env;
        //    public Proto[] p;
        //    public UpVal[] upvals = Arrays.InitializeWithDefaultInstances<UpVal>(1);
        //}
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
        public class Table:GCObject {
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
            public class _u {
                public TValue value = new TValue();  /* the value (when closed) */

                public class _l {  /* double linked list (when open) */
                    public UpVal prev;
                    public UpVal next;
                };

                public _l l = new _l();
            }
            public new _u u = new _u();
        }

        /// <summary>
        /// string header
        /// </summary>
        public class TString_tsv : GCObject {
            public lu_byte reserved;
            public uint hash;
            public uint len;
        };
    public class TString : TString_tsv {
        //public L_Umaxalign dummy;  /* ensures maximum alignment for strings */			
        public TString_tsv tsv { get { return this; } }

        public TString()
        {
        }
        public TString(CharPtr str) { this.str = str; }

        public CharPtr str;

        public override string ToString() { return str.ToString(); } // for debugging
    };
}
}
