using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua {
    /// <summary>
    /// global state machine (lstate.c in lua src)
    /// </summary>
    partial class Lua {
        /// <summary>
        /// (C# simulated) union of GC objects
        /// how it simulates union:
        /// 1. inheritance graph: GCheader <- GCObject <- TString, Udata ...(all GC types of lua) 
        /// 2. GCObject use property to return specific type of value with polymorphic
        /// </summary>
        public class GCObject : GCheader {
            /// <summary>
            /// for convenience (eg. TString is subclass of GCObject
            /// </summary>
            public GCheader gch { get { return (GCheader)this; } }
            public TString ts { get { return (TString)this; } }
            public Udata u { get { return (Udata)this; } }
            public Closure cl { get { return (Closure)this; } }
            public Table h { get { return (Table)this; } }
            public Proto p { get { return (Proto)this; } }
            public UpVal uv { get { return (UpVal)this; } }
            public lua_State th { get { return (lua_State)this; } }
        };
        /// <summary>
        /// thread: both lua vm and lua coroutine is a "lua state"
        /// </summary>
        public class lua_State:GCObject {
            public byte status;
            public lua_TValue top; // first free slot in the stack
            public lua_TValue @base; // base of current function
            public global_State l_G;
            public CallInfo ci; // call info for current function
            public readonly UInt32 savedpc; // `savedpc' of current function
            public lua_TValue stack_last; // last free slot in the stack
            public lua_TValue stack; // stack base
            public CallInfo end_ci; // points after end of ci array
            public CallInfo base_ci; // array of CallInfo's
            public int stacksize;
            public int size_ci; // size of array `base_ci'
            public UInt16 nCcalls; // number of nested C calls
            public UInt16 baseCcalls; // nested C calls when resuming coroutine
            public byte hookmask;
            public byte allowhook;
            public int basehookcount;
            public int hookcount;
            //public lua_Hook hook;
            public lua_TValue l_gt = new lua_TValue(); // table of globals
            public lua_TValue env = new lua_TValue(); // temporary place for environments
            public GCObject openupval; // list of open upvalues in this stack
            public GCObject gclist;
            //public lua_longjmp errorJmp; // current error recover point
            //public ptrdiff_t errfunc = new ptrdiff_t(); // current error handling function (stack index)
        }
        /// <summary>
        /// information of a call
        /// </summary>
        public class CallInfo {
            public lua_TValue @base; // base for this function
            public lua_TValue func; // function index in the stack
            public lua_TValue top; // top for this function
            public readonly UInt32 savedpc;
            public int nresults; // expected number of results from this function
            //public int tailcalls; // number of tail calls lost under this entry
        }
        public class global_State {
            //public stringtable strt = new stringtable(); // hash table for strings
            //public lua_Alloc frealloc; // function to reallocate memory
            public object ud; // auxiliary data to `frealloc'
            public byte currentwhite;
            public byte gcstate; // state of garbage collector
            public int sweepstrgc; // position of sweep in `strt'
            public GCObject rootgc; // list of all collectable objects
            ///// <summary>
            ///// GC使用，TOUnderstand：kopi实现成了一个interface
            ///// </summary>
            //public GCObject[] sweepgc; // position of sweep in `rootgc'
            public GCObject gray; // list of gray objects
            public GCObject grayagain; // list of objects to be traversed atomically
            public GCObject weak; // list of weak tables (to be cleared)
            public GCObject tmudata; // last element of list of userdata to be GC
            //public Mbuffer buff = new Mbuffer(); // temporary buffer for string concatentation
            //public LUAI_UMEM GCthreshold = new LUAI_UMEM();
            //public LUAI_UMEM totalbytes = new LUAI_UMEM(); // number of bytes currently allocated
            //public LUAI_UMEM estimate = new LUAI_UMEM(); // an estimate of number of bytes actually in use
            //public LUAI_UMEM gcdept = new LUAI_UMEM(); // how much GC is `behind schedule'
            public int gcpause; // size of pause between successive GCs
            public int gcstepmul; // GC `granularity'
            //public lua_CFunction panic; // to be called in unprotected errors
            public lua_TValue l_registry = new lua_TValue();
            public lua_State mainthread;
            public UpVal uvhead = new UpVal(); // head of double-linked list of all open upvalues
            /// <summary>
            /// ... , LUA_TTHREAD+1 is number of all primitive types 
            /// </summary>
            public Table []mt=new Table[LUA_TTHREAD + 1]; // metatables for basic types
            public TString[] tmname = new TString[(int)TMS.TM_N];  /* array with tag-method names */
        }
    }
}
