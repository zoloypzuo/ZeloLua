using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using System.IO;
using zluaTests;

namespace zlua.Compiler.Tests
{
    [TestClass()]
    public class LexerTests
    {
        [TestMethod()]
        public void TokenStreamTest()
        {
            TestTool.AssertPropertyEqual(
                "zlua.Compiler.Token[].json",
                Lexer.TokenStream(
                    new FileStream(
                        $"{TestTool.PathBase}lua/ch14/hello_world.lua", FileMode.Open),
                    "").ToArray());
        }
    }
}