'''一些全局信息，整个lua的API'''
from antlr4 import *
from gen.zlua.LuaLexer import LuaLexer
from gen.zlua.LuaParser import LuaParser
from compiler import LuaCompiler
from vm import LuaThread, LuaClosure

__version__ = 'zlua based on lua 5.1.4'


def do_file(path: str, thread: LuaThread = None):
    thread = thread or LuaThread()
    input = FileStream(path)
    lexer = LuaLexer(input)
    stream = CommonTokenStream(lexer)
    parser = LuaParser(stream)
    tree = parser.chunk()
    compiler = LuaCompiler()
    compiler.visit(tree)
    lc = LuaClosure(compiler.chunk_proto)
    if thread.frame_stack:
        thread.curr_cl.saved_pc = thread.pc
    thread.load_lib(std_base_lib)
    thread.pc = 0  # 调用新函数，指针清零
    thread.frame_stack.append(lc)
    thread.execute()


def do_string(lua_code: str, thread: LuaThread = None):
    '''主要用这个测试短小的lua代码；默认新开一个thread'''
    thread = thread or LuaThread()
    input = InputStream(lua_code)
    lexer = LuaLexer(input)
    stream = CommonTokenStream(lexer)
    parser = LuaParser(stream)
    tree = parser.chunk()
    compiler = LuaCompiler()
    compiler.visit(tree)
    lc = LuaClosure(compiler.chunk_proto)
    # 有点复杂，思考过的，chunk签名形如void chunk(){}，因此不需要传参数和返回值
    # 但是提出来这件事的重要原因是调用chunk的逻辑必须是单独的，不可能和其他lua closure共用call函数
    # do string有两种情况，一是什么都没有，二是已经加载了lua代码，内部元编程加载新代码，后者要保存指针，就像一般的调用一样
    # 而且要用if判断，否则null reference
    # 要理解execute的功能：就是状态机的转换动作，而且是靠指令来行动的，你要给他准备正确的pc和栈帧，仅此而且，它只负责loop里执行指令
    if thread.frame_stack:
        thread.curr_cl.saved_pc = thread.pc
    thread.load_lib(std_base_lib)
    thread.pc = 0  # 调用新函数，指针清零
    thread.frame_stack.append(lc)
    thread.execute()


def lua_assert(b): assert b


std_base_lib = {
    'assert': lua_assert,
    'setmetatable': lambda t, mt: t.set_metatable(mt),
    'dofile': do_file,
    'dostring': do_string,
    'print': print,
}
