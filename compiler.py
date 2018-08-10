'''
the compile stage part of zlua
'''
from gen.zlua.LuaParser import LuaParser
from gen.zlua.LuaVisitor import LuaVisitor
from vm import Proto


class LuaCompiler(LuaVisitor):
    def __init__(self):
        self.chunk_proto=Proto(None)
