'''
ISA manual:

primitive type:
1. int
2. float
3. str
4. {str} id: var and func

instr format:
1. move A B


'''
from  re import match

class Instr:

    def __init__(self, operator):
        self.operator = ''
        self.operand_types = []
class ISA():

    def __init__(self):
        self.grammar = {
            'var': r'[_a-zA-Z]\w*',
            'literal': '|'.join([r'([+-]?\d+)', r'([+-]?\d*\.\d+)', r'(\".*\")']),#int, float, str
            'func': r'[_a-zA-Z]\w*',
            'label': r'[_a-zA-Z]\w*'}
        self.instrs={
            'mov':['var',['var','literal']],  # either var is local
            'setglobal':['var',['var','literal']], #dest var is global, source var is local
            'return':[]
        }
    def verify(self,operator:str,operands:list):
        '''verify a instr'''
        # eg. [setglobal, a, 10]
        format=self.instrs[operator]#eg.['var',['var','literal']]
        for i in range(len(operands)):
            operand=operands[i]
            format_for_the_operand=format[i]
            if isinstance(format_for_the_operand,list):#eg. ['var','literal']
                res=[]
                for i in format_for_the_operand:
                    pat=self.grammar[i] #eg. r'[_a-zA-Z]\w*'
                    res.append(match(pat,operand))
                assert any(res)
                assert any([match(self.grammar[i],operand) for i in format_for_the_operand])
            else:
                pat=self.grammar[format_for_the_operand]
                assert match(pat,operand)
def test():
    isa=ISA()
    instrs=[i.split() for i in """
    setglobal a 10
	setglobal b 30.0
	setglobal c "foo"
	return
	""".split('\n') if not match('\s*$',i)] #tricky, just for correctness
    for i in instrs:
        isa.verify(i[0],i[1:])
if __name__ == '__main__':
    test()