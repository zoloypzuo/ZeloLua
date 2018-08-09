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
    static class LDo
    {

        /// <summary>
        /// luaD_call; call `func, `func can be either CSharp or Lua; when call `func, arguments are
        /// right after `func on the stack of `L; when returns, return values start at the original position
        /// of `func 翻译一下】调用func，c或lua，arg和ret协议如上，
        /// 因为太难了，还是中文说明】从C调用一个函数（划重点），相比api里那个重要一点。这里我简单地保证C SO
        /// 这个call是从lapi开始的call，lapi计算出funcIndex，这条线是算一次C call，在Thread里也存了counter
        /// lua的call指令只使用precall，因为后面跟着goto reentry，而这里要主动调用一次execute开始执行；precall处理C或lua，我们先走lua
        /// lapi和这里ldo的Call只是签名形式不一样；说是ccall是因为这个必须是c api发起的call，因为lua call只调用precall
        /// lua_call 函数和args已经压栈，调用它；是一次C发起的调用
        /// 这个特殊的call不是lua实现内部使用的，他会用api来push func，push args然后调用
        /// 一个例子是每次启动chunk时，push chunk，call it，funcindex=topindex-1
        /// </summary>
        public static void Call(TThread L, int nArgs)
        {
            ++L.nCSharpCalls;
            if (L.nCSharpCalls >= LuaConf.MaxCalls)
                throw new Exception("CSharp stack overflow");
            int funcIndex = L.topIndex - (nArgs + 1);
            if (PreCall(L, funcIndex) == PCRLUA)
                L.Execute(1);
            --L.nCSharpCalls;
        }
        /// <summary>
        /// tryfuncTM; 尝试返回元方法__call
        /// 我们暂时不管metacall
        /// </summary>
        static TValue TryMetaCall(TThread L, int funcIndex)
        {
            TValue metamethod = LTm.GetMetamethod(L, L[funcIndex], MMType.Call);
            Debug.Assert(metamethod.IsFunction);
            /* Open a hole inside the stack at `func' */
            for (int i = L.topIndex; i > funcIndex; i--)
                L[i].TVal = L[i - 1];
            L.topIndex++;
            L[funcIndex].TVal = metamethod;/* tag method is the new function to be called */
            return L[funcIndex];
        }
        /* results from luaD_precall */
        internal const int PCRLUA = 0;   /* 说明precall初始化了一个lua函数：initiated a call to a Lua function */
        internal const int PCRC = 1;    /* 说明precall调用了一个c函数：did a call to a C function */

        /// <summary>
        /// call指令实现，funindex是相对于base的偏移
        /// </summary>
        public static int PreCall(TThread L, int funcOffset)
        {
            int funcIndex = L.BaseIndex + funcOffset;
            //获取函数
            TValue func = L[funcIndex];
            if (!func.IsFunction)
                func = TryMetaCall(L, funcOffset);
            L.Ci.savedpc = L.pc;// 保存PC
            if (func.Cl is LuaClosure) {  /* Lua function? prepare its call */
                LuaClosure cl = func.Cl as LuaClosure;
                Proto p = cl.p;
                Callinfo ci = new Callinfo() {
                    funcIndex = funcIndex,
                    topIndex = funcIndex + p.MaxStacksize
                };
                if (ci.topIndex >= L.StackLastFree)
                    L.Alloc(ci.topIndex + 1);
                //更新pc
                L.pc = 0;
                L.codes = p.codes;
                L.ciStack.Push(ci);
                //栈帧清为nil
                for (int st = L.topIndex; st < ci.topIndex; st++) //st是stacktop
                    L[st].SetNil();
                L.topIndex = ci.topIndex;  //L.top指向栈帧分配好的空间之后
                return PCRLUA;
            } else {  /* if is a C function, call it */
                Callinfo ci = new Callinfo();
                const int MinStackSizeForCSharpFunction = 20;
                if (L.topIndex + MinStackSizeForCSharpFunction >= L.StackLastFree)
                    L.Alloc(L.topIndex + MinStackSizeForCSharpFunction + 1);
                // 调用C函数
                (L[L.Ci.funcIndex].Cl as CSharpClosure).f(L);
                // 调用结束之后的处理
                PosCall(L, L.topIndex - L.BaseIndex);
                return PCRC;
            }

        }
        /// <summary>
        /// 从C或lua函数返回;`resultIndex是返回值相对于L.base的偏移(很容易错，因为没有指针）
        /// </summary>
        public static void PosCall(TThread L, int resultOffset)
        {
            Callinfo ci = L.ciStack.Pop();
            L.pc = L.Ci.savedpc;
            L[ci.funcIndex].TVal = L[L.BaseIndex + resultOffset];
        }
    }
}
/// <summary>
/// 元方法
/// </summary>
namespace zlua.Metamethod
{
    static class LTm  //src称为tagged method，不喜欢。。
    {
        public static readonly string[] names = new string[] {
            "__index", "__newindex",
            "__gc", "__mode", "__eq",
            "__add", "__sub", "__mul", "__div", "__mod",
            "__pow", "__unm", "__len", "__lt", "__le",
            "__concat", "__call"
        };
        /// <summary>
        /// luaT_gettmbyobj; get metamethod from `obj，
        /// obj没有元表或没有该元方法返回nilobject；enum和string一一对应，这里从enum开始
        /// </summary>
        public static TValue GetMetamethod(this TThread L, TValue obj, MMType metamethodType)
        {
            TTable metatable;
            switch (obj.Type) {
                case LuaTypes.Table:
                    metatable = obj.Table.metatable;
                    break;
                case LuaTypes.Userdata:
                    metatable = obj.Userdata.metaTable;
                    break;
                default:
                    metatable = L.globalState.metaTableForBasicType[(int)obj.Type];
                    break;
            }
            return metatable != null ?
                metatable.GetByStr(L.globalState.metaMethodNames[(int)metamethodType]) :
                TValue.NilObject;
        }
    }
    enum MMType
    {
        Index,
        NewIndex,
        GC,
        Mode,
        Eq,  /* last tag method with `fast' access */
        Add,
        Sub,
        Mul,
        Div,
        Mod,
        Pow,
        Unm,
        Len,
        Lt,
        Le,
        Concat,
        Call,
        N     /* number of elements in the enum */ //仅用于标记大小。
    }

}
