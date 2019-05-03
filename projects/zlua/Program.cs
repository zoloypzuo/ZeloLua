using System.IO;
using System.Linq;

using ZoloLua.Core.Undumper;
using ZoloLua.Core.VirtualMachine;

namespace ZoloLua
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