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
from z_json import beautified_json,plain_json
from os import path as _p


class Function:

    def __init__(self, *param_names):
        self.param_names = param_names

        self.instrs = []  # {list<AssembledInstr>}
        self.inner_funcs = []  # {list<Function>}
        self.labels = {}  # {dict<str,int>}


class AssembledInstr:

    def __init__(self, operator, operands):
        assert isinstance(operands, list)
        self.operator = operator
        self.operands = operands  # {list}


class ExeFile:
    def __init__(self, main_func):
        # self.var_table = var_table  # TODO
        # self.label_table = label_table
        # self.func_table = func_table
        # self.assembled_instrs = assembled_instrs
        self.main_func=main_func

class Assembler:

    def __init__(self, path):
        '''
        assemble the `path to .json
        :param path:
        '''
        # ----tables for assembled file
        # self.global_var_table = {}
        self.main_func = None
        # self.label_table = {}
        # self.func_table = {}
        # self.assembled_instrs = []

        self.isa = ISA()
        # ----core
        src = self.format(path)  # [(line,line_number),...]
        self.lexemes = self.lex(src)  # [[lexeme0,...],...]
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
        def parse_non_keyword(lexeme):
            if match(r'[_a-zA-Z]\w*', lexeme): return lexeme

        while True:
            if self.is_EOF:
                break
            line = current_line()
            assert line is not []  # just for debug
            operator = line[0]
            remainder = line[1:]
            if operator == 'Func':
                param_names = self.handle_func(remainder)
                new_func = Function(*param_names)
                if self.main_func is None: self.main_func = new_func
                self.current_func = new_func

                skip_to_next_line()  # note to skip '{' line

            elif operator == '}':
                self.current_func.instrs.append(AssembledInstr('Ret', []))  # add Ret to the end of func
            elif is_instr(operator):
                self.current_func.instrs.append(
                    AssembledInstr(
                        operator,
                        [x for x in remainder if x not in ',:']))
            elif is_label(operator):
                self.current_func.instrs.append(AssembledInstr('Nop', []))
                self.current_func.labels[operator] = len(self.current_func.instrs) #TODO check

            skip_to_next_line()

    def dump_json(self, path: str):
        '''dump exe DS to json file'''
        exe = ExeFile(self.main_func)
        asm_name = _p.basename(path)
        # use original asm to create exe file name, replace whitespace with '_' and add '.json'
        output_file_name = (sub('\..*', '', asm_name.replace('\s', '_'))) + '_exe.json'
        with open(output_file_name, 'w') as f:
            f.write(beautified_json(exe, decodable=True))

        # 方便看
        output_plain_name='plain'+'.json'
        with open(output_plain_name,'w') as f:
            f.write(beautified_json(exe,decodable=False))

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
    Assembler('_test/1-assign.txt')
