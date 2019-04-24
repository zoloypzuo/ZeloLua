namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// 栈帧信息，或者说是一次调用的信息
    /// </summary>
    internal class CallInfo
    {
        public int funcIndex;

        public int @base {
            get {
                return funcIndex + 1;
            }
        }

        public int top;

        /// saved pc when call function, index of instruction array
        /// 调用别的函数时保存LuaState的savedpc
        public int savedpc;
    }
}
