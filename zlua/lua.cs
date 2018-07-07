using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using zlua.VM;
/// <summary>
/// 注释规范
/// 1. "<lua_src>...</lua_src>" is quote from lua source code
///     1. HOWTO 当你重命名某一名字时使用
///     2. DONT 不要过度引用，讲你做了什么，打算以后做什么，以后不要做什么，不要讲没做什么
/// 2. TString类型的变量以tstr命名
/// </summary>
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
        Proto = 6,
        Userdata = 7,
        Thread = 8,
        Closure = 9, //自己加的
        Int = 10,  //自己加的，TODO这肯定是错的。
    }
    /// <summary>
    /// lua接口
    /// </summary>
    public class Lua
    {

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
            new TThread(compiler.main_func).run();

        }
    }
}
