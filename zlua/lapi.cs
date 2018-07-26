using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.VM;
using zlua.TypeModel;
using zlua.CallSystem;
using System.Diagnostics;
using zlua;
using zlua.Configuration;
/// <summary>
/// CSharp API
/// </summary>
namespace zlua.API
{
    public static class lapi
    {
        #region push functions (C# -> L)
        // 这个push相当于x86的push指令，对于lua这种情况（C#当然不能像汇编一样随便访问内存），其实是设置top元素为push进去的元素而不是push一个新的TValue进去
        // 实现决策】重复使用top++让人有种1. 没封装好，用户不应该知道栈顶的约定 2. repeat yourself（包括index2TVal）；然而这是没办法的。lapi等很多传入L的文件/模块其实是对L这个类的扩展，但是又不得不像外部类一样编程
        // 所以挺痛苦的；关于实现，先和src尽量一致，保证正确。多写几行不会死。

        /// <summary>
        /// luaA_pushobject
        /// </summary>
        public static void PushObject(this TThread L, TValue obj)
        {
            L[L.top++].TVal = obj;
        }
        /// <summary>
        /// lua_pushnil
        /// </summary>
        public static void PushNil(this TThread L)
        {
            L[L.top++].SetNil();
        }
        /// <summary>
        /// lua_pushnumber
        /// </summary>
        public static void PushNumber(this TThread L, double n)
        {
            L[L.top++].N = n;
        }
        /// <summary>
        /// lua_pushinteger
        /// </summary>
        public static void PushInteger(this TThread L, int n)
        {
            L[L.top++].N = (double)n;
        }
        /// <summary>
        /// lua_pushlstring, lua_pushstring
        /// </summary>
        public static void PushString(this TThread L, string s)
        {
            if (s == null)
                PushNil(L);
            else
                L[L.top++].TStr = (TString)s;
        }
        /// <summary>
        /// lua_pushvfstring, pushfstring
        /// </summary>
        static void PushFormatedString(this TThread L, string format)
        {
            //TODO 
        }
        /// <summary>
        /// lua_pushcclosure
        /// </summary>
        public static void PushCShapClosure(this TThread L, lua.CSharpFunction func, int n)
        {
            //TODO
        }
        /// <summary>
        /// lua_pushboolean
        /// </summary>
        public static void PushBool(this TThread L, bool b)
        {
            L[L.top++].B = b;
        }
        /// <summary>
        /// lua_pushlighuserdata
        /// </summary>
        public static void PushLightUserdata(this TThread L, object lud)
        {
            //TODO
        }
        /// <summary>
        /// lua_pushthread; push L itself
        /// </summary>
        public static void PushThread(this TThread L)
        {
            L[L.top++].Thread = L;
        }
        /// <summary>
        /// lua_pushvalue; push L[index]
        /// </summary>
        public static void PushValue(this TThread L, int index)
        {
            L[L.top++] = Index2TVal(L, index);
        }
        #endregion
        #region access functions (L -> C#)
        /// <summary>
        /// lua_type
        /// </summary>
        public static LuaTypes Type(this TThread L, int index)
        {
            TValue o = Index2TVal(L, index);
            return (o == TValue.NilObject) ? LuaTypes.None : o.Type;
        }
        /// <summary>
        /// lua_typename; 
        /// 没用，仅仅是为了与src API一致，完整】
        /// </summary>
        public static string TypeName(this TThread L, LuaTypes type)
        {
            return type == LuaTypes.None ? "no value" : type.ToString();
        }
        /// <summary>
        /// lua_iscfunction
        /// </summary>
        public static bool IsCSharpFunction(this TThread L, int index) => L.Index2TVal(index).IsCSharpFunction;
        /// <summary>
        /// lua_isnumber
        /// </summary>
        public static bool IsNumber(this TThread L, int index) => false;//TODO tonumber
                                                                        /// <summary>
                                                                        /// lua_isstring
                                                                        /// </summary>
        public static bool IsString(this TThread L, int index)
        {
            var t = Type(L, index);
            return t == LuaTypes.String || t == LuaTypes.Number;
        }
        /// <summary>
        /// lua_isuserdata; `src check both light and full ud
        /// 没有引用】和src不一致，他把light 和full都算ud】
        /// </summary>
        public static bool IsLightUserData(this TThread L, int index) => Index2TVal(L, index).Type == LuaTypes.LightUserdata;
        /// <summary>
        /// lua_rawequal； raw指不调用元方法__eq
        /// </summary>
        public static bool RawEqual(this TThread L, int index1, int index2)
        {
            var o1 = Index2TVal(L, index1);
            var o2 = Index2TVal(L, index2);
            return (o1 == TValue.NilObject || o2 == TValue.NilObject) ? false : o1.Equals(o2);
        }
        /// <summary>
        /// lua_equal
        /// 没有引用】
        /// </summary>
        public static bool Equal(this TThread L, int index1, int index2)
        {
            var o1 = L.Index2TVal(index1);
            var o2 = L.Index2TVal(index2);
            var either_nil = (o1 == TValue.NilObject || o2 == TValue.NilObject);
            return either_nil ? false : L.EqualObj(o1, o2);
        }
        /// <summary>
        /// lua_lessthan
        /// </summary>
        public static bool LessThan(this TThread L, int index1, int index2)
        {
            var o1 = L.Index2TVal(index1);
            var o2 = L.Index2TVal(index2);
            var either_nil = (o1 == TValue.NilObject || o2 == TValue.NilObject);
            return either_nil ? false : L.LessThan(o1, o2);
        }
        /// <summary>
        /// lua_tonumber; 即使转换失败，返回0
        /// </summary>
        public static double ToNumber(this TThread L, int index)
        {
            TValue o = Index2TVal(L, index);
            bool canBeConvertedToNum;
            double num = (double)L.ToNumber(o, out canBeConvertedToNum);
            if (canBeConvertedToNum)
                return num;
            else
                return 0;
        }
        /// <summary>
        /// lua_tointeger; 基于ToNumber，转成int，四舍五入
        /// </summary>
        public static int ToInteger(this TThread L, int index)
        {
            return luaconf.Double2Integer(ToNumber(L, index));
        }
        /// <summary>
        /// lua_toboolean
        /// </summary>
        public static bool ToBoolean(this TThread L, int index)
        {
            return !Index2TVal(L, index).IsFalse;
        }
        /// <summary>
        /// lua_tolstring
        /// </summary>
        public static string ToString(this TThread L, int index)
        {
            return null;
        }
        /// <summary>
        /// lua_objlen
        /// </summary>
        public static int ObjLen(this TThread L, int index)
        {
            return 0;
        }
        /// <summary>
        /// lua_tocfunction
        /// </summary>
        public static lua.CSharpFunction ToCSharpFunction(this TThread L, int index)
        {
            return null;
        }
        /// <summary>
        /// lua_touserdata; `src handle both light and full ud
        /// </summary>
        public static object ToUserdata(this TThread L, int index)
        {
            return null;
        }
        /// <summary>
        /// lua_tothread
        /// </summary>
        public static TThread ToThread(this TThread L, int index)
        {
            return null;
        }
        /// <summary>
        /// lua_topointer; return all lua reference type as object 
        /// </summary>
        public static object ToPointer(this TThread L, int index)
        {
            return null;
        }
        #endregion
        #region get functions (Lua -> L)
        /// <summary>
        /// lua_gettable; may call metamethold __index, which rawget does not
        /// </summary>
        public static void GetTable(this TThread L, int index)
        {
            var t = L.Index2TVal(index);
            var top = L[L.top - 1];
            L.GetTable(t, top, top);
        }
        /// <summary>
        /// lua_getfield; get field from table (indexed by `index), and push the field into L
        /// </summary>
        public static void GetField(this TThread L, int index, string key)
        {
            var t = L.Index2TVal(index);
            //TODO luaV_gettable, metable table
        }
        /// <summary>
        /// lua_rawget; key is pushed, only find the value in the original table (thus metamethod __index is not called),
        /// and set key to value, thus value is at the top (to save an entry =_=)
        /// </summary>
        public static void RawGet(this TThread L, int index)
        {
            TValue table = Index2TVal(L, index);
            Debug.Assert(table.IsTable);
            L[L.top - 1].TVal = table.Table.Get(L[L.top - 1]);
        }

