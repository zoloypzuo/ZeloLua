from typing import AnyStr, Tuple

from zlua.vm import LuaThread

no_instr = ('', ('',))


class Debugger:
    def __init__(self):
        self.thread: LuaThread = None
        self.is_stepping = False

    def execute(self):
        while True:
            instr = input('> ')
            op, operands = _parse_instr(instr)
            try:
                ret = getattr(self, '_' + op)(*operands)
            except AttributeError:
                print('错误的debug指令')
                self._help()
            if ret == 'break':
                break

    def _help(self, *oprds):
        set1 = set(filter(lambda s: not s.startswith('__'), dir(self)))
        ops = set1 - {'execute'}
        print(ops)

    def _set_breakpoint(self, *line_numbers):
        for i in line_numbers:
            if not (isinstance(i, int) and i > 0):
                raise ValueError('断点行号是正整数')
        self.bps = line_numbers

    def _step(self):
        self.is_stepping = True
        return 'break'

    def _continue(self):
        return 'break'

    def _globals(self):
        print(self.thread.globals)

    def _locals(self):
        visibile_locals = set().union(*[scope.locals for scope in self.thread.curr_p.scope_stack])
        print(visibile_locals)
    def _src(self):
        print(self.thread.curr_p.instrs[self.thread.pc].src_text)

def _parse_instr(instr: str) -> Tuple[str, Tuple[str]]:
    '''不抛出异常，指令分派时才。。'''
    import re
    lexemes = re.split(',\s', instr)
    if not lexemes: return no_instr
    op, operands = lexemes[0], tuple(lexemes[1:])
    return op, operands


from zlua.lua import new_thread, do_file

if __name__ == '__main__':
    t = new_thread()
    d = Debugger()
    t.debugger = d
    d.thread = t
    d._set_breakpoint(1)
    do_file('../tests/test.lua', t)
