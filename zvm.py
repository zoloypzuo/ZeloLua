"""
zvm takes _exe.json as input and execute it
 stages:
1. load tables to runtime table classes
2. vm loop:
    1. fetch a line of instruction
    2. decode it to operator and operands
    3. execute it
"""





from ISA import ISA
from re import match
from zasm import *
from collections import namedtuple

RetAddr=namedtuple('RetAddr',['func','addr'])
# RetAddr.__doc__="..."

class RuntimeFunc:

    def __init__(self, func:Function,ret_addr):
        self.func=func
        self.ret_addr=ret_addr # None if _Main
        self.local_data={}

class Process:

    def __init__(self, path):
        '''zvm use .json as .exe file format to init a process'''
        # ----get tables from .json
        exe = self.load(path)
        self.main_func=exe.main_func

        self.isa = ISA()
        self.stack = []  # {list<FuncNode>}
        self.global_data = {}  # {var_name:val,...}
        self.global_data['RetVal'] = None  # init a global var named 'RetVal' for return value of function calls


        rt_main_func = RuntimeFunc(self.main_func,None)
        self.stack.append(rt_main_func)
        self.curr_func=self.stack_top()
        # ----some flags
        self.jump = False
        self.is_EOF = self.curr_func.func.instrs is []

    def run(self):
        '''run the process'''
        self.pc=0
        while True:
            yield None
            if self.is_EOF:
                break
            self.jump = False  # reset the jump
            current_instr = self.curr_func.func.instrs[self.pc]
            self.execute(current_instr.operator, *current_instr.operands)
            if not self.jump:
                self.skip_to_next_line()
            else:
                continue

    def skip_to_next_line(self):
        if self.pc >= len(self.curr_func.func.instrs) - 1:
            self.is_EOF = True
        self.pc += 1

    def stack_top(self)->RuntimeFunc:
        return self.stack[-1]

    def execute(self, operator, *operands):
        '''

        :param operator: eg. 'Mov'
        :param operands: eg. ('Var',16), () if no operands
        :return:
        '''
        def parse_value(lexeme:str):
            if match(r'[_a-zA-Z]\w*', lexeme):  # var
                return self.curr_func.local_data[lexeme]
            else:  # literal
                if match(r'\".*\"',lexeme):return lexeme.strip('\"')
                elif match(r'([+-]?\d*.\d+)',lexeme):return float(lexeme)
                else:return int(rhs)

        if operator == 'mov':
            rhs = operands[1]
            rhs=parse_value(rhs)
            self.curr_func.local_data[operands[0]] = rhs
        elif operator == 'setglobal':
            rhs=operands[1]
            rhs=parse_value(rhs)
            self.global_data[operands[0]]=rhs
        # elif operator == 'Jmp':
        #     self.jump = True
        #     label_addr = self.labels[operands[0]]
        #     self.Jmp(label_addr)
        # elif operator == 'Call':
        #     func_name = operands[0]
        #     params = operands[1:]
        #     self.Call(func_name, *params)
        elif operator == 'return':
            if self.curr_func.ret_addr == None:
                exit('Return from _Main, Process executed')
            self.pc = self.curr_func.ret_addr
            self.stack.pop()
            self.curr_func = self.stack_top()
        # elif operator == 'Print':
        #     self.Print(*operands)
        # elif operands == 'PrintVar':
        #     self.PrintVar(*operands)
        elif operator == 'Nop':
            self.Nop()

    def Var(self, ident):
        self.stack_top().local_data[ident] = None

    def Jmp(self, label):
        self.pc = label

    def Print(self, *args):
        print(*args)

    def PrintVar(self, var_name):
        var_val = self.vars[(var_name, self.stack_top().name)]
        print(var_val)

    def Nop(self):
        pass

    def Call(self, func_name, *params):
        func_info = self.funcs[func_name]  # func info from func table
        new_runtime_func = RuntimeFunc(func_name, self.stack_top().entry, func_info.entry)
        # ----pass params: add to local_data
        param_names = func_info.param_names
        for i in range(len(param_names)):
            new_runtime_func.local_data[param_names[i]] = params[i]

        self.pc = func_info.entry  # set pc to the callee entry
        self.stack.append(new_runtime_func)

    def call_main(self):
        try:
            main_info = self.funcs['_Main']
            main_func = RuntimeFunc('_Main', None, main_info.entry)
            self.pc = main_info.entry
            self.stack.append(self.main_func)
        except KeyError:
            exit('Code has no _Main')


    def load(self, path):
        import z_json
        return z_json.load(path)
if __name__ == '__main__':
    p=Process('1-assign_exe.json')
    p1 = p.run()
    next(p1)

    next(p1)
    next(p1)
    next(p1)
    next(p1)
    next(p1)
    next(p1)
    next(p1)
