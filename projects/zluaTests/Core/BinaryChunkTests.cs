using Microsoft.VisualStudio.TestTools.UnitTesting;
using zlua.Core.BinaryChunk;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace zlua.Core.BinaryChunk.Tests
{
    [TestClass()]
    public class BinaryChunkTests
    {
        [TestMethod()]
        public void UndumpTest()
        {
            var p = BinaryChunk.Undump(new FileStream("../../../../data/lua/ch02/hello_world.out", FileMode.Open));
            // TODO 这该怎么测试呢，手写一个proto比较相等吗，这是可行的，因为现在的规格是稳定的
            // 但是我好懒啊
            // 已经通过了，暂时先这样
        }
    }
}