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
        // mt for basic type
        internal Table[] mt = new Table[(int)LuaType.LUA_TTHREAD + 1];

        /// <summary>
        /// 元方法名字
        /// </summary>
        internal TString[] tmname = new TString[(int)TMS.TM_N];
    }
}