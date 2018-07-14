using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zlua
{
    class lparser
    {
        public void single_var_aux()
        {
            // in parse stage, use tree<FuncState> to find reference of variable:
            //            a.local scope/ curr func => local var

            //        b.outer scope/ enclosing func => upvalue
            //the outest/ virtual main/ global scope => global var
        }
    }
}
