using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.ISA;
using zlua.GlobalState;
using System.Diagnostics;
using zlua.API;
/// <summary>
/// 虚拟机
/// </summary>
namespace zlua.VM
{
    using TNumber = Double;
    public class TThread : GCObject
    {
        Closure rt_main_func;
        public Stack<Closure> stack = new Stack<Closure>();
        public Dictionary<TString, TValue> global_data;
        public int pc = 0;

        public List<TValue> Stack;
        /// <summary>
        /// = callinfo_stack.top().top 
        /// </summary>
        public int top;  // StkId top, but you know, use "pointer + int" to get array element
        /// <summary>
        /// = callinfo_stack.top()._base
        /// </summary>
        public int _base; // "base" is a C# keyword, ...
        public CallInfo CurrCallInfo { get; }
        public CallInfo IncrementCallInfo()
        {
            var ci = new CallInfo();
            callinfoStack.Push(ci);
            return ci;
        }
        public Stack<CallInfo> callinfoStack;
        /// <summary>
        /// consts
        /// </summary>
        List<TValue> k;
        /// <summary>
        /// _G
        /// </summary>
        public TValue GlobalsTable { get; set; }
        /// <summary>
        /// saved pc when call a function; index of instruction array
        /// </summary>
        public int savedpc;
        public int nCSharpCalls;
        public GlobalState.GlobalState GlobalState;
        /// <summary>
        /// lua_newstate    
        /// </summary>
        /// <param name="main_func"></param>
        public TThread(Proto main_func)
        {
            rt_main_func = new Closure(main_func) { ret_addr = -1 };
            global_data = rt_main_func.local_data;
            stack.Push(rt_main_func);

            GlobalState = new GlobalState.GlobalState() { mainThread = this };


        }
        public void run()
        {
            while (true) {
                var curr_instr = curr_func.func.instrs[pc];
                curr_instr.execute(this);
                pc++;
            }
        }
        /// <summary>
        /// TODO 这是一个重新开始的地方，命名可以稍微参考一下。但是指令集要思考一下。要紧凑。理论上和寄存器式应该是一致的
        /// </summary>
        public void new_run(int level)
        {
            while (true) {
                //const Instruction pc = 1;
            }
            //var curr_instr = curr_func.func.instrs[pc];
            //var opcode = opcode(curr_instr);
            //switch(opcode) {
            //    case Mov:
            //        foo;
            //        continue;
            //    case ...
            //}
        }
        public Closure curr_func => stack.Peek();
        public void push(TValue item) => curr_func.stack.Push(item);
        public TValue pop() => curr_func.stack.Pop();


        public void load_file(string fn) { }
        public void pcall(int n_args, int n_retvals)
        {
            var cs = new CallS();
            cs.func = Stack[top - (n_args + 1)];
        }
        public void pre_call()
        {
            //TODO save pc to caller CallInfo, create new CallInfo for callee
        }
        public void pos_call()
        {

        }
        public void single_var_aux()
        {
            // in parse stage, use tree<FuncState> to find reference of variable:
            //            a.local scope/ curr func => local var

            //        b.outer scope/ enclosing func => upvalue
            //the outest/ virtual main/ global scope => global var
        }
        #region get operands from instruction args
        /// <summary>
        /// NO NEED TO IMPLEMENT check opmode of B, C
        /// </summary>
        /// <param name="i"></param>
        /// <returns></returns>
        TValue RA(Instruction i) => Stack[_base + i.A];
        TValue RB(Instruction i) => Stack[_base + i.B];
        TValue RC(Instruction i) => Stack[_base + i.C];

        TValue RKB(Instruction i) => Instruction.is_k(i.B) ? k[Instruction.index_k(i.B)] : RB(i);
        TValue RKC(Instruction i) => Instruction.is_k(i.C) ? k[Instruction.index_k(i.C)] : RC(i);
        TValue KBx(Instruction i) => k[i.Bx];
        #endregion
        #region other things

        bool is_Cs_function(int index) => this.Index2TVal(index).is_cs_function;

        //LUA_API int lua_isnumber(lua_State* L, int idx)
        //{
        //    TValue n;
        //    const TValue* o = index2adr(L, idx);
        //    return tonumber(o, &n);
        //}


        //LUA_API int lua_isstring(lua_State* L, int idx)
        //{
        //    int t = lua_type(L, idx);
        //    return (t == LUA_TSTRING || t == LUA_TNUMBER);
        //}


        //LUA_API int lua_isuserdata(lua_State* L, int idx)
        //{
        //    const TValue* o = index2adr(L, idx);
        //    return (ttisuserdata(o) || ttislightuserdata(o));
        //}

        public bool is_number(int index) => false;
        public TNumber tonumber(int index)
        {
            var tval = this.Index2TVal(index);
            return 1;
        }
        public TValue tonumber(TValue obj)
        {
            if (obj.tt_is_number) return obj;
            if (obj.tt_is_string) ;
            return null;
        }
        #endregion
        /// <summary>
        /// equalobj
        /// </summary>
        public bool EqualObj(TValue o1, TValue o2) => (o1.Type == o2.Type) && EqualVal(o1, o2);
        /// <summary>
        /// luaV_equalval
        /// </summary>
        /// <param name="t1"></param>
        /// <param name="o"></param>
        /// <param name=""></param>
        /// <returns></returns>
        public bool EqualVal(TValue t1, TValue t2)
        {
            Debug.Assert(t1.Type == t2.Type);
            switch (t1.Type) {
                case LuaTypes.Nil:return true;
                case LuaTypes.Number:return (TNumber)t1 == (TNumber)t2;
                case LuaTypes.Boolean:return (bool)t1 == (bool)t2; //为什么cast多余，不应该啊。要么得改成字段访问
                case LuaTypes.Userdata:return false;//TODO 有meta方法
                case LuaTypes.Table: {
                        if ((TTable)t1 == (TTable)t2) return true;
                        return false;//TODO metatable compare
                    }
                default:
                    return (GCObject)t1 == (GCObject)t2;
                //TODO metatable compare???
            }
        }
        /// <summary>
        /// luaV_gettable
        /// </summary>
        /// <param name="t"></param>
        /// <param name="key"></param>
        /// <param name="val"></param>
        public void GetTable(TValue t,TValue key,TValue val)
        {
            //TODO, 要无限查元表。
        }
        public bool LessThan(TValue lhs,TValue rhs)
        {
            if (lhs.Type != rhs.Type) throw new Exception();
            if (lhs.tt_is_number) return (TNumber)lhs < (TNumber)rhs;
            if (lhs.tt_is_string) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
        }
    }
    /// <summary>
    /// protected call
    /// </summary>
    public class CallS { public TValue func; public int n_retvals; }
    public class CallInfo
    {
        public TValue func;
        public int _base; // = func+1
        public int top;
        /// <summary>
        /// saved pc when call function, index of instruction array
        /// </summary>
        public int savedpc;
        int n_retvals;
    }
}
