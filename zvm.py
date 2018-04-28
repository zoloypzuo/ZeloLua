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
        self.args = []  # args for call another func
        self.ret_val = None


class Thread:

    def __init__(self, path):
        '''zvm use .json as .exe file format to init a thread'''
        # ----get tables from .json
        exe = self.load(path)
        self.main_func = exe.main_func  # TODO，exe可以重新设计一下

        self.isa = ISA()
        self.stack = []  # {list<FuncNode>}
        self.global_data = {}  # {var_name:val,...}

        rt_main_func = RuntimeFunc(self.main_func)
        rt_main_func.local_data = self.global_data
        self.stack.append(rt_main_func)

    @property
    def curr_func(self):
        return self.stack[-1]

    def run(self):
        '''run the process'''
        self.pc = 0
        while True:
            # yield None
            self.current_instr = self.curr_func.func.instrs[self.pc]
            self.execute(self.current_instr.operator, *self.current_instr.operands)
            self.pc += 1

    def parse_value(self, lexeme: str):
        '''parse lexeme to rvalue'''
        if match(r'[\.?_a-zA-Z]\w*', lexeme):  # var
            return self.curr_func.local_data[lexeme]
        else:  # literal
            if match(r'\".*\"', lexeme):
                return lexeme.strip('\"')
            elif match(r'([+-]?\d*.\d+)', lexeme):
                return float(lexeme)
            else:
                return int(lexeme)

    def execute(self, operator, *operands):
        '''
        execute an instr
        :param operator: eg. 'Mov'
        :param operands: eg. ('Var',16), () if no operands
        :return:
        '''
        getattr(self, operator)(*operands)

    def move(self, *operands):
        self.curr_func.local_data[operands[0]] = self.parse_value(operands[1])

    def setglobal(self, *operands):
        self.global_data[operands[0]] = self.parse_value(operands[1])

    def closure(self, *operands):
        rt_func = RuntimeFunc(self.curr_func.func.inner_funcs[int(operands[0])])
        self.curr_func.local_data['.t'] = rt_func

    def call(self, *operands):
        callee = self.curr_func.local_data[operands[0]]
        callee.ret_addr = self.pc
        # pass params
        for i in range(len(self.curr_func.args)):
            callee.local_data[callee.func.param_names[i]] = self.curr_func.args[i]
        self.stack.append(callee)
        self.pc = -1  # -1 is tricky, pc will increment after execute

    def ret(self, *operands):
        if self.curr_func.ret_addr == None:
            exit ('Return from _Main, Process executed')
        self.pc = self.curr_func.ret_addr
        ret_val = self.curr_func.ret_val
        self.stack.pop()
        self.curr_func.local_data['.ret_val'] = ret_val

    def load_arg(self, *operands):
        self.curr_func.args.append(self.parse_value(operands[0]))

    def load_ret_val(self, *operands):
        self.curr_func.ret_val = self.parse_value(operands[0])

    def add(self, *operands):
        self.curr_func.local_data[operands[0]] = sum(
            map(self.parse_value, operands[1:]))  # tricky, add C A B: C=A+B, ...

    def load(self, path):
        '''load exe from path'''
        with open(path, 'rb') as f:
            return pickle.load(f)


if __name__ == '__main__':
    p = Thread('1-assign_exe.json')
    p.run()
    p = Thread('2-call func_exe.json')
    p.run()
