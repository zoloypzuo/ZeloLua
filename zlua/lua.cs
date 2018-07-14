using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using zlua.API;
using zlua.TypeModel;
using zlua.VM;

namespace zlua
{
    /// <summary>
    /// differ from clua: const int... => enum
    /// </summary>
    public enum LuaTypes
    {
        None = -1,
        Nil = 0,
        Boolean = 1,
        LightUserdata = 2,
        Number = 3,
        String = 4,
        Table = 5,
        Function = 6, // lua src's Function TODO
        Userdata = 7,
        Thread = 8,
        Closure = 9, //自己加的
        Int = 10,  //自己加的，TODO这肯定是错的。
    }
    /// <summary>
    /// lua接口
    /// </summary>
    public static class lua
    {
        public const string Version = "zlua 1.0, based on lua 5.1.4";
        public static void dofile(string path)
        {
            FileStream fs = new FileStream(@"..\..\" + path, FileMode.Open, FileAccess.Read);
            AntlrInputStream inputStream = new AntlrInputStream(fs);
            LuaLexer lexer = new LuaLexer(inputStream);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            LuaParser parser = new LuaParser(tokens);
            var tree = parser.chunk();
            var walker = new ParseTreeWalker();
            var compiler = new Compiler();
            walker.Walk(compiler, tree);
            new TThread(compiler.main_func).execute(1);
        }
        /// <summary>
        /// LUA_MULTRET, an option for lua_pcall and lua_call
        /// </summary>
        public const int MultiRet = -1;
        #region pseudo indicdes
        public const int RegisteyIndex = -10000;
        public const int EnvIndex = -10001;
        public const int GlobalsIndex = -10002;
        public static int UpvalIndex(int index) => GlobalsIndex - index;
        #endregion
        public static void GetGlobal(this TThread L,TString s)=>L.GetField(GlobalsIndex,s);
    }
}
