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
        public TTable metaTable;
        public TTable env;
    }

    public class TTable : LuaReference, IEnumerable<KeyValuePair<LuaValue, LuaValue>>
    {
        public TTable metatable;
        private Dictionary<LuaValue, LuaValue> hashTablePart;
        private List<LuaValue> arrayPart;

        public TTable(int sizeArrayPart, int sizeHashTablePart)
        {
            hashTablePart = new Dictionary<LuaValue, LuaValue>(sizeHashTablePart);
            arrayPart = new List<LuaValue>(sizeArrayPart);
        }

        private static int Double2Integer(double d)
           => (int)Math.Round(d, MidpointRounding.AwayFromZero); //目前来说只有这里需要用

        /// <summary>
        /// luaH_get
        /// </summary>
        public LuaValue Get(LuaValue key)
        {
            switch (key.Type) {
                case LuaTypes.Nil: return LuaValue.NilObject;
                case LuaTypes.String:
                    return GetByStr(key.TStr);

                case LuaTypes.Number:
                    double n = key.N;
                    int k = Double2Integer(n);
                    if (k == n)
                        return GetByInt(k);
                    goto default; // sigh, must have break or return, so ...
                default:
                    if (hashTablePart.ContainsKey(key))
                        return hashTablePart[key];
                    return LuaValue.NilObject;
            }
        }

        /// <summary>
        /// luaH_set, return tvalue found with `key,
        /// else create a new pair and return the new tvalue
        /// </summary>
        public LuaValue Set(LuaState L, LuaValue key)
        {
            var tval = Get(key);
            if (tval != LuaValue.NilObject) return tval;
            else {
                //Debug.Assert(key.IsNil, "table index is nil");
                //Debug.Assert(key.IsNumber && Double.IsNaN(key.N), "table index is NaN");
                var new_val = new LuaValue();
                hashTablePart[key] = new_val;
                return new_val;
            }
        }

        public LuaValue GetByStr(TString key)
        {
            var k = new LuaValue(key);
            if (hashTablePart.ContainsKey(k))
                return hashTablePart[k];
            return LuaValue.NilObject;
        }

        /// <summary>
        /// luaH_getnum
        /// </summary>
        public LuaValue GetByInt(LuaInteger key)
        {
            if (key - 1 < arrayPart.Count) return arrayPart[(int)key - 1];
            else {
                double k = (double)key;
                if (hashTablePart.ContainsKey(new LuaValue(key)))
                    return hashTablePart[new LuaValue(k)];
                return LuaValue.NilObject;
            }
        }

        private LuaValue SetStr(TString key)
        {
            var tval = GetByStr(key);
            if (tval != LuaValue.NilObject)
                return tval;
            else {
                var new_val = new LuaValue();
                hashTablePart[new LuaValue(key)] = new_val;
                return new_val;
            }
        }

        private LuaValue SetInt(LuaInteger key)
        {
            var tval = GetByInt(key);
            if (tval != LuaValue.NilObject) return tval;
            else {
                var new_val = new LuaValue();
                hashTablePart[new LuaValue(key)] = new_val;
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

        IEnumerator<KeyValuePair<LuaValue, LuaValue>> IEnumerable<KeyValuePair<LuaValue, LuaValue>>.GetEnumerator()
        {
            LuaInteger index = 0;
            foreach (var item in arrayPart) {
                yield return new KeyValuePair<LuaValue, LuaValue>(new LuaValue(++index), item);
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
        public LuaValue val;
        public byte Instack;
        public byte Idx;
    }
}