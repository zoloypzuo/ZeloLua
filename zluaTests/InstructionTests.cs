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
        public void CreateOprd2()
        {
            Assert.AreEqual<UInt32>(0x00000007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 0));
            Assert.AreEqual<UInt32>(0x00004007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 1));
            Assert.AreEqual<UInt32>(0x00008007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 2));
            Assert.AreEqual<UInt32>(0x00010001, (uint)new Bytecode(Opcodes.LoadK, 0, 4));
            Assert.AreEqual<UInt32>(0x0000C007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 3));
            Assert.AreEqual<UInt32>(0x00018001, (uint)new Bytecode(Opcodes.LoadK, 0, 6));
            Assert.AreEqual<UInt32>(0x00014007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 5));
            Assert.AreEqual<UInt32>(0x00020001, (uint)new Bytecode(Opcodes.LoadK, 0, 8));
            Assert.AreEqual<UInt32>(0x0001C007, (uint)new Bytecode(Opcodes.SetGlobal, 0, 7));
            Assert.AreEqual<UInt32>(0x00000003, (uint)new Bytecode(Opcodes.LoadNil, 0, 0));
            Assert.AreEqual<UInt32>(0x000100C1, (uint)new Bytecode(Opcodes.LoadK, 3, 4));
            Assert.AreEqual<UInt32>(0x00018101, (uint)new Bytecode(Opcodes.LoadK, 4, 6));
            Assert.AreEqual<UInt32>(0x00020141, (uint)new Bytecode(Opcodes.LoadK, 5, 8));
            Assert.AreEqual<UInt32>(0x000101C1, (uint)new Bytecode(Opcodes.LoadK, 7, 4));
            Assert.AreEqual<UInt32>(0x00024201, (uint)new Bytecode(Opcodes.LoadK, 8, 9));
            Assert.AreEqual<UInt32>(0x000241C1, (uint)new Bytecode(Opcodes.LoadK, 7, 9));
            Assert.AreEqual<UInt32>(0x00028201, (uint)new Bytecode(Opcodes.LoadK, 8, 10));
            Assert.AreEqual<UInt32>(0x00000324, (uint)new Bytecode(Opcodes.Closure, 12, 0));
            Assert.AreEqual<UInt32>(0x00034307, (uint)new Bytecode(Opcodes.SetGlobal, 12, 13));
            Assert.AreEqual<UInt32>(0x00034305, (uint)new Bytecode(Opcodes.GetGlobal, 12, 13));
            Assert.AreEqual<UInt32>(0x00010341, (uint)new Bytecode(Opcodes.LoadK, 13, 4));
            Assert.AreEqual<UInt32>(0x00024381, (uint)new Bytecode(Opcodes.LoadK, 14, 9));

                    }

        [TestMethod()]
        public void CreateOprd3()
        {

            Assert.AreEqual<UInt32>(0x00000002, (uint)new Bytecode(Opcodes.LoadBool, 0, 0, 0));
            Assert.AreEqual<UInt32>(0x00800002, (uint)new Bytecode(Opcodes.LoadBool, 0, 1, 0));
            Assert.AreEqual<UInt32>(0x00000042, (uint)new Bytecode(Opcodes.LoadBool, 1, 0, 0));
            Assert.AreEqual<UInt32>(0x00800082, (uint)new Bytecode(Opcodes.LoadBool, 2, 1, 0));
            Assert.AreEqual<UInt32>(0x0100018A, (uint)new Bytecode(Opcodes.NewTable, 6, 2, 0));
            Assert.AreEqual<UInt32>(0x010041A2, (uint)new Bytecode(Opcodes.SetList, 6, 2, 1));
            Assert.AreEqual<UInt32>(0x85C3024C, (uint)new Bytecode(Opcodes.Add, 9, 267, 268));
            Assert.AreEqual<UInt32>(0x82424057, (uint)new Bytecode(Opcodes.Eq, 1, 260, 265));
            Assert.AreEqual<UInt32>(0x00004282, (uint)new Bytecode(Opcodes.LoadBool, 10, 0, 1));
            Assert.AreEqual<UInt32>(0x00800282, (uint)new Bytecode(Opcodes.LoadBool, 10, 1, 0));
            Assert.AreEqual<UInt32>(0x000002C2, (uint)new Bytecode(Opcodes.LoadBool, 11, 0, 0));
            Assert.AreEqual<UInt32>(0x0180831C, (uint)new Bytecode(Opcodes.Call, 12, 3, 2));

            // TODO，这两条指令的C是省略为0的，另外jmp型是sbx，还没有考虑
            Assert.AreEqual<UInt32>(0x03000194, (uint)new Bytecode(Opcodes.Len, 6, 6, 0));
            Assert.AreEqual<UInt32>(0x0080001E, (uint)new Bytecode(Opcodes.Return, 0, 1, 0));


        }
        [TestMethod()]
        public void A()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).A);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 1, 0).A);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 1, 0, 0).A);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.LoadBool, 2, 1, 0).A);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.NewTable, 6, 2, 0).A);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.SetList, 6, 2, 1).A);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.Add, 9, 267, 268).A);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.Eq, 1, 260, 265).A);
            Assert.AreEqual<Int32>(10, new Bytecode(Opcodes.LoadBool, 10, 1, 0).A);
            Assert.AreEqual<Int32>(11, new Bytecode(Opcodes.LoadBool, 11, 0, 0).A);
            Assert.AreEqual<Int32>(12, new Bytecode(Opcodes.Call, 12, 3, 2).A);
        }
        [TestMethod()]
        public void B()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 0, 1, 0).B);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 1, 0, 0).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 2, 1, 0).B);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.NewTable, 6, 2, 0).B);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.SetList, 6, 2, 1).B);
            Assert.AreEqual<Int32>(267, new Bytecode(Opcodes.Add, 9, 267, 268).B);
            Assert.AreEqual<Int32>(260, new Bytecode(Opcodes.Eq, 1, 260, 265).B);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.LoadBool, 10, 1, 0).B);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 11, 0, 0).B);
            Assert.AreEqual<Int32>(3, new Bytecode(Opcodes.Call, 12, 3, 2).B);
        }
        [TestMethod()]
        public void C()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 0, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 0, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 1, 0, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 2, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.NewTable, 6, 2, 0).C);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.SetList, 6, 2, 1).C);
            Assert.AreEqual<Int32>(268, new Bytecode(Opcodes.Add, 9, 267, 268).C);
            Assert.AreEqual<Int32>(265, new Bytecode(Opcodes.Eq, 1, 260, 265).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 10, 1, 0).C);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadBool, 11, 0, 0).C);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.Call, 12, 3, 2).C);
        }
        [TestMethod()]
        public void Bx()
        {
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.SetGlobal, 0, 0).Bx);
            Assert.AreEqual<Int32>(1, new Bytecode(Opcodes.SetGlobal, 0, 1).Bx);
            Assert.AreEqual<Int32>(2, new Bytecode(Opcodes.SetGlobal, 0, 2).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 0, 4).Bx);
            Assert.AreEqual<Int32>(3, new Bytecode(Opcodes.SetGlobal, 0, 3).Bx);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.LoadK, 0, 6).Bx);
            Assert.AreEqual<Int32>(5, new Bytecode(Opcodes.SetGlobal, 0, 5).Bx);
            Assert.AreEqual<Int32>(8, new Bytecode(Opcodes.LoadK, 0, 8).Bx);
            Assert.AreEqual<Int32>(7, new Bytecode(Opcodes.SetGlobal, 0, 7).Bx);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.LoadNil, 0, 0).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 3, 4).Bx);
            Assert.AreEqual<Int32>(6, new Bytecode(Opcodes.LoadK, 4, 6).Bx);
            Assert.AreEqual<Int32>(8, new Bytecode(Opcodes.LoadK, 5, 8).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 7, 4).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 8, 9).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 7, 9).Bx);
            Assert.AreEqual<Int32>(10, new Bytecode(Opcodes.LoadK, 8, 10).Bx);
            Assert.AreEqual<Int32>(0, new Bytecode(Opcodes.Closure, 12, 0).Bx);
            Assert.AreEqual<Int32>(13, new Bytecode(Opcodes.SetGlobal, 12, 13).Bx);
            Assert.AreEqual<Int32>(13, new Bytecode(Opcodes.GetGlobal, 12, 13).Bx);
            Assert.AreEqual<Int32>(4, new Bytecode(Opcodes.LoadK, 13, 4).Bx);
            Assert.AreEqual<Int32>(9, new Bytecode(Opcodes.LoadK, 14, 9).Bx);
        }
    }
}