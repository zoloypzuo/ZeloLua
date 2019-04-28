// zlua v0.1 基于 clua5.3
//
// lua解释器

using Antlr4.Runtime;

using System;
using System.IO;

using zlua.Compiler;
using zlua.Compiler.CodeGenerator;
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

    public partial class lua_State
    {
        /* option for multiple returns in 'lua_pcall' and 'lua_call' */
        public const int LUA_MULTRET = -1;

        // 《Lua设计与实现》p39
        public void luaL_dofile(string path)
        {
            luaL_loadfile(path);
            luaD_call(0, LUA_MULTRET);
        }

        public void luaL_loadfile(string path)
        {
            Proto p;
            if (IsBinaryChunk(path)) {
                p = luaU.Undump(new FileStream(path, FileMode.Open));
            } else {
                p = DoInput(new AntlrFileStream(path, System.Text.Encoding.UTF8), $"@{path}");
            }
            var env = new Table(1, 1);
            env.luaH_set(new TValue("print")).Cl = new CSharpClosure()
            {
                f = (L) =>
                {
                    var s = L.pop();
                    Console.WriteLine(s.Str);
                }
            };
            LuaClosure cl = new LuaClosure(env, 1, p);
            push(new TValue(cl));
        }

        public void dostring(string chunk)
        {
            // * 编译源文本生成Proto实例tf
            // * 使用tf构造Closure实例cl
            // * 初始化cl的upval
            // * 将cl压栈
            // * 调用Call方法执行cl
            DoInput(new AntlrInputStream(chunk), chunk);
            // TODO 规范api，block上创建visit chunk方法
            // TODO 从visitor取得proto
            // 我还是愿意创建chunkproto这个类
            // 拿到后压栈
            luaD_call(0);
        }

        /// 注册一个C#函数，在lua代码中用name调用
        /// 被调用函数被包装成closure，在G中，key是`name
        /// no upval，你要自己设置（永远用不到）
        public void Register(lua_CFunction csFunc, string name)
        {
            var newFunc = new CSharpClosure() { f = csFunc };
            gt.Table.luaH_getstr((TString)name).Cl = newFunc;
        }

        /// 基于L.top，压函数，压args，返回1个值
        public delegate void lua_CFunction(lua_State L);

        private Proto DoInput(ICharStream chunk, string chunkName)
        {
            LuaLexer lexer = new LuaLexer(chunk);
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            LuaParser parser = new LuaParser(tokenStream);
            var tree = parser.chunk();
            LuaCodeGenerator codeGenerator = new LuaCodeGenerator();
            codeGenerator.Visit(tree);
            return null;
        }

        private bool IsBinaryChunk(string path)
        {
            using (var f = new FileStream(path, FileMode.Open)) {
                // TODO check and throw file open error
                char c = (char)f.ReadByte();
                return c == luaU.FirstChar;
            }
        }
    }
}