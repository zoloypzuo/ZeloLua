// zlua v0.1 基于 clua5.3
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

    public partial class lua_State
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
            Call(0, LUA_MULTRET);
        }

        // luaL_loadfile
        public void loadfile(string path)
        {
            Proto p;
            if (IsBinaryChunk(path)) {
                p = luaU.Undump(new FileStream(path, FileMode.Open));
            } else {
                p = DoInput(File.ReadAllText(path, System.Text.Encoding.UTF8), $"@{path}");
            }
            /*
             * TODO
             	c := newLuaClosure(proto)
	            self.stack.push(c)
	            
                ????
                if len(proto.Upvalues) > 0 {
                    // table[2]
		            env := self.registry.get(LUA_RIDX_GLOBALS)
		            c.upvals[0] = &upvalue{&env}
	            }
             */
            LuaClosure cl = new LuaClosure(null, 1, p);
            if (p.Upvalues.Length > 0) {
                var env = new Table(1, 1);
                env.Set(this, new TValue("print")).Cl = new CSharpClosure()
                {
                    f = (L) =>
                    {
                        var s = L.stack.pop();
                        Console.WriteLine(s.Str);
                    }
                };
                cl.upvals.Add(new Upvalue()
                {
                    val = new TValue(env)
                });
            }
            stack.push(new TValue(cl));
        }

        public void dostring(string chunk)
        {
            // * 编译源文本生成Proto实例tf
            // * 使用tf构造Closure实例cl
            // * 初始化cl的upval
            // * 将cl压栈
            // * 调用Call方法执行cl
            DoInput(chunk, chunk);
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
        public delegate void CSharpFunction(lua_State L);


        private Proto DoInput(string chunk, string chunkName)
        {
            LuaLexer lexer = new LuaLexer(chunk, chunkName);
            TokenStream tokenStream = new TokenStream(lexer);
            LuaParser parser = new LuaParser(tokenStream);
            LuaVisitor visitor = new LuaVisitor();
            blockContext block = parser.Parse();
            visitor.Visit_block(block);
            // TODO
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