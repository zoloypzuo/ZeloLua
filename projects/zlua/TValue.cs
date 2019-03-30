using System;
using zlua.Core;

namespace ZeptLua.VM
{
    public class TValue
    {
        private TTable table;

        public TValue()
        {
        }

        public TValue(TTable table)
        {
            this.table = table;
        }

        public object Type { get; internal set; }

        public static explicit operator TValue(TTable v)
        {
            throw new NotImplementedException();
        }
    }
}