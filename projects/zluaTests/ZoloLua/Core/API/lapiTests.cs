using Microsoft.VisualStudio.TestTools.UnitTesting;
using ZoloLua.Core.VirtualMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZoloLua.Core.VirtualMachine.Tests
{
    [TestClass()]
    public class lapiTests
    {
        /// <summary>
        /// 一个简单的例子
        /// </summary>
        [TestMethod()]
        public void simpleTest()
        {
            //库是在dofile外面打开的
            //lua_State L=lua_open();
            //luaL_openlibs(L);
            //luaL_dofile(L,@"");
        }
    }
}