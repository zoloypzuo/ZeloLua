using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.CallSystem;
using System.Diagnostics;

namespace zlua.API
{
    static class lapi
    {
        //class CallS
        //{
        //    public TValue func;
        //    public int n_retvals;
        //}
        //static void pcall(this TThread L,int n_args,int n_retvals,int errfunc)
        //{
        //    var cs=new CallS();
        //    cs.func = L.Stack[L.Top - n_args + 1];
        //    cs.n_retvals = n_retvals;

        //}
        /// <summary>
        /// lua_gettop
        /// </summary>
        /// <param name="L"></param>
        /// <returns></returns>
        public static int GetTop(this TThread L) => L.top - L._base;

        static void Call(this TThread L, int nArgs, int nRetvals)
        {
            int funcIndex = L.top - (nArgs + 1);
            CallSystem.ldo.Call(L, funcIndex, nRetvals);
            AdjustRetvals(L, nRetvals);
        }
        /// <summary>
        /// adjustresults
        /// </summary>
        /// <param name="L"></param>
        /// <param name="nRetvals"></param>
        public static void AdjustRetvals(this TThread L, int nRetvals)
        {
            if (nRetvals == lua.MultiRet && L.top >= L.CurrCallInfo.top) L.CurrCallInfo.top = L.top;
        }
        /// <summary>
        /// lua_createtable
        /// </summary>
        /// <param name="L"></param>
        /// <param name="sizeArrayPart"></param>
        /// <param name="sizeHashTablePart"></param>
        public static void CreateTable(this TThread L, int sizeArrayPart, int sizeHashTablePart)
        {
            var new_table = new TTable(L, sizeHashTablePart, sizeArrayPart);
            L.Stack.Add((TValue)new_table);
        }
        /// <summary>
        /// lua_equal
        /// </summary>
        /// <param name="L"></param>
        /// <param name="index1"></param>
        /// <param name="index2"></param>
        /// <returns></returns>
        public static bool Equal(this TThread L, int index1, int index2)
        {
            var o1 = L.Index2TVal(index1);
            var o2 = L.Index2TVal(index2);
            var either_nil = (o1 == TValue.NilObject || o2 == TValue.NilObject);
            return either_nil ? false : L.EqualObj(o1, o2);
        }
        /// <summary>
        /// get tvalue from stack, accept an signed index (which allows index that under 0) or pesudo index to index special variable like _G
        /// </summary>
        public static TValue Index2TVal(this TThread L, int index)
        {
            if (index > 0) {
                Debug.Assert(index <= L.CurrCallInfo.top - L._base); // check array boundary
                int idx = L._base + (index - 1);
                if (idx >= L.top) return TValue.NilObject;
                else return L.Stack[idx];
            } else if (index > lua.RegisteyIndex) /* -10000 < index < 0*/ {
                Debug.Assert(index != 0 && -index <= L.top - L._base); // check array boundary
                return L.Stack[L.top + index];
            } else {
                switch (index) {
                    case lua.RegisteyIndex: return L.globalState.registery;
                    case lua.EnvIndex: return null;  //TODO, src use curr func's env, why
                    case lua.GlobalsIndex: return L.globalsTable;
                    default:
                        return null; //TODO
                }
            }
        }
        /// <summary>
        /// lua_getfield, get field from table (indexed by `index), and push the field into L.Stack
        /// </summary>
        /// <param name="L"></param>
        /// <param name="index"></param>
        /// <param name="key"></param>
        public static void GetField(this TThread L, int index, string key)
        {
            var t = L.Index2TVal(index);
            //TODO luaV_gettable, metable table
        }

        /// <summary>
        /// lua_getmetable
        /// </summary>
        /// <param name="L"></param>
        /// <param name="index"></param>
        public static void GetMetatable(this TThread L, int index)
        {
            var obj = L.Index2TVal(index);
            TValue mt = null;
            switch (obj.Type) {
                case LuaTypes.Table: mt = ((TTable)obj).metatable; break;
                case LuaTypes.Userdata: break;
                default: break;
            }
            if (mt != null)
                L.Stack.Add(mt);
        }
        /// <summary>
        /// lua_gettable
        /// </summary>
        /// <param name="L"></param>
        /// <param name="index"></param>
        public static void GetTable(this TThread L,int index)
        {
            var t = L.Index2TVal(index);
            var top = L.Stack[L.top - 1];
            L.GetTable(t, top, top);
        }
        /// <summary>
        /// lua_lessthan
        /// </summary>
        /// <param name="L"></param>
        /// <param name="index1"></param>
        /// <param name="index2"></param>
        public static bool LessThan(this TThread L,int index1,int index2)
        {
            var o1 = L.Index2TVal(index1);
            var o2 = L.Index2TVal(index2);
            var either_nil = (o1 == TValue.NilObject || o2 == TValue.NilObject);
            return either_nil ? false : L.LessThan(o1, o2);
        }
        /// <summary>
        /// lua_iscfunction
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        public static bool IsCSFunction(this TThread L,int index) => L.Index2TVal(index).is_cs_function;
    }
}
