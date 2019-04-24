using zlua.Core.Lua;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// `global state', shared by all threads of this state
    /// </summary>
#pragma warning disable IDE1006 // Naming Styles
    internal class global_State
#pragma warning restore IDE1006 // Naming Styles
    {
        public TValue registry = new TValue(new Table(sizeHashTablePart: 2, sizeArrayPart: 0));

        //internal TThread mainThread;
        internal Table[] metaTableForBasicType = new Table[(int)LuaType.LUA_TTHREAD + 1];

        internal LuaString[] metaMethodNames = new LuaString[(int)TMS.TM_N];
    }
}
