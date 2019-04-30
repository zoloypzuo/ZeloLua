using Microsoft.VisualStudio.TestTools.UnitTesting;
using zluaTests;
namespace zlua.Core.VirtualMachine.Tests{
	[TestClass()]
	public class lua_StateTests
	{
		[TestMethod()]
		public void emptyChunkTest()		{
		TestTool.t00("string/empty/empty");		}
		
		[TestMethod()]
		public void emptyTest()		{
		TestTool.t01("");		}
		
		[TestMethod()]
		public void helloworldChunkTest()		{
		TestTool.t00("string/helloworld/helloworld");		}
		
		[TestMethod()]
		public void helloworldTest()		{
		TestTool.t01("print(\"Hello World!\")");		}
		
		[TestMethod()]
		public void functionCallChunkTest()		{
		TestTool.t00("string/functionCall/closure");		TestTool.t00("string/functionCall/call");		TestTool.t00("string/functionCall/return");		TestTool.t00("string/functionCall/vararg");		TestTool.t00("string/functionCall/tailcall");		}
		
		[TestMethod()]
		public void functionCallTest()		{
		TestTool.t01("local a,b,c\nlocal function f() end\nlocal g = function() end\n");		TestTool.t01("local function f() end\nlocal a,b,c = f(1,2,3,4)");		TestTool.t01("local a,b; return 1,a,b");		TestTool.t01("local a,b,c,d,e = 100, ...");		TestTool.t01("local function f() end\nreturn f(a,b,c)");		}
		
		[TestMethod()]
		public void ChunkTest()		{
		TestTool.t00("string/self");		}
		
		[TestMethod()]
		public void Test()		{
		TestTool.t01("function obj:f(a) end]\nlocal a,obj; obj:f(a)");		}
		
	}
}
