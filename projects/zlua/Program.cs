using System.Linq;

using zlua.Compiler;

namespace zlua
{
    public class Program
    {
        private static void Test1(string chunk, Token[] expect)
        {
            var actual = new Lexer(chunk, "").ToArray();
            //Assert.AreEqual(expect.Length, actual.Length);
            //for (int i = 0; i < actual.Length; i++) {
            //    Assert.AreEqual(expect[i].Kind, actual[i].Kind);
            //    Assert.AreEqual(expect[i].Lexeme, actual[i].Lexeme);
            //}
        }

        public static void Main(string[] args)
        {
            //Test1("-- this is a comment", new Token[] { new Token(1, TokenKind.TOKEN_EOF, ""), });
            new Parser(new TokenStream(new Lexer("print(\"hello world\"", "")));
        }
    }
}