        //实现决策】下面的代码L实现了indexer（用的多了自然要），之前写好的不会改，这样也好。Stack的访问仍然是像数组一样，而不是真正的Stack

        /// <summary>
        /// lua_rawgeti; key is int (compared to `rawget) and value is pushed
        /// </summary>
        public static void RawGetInt(this TThread L, int index, int n)
        {
            TValue table = Index2TVal(L, index);
            Debug.Assert(table.IsTable);
            L[L.top++] = table.Table.GetByInt(n);
        }
        /// <summary>
        /// lua_createtable
        /// </summary>
        public static void CreateTable(this TThread L, int sizeArrayPart, int sizeHashTablePart)
        {
            L[L.top++] = (TValue)new TTable(sizeHashTablePart: sizeHashTablePart, sizeArrayPart: sizeArrayPart);
        }
        /// <summary>
        /// lua_getmetable
        /// </summary>
        public static void GetMetatable(this TThread L, int index)
        {
            var obj = L.Index2TVal(index);
            TTable mt = null;
            switch (obj.Type) {
                case LuaTypes.Table: mt = ((TTable)obj).metatable; break;
                case LuaTypes.Userdata: break;
                default: break;
            }
            if (mt != null)
                L[L.top++].Table = mt;
        }/// <summary>
         /// lua_getfenv; get env of Function, Userdata and Thread
         /// </summary>
        public static void GetFEnv(this TThread L, int index)
        {

        }
        #region set functions (L -> Lua)
        /// <summary>
        /// lua_settable; 
        /// </summary>
        public static void SetTable(this TThread L, int index)
        {

        }
        /// <summary>
        /// lua_setfield;
        /// </summary>
        public static void SetField(this TThread L, int index, string k)
        {

        }
        public static void RawSet(this TThread L, int index)
        {

        }
        public static void RawSetInt(this TThread L, int index, int n)
        {

        }
        public static void SetMetatable(this TThread L, int objIndex)
        {

        }
        public static void SetFenv(this TThread L, int index)
        {

        }
        #endregion
        #endregion
        #region load and call functions (run Lua code)
        /// <summary>
        /// adjustresults
        /// </summary>
        static void AdjustRetvals(this TThread L, int nRetvals)
        {
            if (nRetvals == lua.MultiRet && L.top >= L.CurrCallInfo.top) L.CurrCallInfo.top = L.top;
        }
        /// <summary>
        /// lua_call
        /// </summary>
        public static void Call(this TThread L, int nArgs, int nRetvals)
        {
            int funcIndex = L.top - (nArgs + 1);
            ldo.Call(L, funcIndex, nRetvals); //TODO 名字重复了，不好。而且签名是一样的。
            //AdjustRetvals(L, nRetvals);
        }
        #endregion
        #region other functions
        /// <summary>
        /// lua_gettop
        /// </summary>
        public static int GetTop(this TThread L) => L.top - L._base;

