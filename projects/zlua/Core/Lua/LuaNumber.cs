using System;
using zlua.Core.ObjectModel;

namespace zlua.Core.Lua
{
    // lua浮点数类型
    //
    // 不支持配置成float
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
            var hashCode = -783812246;
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
            return new lua_Number { Value = n };
        }

        //public static explicit operator LuaNumber(LuaIn n)
        //{
        //    return (Int64)n;
        //}

        public static bool ToFloat(TValue val)
        {
            //switch (val.Type) {
            //    case LuaTypes.Number:return val.N;
            //    default:
            //}
            return false;
        }

        public static bool TryParse(string s, out lua_Number n)
        {
            double outN;
            bool b;
            b = Double.TryParse(s, out outN);
            n = outN;
            return b;
        }
    }
}