using System.Collections.Generic;
using ZoloLua.Core.Lua;
using ZoloLua.Core.TypeModel;
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
        public UpVal[] upvals;

        // luaF_newLclosure
        public LuaClosure(Table env, int nUpvals, Proto p) : base(env)
        {
            this.p = p;
            upvals = new UpVal[nUpvals];
        }
    }

    internal class CSharpClosure : Closure
    {
        public lua_CFunction f;
        public TValue[] upvalue;

        public CSharpClosure() : base(null)
        {
        }

        public int nupvalues
        {
            get
            {
                return upvalue.Length;
            }
        }
    }
}