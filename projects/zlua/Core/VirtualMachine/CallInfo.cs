namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// 栈帧信息，或者说是一次调用的信息
    /// </summary>
    internal class CallInfo
    {
        public int @base;/* base for this function */
        public int func;/* function index in the stack */
        public int top; /* top for this function */
        /// saved pc when call function, index of instruction array
        /// 调用别的函数时保存LuaState的savedpc
        public int savedpc;
        public int nresults;  /* expected number of results from this function */
        public int tailcalls;  /* number of tail calls lost under this entry */
    }
}