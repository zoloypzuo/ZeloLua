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
            using (FileStream fs = new FileStream(path,
                FileMode.Open, FileAccess.Read)) {
                AntlrInputStream inputStream = new AntlrInputStream(fs);
                LuaLexer lexer = new LuaLexer(inputStream);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                LuaParser parser = new LuaParser(tokens);
                var tree = parser.chunk();
                var walker = new ParseTreeWalker();
                var compiler = new Compiler();
                walker.Walk(compiler, tree);
            }
            //TODO导出一个proto

            Proto proto = new Proto();
            Closure closure = new LuaClosure((TTable)L.globalsTable, 0, proto);
            L[L.top].Cl = closure;
            L.top++;
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
