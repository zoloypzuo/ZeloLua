using System;

namespace ZoloLua.Core.Lua
{
    /// <summary>
    ///     lua整数类型
    /// 不支持配置成比如int32
    /// lua5.1虽然没有整数类型，但是仍然使用lua_Integer在pushinteger和tointeger函数中（16次引用），而且内部为ptrdiff
    /// </summary>
    /// <remarks>
    /// typedef ptrdiff_t lua_Integer;
    ///这个类型被用于 Lua API 接收整数值。
    ///缺省时这个被定义为 ptrdiff_t， 这个东西通常是机器能处理的最大整数类型。
    /// </remarks>
    public struct lua_Integer : IEquatable<lua_Integer>
    {
        public long Value { get; set; }

        public override bool Equals(object obj)
        {
            return obj is lua_Integer && Equals((lua_Integer)obj);
        }

        public bool Equals(lua_Integer other)
        {
            return Value == other.Value;
        }

        public override int GetHashCode()
        {
            int hashCode = -783812246;
            hashCode = hashCode * -1521134295 + base.GetHashCode();
            hashCode = hashCode * -1521134295 + Value.GetHashCode();
            return hashCode;
        }

        public override string ToString()
        {
            return Value.ToString();
        }

        public static bool operator ==(lua_Integer i1, lua_Integer i2)
        {
            return i1.Equals(i2);
        }

        public static bool operator !=(lua_Integer i1, lua_Integer i2)
        {
            return !i1.Equals(i2);
        }

        public static implicit operator lua_Integer(long i)
        {
            return new lua_Integer { Value = i };
        }

        public static implicit operator long(lua_Integer i)
        {
            return i.Value;
        }

        public static explicit operator lua_Integer(lua_Number n)
        {
            return (long)n;
        }

        // TODO，先进行词法验证，luanumber也是，lua和c#标准不同
        public static bool TryParse(string s, out lua_Integer i)
        {
            long outI;
            bool b;
            b = long.TryParse(s, out outI);
            i = outI;
            return b;
        }
    }
}