"""
zvm takes _exe.json as input and execute it

stages:
1. load tables to runtime table classes
2. vm loop:
    1. fetch a line of instruction
    2. decode it to operator and operands
    3. execute it

label is used for "while, if" in script, jump to label that is out of curr func is not allowed


"""

from ISA import ISA
from re import match
from zasm import *
from collections import namedtuple

import pickle
class RuntimeFunc:

    def __init__(self, func: Function):
        self.func = func
        self.ret_addr = None # None if _Main
        self.local_data = {} # _Main's local_data is global data
        self.args = []  # args for call another func
        self.ret_val = None


class Thread:

    def __init__(self, path):
        '''zvm use .json as .exe file format to init a thread'''
        # ----get tables from .json
        exe = self.load(path)
        self.main_func = exe.main_func #TODO，exe可以重新设计一下

        self.isa = ISA()
        self.stack = []  # {list<FuncNode>}
        self.global_data = {}  # {var_name:val,...}

        rt_main_func = RuntimeFunc(self.main_func)
        rt_main_func.local_data=self.global_data
        self.stack.append(rt_main_func)
        self.curr_func: RuntimeFunc = self.stack[-1] #TODO 重构成property
        # ----some flags
        # self.jump = False
        # self.is_EOF = self.curr_func.func.instrs is []

    def run(self):
        '''run the process'''
        self.pc = 0
        while True:
            # yield None
            # if self.is_EOF:
            #     break
            # self.jump = False  # reset the jump
            current_instr = self.curr_func.func.instrs[self.pc]
            self.execute(current_instr.operator, *current_instr.operands)
            self.skip_to_next_line()
            # if not self.jump:
            #     self.skip_to_next_line()
            # else:
            #     continue

    def skip_to_next_line(self):
        if self.pc >= len(self.curr_func.func.instrs) - 1:
            self.is_EOF = True
        self.pc += 1

    def execute(self, operator, *operands):
        '''

        :param operator: eg. 'Mov'
        :param operands: eg. ('Var',16), () if no operands
        :return:
        '''

        def parse_value(lexeme: str):
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

        if operator == 'mov':
            rhs = operands[1]
            rhs_value = parse_value(rhs)
            self.curr_func.local_data[operands[0]] = rhs_value
        elif operator == 'setglobal':
            rhs = operands[1]
            rhs_value = parse_value(rhs)
            self.global_data[operands[0]] = rhs_value
        elif operator == 'closure':
            rt_func = RuntimeFunc(self.curr_func.func.inner_funcs[int(operands[0])])
            self.curr_func.local_data['.t'] = rt_func
        elif operator == 'call':
            callee: RuntimeFunc = self.curr_func.local_data[operands[0]]
            callee.ret_addr=self.pc
            # pass params
            for i in range(len(self.curr_func.args)):
                callee.local_data[callee.func.param_names[i]] = self.curr_func.args[i]
            self.stack.append(callee)
            self.pc = -1 #-1 is tricky, pc will increment after exexcute
            self.curr_func = self.stack[-1]
        elif operator == 'return':
            if self.curr_func.ret_addr == None:
                exit('Return from _Main, Process executed')
            self.pc = self.curr_func.ret_addr
            ret_val = self.curr_func.ret_val
            self.stack.pop()
            self.curr_func = self.stack[-1]
            self.curr_func.local_data['.ret_val'] = ret_val
        elif operator=='load_arg':
            self.curr_func.args.append(parse_value(operands[0]))
        elif operator=='load_ret_val':#TODO 这句指令删掉，retval是局部变量
            self.curr_func.ret_val=parse_value(operands[0])
        elif operator=='add':
            i1 = operands[1]
            i2=operands[2]
            i1_val = parse_value(i1)
            i2_val=parse_value(i2)
            self.curr_func.local_data[operands[0]] = i1_val+i2_val

        # elif operator == 'Jmp':
        #     self.jump = True
        #     label_addr = self.labels[operands[0]]
        #     self.Jmp(label_addr)
        # elif operator == 'Call':
        #     func_name = operands[0]
        #     params = operands[1:]
        #     self.Call(func_name, *params)

        # elif operator == 'Print':`
        #     self.Print(*operands)
        # elif operands == 'PrintVar':
        #     self.PrintVar(*operands)
        # elif operator == 'Nop':
        #     self.Nop()

    # def Var(self, ident):
    #     self.stack[-1]().local_data[ident] = None
    #
    # def Jmp(self, label):
    #     self.pc = label
    #
    # def Print(self, *args):
    #     print(*args)
    #
    # def PrintVar(self, var_name):
    #     var_val = self.vars[(var_name, self.stack[-1]().name)]
    #     print(var_val)
    #
    # def Nop(self):
    #     pass

    # def Call(self, func_name, *params):
    #     func_info = self.funcs[func_name]  # func info from func table
    #     new_runtime_func = RuntimeFunc(func_name, self.stack[-1]().entry, func_info.entry)
    #     # ----pass params: add to local_data
    #     param_names = func_info.param_names
    #     for i in range(len(param_names)):
    #         new_runtime_func.local_data[param_names[i]] = params[i]
    #
    #     self.pc = func_info.entry  # set pc to the callee entry
    #     self.stack.append(new_runtime_func)

    def call_main(self):
        try:
            main_info = self.funcs['_Main']
            main_func = RuntimeFunc('_Main', None, main_info.entry)
            self.pc = main_info.entry
            self.stack.append(self.main_func)
        except KeyError:
            exit('Code has no _Main')

    def load(self, path):
        # import z_json
        # return z_json.load(path)
        with open(path,'rb') as f:
            return pickle.load(f)

if __name__ == '__main__':
    # p = Thread('1-assign_exe.json')
    p=Thread('2-call func_exe.json')
    p1 = p.run()
    # next(p1)
    #
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
    # next(p1)
