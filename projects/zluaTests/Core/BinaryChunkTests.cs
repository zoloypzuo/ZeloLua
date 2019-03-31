using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.IO;
using Newtonsoft.Json;
using zluaTests;

namespace zlua.Core.BinaryChunk.Tests
{
    [TestClass()]
    public class BinaryChunkTests
    {
        const string pathBase = "../../../../data/";
        [TestMethod()]
        public void UndumpTest()
        {
            TestTool.AssertPropertyEqual(
                "zlua.Core.BinaryChunk.Prototype.txt",
                BinaryChunk.Undump(
                    new FileStream(
                        $"{pathBase}lua/ch02/hello_world.out"
                        , FileMode.Open)));
            //TestTool.ExportObject(p);  // 使用这行生成文件
        }
    }
}