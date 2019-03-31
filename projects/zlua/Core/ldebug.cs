//using System.Collections.Generic;
//using ZeptLua.VM;
//using zlua.Core;
///// <summary>
///// 调试器
///// </summary>
//namespace ZeptLua.Debugger
//{
//    public class LDebug
//    {
//        public LDebug(TThread L)
//        {
//            _G = (TTable)L.globalsTable;
//        }

//        private readonly Dictionary<string, TValue> name2Local;

//        public Dictionary<string, TValue> GetName2Local()
//        {
//            return name2Local;
//        }

//        public readonly TTable _G;
//        public override string ToString()
//        {
//            string s="";
//            s += "* Locals\n";
//            foreach (var item in GetName2Local()) {
//                s += (item.Key + "\t" + item.Value);
//            }
//            s += "* Globals\n";
//            foreach (var item in _G) {
//                s += item;
//            }
//            return s;
//        }
//    }
//}
