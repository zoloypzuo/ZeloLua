using ZoloLua.Core.Lua;
using ZoloLua.Core.MetaMethod;
using ZoloLua.Core.TypeModel;
using static ZoloLua.Core.VirtualMachine.lua_State;

namespace ZoloLua.Core.VirtualMachine
{
    /// <summary>
    ///     `global state', shared by all threads of this state
    /// </summary>
    internal class global_State
    {
        public TValue l_registry;
        public lua_State mainthread;

        /// <summary>
        ///     metatables for basic types
        /// </summary>
        public Table[] mt;
        public lua_CFunction panic; /* to be called in unprotected errors */

        /// <summary>
        ///     元方法名字
        ///     array with tag-method names
        /// </summary>
        public TString[] tmname;
        public UpVal uvhead; /* head of double-linked list of all open upvalues */

        public global_State()
        {
            mt = new Table[lobject.NUM_TAGS];
            tmname = new TString[(int)TMS.TM_N];
            l_registry = new TValue();
        }
    }
}