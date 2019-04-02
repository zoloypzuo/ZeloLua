using System.IO;
using System.Linq;

using zlua.Compiler;

namespace zlua
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //var path = @"" + "test.lua";
            //lua.dofile(new tthread(), path);
            System.Console.WriteLine();
            var a =  Lexer.TokenStream(new FileStream("../../../../data/lua/ch14/hello_world.lua", FileMode.Open), "").ToArray();
        }
    }
}