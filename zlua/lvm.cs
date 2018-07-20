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
        public TValue globalsTable;
        /// <summary>
        /// saved pc when call a function; index of instruction array
        /// </summary>
        public int savedpc;
        public int nCSharpCalls;
        public GlobalState.GlobalState globalState;
        /// <summary>
        /// lua_newstate    
        /// </summary>
        /// <param name="main_func"></param>
        public TThread(Proto main_func)
        {
            globalState = new GlobalState.GlobalState() { mainThread = this };
        }
        /// <summary>
        /// luaV_execute
        /// </summary>
        /// <param name="level"></param>
        public void Execute(int level)
        {
            while (true) {
                Instruction i = 0;
                switch (i.Opcode) {
                    case Opcodes.Move:
                        break;
                    case Opcodes.LoadK:
                        break;
                    case Opcodes.LoadBool:
                        break;
                    case Opcodes.LoadNil:
                        break;
                    case Opcodes.GetUpVal:
                        break;
                    case Opcodes.GetGlobal:
                        break;
                    case Opcodes.GetTable:
                        break;
                    case Opcodes.SetGlobal:
                        break;
                    case Opcodes.SetUpval:
                        break;
                    case Opcodes.SetTable:
                        break;
                    case Opcodes.NewTable:
                        break;
                    case Opcodes.Self:
                        break;
                    case Opcodes.Add:
                        break;
                    case Opcodes.Sub:
                        break;
                    case Opcodes.Mul:
                        break;
                    case Opcodes.Div:
                        break;
                    case Opcodes.Mod:
                        break;
                    case Opcodes.Pow:
                        break;
                    case Opcodes.Unm:
                        break;
                    case Opcodes.Not:
                        break;
                    case Opcodes.Len:
                        break;
                    case Opcodes.Concat:
                        break;
                    case Opcodes.Jmp:
                        break;
                    case Opcodes.Eq:
                        break;
                    case Opcodes.Lt:
                        break;
                    case Opcodes.Le:
                        break;
                    case Opcodes.Test:
                        break;
                    case Opcodes.Testset:
                        break;
                    case Opcodes.Call:
                        break;
                    case Opcodes.TailCall:
                        break;
                    case Opcodes.Return:
                        break;
                    case Opcodes.ForLoop:
                        break;
                    case Opcodes.ForPrep:
                        break;
                    case Opcodes.TForLoop:
                        break;
                    case Opcodes.SetList:
                        break;
                    case Opcodes.Close:
                        break;
                    case Opcodes.Closure:
                        break;
                    case Opcodes.VarArg:
                        break;
                    case Opcodes.And:
                        break;
                    case Opcodes.PushVar:
                        break;
                    case Opcodes.Push:
                        break;
                    case Opcodes.Pop:
                        break;
                    default:
                        break;
                }
            }

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

        /// <summary>
        /// luaV_tonumber
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public TValue ToNumber(TValue obj, TValue n)
        {
            return null;//TODO
        }
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
                case LuaTypes.Nil: return true;
                case LuaTypes.Number: return (TNumber)t1 == (TNumber)t2;
                case LuaTypes.Boolean: return (bool)t1 == (bool)t2; //为什么cast多余，不应该啊。要么得改成字段访问
                case LuaTypes.Userdata: return false;//TODO 有meta方法
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
        public void GetTable(TValue t, TValue key, TValue val)
        {
            //TODO, 要无限查元表。
        }
        public bool LessThan(TValue lhs, TValue rhs)
        {
            if (lhs.Type != rhs.Type) throw new Exception();
            if (lhs.tt_is_number) return (TNumber)lhs < (TNumber)rhs;
            if (lhs.tt_is_string) return false;//TODO 字典序。或者你看标准库有没有
            else return false; //TODO 调用meta方法
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
