using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace ZoloLua.Core.VirtualMachine.Tests{
	[TestClass()]
	public class lvmTests
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
		public void functionDefChunkTest()
		{
			TestTool.t00("string/functionDef/simplest");  // SS p90
			TestTool.t00("string/functionDef/parameter");  // SS p93
		}
		
		[TestMethod()]
		public void functionDefTest()
		{
			TestTool.t01("\nfunction test()\nend");  // SS p90
			TestTool.t01("\nfunction f(a, b, c)\nend");  // SS p93
		}
		
		[TestMethod()]
		public void functionCallChunkTest()
		{
			TestTool.t00("string/functionCall/simplest");  // SS p95
		}
		
		[TestMethod()]
		public void functionCallTest()
		{
			TestTool.t01("print(\"a\")");  // SS p95
		}
		
		[TestMethod()]
		public void relationOpChunkTest()
		{
			TestTool.t00("string/relationOp/foo");  // SS p115
			TestTool.t00("string/relationOp/and");  // SS p118
		}
		
		[TestMethod()]
		public void relationOpTest()
		{
			TestTool.t01("\nlocal a,b,c\nc = a == b");  // SS p115
			TestTool.t01("\nlocal a,b,c\nc = a and b");  // SS p118
		}
		
		[TestMethod()]
		public void loopChunkTest()
		{
			TestTool.t00("string/loop/foo");  // SS p124
		}
		
		[TestMethod()]
		public void loopTest()
		{
			TestTool.t01("local a = 0; for i = 1, 100, 5 do a = a + i end;");  // SS p124
		}
		
		[TestMethod()]
		public void file_luago_book_ch02ChunkTest()
		{
			TestTool.t00("file/luago-book/ch02/hello_world");
		}
		
		[TestMethod()]
		public void file_luago_book_ch02Test()
		{
			TestTool.t02("file/luago-book/ch02/hello_world");
		}
	}
}
