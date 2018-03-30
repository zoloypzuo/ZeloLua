import json
from ISA import ISA
from re import match


class Variable:

    def __int__(self, name):
        self.name = name
        self.val = None


class Function:
    '''runtime function node'''

    def __init__(self, name, ret_addr, entry):
        self.name = name  # 不需要，debug方便
        self.ret_addr = ret_addr
        self.entry = entry
        self.local_data = {}  # {var_name:val,...}


class Process:

    def __init__(self, path):
        '''zvm use .json as .exe file format to init a process'''
        with open(path, 'r') as f:
            text = json.load(f)
            self.instrs = text['instrs']
            self.funcs = text['funcs']
            self.vars = text['vars']
            self.labels = text['labels']
        self.pc = 0
        self.isa = ISA()
        self.stack = []  # {list<Function>}
        self.global_data = {}  # {var_name:val,...}
        self.jump = False
        self.is_EOF = self.instrs is not []
        self.run()

    def run(self):
        '''run the process'''
        while True:
            if self.is_EOF:
                break
            self.jump = False  # reset the jump
            current_instr = self.instrs[self.pc]
            self.execute(current_instr['operator'], *current_instr['operands'])
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
        if operator == 'Mov':
            lhs = operands[0]
            rhs = operands[1]
            if match(r'\w+', rhs):  # var, so the operand is memory ref
                self.Mov(lhs, self.stack_top().local_data[rhs])
            else:  # literal
                self.Mov(lhs, rhs)
        elif operator == 'Var':
            pass
        elif operator == 'Jmp':
            self.jump = True
            label = operands[0]
            self.Jmp(self.labels[label])
        elif operator == 'Call':
            func_name = operands[0]
            self.Call(func_name)

    def Var(ident):
        self.stack_top().local_data[ident] = None

    def Mov(self, x, y):
        x.val = y

    def Jmp(self, label):
        self.pc = label

    def Call(self, func_name, ret_addr, *params):
        func_info = self.funcs[func_name]  # func info from func table
        func = Function(func_name, self.stack_top().entry, func_info['entry'])
        # ----pass params: add to local_data
        param_names = func_info['param_names']
        for i in range(len(param_name)):
            func.local_data[param_name[i]] = params[i]

        self.pc = func_info['entry']  # set pc to the callee entry
        self.stack.append(func)


if __name__ == '__main__':
    Process('out.json')
