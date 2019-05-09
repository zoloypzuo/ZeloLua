using ZoloLua.Core.VirtualMachine;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace ZoloLua.Core.VirtualMachine.Tests
{
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
        public void lua_callTest()
        {

        }

        [TestMethod()]
        public void lua_checkstackTest()
        {

        }

        [TestMethod()]
        public void lua_concatTest()
        {

        }

        [TestMethod()]
        public void lua_cpcallTest()
        {

        }

        [TestMethod()]
        public void lua_createtableTest()
        {

        }

        [TestMethod()]
        public void lua_dumpTest()
        {

        }

        [TestMethod()]
        public void lua_equalTest()
        {

        }

        [TestMethod()]
        public void lua_errorTest()
        {

        }

        [TestMethod()]
        public void lua_getfenvTest()
        {

        }

        [TestMethod()]
        public void lua_getfieldTest()
        {

        }

        [TestMethod()]
        public void lua_getglobalTest()
        {

        }

        [TestMethod()]
        public void lua_getmetatableTest()
        {

        }

        [TestMethod()]
        public void lua_gettableTest()
        {

        }

        [TestMethod()]
        public void lua_gettopTest()
        {

        }

        [TestMethod()]
        public void lua_insertTest()
        {

        }

        [TestMethod()]
        public void lua_IntegerTest()
        {

        }

        [TestMethod()]
        public void lua_isbooleanTest()
        {

        }

        [TestMethod()]
        public void lua_iscfunctionTest()
        {

        }

        [TestMethod()]
        public void lua_isfunctionTest()
        {

        }

        [TestMethod()]
        public void lua_islightuserdataTest()
        {

        }

        [TestMethod()]
        public void lua_isnilTest()
        {

        }

        [TestMethod()]
        public void lua_isnumberTest()
        {

        }

        [TestMethod()]
        public void lua_isstringTest()
        {

        }

        [TestMethod()]
        public void lua_istableTest()
        {

        }

        [TestMethod()]
        public void lua_isthreadTest()
        {

        }

        [TestMethod()]
        public void lua_isuserdataTest()
        {

        }

        [TestMethod()]
        public void lua_lessthanTest()
        {

        }

        [TestMethod()]
        public void lua_loadTest()
        {

        }

        [TestMethod()]
        public void lua_newstateTest()
        {

        }

        [TestMethod()]
        public void lua_newtableTest()
        {

        }

        [TestMethod()]
        public void lua_newthreadTest()
        {

        }

        [TestMethod()]
        public void lua_newuserdataTest()
        {

        }

        [TestMethod()]
        public void lua_nextTest()
        {

        }

        [TestMethod()]
        public void lua_NumberTest()
        {

        }

        [TestMethod()]
        public void lua_objlenTest()
        {

        }

        [TestMethod()]
        public void lua_pcallTest()
        {

        }

        [TestMethod()]
        public void lua_popTest()
        {

        }

        [TestMethod()]
        public void lua_pushbooleanTest()
        {

        }

        [TestMethod()]
        public void lua_pushcclosureTest()
        {

        }

        [TestMethod()]
        public void lua_pushcfunctionTest()
        {

        }

        [TestMethod()]
        public void lua_pushfstringTest()
        {

        }

        [TestMethod()]
        public void lua_pushintegerTest()
        {

        }

        [TestMethod()]
        public void lua_pushlightuserdataTest()
        {

        }

        [TestMethod()]
        public void lua_pushlstringTest()
        {

        }

        [TestMethod()]
        public void lua_pushnilTest()
        {

        }

        [TestMethod()]
        public void lua_pushnumberTest()
        {

        }

        [TestMethod()]
        public void lua_pushstringTest()
        {

        }

        [TestMethod()]
        public void lua_pushthreadTest()
        {

        }

        [TestMethod()]
        public void lua_pushvalueTest()
        {

        }

        [TestMethod()]
        public void lua_pushvfstringTest()
        {

        }

        [TestMethod()]
        public void lua_rawequalTest()
        {

        }

        [TestMethod()]
        public void lua_rawgetTest()
        {

        }

        [TestMethod()]
        public void lua_rawgetiTest()
        {

        }

        [TestMethod()]
        public void lua_rawsetTest()
        {

        }

        [TestMethod()]
        public void lua_rawsetiTest()
        {

        }

        [TestMethod()]
        public void lua_ReaderTest()
        {

        }

        [TestMethod()]
        public void lua_registerTest()
        {

        }

        [TestMethod()]
        public void lua_removeTest()
        {

        }

        [TestMethod()]
        public void lua_replaceTest()
        {

        }

        [TestMethod()]
        public void lua_resumeTest()
        {

        }

        [TestMethod()]
        public void lua_setallocfTest()
        {

        }

        [TestMethod()]
        public void lua_setfenvTest()
        {

        }

        [TestMethod()]
        public void lua_setfieldTest()
        {

        }

        [TestMethod()]
        public void lua_setglobalTest()
        {

        }

        [TestMethod()]
        public void lua_setmetatableTest()
        {

        }

        [TestMethod()]
        public void lua_settableTest()
        {

        }

        [TestMethod()]
        public void lua_settopTest()
        {

        }

        [TestMethod()]
        public void lua_statusTest()
        {

        }

        [TestMethod()]
        public void lua_tobooleanTest()
        {

        }

        [TestMethod()]
        public void lua_tocfunctionTest()
        {

        }

        [TestMethod()]
        public void lua_tointegerTest()
        {

        }

        [TestMethod()]
        public void lua_tolstringTest()
        {

        }

        [TestMethod()]
        public void lua_tonumberTest()
        {

        }

        [TestMethod()]
        public void lua_topointerTest()
        {

        }

        [TestMethod()]
        public void lua_tostringTest()
        {

        }

        [TestMethod()]
        public void lua_tothreadTest()
        {

        }

        [TestMethod()]
        public void lua_touserdataTest()
        {

        }

        [TestMethod()]
        public void lua_typeTest()
        {

        }

        [TestMethod()]
        public void lua_typenameTest()
        {

        }

        [TestMethod()]
        public void lua_WriterTest()
        {

        }

        [TestMethod()]
        public void lua_xmoveTest()
        {

        }

        [TestMethod()]
        public void lua_yieldTest()
        {

        }
    }
}
