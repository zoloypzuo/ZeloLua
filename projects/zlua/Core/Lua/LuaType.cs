namespace ZoloLua.Core.Lua
{
    internal class luaO
    {
        public const int LAST_TAG = (int)LuaTag.LUA_TTHREAD;
        public const int NUM_TAGS = LAST_TAG + 1;
        /* Bit mark for collectable types */
        public const int BIT_ISCOLLECTABLE = 1 << 6;
        /* mark a tag as collectable */
        //internal static ctb(t)			((t) | BIT_ISCOLLECTABLE)
        /*
        ** number of all possible tags (including LUA_TNONE but excluding DEADKEY)
        */
        public const int LUA_TOTALTAGS = (int)LuaTag.LUA_TPROTO + 2;
    }

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

        LUA_TPROTO = luaO.LAST_TAG + 1, /* function prototypes */
        LUA_TUPVAL = luaO.LAST_TAG + 2,
        LUA_TDEADKEY = luaO.LAST_TAG + 3, /* removed keys in tables */

        #endregion Extra tags for non-values
    }
}