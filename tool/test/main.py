'''
# 自动生成测试系统

## compile函数

compile函数使用以下文件
* chunkspy.file 反汇编程序
* learn.file 被反汇编的lua代码
* lua_asm.txt 简单汇编，输出的汇编代码，仅包含指令字节码
* exe_out_asm.txt 完整汇编，输出的预编译代码的反汇编代码，包含编译输出的所有信息
* luac.out 编译生成的临时文件

## 自动生成测试

* 每个测试的源文本有一个路径
  * 对于dostring，路径要自己制定
  * 对于dofile，源文件本身有路径
* 编译生成的反汇编信息被存储在这个项目的compile_out目录下
* 二进制chunk被送到zlua的测试数据目录下
* 自动生成c#测试函数，并将整个cs文件复制到zlua项目对应位置中


## 编写测试

* 测试的数据来源很多，现阶段主要以《Lua设计与实现为主》
* 它的优点是每个测试尽可能短小，生成我们想要测试的指令
* 《自己动手实现Lua》正文里的例子是没法运行的
* 我们从第6章开始慢慢照着书编写测试
* 编写测试时注意python的字符串语法
  * 源文本里有字符串的，用python的三点字符串，并加上r
  * 用r就没法用\n了
  * 不用r引号带转义很难复制到其他地方实验
* 《Lua设计与实现》代号SS，《自己动手实现Lua》代号ZD
* 测试路径使用驼峰命名
* 测试注释添加SS的页数，因为运行测试时需要参考书的内容
'''
import os
from collections import namedtuple
from shutil import copyfile
from tool.csharp import attribute, method_def, r_comment, method_call, string, newline, csharp, using, namespace, _class
from tool.util import join, write_all, make_dirs, path2id, list_files

# region app

zlua_chunk_base_path = '../../../zlua/data/chunk/'
output_base = 'compile_out/'
zlua_test_code_path = r'..\..\..\zlua\projects\zluaTests\ZoloLua\Core\VirtualMachine\lua_StateTests.cs'

# 代表一条string test
TestString = namedtuple(
    'TestS',
    [
        'lua_code',
        'path',
        'comment'
    ])

# 路径集合，用来避免重复
path_set = set()

string_tests = {}

file_tests = {}


def test_method_attribute(code):
    return attribute('[TestMethod()]', code)


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
    output_path = '{zlua_chunk_base_path}{path}.out'.format(
        zlua_chunk_base_path=zlua_chunk_base_path, path=path)
    make_dirs(output_path)
    copyfile('luac.out', output_path)

    # 整合写入文件
    # time_stamp = str(datetime.datetime.now()).replace(':', '-')
    output_path = '{output_base}{path}.lua'.format(output_base=output_base, path=path)
    make_dirs(output_path)
    with open(output_path, 'w') as out:
        with open('learn.lua', 'r') as in3, \
                open('lua_asm.txt', 'r') as in1, \
                open('exe_out_asm.txt', 'r') as in2:
            out.write('-' * 30 + '\n')
            for i in in3:
                out.write(i)
            out.write('\n' + '-' * 30 + '\n')
            for i in in1:
                out.write(i)
            out.write('\n' + '-' * 30 + '\n')
            for i in in2:
                out.write(i)


# 两个API函数，用于生成dostring和dofile测试
def gs(lua_code: str, path: str, comment=''):
    string_path = 'string/' + path
    assert string_path not in path_set, \
        "base不应该重复，否则会被替换掉，必须使用setlist0，setlist1，避免重复"
    path_set.add(string_path)
    compile(lua_code, string_path)
    # 字符串的空串测试函数的空串测试语句
    _dir, base = os.path.split(path)
    if _dir not in string_tests:
        string_tests[_dir] = []
    string_tests[_dir].append(TestString(lua_code, string_path, comment))


def gf(path: str):
    _path = path.rstrip('.lua')
    with open(path, 'r') as f:
        compile(f.read(), _path)
    _dir, base = os.path.split(_path)
    if _dir not in file_tests:
        file_tests[_dir] = []
    file_tests[_dir].append(base)


# endregion

# region 测试字符串

