using System;
using System.Collections.Generic;
using System.Diagnostics;
using ZoloLua.Core.TypeModel;

namespace ZoloLua.Core.VirtualMachine
{
    public partial class lua_State
    {
        /// <summary>
        ///     helper，绑定此lua_State的stack和StkId
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        private StkId newStkId(int index)
        {
            return new StkId(stack, index);
        }

        /// <summary>
        ///     模拟指针运算
        /// </summary>
        private class StkId : IEquatable<StkId>
        {
            private readonly List<TValue> stack;
            public int index;

            public StkId(List<TValue> stack, int index)
            {
                // 出错了，断言一下
                Debug.Assert(stack != null);
                this.stack = stack;
                this.index = index;
            }

            /// <summary>
            ///     helper
            /// </summary>
            /// <param name="o"></param>
            [DebuggerStepThrough]
            public void Set(TValue o)
            {
                stack[index].Value = o;
            }

            /// <summary>
            ///     helper
            /// </summary>
            [DebuggerStepThrough]
            public void SetNil()
            {
                stack[index].SetNil();
            }

            /// <summary>
            ///     helper，前置的cast语法非常丑
            /// </summary>
            public TValue Value {
                [DebuggerStepThrough]
                get {
                    return this;
                }
            }

            /// <summary>
            ///     指针+整数返回指针
            /// </summary>
            /// <param name="stkId"></param>
            /// <param name="i"></param>
            /// <returns></returns>
            public static StkId operator +(StkId stkId, int i)
            {
                return new StkId(stkId.stack, stkId.index + i);
            }

            /// <summary>
            ///     指针-整数返回指针
            /// </summary>
            /// <param name="stkId"></param>
            /// <param name="i"></param>
            /// <returns></returns>
            public static StkId operator -(StkId stkId, int i)
            {
                return new StkId(stkId.stack, stkId.index - i);
            }

            /// <summary>
            ///     指针之差
            /// </summary>
            /// <param name="l"></param>
            /// <param name="r"></param>
            /// <returns></returns>
            public static int operator -(StkId l, StkId r)
            {
                // stkid是内部实现细节，因此错误是断言不是异常
                Debug.Assert(ReferenceEquals(l.stack, r.stack));
                return l.index - r.index;
            }

            public static StkId operator ++(StkId stkId)
            {
                stkId.index++;
                return stkId;
            }

            public static StkId operator --(StkId stkId)
            {
                stkId.index--;
                return stkId;
            }

            /// <summary>
            ///     指针解引用
            /// </summary>
            /// <param name="stkId"></param>
            public static implicit operator TValue(StkId stkId)
            {
                return stkId.stack[stkId.index];
            }

            public static bool operator <(StkId l, StkId r)
            {
                return ReferenceEquals(l.stack, r.stack) && l.index < r.index;
            }

            public static bool operator >(StkId l, StkId r)
            {
                return ReferenceEquals(l.stack, r.stack) && l.index > r.index;
            }

            public static bool operator <=(StkId l, StkId r)
            {
                return ReferenceEquals(l.stack, r.stack) && l.index <= r.index;
            }

            public static bool operator >=(StkId l, StkId r)
            {
                return ReferenceEquals(l.stack, r.stack) && l.index >= r.index;
            }

            public static bool operator ==(StkId l, StkId r)
            {
                return l.Equals(r);
            }

            public static bool operator !=(StkId l, StkId r)
            {
                return !l.Equals(r);
            }

            public override string ToString()
            {
                return $"{index} {stack[index]}";
            }

            public override bool Equals(object obj)
            {
                return obj is StkId && Equals((StkId)obj);
            }

            public bool Equals(StkId other)
            {
                // stkid是内部实现细节，因此错误是断言不是异常
                Debug.Assert(ReferenceEquals(stack, other.stack));
                return index == other.index;
            }

            public override int GetHashCode()
            {
                return -1982729373 + index.GetHashCode();
            }
        }
    }
}