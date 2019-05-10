using System.Diagnostics;
using ZoloLua.Core.Lua;

namespace ZoloLua.Core.TypeModel
{
    /// <summary>
    ///     类型模型
    /// </summary>
    /// <remarks>
    ///     我完整查看了clua，lobject是一个internal的模块
    /// </remarks>
    internal class lobject
    {
        /* tags for values visible from Lua */
        public const int LAST_TAG = (int)LuaType.LUA_TTHREAD;

        public const int NUM_TAGS = LAST_TAG + 1;


        /*
		** Extra tags for non-values
		*/
        public const int LUA_TPROTO = LAST_TAG + 1;
        public const int LUA_TUPVAL = LAST_TAG + 2;
        public const int LUA_TDEADKEY = LAST_TAG + 3;

        // 类型模型中各个类型的结构体定义
        // 我单独拉出来定义

        // 一些测试tt的宏
        // 宏名以tt开头
        /*
        ** basic types
        */
        public const int LUA_TNONE = -1;

        public const int LUA_TNIL = 0;
        public const int LUA_TBOOLEAN = 1;
        public const int LUA_TLIGHTUSERDATA = 2;
        public const int LUA_TNUMBER = 3;
        public const int LUA_TSTRING = 4;
        public const int LUA_TTABLE = 5;
        public const int LUA_TFUNCTION = 6;
        public const int LUA_TUSERDATA = 7;
        public const int LUA_TTHREAD = 8;

        // 一些访问TValue各个类型的值的宏

        /// <summary>
        ///     单例
        /// </summary>
        public static TValue luaO_nilobject { get; } = new TValue();


        // 其他功能

        public static bool luaO_rawequalObj(TValue t1, TValue t2)
        {
            if (t1.tt != t2.tt) {
                return false;
            }
            switch (t2.tt) {
                case LuaType.LUA_TNIL:
                    return true;

                case LuaType.LUA_TNUMBER:
                    return t1.N == t2.N;

                case LuaType.LUA_TBOOLEAN:
                    return t1.B == t2.B;

                case LuaType.LUA_TSTRING:
                    return t1.Str == t2.Str;

                default:
                    Debug.Assert(t2.IsCollectable);
                    return t1.gc == t2.gc;
            }
        }

        public static bool luaO_str2d(string s, out lua_Number n)
        {
            return lua_Number.TryParse(s, out n);
        }

        public static bool ttisboolean(TValue o) { return ttype(o) == LUA_TBOOLEAN; }

        public static bool ttisfunction(TValue o) { return ttype(o) == LUA_TFUNCTION; }

        public static bool ttislightuserdata(TValue o) { return ttype(o) == LUA_TLIGHTUSERDATA; }

        public static bool ttisnil(TValue o) { return ttype(o) == LUA_TNIL; }

        public static bool ttisnumber(TValue o) { return ttype(o) == LUA_TNUMBER; }

        public static bool ttisstring(TValue o) { return ttype(o) == LUA_TSTRING; }

        public static bool ttistable(TValue o) { return ttype(o) == LUA_TTABLE; }

        public static bool ttisthread(TValue o) { return ttype(o) == LUA_TTHREAD; }

        public static bool ttisuserdata(TValue o) { return ttype(o) == LUA_TUSERDATA; }

        /* Macros to test type */
        public static int ttype(TValue o) { return (int)o.tt; }
    }

    internal class LocVar
    {
        public int endpc;
        public int startpc;
        public string varname;
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class GCObject
    {
    }

    /// <summary>
    /// 用户数据
    /// </summary>
    /// <remarks>
    ///zlua不区分light ud和ud，因为c#不能手工分配内存
    /// clua的Udata指由L分配内存的用户数据
    /// </remarks>
    public class Udata : GCObject
    {
        public Table env;
        public Table metatable;

        /// <summary>
        /// luaS_newudata
        /// </summary>
        public Udata(Table e)
        {
            env = e;
        }

        /// <summary>
        /// TODO
        /// </summary>
        public int len { get { return 0; } }
    }

    internal class UpVal : GCObject
    {
        public byte Idx;
        public byte Instack;
        public TValue v;
    }
}