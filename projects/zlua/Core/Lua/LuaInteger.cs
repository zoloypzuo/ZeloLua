using System;

namespace zlua.Core.Lua
{
    // lua整数类型
    //
    // 不支持配置成比如int32
    public struct LuaInteger : IEquatable<LuaInteger>
    {
        public Int64 Value { get; private set; }

        public override bool Equals(object obj)
        {
            return obj is LuaInteger && Equals((LuaInteger)obj);
        }

        public bool Equals(LuaInteger other)
        {
            return Value == other.Value;
        }

        public override int GetHashCode()
        {
            var hashCode = -783812246;
            hashCode = hashCode * -1521134295 + base.GetHashCode();
            hashCode = hashCode * -1521134295 + Value.GetHashCode();
            return hashCode;
        }

        public override string ToString()
        {
            return Value.ToString();
        }

        public static bool operator ==(LuaInteger i1, LuaInteger i2)
        {
            return i1.Equals(i2);
        }

        public static bool operator !=(LuaInteger i1, LuaInteger i2)
        {
            return !i1.Equals(i2);
        }

        public static implicit operator LuaInteger(Int64 i)
        {
            return new LuaInteger { Value = i };
        }

        public static implicit operator Int64(LuaInteger i)
        {
            return i.Value;
        }
    }
}