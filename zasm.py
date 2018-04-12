"""
zasm is .zasm assembler, it outputs xxx_exe.json which is input of zvm
4 stages
1. format: split file to lines and append line number
2. lex: lex line to lexemes, without tokenization because it is simple
3. parse: parse (lightly) lexemes, fill the 4 tables
4. dump: save the 4 table to .json



"""


from re import match, sub, split
from ISA import ISA
from z_json_serialization import beautified_json
from os import path as _p


class Function:

    def __init__(self, name, *param_names):
        self.name = name
        self.entry = 0
        self.param_names = param_names


class Label:

    def __init__(self, name, func):
        self.name = name
        self.func = func


class Variable:

    def __init__(self, name, func_name):
        self.name = name
        self.func_name = func_name


class AssembledInstr:

    def __init__(self, operator, operands):
        assert isinstance(operands, list)
        self.operator = operator
        self.operands = operands  # {list}


class ExeFile:
    def __init__(self, var_table, label_table, func_table, assembled_instrs):
        self.var_table = var_table
        self.label_table = label_table
        self.func_table = func_table
        self.assembled_instrs = assembled_instrs


class Assembler:

    def __init__(self, path):
        # ----tables for assembled file
        self.var_table = {}
        self.label_table = {}
        self.func_table = {}
        self.assembled_instrs = []

        self.isa = ISA()
        # ----core
        src = self.format(path)  # [(line,line_number),...]
        self.lexemes = self.lex(src)  # [{line}[lexeme0,...],...]
        self.parse(self.lexemes)  # fill tables
        self.dump_json(path)
        pass

    def split_punc(self, text):
        """after split src with whitespace(so {parameter}text will not contain whitespace),
        split with punctuation such that 'a,b' => ('a',',','b'), note that there is no space between 'a' and ','"""
        index0 = 0
        index1 = 0
        ret = []
        while True:
            if index1 >= len(text): break
            if text[index1] not in ':,{}()':
                pass  # text[index1] is not punc
            else:  # text[index1] is punc, lex the lexeme and punc and add to ret
                lexeme = text[index0:index1]
                if lexeme:  # tiny bug emerge when successive punc like '){' in 'Func _Main(1,2){', lexeme is '' which should not be added
                    ret.append(lexeme)
                ret.append(text[index1])
                index0 = index1 + 1  # move index0 to index1
            index1 += 1
        remainder = text[index0:]
        if remainder:
            ret.append(remainder)  # the last lexeme may not be appended, so append it
        return ret

    def lex(self, src):
        '''lex src to lexemes'''
        lines = []
        for i in src:
            y = []
            t = list(filter(None, split(r'\s+', i[0])))  # 'lexemes' split by whitespace
            for j in t:
                j = self.split_punc(j)
                for k in j:
                    y.append(k)
            lines.append(y)
        return lines

    def parse(self, lexemes):
        # ----line operation
        self.line_index = 0
        self.is_EOF = lexemes is []  # if lexemes is []...

        def current_line():
            return lexemes[self.line_index]

        def skip_to_next_line():
            if self.line_index >= len(lexemes) - 1:
                self.is_EOF = True
            self.line_index += 1

        # ----recognize lexeme
        def is_instr(text):
            return text in self.isa.instrs

        def is_label(text):
            return match(r'[_0-9a-zA-Z]\w*', text)  # 可能重复了

        # ----parse
        self.current_func = ''
        while True:
            if self.is_EOF:
                break
            line = current_line()
            assert line is not []  # just for debug
            operator = line[0]
            remainder = line[1:]
            if operator == 'SetStackSize':
                pass
            elif operator == 'Var':
                name = remainder[0]
                new_var = Variable(name, self.current_func)
                self.var_table[name] = new_var
                self.assembled_instrs.append(AssembledInstr(operator, remainder))
            elif operator == 'Func':
                func_name = remainder[0]
                param_names = self.handle_func(remainder[1:])
                new_func = Function(func_name, *param_names)

                new_func.entry = len(self.assembled_instrs)  # note to skip '{' line
                self.func_table[func_name] = new_func
                self.current_func = func_name
                skip_to_next_line()  # note to skip '{' line
            elif operator == '}':
                self.assembled_instrs.append(AssembledInstr('Ret', []))  # add Ret to the end of func
            elif is_instr(operator):
                self.assembled_instrs.append(AssembledInstr(operator, list(filter(lambda x: x not in ',:', remainder))))
            elif is_label(operator):
                self.assembled_instrs.append(AssembledInstr('Nop', []))
                self.label_table[operator] = len(self.assembled_instrs)

            skip_to_next_line()

    def dump_json(self, path: str):
        '''dump exe DS to json file'''
        exe = ExeFile(self.var_table, self.label_table, self.func_table, self.assembled_instrs)
        asm_name = _p.basename(path)
        # use original asm to create exe file name, replace whitespace with '_' and add '.json'
        output_file_name = (sub('\..*', '', asm_name.replace('\s','_')))+'_exe.json'
        with open(output_file_name, 'w') as f:
            f.write(beautified_json(exe))

    def format(self, path):
        '''open the src file, remove comments, skip blank lines, and return [(line,line_number),...]'''

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
                if is_blank_line(line):
                    continue
                ret.append((line, i))
        return ret

    def handle_func(self, tokens):
        '''
        ['(','a',',','b',',','c',')'] => {generator}['a','b','c']
        :param tokens:
        :return:
        '''
        index = 0
        while True:
            if index >= len(tokens) - 1: break
            curr_token = tokens[index]
            if curr_token in '(),':
                pass
            elif match('\w+', curr_token):
                yield curr_token
            else:
                pass  # just for foo


if __name__ == '__main__':
    src = format('test_3.txt')
    Assembler(src)
