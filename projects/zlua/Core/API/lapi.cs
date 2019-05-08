using System;
using System.Diagnostics;
using Antlr4.Runtime;
using ZoloLua.Compiler;
using ZoloLua.Compiler.CodeGenerator;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Core.API
{
    /// <summary>
    ///     lua API
    /// </summary>
    public class lapi
    {
    }
}

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        /// <summary>
        ///     lua_pcall的基础版本，不抛出异常
        ///     我决定一律使用lua_call替代lua_pcall
        ///     https://www.lua.org/manual/5.1/manual.html#lua_call
        /// </summary>
        /// <param name="nargs"></param>
        /// <param name="nresults"></param>
        public void lua_call(int nargs, int nresults)
        {
            StkId func;
            api_checknelems(nargs + 1);
            checkresults(nargs, nresults);
            func = top - (nargs + 1);
            luaD_call(func, nresults);
            adjustresults(nresults);
        }


        public void lua_createtable(int narray, int nrec)
        {
            top.Value.Table = new Table(narray, nrec);
            api_incr_top();
        }


        /// <summary>
        ///     clua是parser或undump，zlua只parse
        /// </summary>
        /// <param name="chunk"></param>
        /// <param name="chunkname"></param>
        /// <returns></returns>
        public void lua_load(ICharStream chunk, string chunkname)
        {
            if (chunkname == null) {
                chunkname = "?";
            }

            LuaLexer lexer = new LuaLexer(chunk);
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            LuaParser parser = new LuaParser(tokenStream);
            LuaParser.ChunkContext tree = parser.chunk();
            LuaCodeGenerator codeGenerator = new LuaCodeGenerator();
            codeGenerator.Visit(tree);

            Proto p = codeGenerator.Chunk;
            Table env = new Table(1, 1);
            env.luaH_set(new TValue("print")).Cl = new CSharpClosure
            {
                f = L =>
                {
                    TValue s = L.pop();
                    Console.WriteLine(s.Str);
                    return 0;
                }
            };
            LuaClosure cl = new LuaClosure(env, 1, p);
            push(new TValue(cl));
        }

        /// <summary>
        ///     
        /// </summary>
        /// <remarks>
        ///     lua_State *lua_newstate (lua_Alloc f, void *ud);
        ///     创建的一个新的独立的状态机。 如果创建不了（因为内存问题）返回 NULL 。 参数 f是一个分配器函数； Lua 将通过这个函数做状态机内所有的内存分配操作。 第二个参数 ud ，这个指针将在每次调用分配器时被直接传入。
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

        /// <summary>
        /// </summary>
        /// <remarks>
        ///     void lua_newtable (lua_State *L);
        ///     创建一个空 table ，并将之压入堆栈。 它等价于 lua_createtable(L, 0, 0)。
        /// </remarks>
        public void lua_newtable()
        {
            lua_createtable(0, 0);
        }

        /// <summary>
        /// 基于当前lua_State构建新lua_State实例并压栈
        /// </summary>
        /// <returns></returns>
        /// <remarks>
        ///lua_State *lua_newthread (lua_State *L);
        ///创建一个新线程，并将其压入堆栈， 并返回维护这个线程的 lua_State指针。 这个函数返回的新状态机共享原有状态机中的所有对象（比如一些 table）， 但是它有独立的执行堆栈。
        ///没有显式的函数可以用来关闭或销毁掉一个线程。 线程跟其它 Lua 对象一样是垃圾收集的条目之一。
        /// </remarks>
        public lua_State lua_newthread()
        {
            lua_State L1;
            // 共享全局状态
            L1 = new lua_State
            {
                G = this.G,
                gt = this.gt
            };
            top.Value.Thread = L1;
            api_incr_top();
            return L1;
        }

        /// <summary>
        /// c#不能手工分配内存，所以
        /// </summary>
        /// <returns></returns>
        /// <remarks>void *lua_newuserdata (lua_State *L, size_t size);
        ///这个函数分配分配一块指定大小的内存块， 把内存块地址作为一个完整的 userdata 压入堆栈，并返回这个地址。
        ///userdata 代表 Lua 中的 C 值。 完整的 userdata 代表一块内存。 它是一个对象（就像 table 那样的对象）： 你必须创建它，它有着自己的元表，而且它在被回收时，可以被监测到。 一个完整的 userdata 只和它自己相等（在等于的原生作用下）。
        ///当 Lua 通过 gc元方法回收一个完整的 userdata 时， Lua 调用这个元方法并把 userdata 标记为已终止。 等到这个 userdata 再次被收集的时候，Lua 会释放掉相关的内存。</remarks>
        public object lua_newuserdata()
        {
            Udata u;
            u = new Udata(getcurrenv());
            top.Value.Udata = u;
            api_incr_top();
            return u;
        }


        private Table getcurrenv()
        {
            if (CallStack.Count == 1)  /* no enclosing function? */
                return gt.Table;  /* use global table as environment */
            else {
                Closure func = curr_func;
                return (func as CSharpClosure).env;
            }
        }
        public int lua_setmetatable(int objindex)
        {
            TValue obj;
            Table mt;

            api_checknelems(1);
            obj = index2adr(objindex);
            api_checkvalidindex(obj);
            if (stack[top.index - 1].IsNil) {
                mt = null;
            } else {
                api_check(stack[top.index - 1].IsTable);
                mt = stack[top.index - 1].Table;
            }
            switch (obj.tt) {
                case LuaType.LUA_TTABLE: {
                        obj.Table.metatable = mt;
                        //if (mt!=null)
                        //    luaC_objbarriert(L, hvalue(obj), mt);
                        break;
                    }
                //case LUA_TUSERDATA: {
                //        uvalue(obj)->metatable = mt;
                //        if (mt)
                //            luaC_objbarrier(L, rawuvalue(obj), mt);
                //        break;
                //    }
                default: {
                        G.mt[(int)obj.tt] = mt;
                        break;
                    }
            }
            top--;

            return 1;
        }


        private TValue index2adr(int idx)
        {
            if (idx > 0) {
                StkId o = @base + (idx - 1);
                api_check(idx <= ci.top - @base);
                if (o >= top) {
                    return lobject.luaO_nilobject;
                }
                return o;
            }
            if (idx > LUA_REGISTRYINDEX) {
                api_check(idx != 0 && -idx <= top - @base);
                return top + idx;
            }
            switch (idx) { /* pseudo-indices */
                case LUA_REGISTRYINDEX: return registry;
                case LUA_ENVIRONINDEX: {
                        Closure func = curr_func;
                        env.Table = (func as CSharpClosure).env;
                        return env;
                    }
                case LUA_GLOBALSINDEX: return gt;
                default: {
                        Closure func = curr_func;
                        idx = LUA_GLOBALSINDEX - idx;
                        CSharpClosure ccl = func as CSharpClosure;
                        return idx <= ccl.nupvalues
                            ? ccl.upvalue[idx - 1]
                            : lobject.luaO_nilobject;
                    }
            }
        }

        #region lapi辅助宏

        /// <summary>
        ///     检查编程错误
        /// </summary>
        /// <param name="b"></param>
        [DebuggerStepThrough]
        private void api_check(bool b)
        {
            Debug.Assert(b);
        }

        /// <summary>
        ///     检查有lua栈是否能提供n个空闲位置
        /// </summary>
        /// <param name="n"></param>
        [DebuggerStepThrough]
        private void api_checknelems(int n)
        {
            api_check(n <= top - @base);
        }

        /// <summary>
        ///     索引有效
        /// </summary>
        /// <param name="i"></param>
        [DebuggerStepThrough]
        private void api_checkvalidindex(TValue i)
        {
            api_check(!ReferenceEquals(i, lobject.luaO_nilobject));
        }

        /// <summary>
        ///     递增栈顶，检查没有lua栈溢出
        /// </summary>
        [DebuggerStepThrough]
        private void api_incr_top()
        {
            api_check(top < ci.top);
            top++;
        }

        #endregion


        #region load* call*辅助宏 

        [DebuggerStepThrough]
        private void checkresults(int na, int nr)
        {
            Debug.Assert(nr == LUA_MULTRET || ci.top - top >= nr - na);
        }

        [DebuggerStepThrough]
        private void adjustresults(int nres)
        {
            if (nres == LUA_MULTRET && top >= ci.top) {
                ci.top = top;
            }
        }

        #endregion


        #region Obsolete

        [Obsolete]
        private struct CallS
        { /* data to `f_call' */
            public StkId func;
            public int nresults;
        }

        [Obsolete]
        private void f_call(object ud)
        {
            // 这里不是很清楚为什么要多定义一个CallS
            CallS c = (CallS)ud;
            luaD_call(c.func, c.nresults);
        }

        //luaL_dofile调用如下
        //lua_pcall(nargs: 0, nresults: LUA_MULTRET, errfunc: 0);
        [Obsolete]
        private int lua_pcall(int nargs, int nresults, int errfunc)
        {
            CallS c;
            int status;
            // errfunc，不实现
            int func = 0;

            //TODO dofile这里没有通过断言。。1<=0-0
            //api_checknelems(nargs + 1);
            checkresults(nargs, nresults);
            //if (errfunc == 0)
            //    func = 0;
            //else {
            //StkId o = index2adr(errfunc);
            //api_checkvalidindex( o);
            //func = savestack(o);
            //}
            c.func = top - (nargs + 1); /* function to be called */
            c.nresults = nresults;
            status = luaD_pcall(f_call, c, savestack(c.func), func);
            adjustresults(nresults);
            return status;
        }

        #endregion
    }
}