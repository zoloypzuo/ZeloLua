import json
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
        exe=self.load(path)
        self.instrs = exe.assembled_instrs
        self.funcs = exe.func_table
        self.vars = exe.var_table
        self.labels = exe.label_table
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
            lhs = self.stack_top().local_data[operands[0]]  # lhs must be var ie. lvalue ie. mem ref
            rhs = operands[1]
            if match(r'\w+', rhs):  # var
                lhs = self.stack_top().local_data[rhs]
            else:  # literal
                lhs = rhs
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

    def Var(ident):
        self.stack_top().local_data[ident] = None

    def Jmp(self, label):
        self.pc = label

    def Call(self, func_name, ret_addr, *params):
        func_info = self.funcs[func_name]  # func info from func table
        func = FuncNode(func_name, self.stack_top().entry, func_info['entry'])
        # ----pass params: add to local_data
        param_names = func_info['param_names']
        for i in range(len(param_name)):
            func.local_data[param_name[i]] = params[i]

        self.pc = func_info['entry']  # set pc to the callee entry
        self.stack.append(func)
    def load(self,path):
        def deserialize(json_obj):
            if isinstance(json_obj, (int, float, str, bool)):
                return json_obj
            elif isinstance(json_obj, list):
                return [deserialize(i) for i in json_obj]
            elif json_obj is None:
                return None
            elif isinstance(json_obj, dict):
                if False:
                    pass  # just for foo
                elif json_obj.keys() == Function(None).__dict__.keys():
                    new_Function = Function(None)
                    new_Function.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
                    return new_Function
                elif json_obj.keys() == Label(None,None).__dict__.keys():
                    new_Label = Label(None,None)
                    new_Label.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
                    return new_Label
                elif json_obj.keys() == Variable().__dict__.keys():
                    new_Variable = Variable()
                    new_Variable.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
                    return new_Variable
                elif json_obj.keys() == AssembledInstr(None,None).__dict__.keys():
                    new_AssembledInstr = AssembledInstr(None,None)
                    new_AssembledInstr.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
                    return new_AssembledInstr
                elif json_obj.keys() == ExeFile(None,None,None,None).__dict__.keys():
                    new_ExeFile = ExeFile(None,None,None,None)
                    new_ExeFile.__dict__ = {deserialize(key): deserialize(val) for key, val in json_obj.items()}
                    return new_ExeFile
                else:
                    return {deserialize(key): deserialize(val) for key, val in json_obj.items()}

        with open(path, 'r')as f:
            json_obj = json.load(f)
            return deserialize(json_obj)

if __name__ == '__main__':
    Process('out.json')
