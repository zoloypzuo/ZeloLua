from unittest import TestCase
import unittest
from lua import do_string


class Test(TestCase):
    def test_exp(self):
        do_string('local a=nil')
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
        do_string('local a=1')
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
        do_string('local function f() return 1 end; f()')
        do_string('local function f() end; local ret=f()')

    def test_relation_op(self):
        do_string('local a=(1+1==2)')
        do_string('local a=(1+1~=2')
        do_string('local a=(1<2)')
        do_string('local a=(1<=2)')
        do_string('local a=(1>2)')
        do_string('local a=(1>=2)')
        do_string('local a=true and false')
        do_string('local a=false and true')
        do_string('local a=true or false')
        do_string('local a=false or false')

        do_string('assert(1+1==2)')
        do_string('local a=1;local b=2;assert(a+b==3);')

    def test_ctrl_flow(self):
        do_string('')

    def test_mt(self):
        '''TODO'''

    def test_with_assert(self):
        '''TODO测试行为'''


if __name__ == '__main__':
    unittest.main()
