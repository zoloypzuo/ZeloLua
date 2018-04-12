from ISA import ISA
from re import match
from zasm import *


class FuncNode:
    '''runtime function node'''

    def __init__(self, name, ret_addr, entry):
        self.name = name  # 不需要，debug方便
        self.ret_addr = ret_addr
        self.entry = entry
        self.local_data = {}  # {var_name:val,...}


class Process:

    def __init__(self, path):
        '''zvm use .json as .exe file format to init a process'''
        # ----get tables from .json
        exe = self.load(path)
        self.instrs = exe.assembled_instrs
        self.funcs = exe.func_table
        self.vars = exe.var_table
        self.labels = exe.label_table

        self.pc = 0
        self.isa = ISA()
        self.stack = []  # {list<FuncNode>}
        self.global_data = {}  # {var_name:val,...}
        self.global_data['RetVal'] = None  # init a global var named 'RetVal' for return value of function calls
        # ----some flags
        self.jump = False
        self.is_EOF = self.instrs is []

        self.call_main() # set pc to _Main(and do some other sth)
        self.run()

    def run(self):
        '''run the process'''
        while True:
            if self.is_EOF:
                break
            self.jump = False  # reset the jump
            current_instr = self.instrs[self.pc]
            self.execute(current_instr.operator, *current_instr.operands)
            if not self.jump:
                self.skip_to_next_line()
            else:
                continue

    def skip_to_next_line(self):
        if self.pc >= len(self.instrs) - 1:
            self.is_EOF = True
        self.pc += 1

    def stack_top(self):
        return self.stack[-1]

    def execute(self, operator, *operands):
        '''

        :param operator: eg. 'Mov'
        :param operands: eg. ('Var',16), () if no operands
        :return:
        '''
        if operator == 'Mov':
            rhs = operands[1]
            if match(r'[_a-zA-Z]\w*', rhs):  # var
                self.stack_top().local_data[operands[0]] = self.stack_top().local_data[rhs]
            else:  # literal
                self.stack_top().local_data[operands[0]] = rhs
        elif operator == 'Var':
            pass
        elif operator == 'Jmp':
            self.jump = True
            label_addr = self.labels[operands[0]]
            self.Jmp(label_addr)
        elif operator == 'Call':
            func_name = operands[0]
            params = operands[1:]
            self.Call(func_name, *params)
        elif operator == 'Ret':
            self.Ret()
        elif operator == 'Print':
            self.Print(*operands)
        elif operands == 'PrintVar':
            self.PrintVar(*operands)
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
        new_runtime_func = FuncNode(func_name, self.stack_top().entry, func_info.entry)
        # ----pass params: add to local_data
        param_names = func_info.param_names
        for i in range(len(param_names)):
            new_runtime_func.local_data[param_names[i]] = params[i]

        self.pc = func_info.entry  # set pc to the callee entry
        self.stack.append(new_runtime_func)

    def call_main(self):
        try:
            main_info = self.funcs['_Main']
            main_func = FuncNode('_Main', None, main_info.entry)
            self.pc = main_info.entry
            self.stack.append(main_func)
        except KeyError:
            exit('Code has no _Main')

    def Ret(self):
        if self.stack_top().name=='_Main':
            exit('Return from _Main, Process executed')
        self.pc = self.stack_top().ret_addr

    def load(self, path):
        import z_json
        return z_json.decode(path)
if __name__ == '__main__':
    Process('test_3_exe.json')
