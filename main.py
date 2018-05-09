from antlr4 import *
from _gen.LuaLexer import LuaLexer
from _gen.LuaParser import LuaParser
from _gen.LuaListener import LuaListener
from zvm import Thread

def dofile(path):
    '''execute .lua'''
    input=FileStream(path)
    lexer = LuaLexer(input)
    stream = CommonTokenStream(lexer)
    parser = LuaParser(stream)
    tree = parser.chunk()
    walker=ParseTreeWalker()
    listener=LuaListener()
    walker.walk(listener,tree)
    Thread(listener.main_func)


if __name__ == '__main__':
    dofile('_test/test.lua')
    # with open('_test/test.lua','r') as f:
    #     dofile(f)
