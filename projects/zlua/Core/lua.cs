﻿// zlua v0.1 基于 clua5.3
//
// 目标：
// [ ] 先看完并敲完《go lua》，细节可以不管
// [ ] 重新看《lua设计与实现》，重新看clua源代码
// [ ] 整理zlua的lua语法，语法标准是BNF，而不是antlr
// [ ] 实现BNF parser generator
// [ ] 静态代码检查，大概是测覆盖率之类，难得的机会要试试
// [ ] 性能剖析与基准测试，如前面所说，要试一试
// [ ] 异常处理怎么才是好的，是不是应该做一下本地化，
//     我觉得这样很好，vs就将错误信息本地化了，虽然大部分编程语言包括lua都是英文的
//     我觉得这是一个好的点子，所有工具都应该本地化

using System;
using zlua.Core.Instruction;

namespace zlua.Core
{
    // 见鬼了异常，因为有些分支根本不可能走到，用于占位
    internal class GodDamnException : Exception
    { }

    // 错误的操作数类型，我们用opcode作为提示
    internal class OprdTypeException : Exception
    {
        public OprdTypeException(Op opcode) : base(opcode.ToString() + "错误的操作数")
        {
        }
    }

    // lua类型枚举
    public enum LuaTypes
    {
        // 无效索引对应的值的类型
        None = -1,

        Nil,
        Boolean,
        LightUserdata,
        Number,
        String,
        Table,

        // C and Lua functions
        Function,

        Userdata,
        Thread,

        //extra tags
        Proto,

        Upval,

        // lua5.3新增的整数类型
        //
        // lobject.h line 59
        Integer = 19,
    }

    ///// lua接口
    //public static class Lua
    //{
    //    public const string Version = "zlua 1.0, based on lua 5.1.4";

    //    public static void DoFile(this TThread L, string path)
    //    {
    //        //L.LoadFile(path);
    //        LDo.Call(L, 0);
    //    }
    //    public static void DoString(this TThread L, string luaCode)
    //    {
    //        //L.LoadString(luaCode);
    //        LDo.Call(L, 0);
    //    }
    //    /// <summary>
    //    /// 注册一个C#函数，在lua代码中用name调用
    //    /// 被调用函数被包装成closure，在G中，key是`name
    //    /// no upval，你要自己设置（永远用不到）
    //    /// </summary>
    //    public static void Register(this TThread L, CSFunc csFunc, string name)
    //    {
    //        var newFunc = new CSharpClosure() { f = csFunc };
    //        ((TTable)L.globalsTable).GetByStr((TString)name).Cl = newFunc;
    //    }
    //    /// <summary>
    //    /// 基于L.top，压函数，压args，返回1个值
    //    /// </summary>
    //    /// <param name="L"></param>
    //    public delegate void CSFunc(TThread L);
    //}

    // lua浮点数类型
    //
    // 不支持配置成float
    public struct LuaNumber : IEquatable<LuaNumber>
    {
        public double Value { get; set; }

        public override bool Equals(object obj)
        {
            return obj is LuaNumber && Equals((LuaNumber)obj);
        }

        public bool Equals(LuaNumber other)
        {
            return Value == other.Value;
        }

        public override int GetHashCode()
        {
            var hashCode = -783812246;
            hashCode = hashCode * -1521134295 + base.GetHashCode();
            hashCode = hashCode * -1521134295 + Value.GetHashCode();
            return hashCode;
        }

        public override string ToString()
        {
            return Value.ToString();
        }

        public static bool operator ==(LuaNumber n1, LuaNumber n2)
        {
            return n1.Equals(n2);
        }

        public static bool operator !=(LuaNumber n1, LuaNumber n2)
        {
            return !n1.Equals(n2);
        }
    }

    // lua整数类型
    //
    // 不支持配置成比如int32
    public struct LuaInteger : IEquatable<LuaInteger>
    {
        public Int64 Value { get; set; }

        public override bool Equals(object obj)
        {
            return obj is LuaInteger && Equals((LuaInteger)obj);
        }

        public bool Equals(LuaInteger other)
        {
            return Value == other.Value;
        }

        public override int GetHashCode()
        {
            var hashCode = -783812246;
            hashCode = hashCode * -1521134295 + base.GetHashCode();
            hashCode = hashCode * -1521134295 + Value.GetHashCode();
            return hashCode;
        }

        public override string ToString()
        {
            return Value.ToString();
        }

        public static bool operator ==(LuaInteger i1, LuaInteger i2)
        {
            return i1.Equals(i2);
        }

        public static bool operator !=(LuaInteger i1, LuaInteger i2)
        {
            return !i1.Equals(i2);
        }
    }
}