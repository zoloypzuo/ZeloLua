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
/// 辅助库
/// </summary>
namespace zlua.AuxLib
{
    public static class LAuxlib
    {
        /// <summary>
        /// luaL_loadfile lua_load（更简单），核心逻辑是编译到proto，然后加upval作为closure压栈
        /// 实现决策】没有upval
        /// </summary>
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
        /// <summary>
        /// 和loadfile一样
        /// </summary>
        /// <param name="L"></param>
        /// <param name="luaCode"></param>
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
        /// <summary>
        /// lua_CFunction
        /// </summary>
        public delegate void CSharpFunction(TThread L);

    }
}
