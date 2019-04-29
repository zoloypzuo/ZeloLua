using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using zlua.Core.ObjectModel;

namespace zluaTests.Core.VirtualMachine
{
    /// <summary>
    /// 模拟指针运算
    /// </summary>
    class StkId
    {
        TValue[] stack;
        int index;

        public StkId(TValue[] stack, int index)
        {
            this.stack = stack;
            this.index = index;
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
        /// 指针解引用
        /// </summary>
        /// <param name="stkId"></param>
        public static implicit operator TValue(StkId stkId)
        {
            return stkId.stack[stkId.index];
        }
    }
}
