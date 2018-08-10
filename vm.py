'''
the runtime stage part of zlua

'''

import pickle
from typing import *


class Proto:

    def __init__(self, parent, *param_names):
        self.param_names = param_names
        self.parent = parent
        self.instrs: List = []
        self.inner_funcs: List[Proto] = []
        self.labels: Dict[str:int] = {}
        self.locals = {}
        self.enclosed_blocks = []


class Block:
    def __init__(self):
        self.parent
        self.enclosed_blocks = []
        self.locals = {}
        self.startpc
        self.endpc


class Instr:

    def __init__(self, op, operands):
        assert isinstance(operands, (list, tuple))
        self.op = op
        self.operands = operands

    def __str__(self):
        return self.op + ' ' + ','.join(map(repr, self.operands))


class Closure: pass


class PythonClosure(Closure):
    def __init__(self, py_func):
        self.py_func = py_func

    def __call__(self, *args):
        return self.py_func(*args)


class LuaClosure(Closure):

    def __init__(self, func: Proto):
        self.saved_pc = 0
        self.func: Proto = func
        self.exp_stack = []  # "stack-based vm"


class LuaThread:
    def __init__(self):
        self.frame_stack: List[Closure] = []
        self.globals: Dict[str,] = {}
        self.pc = 0

        def lua_assert(thread):
            assert thread.pop()

        self.register(lua_assert, 'assert')

    def register(self, python_func, name):
        self.globals[name] = PythonClosure(python_func)

    @property
    def curr_func(self) -> LuaClosure:
        return self.frame_stack[-1]

    def push(self, val):
        self.curr_func.exp_stack.append(val)

    def pop(self):
        return self.curr_func.exp_stack.pop()

    def popn(self, n_args):
        assert n_args >= 0
        if n_args > 0:
            n = self.curr_func.exp_stack[-n_args:]  # tricky: [1,2,3][-1:] => [3] but [1,2,3][-0:] => [1,2,3]
            del self.curr_func.exp_stack[-n_args:]
            return n
        else:
            return []

    def execute(self):
        while True:
            self.curr_instr = self.curr_func.func.instrs[self.pc]
            op = '_' + self.curr_instr.op
            operands = self.curr_instr.operands
            if getattr(self, '_' + op)(*operands) == 'return from chunk':  # 为了能从chunk返回
                return
            self.pc += 1

    def _closure(self, *operands):
        rt_func = LuaClosure(self.curr_func.func.inner_funcs[int(operands[0])])
        # self.curr_func.local_data['.t'] = rt_func
        self.push(rt_func)

    def _call(self, *operands):
        n_args = operands[0]
        args = self.popn(n_args)
        closure = self.pop()
        self.frame_stack.append(closure)
        if not isinstance(closure, Closure):  # 不是函数，尝试元方法
            try:
                closure = closure.metatable['__call']
                if not isinstance(closure, Closure):
                    raise TypeError('对象不可调用')  # __call不是函数
            except AttributeError:
                raise TypeError('对象不可调用') #没有metatable字段

        if isinstance(closure, LuaClosure):
            closure.func.locals.update(
                dict(zip(closure.func.param_names, args)))  # 这句很复杂，一行把param names和args组合起来加入locals
            self.pc = -1
        else:
            self.push(closure())  # push ret val

    def _ret(self, *operands):
        ret_val = self.pop()
        self.frame_stack.pop()
        if not self.frame_stack:
            return 'return from chunk'
        self.pc = self.curr_func.saved_pc
        self.push(ret_val)

    def _add(self, *operands):
        # self.curr_func.local_data[operands[0]] = sum(
        #     map(self.parse_value, operands[1:]))  # tricky, add C A B: C=A+B, ...
        a0 = self.pop()
        a1 = self.pop()
        self.push(a0 + a1)

    def _load(self, path):
        '''load exe from path'''
        with open(path, 'rb') as f:
            return pickle.load(f)

    def _push(self, *operands):
        self.curr_func.exp_stack.append(operands[0])

    def _pop(self):
        return self.curr_func.exp_stack.pop()

    def _mul(self, *operands):
        a0 = self.curr_func.exp_stack.pop()
        a1 = self.curr_func.exp_stack.pop()
        self.push(a0 * a1)

    def _eq(self, *operands):
        a0 = self.curr_func.exp_stack.pop()
        a1 = self.curr_func.exp_stack.pop()
        self.push(a0 == a1)

    def _and(self, *operands):
        a0 = self.curr_func.exp_stack.pop()
        a1 = self.curr_func.exp_stack.pop()
        self.push(a0 and a1)

    def _push_var(self, *operands):
        var = operands[0]
        value = self.curr_func.local_data[var]
        self.push(value)


def _try_meta_call(thread, func):
    pass


def _get_metamethod(thread, obj, meta_type: str):
    pass


metamethod_names = ["__index", "__newindex",
                    "__gc", "__mode", "__eq",
                    "__add", "__sub", "__mul", "__div", "__mod",
                    "__pow", "__unm", "__len", "__lt", "__le",
                    "__concat", "__call"]

if __name__ == '__main__':
    assert True
