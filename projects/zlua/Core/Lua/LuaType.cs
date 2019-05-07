namespace ZoloLua.Core.Lua
{
    /// <summary>
    ///     lua类型枚举
    /// </summary>
    public enum LuaTag
    {
        /// <summary>
        ///     无效索引对应的值的类型，表示没有值
        /// </summary>
        LUA_TNONE = -1,

        LUA_TNIL,
        LUA_TBOOLEAN,
        LUA_TLIGHTUSERDATA,
        LUA_TNUMBER,
        LUA_TSTRING,
        LUA_TTABLE,

        /// <summary>
        ///     C and Lua functions
        /// </summary>
        LUA_TFUNCTION,

        LUA_TUSERDATA,
        LUA_TTHREAD,

        #region Extra tags for non-values

        //LUA_TPROTO = lobj.LAST_TAG + 1, /* function prototypes */
        //LUA_TUPVAL = luaO.LAST_TAG + 2,
        //LUA_TDEADKEY = luaO.LAST_TAG + 3, /* removed keys in tables */

        #endregion Extra tags for non-values
    }
}