        public static TTable GetCurrEnv(this TThread L)
        {
            return null;
        }

        /// <summary>
        /// get tvalue from stack, accept an signed index (which allows index that under 0), or pesudo index to index special variable like _G
        /// 正数idx允许超界，返回nilObject，而负数不允许；
        /// 伪索引包含：注册表，_G，C函数相关的两样东西：env和upvals，这点请阅读一下5.1 manual里C API处 3.4 CCLosure小节的笔记，总之是为了CClosure服务的
        /// get env有一点困惑（他设置了L.env）但是无所谓，upvals数组同样是从1开始索引，超界返回nilObject（应该是个约定，正数索引都这样）
        /// </summary>
        public static TValue Index2TVal(this TThread L, int index)
        {
            if (index > 0) {
                Debug.Assert(index <= L.CurrCallInfo.top - L._base); // check array boundary
                int idx = L._base + (index - 1);
                if (idx >= L.top) return TValue.NilObject;
                else return L[idx];
            } else if (index > lua.RegisteyIndex) /* -10000 < index < 0*/ {
                Debug.Assert(index != 0 && -index <= L.top - L._base); // check array boundary
                return L[L.top + index];
            } else {
                switch (index) {
                    case lua.RegisteyIndex: return L.globalState.registry;
                    case lua.EnvIndex: {
                            L.env.Table = (L[L.CurrCallInfo.funcIndex].Cl as CSharpClosure).env;
                            return L.env;
                        }
                    case lua.GlobalsIndex: return L.globalsTable;
                    default: {
                            CSharpClosure func = L[L.CurrCallInfo.funcIndex].Cl as CSharpClosure;
                            index = lua.GlobalsIndex - index;
                            return index <= func.NUpvals ? func.upvals[index - 1] : TValue.NilObject;
                        }
                }
            }
        }
        #endregion

    }
}
