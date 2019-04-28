using System;
using System.Collections.Generic;

using zlua.Core.ObjectModel;

namespace zlua.Core.VirtualMachine
{
    /// <summary>
    /// lua栈
    /// </summary>
    /// <remarks>
    /// 注意还是要手工扩容的，用数组是不行的，用list后还得手工扩容，扩容是添加新的luaValue实例
    /// 栈索引参见p54
    /// </remarks>
    public partial class lua_State
    {
        public List<TValue> slots;

        public lua_State(int size)
        {
            slots = new List<TValue>(size);
            for (int i = 0; i < size; i++) {
                slots.Add(new TValue());
            }
            top = 0;
        }

        // 检查栈的空闲空间是否还可以容纳（推入）至少n个值，如若不然，扩容
        public void check(int n)
        {
            int free = slots.Count - top;
            for (int i = free; i < n; i++) {
                slots.Add(new TValue());
            }
        }

        // 压栈，溢出时抛出异常
        public void push(TValue val)
        {
            if (top == slots.Count) {
                throw new Exception("stack overflow");
            } else {
                slots[top] = val;
                top++;
            }
        }

        // 弹栈，若栈为空，抛出异常
        public TValue pop()
        {
            if (top < 1) {
                throw new Exception("stack underflow");
            } else {
                top--;
                var val = slots[top];
                slots[top] = new TValue();
                return val;
            }
        }

        // 转换成绝对索引，不考虑索引是否有效
        public int absIndex(int idx)
        {
            if (idx >= 0) {
                return idx;
            } else {
                return idx + top + 1;
            }
        }

        // 索引有效
        public bool isValid(int idx)
        {
            var absIdx = absIndex(idx);
            return absIdx > 0 && absIdx <= top;
        }

        // 取值，索引无效返回nil
        public TValue get(int idx)
        {
            var absIdx = absIndex(idx);
            if (absIdx > 0 && absIdx <= top) {
                return slots[absIdx - 1];
            } else {
                return new TValue();
            }
        }

        // 写值，索引无效则抛出异常
        public void set(int idx, TValue val)
        {
            var absIdx = absIndex(idx);
            if (absIdx > 0 && absIdx <= top) {
                // 比较下面两种写法
                // 作者用go object实现lua object
                // 而这里是拷贝语义，我必须拷贝而不是
                // set会在类似于lua中的a=b赋值时发生，这里当然是拷贝，两个不是一个对象
                // a=b时，如果b是引用类型，那么我调用a=1时，不影响b，所以一定是新的luaValue，拷贝而已
                // python对a=b赋值后a is b，这是怎么回事。。如果copy，是两个luaValue，id应该不同
                // 所以这个id应该是标识luaValue的引用部分的
                // 然而b=1，a=b之后a is b，所以我就想不通
                // 不管，拷贝一定是对的
                //slots[absIdx - 1] = val;
                slots[absIdx - 1].Value = val;
            } else {
                throw new Exception("invalid index");
            }
        }

        internal void reverse(int from, int to)
        {
            for (; from < to; from++, to--) {
                // swap
                var t = slots[from];
                slots[from] = slots[to];
                slots[to] = slots[from];
            }
        }
    }
}