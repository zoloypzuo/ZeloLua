using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
/// <summary>
/// 调试器
/// </summary>
namespace zlua.Debugger
{
    public class LDebug
    {
        public LDebug(TThread L)
        {
            _G = (TTable)L.globalsTable;
        }
        public Dictionary<string, TValue> Name2Local { get; }
        public readonly TTable _G;
        public override string ToString()
        {
            string s="";
            s += "* Locals\n";
            foreach (var item in Name2Local) {
                s += (item.Key + "\t" + item.Value);
            }
            s += "* Globals\n";
            foreach (var item in _G) {
                s += item;
            }
            return s;
        }
    }
}
