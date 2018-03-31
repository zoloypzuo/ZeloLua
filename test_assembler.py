from unittest import TestCase
from zasm import *

class TestAssembler(TestCase):
    def setUp(self):
        src = format('test_0.xasm')
        self.a=Assembler(src)

    def test_split_punc(self):
        self.assertEqual(self.a.split_punc('a,b'), ['a', ',', 'b'])
        self.assertEqual(self.a.split_punc('label:'),['label',':'])
        self.assertEqual(self.a.split_punc('a,b,c'),['a',',','b',',','c'])

    def test_lex(self):
        pass
    def test_lexeme2token(self):
        pass