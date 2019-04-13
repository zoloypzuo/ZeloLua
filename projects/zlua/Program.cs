using System.IO;
using System.Linq;

using zlua.Compiler.Lexer;
using zlua.Core.Undumper;
using zlua.Core.VirtualMachine;

namespace zlua
{
    public class Program
    {
        private static void Test1(string chunk, Token[] expect)
        {
            var actual = new LuaLexer(chunk, "").ToArray();
            //Assert.AreEqual(expect.Length, actual.Length);
            //for (int i = 0; i < actual.Length; i++) {
            //    Assert.AreEqual(expect[i].Kind, actual[i].Kind);
            //    Assert.AreEqual(expect[i].Lexeme, actual[i].Lexeme);
            //}
        }

        public static void Main(string[] args)
        {
            //Test1("-- this is a comment", new Token[] { new Token(1, TokenKind.TOKEN_EOF, ""), });
            //new LuaParser(new TokenStream(new LuaLexer("print(\"hello world\"", "")));
            var p = luaU.Undump(new FileStream(
                @"C:\Users\91018\Documents\GitHub\zlua\data\lua\ch02\hello_world.out",
                FileMode.Open));
            new LuaState().dofile(@"C:\Users\91018\Documents\GitHub\zlua\data\lua\ch02\hello_world.out");
        }
    }
}