'''空串和hello world'''

gs('', 'empty/empty')
gs('print("Hello World!")', 'helloWorld/helloWorld')


def ass(s):
    '''赋值类指令'''
    return 'assign/' + s


gs('''
local a = 10
local b = a
''', ass('localAssign'), comment='SS p68')
gs('''
a = 10
local b = a''', ass('global'), comment='SS p70')


def t(s):
    '''表'''
    return 'table/' + s


gs('local p = {}', t('newtable'), 'SS p72')
gs('local p = {1,2}', t('setlist'), 'SS p74')
gs(r'local p = {["a"]=1}', t('settable'), 'SS p77')
gs(r'''
local a = "a"
local p = {[a]=1}
''', t('settable1'), 'SS p78')
gs(r'''
local p = {["a"]=1}
local b = p["a"]''', t('gettable'), 'SS p79')
# gs("t = {1,2,f()}", t('setlist1'), '结尾是函数调用或vararg')

'''函数定义'''


def fd(s): return 'functionDef/' + s


gs('''
function test()
end''', fd('simplest'), 'SS p90')
gs('''
function f(a, b, c)
end''', fd('parameter'), 'SS p93')
gs('''
local a,b,c
local function f() end
local g = function() end''', fd('closure'))

'''函数调用'''


def fc(s): return 'functionCall/' + s


gs('print("a")', fc('simplest'), 'SS p95')


# gs('''
# local function f() end
# local a,b,c = f(1,2,3,4)''', fc('call'))
# gs("local a,b; return 1,a,b", fc('return'))
# gs("local a,b,c,d,e = 100, ...", fc('vararg'))

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

def fr(s):
    '''函数返回'''
    return 'functionReturn/' + s


def rel(s):
    '''关系逻辑类指令'''
    return 'relationOp/' + s


gs('''
local a,b,c
c = a == b''', rel('foo'), 'SS p115')
gs('''
local a,b,c
c = a and b''', rel('and'), 'SS p118')


def loop(s):
    '''循环类指令'''
    return 'loop/' + s


gs('local a = 0; for i = 1, 100, 5 do a = a + i end;', loop('foo'), 'SS p124')


# gs('for k,v in pairs(t) do print(k,v) end')  TODO 在zlua导入pairs函数

# endregion

# region 测试文件

def gen(path):
    for f in list_files(path):
        gf(f)


# gen('file/luago-book/ch02')
# gen('file/luago-book/ch04')
# gen('file/luago-book/ch05')
# gen('file/luago-book/ch06')
# gen('file/luago-book/ch07')

# endregion

# region main

code = []
for k, v in string_tests.items():
    code += test_method_attribute(
        method_def(
            access='public',
            ret_type='void',
            method=k + 'ChunkTest',
            parlist=[],
            code=[r_comment(i.comment, method_call('TestTool', 't00', [string(i.path)]))
                  for i in v]
        ))
    newline(code)
    code += test_method_attribute(
        method_def(
            access='public',
            ret_type='void',
            method=k + 'Test',
            parlist=[],
            code=[r_comment(i.comment, method_call('TestTool', 't01', [string(i.lua_code)]))
                  for i in v]
        ))
    newline(code)

for k, v in file_tests.items():
    code += test_method_attribute(
        method_def(
            access='public',
            ret_type='void',
            method=path2id(k) + 'ChunkTest',
            parlist=[],
            code=[method_call('TestTool', 't00', [string(k + '/' + i)])
                  for i in v]
        )
    )
    newline(code)
    code += test_method_attribute(
        method_def(
            access='public',
            ret_type='void',
            method=path2id(k) + 'Test',
            parlist=[],
            code=[method_call('TestTool', 't02', [string(k + '/' + i)])
                  for i in v]
        )
    )
    newline(code)

all_code = \
    csharp(
        using([
            'Microsoft.VisualStudio.TestTools.UnitTesting',
        ]) + \
        ['\n'] + \
        namespace('ZoloLua.Core.VirtualMachine.Tests',
                  attribute('[TestClass()]',
                            _class('public', 'lvmTests', code))))

write_all(zlua_test_code_path, join(all_code))
# endregion
