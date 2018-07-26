using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
/// <summary>
/// Closure和Proto的辅助函数
/// </summary>
namespace zlua.FuncAux
{
    static class lfunc
    {
        /// <summary>
        /// luaF_findupval
        /// </summary>
                public static Upval FindUpval(this TThread L, int levelIndex)
        {
            return null;
        }
    }
}
