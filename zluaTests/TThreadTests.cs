using Microsoft.VisualStudio.TestTools.UnitTesting;
using zlua.VM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.ISA;
using zlua.TypeModel;
using zlua.API;
namespace zlua.VM.Tests
{
    [TestClass()]
    public class TThreadTests
    {

        [TestMethod()]
        public void TThreadTest()
        {

        }

        [TestMethod()]
        public void ExecuteTest()
        {
            var L = new TThread();
            var codes = Bytecode.Gen(new uint[]
            {
                0x00000007, 0x00000002, 0x00004007, 0x00800002, 0x00008007, 0x00010001,
                0x0000C007, 0x00018001, 0x00014007, 0x00020001, 0x0001C007, 0x00000003,
                0x00000042, 0x00800082, 0x000100C1, 0x00018101, 0x00020141, 0x0100018A,
                0x000101C1, 0x00024201, 0x010041A2, 0x000241C1, 0x00028201, 0x85C3024C,
                0x82424057, 0x00800282, 0x000002C2, 0x00000324, 0x00034307, 0x00034305,
                0x00010341, 0x00024381, 0x0180831C
            });
            var p = new Proto() {
                codes = codes,
                maxStacksize = 15,
                nParams = 0,
                isVararg = false,
                k = new List<TValue> {
                    (TValue)(TString)"a",
                    (TValue)(TString)"a1",
                    (TValue)(TString)"a2",
                    (TValue)(TString)"b",
                    (TValue)1,
                    (TValue)(TString)"b1",
                    (TValue)1.2,
                    (TValue)(TString)"c",
                    (TValue)(TString)"lalala",
                    (TValue)2,
                    (TValue)3,
                    (TValue)(TString)"1",
                    (TValue)(TString)"2",
                    (TValue)(TString)"add"
                },
                inner_funcs = new List<Proto> { new Proto()}
            };
            Closure closure = new LuaClosure((TTable)L.globalsTable, 0, p);
            L.Stack[L.top].Cl = closure;
            L.top++;
            lapi.Call(L, 0, 0);
        }

        [TestMethod()]
        public void ToNumberTest()
        {

        }

        [TestMethod()]
        public void ToStringTest()
        {

        }

        [TestMethod()]
        public void ConcatTest()
        {

        }

        [TestMethod()]
        public void EqualObjTest()
        {

        }

        [TestMethod()]
        public void EqualValTest()
        {

        }

        [TestMethod()]
        public void GetTableTest()
        {

        }

        [TestMethod()]
        public void SetTableTest()
        {

        }

        [TestMethod()]
        public void LessThanTest()
        {

        }
    }
}