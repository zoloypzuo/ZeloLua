using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.ISA;
namespace zlua
{
    public class Program
    {

        public static void Main(string[] args)
        {
            var path = @"..\..\" + "test.lua";
            Lua.DoFile(new TThread(), path);
        }
    }
}
