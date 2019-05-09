using ZoloLua.Core.Lua;

namespace ZoloLua.Library.AuxLib
{
    /// <summary>
    /// clua的reg数组是用null作为哨兵的，zlua不需要
    /// </summary>
    public struct luaL_Reg
    {
        public string name;
        public lua_CFunction func;
    }
}
