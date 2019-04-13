using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
// 运算符

using System.Threading.Tasks;
using zlua.Core.Instruction;
using zlua.Core.Lua;
using zlua.Core.MetaMethod;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    public partial class LuaState
    {
        // 算术运算符和按位运算符
        private void Arith(
            Bytecode instr,
            Func<LuaInteger, LuaInteger, LuaInteger> IOp,
            Func<LuaNumber, LuaNumber, LuaNumber> FOp,
            TMS @event)
        {
            LuaValue ra = RA(instr);
            LuaValue rb = RKB(instr);
            LuaValue rc = RKC(instr);
            if (rb.IsInteger && rc.IsInteger) {
                ra.I = IOp(rb.I, rc.I);
            } else {
                LuaNumber nb;
                LuaNumber nc;
                bool b = tonumber(rb, out nb);
                bool c = tonumber(rc, out nc);
                if (b && c) {
                    ra.N = FOp(nb, nc);
                } else {
                    trybinTM(rb, rc, ra, @event);
                }
            }
        }

        private void Arith(
            Bytecode instr,
            Func<LuaInteger, LuaInteger, LuaInteger> IOp,
            TMS @event)
        {
            LuaValue ra = RA(instr);
            LuaValue rb = RKB(instr);
            LuaValue rc = RKC(instr);
            if (rb.IsInteger && rc.IsInteger) {
                ra.I = IOp(rb.I, rc.I);
            } else {
                trybinTM(rb, rc, ra, @event);
            }
        }

        void Arith(
            Bytecode instr,
            Func<LuaNumber, LuaNumber, LuaNumber> FOp,
            TMS @event)
        {
            LuaValue ra = RA(instr);
            LuaValue rb = RKB(instr);
            LuaValue rc = RKC(instr);
            LuaNumber nb;
            LuaNumber nc;
            bool b = tonumber(rb, out nb);
            bool c = tonumber(rc, out nc);
            if (b && c) {
                ra.N = FOp(nb, nc);
            } else {
                trybinTM(rb, rc, ra, @event);
            }
        }

        bool Compare(int idx1, int idx2, Opcode compareOp)
        {

        }

        void Len(int idx)
        {

        }

        void Concat(int n)
        {

        }

        // int floor div
        public static LuaInteger IFloorDiv(LuaInteger a, LuaInteger b)
        {
            if (a > 0 & b > 0 || a < 0 && b < 0 || a % b == 0) {
                return a / b;
            } else {
                return a / b - 1;
            }
        }

        // float floor div
        public static LuaNumber FFloorDiv(LuaNumber a, LuaNumber b)
        {
            return Math.Floor(a / b);
        }

        // int mod
        public static LuaInteger IMod(LuaInteger a, LuaInteger b)
        {
            return a - IFloorDiv(a, b) * b;
        }

        // float mod
        public static LuaNumber FMod(LuaNumber a, LuaNumber b)
        {
            return a - Math.Floor(a / b) * b;
        }

        public static LuaInteger ShiftLeft(LuaInteger a, LuaInteger n)
        {
            return a << (int)n;
        }

        public static LuaInteger ShiftRight(LuaInteger a, LuaInteger n)
        {
            return a >> (int)n;
        }

        public static LuaNumber Pow(LuaNumber a, LuaNumber b)
        {
            return Math.Pow(a, b);
        }
    }
}
