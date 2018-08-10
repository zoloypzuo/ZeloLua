from unittest import TestCase

from lua import do_string


class Test(TestCase):
    def test_do_string(self):
        do_string('assert(1+1==2)')
        do_string('local a=1;local b=2;assert(a+b==3);')
