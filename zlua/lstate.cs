using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
/// <summary>
/// 全局状态
/// </summary>
namespace zlua.GlobalState
{
    public class GlobalState
    {
        public TValue registry;
        public TThread mainThread;
    }
}
