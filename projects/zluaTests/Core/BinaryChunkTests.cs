using System.IO;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using zluaTests;

namespace zlua.Core.BinaryChunk.Tests
{
    [TestClass()]
    public class BinaryChunkTests
    {
        [TestMethod()]
        public void UndumpTest()
        {
            TestTool.AssertPropertyEqual(
                "zlua.Core.BinaryChunk.Prototype.json",
                BinaryChunk.Undump(
                    new FileStream(
                        $"{TestTool.DataPathBase}lua/ch02/hello_world.out"
                        , FileMode.Open)));
            //TestTool.ExportObject(p);  // 使用这行生成文件
        }
    }
}