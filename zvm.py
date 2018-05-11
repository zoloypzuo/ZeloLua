"""
zvm takes _exe.json as input and execute it

stages:
1. load tables to runtime table classes
2. vm loop:
    1. fetch a line of instruction
    2. decode it to operator and operands
    3. execute it

label is used for "while, if" in script, jump to label that is out of curr func is not allowed
TODO 设计一个debugger，coroutine可能有用，可能累赘。总之，不允许太扰乱主体运行，最好提供一个单独的callback实现debugger
TODO vm detach asm，asm停止开发，vm直接接受数据结构进行执行
"""

from ISA import ISA
from re import match
from zasm import *
from collections import namedtuple

import pickle


class RuntimeFunc:

    def __init__(self, func: Function):
        self.func = func
        self.ret_addr = None  # None if _Main
        self.local_data = {}  # _Main's local_data is global data
        # self.args = []  # args for call another func
        # self.ret_val = None
        self.stack = []  # "stack-based vm"


class Thread:

    def __init__(self, main_func):
        self.main_func = main_func

        self.isa = ISA()
        self.stack = []  # {list<FuncNode>}
        self.global_data = {}  # {var_name:val,...}

        rt_main_func = RuntimeFunc(self.main_func)
        self.global_data = rt_main_func.local_data
        self.stack.append(rt_main_func)

    @property
    def curr_func(self) -> RuntimeFunc:
        return self.stack[-1]

    def run(self):
        self.pc = 0
        while True:
            # yield None
            self.current_instr = self.curr_func.func.instrs[self.pc]
            self.execute(self.current_instr.operator, *self.current_instr.operands)
            self.pc += 1

    # def parse_value(self, lexeme: str):
    #     '''parse lexeme to rvalue'''
    #     if False:
    #         pass
    #     elif lexeme == 'nil':
    #         return None  # map lua nil to py None
    #     elif lexeme == 'true':
    #         return True
    #     elif lexeme == 'false':
    #         return False
    #     elif match(self.isa.lex_grammar['var'], lexeme):
    #         return self.curr_func.local_data[lexeme]
    #     elif match(self.isa.lex_grammar['str'], lexeme):
    #         return lexeme.strip('\"')
    #     elif match(self.isa.lex_grammar['float'], lexeme):
    #         return float(lexeme)
    #
    #     else:
    #         return int(lexeme)

    def execute(self, operator, *operands):
        '''
        execute an instr
        :param operator: eg. 'Mov'
        :param operands: eg. ('Var',16), () if no operands
        :return:
        '''
        getattr(self, operator)(*operands)

    def mov(self, *operands):
        # self.curr_func.local_data[operands[0]] = self.parse_value(operands[1])
        var=operands[0]
        self.curr_func.local_data[var]=self.pop()

    # def setglobal(self, *operands):
    #     self.global_data[operands[0]] = self.parse_value(operands[1])

    def closure(self, *operands):
        rt_func = RuntimeFunc(self.curr_func.func.inner_funcs[int(operands[0])])
        # self.curr_func.local_data['.t'] = rt_func
        self.push(rt_func)

    def call(self, *operands):
        callee:RuntimeFunc = self.curr_func.local_data[operands[0]]
        callee.ret_addr = self.pc
        # pass params
        for i in range(len(callee.func.param_names)):
            callee.local_data[callee.func.param_names[i]] = self.pop()
        self.stack.append(callee)
        self.pc = -1  # -1 is tricky, pc will increment after execute

    def ret(self, *operands):
        if self.curr_func.ret_addr == None:
            exit('Return from _Main, Process executed')
        self.pc = self.curr_func.ret_addr
        ret_val = self.pop()
        self.stack.pop()
        self.push(ret_val)

    def add(self, *operands):
        # self.curr_func.local_data[operands[0]] = sum(
        #     map(self.parse_value, operands[1:]))  # tricky, add C A B: C=A+B, ...
        a0 = self.pop()
        a1 = self.pop()
        self.push(a0 + a1)

    def load(self, path):
        '''load exe from path'''
        with open(path, 'rb') as f:
            return pickle.load(f)

    def push(self, *operands):
        self.curr_func.stack.append(operands[0])

    def pop(self):
        return self.curr_func.stack.pop()

    def mul(self, *operands):
        a0 = self.curr_func.stack.pop()
        a1 = self.curr_func.stack.pop()
        self.push(a0 * a1)

    def eq(self,*operands):
        a0=self.curr_func.stack.pop()
        a1=self.curr_func.stack.pop()
        self.push(a0==a1)
    def _and(self,*operands):
        a0=self.curr_func.stack.pop()
        a1=self.curr_func.stack.pop()
        self.push(a0 and a1)
    def push_var(self,*operands):
        var=operands[0]
        value=self.curr_func.local_data[var]
        self.push(value)

if __name__ == '__main__': pass
# p1 = Thread('1-assign_exe.json')
# rtp1=p1.run()
# p2 = Thread('2-call func_exe.json')
# rtp2=p2.run()
# # while True:
# #     next(rtp1)
# while True:
#     next(rtp2)
