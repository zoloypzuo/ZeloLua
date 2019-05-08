using System;
using System.Diagnostics;
using zlua.Core.MetaMethod;
using ZoloLua.Core.Configuration;
using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Core.CallSystem
{
    /// <summary>
    ///     调用系统
    /// </summary>
    public class ldo
    {
    }
}

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        //#define saveci(L,p)		((char *)(p) - (char *)L->base_ci)
        //#define restoreci(L,n)		((CallInfo *)((char *)L->base_ci + (n)))

        ///* results from luaD_precall */
        //internal const int PCRLUA = 0;   /* 说明precall初始化了一个lua函数：initiated a call to a Lua function */
        //internal const int PCRC = 1;    /* 说明precall调用了一个c函数：did a call to a C function */
        //const int PCRYIELD = 2;
        /* results from luaD_precall */
        private const int PCRLUA = 0; /* initiated a call to a Lua function */
        private const int PCRC = 1; /* did a call to a C function */
        private const int PCRYIELD = 2; /* C funtion yielded */

        /// <summary>
        /// </summary>
        /// <param name="p"></param>
        /// <param name="actual"></param>
        /// <returns></returns>
        /// <remarks>旧式vararg可以用arg访问，zlua不支持</remarks>
        private StkId adjust_varargs(Proto p, int actual)
        {
            int i;
            int nfixargs = p.numparams;
            StkId @base, @fixed;
            for (; actual < nfixargs; ++actual)
                top++.SetNil();
            /* move fixed parameters to final position */
            @fixed = top - actual; /* first fixed argument */
            @base = top; /* final position of first argument */
            for (i = 0; i < nfixargs; i++) {
                top++.Set(@fixed + i);
                (@fixed + i).SetNil();
            }
            return @base;
        }

        private void incr_top()
        {
            luaD_checkstack(1);
            top++;
        }

        /*
        ** Call a function (C or Lua). The function to be called is at *func.
        ** The arguments are on the stack, right after the function.
        ** When returns, all the results are on the stack, starting at the original
        ** function position.
        */

        // * 调用函数，函数可以是c#函数或lua函数
        // * 调用协议如下：
        //   调用/Call/前，Closure实例和实参被依次压栈
        //   调用/Call/后，Closure和实参被移除，并留下返回值
        // * /Call/并不是与luaD_call完全对应，而是替代了clua中一系列复杂的call函数整体功能
        //   clua实现dofile时有一个非常深的栈，这里简化为一个方法调用
        /// 从C调用一个函数（划重点），相比api里那个重要一点。这里我简单地保证C
        /// 这个call是从lapi开始的call，lapi计算出funcIndex，这条线是算一次C call，在Thread里也存了counter
        /// lua的call指令只使用precall，因为后面跟着goto reentry，而这里要主动调用一次execute开始执行；precall处理C或lua，我们先走lua
        /// lapi和这里ldo的Call只是签名形式不一样；说是ccall是因为这个必须是c api发起的call，因为lua call只调用precall
        /// lua_call 函数和args已经压栈，调用它；是一次C发起的调用
        /// 这个特殊的call不是lua实现内部使用的，他会用api来push func，push args然后调用
        /// 一个例子是每次启动chunk时，push chunk，call it，funcindex=topindex-1
        private void luaD_call(StkId func, int nResults)
        {
            //TODO
            //if (++L->nCcalls >= LUAI_MAXCCALLS) {
            //    if (L->nCcalls == LUAI_MAXCCALLS)
            //        luaG_runerror(L, "C stack overflow");
            //    else if (L->nCcalls >= (LUAI_MAXCCALLS + (LUAI_MAXCCALLS >> 3)))
            //        luaD_throw(L, LUA_ERRERR);  /* error while handing stack error */
            //}
            ++nCcalls;
            if (nCcalls >= luaconf.LUAI_MAXCCALLS) {
                throw new Exception("C stack overflow");
            }
            // 因为Closure实例cl和实参已经被压栈，可以执行这个cl
            if (luaD_precall(func, nResults) == PCRLUA) {
                luaV_execute(1);
            }
            --nCcalls;
        }

        private void luaD_checkstack(int n)
        {
            if (stack_last - top <= n) {
                luaD_growstack(n);
            }
            //else condhardstacktests(luaD_reallocstack(L, L->stacksize - EXTRA_STACK - 1));
        }

        // header public api
        // int luaD_protectedparser (lua_State *L, ZIO *z, const char *name);
        // void luaD_callhook (lua_State *L, int event, int line);
        // int luaD_precall (lua_State *L, StkId func, int nresults);
        // void luaD_call (lua_State *L, StkId func, int nResults);
        // int luaD_pcall (lua_State *L, Pfunc func, void *u,
        //                                        ptrdiff_t oldtop, ptrdiff_t ef);
        // int luaD_poscall (lua_State *L, StkId firstResult);
        // void luaD_reallocCI (lua_State *L, int newsize);
        // void luaD_reallocstack (lua_State *L, int newsize);
        // void luaD_growstack (lua_State *L, int n);

        // void luaD_throw (lua_State *L, int errcode);
        // int luaD_rawrunprotected (lua_State *L, Pfunc f, void *ud);

        // void luaD_seterrorobj (lua_State *L, int errcode, StkId oldtop);

        private void luaD_growstack(int n)
        {
            //if (n <= stack.Count)  /* double size is enough? */
            //    luaD_reallocstack(L, 2 * L->stacksize);
            //else
            //    luaD_reallocstack(L, L->stacksize + n);
        }

        /// <summary>
        ///     从C或lua函数返回
        ///     `resultIndex是返回值相对于L.base的偏移(很容易错，因为没有指针）
        /// </summary>
        private int luaD_poscall(StkId firstResult)
        {
            StkId res;
            int wanted, i;
            // ci退栈
            CallInfo ci = CallStack.Pop();
            res = ci.func; /* res == final position of 1st result */
            wanted = ci.nresults;
            @base = this.ci.@base; /* restore base */
            TValue funcValue = this.ci.func;
            LuaClosure cl = funcValue.Cl as LuaClosure;
            code = cl.p.code; /* restore savedpc */
            savedpc = this.ci.savedpc;
            /* move results to correct place */
            for (i = wanted; i != 0 && firstResult < top; i--)
                res++.Set(firstResult++);
            while (i-- > 0)
                res++.SetNil();
            top = res;
            return wanted - LUA_MULTRET; /* 0 iff wanted == LUA_MULTRET */
        }

        // luaD_precall
        //
        // * 同时也是call指令实现
        // * funindex是相对于base的偏移
        // * 保存this.savedpc到当前CallInfo的savedpc中
        // * 根据函数参数个数计算待调用函数的base和top值，存入新的CallInfo中
        // * 切换到新的CallInfo
        private int luaD_precall(StkId func, int nresults)
        {
            TValue funcValue = func;
            if (!funcValue.IsFunction) {
                func = tryfuncTM(func); /* check the `function' tag method */
            }
            int funcr = savestack(func);
            ci.savedpc = savedpc;
            /* Lua function? prepare its call */
            if (funcValue.Cl is LuaClosure) {
                LuaClosure cl = funcValue.Cl as LuaClosure;
                StkId @base;
                Proto p = cl.p;
                luaD_checkstack(p.maxstacksize);
                func = restorestack(funcr);
                if (!p.IsVararg) { /* no varargs? */
                    @base = func + 1;
                    if (top > @base + p.numparams) {
                        top = @base + p.numparams;
                    }
                } else { /* vararg function */
                    int nargs = top - func - 1;
                    @base = adjust_varargs(p, nargs);
                    func = restorestack(funcr); /* previous call may change the stack */
                }
                CallInfo ci = new CallInfo
                {
                    func = func,
                    @base = @base,
                    top = this.@base + p.maxstacksize
                };
                this.@base = @base;
                CallStack.Push(ci); /* now `enter' new function */
                Debug.Assert(ci.top <= stack_last);
                code = p.code; /* starting point */
                savedpc = 0;
                ci.tailcalls = 0;
                ci.nresults = nresults;
                // 栈帧清为nil
                // 把多余的函数参数设为nil
                // st是stacktop
                for (StkId st = top; st < ci.top; st++)
                    st.SetNil();
                return PCRLUA;
            }
            /* if is a C function, call it */
            else {
                luaD_checkstack(LUA_MINSTACK); /* ensure minimum stack size */
                func = restorestack(funcr);
                StkId @base = func + 1;
                CallInfo ci = new CallInfo
                {
                    func = func,
                    top = top + LUA_MINSTACK,
                    @base = @base,
                    nresults = nresults
                };
                this.@base = @base;
                CallStack.Push(ci); /* now `enter' new function */
                Debug.Assert(ci.top <= stack_last);
                funcValue = func;
                int n = (funcValue.Cl as CSharpClosure).f(this); /* do the actual call */
                if (n < 0) /* yielding? */ {
                    return PCRYIELD;
                }
                luaD_poscall(top - n);
                return PCRC;
            }
        }

        [DebuggerStepThrough]
        private StkId restorestack(int n)
        {
            return new StkId(stack, n);
        }

        [DebuggerStepThrough]
        private int savestack(StkId p)
        {
            return p.index;
        }

        /// <summary>
        ///     tryfuncTM; 尝试返回元方法__call
        ///     我们暂时不管metacall
        /// </summary>
        private StkId tryfuncTM(StkId func)
        {
            TValue tm = luaT_gettmbyobj(func, TMS.TM_CALL);
            int funcr = savestack(func);
            if (!tm.IsFunction)
                //luaG_typeerror(L, func, "call");
            {
                throw new Exception();
            }
            /* Open a hole inside the stack at `func' */
            for (StkId p = top; p > func; p--)
                p.Set(p - 1);
            top++;
            //TODO clua中save和restore是保存func指针
            //我感觉是多余的，防止编程错误
            func = restorestack(funcr); /* previous call may change stack */
            func.Set(tm); /* tag method is the new function to be called */
            return func;
        }

        #region Obsolete

        /// <summary>
        ///     调用<c>func</c>，参数是<c>u</c>
        ///     是pcall这条线，我决定放弃这条线
        /// </summary>
        /// <param name="L"></param>
        /// <param name="func"></param>
        /// <param name="u"></param>
        /// <param name="old_top"></param>
        /// <param name="ef"></param>
        /// <returns></returns>
        [Obsolete]
        private int luaD_pcall(Pfunc func, object u,
                               int old_top, int ef)
        {
            // 同样的，注释掉的代码太复杂了，都是错误处理
            int status;
            //unsigned short oldnCcalls = L->nCcalls;
            //ptrdiff_t old_ci = saveci(L, L->ci);
            //lu_byte old_allowhooks = L->allowhook;
            //ptrdiff_t old_errfunc = L->errfunc;
            //L->errfunc = ef;
            status = luaD_rawrunprotected(func, u);
            //if (status != 0) {  /* an error occurred? */
            //    StkId oldtop = restorestack(L, old_top);
            //    luaF_close(L, oldtop);  /* close eventual pending closures */
            //    luaD_seterrorobj(L, status, oldtop);
            //    L->nCcalls = oldnCcalls;
            //    L->ci = restoreci(L, old_ci);
            //    L->base = L->ci->base;
            //    L->savedpc = L->ci->savedpc;
            //    L->allowhook = old_allowhooks;
            //    restore_stack_limit(L);
            //}
            //L->errfunc = old_errfunc;
            return status;
        }

        /// <summary>
        ///     是内部实现细节
        ///     LUAI_TRY太复杂了，涉及longjmp错误处理
        ///     pcall调用，我决定放弃pcall
        /// </summary>
        /// <param name="f"></param>
        /// <param name="ud"></param>
        /// <returns></returns>
        [Obsolete]
        private int luaD_rawrunprotected(Pfunc f, object ud)
        {
            //struct lua_longjmp lj;
            //lj.status = 0;
            //lj.previous = L->errorJmp;  /* chain new error handler */
            //L->errorJmp = &lj;
            // 
            //  LUAI_TRY(&lj,
            //    (f)(ud);
            //);
            //L->errorJmp = lj.previous;  /* restore old error handler */
            //return lj.status;
            f(ud);
            return 0;
        }

        /* type of protected functions, to be ran by `runprotected' */
        /// <summary>
        ///     是内部实现细节，因此我设计为不传入L
        ///     是pcall调用，我放弃这条线
        /// </summary>
        /// <param name="ud"></param>
        [Obsolete]
        private delegate void Pfunc(object ud);

        #endregion
    }
}