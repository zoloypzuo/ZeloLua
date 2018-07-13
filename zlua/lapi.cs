using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
namespace zlua.API
{
    static class lapi
    {
        class CallS
        {
            public TValue func;
            public int n_retvals;
        }
        static void pcall(this TThread L,int n_args,int n_retvals,int errfunc)
        {
            var cs=new CallS();
            cs.func = L._stack[L.top - n_args + 1];
            cs.n_retvals = n_retvals;

        }
        /// <summary>
        /// lua_gettop
        /// </summary>
        /// <param name="L"></param>
        /// <returns></returns>
        public static int GetTop(this TThread L) => L.top - L._base;
    }
}
