using ZeptLua.VM;

namespace ZeptLua
{
    public class Program
    {

        public static void Main(string[] args)
        {
            var path = @"" + "test.lua";
            Lua.DoFile(new TThread(), path);
        }
    }
}
