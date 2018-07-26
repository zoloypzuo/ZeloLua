using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.VM;
using zlua.Metamethod;
/// <summary>
/// 全局状态
/// </summary>
namespace zlua.GlobalState
{
    /// <summary>
    /// 相比src，几乎没用。
    /// </summary>
    public class GlobalState
    {
        public TValue registry;
        public TThread mainThread;
        public TTable[] metaTableForBasicType = new TTable[(int)LuaTypes.Thread + 1];
        public TString[] metaMethodNames = new TString[(int)MetamethodTypes.N];
    }
}
