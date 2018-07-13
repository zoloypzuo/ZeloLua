using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.Configuration
{
    using TNumber = Double;
    static class luaconf
    {
        public const int MaxCalls = 200;
        public const int MaxRegs = 200;
        public const int MaxUpVals = 60;
        public static bool IsNaN(TNumber a) => !(a != a);
    }
}
