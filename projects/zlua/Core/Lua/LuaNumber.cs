using System;

namespace ZoloLua.Core.Lua
{
    /// <summary>
    ///     lua浮点数类型
    /// </summary>
    /// <remarks>不支持配置成float</remarks>
    public struct lua_Number : IEquatable<lua_Number>
    {
        public double Value { get; set; }

        public override bool Equals(object obj)
        {
            return obj is lua_Number && Equals((lua_Number)obj);
        }

        public bool Equals(lua_Number other)
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

        public static bool operator ==(lua_Number n1, lua_Number n2)
        {
            return n1.Equals(n2);
        }

        public static bool operator !=(lua_Number n1, lua_Number n2)
        {
            return !n1.Equals(n2);
        }

        public static implicit operator lua_Number(double n)
        {
            return new lua_Number { Value = n };
        }

        public static implicit operator double(lua_Number n)
        {
            return n.Value;
        }

        public static bool TryParse(string s, out lua_Number n)
        {
            double outN;
            bool b;
            b = double.TryParse(s, out outN);
            n = outN;
            return b;
        }
    }
}