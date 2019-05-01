'''反汇编
每次执行该脚本，lua源代码，简单汇编和完整汇编的代码会被整合输出到compile_out目录下名为对应时间戳的文件中

chunkspy.file 反汇编程序
learn.file 被反汇编的lua代码
lua_asm.txt 简单汇编，输出的汇编代码，仅包含指令字节码
exe_out_asm.txt 完整汇编，输出的预编译代码的反汇编代码，包含编译输出的所有信息
luac.out 编译生成的临时文件

编译lua源代码

* 每个测试的源文本有一个路径
* 整合的反汇编信息留在这个项目
* 二进制chunk送到zlua的测试目录
* 生成c#测试函数
* 指定是文件还是字符串，暂时只管字符串

指定路径标识，编译源文本，并输出到文件

编译空串，字符串的空串测试函数的空串测试语句
complie("", "string/empty/empty")

编译文件，路径

'''
import os
import datetime
import re
from collections import defaultdict, namedtuple
from pprint import pprint
from shutil import copyfile

zlua_chunk_base_path = '../../../zlua/data/chunk/'


def compile(lua_code: str, path: str):
    # 将源文本写入文件
    with open('learn.lua', 'w') as f:
        f.write(lua_code)
    # 用官方lua编译该文件成汇编代码
    os.system("luac learn.lua")
    os.system("lua chunkspy.lua luac.out learn.lua --brief > lua_asm.txt")
    os.system("luac learn.lua")
    os.system("lua chunkspy.lua luac.out learn.lua > exe_out_asm.txt")
    # 将luac.out复制到zlua输出路径
    output_path = '{zlua_chunk_base_path}{path}.out'.format(zlua_chunk_base_path=zlua_chunk_base_path, path=path)
    if not os.path.exists(os.path.dirname(output_path)):
        os.makedirs(os.path.dirname(output_path))
    copyfile('luac.out', output_path)

    # 整合写入文件
    output_base = r'../../compile_out/'
    # time_stamp = str(datetime.datetime.now()).replace(':', '-')
    output_path = '{output_base}{path}.lua'.format(output_base=output_base, path=path)
    if not os.path.exists(os.path.dirname(output_path)):
        os.makedirs(os.path.dirname(output_path))
    with open(output_path, 'w') as out:
        with open('learn.lua', 'r') as in3, \
                open('lua_asm.txt', 'r') as in1, \
                open('exe_out_asm.txt', 'r') as in2:
            out.write('-' * 30 + '\n')
            for i in in3:
                out.write(i)
            out.write('\n' + '-' * 30 + '\n')
            for i in in1:
                print(i, end='')
                out.write(i)
            out.write('\n' + '-' * 30 + '\n')
            for i in in2:
                out.write(i)


# cs string test
css = {}


def join(l): return ''.join(l)


def method_def(access, ret_type, method, parlist, code: list):
    return ['{access} {ret_type} {method}({parlist})\n'.format(
        access=access,
        ret_type=ret_type,
        method=method,
        parlist=','.join(parlist))
           ] + \
           ['{\n'] + \
           tab(code) + \
           ['}\n']


def test_method_attribute(code):
    return attribute('[TestMethod()]', code)


def method_call(o, func, arglist):
    # 静态方法也可
    return o + '.' + func + '(' + ','.join(arglist) + ');\n'


def attribute(attribute, code):
    return [attribute + '\n'] + \
           code


def string(s): return '"' + s.replace('\n', '\\n').replace('"', '\\"') + '"'


def r_comment(comment, s):
    # 空comment被忽略
    return s.rstrip() + '  // ' + comment + '\n' if comment else s


def newline(code: list): code.append('\n')


def tab(code: list): return ['\t' + line for line in code]


def using(namespaces: list, code): return ['using ' + namespace + ';\n' for namespace in namespaces] + code


def namespace(namespace, code):
    return ['namespace ' + namespace,
            '{\n'] + \
           tab(code) + \
           ['}\n']


def _class(access, _class, code):
    return ['public class ' + _class + '\n',
            '{\n'] + \
           tab(code) + \
           ['}\n']


# 代表一条string test
TestS = namedtuple('TestS', [
    'lua_code',
    'path',
    'comment'
])


# TODO base不应该重复，否则会被替换掉，必须使用setlist0，setlist1
def gs(lua_code: str, path: str, comment=''):
    compile(lua_code, 'string/' + path)
    # 字符串的空串测试函数的空串测试语句
    _dir, base = os.path.split(path)
    if _dir not in css:
        css[_dir] = []
    css[_dir].append(TestS(lua_code, 'string/' + path, comment))


def gf(path: str):
    with open(path, 'r') as f:
        compile(f.read(), path)


gs('', 'empty/empty')
gs('print("Hello World!")', 'helloworld/helloworld')


def fc(s): return 'functionCall/' + s


gs("local a,b,c\n"
   "local function f() end\n"
   "local g = function() end\n", fc('closure'))
gs("local function f() end\n"
   "local a,b,c = f(1,2,3,4)", fc('call'))
gs("local a,b; return 1,a,b", fc('return'))
gs("local a,b,c,d,e = 100, ...", fc('vararg'))
# gs("local function f() end\n"
#    "return f(a,b,c)", fc('tailcall'))
# gs('''
# -- Meta class
# Shape = {area = 0}
#
# function Shape:new (o,side)
#   o = o or {}
#   setmetatable(o, self)
#   self.__index = self
#   side = side or 0
#   self.area = side*side;
#   return o
# end
#
# function Shape:printArea ()
#   print(self.area)
# end
#
# myshape = Shape:new(nil,10)
#
# myshape:printArea()
#
# ''', fc('self'))


def t(s): return 'table/' + s

# 《Lua设计与实现》p72+ 优点是每个测试尽可能短小，生成我们想要测试的指令
# 《自己动手实现Lua》正文里的例子是没法运行的
#
# 源文本里有字符串的，用python的三点字符串，并加上r
# 用r就没法用\n了
# 不用r引号带转义很难复制到其他地方实验

gs('local p = {}', t('newtable'))
gs('local p = {1,2}',t('setlist'))
gs(r'local p = {["a"]=1}',t('settable'))
gs(r'''
local a = "a"
local p = {[a]=1}
''',t('settable1'))
gs(r'''
local p = {["a"]=1}
local b = p["a"]''', t('gettable'))
# gs("t = {1,2,f()}", t('setlist1'), '结尾是函数调用或vararg')

code = []
for k, v in css.items():
    code += test_method_attribute(method_def(
        access='public',
        ret_type='void',
        method=k + 'ChunkTest',
        parlist=[],
        code=[r_comment(i.comment,
                        method_call('TestTool', 't00', [string(i.path)])) for i in v]
    ))
    newline(code)
    code += test_method_attribute(method_def(
        access='public',
        ret_type='void',
        method=k + 'Test',
        parlist=[],
        code=[r_comment(i.comment, method_call('TestTool', 't01', [string(i.lua_code)])) for i in v]
    ))
    newline(code)

code = using(['Microsoft.VisualStudio.TestTools.UnitTesting', 'zluaTests'],
             namespace('zlua.Core.VirtualMachine.Tests',
                       attribute('[TestClass()]',
                                 _class('public', 'lua_StateTests', code))))
with open(r'..\..\..\zlua\projects\zluaTests\Core\VirtualMachine\lua_StateTests.cs', 'w') as f:
    f.write(join(code))
