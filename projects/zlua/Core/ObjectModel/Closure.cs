using System.Collections.Generic;
using static ZoloLua.Core.VirtualMachine.lua_State;

namespace ZoloLua.Core.ObjectModel
{
    public class Closure : GCObject
    {
        public Table env;

        public Closure(Table env)
        {
            this.env = env;
        }
    }

    internal class LuaClosure : Closure
    {
        public Proto p;
        public List<UpVal> upvals;

        // luaF_newLclosure
        public LuaClosure(Table env, int nUpvals, Proto p) : base(env)
        {
            this.p = p;
            upvals = new List<UpVal>(nUpvals);
            //for (int i = 0; i < p.Upvalues.Length; i++) {
            //    p.Upvalues[i] = new UpVal();
            //}
        }

        public int NumUpvals {
            get {
                return upvals.Count;
            }
        }
    }

    internal class CSharpClosure : Closure
    {
        public lua_CFunction f;
        public List<TValue> upvalue;

        public CSharpClosure() : base(null)
        {
        }

        public int nupvalues {
            get {
                return upvalue.Count;
            }
        }
    }
}