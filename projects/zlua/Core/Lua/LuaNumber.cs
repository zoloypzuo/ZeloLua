using System;
using zlua.Core.ObjectModel;

namespace zlua.Core.Lua
{
    // lua浮点数类型
    //
    // 不支持配置成float
    public struct LuaNumber : IEquatable<LuaNumber>
    {
        public double Value { get; set; }

        public override bool Equals(object obj)
        {
            return obj is LuaNumber && Equals((LuaNumber)obj);
        }

        public bool Equals(LuaNumber other)
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

        public static bool operator ==(LuaNumber n1, LuaNumber n2)
        {
            return n1.Equals(n2);
        }

        public static bool operator !=(LuaNumber n1, LuaNumber n2)
        {
            return !n1.Equals(n2);
        }

        public static implicit operator LuaNumber(double n)
        {
            return new LuaNumber { Value = n };
        }

        public static implicit operator double(LuaNumber n)
        {
            return new LuaNumber { Value = n };
        }

        //public static explicit operator LuaNumber(LuaIn n)
        //{
        //    return (Int64)n;
        //}

        public static bool ToFloat(LuaValue val)
        {
            //switch (val.Type) {
            //    case LuaTypes.Number:return val.N;
            //    default:
            //}
            return false;
        }

        public static bool TryParse(string s, out LuaNumber n)
        {
            double outN;
            bool b;
            b = Double.TryParse(s, out outN);
            n = outN;
            return b;
        }
    }
}