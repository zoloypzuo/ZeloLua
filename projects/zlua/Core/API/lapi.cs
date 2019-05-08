using System;
using System.Diagnostics;
using Antlr4.Runtime;
using ZoloLua.Compiler;
using ZoloLua.Compiler.CodeGenerator;
using ZoloLua.Core.Configuration;
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
        #region KopiLua lua.h所有内容
        public delegate int lua_CFunction(lua_State L);
        // lua语言基本信息

        public const string LUA_VERSION = "Lua 5.1";
        public const string LUA_RELEASE = "Lua 5.1.4";
        public const int LUA_VERSION_NUM = 501;
        public const string LUA_COPYRIGHT = "Copyright (C) 1994-2008 Lua.org, PUC-Rio";
        public const string LUA_AUTHORS = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";


        /* mark for precompiled code (`<esc>Lua') */
        public const string LUA_SIGNATURE = "\x01bLua";

        /* option for multiple returns in `lua_pcall' and `lua_call' */
        public const int LUA_MULTRET = -1;


        /*
        ** pseudo-indices
        */
        public const int LUA_REGISTRYINDEX = -10000;
        public const int LUA_ENVIRONINDEX = -10001;
        public const int LUA_GLOBALSINDEX = -10002;


        /* thread status; 0 is OK */
        public const int LUA_YIELD = 1;
        public const int LUA_ERRRUN = 2;
        public const int LUA_ERRSYNTAX = 3;
        public const int LUA_ERRMEM = 4;
        public const int LUA_ERRERR = 5;


        /*
        ** functions that read/write blocks when loading/dumping Lua chunks
        */
        //public delegate CharPtr lua_Reader(lua_State L, object ud, out uint sz);

        //public delegate int lua_Writer(lua_State L, CharPtr p, uint sz, object ud);


        /*
        ** prototype for memory-allocation functions
        */
        //public delegate object lua_Alloc(object ud, object ptr, uint osize, uint nsize);
        //public delegate object lua_Alloc(Type t);


        /*
        ** basic types
        */
        public const int LUA_TNONE = -1;

        public const int LUA_TNIL = 0;
        public const int LUA_TBOOLEAN = 1;
        public const int LUA_TLIGHTUSERDATA = 2;
        public const int LUA_TNUMBER = 3;
        public const int LUA_TSTRING = 4;
        public const int LUA_TTABLE = 5;
        public const int LUA_TFUNCTION = 6;
        public const int LUA_TUSERDATA = 7;
        public const int LUA_TTHREAD = 8;


        /* minimum Lua stack available to a C function */
        public const int LUA_MINSTACK = 20;

        public static int lua_upvalueindex(int i) { return LUA_GLOBALSINDEX - i; }


        // 一些函数指针类型定义
        // 一些lua辅助宏定义

        /* type of numbers in Lua */
        //typedef LUA_NUMBER lua_Number;


        /* type for integer functions */
        //typedef LUA_INTEGER lua_Integer;

        /*
        ** garbage-collection function and options
        */

        //      public const int LUA_GCSTOP = 0;
        //      public const int LUA_GCRESTART = 1;
        //      public const int LUA_GCCOLLECT = 2;
        //      public const int LUA_GCCOUNT = 3;
        //      public const int LUA_GCCOUNTB = 4;
        //      public const int LUA_GCSTEP = 5;
        //      public const int LUA_GCSETPAUSE = 6;
        //      public const int LUA_GCSETSTEPMUL = 7;

        //      /* 
        //** ===============================================================
        //** some useful macros
        //** ===============================================================
        //*/

        //      public static void lua_pop(lua_State L, int n)
        //      {
        //          lua_settop(L, -(n) - 1);
        //      }

        //      public static void lua_newtable(lua_State L)
        //      {
        //          lua_createtable(L, 0, 0);
        //      }

        //      public static void lua_register(lua_State L, CharPtr n, lua_CFunction f)
        //      {
        //          lua_pushcfunction(L, f);
        //          lua_setglobal(L, n);
        //      }

        //      public static void lua_pushcfunction(lua_State L, lua_CFunction f)
        //      {
        //          lua_pushcclosure(L, f, 0);
        //      }

        //      public static uint lua_strlen(lua_State L, int i)
        //      {
        //          return lua_objlen(L, i);
        //      }

        //      public static bool lua_isfunction(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TFUNCTION;
        //      }

        //      public static bool lua_istable(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TTABLE;
        //      }

        //      public static bool lua_islightuserdata(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TLIGHTUSERDATA;
        //      }

        //      public static bool lua_isnil(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TNIL;
        //      }

        //      public static bool lua_isboolean(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TBOOLEAN;
        //      }

        //      public static bool lua_isthread(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TTHREAD;
        //      }

        //      public static bool lua_isnone(lua_State L, int n)
        //      {
        //          return lua_type(L, n) == LUA_TNONE;
        //      }

        //      public static bool lua_isnoneornil(lua_State L, lua_Number n)
        //      {
        //          return lua_type(L, (int)n) <= 0;
        //      }

        //      public static void lua_pushliteral(lua_State L, CharPtr s)
        //      {
        //          //TODO: Implement use using lua_pushlstring instead of lua_pushstring
        //          //lua_pushlstring(L, "" s, (sizeof(s)/GetUnmanagedSize(typeof(char)))-1)
        //          lua_pushstring(L, s);
        //      }

        //      public static void lua_setglobal(lua_State L, CharPtr s)
        //      {
        //          lua_setfield(L, LUA_GLOBALSINDEX, s);
        //      }

        //      public static void lua_getglobal(lua_State L, CharPtr s)
        //      {
        //          lua_getfield(L, LUA_GLOBALSINDEX, s);
        //      }

        //      public static CharPtr lua_tostring(lua_State L, int i)
        //      {
        //          uint blah;
        //          return lua_tolstring(L, i, out blah);
        //      }

        //      ////#define lua_open()	luaL_newstate()
        //      public static lua_State lua_open()
        //      {
        //          return luaL_newstate();
        //      }

        //      ////#define lua_getregistry(L)	lua_pushvalue(L, LUA_REGISTRYINDEX)
        //      public static void lua_getregistry(lua_State L)
        //      {
        //          lua_pushvalue(L, LUA_REGISTRYINDEX);
        //      }

        //      ////#define lua_getgccount(L)	lua_gc(L, LUA_GCCOUNT, 0)
        //      public static int lua_getgccount(lua_State L)
        //      {
        //          return lua_gc(L, LUA_GCCOUNT, 0);
        //      }

        //      //#define lua_Chunkreader		lua_Reader
        //      //#define lua_Chunkwriter		lua_Writer


        //      /*
        //** {======================================================================
        //** Debug API
        //** =======================================================================
        //*/


        //      /*
        //** Event codes
        //*/
        //      public const int LUA_HOOKCALL = 0;
        //      public const int LUA_HOOKRET = 1;
        //      public const int LUA_HOOKLINE = 2;
        //      public const int LUA_HOOKCOUNT = 3;
        //      public const int LUA_HOOKTAILRET = 4;


        //      /*
        //** Event masks
        //*/
        //      public const int LUA_MASKCALL = (1 << LUA_HOOKCALL);
        //      public const int LUA_MASKRET = (1 << LUA_HOOKRET);
        //      public const int LUA_MASKLINE = (1 << LUA_HOOKLINE);
        //      public const int LUA_MASKCOUNT = (1 << LUA_HOOKCOUNT);

        //      /* Functions to be called by the debuger in specific events */
        //      public delegate void lua_Hook(lua_State L, lua_Debug ar);


        //      public class lua_Debug
        //      {
        //          public int event_;
        //          public CharPtr name;    /* (n) */
        //          public CharPtr namewhat;    /* (n) `global', `local', `field', `method' */
        //          public CharPtr what;    /* (S) `Lua', `C', `main', `tail' */
        //          public CharPtr source;  /* (S) */
        //          public int currentline; /* (l) */
        //          public int nups;        /* (u) number of upvalues */
        //          public int linedefined; /* (S) */
        //          public int lastlinedefined; /* (S) */
        //          public CharPtr short_src = new char[LUA_IDSIZE]; /* (S) */
        //                                                           /* private part */
        //          public int i_ci;  /* active function */
        //      };

        /* }====================================================================== */


        /******************************************************************************
        * Copyright (C) 1994-2008 Lua.org, PUC-Rio.  All rights reserved.
        *
        * Permission is hereby granted, free of charge, to any person obtaining
        * a copy of this software and associated documentation files (the
        * "Software"), to deal in the Software without restriction, including
        * without limitation the rights to use, copy, modify, merge, publish,
        * distribute, sublicense, and/or sell copies of the Software, and to
        * permit persons to whom the Software is furnished to do so, subject to
        * the following conditions:
        *
        * The above copyright notice and this permission notice shall be
        * included in all copies or substantial portions of the Software.
        *
        * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
        * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
        * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
        * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
        * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
        * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
        ******************************************************************************/
        #endregion
        /// <summary>
        ///     lua_pcall的基础版本，不抛出异常
        ///     我决定一律使用lua_call替代lua_pcall
        /// </summary>
        /// <param name="nargs"></param>
        /// <param name="nresults"></param>
        /// <remarks>
        ///     void lua_call (lua_State *L, int nargs, int nresults);
        ///     调用一个函数。
        ///     要调用一个函数请遵循以下协议：
        ///     1. 首先，要调用的函数应该被压入堆栈；
        ///     2.  接着，把需要传递给这个函数的参数按正序压栈； 这是指第一个参数首先压栈。
        ///     3. 最后调用一下 lua_call；nargs 是你压入堆栈的参数个数。
        ///     4. 当函数调用完毕后，所有的参数以及函数本身都会出栈。 而函数的返回值这时则被压入堆栈。 返回值的个数将被调整为 nresults个， 除非 nresults被设置成LUA_MULTRET。
        ///     在这种情况下，所有的返回值都被压入堆栈中。 Lua 会保证返回值都放入栈空间中。 函数返回值将按正序压栈（第一个返回值首先压栈）， 因此在调用结束后，最后一个返回值将被放在栈顶。
        ///     被调用函数内发生的错误将（通过 longjmp）一直上抛。
        ///     下面的例子中，这行 Lua 代码等价于在宿主程序用 C 代码做一些工作：
        ///     a = f("how", t.x, 14)
        ///     这里是 C 里的代码：
        ///     lua_getfield(L, LUA_GLOBALSINDEX, "f");          /* 将调用的函数 */
        ///     lua_pushstring(L, "how");                          /* 第一个参数 */
        ///     lua_getfield(L, LUA_GLOBALSINDEX, "t");          /* table 的索引 */
        ///     lua_getfield(L, -1, "x");         /* 压入 t.x 的值（第 2 个参数）*/
        ///     lua_remove(L, -2);                           /* 从堆栈中移去 't' */
        ///     lua_pushinteger(L, 14);                           /* 第 3 个参数 */
        ///     lua_call(L, 3, 1); /* 调用 'f'，传入 3 个参数，并索取 1 个返回值 */
        ///     lua_setfield(L, LUA_GLOBALSINDEX, "a");      /* 设置全局变量 'a' */
        ///     注意上面这段代码是“平衡”的： 到了最后，堆栈恢复成原由的配置。 这是一种良好的编程习惯。
        ///     通信协议
        ///     1. 编写C函数时可以认为是一个独立的栈（也就是新的栈，和L的栈无关）
        ///     2. 第一个参数的idx是1，第二个是2。。  //所以很简单，其实这里也不是栈了，就是一个window/array
        ///     3. 返回值的话有一系列push函数，直接push
        ///     4. C函数要返回返回值的个数
        ///     对象都是表，getfield即可获得字段
        /// </remarks>
        public void lua_call(int nargs, int nresults)
        {
            StkId func;
            api_checknelems(nargs + 1);
            checkresults(nargs, nresults);
            func = top - (nargs + 1);
            luaD_call(func, nresults);
            adjustresults(nresults);
        }

        /// <summary>
        /// 创建表，压栈
        /// </summary>
        /// <param name="narray"></param>
        /// <param name="nrec"></param>
        /// <remarks>
        ///void lua_createtable (lua_State *L, int narr, int nrec);
        ///创建一个新的空 table 压入堆栈。 这个新 table 将被预分配 narr个元素的数组空间 以及nrec 个元素的非数组空间。
        /// 当你明确知道表中需要多少个元素时，预分配就非常有用。 如果你不知道，可以使用函数 lua_newtable。
        /// </remarks>
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
        /// </summary>
        /// <remarks>
        /// 只被auxlib的luaL_newstate调用
        /// clua中，这个函数只分配内存
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
        ///     基于当前lua_State构建新lua_State实例并压栈
        /// </summary>
        /// <returns></returns>
        /// <remarks>
        ///     lua_State *lua_newthread (lua_State *L);
        ///     创建一个新线程，并将其压入堆栈， 并返回维护这个线程的 lua_State指针。
        /// 这个函数返回的新状态机共享原有状态机中的所有对象（比如一些 table）， 但是它有独立的执行堆栈。
        ///     没有显式的函数可以用来关闭或销毁掉一个线程。 线程跟其它 Lua 对象一样是垃圾收集的条目之一。
        /// </remarks>
        public lua_State lua_newthread()
        {
            lua_State L1;
            // 共享全局状态
            L1 = new lua_State
            {
                G = G,
                gt = gt
            };
            top.Value.Thread = L1;
            api_incr_top();
            return L1;
        }

        /// <summary>
        ///     c#不能手工分配内存，所以
        /// </summary>
        /// <returns></returns>
        /// <remarks>
        ///     void *lua_newuserdata (lua_State *L, size_t size);
        ///     这个函数分配分配一块指定大小的内存块， 把内存块地址作为一个完整的 userdata 压入堆栈，并返回这个地址。
        ///     userdata 代表 Lua 中的 C 值。 完整的 userdata 代表一块内存。 它是一个对象（就像 table 那样的对象）：
        /// 你必须创建它，它有着自己的元表，而且它在被回收时，可以被监测到。 一个完整的
        ///     userdata 只和它自己相等（在等于的原生作用下）。
        ///     当 Lua 通过 gc元方法回收一个完整的 userdata 时， Lua 调用这个元方法并把 userdata 标记为已终止。
        /// 等到这个 userdata 再次被收集的时候，Lua 会释放掉相关的内存。
        /// </remarks>
        public object lua_newuserdata()
        {
            Udata u;
            u = new Udata(getcurrenv());
            top.Value.Udata = u;
            api_incr_top();
            return u;
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


        private Table getcurrenv()
        {
            if (CallStack.Count == 1) /* no enclosing function? */ {
                return gt.Table; /* use global table as environment */
            }
            Closure func = curr_func;
            return (func as CSharpClosure).env;
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

        /// <summary>
        /// lua栈不会自动增长，api调用者必须主动调用/CheckStack/以确保压入更多值不会导致栈溢出
        /// 返回lua栈是否能提供n个空闲格子
        /// 再次强调，对于c#，栈的容量指count，而不是capacity
        /// </summary>
        /// <param name="L"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        /// <remarks>
        ///int lua_checkstack (lua_State *L, int extra);
        /// 确保堆栈上至少有 extra个空位。 如果不能把堆栈扩展到相应的尺寸，函数返回 false 。
        /// 这个函数永远不会缩小堆栈； 如果堆栈已经比需要的大了，那么就放在那里不会产生变化。
        /// </remarks>
        public bool lua_checkstack(int size)
        {
            bool res = true;

            if (size > luaconf.LUAI_MAXCSTACK || (top - @base + size) > luaconf.LUAI_MAXCSTACK)
                res = false;  /* stack overflow */
            else if (size > 0) {
                luaD_checkstack(size);
                if (ci.top < top + size)
                    ci.top = top + size;
            }

            return res;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="n"></param>
        /// <remarks>
        ///void lua_concat (lua_State *L, int n);
        ///连接栈顶的 n个值， 然后将这些值出栈，并把结果放在栈顶。 如果 n为 1 ，结果就是一个字符串放在栈上（即，函数什么都不做）；
        /// 如果 n为 0 ，结果是一个空串。 连接依照 Lua 中创建语义完成（参见 §2.5.4 ）。
        /// </remarks>
        public void lua_concat(int n)
        {

            api_checknelems( n);
            if (n >= 2) {
                luaV_concat(n, (top - @base) - 1);
                top -= (n - 1);
            } else if (n == 0) {  /* push empty string */
                top.Value.TStr = new TString("");
                api_incr_top();
            }
            /* else n == 1; nothing to do */

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="L"></param>
        /// <param name="writer"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        /// <remarks>
        ///int lua_dump (lua_State *L, lua_Writer writer, void *data);
        ///1. 把函数 dump 成二进制 chunk 。
        ///2.  函数接收栈顶的 Lua 函数做参数，然后生成它的二进制 chunk 。 若被 dump 出来的东西被再次加载，加载的结果就相当于原来的函数。
        ///3.  当它在产生 chunk 的时候，lua_dump 通过调用函数writer （参见 lua_Writer） 来写入数据，后面的 data参数会被传入 writer 。
        ///4. 最后一次由写入器(writer) 返回值将作为这个函数的返回值返回； 0 表示没有错误。
        ///这个函数不会把 Lua 返回弹出堆栈。
        /// </remarks>
        public int lua_dump(out object data)
        {
            throw new Exception();
            // dump没实现
            // 大概的内容是编译生成p和void*data，data是二进制chunk
            // 这里的o作为p的重启，然后被抛弃了
            //int status;
            //TValue o;

            //api_checknelems(1);
            //o = top - 1;
            //if (o.IsLuaFunction)
            //    status = luaU_dump(data, 0);
            //else
            //    status = 1;

            //return status;
        }


        /// <summary>
        /// lua_equal和lua_rawequal的区别在于前者调用元方法
        /// </summary>
        /// <param name="index1"></param>
        /// <param name="index2"></param>
        /// <returns></returns>
        /// <remarks>
        /// int lua_rawequal (lua_State *L, int index1, int index2);
        ///如果两个索引 index1 和 index2 处的值简单地相等 （不调用元方法）则返回 1 。 否则返回 0 。 如果任何一个索引无效也返回 0 。
        /// </remarks>
        public bool lua_rawequal(int index1, int index2)
        {
            TValue o1 = index2adr(index1);
            TValue o2 = index2adr(index2);
            return !ReferenceEquals(o1, lobject.luaO_nilobject) &&
                   !ReferenceEquals(o2, lobject.luaO_nilobject) &&
                   lobject.luaO_rawequalObj(o1, o2);
        }

        /// <summary>
        /// lua_equal和lua_rawequal的区别在于前者调用元方法
        /// </summary>
        /// <param name="index1"></param>
        /// <param name="index2"></param>
        /// <returns></returns>
        /// <remarks>
        ///int lua_equal (lua_State *L, int index1, int index2);
        ///如果依照 Lua 中 == 操作符语义，索引 index1和 index2中的值相同的话，返回 1 。 否则返回 0 。 如果任何一个索引无效也会返回 0。
        /// </remarks>
        public bool lua_equal(int index1, int index2)
        {
            TValue o1, o2;
            bool i;
            /* may call tag method */
            o1 = index2adr(index1);
            o2 = index2adr(index2);
            i = !ReferenceEquals(o1, lobject.luaO_nilobject) &&
                !ReferenceEquals(o2, lobject.luaO_nilobject) &&
                equalobj(o1, o2);

            return i;
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