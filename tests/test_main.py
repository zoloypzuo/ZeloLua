from unittest import TestCase
import unittest
from zlua.lua import do_string, do_file
from zlua.vm import LuaValueError


class Test(TestCase):
    def test_exp(self):
        do_string('local a=nil -- 安抚')
        do_string('local a=false')
        do_string('local a=true')
        do_string('local a=1.1')
        do_string('local a="s"')
        # test_prefixexp
        # test table ctor
        do_string('local a=2^3')
        do_string('local a=not true')
        do_string('local a=#{1,2,3}')
        do_string('local a=1; local b=-a')
        do_string('local a=1+2')
        do_string('local a=1*2')
        do_string('local a=1-2')
        do_string('local a=1/2')
        do_string('local a="hello".."world"')
        # test relation op

    def test_basic_stat(self):
        do_string('local a,b,c=1,2,3')
        do_string('a=1')
        do_string('local a={}; a.t1="val1";a["t2"]="val2"')

    def test_func_def(self):
        do_string(
            'local t={["obj"]={}}; function t.obj:m() end')  # => get_lug 't'; push_l 'obj'; get_table; push_l 'm'; closure 0; set_table
        do_string('local t={}; function t.f() end')  # table's func; => get_lug 't'; push_l 'f'; closure 0; set_table
        do_string('local a=function (a,b) local c=a+b return c end')

    def test_table_ctor(self):
        do_string('local a={1,2,3}')
        do_string('local a={["keya"]="vala"}')

    def test_func_call(self):
        do_string('local function f() do return 1 end end; f(); f();')
        do_string('local function f() end; local ret=f()')
        do_string('print "hello"')

    def test_relation_op(self):
        do_string('local a=(1+1==2)')
        do_string('local a=(1+1~=2)')
        do_string('local a=(1<2)')
        do_string('local a=(1<=2)')
        do_string('local a=(1>2)')
        do_string('local a=(1>=2)')
        do_string('local a=true and false; assert(a==false)')
        do_string('local a=false and true; assert(a==false)')
        do_string('local a=true or false')
        do_string('local a=false or false')
        do_string('assert((nil or "alo") == "alo")')

        do_string('assert(1+1==2)')
        do_string('local a=1;local b=2;assert(a+b==3);')

    def test_ctrl_flow(self):
        do_string('while false do end')  # while false
        do_string('if true then elseif false then else end')  # if true
        do_string('if false then elseif true then else end')  # elseif true
        do_string('if false then elseif false then else end')  # else true
        do_string('if false then end')  # nothing
        do_string('if false then elseif false then end')  # no else
        do_string('if false then else end')  # not elseif
        do_string('for i=1,2 do print(i) end')
        do_string('for i=1,2,1 do print(i) end')  # => 1,2
        do_string('for i=1,5,3 do print(i) end')  # => 1,4
        do_string('for i=-5,5,1 do print("i:", i) end')  # => -5, ... ,5
        self.assertRaises(LuaValueError, do_string, 'for i=5,-5,-2 do print(i) end')  # => 5, 3, 1, -1, -3, -5，不实现
        do_string('for k,v in {["key1"]="val1",["key2"]="val2"} do print(k,v) end')
        do_string('''
                local a = {}
                for i = -1, 1, 1 do
                    --print(i)
                    a[i] = i;
                end
                --a[10e30] = "alo";
                --print(a)
                for i = -1, 1, 1 do
                    --print('i:',i,'a[i]:',a[i])
                    assert(a[i] == i);
                end''')
        do_string('''
                local res = 1
                local function fact (n)
                    if n == 0 then
                        return res
                    else
                        return n * fact(n - 1)
                    end
                end
                fact(5)
                assert(fact(5) == 120)''')

    def test_mt(self):
        pass

    # region 更加严格的测试，测试行为的正确性；使用官方测试文件
    def test_upval(self):
        do_string('local a=1;local function f() return a end;a=2;assert(f()==2)')
        do_string('''
            function f(a)
                  local b=3
                  return function(b)
                      return a+b
                    end
                end
            print(f(1)(2))
            assert(f(1)(2)==3)''')

    def test_error(self):
        '''https://python3-cookbook.readthedocs.io/zh_CN/latest/c14/p03_testing_for_exceptional_conditions_in_unit_tests.html'''
        self.assertRaises(SyntaxError, do_string, 'local a=(')
        self.assertRaises(Exception, do_string, 'local f=function (a) return a end; f(1,2);')

    def test_scope(self):
        do_string('''
            do local i=1 end
            do local i1=1 end
            do local i2=1 end
            ''')
        self.assertRaises(Exception, do_string, '''
                local i;
                do
                    local i
                end
            ''')

    def test_formal(self):
        '''TODO 1. 因为你修改了语法，无法兼容 a,b=1,2 2.标准库还没上。 3.他的文件都有语法文件和编码问题'''
        import sys,os
        print(os.path.abspath('.'))
        do_file('test.lua')
        do_file('calls.lua')
        do_file('constructs.lua')
    # endregion


if __name__ == '__main__':
    unittest.main()
