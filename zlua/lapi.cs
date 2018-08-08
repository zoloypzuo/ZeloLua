using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.CallSystem;
using System.Diagnostics;
using zlua;
using zlua.Configuration;
using zlua.VM;
using zlua.TypeModel;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using System.IO;
using zlua.Parser;
using zlua.Gen;
using System;
using System.Collections.Generic;
/// <summary>
/// CSharp API 这里因为过失没法回退，稍微要话十几分钟把所有index改为index2TValue(index)，TODO，反正lapi内部不用。
/// </summary>
namespace zlua.API
{
    public static class LApi
    {
        #region load and call functions (run Lua code)
        /// <summary>
        /// lua_call 函数和args已经压栈，调用它；是一次C发起的调用
        /// 名字重复了，不好。而且签名是一样的。
        /// </summary>
        public static void Call(TThread L, int nArgs, int nRetvals)
        {
            int funcIndex = L.topIndex - (nArgs + 1);
            LDo.Call(L, funcIndex, nRetvals);
        }
        public static void LoadFile(this TThread L, string path)
        {
            AntlrInputStream inputStream; //输入流传递给antlr的输入流
            LuaLexer lexer; //*传递给lexer
            CommonTokenStream tokens; //lexer分析好token流
            LuaParser parser; //*由token流生成AST
            LParser lp = new LParser(); //Listener遍历AST返回Proto
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read)) {
                inputStream = new AntlrInputStream(fs);
                lexer = new LuaLexer(inputStream);
                tokens = new CommonTokenStream(lexer);
                parser = new LuaParser(tokens);
                var tree = parser.chunk();
                var walker = new ParseTreeWalker();
                lp.Visit(tree);
            }
            Proto proto = lp.ChunkProto;
            //初始化k
            L.ns = new List<TValue>();
            foreach (var item in lp.ChunkProto.ns) {
                L.ns.Add((TValue)item);
            }
            L.strs = new List<TValue>();
            foreach (var item in lp.ChunkProto.strs) {
                L.strs.Add((TValue)item);
            }
            Closure closure = new LuaClosure(env: (TTable)L.globalsTable, nUpvals: 0, p: proto);
            L[L.topIndex++].Cl = closure;
        }
        public static void LoadString(this TThread L, string luaCode)
        {
            AntlrInputStream inputStream; //输入流传递给antlr的输入流
            inputStream = new AntlrInputStream(luaCode); //知道可以。就行了。
            LuaLexer lexer; //*传递给lexer
            CommonTokenStream tokens; //lexer分析好token流
            LuaParser parser; //*由token流生成AST
            LParser lp = new LParser(); //Listener遍历AST返回Proto
            lexer = new LuaLexer(inputStream);
            tokens = new CommonTokenStream(lexer);
            parser = new LuaParser(tokens);
            var tree = parser.chunk();
            var walker = new ParseTreeWalker();
            lp.Visit(tree);
            Proto proto = lp.ChunkProto;
            //初始化k
            L.ns = new List<TValue>();
            foreach (var item in lp.ChunkProto.ns) {
                L.ns.Add((TValue)item);
            }
            L.strs = new List<TValue>();
            foreach (var item in lp.ChunkProto.strs) {
                L.strs.Add((TValue)item);
            }
            Closure closure = new LuaClosure(env: (TTable)L.globalsTable, nUpvals: 0, p: proto);
            L[L.topIndex++].Cl = closure;
        }
        public delegate void CSharpFunction(TThread L);
        #endregion
    }
}
/// <summary>
/// lua标准库，src就十几行，用于定义和加载所有具体的标准库，项目尾声时处理
/// </summary>
namespace zlua.Stdlib
{
    class lualib
    {
    }
}