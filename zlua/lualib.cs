using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.Stdlib
{
    class Stdlib
    {
        /* <lua_src> #define lua_assert(x)	((void)0)*/
        public static void assert(bool x) => Debug.Assert(x);
    }
}
