using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.Configuration;
using System.Diagnostics;
using zlua.ISA;
/// <summary>
/// 调用系统
/// </summary>
namespace zlua.CallSystem
{
    delegate void ProtectedFunc(TThread L, object ud);
    static class ldo
    {
        
        /// <summary>
        /// luaD_call; call `func, `func can be either CSharp or Lua; when call `func, arguments are
        /// right after `func on the stack of `L; when returns, return values start at the original position
        /// of `func
        /// 因为太难了，还是中文说明】这个call是从lapi开始的call，lapi计算出funcIndex，这条线是算一次C call，在Thread里也存了counter
        /// lua的call指令只使用precall，因为后面跟着goto reentry，而这里要主动调用一次execute开始执行；precall处理C或lua，我们先走lua
        /// 实现决策】禁用this，因为与lapi的签名一致，ldo这里是zlua的内部，所以。。弃车保帅
        /// </summary>
        public static void Call(TThread L, int funcIndex, int nRetvals)
        {
            ++L.nCSharpCalls;
            if (L.nCSharpCalls >= luaconf.MaxCalls)
                throw new Exception("CSharp stack overflow");
            PreCall(L, funcIndex, nRetvals);
            L.Execute(1);
            --L.nCSharpCalls;
        }
        /// <summary>
        /// luaD_precall, TODO save pc to caller CallInfo, create new CallInfo for callee
        /// 中文说明】call指令实现；所以即调用新韩淑，因此保存数据，push栈帧
        /// </summary>
        /// <param name="L"></param>
        /// <param name="funcIndex"></param>
        /// <param name="n_retvals"></param>
        public static void PreCall(this TThread L, int funcIndex, int n_retvals)
        {
            L.CurrCallInfo.savedpc = L.savedpc;
            TValue func = L.Stack[funcIndex];
            LuaClosure closure = ((Closure)func) as LuaClosure;

            Proto p = closure.p;
            int n_args = L.top - funcIndex - 1;

            var ci = new CallInfo() { func = func };
            var _base = funcIndex + 1;
            L._base = ci._base = _base;
            L.savedpc = 0;
            L.codes = p.codes;
            L.k = p.k;
            L.callinfoStack.Push(ci);
        }

        /// <summary>
        /// adjust_varargs
        /// </summary>
        /// <param name="L"></param>
        /// <param name="p"></param>
        /// <param name="acutal"></param>
        public static void AdjustVararg(this TThread L, Proto p, int acutal)
        {
            //TODO
        }
        /// <summary>
        /// luaD_checkstack
        /// </summary>
        public static void CheckStack()
        {

        }
        /// <summary>
        /// f_parser; ud is SParser(so it is bad smell); 
        /// read from SParser( which contains lua source code), 
        /// read the first char to determine if it is bytecode file or text file, 
        /// then use undump or parser to transform the file to Proto, then make the Proto to Closure and push it 
        /// called] luaD_protectedparser
        /// 实现决策】已经归并入loadfile，被其替代
        /// </summary>
        /// <param name="L"></param>
        /// <param name="ud"></param>
        public static void FParser(this TThread L, object ud)
        {
            // TODO 目前当然是parse

        }
    }
}
