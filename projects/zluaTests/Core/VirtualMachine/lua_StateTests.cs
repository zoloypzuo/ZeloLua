using Microsoft.VisualStudio.TestTools.UnitTesting;
using ZoloLua;

namespace zlua.Core.VirtualMachine.Tests
{
    [TestClass]
    public class lua_StateTests
    {
        [TestMethod]
        public void emptyChunkTest()
        {
            TestTool.t00("string/empty/empty");
        }

        [TestMethod]
        public void helloWorldChunkTest()
        {
            TestTool.t00("string/helloWorld/helloWorld");
        }

        [TestMethod]
        public void assignChunkTest()
        {
            TestTool.t00("string/assign/localAssign"); // SS p68
            TestTool.t00("string/assign/global"); // SS p70
        }

        [TestMethod]
        public void tableChunkTest()
        {
            TestTool.t00("string/table/newtable"); // SS p72
            TestTool.t00("string/table/setlist"); // SS p74
            TestTool.t00("string/table/settable"); // SS p77
            TestTool.t00("string/table/settable1"); // SS p78
            TestTool.t00("string/table/gettable"); // SS p79
        }

        [TestMethod]
        public void functionDefChunkTest()
        {
            TestTool.t00("string/functionDef/simplest"); // SS p90
            TestTool.t00("string/functionDef/parameter"); // SS p93
        }

        [TestMethod]
        public void functionCallChunkTest()
        {
            TestTool.t00("string/functionCall/simplest"); // SS p95
        }

        [TestMethod]
        public void relationOpChunkTest()
        {
            TestTool.t00("string/relationOp/foo"); // SS p115
            TestTool.t00("string/relationOp/and"); // SS p118
        }

        [TestMethod]
        public void loopChunkTest()
        {
            TestTool.t00("string/loop/foo"); // SS p124
        }

        [TestMethod]
        public void loopTest()
        {
            TestTool.t01("local a = 0; for i = 1, 100, 5 do a = a + i end;"); // SS p124
        }
    }
}