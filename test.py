import unittest
import xasm
from xasm import TokenType

class MyTestCase(unittest.TestCase):
    def setUp(self):
        self.lexer=xasm.Lexer()
        # self.lexer.LoadSourceFile(r"C:\Users\91018\Desktop\test_0.xasm") 无法正确加载


    def test_IsCharWhitespace(self):
        self.assertTrue(xasm.IsCharWhitespace(" "))
        self.assertTrue(xasm.IsCharWhitespace("\t"))
        self.assertFalse(xasm.IsCharWhitespace("\n"))

    def test_IsCharNumeric(self):
        self.assertTrue(xasm.IsCharNumeric("0"))
        self.assertTrue(xasm.IsCharNumeric("9"))

    def test_IsCharIdent(self):
        self.assertTrue(xasm.IsCharIdent(("0")))
        self.assertTrue(xasm.IsCharIdent(("a")))
        self.assertTrue(xasm.IsCharIdent(("A")))
        self.assertTrue(xasm.IsCharIdent(("_")))

    def load_a_instr(self,s):
        '''重置lexer，装载一条测试指令
           用于测试GetNextToken
        '''
        self.lexer.SourceCodes=[]
        self.lexer.ResetLexer()
        self.lexer.SourceCodes.append(s)
    def compare_lexemes(self,s,lexemes):
        self.load_a_instr(s)
        for i in lexemes:
            self.lexer.GetNextToken()
            self.assertEqual(self.lexer.CurrLexeme,i)

    def compare_token_type(self,s,token_types):
        self.load_a_instr(s)
        for i in token_types:
            self.assertEqual(self.lexer.CurrToken,i)

    def test_GetNextToken(self):
        s1=r'Var		Counter'
        self.compare_lexemes(s1,['VAR','COUNTER'])
        s2=r'Mov Counter, 16'
        self.compare_lexemes(s2,['MOV',"COUNTER",',','16'])
        s3=r'LoopStart0:'
        self.compare_lexemes(s3,['LOOPSTART0',':'])
        s4=r'JGE Counter, 0, LoopStart0'
        self.compare_lexemes(s4,['JGE','COUNTER',',','0',',','LOOPSTART0'])

        self.compare_token_type(s1,[TokenType.INSTR,TokenType.IDENT]) #<TokenType.INSTR: 12> != <TokenType.INVALID: 18>
        self.compare_token_type(s2,[TokenType.INSTR,TokenType.IDENT,TokenType.COMMA,TokenType.INT])
        self.compare_token_type(s3,[TokenType.IDENT,TokenType.COLON])
        self.compare_token_type(s4,[TokenType.INSTR,TokenType.IDENT,TokenType.COMMA,TokenType.INT,TokenType.COMMA,TokenType.IDENT])


        s=r'getchar dest, "src string"'#, index'
        self.compare_lexemes(s,['GETCHAR','DEST',',','\"','src string','\"'])#,',','INDEX'])



if __name__ == '__main__':
    unittest.main()
