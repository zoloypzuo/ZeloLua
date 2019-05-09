using Microsoft.VisualStudio.TestTools.UnitTesting;

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
            lua_State L = lua_State.lua_open();
            L.luaL_openlibs();
            L.luaL_dofile(@"");
        }
    }
}