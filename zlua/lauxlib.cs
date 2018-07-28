using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using System.IO;
using p = zlua.Parser; // 防止名字冲突，大概不需要把
using zlua.AntlrGen;
/// <summary>
/// 辅助库
/// </summary>
namespace zlua.AuxLib
{
    static class lauxlib
    {
        /// <summary>
        /// luaL_loadfile
        /// 实现决策】我们简化src实现方式，src中经过了三个复杂的函数到fparser内才判断文件是字节码还是text，然后。。。，所以实现中这里就做完了
        /// </summary>
        public static void LoadFile(this TThread L, string path)
        {
            AntlrInputStream inputStream; //输入流传递给antlr的输入流
            LuaLexer lexer; //*传递给lexer
            CommonTokenStream tokens; //lexer分析好token流
            LuaParser parser; //*由token流生成AST
            p.lparser lp = new p.lparser(); //Listener遍历AST返回Proto
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read)) {
                inputStream = new AntlrInputStream(fs);
                lexer = new LuaLexer(inputStream);
                tokens = new CommonTokenStream(lexer);
                parser = new LuaParser(tokens);
                var tree = parser.chunk();
                var walker = new ParseTreeWalker();
                walker.Walk(lp, tree);
                Console.WriteLine(tree.ToStringTree()); //虽然C#的根本没法看，留着呗
            }
            Proto proto = lp.ChunkProto;
            Closure closure = new LuaClosure((TTable)L.globalsTable, 0, proto);
            L[L.topIndex].Cl = closure;
            L.topIndex++;
        }
        /// <summary>
        /// luaL_checkany
        /// </summary>
        public static void CheckAny(this TThread L, int n_arg)
        {
        }
        /// <summary>
        /// lua_CFunction
        /// </summary>
        public delegate void CSharpFunction(TThread L);
        /// <summary>
        /// lua_Reader
        /// </summary>
        public delegate string Reader(TThread L, object ud, int size);
        /// <summary>
        /// 
        /// </summary>
        public delegate void Writer(TThread L, object p, int size, object ud);
        /// <summary>
        /// lua_call
        /// </summary>
        public static void Call(TThread L, int n_args, int n_retvals)
        {

        }
    }
}
