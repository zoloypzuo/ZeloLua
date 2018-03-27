import json
from zasm import ISA
from re import match

class Variable:
    def __int__(self,name):
        self.name=name
        self.val=None


class Function:
    def __init__(self,name,entry):
        self.name=name
        self.entry=entry
        self.local_data={} #var_name:val

class Process:
    def __init__(self,path):
        with open(path,'r') as f:
            text=json.load(f)
            self.instrs=text['instrs']
            self.funcs=text['funcs']
            self.vars=text['vars']
            self.labels=text['labels']
        self.pc=0
        self.isa=ISA()
        self.stack=[]
        self.global_datas={}
        self.jump=False
        self.is_EOF=self.instrs is not []
        self.run()
    def run(self):
        while True:
            if self.is_EOF:break
            current_instr=self.instrs[self.pc]
            self.execute(current_instr['operator'],*current_instr['operands'])
            if not self.jump:self.skip_to_next_line()
            else:continue
    def skip_to_next_line(self):
        if self.pc >= len(self.instrs)-1:self.is_EOF=True
        self.pc+=1


    def stack_top(self):return self.stack[-1]


    def execute(self,operator,*operands):
        if operator == 'Mov':
            lhs=operands[0]
            rhs=operands[1]
            if match(r'\w+',rhs):  #var
                self.Mov(lhs,self.stack_top().local_data[rhs])
            else:  #literal
                self.Mov(lhs,rhs)
        elif operator == 'Var':pass
        elif operator == 'Jmp':
            label=operands[0]
            self.Jmp(self.labels[label])
        elif operator == 'Call':
            func=operands[0]
            self.Call(func)

    def Mov(self,x,y):x.val=y
    def Jmp(self,label):self.pc=label
    def Call(self,func):
        self.pc=func
        pass #foo




if __name__ == '__main__':
    Process('out.json')