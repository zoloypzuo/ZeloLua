using System;
using System.Collections.Generic;
using System.Diagnostics;
using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    public partial class lua_State
    {
        /// <summary>
        /// 模拟指针运算
        /// </summary>
        class StkId
        {
            List<TValue> stack;
            public int index;

            public StkId(List<TValue> stack, int index)
            {
                this.stack = stack;
                this.index = index;
            }

            /// <summary>
            /// helper
            /// </summary>
            /// <param name="o"></param>
            [DebuggerStepThrough]
            public void Set(TValue o)
            {
                stack[index].Value = o;
            }

            /// <summary>
            /// helper
            /// </summary>
            [DebuggerStepThrough]
            public void SetNil()
            {
                stack[index].SetNil();
            }

            /// <summary>
            /// 指针+整数返回指针
            /// </summary>
            /// <param name="stkId"></param>
            /// <param name="i"></param>
            /// <returns></returns>
            public static StkId operator +(StkId stkId, int i)
            {
                return new StkId(stkId.stack, stkId.index + i);
            }

            /// <summary>
            /// 指针-整数返回指针
            /// </summary>
            /// <param name="stkId"></param>
            /// <param name="i"></param>
            /// <returns></returns>
            public static StkId operator -(StkId stkId, int i)
            {
                return new StkId(stkId.stack, stkId.index - i);
            }

            /// <summary>
            /// 指针之差
            /// </summary>
            /// <param name="l"></param>
            /// <param name="r"></param>
            /// <returns></returns>
            public static int operator -(StkId l, StkId r)
            {
                // stkid是内部实现细节，因此错误是断言不是异常
                Debug.Assert(Object.ReferenceEquals(l.stack, r.stack));
                return l.index - r.index;
            }

            public static StkId operator ++(StkId stkId)
            {
                return new StkId(stkId.stack, stkId.index++);
            }

            public static StkId operator --(StkId stkId)
            {
                return new StkId(stkId.stack, stkId.index--);
            }

            /// <summary>
            /// 指针解引用
            /// </summary>
            /// <param name="stkId"></param>
            public static implicit operator TValue(StkId stkId)
            {
                return stkId.stack[stkId.index];
            }

            public static bool operator <(StkId l, StkId r)
            {
                return Object.ReferenceEquals(l.stack, r.stack) && l.index < r.index;
            }

            public static bool operator >(StkId l, StkId r)
            {
                return Object.ReferenceEquals(l.stack, r.stack) && l.index > r.index;
            }

            public static bool operator <=(StkId l, StkId r)
            {
                return Object.ReferenceEquals(l.stack, r.stack) && l.index <= r.index;
            }

            public static bool operator >=(StkId l, StkId r)
            {
                return Object.ReferenceEquals(l.stack, r.stack) && l.index >= r.index;
            }
        }
    }
}
