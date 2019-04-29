using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// lstate模块
    /// </summary>
    public partial class lua_State : GCObject
    {
        byte status;
        /// <summary>
        /// l_G
        /// </summary>
        global_State G;

        /// <summary>
        /// number of nested C calls
        /// </summary>
        UInt16 nCcalls;

        /// <summary>
        /// nested C calls when resuming coroutine
        /// </summary>
        UInt16 baseCcalls;

        /// <summary>
        /// table of globals
        /// l_gt
        /// </summary>
        TValue gt;

        /// <summary>
        /// temporary place for environments
        /// </summary>
        TValue env;

        TValue registry { get { return G.l_registry; } }

        /// <summary>
        /// lua_newstate
        /// </summary>
        public static lua_State lua_newstate()
        {
            lua_State L = new lua_State();
            global_State g = new global_State();
            L.G = g;
            g.mainthread = L;
            //g->uvhead.u.l.prev = &g->uvhead;
            //g->uvhead.u.l.next = &g->uvhead;
            // f_luaopen
            L.gt = new TValue(new Table(0, 2));
            L.registry.Table = new Table(0, 2);
            L.luaT_init();
            return L;
        }
    }
}
