// lua API
//
// 如果不想写在一个类里，有以下几种方案：
// * partial class：本身专用于拆分大类到不同文件，必须在同一namespace，我不能放在zlua.API中
//   你要思考namesapce的意义，我分文件夹，namespace的意义是什么，怎么去分
//   看msdn和koopoo
// * 扩展方法：只能访问public内容
// 显然，partial会好一些，这是api，不是辅助api，不是单纯包装，因此必须要在类内，namespace肯定要一样，至于怎么构建namespace之后在考虑

using System;

using zlua.Core.Lua;
using zlua.Core.ObjectModel;

// CSharp API 这里因为过失没法回退，稍微要话十几分钟把所有index改为index2TValue(index)
// TODO，反正lapi内部不用。
// TODO namespace和。。还是有点。。爱
namespace zlua.Core.VirtualMachine
{
    public partial class lua_State : LuaReference
    {
        public int GetTop()
        {
            return this.stack.top;
        }

        public int AbsIndex(int idx)
        {
            return stack.absIndex(idx);
        }

        // lua栈不会自动增长，api调用者必须主动调用/CheckStack/以确保压入更多值不会导致栈溢出
        // 返回是否有n个空闲格子
        // 再次强调，对于c#，栈的容量指count，而不是capacity
        public bool CheckStack(int n)
        {
            stack.check(n);
            return true;  // never fails
        }

        public void Pop(int n)
        {
            for (int i = 0; i < n; i++) {
                stack.pop();
            }
        }

        public void Copy(int fromIdx, int toIdx)
        {
            var val = stack.get(fromIdx);
            stack.set(toIdx, val);
        }

        // 把索引处的值压栈
        public void PushValue(int idx)
        {
            var val = stack.get(idx);
            stack.push(val);
        }

        // /PushVale/的逆操作
        public void Replace(int idx)
        {
            var val = stack.pop();
            stack.set(idx, val);
        }

        // 弹栈，插入指定位置
        public void Insert(int idx)
        {
            Rotate(idx, 1);
        }

        // 删除指定位置的值，这个位置之后的格子依次向前移动一格
        public void Remove(int idx)
        {
            Rotate(idx, -1);
            Pop(1);
        }

        // [idx, top]之间的值朝向栈顶方向旋转n个位置，n为负数则朝向栈底方向
        //
        // 这个就是向栈顶循环移动n个格子，n可以是负数
        // 如果不能理解，参见p62
        public void Rotate(int idx, int n)
        {
            var t = stack.top - 1;
            var p = stack.absIndex(idx) - 1;
            int m;
            if (n >= 0) {
                m = t - n;
            } else {
                m = p - n - 1;
            }
            stack.reverse(p, m);
            stack.reverse(m + 1, t);
            stack.reverse(p, t);
        }

        // 将栈顶设为/idx/，/idx/小于当前栈顶索引时，相当于弹出或者说截断多余的部分，
        // 相反地，如果/idx/大于当前栈顶索引时，相当于压入nil来填补
        //
        // /Pop/相当于SetTop(-n-1)
        public void SetTop(int idx)
        {
            var newTop = stack.absIndex(idx);
            if (newTop < 0) {
                throw new Exception("stack underflow");
            }

            int n = stack.top - newTop;
            if (n > 0) {
                for (int i = 0; i < n; i++) {
                    stack.pop();
                }
            } else if (n < 0) {
                for (int i = 0; i > n; i--) {
                    stack.push(new TValue());
                }
            }
        }

        #region Push*方法 将某一类型的luaValue压栈

        public void PushNil()
        {
            stack.push(new TValue());
        }

        public void PushBoolean(bool b)
        {
            stack.push(new TValue(b));
        }

        public void PushInteger(lua_Integer i)
        {
            stack.push(new TValue(i));
        }

        public void PushNumber(double n)
        {
            stack.push(new TValue(n));
        }

        public void PushString(string s)
        {
            stack.push(new TValue(s));
        }

        #endregion Push*方法 将某一类型的luaValue压栈

        #region Access*方法 从栈获取值

        public string TypeName(LuaType type)
        {
            return type.ToString();
        }

        // 无效索引返回LUA_TNONE
        public LuaType Type(int idx)
        {
            if (stack.isValid(idx)) {
                var val = stack.get(idx);
                return val.Type;
            } else {
                return LuaType.LUA_TNONE;
            }
        }

        public bool IsNone(int idx)
        {
            return Type(idx) == LuaType.LUA_TNONE;
        }

        public bool IsNil(int idx)
        {
            return Type(idx) == LuaType.LUA_TNIL;
        }

        public bool IsNoneOrNil(int idx)
        {
            return IsNone(idx) || IsNil(idx);
        }

        public bool IsBoolean(int idx)
        {
            return Type(idx) == LuaType.LUA_TBOOLEAN;
        }

        // 注意lua类型转换规格
        public bool IsString(int idx)
        {
            return Type(idx) == LuaType.LUA_TNUMBER || Type(idx) == LuaType.LUA_TSTRING;
        }

        public bool IsNumber(int idx)
        {
            //return ToNumberX(idx);
            return false;
        }

        public bool IsInteger(int idx)
        {
            return Type(idx) == LuaType.LUA_TNUMBER;
        }

        public bool ToBoolean(int idx)
        {
            return convertToBoolean(stack.get(idx));
        }

        private bool convertToBoolean(TValue luaValue)
        {
            switch (luaValue.Type) {
                case LuaType.LUA_TNIL:
                    return false;

                case LuaType.LUA_TBOOLEAN:
                    return luaValue.B;

                default:
                    return true;
            }
        }

        #endregion Access*方法 从栈获取值
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
namespace zlua.Stdlib
{
    internal class lualib
    {
    }
}