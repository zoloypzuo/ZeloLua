using zlua.Core.Lua;
using zlua.Core.ObjectModel;
using zlua.Core.VirtualMachine;

namespace zlua.Core.MetaMethod
{
    internal static class LTm  //src称为tagged method，不喜欢。。
    {
        public static readonly string[] names = new string[] {
            "__index", "__newindex",
            "__gc", "__mode", "__eq",
            "__add", "__sub", "__mul", "__div", "__mod",
            "__pow", "__unm", "__len", "__lt", "__le",
            "__concat", "__call"
        };

        /// <summary>
        /// luaT_gettmbyobj; get metamethod from `obj，
        /// obj没有元表或没有该元方法返回nilobject；enum和string一一对应，这里从enum开始
        /// </summary>
        public static LuaValue GetMetamethod(this LuaState L, LuaValue obj, TMS metamethodType)
        {
            TTable metatable;
            switch (obj.Type) {
                case LuaTypes.Table:
                    metatable = obj.Table.metatable;
                    break;

                //case LuaType.Userdata:
                //    metatable = obj.Userdata.metaTable;
                //    break;

                default:
                    metatable = L.globalState.metaTableForBasicType[(int)obj.Type];
                    break;
            }
            return metatable != null ?
                metatable.GetByStr(L.globalState.metaMethodNames[(int)metamethodType]) :
                LuaValue.NilObject;
        }
    }

    /*
    * WARNING: if you change the order of this enumeration,
    * grep "ORDER TM" and "ORDER OP"
    */
    enum TMS
    {
        TM_INDEX,
        TM_NEWINDEX,
        TM_GC,
        TM_MODE,
        TM_LEN,
        TM_EQ,  /* last tag method with fast access */
        TM_ADD,
        TM_SUB,
        TM_MUL,
        TM_MOD,
        TM_POW,
        TM_DIV,
        TM_IDIV,
        TM_BAND,
        TM_BOR,
        TM_BXOR,
        TM_SHL,
        TM_SHR,
        TM_UNM,
        TM_BNOT,
        TM_LT,
        TM_LE,
        TM_CONCAT,
        TM_CALL,
        TM_N        /* number of elements in the enum */
    }
}