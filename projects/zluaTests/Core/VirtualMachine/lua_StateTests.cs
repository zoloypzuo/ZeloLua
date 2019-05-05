using Microsoft.VisualStudio.TestTools.UnitTesting;
using zluaTests;
namespace zlua.Core.VirtualMachine.Tests{
	[TestClass()]
	public class lua_StateTests
	{
		[TestMethod()]
		public void emptyChunkTest()
		{
			TestTool.t00("string/empty/empty");
		}
		
		[TestMethod()]
		public void emptyTest()
		{
			TestTool.t01("");
		}
		
		[TestMethod()]
		public void helloWorldChunkTest()
		{
			TestTool.t00("string/helloWorld/helloWorld");
		}
		
		[TestMethod()]
		public void helloWorldTest()
		{
			TestTool.t01("print(\"Hello World!\")");
		}
		
		[TestMethod()]
		public void assignChunkTest()
		{
			TestTool.t00("string/assign/localAssign");  // SS p68
			TestTool.t00("string/assign/global");  // SS p70
		}
		
		[TestMethod()]
		public void assignTest()
		{
			TestTool.t01("\nlocal a = 10\nlocal b = a\n");  // SS p68
			TestTool.t01("\na = 10\nlocal b = a");  // SS p70
		}
		
		[TestMethod()]
		public void tableChunkTest()
		{
			TestTool.t00("string/table/newtable");  // SS p72
			TestTool.t00("string/table/setlist");  // SS p74
			TestTool.t00("string/table/settable");  // SS p77
			TestTool.t00("string/table/settable1");  // SS p78
			TestTool.t00("string/table/gettable");  // SS p79
		}
		
		[TestMethod()]
		public void tableTest()
		{
			TestTool.t01("local p = {}");  // SS p72
			TestTool.t01("local p = {1,2}");  // SS p74
			TestTool.t01("local p = {[\"a\"]=1}");  // SS p77
			TestTool.t01("\nlocal a = \"a\"\nlocal p = {[a]=1}\n");  // SS p78
			TestTool.t01("\nlocal p = {[\"a\"]=1}\nlocal b = p[\"a\"]");  // SS p79
		}
		
		[TestMethod()]
		public void functionCallChunkTest()
		{
			TestTool.t00("string/functionCall/closure");
			TestTool.t00("string/functionCall/call");
			TestTool.t00("string/functionCall/return");
			TestTool.t00("string/functionCall/vararg");
		}
		
		[TestMethod()]
		public void functionCallTest()
		{
			TestTool.t01("local a,b,c\nlocal function f() end\nlocal g = function() end\n");
			TestTool.t01("local function f() end\nlocal a,b,c = f(1,2,3,4)");
			TestTool.t01("local a,b; return 1,a,b");
			TestTool.t01("local a,b,c,d,e = 100, ...");
		}
		
	}
}
