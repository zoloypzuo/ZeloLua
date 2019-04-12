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
        public static LuaValue GetMetamethod(this LuaState L, LuaValue obj, MMType metamethodType)
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

    internal enum MMType
    {
        Index,
        NewIndex,
        GC,
        Mode,
        Eq,  /* last tag method with `fast' access */
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        Pow,
        Unm,
        Len,
        Lt,
        Le,
        Concat,
        Call,
        N     /* number of elements in the enum */ //仅用于标记大小。
    }
}