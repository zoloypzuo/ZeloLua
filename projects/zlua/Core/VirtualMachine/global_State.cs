using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;
using static ZoloLua.Core.VirtualMachine.lua_State;

namespace ZoloLua.Core.VirtualMachine
{
    /// <summary>
    /// `global state', shared by all threads of this state
    /// </summary>
    internal class global_State
    {
        public lua_CFunction panic;  /* to be called in unprotected errors */
        public TValue l_registry;
        public lua_State mainthread;
        public UpVal uvhead;  /* head of double-linked list of all open upvalues */
        /// <summary>
        /// metatables for basic types
        /// </summary>
        public Table[] mt;
        /// <summary>
        /// 元方法名字
        /// array with tag-method names
        /// </summary>
        public TString[] tmname;

        public global_State()
        {
            mt = new Table[luaO.NUM_TAGS];
            tmname = new TString[(int)TMS.TM_N];
            l_registry = new TValue();
        }
    }
}