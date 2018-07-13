using Microsoft.VisualStudio.TestTools.UnitTesting;
using zlua.ISA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.ISA.Tests
{
    [TestClass()]
    public class InstructionTests
    {

        [TestMethod()]
        public void InstructionTest1()
        {
            Assert.AreEqual<int>(0b0, new Instruction(Opcodes.Move, 0, 0,0));
            Assert.AreEqual<int>(0b0000_0000_1000_0000_0100_0000_0100_0001, 
                new Instruction((Opcodes)1, 1, 1,1));
        }

        [TestMethod()]
        public void InstructionTest2()
        {
            Assert.AreEqual<int>(0b0100_0000_0100_0001,
                new Instruction((Opcodes)1, 1, 1));
        }
    }
}