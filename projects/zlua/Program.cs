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
            //库是在dofile外面打开的
            //luaL_openlibs(L);  /* open libraries */
            //lua_State.lua_newstate().luaL_dofile(@"C:\Users\91018\Documents\GitHub\zlua\data\luac.out");
        }
    }
}