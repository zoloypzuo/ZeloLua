'''一些全局信息，整个lua的API'''
from antlr4 import *
from functools import partial

from gen.zlua.LuaLexer import LuaLexer
from gen.zlua.LuaParser import LuaParser
from compiler import LuaCompiler
from vm import LuaThread, LuaClosure

__version__ = 'zlua based on lua 5.1.4'


def new_thread(*libs):
    thread = LuaThread()
    list(map(thread.load_lib, libs))
    return thread


def _do_input(input, thread):
    lexer = LuaLexer(input)
    stream = CommonTokenStream(lexer)
    parser = LuaParser(stream)
    tree = parser.chunk()
    compiler = LuaCompiler()
    compiler.visit(tree)
    lc = LuaClosure(compiler.chunk_proto)
    if thread.frame_stack:
        thread.curr_cl.saved_pc = thread.pc

    def lua_assert(b):
        assert b

    std_base_lib = {
        'assert': lua_assert,
        'setmetatable': lambda t, mt: t.set_metatable(mt),
        'dofile': partial(do_file, thread=thread),
        'dostring': partial(do_string, thread=thread),
        'print': print,
    }
    thread.load_lib(std_base_lib)
    thread.pc = 0  # 调用新函数，指针清零
    thread.frame_stack.append(lc)
    thread.execute()


def do_file(path: str, thread: LuaThread = None):
    thread = thread or LuaThread()
    input = FileStream(path, encoding='utf-8')
    _do_input(input, thread)


def do_string(lua_code: str, thread: LuaThread = None):
    thread = thread or LuaThread()
    input = InputStream(lua_code)
    _do_input(input, thread)
