using Microsoft.VisualStudio.TestTools.UnitTesting;
using zlua.Core.VirtualMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.Core.VirtualMachine.Tests
{
    [TestClass()]
    public class lua_StateTests
    {
        [TestMethod()]
        public void lua_StateTest()
        {

        }

        /// <summary>
        /// 《自己动手实现Lua》p131+
        /// </summary>
        [TestMethod()]
        public void TableTest()
        {
            //TODO
            //添加ch07所有文件作为测试
            //下面是书中正文中的简单测试，与文件中测试不同
            //如果有必要，用反汇编器生成，但是没必要全部生成，太麻烦了，我们要测试通过就可以了
            string newtable = "local a,b,c,d; b = {x=1,y=2}";
            string gettable = "local a,t,k,v,e; v = t[k]; v = t[100]";
            string settable = "local a,t,k,v,e; t[k]=v; t[100] = \"foo\"";
            string setlist = "local t = {1,2,3,4}";
            // 结尾是函数调用或vararg
            string setlist1 = "t = {1,2,f()}";
        }

        /// <summary>
        /// 《自己动手实现Lua》p152+
        /// </summary>
        [TestMethod()]
        public void FunctionCallTest()
        {
            string closure =
                "local a,b,c\n" +
                "local function f() end\n" +
                "local g = fucntion() end\n";
            //TODO 确保代码应该正确执行，然后书中的代码不能。。
            //TODO 你可以试一试捕获这些异常并忽略
            string call = $"local a,b,c = f(1,2,3,4)";
            string @return = "local a,b; return 1,a,b";
            string vararg = "local a,b,c,d,e = 100, ...";
            string tailcall = "return f(a,b,c)";
            string self = "local a,obj; obj:f(a)";
        }
    }
}