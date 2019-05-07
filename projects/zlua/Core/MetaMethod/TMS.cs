using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua.Core.MetaMethod
{
    internal enum TMS
    {
        TM_INDEX,
        TM_NEWINDEX,
        TM_GC,
        TM_MODE,
        TM_EQ, /* last tag method with `fast' access */
        TM_ADD,
        TM_SUB,
        TM_MUL,
        TM_DIV,
        TM_MOD,
        TM_POW,
        TM_UNM,
        TM_LEN,
        TM_LT,
        TM_LE,
        TM_CONCAT,
        TM_CALL,
        TM_N /* number of elements in the enum */
    }
}
