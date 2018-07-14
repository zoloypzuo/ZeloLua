using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.Configuration;
using System.Diagnostics;

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
        public static void Call(this TThread L,int funcIndex,int nRetvals)
        {
            ++L.nCSharpCalls;
            if (L.nCSharpCalls >= luaconf.MaxCalls)
                throw new Exception("CSharp stack overflow");
            PreCall(L, funcIndex, nRetvals);
            --L.nCSharpCalls;
        }
        /// <summary>
        /// luaD_precall, TODO save pc to caller CallInfo, create new CallInfo for callee
        /// </summary>
        /// <param name="L"></param>
        /// <param name="funcIndex"></param>
        /// <param name="n_retvals"></param>
        public static void PreCall(this TThread L,int funcIndex,int n_retvals)
        {
            L.CurrCallInfo.savedpc = L.savedpc;
            var func = L.Stack[funcIndex];
            if (func.is_lua_function) {
                //TODO foo
                var ci = L.IncrementCallInfo();
                ci.func = func;
                //L._base=ci._base=_base;
                //L.savedpc =;
            }
        }
        /// <summary>
        /// adjust_varargs
        /// </summary>
        /// <param name="L"></param>
        /// <param name="p"></param>
        /// <param name="acutal"></param>
        public static void AdjustVararg(this TThread L,Proto p,int acutal)
        {
            //TODO
        }
        /// <summary>
        /// luaD_checkstack
        /// </summary>
        public static void CheckStack()
        {

        }
    }
}
