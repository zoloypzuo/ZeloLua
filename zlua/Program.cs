using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua
{
    class Program
    {
        public static void Main(string[] args)
        {
            new Lua().dofile("test.lua");
        }
    }
}
