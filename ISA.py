'''
ISA manual:
规范：ISA应该给出接口性的描述
primitive type:
1. int
2. float
3. str
4. {str} id: var and func

instr format:
1. move A B   : A=B
2. setglobal A B : A=B

closure A : .t = closure(inner_funcs[A]) # .t is special tmp var, the closure instr must be followed by a move or setglobal instr
call A : A() # len(args) is strictly equal to len(callee.params); caller.args should be filled before
return :  # only one ret val; callee.ret_vals should be filled before

load_arg A: curr_func.args.append(A)
load_ret_val A:curr_func.ret_vals.append(A)


add C A B : C=A+B

nop : do nothing

ps:
1. note that if a id can be found is not checked, which is a runtime error
2. except set/get global's destination/source operand, other operand id must be local variable, or it will raise a runtime error
'''
from  re import match

class Instr:

    def __init__(self, operator):
        self.operator = ''#TODO
        self.operand_types = []
class ISA():
    '''the ISA, include a extra instr format verification function'''
    def __init__(self):
        self.grammar = {
            'var': r'\.?[_a-zA-Z]\w*',
            'literal': '|'.join([r'([+-]?\d+)', r'([+-]?\d*\.\d+)', r'(\".*\")']),#int, float, str
            'func': r'\.?[_a-zA-Z]\w*',
            'label': r'\.?[_a-zA-Z]\w*',
            'index':r'\d+'
        }
        rvalue=['var','literal']
        self.instrs={
            'mov':['var',rvalue],  # either var is local
            'setglobal':['var',rvalue], #dest var is global, source var is local
            'return':[],
            'closure':['index'],
            'call':['func'],
            'load_arg':rvalue,
            'load_ret_val':rvalue,
            'add':['var',rvalue,rvalue],
            'nop':[]
        }
    def verify(self,operator:str,operands:list):
        '''verify a instr, if a id can be found is not checked, which is a runtime error'''
        # eg. [setglobal, a, 10]
        format=self.instrs[operator]#eg.['var',['var','literal']]
        for i in range(len(operands)):
            operand=operands[i]
            format_for_the_operand=format[i]
            if isinstance(format_for_the_operand,list):#eg. ['var','literal']
                # res=[]
                # for i in format_for_the_operand:
                #     pat=self.grammar[i] #eg. r'[_a-zA-Z]\w*'
                #     res.append(match(pat,operand))
                # assert any(res)
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