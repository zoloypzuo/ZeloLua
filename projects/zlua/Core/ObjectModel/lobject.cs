// 类型模型

using System;
using System.Collections;
using System.Collections.Generic;

using zlua.Core.Lua;
using zlua.Core.VirtualMachine;

namespace zlua.Core.ObjectModel
{
    internal class LocVar
    {
        public string VarName;
        public uint StartPc;
        public uint EndPc;
    }

    // the string type of lua, just warpper of C# string
    public class TString : LuaReference
    {
        public TString(string str)
        {
            this.str = str;
        }

        public string str; //可以设置str，这样复用TString对象，因为只是个warpper，

        public override string ToString()
        {
            return str.ToString();
        } // for debugging

        public override bool Equals(object obj)
        {
            return str.Equals((obj as TString)?.str);
        }

        public override int GetHashCode()
        {
            return str.GetHashCode();
        }

        public static implicit operator string(TString tstr) => tstr.str;

        public static implicit operator TString(string str) => new TString(str);

        public int Len { get { return str.Length; } }
    }

    // GCObject; base class of all reference type objects in lua
    public abstract class LuaReference
    {
    }

    //TODO
    public class Userdata : LuaReference
    {
        public Table metaTable;
        public Table env;
    }

    public class Table : LuaReference, IEnumerable<KeyValuePair<TValue, TValue>>
    {
        public Table metatable;
        private Dictionary<TValue, TValue> hashTablePart;
        private List<TValue> arrayPart;

        public Table(int sizeArrayPart, int sizeHashTablePart)
        {
            hashTablePart = new Dictionary<TValue, TValue>(sizeHashTablePart);
            arrayPart = new List<TValue>(sizeArrayPart);
        }

        private static int Double2Integer(double d)
           => (int)Math.Round(d, MidpointRounding.AwayFromZero); //目前来说只有这里需要用

        /// <summary>
        /// luaH_get
        /// </summary>
        public TValue Get(TValue key)
        {
            switch (key.Type) {
                case LuaType.LUA_TNIL: return TValue.NilObject;
                case LuaType.LUA_TSTRING:
                    return GetByStr(key.TStr);

                case LuaType.LUA_TNUMBER:
                    double n = key.N;
                    int k = Double2Integer(n);
                    if (k == n)
                        return GetByInt(k);
                    goto default; // sigh, must have break or return, so ...
                default:
                    if (hashTablePart.ContainsKey(key))
                        return hashTablePart[key];
                    return TValue.NilObject;
            }
        }

        /// <summary>
        /// luaH_set, return tvalue found with `key,
        /// else create a new pair and return the new tvalue
        /// </summary>
        public TValue Set(lua_State L, TValue key)
        {
            var tval = Get(key);
            if (tval != TValue.NilObject) return tval;
            else {
                //Debug.Assert(key.IsNil, "table index is nil");
                //Debug.Assert(key.IsNumber && Double.IsNaN(key.N), "table index is NaN");
                var new_val = new TValue();
                hashTablePart[key] = new_val;
                return new_val;
            }
        }

        public TValue GetByStr(TString key)
        {
            var k = new TValue(key);
            if (hashTablePart.ContainsKey(k))
                return hashTablePart[k];
            return TValue.NilObject;
        }

        /// <summary>
        /// luaH_getnum
        /// </summary>
        public TValue GetByInt(lua_Integer key)
        {
            if (key - 1 < arrayPart.Count) return arrayPart[(int)key - 1];
            else {
                double k = (double)key;
                if (hashTablePart.ContainsKey(new TValue(key)))
                    return hashTablePart[new TValue(k)];
                return TValue.NilObject;
            }
        }

        private TValue SetStr(TString key)
        {
            var tval = GetByStr(key);
            if (tval != TValue.NilObject)
                return tval;
            else {
                var new_val = new TValue();
                hashTablePart[new TValue(key)] = new_val;
                return new_val;
            }
        }

        private TValue SetInt(lua_Integer key)
        {
            var tval = GetByInt(key);
            if (tval != TValue.NilObject) return tval;
            else {
                var new_val = new TValue();
                hashTablePart[new TValue(key)] = new_val;
                return new_val; //TODO 这里是错的。应该有分配到arraypart的逻辑
            }
        }

        /// <summary>
        /// luaH_getn; 返回一个int索引作为bound，本身不为空，下一个位置为空
        /// </summary>
        /// <returns></returns>
        public int GetN()
        {
            return 1;
        }

        IEnumerator<KeyValuePair<TValue, TValue>> IEnumerable<KeyValuePair<TValue, TValue>>.GetEnumerator()
        {
            lua_Integer index = 0;
            foreach (var item in arrayPart) {
                yield return new KeyValuePair<TValue, TValue>(new TValue(++index), item);
            }
            foreach (var item in hashTablePart) {
                yield return item;
            }
        }

        public IEnumerator GetEnumerator()
        {
            return this.GetEnumerator();
        }
    }

    internal class Upvalue : LuaReference
    {
        public TValue val;
        public byte Instack;
        public byte Idx;
    }
}