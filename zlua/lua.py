'''一些全局信息，整个lua的API'''
from antlr4 import *
from functools import partial

from gen.zlua.LuaLexer import LuaLexer
from gen.zlua.LuaParser import LuaParser
from zlua.compiler import LuaCompiler
from zlua.type_model import Table
from zlua.vm import LuaThread, LuaClosure, CallInfo

__version__ = 'zlua based on lua 5.1.4'


def new_thread(*libs):
    thread = LuaThread()

    def lua_assert(b):
        assert b

    std_base_lib = {
        'assert': lua_assert,
        'setmetatable': lambda t, mt: t.set_metatable(mt),
        'dofile': partial(do_file, thread=thread),  # 这个dict写在函数里就是为了这个partial需要参数
        'dostring': partial(do_string, thread=thread),
        'print': print,
        'type': type,
        'tostring': str,
        'tonumber': float,  # TODO 再想想
    }
    s = Table([], {'format': lambda s, *args: s.format(*args)})
    g = Table([], thread.globals)
    thread.load_lib(std_base_lib)
    thread.load_lib({'str': s})
    thread.load_lib({'_G': g})
    list(map(thread.load_lib, libs))
    return thread


def _do_input(input, thread: LuaThread):
    lexer = LuaLexer(input)
    stream = CommonTokenStream(lexer)
    parser = LuaParser(stream)
    tree = parser.chunk()
    compiler = LuaCompiler()
    compiler.visit(tree)
    lc = LuaClosure(compiler.chunk_proto)
    thread.pc = 0  # 调用新函数，指针清零
    thread.ci_stack.append(CallInfo(lc))
    thread.execute()


def do_file(path: str, thread: LuaThread = None):
    thread = thread or new_thread()
    input = FileStream(path, encoding='utf-8')
    _do_input(input, thread)


def do_string(lua_code: str, thread: LuaThread = None):
    thread = thread or new_thread()
    input = InputStream(lua_code)
    _do_input(input, thread)
