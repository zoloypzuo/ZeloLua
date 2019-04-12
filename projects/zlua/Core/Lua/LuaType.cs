namespace zlua.Core.Lua
{
    // lua类型枚举
    public enum LuaTypes
    {
        // 无效索引对应的值的类型，表示没有值
        None = -1,

        Nil,
        Boolean,
        LightUserdata,
        Number,
        String,
        Table,

        // C and Lua functions
        Function,

        Userdata,
        Thread,

        //extra tags
        Proto,

        Upval,

        // lua5.3新增的整数类型
        //
        // lobject.h line 59
        Integer = 19,
    }
}