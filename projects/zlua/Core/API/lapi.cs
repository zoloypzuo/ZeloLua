

using System.Diagnostics;
using ZoloLua.Core.Lua;
using ZoloLua.Core.ObjectModel;


namespace ZoloLua.Core.API
{
    /// <summary>
    ///  lua API
    /// </summary>
    public class lapi
    {

    }
}

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        [DebuggerStepThrough]
        private void api_checknelems(int n)
        {
            // clua实现最后相当于空语句，因此是断言不是异常
            Debug.Assert(n <= top - @base);
        }

        /*
        ** `load' and `call' functions (run Lua code)
        */

        [DebuggerStepThrough]
        private void adjustresults(int nres)
        {
            if (nres == LUA_MULTRET && top >= ci.top) ci.top = top;
        }

        [DebuggerStepThrough]
        private void checkresults(int na, int nr)
        {
            Debug.Assert(nr == LUA_MULTRET || ci.top - top >= nr - na);
        }

        private void lua_call(int nargs, int nresults)
        {
            StkId func;
            api_checknelems(nargs + 1);
            checkresults(nargs, nresults);
            func = top - (nargs + 1);
            luaD_call(func, nresults);
            adjustresults(nresults);
        }

        private void f_call(lua_State L, object ud)
        {
            // lua_State内的PFunc的L只是装饰，一定传入this
            Debug.Assert(ReferenceEquals(L, this));
            // 这里不是很清楚为什么要多定义一个CallS
            CallS c = (CallS)ud;
            luaD_call(c.func, c.nresults);
        }

        //luaL_dofile调用如下
        //lua_pcall(nargs: 0, nresults: LUA_MULTRET, errfunc: 0);
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

        /// <summary>
        ///     这是编程错误，clua里是空的
        /// </summary>
        /// <param name="b"></param>
        private void api_check(bool b)
        {
            Debug.Assert(b);
        }

        private TValue index2adr(int idx)
        {
            if (idx > 0) {
                StkId o = @base + (idx - 1);
                api_check(idx <= ci.top - @base);
                if (o >= top) return lobject.luaO_nilobject;
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

        private void api_checkvalidindex(TValue i)
        {
            api_check(!ReferenceEquals(i, lobject.luaO_nilobject));
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

        /*
        ** Execute a protected call.
        */

        private struct CallS
        { /* data to `f_call' */
            public StkId func;
            public int nresults;
        }

        //public int GetTop()
        //{
        //    return this.LuaStack.top;
        //}

        //public int AbsIndex(int idx)
        //{
        //    return LuaStack.absIndex(idx);
        //}

        //// lua栈不会自动增长，api调用者必须主动调用/CheckStack/以确保压入更多值不会导致栈溢出
        //// 返回是否有n个空闲格子
        //// 再次强调，对于c#，栈的容量指count，而不是capacity
        //public bool CheckStack(int n)
        //{
        //    LuaStack.check(n);
        //    return true;  // never fails
        //}

        //public void Pop(int n)
        //{
        //    for (int i = 0; i < n; i++) {
        //        LuaStack.pop();
        //    }
        //}

        //public void Copy(int fromIdx, int toIdx)
        //{
        //    var val = LuaStack.get(fromIdx);
        //    LuaStack.set(toIdx, val);
        //}

        //// 把索引处的值压栈
        //public void PushValue(int idx)
        //{
        //    var val = LuaStack.get(idx);
        //    LuaStack.push(val);
        //}

        //// /PushVale/的逆操作
        //public void Replace(int idx)
        //{
        //    var val = LuaStack.pop();
        //    LuaStack.set(idx, val);
        //}

        //// 弹栈，插入指定位置
        //public void Insert(int idx)
        //{
        //    Rotate(idx, 1);
        //}

        //// 删除指定位置的值，这个位置之后的格子依次向前移动一格
        //public void Remove(int idx)
        //{
        //    Rotate(idx, -1);
        //    Pop(1);
        //}

        //// [idx, top]之间的值朝向栈顶方向旋转n个位置，n为负数则朝向栈底方向
        ////
        //// 这个就是向栈顶循环移动n个格子，n可以是负数
        //// 如果不能理解，参见p62
        //public void Rotate(int idx, int n)
        //{
        //    var t = LuaStack.top - 1;
        //    var p = LuaStack.absIndex(idx) - 1;
        //    int m;
        //    if (n >= 0) {
        //        m = t - n;
        //    } else {
        //        m = p - n - 1;
        //    }
        //    LuaStack.reverse(p, m);
        //    LuaStack.reverse(m + 1, t);
        //    LuaStack.reverse(p, t);
        //}

        //// 将栈顶设为/idx/，/idx/小于当前栈顶索引时，相当于弹出或者说截断多余的部分，
        //// 相反地，如果/idx/大于当前栈顶索引时，相当于压入nil来填补
        ////
        //// /Pop/相当于SetTop(-n-1)
        //public void SetTop(int idx)
        //{
        //    var newTop = LuaStack.absIndex(idx);
        //    if (newTop < 0) {
        //        throw new Exception("stack underflow");
        //    }

        //    int n = LuaStack.top - newTop;
        //    if (n > 0) {
        //        for (int i = 0; i < n; i++) {
        //            LuaStack.pop();
        //        }
        //    } else if (n < 0) {
        //        for (int i = 0; i > n; i--) {
        //            LuaStack.push(new TValue());
        //        }
        //    }
        //}

        //#region Push*方法 将某一类型的luaValue压栈

        //public void PushNil()
        //{
        //    LuaStack.push(new TValue());
        //}

        //public void PushBoolean(bool b)
        //{
        //    LuaStack.push(new TValue(b));
        //}

        //public void PushNumber(double n)
        //{
        //    LuaStack.push(new TValue(n));
        //}

        //public void PushString(string s)
        //{
        //    LuaStack.push(new TValue(s));
        //}

        //#endregion Push*方法 将某一类型的luaValue压栈

        //#region Access*方法 从栈获取值

        //public string TypeName(LuaType type)
        //{
        //    return type.ToString();
        //}

        //// 无效索引返回LUA_TNONE
        //public LuaType Type(int idx)
        //{
        //    if (LuaStack.isValid(idx)) {
        //        var val = LuaStack.get(idx);
        //        return val.tt;
        //    } else {
        //        return LuaType.LUA_TNONE;
        //    }
        //}

        //public bool IsNone(int idx)
        //{
        //    return Type(idx) == LuaType.LUA_TNONE;
        //}

        //public bool IsNil(int idx)
        //{
        //    return Type(idx) == LuaType.LUA_TNIL;
        //}

        //public bool IsNoneOrNil(int idx)
        //{
        //    return IsNone(idx) || IsNil(idx);
        //}

        //public bool IsBoolean(int idx)
        //{
        //    return Type(idx) == LuaType.LUA_TBOOLEAN;
        //}

        //// 注意lua类型转换规格
        //public bool IsString(int idx)
        //{
        //    return Type(idx) == LuaType.LUA_TNUMBER || Type(idx) == LuaType.LUA_TSTRING;
        //}

        //public bool IsNumber(int idx)
        //{
        //    //return ToNumberX(idx);
        //    return false;
        //}

        //public bool IsInteger(int idx)
        //{
        //    return Type(idx) == LuaType.LUA_TNUMBER;
        //}

        //public bool ToBoolean(int idx)
        //{
        //    return convertToBoolean(LuaStack.get(idx));
        //}

        //private bool convertToBoolean(TValue luaValue)
        //{
        //    switch (luaValue.tt) {
        //        case LuaType.LUA_TNIL:
        //            return false;

        //        case LuaType.LUA_TBOOLEAN:
        //            return luaValue.B;

        //        default:
        //            return true;
        //    }
        //}

        //#endregion Access*方法 从栈获取值
    }

    //public static class LApi
    //{
    //    #region load and call functions (run Lua code)
    //    public static void LoadFile(this TThread L, string path)
    //    {
    //        AntlrInputStream inputStream; //输入流传递给antlr的输入流
    //        LuaLexer lexer; //*传递给lexer
    //        CommonTokenStream tokens; //lexer分析好token流
    //        LuaParser parser; //*由token流生成AST
    //        //LParser lp = new LParser(); //Listener遍历AST返回Proto
    //        using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read)) {
    //            inputStream = new AntlrInputStream(fs);
    //            lexer = new LuaLexer(inputStream);
    //            tokens = new CommonTokenStream(lexer);
    //            parser = new LuaParser(tokens);
    //            var tree = parser.chunk();
    //            var walker = new ParseTreeWalker();
    //            lp.Visit(tree);
    //        }
    //        Proto proto = lp.ChunkProto;
    //        //初始化k
    //        L.ns = new List<TValue>();
    //        foreach (var item in lp.ChunkProto.ns) {
    //            L.ns.Add((TValue)item);
    //        }
    //        L.strs = new List<TValue>();
    //        foreach (var item in lp.ChunkProto.strs) {
    //            L.strs.Add((TValue)item);
    //        }
    //        Closure closure = new LuaClosure(env: (TTable)L.globalsTable, nUpvals: 0, p: proto);
    //        L.ciStack.Push(new Callinfo()
    //        {
    //            funcIndex = L.topIndex,
    //            topIndex = L.topIndex + proto.MaxStacksize
    //        });
    //        L[L.topIndex].Cl = closure;
    //        L.topIndex = L.topIndex + proto.MaxStacksize;
    //    }
    //    public static void LoadString(this TThread L, string luaCode)
    //    {
    //        AntlrInputStream inputStream; //输入流传递给antlr的输入流
    //        inputStream = new AntlrInputStream(luaCode); //知道可以。就行了。
    //        LuaLexer lexer; //*传递给lexer
    //        CommonTokenStream tokens; //lexer分析好token流
    //        LuaParser parser; //*由token流生成AST
    //        //LParser lp = new LParser(); //Listener遍历AST返回Proto
    //        lexer = new LuaLexer(inputStream);
    //        tokens = new CommonTokenStream(lexer);
    //        parser = new LuaParser(tokens);
    //        var tree = parser.chunk();
    //        var walker = new ParseTreeWalker();
    //        //lp.Visit(tree);
    //        Proto proto = lp.ChunkProto;
    //        //初始化k
    //        L.ns = new List<TValue>();
    //        foreach (var item in lp.ChunkProto.ns) {
    //            L.ns.Add((TValue)item);
    //        }
    //        L.strs = new List<TValue>();
    //        foreach (var item in lp.ChunkProto.strs) {
    //            L.strs.Add((TValue)item);
    //        }
    //        Closure closure = new LuaClosure(env: (TTable)L.globalsTable, nUpvals: 0, p: proto);
    //        L.ciStack.Push(new Callinfo()
    //        {
    //            funcIndex = L.topIndex,
    //            topIndex = L.topIndex + proto.MaxStacksize
    //        });
    //        L[L.topIndex].Cl = closure;
    //        L.topIndex = L.topIndex + proto.MaxStacksize;
    //    }
    //    public delegate void CSharpFunction(TThread L);
    //    #endregion
    ////}
}

/// <summary>
/// lua标准库，src就十几行，用于定义和加载所有具体的标准库，项目尾声时处理
/// </summary>
namespace ZoloLua.Stdlib
{
    internal class lualib
    {
    }
}