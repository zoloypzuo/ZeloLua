from re import match, sub, split
import json

class Function():
    def __init__(self, name):
        self.name = name
        self.entry=0


class Label():
    def __init__(self, name, func):
        self.name = name
        self.func = func


class Variable():
    def __init__(self, name, func):
        self.name = name
        self.func = func


class Instr():
    def __init__(self,operator):
        self.operator = ''
        self.operand_types = []

class ISA():


    def __init__(self):
        self.grammar = {
            'var': ['[_a-zA-Z]\\w*'],
            'literal': ['([+-]?\\d+)', '([+-]?\\d*\\.\\d+)', '(\\".*\\")'],
            'func': ['[_a-zA-Z]\\w*'],
            'label': ['[_a-zA-Z]\\w*']}
        self.instrs={}
        self.build()

        # ---- self.grammar is generated by following code
        #     self.grammar = self.parse_grammar(r'''
        #                 var => [_a-zA-Z]\w+
        #                 literal => ([+-]?\d+)|([+-]?\d*\.\d+)|(\".*\")
        #                 func => [_a-zA-Z]\w+
        #                 label => [_a-zA-Z]\w+
        #                 ''')
        #     pass
        # def parse_grammar(self,description):
        #     def _split(text,sep=None):
        #         return [t.strip() for t in text.strip().split(sep) if t]
        #     g={}
        #     description=description.replace('\t','') #remove tabs
        #     for line in _split(description,'\n'):
        #         lhs,rhs=_split(line,' => ')
        #         g[lhs]=_split(rhs,'|')
        #     return g
    def build(self):
        self.instrs['Mov']=Instr('Mov')
        self.instrs['Mov'].operand_types.append(['var'])
        self.instrs['Mov'].operand_types.append(['var','literal'])
        self.instrs['Var']=Instr('Var')
        self.instrs['Var'].operand_types.append(['var'])
class AssembledInstr():
    def __init__(self,operator,operands):
        self.operator=operator
        self.operands = operands #list


class Assembler():
    def __init__(self, src):
        self.src = src
        #----tables for assembled file
        self.var_table={}
        self.label_table={}
        self.func_table={}
        self.assembled_instrs=[]

        self.isa = ISA()
        #----core
        self.lexemes=self.lex(src)
        self.parse(self.lexemes)
        self.dump_json()
        pass

    def split_punc(self, text):
        """after split src with whitespace(so {parameter}text will not contain whitespace),
        split with punctuation such that 'a,b' => ('a',',','b')"""
        '''这种写法是低效的，+=应该改成用index切片'''
        lexeme = ''
        ret = []
        for i in text:
            if i not in ':,':
                lexeme += i
            else:
                ret.append(lexeme)
                lexeme = ''
                ret.append(i)
        if lexeme: ret.append(lexeme)  # the last lexeme may not be appended, so append it
        return ret

    def lex(self, src):
        '''lex src to lexemes'''
        x = []
        for i in src:
            y = []
            for j in list(filter(None, split(r'\s+', i[0]))):
                j = self.split_punc(j)
                for k in j: y.append(k)
            x.append(y)
        return x

    def parse(self, lexemes):
        # ----line operation
        self.line_index = 0
        self.is_EOF = lexemes is [] # if lexemes is []...

        def current_line():
            return lexemes[self.line_index]

        def skip_to_next_line():
            if self.line_index >= len(lexemes)-1: self.is_EOF = True
            self.line_index += 1

        # ----recognize lexeme
        def is_instr(text):
            return text in self.isa.instrs

        def is_label(text):
            return match(r'[_0-9a-zA-Z]\w*',text)  #可能重复了
        # ----parse
        self.current_func=''
        while True:
            if self.is_EOF: break
            line = current_line()
            operator = line[0]
            remainder=line[1:]
            if operator == 'SetStackSize':
                pass
            elif operator == 'Var':
                name=remainder[0]
                new_var=Variable(name,self.current_func)
                self.var_table[name]=new_var
                self.assembled_instrs.append(AssembledInstr(operator, remainder))
            elif operator == 'Func':
                name=remainder[0]
                new_func=Function(name)
                new_func.entry=len(self.assembled_instrs)+1 #note to skip '{' line
                self.func_table[name]=new_func
                self.current_func=name
                skip_to_next_line() #note to skip '{' line
            elif operator == 'Param':
                pass
            elif operator == '}':pass
            elif is_instr(operator):
                self.assembled_instrs.append(AssembledInstr(operator,list(filter(lambda x:x not in ',:',remainder))))
            elif is_label(operator):
                self.label_table[operator]=len(self.assembled_instrs)

            skip_to_next_line()
    def dump_json(self):
        instrs=[]
        funcs={}
        vars={}
        for instr in self.assembled_instrs:
            instrs.append({'operator':instr.operator,'operands':instr.operands})
        for f_name,f_node in self.func_table.items():
            funcs[f_name]={'entry':f_node.entry,'name':f_node.name}
        #label table do not need change
        for var_name,var_node in self.var_table.items():
            vars[var_name]={'name':var_node.name,'func':var_node.func}
        output={
            'instrs':instrs,
            'funcs':funcs,
            'vars':vars,
            'labels':self.label_table
        }
        with open('out.json','w') as f:
            f.write(json.dumps(output))

def format(path):
    '''open the src file, remove comments, skip blank lines, and return [(line,line_number),...]'''
    '''>>>print(format('test_0.xasm'))'''

    def remove_comments(line):
        """>>>print(remove_comments('Var Counter; Create a counter'))"""
        return sub(r';.*', r'', line)

    def is_blank_line(line):
        return match(r'^\s*\n', line)

    i = 0
    ret = []
    with open(path, 'r') as f:
        for line in f:
            line = remove_comments(line)
            i += 1
            if is_blank_line(line): continue
            ret.append((line, i))
    return ret


if __name__ == '__main__':
    src = format('test_3.txt')
    Assembler(src)
