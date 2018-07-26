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
using zlua.Metamethod;
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
        /// of `func 翻译一下】调用func，c或lua，arg和ret协议如上，
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
        /// tryfuncTM; 尝试返回元方法__call
        /// </summary>
                static TValue TryMetaCall(this TThread L, int funcIndex)
        {
            TValue metamethod = ltm.GetMetamethod(L, L[funcIndex], MetamethodTypes.Call);
            Debug.Assert(metamethod.IsFunction);
            /* Open a hole inside the stack at `func' */
            for (int i = L.top; i > funcIndex; i--)
                L[i].TVal = L[i - 1];
            L.top++;
            L[funcIndex].TVal = metamethod;/* tag method is the new function to be called */
            return L[funcIndex];
        }
        /* results from luaD_precall */
        public const int PCRLUA = 0;   /* 说明precall初始化了一个lua函数：initiated a call to a Lua function */
        public const int PCRC = 1;    /* 说明precall调用了一个c函数：did a call to a C function */
        public const int PCRYIELD = 2; /* c函数yield？？？：C funtion yielded */

        /// <summary>
        /// luaD_precall, TODO save pc to caller CallInfo, create new CallInfo for callee
        /// 中文说明】call指令实现；所以即调用新韩淑，因此保存数据，push栈帧
        /// </summary>
        public static int PreCall(this TThread L, int funcIndex, int n_retvals)
        {
            TValue func = L[funcIndex];
            if (!func.IsFunction)
                func = TryMetaCall(L, funcIndex);
            L.CurrCallInfo.savedpc = L.savedpc;// 保存PC
            LuaClosure cl = func.Cl as LuaClosure;
            if (!cl.IsCharp) {  /* Lua function? prepare its call */
                int st, _base;
                Proto p = cl.p;
                if (!p.isVararg) {  /* no varargs? */
                    _base = funcIndex + 1;
                    if (L.top > _base + p.nParams)
                        L.top = _base + p.nParams;
                } else {  /* vararg function */
                    int nargs = (L.top - funcIndex) - 1;
                    _base = AdjustVararg(L, p, nargs);
                }
                CallInfo ci = new CallInfo() {
                    funcIndex = funcIndex,
                    _base = _base,
                    top = L._base + p.maxStacksize,
                    nRetvals = n_retvals
                };
                Debug.Assert(ci.top <= L.stackLastFree);
                L._base = _base;

                L.savedpc = 0;
                L.codes = p.codes;
                L.k = p.k;
                L.callinfoStack.Push(ci);
                for (st = L.top; st < ci.top; st++)
                    L[st].SetNil();
                L.top = ci.top;
                return PCRLUA;
            } else {  /* if is a C function, call it */
                int n;
                CallInfo ci = new CallInfo();
                L._base = ci._base = ci.funcIndex + 1;
                ci.top = L.top + lua.MinStackSizeForCSharpFunction;
                Debug.Assert(ci.top <= L.stackLastFree);
                // 期待返回多少个返回值
                ci.nRetvals = n_retvals;
                // 调用C函数
                n = (L[L.CurrCallInfo.funcIndex].Cl as CSharpClosure).f(L);
                if (n < 0)  /* yielding? */
                    return PCRYIELD;
                else {
                    // 调用结束之后的处理
                    PosCall(L, L.top - n);
                    return PCRC;
                }
            }

        }
        /// <summary>
        /// luaD_poscall; 从C或lua函数返回； 如果返回0，说名从一个多返回值的函数返回
        /// </summary>
        public static int PosCall(this TThread L, int firstResultIndex)
        {
            CallInfo ci = L.callinfoStack.Pop(); //ci弹栈
                                                 /* 恢复一部分*/
            int resultIndex = ci.funcIndex;
            int wanted = ci.nRetvals;
            L._base = L.CurrCallInfo._base;
            L.savedpc = L.CurrCallInfo.savedpc;
            /* 返回值压栈, 补nil到wanted个返回值*/
            int i;
            for (i = wanted; i != 0 && firstResultIndex < L.top; i--) {
                L[resultIndex++].TVal = L[firstResultIndex++];
            }
            while (i-- > 0) {
                L[resultIndex++].SetNil();
            }
            L.top = resultIndex; //恢复top
            return wanted - lua.MultiRet; /* 0 if wanted == LUA_MULTRET */
        }
        /// <summary>
        /// adjust_varargs 根据函数的参数数量调整base和top指针位置
        /// </summary>
        public static int AdjustVararg(this TThread L, Proto p, int acutal)
        {
            //TODO
            return 1;
        }
        /// <summary>
        /// luaD_checkstack
        /// </summary>
        public static void CheckStack()
        {

        }
        /// <summary>
        /// savestack; 嗯，就这么简单
        /// </summary>
                public static int SaveStack(this TThread L, int index)
        {
            return index;
        }
        /// <summary>
        /// restorestack;
        /// </summary>
        public static TValue RestoreStack(this TThread L, int index)
        {
            return L[index];
        }
        /// <summary>
        /// f_parser; ud is SParser(so it is bad smell); 
        /// read from SParser( which contains lua source code), 
        /// read the first char to determine if it is bytecode file or text file, 
        /// then use undump or parser to transform the file to Proto, then make the Proto to Closure and push it 
        /// called] luaD_protectedparser
        /// 实现决策】已经归并入loadfile，被其替代
        /// </summary>
                        //public static void FParser(this TThread L, object ud)
        //{
        //    // TODO 目前当然是parse

        //}
    }
}
