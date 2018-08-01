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
        /// lapi和这里ldo的Call只是签名形式不一样；说是ccall是因为这个必须是c api发起的call，因为lua call只调用precall
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
            for (int i = L.topIndex; i > funcIndex; i--)
                L[i].TVal = L[i - 1];
            L.topIndex++;
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
        public static int PreCall(this TThread L, int funcIndex, int nRetvals)
        {
            //获取函数
            TValue func = L[funcIndex];
            if (!func.IsFunction)
                func = TryMetaCall(L, funcIndex);
            L.Ci.savedpc = L.savedpc;// 保存PC
            LuaClosure cl = func.Cl as LuaClosure;
            if (!cl.IsCharp) {  /* Lua function? prepare its call */
                int _base; //新的base，算完再更新L的base
                Proto p = cl.p;
                if (!p.isVararg) {  /* no varargs? */
                    //新base在func+1
                    _base = funcIndex + 1;
                    //截断多余的args，因为args可以压任意多个
                    if (L.topIndex > _base + p.nParams)
                        L.topIndex = _base + p.nParams;
                } else {  /* vararg function */
                    //否则要从top减掉nparam，算出新base，TODO处理vararg
                    int nargs = (L.topIndex - funcIndex) - 1;
                    _base = AdjustVararg(L, p, nargs);
                }
                Callinfo ci = new Callinfo() {
                    funcIndex = funcIndex,
                    baseIndex = _base,
                    topIndex = L.baseIndex + p.MaxStacksize,  //top存最大的栈帧大小，编译期确定
                    nRetvals = nRetvals
                };
                if (ci.topIndex >= L.StackLastFree)
                    L.Alloc(ci.topIndex + 1);
                Debug.Assert(ci.topIndex < L.StackLastFree);
                L.baseIndex = _base; //更新base
                //更新pc和k
                L.savedpc = 0;
                L.codes = p.codes;
                L.k = p.k;
                L.ciStack.Push(ci);
                for (int st = L.topIndex; st < ci.topIndex; st++) //st是stacktop
                    L[st].SetNil();
                //L.topIndex = ci.topIndex;  //为什么。这样不就不对了。必要的话删掉
                return PCRLUA;
            } else {  /* if is a C function, call it */
                //这里根本不对。也没讲清楚yield是干嘛的。一般来说直接按协议调用即可，为什么这么烦。
                int n;
                Callinfo ci = new Callinfo();
                L.baseIndex = ci.baseIndex = ci.funcIndex + 1;
                ci.topIndex = L.topIndex + lua.MinStackSizeForCSharpFunction;
                Debug.Assert(ci.topIndex <= L.StackLastFree);
                // 期待返回多少个返回值
                ci.nRetvals = nRetvals;
                // 调用C函数
                n = (L[L.Ci.funcIndex].Cl as CSharpClosure).f(L);
                if (n < 0)  /* yielding? */
                    return PCRYIELD;
                else {
                    // 调用结束之后的处理
                    PosCall(L, L.topIndex - n);
                    return PCRC;
                }
            }

        }
        /// <summary>
        /// luaD_poscall; 从C或lua函数返回； 如果返回0，说名从一个多返回值的函数返回
        /// </summary>
        public static int PosCall(this TThread L, int firstResultIndex)
        {
            Callinfo ci = L.ciStack.Pop(); //ci弹栈
                                           /* 恢复一部分*/
            int resultIndex = ci.funcIndex;
            int wanted = ci.nRetvals;
            L.baseIndex = L.Ci.baseIndex;
            L.savedpc = L.Ci.savedpc;
            /* 返回值压栈, 补nil到wanted个返回值*/
            int i;
            for (i = wanted; i != 0 && firstResultIndex < L.topIndex; i--) {
                L[resultIndex++].TVal = L[firstResultIndex++];
            }
            while (i-- > 0) {
                L[resultIndex++].SetNil();
            }
            L.topIndex = resultIndex; //恢复top
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
