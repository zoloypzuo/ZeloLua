﻿// zlua v0.1 基于 clua5.3
//

// lua解释器

using System;
using System.IO;
using zlua.Compiler.CodeGenerator;
using zlua.Compiler.Lexer;
using zlua.Compiler.Parser;
using zlua.Core.Instruction;
using zlua.Core.ObjectModel;
using zlua.Core.Undumper;

namespace zlua.Core.VirtualMachine
{


    // 见鬼了异常，因为有些分支根本不可能走到，用于占位
    internal class GodDamnException : Exception
    { }

    // 错误的操作数类型，我们用opcode作为提示
    internal class OprdTypeException : Exception
    {
        public OprdTypeException(Opcode opcode) : base(opcode.ToString() + "错误的操作数")
        {
        }
    }

    /// lua接口
    public partial class LuaState
    {
        public const string Version = "zlua v0.1 based on clua5.3";

        /* option for multiple returns in 'lua_pcall' and 'lua_call' */
        public const int LUA_MULTRET = -1;

        // luaL_dofile
        //
        // 《Lua设计与实现》p39
        public void dofile(string path)
        {
            loadfile(path);
            Call(0);
        }

        // luaL_loadfile
        public void loadfile(string path)
        {
            Proto p;
            using (var f = new FileStream(path, FileMode.Open)) {
                // TODO check and throw file open error
                char c = (char)f.ReadByte();
                // reset stream
                f.Position = 0;
                if (c == luaU.FirstChar) {
                    p = luaU.Undump(f);
                } else {
                    // TODO parse
                    p = null;
                }
            }
            LuaClosure cl = new LuaClosure(null, 1, p);
            if (p.Upvalues.Length > 0) {
                var env = new TTable(1, 1);
                env.Set(this, new LuaValue("print")).Cl = new CSharpClosure()
                {
                    f = (L) =>
                    {
                        var s = L.stack.pop();
                        Console.WriteLine(s.Str);
                    }
                };
                cl.upvals.Add(new Upvalue()
                {
                    val = new LuaValue(env)
                });
            }
            stack.push(new LuaValue(cl));
        }

        public void dostring(string luaCode)
        {
            // * 编译源文本生成Proto实例tf
            // * 使用tf构造Closure实例cl
            // * 初始化cl的upval
            // * 将cl压栈
            // * 调用Call方法执行cl
            LuaLexer lexer = new LuaLexer(luaCode, "");
            TokenStream tokenStream = new TokenStream(lexer);
            LuaParser parser = new LuaParser(tokenStream);
            LuaVisitor visitor = new LuaVisitor();
            visitor.Visit_block(parser.ParseChunk());
            // TODO 规范api，block上创建visit chunk方法
            // TODO 从visitor取得proto
            // 我还是愿意创建chunkproto这个类
            // 拿到后压栈
            Call(0);
        }

        /// 注册一个C#函数，在lua代码中用name调用
        /// 被调用函数被包装成closure，在G中，key是`name
        /// no upval，你要自己设置（永远用不到）
        public void Register(CSharpFunction csFunc, string name)
        {
            var newFunc = new CSharpClosure() { f = csFunc };
            GlobalsTable.Table.GetByStr((TString)name).Cl = newFunc;
        }

        /// 基于L.top，压函数，压args，返回1个值
        public delegate void CSharpFunction(LuaState L);
    }
}