using zlua.Core.Lua;
using zlua.Core.ObjectModel;
using zlua.Core.VirtualMachine;

namespace zlua.Core.VirtualMachine
{
    public partial class lua_State
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
        private TValue GetMetamethod(TValue obj, TMS metamethodType)
        {
            Table metatable;
            switch (obj.Type) {
                case LuaType.LUA_TTABLE:
                    metatable = obj.Table.metatable;
                    break;

                //case LuaType.Userdata:
                //    metatable = obj.Userdata.metaTable;
                //    break;

                default:
                    metatable = globalState.metaTableForBasicType[(int)obj.Type];
                    break;
            }
            return metatable != null ?
                metatable.GetByStr(globalState.metaMethodNames[(int)metamethodType]) :
                TValue.NilObject;
        }


        /// call_binTM; result = __add(lhs, rhs); __add从lhs和rhs的元表查找出，如果都没找到返回false
        private bool trybinTM(TValue lhs, TValue rhs, TValue result, TMS metamethodType)
        {
            result = null;
            TValue metamethod = GetMetamethod( lhs, metamethodType);
            if (metamethod.IsNil)
                metamethod = GetMetamethod( rhs, metamethodType);
            if (metamethod.IsNil)
                return false;
            result.Value = callTMres(metamethod, lhs, rhs);
            return true;
        }

        /// callTMres
        /// `metamethod(lhs, rhs)
        /// 使用lua通用调用协议，可以去Ido.Call的文档看；调用后top恢复到原处，就像没有调用过一样
        private TValue callTMres(TValue metamethod, TValue lhs, TValue rhs)
        {
            /* push func and 2 args*/
            Stack[top++].Value = metamethod;
            Stack[top++].Value = lhs;
            Stack[top++].Value = rhs;
            Call(top - 3);
            return Stack[--top]; //TODO call做了什么，result放在哪里
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