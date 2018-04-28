from unittest import TestCase
from zasm import *

class TestAssembler(TestCase):
    def setUp(self):
        self.a=Assembler('_test/2-call func.txt')

    def test_split_punc(self):
        self.assertEqual(self.a.split_punc('a,b'), ['a', ',', 'b'])
        self.assertEqual(self.a.split_punc('label:'),['label',':'])
        self.assertEqual(self.a.split_punc('a,b,c'),['a',',','b',',','c'])
        self.assertEqual(self.a.split_punc('_Main(1,2){'),['_Main','(','1',',','2',')','{'])

    def test_lex(self):
        pass
    def test_lexeme2token(self):
        pass

    def test_handle_func(self):
        assert list(self.a.handle_func(['(','a',',','b',',','c',')']))== ['a','b','c']
        # self.assertEqual(list(self.a.handle_func(['(','a',',','b',',','c',')'])), ('a','b','c'))