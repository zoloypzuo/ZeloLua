using System.Collections.Generic;

using static zlua.Core.VirtualMachine.lua_State;

namespace zlua.Core.ObjectModel
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

        public int NumUpvals { get { return upvals.Count; } }

        // luaF_newLclosure
        public LuaClosure(Table env, int nUpvals, Proto p) : base(env)
        {
            this.p = p;
            upvals = new List<UpVal>(nUpvals);
            //for (int i = 0; i < p.Upvalues.Length; i++) {
            //    p.Upvalues[i] = new UpVal();
            //}
        }
    }

    internal class CSharpClosure : Closure
    {
        public CSharpFunction f;
        public List<TValue> upvals;

        public int NUpvals {
            get {
                return upvals.Count;
            }
        }

        public CSharpClosure() : base(null)
        {
        }
    }
}