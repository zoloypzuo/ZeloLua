using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.TypeModel;
using zlua.ISA;

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

        public List<TValue> _stack;
        /// <summary>
        /// = callinfo_stack.top().top 
        /// </summary>
        public int top { get; } //StkId top, but you know, use "pointer + int" to get array element
        /// <summary>
        /// = callinfo_stack.top()._base
        /// </summary>
        public int _base { get; }
        public CallInfo curr_callinfo { get; }
        public Stack<CallInfo> callinfo_stack;
        /// <summary>
        /// consts
        /// </summary>
        List<TValue> k;
        /// <summary>
        /// _G
        /// </summary>
        public TTable GlobalTable { get; set; }
        /// <summary>
        /// saved pc when call a function; index of instruction array
        /// </summary>
        public int savedpc;

        public TThread(Proto main_func)
        {
            rt_main_func = new Closure(main_func) { ret_addr = -1 };
            global_data = rt_main_func.local_data;
            stack.Push(rt_main_func);
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
            cs.func = _stack[top - (n_args + 1)];
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
        TValue RA(Instruction i) => _stack[_base + i.A];
        TValue RB(Instruction i) => _stack[_base + i.B];
        TValue RC(Instruction i) => _stack[_base + i.C];

        TValue RKB(Instruction i) => Instruction.is_k(i.B) ? k[Instruction.index_k(i.B)] : RB(i);
        TValue RKC(Instruction i) => Instruction.is_k(i.C) ? k[Instruction.index_k(i.C)] : RC(i);
        TValue KBx(Instruction i) => k[i.Bx];
        #endregion
        #region other things
        /// <summary>
        /// get tvalue from stack, accept an signed index (which allows index that under 0) or pesudo index to index special variable like _G
        /// </summary>
        public static TValue index2tval(int index)
        {
            //TODO
            //static TValue* index2adr(lua_State* L, int idx)
            //{
            //    if (idx > 0) {
            //        // 如果idx > 0,则从栈中base为基础位置取元素
            //        TValue* o = L->base + (idx - 1);
            //        api_check(L, idx <= L->ci->top - L->base);
            //        if (o >= L->top) return cast(TValue *, luaO_nilobject);
            //        else return o;
            //    } else if (idx > LUA_REGISTRYINDEX) {
            //        // 如果LUA_REGISTRYINDEX > idx < 0,则从栈中top为基础位置取元素
            //        api_check(L, idx != 0 && -idx <= L->top - L->base);
            //        return L->top + idx;
            //    } else switch (idx) {  /* pseudo-indices */
            //            case LUA_REGISTRYINDEX: return registry(L);
            //            case LUA_ENVIRONINDEX: {
            //                    Closure* func = curr_func(L);
            //                    sethvalue(L, &L->env, func->c.env);
            //                    return &L->env;
            //                }
            //            case LUA_GLOBALSINDEX: return gt(L);
            //            default: {
            //                    Closure* func = curr_func(L);
            //                    idx = LUA_GLOBALSINDEX - idx;
            //                    return (idx <= func->c.nupvalues)
            //                              ? &func->c.upvalue[idx - 1]
            //                              : cast(TValue *, luaO_nilobject);
            //                }
            //        }
            //}

            return null;
        }
        bool is_Cs_function(int index) => index2tval(index).is_cs_function;

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

        public bool is_number(int index) =>false;
        public TNumber tonumber(int index)
        {
            var tval = index2tval(index);
            return 1;
        }
        public TValue tonumber(TValue obj)
        {
            if (obj.tt_is_number) return obj;
            if (obj.tt_is_string) ;
            return null;
        }
        #endregion
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
