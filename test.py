from unittest import TestCase
import unittest
from lua import do_string


class Test(TestCase):
    def test_local_assign(self):
        do_string('local a,b,c=1,2,3')

    def test_exp(self):
        do_string('local a=nil')
        do_string('local a=false')
        do_string('local a=true')
        do_string('local a=1.1')
        do_string('local a="s"')
        # do_string('local a=function (a,b) local c=a+b return c end') TODO
        # test_prefixexp
        # do_string('local a={1,2,3}') TODO
        # do_string('local a={["keya"]="vala"}') TODO
        do_string('local a=2^3')
        do_string('local a=not true')
        # do_string('local a=#{1,2,3}') TODO
        do_string('local a=1; local b=-a')  # TODO prefixexp
        do_string('local a=1+2')
        do_string('local a=1*2')
        do_string('local a=1-2')
        do_string('local a=1/2')
        do_string('local a=1')
        # do_string('local a=(1+1==2)') TODO暂时不知道怎么决定
        # do_string('local a=(1<2)')
        # do_string('local a=(1<=2)')
        # do_string('local a=(1>2)')
        # do_string('local a=(1>=2)')
        # do_string('local a=true and false')
        # do_string('local a=false and true')
        # do_string('local a=true or false')
        # do_string('local a=false or false')

    # def test_stat(self):
        # do_string('a,b,c=1,2,3')
        # do_string('local function f() return 1 end; f()')
        # do_string('')

    def test_relation_op(self):
        do_string('assert(1+1==2)')
        do_string('local a=1;local b=2;assert(a+b==3);')


if __name__ == '__main__':
    unittest.main()
