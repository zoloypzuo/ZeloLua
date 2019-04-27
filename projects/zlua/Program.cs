using System.IO;
using System.Linq;

using zlua.Core.Undumper;
using zlua.Core.VirtualMachine;

namespace zlua
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //C: \Users\91018\Documents\GitHub\clua\bin\lua5_1_4_CompilerDebug > lua5_1_4_Compiler - l  hello_world.lua
            //
            //main < hello_world.lua:0,0 > (4 instructions, 16 bytes at 0000024E1C5F25B0)
            //0 + params, 2 slots, 0 upvalues, 0 locals, 2 constants, 0 functions
            //        1[1]     GETGLOBAL       0 - 1; print
            //        2[1]     LOADK           1 - 2; "Hello World!"
            //        3[1]     CALL            0 2 1
            //        4[1]     RETURN          0 1
            var p = luaU.Undump(new FileStream(
                @"C:\Users\91018\Documents\GitHub\zlua\data\luac.out",
                FileMode.Open));
            new lua_State().luaL_dofile(@"C:\Users\91018\Documents\GitHub\zlua\data\lua\ch02\hello_world.out");
        }
    }
}