namespace zlua.Core.Lua
{
    internal class luaO
    {
        public const int LUA_NUMTAGS = 9;
        /* Bit mark for collectable types */
        public const int BIT_ISCOLLECTABLE = 1 << 6;
        /* mark a tag as collectable */
        //internal static ctb(t)			((t) | BIT_ISCOLLECTABLE)
        /*
        ** number of all possible tags (including LUA_TNONE but excluding DEADKEY)
        */
        public const int LUA_TOTALTAGS = (int)LuaType.LUA_TPROTO + 2;
    }

    // lua类型枚举
    public enum LuaType
    {
        // 无效索引对应的值的类型，表示没有值
        LUA_TNONE = -1,

        LUA_TNIL,
        LUA_TBOOLEAN,
        LUA_TLIGHTUSERDATA,
        LUA_TNUMBER,
        LUA_TSTRING,
        LUA_TTABLE,

        // C and Lua functions
        LUA_TFUNCTION,

        LUA_TUSERDATA,
        LUA_TTHREAD,

        /*
        ** Extra tags for non-values
        */
        LUA_TPROTO = luaO.LUA_NUMTAGS,/* function prototypes */
        LUA_TDEADKEY = luaO.LUA_NUMTAGS + 1,/* removed keys in tables */
        Upval,

        // extra tags
        // lobject.h line 40
        /*
        ** tags for Tagged Values have the following use of bits:
        ** bits 0-3: actual tag (a LUA_T* value)
        ** bits 4-5: variant bits
        ** bit 6: whether value is collectable
        */
        /*
        ** LUA_TFUNCTION variants:
        ** 0 - Lua function
        ** 1 - light C function
        ** 2 - regular C function (closure)
        */
        /* Variant tags for functions */
        LUA_TLCL = LUA_TFUNCTION | (0 << 4),  /* Lua closure */
        LUA_TLCF = LUA_TFUNCTION | (1 << 4),  /* light C function */
        LUA_TCCL = LUA_TFUNCTION | (2 << 4),  /* C closure */
        /* Variant tags for strings */
        LUA_TSHRSTR = LUA_TSTRING | (0 << 4),  /* short strings */
        LUA_TLNGSTR = LUA_TSTRING | (1 << 4),  /* long strings */
        /* Variant tags for numbers */
        LUA_TNUMFLT = LUA_TNUMBER | (0 << 4),  /* float numbers */
        // lua5.3新增的整数类型
        LUA_TNUMINT = LUA_TNUMBER | (1 << 4),  /* integer numbers */
    }

}