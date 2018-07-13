using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
namespace zlua.CallSystem
{
    delegate void ProtectedFunc(TThread L, object ud);
    static class ldo
    {
        public static void pcall(this TThread L) { } 
        public static void raw_run_unprotected(this TThread L,ProtectedFunc f,object ud)
        {

        }
        /// <summary>
        /// luaD_call; call `func, `func can be either CSharp or Lua; when call `func, arguments are
        /// right after `func on the stack of `L; when returns, return values start at the original position
        /// of `func
        /// </summary>
        public static void Call(this TThread L,TValue func,int n_retvals)
        {

        }
        public static void PreCall(this TThread L,TValue func,int n_retvals)
        {
            L.curr_callinfo.savedpc = L.savedpc;

        }
    }
}
