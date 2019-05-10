using System;
using System.Diagnostics;
//using Antlr4.Runtime;
//using ZoloLua.Compiler;
//using ZoloLua.Compiler.CodeGenerator;
using ZoloLua.Core.Configuration;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;
using ZoloLua.Core.TypeModel;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
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

        [DebuggerStepThrough]
        private bool isvalid(TValue o)
        {
            return !ReferenceEquals(o, lobject.luaO_nilobject);
        }

        /* test for pseudo index */
        [DebuggerStepThrough]
        private bool ispseudo(int i)
        {
            return i <= LUA_REGISTRYINDEX;
        }

        /* test for upvalue */
        [DebuggerStepThrough]
        private bool isupvalue(int i)
        {
            return i < LUA_REGISTRYINDEX;
        }

        /* test for valid but not pseudo index */
        [DebuggerStepThrough]
        private bool isstackindex(int i, TValue o)
        {
            return isvalid(o) && !ispseudo(i);
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
        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_atpanic">lua_atpanic</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_atpanic
        /// 		lua_CFunction lua_atpanic (lua_State *L, lua_CFunction panicf);
        /// 		
        /// 		设置一个新的 panic （恐慌） 函数，并返回前一个。
        /// 		
        /// 		如果在保护环境之外发生了任何错误，
        /// 		Lua 就会调用一个 panic 函数，接着调用 exit(EXIT_FAILURE)，
        /// 		这样就开始退出宿主程序。
        /// 		你的 panic 函数可以永远不返回（例如作一次长跳转）来避免程序退出。
        /// 		
        /// 		panic 函数可以从栈顶取到出错信息。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
        public void lua_atpanic()
        {
        }

        /// <summary>
        /// lua_pcall的基础版本，不抛出异常
        /// 我决定一律使用lua_call替代lua_pcall
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_call">lua_call</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_call
        /// 		void lua_call (lua_State *L, int nargs, int nresults);
        /// 		
        /// 		调用一个函数。
        /// 		
        /// 		要调用一个函数请遵循以下协议：
        /// 		首先，要调用的函数应该被压入堆栈；
        /// 		接着，把需要传递给这个函数的参数按正序压栈；
        /// 		这是指第一个参数首先压栈。
        /// 		最后调用一下 lua_call；
        /// 		nargs 是你压入堆栈的参数个数。
        /// 		当函数调用完毕后，所有的参数以及函数本身都会出栈。
        /// 		而函数的返回值这时则被压入堆栈。
        /// 		返回值的个数将被调整为 nresults 个，
        /// 		除非 nresults 被设置成 LUA_MULTRET。
        /// 		在这种情况下，所有的返回值都被压入堆栈中。
        /// 		Lua 会保证返回值都放入栈空间中。
        /// 		函数返回值将按正序压栈（第一个返回值首先压栈），
        /// 		因此在调用结束后，最后一个返回值将被放在栈顶。
        /// 		
        /// 		被调用函数内发生的错误将（通过 longjmp）一直上抛。
        /// 		
        /// 		下面的例子中，这行 Lua 代码等价于在宿主程序用 C 代码做一些工作：
        /// 		<code>
        /// 		     a = f("how", t.x, 14)
        /// 		</code>
        /// 		这里是 C 里的代码：
        /// 		<code>
        /// 		     lua_getfield(L, LUA_GLOBALSINDEX, "f");          /* 将调用的函数 */
        /// 		     lua_pushstring(L, "how");                          /* 第一个参数 */
        /// 		     lua_getfield(L, LUA_GLOBALSINDEX, "t");          /* table 的索引 */
        /// 		     lua_getfield(L, -1, "x");         /* 压入 t.x 的值（第 2 个参数）*/
        /// 		     lua_remove(L, -2);                           /* 从堆栈中移去 't' */
        /// 		     lua_pushinteger(L, 14);                           /* 第 3 个参数 */
        /// 		     lua_call(L, 3, 1); /* 调用 'f'，传入 3 个参数，并索取 1 个返回值 */
        /// 		     lua_setfield(L, LUA_GLOBALSINDEX, "a");      /* 设置全局变量 'a' */
        /// 		</code>
        /// 		注意上面这段代码是“平衡”的：
        /// 		到了最后，堆栈恢复成原由的配置。
        /// 		这是一种良好的编程习惯。
        /// 		
        /// 	</para>
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
        ///         lua栈不会自动增长，api调用者必须主动调用/CheckStack/以确保压入更多值不会导致栈溢出
        ///     返回lua栈是否能提供n个空闲格子
        ///     再次强调，对于c#，栈的容量指count，而不是capacity
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_checkstack">lua_checkstack</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_checkstack
        /// 		int lua_checkstack (lua_State *L, int extra);
        /// 		
        /// 		确保堆栈上至少有 extra 个空位。
        /// 		如果不能把堆栈扩展到相应的尺寸，函数返回 false 。
        /// 		这个函数永远不会缩小堆栈；
        /// 		如果堆栈已经比需要的大了，那么就放在那里不会产生变化。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_checkstack(int size)
        {
            bool res = true;

            if (size > luaconf.LUAI_MAXCSTACK || top - @base + size > luaconf.LUAI_MAXCSTACK) {
                res = false; /* stack overflow */
            } else if (size > 0) {
                luaD_checkstack(size);
                if (ci.top < top + size) {
                    ci.top = top + size;
                }
            }

            return res;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_concat">lua_concat</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_concat
        /// 		void lua_concat (lua_State *L, int n);
        /// 		
        /// 		连接栈顶的 n 个值，
        /// 		然后将这些值出栈，并把结果放在栈顶。
        /// 		如果 n 为 1 ，结果就是一个字符串放在栈上（即，函数什么都不做）；
        /// 		如果 n 为 0 ，结果是一个空串。
        /// 		
        /// 		连接依照 Lua 中创建语义完成（参见 §2.5.4 ）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_concat(int n)
        {

            api_checknelems(n);
            if (n >= 2) {
                luaV_concat(n, top - @base - 1);
                top -= n - 1;
            } else if (n == 0) { /* push empty string */
                top.Value.TStr = new TString("");
                api_incr_top();
            }
            /* else n == 1; nothing to do */

        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_cpcall">lua_cpcall</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_cpcall
        /// 		int lua_cpcall (lua_State *L, lua_CFunction func, void *ud);
        /// 		
        /// 		以保护模式调用 C 函数 func 。
        /// 		func 只有能从堆栈上拿到一个参数，就是包含有 ud 的 light userdata。
        /// 		当有错误时，
        /// 		lua_cpcall 返回和 lua_pcall 相同的错误代码，
        /// 		并在栈顶留下错误对象；
        /// 		否则它返回零，并不会修改堆栈。
        /// 		所有从 func 内返回的值都会被扔掉。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
        public void lua_cpcall()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_createtable">lua_createtable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_createtable
        /// 		void lua_createtable (lua_State *L, int narr, int nrec);
        /// 		
        /// 		创建一个新的空 table 压入堆栈。
        /// 		这个新 table 将被预分配 narr 个元素的数组空间
        /// 		以及 nrec 个元素的非数组空间。
        /// 		当你明确知道表中需要多少个元素时，预分配就非常有用。
        /// 		如果你不知道，可以使用函数 lua_newtable。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_createtable(int narray, int nrec)
        {
            top.Value.Table = new Table(narray, nrec);
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_dump">lua_dump</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_dump
        /// 		int lua_dump (lua_State *L, lua_Writer writer, void *data);
        /// 		
        /// 		把函数 dump 成二进制 chunk 。
        /// 		函数接收栈顶的 Lua 函数做参数，然后生成它的二进制 chunk 。
        /// 		若被 dump 出来的东西被再次加载，加载的结果就相当于原来的函数。
        /// 		当它在产生 chunk 的时候，lua_dump 
        /// 		通过调用函数 writer （参见 lua_Writer）
        /// 		来写入数据，后面的 data 参数会被传入 writer 。
        /// 		
        /// 		最后一次由写入器 (writer) 返回值将作为这个函数的返回值返回；
        /// 		0 表示没有错误。
        /// 		
        /// 		这个函数不会把 Lua 返回弹出堆栈。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
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
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_equal">lua_equal</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_equal
        /// 		int lua_equal (lua_State *L, int index1, int index2);
        /// 		
        /// 		如果依照 Lua 中 == 操作符语义，索引 index1 和 index2
        /// 		中的值相同的话，返回 1 。
        /// 		否则返回 0 。
        /// 		如果任何一个索引无效也会返回 0。
        /// 		
        /// 	</para>
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

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_error">lua_error</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_error
        /// 		int lua_error (lua_State *L);
        /// 		
        /// 		产生一个 Lua 错误。
        /// 		错误信息（实际上可以是任何类型的 Lua 值）必须被置入栈顶。
        /// 		这个函数会做一次长跳转，因此它不会再返回。
        /// 		（参见 luaL_error）。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
        public void lua_error()
        {
        }

        /// <summary>
        /// 注意这里是c函数，ud和thread有env表
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_getfenv">lua_getfenv</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_getfenv
        /// 		void lua_getfenv (lua_State *L, int index);
        /// 		
        /// 		把索引处值的环境表压入堆栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_getfenv(int idx)
        {
            TValue o;
            o = index2adr(idx);
            api_checkvalidindex(o);
            switch (o.tt) {
                case LuaType.LUA_TFUNCTION:
                    top.Value.Table = (o.Cl as CSharpClosure).env;
                    break;
                case LuaType.LUA_TUSERDATA:
                    top.Value.Table = o.Udata.env;
                    break;
                case LuaType.LUA_TTHREAD:
                    top.Value.Value = o.Thread.gt;
                    break;
                default:
                    top.SetNil();
                    break;
            }
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_getfield">lua_getfield</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_getfield
        /// 		void lua_getfield (lua_State *L, int index, const char *k);
        /// 		
        /// 		把 t[k] 值压入堆栈，
        /// 		这里的 t 是指有效索引 index 指向的值。
        /// 		在 Lua 中，这个函数可能触发对应 "index" 事件的元方法
        /// 		（参见 §2.8）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_getfield(int idx, string k)
        {
            TValue t;
            TValue key;
            t = index2adr(idx);
            api_checkvalidindex(t);
            key = new TValue(k);
            luaV_gettable(t, key, top);
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_getglobal">lua_getglobal</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_getglobal
        /// 		void lua_getglobal (lua_State *L, const char *name);
        /// 		
        /// 		把全局变量 name 里的值压入堆栈。
        /// 		这个是用一个宏定义出来的：
        /// 		
        /// 		     #define lua_getglobal(L,s)  lua_getfield(L, LUA_GLOBALSINDEX, s)
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_getglobal(string s)
        {
            lua_getfield(LUA_GLOBALSINDEX, s);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_getmetatable">lua_getmetatable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_getmetatable
        /// 		int lua_getmetatable (lua_State *L, int index);
        /// 		
        /// 		把给定索引指向的值的元表压入堆栈。
        /// 		如果索引无效，或是这个值没有元表，
        /// 		函数将返回 0 并且不会向栈上压任何东西。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_getmetatable(int objindex)
        {
            TValue obj;
            Table mt = null;
            bool res;
            obj = index2adr(objindex);
            switch ((obj).tt) {
                case LuaType.LUA_TTABLE:
                    mt = obj.Table.metatable;
                    break;
                case LuaType.LUA_TUSERDATA:
                    mt = obj.Udata.metatable;
                    break;
                default:
                    mt = G.mt[(int)obj.tt];
                    break;
            }
            if (mt == null)
                res = false;
            else {
                top.Value.Table = mt;
                api_incr_top();
                res = true;
            }
            return res;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_gettable">lua_gettable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_gettable
        /// 		void lua_gettable (lua_State *L, int index);
        /// 		
        /// 		把 t[k] 值压入堆栈，
        /// 		这里的 t 是指有效索引 index 指向的值，
        /// 		而 k 则是栈顶放的值。
        /// 		
        /// 		这个函数会弹出堆栈上的 key （把结果放在栈上相同位置）。
        /// 		在 Lua 中，这个函数可能触发对应 "index" 事件的元方法
        /// 		（参见 §2.8）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_gettable(int idx)
        {
            TValue t;
            t = index2adr(idx);
            api_checkvalidindex(t);
            luaV_gettable(t, top - 1, top - 1);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_gettop">lua_gettop</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_gettop
        /// 		int lua_gettop (lua_State *L);
        /// 		
        /// 		返回栈顶元素的索引。
        /// 		因为索引是从 1 开始编号的，
        /// 		所以这个结果等于堆栈上的元素个数（因此返回 0 表示堆栈为空）。
        /// 		
        /// 	</para>
        /// </remarks>
        public int lua_gettop()
        {
            return top - @base;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_insert">lua_insert</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_insert
        /// 		void lua_insert (lua_State *L, int index);
        /// 		
        /// 		把栈顶元素插入指定的有效索引处，
        /// 		并依次移动这个索引之上的元素。
        /// 		不要用伪索引来调用这个函数，
        /// 		因为伪索引不是真正指向堆栈上的位置。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_insert(int idx)
        {
            bool isValid;
            StkId p = realIndex2adr(idx, out isValid);
            api_check(isValid);
            for (StkId q = top; q > p; q--) q = q - 1;
            p = top;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isboolean">lua_isboolean</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isboolean
        /// 		int lua_isboolean (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值类型为 boolean 时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isboolean(int n)
        {
            return lua_type(n) == LuaType.LUA_TBOOLEAN;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_iscfunction">lua_iscfunction</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_iscfunction
        /// 		int lua_iscfunction (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个 C 函数时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_iscfunction(int idx)
        {
            TValue o = index2adr(idx);
            return o.IsCSharpFunction;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isfunction">lua_isfunction</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isfunction
        /// 		int lua_isfunction (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个函数（ C 或 Lua 函数均可）时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isfunction(int n)
        {
            return lua_type(n) == LuaType.LUA_TFUNCTION;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_islightuserdata">lua_islightuserdata</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_islightuserdata
        /// 		int lua_islightuserdata (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个 light userdata 时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_islightuserdata(int n)
        {
            return lua_type(n) == LuaType.LUA_TLIGHTUSERDATA;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isnil">lua_isnil</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isnil
        /// 		int lua_isnil (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是 nil 时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isnil(int n)
        {
            return lua_type(n) == LuaType.LUA_TNIL;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isnumber">lua_isnumber</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isnumber
        /// 		int lua_isnumber (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个数字，或是一个可转换为数字的字符串时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isnumber(int idx)
        {
            lua_Number n;
            TValue o = index2adr(idx);
            return tonumber(o, out n);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isstring">lua_isstring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isstring
        /// 		int lua_isstring (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个字符串或是一个数字（数字总能转换成字符串）时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isstring(int idx)
        {
            TValue o = index2adr(idx);
            return o.IsString || o.IsNumber;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_istable">lua_istable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_istable
        /// 		int lua_istable (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个 table 时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_istable(int n)
        {
            return lua_type(n) == LuaType.LUA_TTABLE;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isthread">lua_isthread</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isthread
        /// 		int lua_isthread (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个 thread 时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isthread(int n)
        {
            return lua_type(n) == LuaType.LUA_TTHREAD;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_isuserdata">lua_isuserdata</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_isuserdata
        /// 		int lua_isuserdata (lua_State *L, int index);
        /// 		
        /// 		当给定索引的值是一个 userdata （无论是完整的 userdata 还是 light userdata ）时，返回 1 ，否则返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_isuserdata(int n)
        {
            return lua_type(n) == LuaType.LUA_TUSERDATA;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_lessthan">lua_lessthan</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_lessthan
        /// 		int lua_lessthan (lua_State *L, int index1, int index2);
        /// 		
        /// 		如果索引 index1 处的值小于
        /// 		索引 index2 处的值时，返回 1 ；
        /// 		否则返回 0 。
        /// 		其语义遵循 Lua 中的 less 操作符（就是说，有可能调用元方法）。
        /// 		如果任何一个索引无效，也会返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_lessthan(int index1, int index2)
        {
            TValue o1, o2;
            bool i;
            o1 = index2adr(index1);
            o2 = index2adr(index2);
            i = isvalid(o1) && isvalid(o2) && luaV_lessthan(o1, o2);
            return i;
        }

        /// <summary>
        /// clua是parser或undump，zlua只parse
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_load">lua_load</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_load
        /// 		int lua_load (lua_State *L,
        /// 		              lua_Reader reader,
        /// 		              void *data,
        /// 		              const char *chunkname);
        /// 		
        /// 		加载一个 Lua chunk 。
        /// 		如果没有错误，
        /// 		lua_load 把一个编译好的 chunk 作为一个
        /// 		Lua 函数压入堆栈。
        /// 		否则，压入出错信息。
        /// 		lua_load 的返回值可以是：
        /// 		
        /// 		• 0: 没有错误；
        /// 		
        /// 		• LUA_ERRSYNTAX:
        /// 		在预编译时碰到语法错误；
        /// 		
        /// 		• LUA_ERRMEM:
        /// 		内存分配错误。
        /// 		
        /// 		这个函数仅仅加栽 chunk ；而不会去运行它。
        /// 		
        /// 		lua_load 会自动检测 chunk 是文本的还是二进制的，
        /// 		然后做对应的加载操作（参见程序 luac）。
        /// 		
        /// 		lua_load 函数使用一个用户提供的 reader 函数来
        /// 		读取 chunk （参见 lua_Reader）。
        /// 		data 参数会被传入读取器函数。
        /// 		
        /// 		chunkname 这个参数可以赋予 chunk 一个名字，
        /// 		这个名字被用于出错信息和调试信息（参见 §3.8）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_load(/*ICharStream chunk,*/ string chunkname)
        {
            throw new NotImplementedException();
            if (chunkname == null) {
                chunkname = "?";
            }

            //LuaLexer lexer = new LuaLexer(chunk);
            //CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            //LuaParser parser = new LuaParser(tokenStream);
            //LuaParser.ChunkContext tree = parser.chunk();
            //LuaCodeGenerator codeGenerator = new LuaCodeGenerator();
            //codeGenerator.Visit(tree);

            //Proto p = codeGenerator.Chunk;
            //Table env = new Table(1, 1);
            //env.luaH_set(new TValue("print")).Cl = new CSharpClosure
            //{
            //    f = L =>
            //    {
            //        TValue s = L.pop();
            //        Console.WriteLine(s.Str);
            //        return 0;
            //    }
            //};
            //LuaClosure cl = new LuaClosure(env, 1, p);
            //push(new TValue(cl));
        }

        /// <summary>
        /// 只被auxlib的luaL_newstate调用，clua中，这个函数只分配内存
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_newstate">lua_newstate</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_newstate
        /// 		lua_State *lua_newstate (lua_Alloc f, void *ud);
        /// 		
        /// 		创建的一个新的独立的状态机。
        /// 		如果创建不了（因为内存问题）返回 NULL 。
        /// 		参数 f 是一个分配器函数；
        /// 		Lua 将通过这个函数做状态机内所有的内存分配操作。
        /// 		第二个参数 ud ，这个指针将在每次调用分配器时被直接传入。
        /// 		
        /// 	</para>
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
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_newtable">lua_newtable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_newtable
        /// 		void lua_newtable (lua_State *L);
        /// 		
        /// 		创建一个空 table ，并将之压入堆栈。
        /// 		它等价于 lua_createtable(L, 0, 0) 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_newtable()
        {
            lua_createtable(0, 0);
        }

        /// <summary>
        /// 基于当前lua_State构建新lua_State实例并压栈
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_newthread">lua_newthread</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_newthread
        /// 		lua_State *lua_newthread (lua_State *L);
        /// 		
        /// 		创建一个新线程，并将其压入堆栈，
        /// 		并返回维护这个线程的 lua_State 指针。
        /// 		这个函数返回的新状态机共享原有状态机中的所有对象（比如一些 table），
        /// 		但是它有独立的执行堆栈。
        /// 		
        /// 		没有显式的函数可以用来关闭或销毁掉一个线程。
        /// 		线程跟其它 Lua 对象一样是垃圾收集的条目之一。
        /// 		
        /// 	</para>
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
        /// c#不能手工分配内存，所以
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_newuserdata">lua_newuserdata</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_newuserdata
        /// 		void *lua_newuserdata (lua_State *L, size_t size);
        /// 		
        /// 		这个函数分配分配一块指定大小的内存块，
        /// 		把内存块地址作为一个完整的 userdata 压入堆栈，并返回这个地址。
        /// 		
        /// 		userdata 代表 Lua 中的 C 值。
        /// 		完整的 userdata 代表一块内存。
        /// 		它是一个对象（就像 table 那样的对象）：
        /// 		你必须创建它，它有着自己的元表，而且它在被回收时，可以被监测到。
        /// 		一个完整的 userdata 只和它自己相等（在等于的原生作用下）。
        /// 		
        /// 		当 Lua 通过 gc 元方法回收一个完整的 userdata 时，
        /// 		Lua 调用这个元方法并把 userdata 标记为已终止。
        /// 		等到这个 userdata 再次被收集的时候，Lua 会释放掉相关的内存。
        /// 		
        /// 	</para>
        /// </remarks>
        public object lua_newuserdata()
        {
            Udata u;
            u = new Udata(getcurrenv());
            top.Value.Udata = u;
            api_incr_top();
            return u;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_next">lua_next</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_next
        /// 		int lua_next (lua_State *L, int index);
        /// 		
        /// 		从栈上弹出一个 key（键），
        /// 		然后把索引指定的表中 key-value（健值）对压入堆栈
        /// 		（指定 key 后面的下一 (next) 对）。
        /// 		如果表中以无更多元素，
        /// 		那么 lua_next 将返回 0 （什么也不压入堆栈）。
        /// 		
        /// 		典型的遍历方法是这样的：
        /// 		<code>
        /// 		     /* table 放在索引 't' 处 */
        /// 		     lua_pushnil(L);  /* 第一个 key */
        /// 		     while (lua_next(L, t) != 0) {
        /// 		       /* 用一下 'key' （在索引 -2 处） 和 'value' （在索引 -1 处） */
        /// 		       printf("%s - %s\n",
        /// 		              lua_typename(L, lua_type(L, -2)),
        /// 		              lua_typename(L, lua_type(L, -1)));
        /// 		       /* 移除 'value' ；保留 'key' 做下一次迭代 */
        /// 		       lua_pop(L, 1);
        /// 		     }
        /// 		</code>
        /// 		在遍历一张表的时候，
        /// 		不要直接对 key 调用 lua_tolstring ，
        /// 		除非你知道这个 key 一定是一个字符串。
        /// 		调用 lua_tolstring 有可能改变给定索引位置的值；
        /// 		这会对下一次调用 lua_next 造成影响。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_next(int idx)
        {
            TValue t;
            bool more;
            t = index2adr(idx);
            api_check(t.IsTable);
            more = t.Table.luaH_next(top - 1);
            if (more) {
                api_incr_top();
            } else  /* no more elements */
                top -= 1;  /* remove key */
            return more;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_objlen">lua_objlen</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_objlen
        /// 		size_t lua_objlen (lua_State *L, int index);
        /// 		
        /// 		返回指定的索引处的值的长度。
        /// 		对于 string ，那就是字符串的长度；
        /// 		对于 table ，是取长度操作符 ('#') 的结果；
        /// 		对于 userdata ，就是为其分配的内存块的尺寸；
        /// 		对于其它值，为 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public int lua_objlen(int idx)
        {
            TValue o = index2adr(idx);
            switch (o.tt) {
                case LuaType.LUA_TSTRING: return o.TStr.len;
                case LuaType.LUA_TUSERDATA: return o.Udata.len;
                case LuaType.LUA_TTABLE: return o.Table.luaH_getn();
                case LuaType.LUA_TNUMBER: {
                        int l;
                        l = (luaV_tostring(o) ? o.TStr.len : 0);
                        return l;
                    }
                default: return 0;
            }
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pcall">lua_pcall</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pcall
        /// 		lua_pcall (lua_State *L, int nargs, int nresults, int errfunc);
        /// 		
        /// 		以保护模式调用一个函数。
        /// 		
        /// 		nargs 和 nresults 的含义与
        /// 		lua_call 中的相同。
        /// 		如果在调用过程中没有发生错误，
        /// 		lua_pcall 的行为和 lua_call 完全一致。
        /// 		但是，如果有错误发生的话，
        /// 		lua_pcall 会捕获它，
        /// 		然后把单一的值（错误信息）压入堆栈，然后返回错误码。
        /// 		同 lua_call 一样，
        /// 		lua_pcall 总是把函数本身和它的参数从栈上移除。
        /// 		
        /// 		如果 errfunc 是 0 ，
        /// 		返回在栈顶的错误信息就和原始错误信息完全一致。
        /// 		否则，errfunc 就被当成是错误处理函数在栈上的索引。
        /// 		（在当前的实现里，这个索引不能是伪索引。）
        /// 		在发生运行时错误时，
        /// 		这个函数会被调用而参数就是错误信息。
        /// 		错误处理函数的返回值将被 lua_pcall 作为出错信息返回在堆栈上。
        /// 		
        /// 		典型的用法中，错误处理函数被用来在出错信息上加上更多的调试信息，比如栈跟踪信息 (stack traceback) 。
        /// 		这些信息在 lua_pcall 返回后，因为栈已经展开 (unwound) ，
        /// 		所以收集不到了。
        /// 		
        /// 		lua_pcall 函数在调用成功时返回 0 ，
        /// 		否则返回以下（定义在 lua.h 中的）错误代码中的一个：
        /// 		
        /// 		• LUA_ERRRUN:
        /// 		运行时错误。
        /// 		
        /// 		• LUA_ERRMEM:
        /// 		内存分配错误。
        /// 		对于这种错，Lua 调用不了错误处理函数。
        /// 		
        /// 		• LUA_ERRERR:
        /// 		在运行错误处理函数时发生的错误。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
        public void lua_pcall()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pop">lua_pop</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pop
        /// 		void lua_pop (lua_State *L, int n);
        /// 		
        /// 		从堆栈中弹出 n 个元素。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pop(int n)
        {
            lua_settop(-(n) - 1);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushboolean">lua_pushboolean</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushboolean
        /// 		void lua_pushboolean (lua_State *L, int b);
        /// 		
        /// 		把 b 作为一个 boolean 值压入堆栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushboolean(bool b)
        {
            top.Value.B = b;  /* ensure that true is 1 */
            api_incr_top();
        }

        /// <summary>
        /// 创建c闭包，有n个upval（是TValue），upvals已经被压栈了
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushcclosure">lua_pushcclosure</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushcclosure
        /// 		void lua_pushcclosure (lua_State *L, lua_CFunction fn, int n);
        /// 		
        /// 		把一个新的 C closure 压入堆栈。
        /// 		
        /// 		当创建了一个 C 函数后，你可以给它关联一些值，这样就是在创建一个 C closure
        /// 		（参见 §3.4）；
        /// 		接下来无论函数何时被调用，这些值都可以被这个函数访问到。
        /// 		为了将一些值关联到一个 C 函数上，
        /// 		首先这些值需要先被压入堆栈（如果有多个值，第一个先压）。
        /// 		接下来调用 lua_pushcclosure
        /// 		来创建出 closure 并把这个 C 函数压到堆栈上。
        /// 		参数 n 告之函数有多少个值需要关联到函数上。
        /// 		lua_pushcclosure 也会把这些值从栈上弹出。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushcclosure(lua_CFunction fn, int n)
        {
            CSharpClosure cl = new CSharpClosure
            {
                f = fn,
                upvalue = new TValue[n],
                env = getcurrenv()
            };
            api_checknelems(n);
            top -= n;
            while (n-- != 0)
                cl.upvalue[n] = top + n;
            top.Value.Cl = cl;
            api_incr_top();
        }

        /// <summary>
        /// 创建c函数，与pushcclosure的区别在于无upval
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushcfunction">lua_pushcfunction</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushcfunction
        /// 		void lua_pushcfunction (lua_State *L, lua_CFunction f);
        /// 		
        /// 		将一个 C 函数压入堆栈。
        /// 		这个函数接收一个 C 函数指针，并将一个类型为 function 的 Lua 值
        /// 		压入堆栈。当这个栈顶的值被调用时，将触发对应的 C 函数。
        /// 		
        /// 		注册到 Lua 中的任何函数都必须遵循正确的协议来接收参数和返回值
        /// 		（参见 lua_CFunction）。
        /// 		
        /// 		lua_pushcfunction 是作为一个宏定义出现的：
        /// 		
        /// 		     #define lua_pushcfunction(L,f)  lua_pushcclosure(L,f,0)
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushcfunction(lua_CFunction f)
        {
            lua_pushcclosure(f, 0);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushfstring">lua_pushfstring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushfstring
        /// 		const char *lua_pushfstring (lua_State *L, const char *fmt, ...);
        /// 		
        /// 		把一个格式化过的字符串压入堆栈，然后返回这个字符串的指针。
        /// 		它和 C 函数 sprintf 比较像，不过有一些重要的区别：
        /// 		
        /// 		• 
        /// 		摸你需要为结果分配空间：
        /// 		其结果是一个 Lua 字符串，由 Lua 来关心其内存分配
        /// 		（同时通过垃圾收集来释放内存）。
        /// 		
        /// 		• 
        /// 		这个转换非常的受限。
        /// 		不支持 flag ，宽度，或是指定精度。
        /// 		它只支持下面这些：
        /// 		'%%' （插入一个 '%'），
        /// 		'%s' （插入一个带零终止符的字符串，没有长度限制），
        /// 		'%f' （插入一个 lua_Number），
        /// 		'%p' （插入一个指针或是一个十六进制数），
        /// 		'%d' （插入一个 int)，
        /// 		'%c' （把一个 int 作为一个字符插入）。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete]
        public void lua_pushfstring()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushinteger">lua_pushinteger</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushinteger
        /// 		void lua_pushinteger (lua_State *L, lua_Integer n);
        /// 		
        /// 		把 n 作为一个数字压栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushinteger(lua_Integer n)
        {
            top.Value.N = (lua_Number)(n.Value);
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushlightuserdata">lua_pushlightuserdata</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushlightuserdata
        /// 		void lua_pushlightuserdata (lua_State *L, void *p);
        /// 		
        /// 		把一个 light userdata 压栈。
        /// 		
        /// 		userdata 在 Lua 中表示一个 C 值。
        /// 		light userdata 表示一个指针。
        /// 		它是一个像数字一样的值：
        /// 		你不需要专门创建它，它也没有独立的 metatable ，
        /// 		而且也不会被收集（因为从来不需要创建）。
        /// 		只要表示的 C 地址相同，两个 light userdata 就相等。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushlightuserdata(object p)
        {
            top.Value.LightUserdata = p;
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushlstring">lua_pushlstring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushlstring
        /// 		void lua_pushlstring (lua_State *L, const char *s, size_t len);
        /// 		
        /// 		把指针 s 指向的长度为 len 的字符串压栈。
        /// 		Lua 对这个字符串做一次内存拷贝（或是复用一个拷贝），
        /// 		因此 s 处的内存在函数返回后，可以释放掉或是重用于其它用途。
        /// 		字符串内可以保存有零字符。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushlstring(string s)
        {
            top.Value.TStr = new TString(s);
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushnil">lua_pushnil</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushnil
        /// 		void lua_pushnil (lua_State *L);
        /// 		
        /// 		把一个 nil 压栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushnil()
        {
            top.SetNil();
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushnumber">lua_pushnumber</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushnumber
        /// 		void lua_pushnumber (lua_State *L, lua_Number n);
        /// 		
        /// 		把一个数字 n 压栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushnumber(lua_Number n)
        {
            top.Value.N = n;
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushstring">lua_pushstring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushstring
        /// 		void lua_pushstring (lua_State *L, const char *s);
        /// 		
        /// 		把指针 s 指向的以零结尾的字符串压栈。
        /// 		Lua 对这个字符串做一次内存拷贝（或是复用一个拷贝），
        /// 		因此 s 处的内存在函数返回后，可以释放掉或是重用于其它用途。
        /// 		字符串中不能包含有零字符；第一个碰到的零字符会认为是字符串的结束。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushstring(string s)
        {
            if (s == null)
                lua_pushnil();
            else
                lua_pushlstring(s);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushthread">lua_pushthread</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushthread
        /// 		int lua_pushthread (lua_State *L);
        /// 		
        /// 		把 L 中提供的线程压栈。
        /// 		如果这个线程是当前状态机的主线程的话，返回 1 。
        /// 		
        /// 	</para>
        /// </remarks>
        public bool lua_pushthread(lua_State L)
        {
            top.Value.Thread = L;
            api_incr_top();
            return (G.mainthread == L);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_pushvalue">lua_pushvalue</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_pushvalue
        /// 		void lua_pushvalue (lua_State *L, int index);
        /// 		
        /// 		把堆栈上给定有效处索引处的元素作一个拷贝压栈。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_pushvalue(int idx)
        {
            top.Value.Value = index2adr(idx);
            api_incr_top();
        }

        /// <summary>
        /// lua_equal和lua_rawequal的区别在于前者调用元方法
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_rawequal">lua_rawequal</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_rawequal
        /// 		int lua_rawequal (lua_State *L, int index1, int index2);
        /// 		
        /// 		如果两个索引 index1 和 index2 处的值简单地相等
        /// 		（不调用元方法）则返回 1 。
        /// 		否则返回 0 。
        /// 		如果任何一个索引无效也返回 0 。
        /// 		
        /// 	</para>
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
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_rawget">lua_rawget</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_rawget
        /// 		void lua_rawget (lua_State *L, int index);
        /// 		
        /// 		类似于 lua_gettable，
        /// 		但是作一次直接访问（不触发元方法）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_rawget(int idx)
        {
            TValue t;
            t = index2adr(idx);
            api_check(t.IsTable);
            (top - 1).Value.Value = t.Table.luaH_get(top - 1);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_rawgeti">lua_rawgeti</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_rawgeti
        /// 		void lua_rawgeti (lua_State *L, int index, int n);
        /// 		
        /// 		把 t[n] 的值压栈，
        /// 		这里的 t 是指给定索引 index 处的一个值。
        /// 		这是一个直接访问；就是说，它不会触发元方法。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_rawgeti(int idx, int n)
        {
            TValue o;
            o = index2adr(idx);
            api_check(o.IsTable);
            top.Value.Value = o.Table.luaH_getnum(n);
            api_incr_top();
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_rawset">lua_rawset</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_rawset
        /// 		void lua_rawset (lua_State *L, int index);
        /// 		
        /// 		类似于 lua_settable，
        /// 		但是是作一个直接赋值（不触发元方法）。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete(message: "太繁琐了")]
        public void lua_rawset(int idx)
        {
            //StkId t;
            //api_checknelems(L, 2);
            //t = index2adr(L, idx);
            //api_check(L, ttistable(t));
            //setobj2t(L, luaH_set(L, hvalue(t), L->top - 2), L->top - 1);
            //L->top -= 2;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_rawseti">lua_rawseti</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_rawseti
        /// 		void lua_rawseti (lua_State *L, int index, int n);
        /// 		
        /// 		等价于 t[n] = v，
        /// 		这里的 t 是指给定索引 index 处的一个值，
        /// 		而 v 是栈顶的值。
        /// 		
        /// 		函数将把这个值弹出栈。
        /// 		赋值操作是直接的；就是说，不会触发元方法。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete(message: "太繁琐了")]
        public void lua_rawseti()
        {
        }

        /// <summary>
        /// 注册一个C#函数，在lua代码中用name调用
        /// 被调用函数被包装成closure，在G中，key是`name
        /// no upval，你要自己设置（永远用不到）
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_register">lua_register</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_register
        /// 		void lua_register (lua_State *L,
        /// 		                   const char *name,
        /// 		                   lua_CFunction f);
        /// 		
        /// 		把 C 函数 f 设到全局变量 name 中。
        /// 		它通过一个宏定义：
        /// 		
        /// 		     #define lua_register(L,n,f) \
        /// 		            (lua_pushcfunction(L, f), lua_setglobal(L, n))
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_register(string name, lua_CFunction f)
        {
            lua_pushcfunction(f);
            lua_setglobal(name);
        }

        /// <summary>
        /// 删除指定位置的值，这个位置之后的格子依次向前移动一格
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_remove">lua_remove</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_remove
        /// 		void lua_remove (lua_State *L, int index);
        /// 		
        /// 		从给定有效索引处移除一个元素，
        /// 		把这个索引之上的所有元素移下来填补上这个空隙。
        /// 		不能用伪索引来调用这个函数，
        /// 		因为伪索引并不指向真实的栈上的位置。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_remove(int idx)
        {
            StkId p;
            bool isValid;
            p = realIndex2adr(idx, out isValid);
            api_check(isValid);
            while (++p < top) (p - 1).Value.Value = p;
            top--;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_replace">lua_replace</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_replace
        /// 		void lua_replace (lua_State *L, int index);
        /// 		
        /// 		把栈顶元素移动到给定位置（并且把这个栈顶元素弹出），
        /// 		不移动任何元素（因此在那个位置处的值被覆盖掉）。
        /// 		
        /// 	</para>
        /// </remarks>
        [Obsolete(message: "太繁琐了")]
        public void lua_replace()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_resume">lua_resume</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_resume
        /// 		int lua_resume (lua_State *L, int narg);
        /// 		
        /// 		在给定线程中启动或继续一个 coroutine 。
        /// 		
        /// 		要启动一个 coroutine 的话，首先你要创建一个新线程
        /// 		（参见 lua_newthread ）；
        /// 		然后把主函数和若干参数压到新线程的堆栈上；
        /// 		最后调用 lua_resume ，
        /// 		把 narg 设为参数的个数。
        /// 		这次调用会在 coroutine 挂起时或是结束运行后返回。
        /// 		当函数返回时，堆栈中会有传给 lua_yield 的所有值，
        /// 		或是主函数的所有返回值。
        /// 		如果 coroutine 切换时，lua_resume 返回
        /// 		LUA_YIELD ，
        /// 		而当 coroutine 结束运行且没有任何错误时，返回 0 。
        /// 		如果有错则返回错误代码（参见 lua_pcall）。
        /// 		在发生错误的情况下，
        /// 		堆栈没有展开，
        /// 		因此你可以使用 debug API 来处理它。
        /// 		出错信息放在栈顶。
        /// 		要继续运行一个 coroutine 的话，你把需要传给 yield
        /// 		作结果的返回值压入堆栈，然后调用 lua_resume 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_resume()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_setfenv">lua_setfenv</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_setfenv
        /// 		int lua_setfenv (lua_State *L, int index);
        /// 		
        /// 		从堆栈上弹出一个 table 并把它设为指定索引处值的新环境。
        /// 		如果指定索引处的值即不是函数又不是线程或是 userdata ，
        /// 		lua_setfenv 会返回 0 ，
        /// 		否则返回 1 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_setfenv()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_setfield">lua_setfield</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_setfield
        /// 		void lua_setfield (lua_State *L, int index, const char *k);
        /// 		
        /// 		做一个等价于 t[k] = v 的操作，
        /// 		这里 t 是给出的有效索引 index 处的值，
        /// 		而 v 是栈顶的那个值。
        /// 		
        /// 		这个函数将把这个值弹出堆栈。
        /// 		跟在 Lua 中一样，这个函数可能触发一个 "newindex" 事件的元方法
        /// 		（参见 §2.8）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_setfield(int idx, string k)
        {
            api_checknelems(1);
            TValue t = index2adr(idx);
            api_checkvalidindex(t);
            TValue key = new TValue(k);
            luaV_settable(t, key, top - 1);
            top--;  /* pop value */
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_setglobal">lua_setglobal</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_setglobal
        /// 		void lua_setglobal (lua_State *L, const char *name);
        /// 		
        /// 		从堆栈上弹出一个值，并将其设到全局变量 name 中。
        /// 		它由一个宏定义出来：
        /// 		
        /// 		     #define lua_setglobal(L,s)   lua_setfield(L, LUA_GLOBALSINDEX, s)
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_setglobal(string s)
        {
            lua_setfield(LUA_GLOBALSINDEX, s);
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_setmetatable">lua_setmetatable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_setmetatable
        /// 		int lua_setmetatable (lua_State *L, int index);
        /// 		
        /// 		把一个 table 弹出堆栈，并将其设为给定索引处的值的 metatable 。
        /// 		
        /// 	</para>
        /// </remarks>
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

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_settable">lua_settable</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_settable
        /// 		void lua_settable (lua_State *L, int index);
        /// 		
        /// 		作一个等价于 t[k] = v 的操作，
        /// 		这里 t 是一个给定有效索引 index 处的值，
        /// 		v 指栈顶的值，
        /// 		而 k 是栈顶之下的那个值。
        /// 		
        /// 		这个函数会把键和值都从堆栈中弹出。
        /// 		和在 Lua 中一样，这个函数可能触发 "newindex" 事件的元方法
        /// 		（参见 §2.8）。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_settable()
        {
        }

        /// <summary>
        /// 将栈顶设为/idx/，/idx/小于当前栈顶索引时，相当于弹出或者说截断多余的部分，
        /// 相反地，如果/idx/大于当前栈顶索引时，相当于压入nil来填补
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_settop">lua_settop</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_settop
        /// 		void lua_settop (lua_State *L, int index);
        /// 		
        /// 		参数允许传入任何可接受的索引以及 0 。
        /// 		它将把堆栈的栈顶设为这个索引。
        /// 		如果新的栈顶比原来的大，超出部分的新元素将被填为 nil 。
        /// 		如果 index 为 0 ，把栈上所有元素移除。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_settop(int idx)
        {
            if (idx >= 0) {
                api_check(idx <= stack_last - @base);
                while (top < @base + idx)
                    (top++).SetNil();
                top = @base + idx;
            } else {
                api_check(-(idx + 1) <= (top - @base));
                top += idx + 1;  /* `subtract' index (index is negative) */
            }
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_status">lua_status</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_status
        /// 		int lua_status (lua_State *L);
        /// 		
        /// 		返回线程 L 的状态。
        /// 		
        /// 		正常的线程状态是 0 。
        /// 		当线程执行完毕或发生一个错误时，状态值是错误码。
        /// 		如果线程被挂起，状态为 LUA_YIELD 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_status()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_toboolean">lua_toboolean</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_toboolean
        /// 		int lua_toboolean (lua_State *L, int index);
        /// 		
        /// 		把指定的索引处的的 Lua 值转换为一个 C 中的 boolean 值（ 0 或是 1 ）。
        /// 		和 Lua 中做的所有测试一样，
        /// 		lua_toboolean 会把任何
        /// 		不同于 false 和 nil 的值当作 1 返回；
        /// 		否则就返回 0 。
        /// 		如果用一个无效索引去调用也会返回 0 。
        /// 		（如果你想只接收真正的 boolean 值，就需要使用
        /// 		lua_isboolean 来测试值的类型。）
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_toboolean()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tocfunction">lua_tocfunction</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tocfunction
        /// 		lua_CFunction lua_tocfunction (lua_State *L, int index);
        /// 		
        /// 		把给定索引处的 Lua 值转换为一个 C 函数。
        /// 		这个值必须是一个 C 函数；如果不是就返回
        /// 		NULL 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tocfunction()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tointeger">lua_tointeger</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tointeger
        /// 		lua_Integer lua_tointeger (lua_State *L, int idx);
        /// 		
        /// 		把给定索引处的 Lua 值转换为 lua_Integer 
        /// 		这样一个有符号整数类型。
        /// 		这个 Lua 值必须是一个数字或是一个可以转换为数字的字符串
        /// 		（参见 §2.2.1）；
        /// 		否则，lua_tointeger 返回 0 。
        /// 		
        /// 		如果数字不是一个整数，
        /// 		截断小数部分的方式没有被明确定义。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tointeger()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tolstring">lua_tolstring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tolstring
        /// 		const char *lua_tolstring (lua_State *L, int index, size_t *len);
        /// 		
        /// 		把给定索引处的 Lua 值转换为一个 C 字符串。
        /// 		如果 len 不为 NULL ，
        /// 		它还把字符串长度设到 *len 中。
        /// 		这个 Lua 值必须是一个字符串或是一个数字；
        /// 		否则返回返回 NULL 。
        /// 		如果值是一个数字，lua_tolstring 
        /// 		还会把堆栈中的那个值的实际类型转换为一个字符串。
        /// 		（当遍历一个表的时候，把 lua_tolstring
        /// 		作用在键上，这个转换有可能导致 lua_next 弄错。）
        /// 		
        /// 		lua_tolstring 返回 Lua 状态机中
        /// 		字符串的以对齐指针。
        /// 		这个字符串总能保证 （ C 要求的）最后一个字符为零 ('\0') ，
        /// 		而且它允许在字符串内包含多个这样的零。
        /// 		因为 Lua 中可能发生垃圾收集，
        /// 		所以不保证 lua_tolstring 返回的指针，
        /// 		在对应的值从堆栈中移除后依然有效。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tolstring()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tonumber">lua_tonumber</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tonumber
        /// 		lua_Number lua_tonumber (lua_State *L, int index);
        /// 		
        /// 		把给定索引处的 Lua 值转换为 lua_Number
        /// 		这样一个 C 类型（参见 lua_Number ）。
        /// 		这个 Lua 值必须是一个数字或是一个可转换为数字的字符串
        /// 		（参见 §2.2.1 ）；
        /// 		否则，lua_tonumber 返回 0 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tonumber()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_topointer">lua_topointer</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_topointer
        /// 		const void *lua_topointer (lua_State *L, int index);
        /// 		
        /// 		把给定索引处的值转换为一般的 C 指针 (void*) 。
        /// 		这个值可以是一个 userdata ，table ，thread 或是一个 function ；
        /// 		否则，lua_topointer 返回 NULL 。
        /// 		不同的对象有不同的指针。
        /// 		不存在把指针再转回原有类型的方法。
        /// 		
        /// 		这个函数通常只为产生 debug 信息用。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_topointer()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tostring">lua_tostring</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tostring
        /// 		const char *lua_tostring (lua_State *L, int index);
        /// 		
        /// 		等价于 lua_tolstring ，而参数 len 设为 NULL 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tostring()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_tothread">lua_tothread</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_tothread
        /// 		lua_State *lua_tothread (lua_State *L, int index);
        /// 		
        /// 		把给定索引处的值转换为一个 Lua 线程（由 lua_State* 代表）。
        /// 		这个值必须是一个线程；否则函数返回 NULL 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_tothread()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_touserdata">lua_touserdata</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_touserdata
        /// 		void *lua_touserdata (lua_State *L, int index);
        /// 		
        /// 		如果给定索引处的值是一个完整的 userdata ，函数返回内存块的地址。
        /// 		如果值是一个 light userdata ，那么就返回它表示的指针。
        /// 		否则，返回 NULL 。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_touserdata()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_type">lua_type</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_type
        /// 		int lua_type (lua_State *L, int index);
        /// 		
        /// 		返回给定索引处的值的类型，
        /// 		当索引无效时则返回 LUA_TNONE
        /// 		（那是指一个指向堆栈上的空位置的索引）。
        /// 		lua_type 返回的类型是一些个在 lua.h 中定义的常量：
        /// 		LUA_TNIL ，
        /// 		LUA_TNUMBER ，
        /// 		LUA_TBOOLEAN ，
        /// 		LUA_TSTRING ，
        /// 		LUA_TTABLE ，
        /// 		LUA_TFUNCTION ，
        /// 		LUA_TUSERDATA ，
        /// 		LUA_TTHREAD ，
        /// 		LUA_TLIGHTUSERDATA 。
        /// 		
        /// 	</para>
        /// </remarks>
        public LuaType lua_type(int idx)
        {
            TValue o = index2adr(idx);
            //TODO lobject.h line 136 ttnov很奇怪，它对tt进行掩码干嘛呢。。
            //不过zlua不需要，返回类型枚举即可
            return isvalid(o) ? o.tt : LuaType.LUA_TNONE;
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_typename">lua_typename</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_typename
        /// 		const char *lua_typename  (lua_State *L, int tp);
        /// 		
        /// 		返回 tp 表示的类型名，
        /// 		这个 tp 必须是 lua_type 可能返回的值中之一。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_typename()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_xmove">lua_xmove</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_xmove
        /// 		void lua_xmove (lua_State *from, lua_State *to, int n);
        /// 		
        /// 		传递 同一个 全局状态机下不同线程中的值。
        /// 		
        /// 		这个函数会从 from 的堆栈中弹出 n 个值，
        /// 		然后把它们压入 to 的堆栈中。
        /// 		
        /// 	</para>
        /// </remarks>
        public void lua_xmove()
        {
        }

        /// <summary>
        /// 	<see href="https://www.lua.org/manual/5.1/manual.html#lua_yield">lua_yield</see>
        /// </summary>
        /// <remarks>
        /// 	<para>
        /// 		lua_yield
        /// 		int lua_yield  (lua_State *L, int nresults);
        /// 		
        /// 		切出一个 coroutine 。
        /// 		
        /// 		这个函数只能在一个 C 函数的返回表达式中调用。如下：
        /// 		
        /// 		     return lua_yield (L, nresults);
        /// 		
        /// 		当一个 C 函数这样调用 lua_yield ，
        /// 		正在运行中的 coroutine 将从运行中挂起，
        /// 		然后启动这个 coroutine 用的那次对 lua_resume 的调用就返回了。
        /// 		参数 nresults 指的是堆栈中需要返回的结果个数，这些返回值将被传递给
        /// 		lua_resume 。/// 	</para>
        /// </remarks>
        public void lua_yield()
        {
        }

        private Table getcurrenv()
        {
            if (CallStack.Count == 1) /* no enclosing function? */ {
                return gt.Table; /* use global table as environment */
            }
            CSharpClosure func = curr_func as CSharpClosure;
            return func.env;
        }

        /// <summary>
        /// 自己写的helper，lua_insert会用到，因为它需要指针算法，直接用index2adr伪索引部分会很糟糕
        /// 事实上，这些函数必须使用真索引，所以写一个helper
        /// </summary>
        /// <param name="idx"></param>
        private StkId realIndex2adr(int idx, out bool isValid)
        {
            isValid = true;
            if (idx > 0) {
                StkId o = @base + (idx - 1);
                api_check(idx <= ci.top - @base);
                if (o >= top) {
                    isValid = false;
                    return null;
                }
                return o;
            }
            if (idx > LUA_REGISTRYINDEX) {
                api_check(idx != 0 && -idx <= top - @base);
                return top + idx;
            } else {
                throw new Exception("dont use pseudo indice here");
            }
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
    }
}