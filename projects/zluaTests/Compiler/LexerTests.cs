using Microsoft.VisualStudio.TestTools.UnitTesting;

using System.Linq;

using zlua.Compiler.Lexer;

using zluaTests;

namespace zlua.Compiler.Tests
{
    [TestClass()]
    public class LexerTests
    {
        // lua代码字符串与序列化结果比较
        private void Test0(string chunk, int index)
        {
            string path = $"/Compiler/LexerTests/{index}.json";
            TestTool.AssertPropertyEqual(path, new LuaLexer(chunk, "").ToArray());
        }

        // lua代码字符串与手写结果比较
        private void Test1(string chunk, Token[] expect)
        {
            var actual = new LuaLexer(chunk, "").ToArray();
            Assert.AreEqual(expect.Length, actual.Length);
            for (int i = 0; i < actual.Length; i++) {
                Assert.AreEqual(expect[i].Kind, actual[i].Kind);
                Assert.AreEqual(expect[i].Lexeme, actual[i].Lexeme);
            }
        }

        [TestMethod()]
        public void LexerTest()
        {
            //Test0("print(\"hello world!\")", 0);
            // 纯空白符
            //Test1(" \f\v\n\r\r\n\t", new Token[] { new Token(4, TokenKind.TOKEN_EOF, ""), });
            // 纯注释
            Test1("-- this is a comment", new Token[] { new Token(1, TokenKind.TOKEN_EOF, ""), });
            Test1("--[[ this is a long comment\nsecond line]]", new Token[] { new Token(2, TokenKind.TOKEN_EOF, "") });
            // 字面量的工作量比较大。。。
            //TODO 数字字面量
            //TODO 字符串字面量
        }
    }
}