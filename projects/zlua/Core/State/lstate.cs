using System.Collections.Generic;
using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Core.VirtualMachine
{
    /// <summary>
    ///     lua_State一般性字段的定义和lua_State的初始化
    /// </summary>
    /// <remarks>这里的字段相对没有运行时的那些字段那么重要</remarks>
    public partial class lua_State : GCObject
    {
        /* extra stack space to handle TM calls and some other extras */
        private const int EXTRA_STACK = 5;

        private const int BASIC_CI_SIZE = 8;

        private const int BASIC_STACK_SIZE = 2 * LUA_MINSTACK;

        /// <summary>
        ///     nested C calls when resuming coroutine
        /// </summary>
        private ushort baseCcalls;

        /// <summary>
        ///     temporary place for environments
        /// </summary>
        private TValue env;

        /// <summary>
        ///     l_G
        /// </summary>
        /// <remarks>
        ///     这里没有只读，因为new_state是static，这里ctor不够用
        ///     相比而言，真正的运行时，比如call stack等等，更加重要，因此严格一些，全局表等等都不太重要
        /// </remarks>
        private global_State G;

        /// <summary>
        ///     table of globals
        ///     l_gt
        /// </summary>
        private TValue gt;

        /// <summary>
        ///     number of nested C calls
        /// </summary>
        private ushort nCcalls;
        private byte status;

        /// <summary>
        ///     stack_init
        ///     初始化lua栈，子协程从父协程初始化，在c中主要是用L进行分配
        ///     但是基本的解释器也调用这个
        /// </summary>
        /// <param name="L1"></param>
        /// <param name="L"></param>
        /// <remarks>
        ///     在两个地方被调用
        ///     f_luaopen中
        ///     stack_init(L, L);  /* init stack */
        ///     luaE_newthread中
        ///     stack_init(L1, L);  /* init stack */
        /// </remarks>
        private lua_State()
        {
            /* initialize CallInfo array */
            CallStack = new Stack<CallInfo>(BASIC_CI_SIZE);
            /* initialize stack array */
            int size = BASIC_STACK_SIZE + EXTRA_STACK;
            stack = new List<TValue>(size);
            for (int i = 0; i < size; i++) stack.Add(new TValue());
            top = newStkId(0);
            /* initialize first ci */
            // 基本的CallInfo，在chunk之前
            // 因为调用函数之前要有一个CallInfo保存savedpc
            // 因此构造LuaState时构造一个基本的CallInfo
            CallInfo ci = new CallInfo();
            // clua是top，但是是错的，单步之后func是nil，当然不对，这对clua没影响，但是我们需要
            ci.func = top + 1;
            // 这个位置在loadfile后推入chunk函数，先设为nil只是一个习惯
            top++.SetNil(); /* `function' entry for this `ci' */
            @base = ci.@base = top;
            ci.top = top + LUA_MINSTACK;
            CallStack.Push(ci);
        }

        private TValue registry {
            get {
                return G.l_registry;
            }
        }

        private int stacksize {
            get {
                return stack.Count;
            }
        }

        private Closure curr_func {
            get {
                return stack[ci.func.index].Cl;
            }
        }

        /// <summary>
        /// luaE_newthread
        /// 只被lua_newthread调用
        /// TODO，因此在lapi中实现，主要是因为ctor有限
        /// </summary>
        //public lua_State(lua_State L) :
        //    this()  /* init stack */
        //{
        //    // 共享全局状态
        //    G = L.G;
        //    gt = L.gt;  /* share table of globals */
        //}

        /// <summary>
        ///     lua_newstate
        /// </summary>
        /// <remarks>
        ///     只被auxlib的luaL_newstate调用
        ///     clua中，这个函数只分配内存
        /// </remarks>
        public static lua_State lua_newstate()
        {
            lua_State L = new lua_State();
            global_State g = new global_State();
            L.G = g;
            g.mainthread = L;
            //g->uvhead.u.l.prev = &g->uvhead;
            //g->uvhead.u.l.next = &g->uvhead;
            // f_luaopen
            L.gt = new TValue(new Table(0, 2));
            L.registry.Table = new Table(0, 2);
            L.luaT_init();
            return L;
        }
    }
}