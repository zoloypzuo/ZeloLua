using Microsoft.VisualStudio.TestTools.UnitTesting;
using zlua.Core.VirtualMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.Core.VirtualMachine.Tests
{
    /// <summary>
    /// 测试虚拟机
    /// </summary>
    /// <remarks>
    /// <list type="bullet">
    ///     <item>
    ///     首先用luac编译出chunk，用undumper加载喂给虚拟机执行，这是一步打桩，用于独立地测试虚拟机
    ///     工作流：zlua_lab反汇编源文本，这里就有luac.out，复制到data/chunk下，
    ///     创建文件夹，重命名文件，这很重要，因为测试是手写的，一开始就制定目录规范，一开始麻烦一些
    ///     </item>
    /// </list>
    /// </remarks>
    [TestClass()]
    public class lua_StateTests
    {
        /// <summary>
        /// 执行chunk文件
        /// </summary>
        /// <param name="filename"></param>
        /// <example>
        ///     <code>t00("empty/empty");</code>
        /// </example>
        void t00(string filename)
        {
            const string basePath = "../../../../data/chunk/";
            lua_State.lua_newstate().luaL_dofile($"{basePath}{filename}.out");
        }

        /// <summary>
        /// dostring
        /// </summary>
        /// <param name="filename"></param>
        void t01(string s)
        {
            //lua_State.lua_newstate().luaL_dostring(s);
        }

        [TestMethod()]
        public void emptyChunkTest()
        {
            t00("string/empty/empty");
        }
        [TestMethod()]
        public void emptyTest()
        {
            t01("");
        }



        [TestMethod()]
        public void HelloworldChunkTest()
        {
            t00("helloworld/helloworld");
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

        [TestMethod()]
        public void FunctionCallChunkTest()
        {
            t00("functionCall/call");
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
            string ctx0 = "local function f() end\n";
            string call = $"{ctx0}local a,b,c = f(1,2,3,4)";
            string @return = "local a,b; return 1,a,b";
            string vararg = "local a,b,c,d,e = 100, ...";
            string tailcall = "return f(a,b,c)";
            string self = "local a,obj; obj:f(a)";
        }
    }
}