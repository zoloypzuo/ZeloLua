'''
the runtime stage part of zlua

'''

import pickle
from type_model import Table
from typing import *

from compiler import Proto


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
        self.upvals = []


class LuaThread:
    def __init__(self):
        self.frame_stack: List[LuaClosure] = []
        self.globals: Dict[str,] = {}
        self.pc = 0

        def lua_assert(b):
            assert b

        self.register(lua_assert, 'assert')

    def register(self, python_func, name):
        self.globals[name] = PythonClosure(python_func)

    @property
    def curr_func(self) -> LuaClosure:
        return self.frame_stack[-1]

    @property
    def _instrs(self):  # just for debug
        return self.curr_func.func.instrs

    def push(self, val):
        self.curr_func.exp_stack.append(val)

    def pop(self):
        return self.curr_func.exp_stack.pop()

    def pushn(self, l: list):
        self.curr_func.exp_stack += l  # [1]+=[2,3] => [1,2,3]

    def popn(self, n):
        '''正序弹出n个栈顶元素，eg s=[1,2,3,4], popn(2) => [3,4]'''
        assert n >= 0
        if n > 0:
            exps = self.curr_func.exp_stack[-n:]  # tricky: [1,2,3][-1:] => [3] but [1,2,3][-0:] => [1,2,3]
            del self.curr_func.exp_stack[-n:]
            return exps
        else:
            return []

    def execute(self):
        while True:
            self.curr_instr = self.curr_func.func.instrs[self.pc]
            op = '_' + self.curr_instr.op
            operands = self.curr_instr.operands
            if getattr(self, op)(*operands) == 'return from chunk':  # 为了能从chunk返回
                return
            self.pc += 1

    def _push_l(self, *operands):
        o = operands[0]
        self.push(o)

    def _get_upval(self, *operands):
        name = operands[0]
        self.push(self.curr_func.upvals[name])

    def _set_upval(self, *operands):
        name = operands[0]
        self.curr_func.upvals[name] = self.pop()

    def _get_global(self, *operands):
        name = operands[0]
        self.push(self.globals[name])

    def _set_global(self, *operands):
        name = operands[0]
        self.globals[name] = self.pop()

    def _unpack(self, *operands):
        n_names = operands[0]
        exps: list = self.pop().apart
        if len(exps) != n_names:
            raise ValueError('解包左右个数不相等')
        self.pushn(exps)

    def _new_locals(self, *operands):
        names = operands
        exps = self.popn(len(names))
        self.curr_func.func.curr_locals.update(dict(zip(names, exps)))

    def _get_local(self, *operands):
        name = operands[0]
        self.push(self.curr_func.func.curr_locals[name])

    def _set_local(self, *operands):
        name = operands[0]
        self.curr_func.func.curr_locals[name] = self.pop()

    def _call(self, *operands):
        n_args = operands[0]
        args = self.popn(n_args)
        closure = self.pop()
        if not isinstance(closure, Closure):  # 不是函数，尝试元方法
            try:
                closure = closure.metatable['__call']
                if not isinstance(closure, Closure):
                    raise TypeError('对象不可调用')  # __call不是函数
            except AttributeError:
                raise TypeError('对象不可调用')  # 没有metatable字段

        if isinstance(closure, LuaClosure):
            self.curr_func.saved_pc = self.pc
            self.frame_stack.append(closure)
            closure.func.locals.update(
                dict(zip(closure.func.param_names, args)))  # 这句很复杂，一行把param names和args组合起来加入locals
            self.pc = -1
        else:
            assert isinstance(closure, PythonClosure)
            ret_val = closure(args)
            self.push(ret_val)  # push ret val

    def _call_procedure(self, *operands):
        self._call(*operands)
        self.pop()  # 抛弃返回值

    def _closure(self, *operands):
        index = operands[0]
        lc = LuaClosure(self.curr_func.func.enclosed_protos[index])
        self.push(lc)

    def _ret(self, *operands):
        n_ret = operands[0]
        ret_val = None
        if n_ret == 1:  # ret 0则返回值为None，否则弹出一个值
            ret_val = self.pop()
        self.frame_stack.pop()
        if not self.frame_stack:
            return 'return from chunk'
        self.pc = self.curr_func.saved_pc
        self.push(ret_val)

    def _procedure_pop(self, *operands):
        self.pop()

    def _self(self, *operands):
        func_name = operands[0]
        table: Table = self.pop()
        self.push(table[func_name])
        self.push(table)

    def _add(self, *operands):
        rhs = self.pop()
        lhs = self.pop()
        self.push(lhs + rhs)

    def _sub(self, *operands):
        rhs = self.pop()  # 注意出栈顺序
        lhs = self.pop()
        self.push(lhs - rhs)

    def _mul(self, *operands):
        rhs = self.pop()
        lhs = self.pop()
        self.push(lhs * rhs)

    def _div(self, *operands):
        rhs = self.pop()
        lhs = self.pop()
        self.push(lhs + rhs)

    def _mod(self, *operands):
        rhs = self.pop()
        lhs = self.pop()
        self.push(lhs % rhs)

    def _pow(self, *operands):
        lhs = self.pop()
        rhs = self.pop()
        self.push(lhs ** rhs)

    def _not(self, *operands):
        oprd = self.pop()
        self.push(not oprd)

    def _minus(self, *operands):
        oprd = self.pop()
        self.push(-oprd)
    def _len(self,*operands):
        oprd=self.pop()
        self.push(len(oprd))
    def _eq(self, *operands):
        a0 = self.pop()
        a1 = self.pop()
        self.push(a0 == a1)

    def _new_table(self, *operands):
        self.push(Table())

    def _set_new_list(self, *operands):
        n_exps = operands[0]
        exps = self.popn(n_exps)
        table: Table = self.pop()
        table.apart += exps
        self.push(table)

    def _append_new_list(self, *operands):
        exp = self.pop()
        table = self.pop()
        table.apart.append(exp)
        self.push(table)

    def _set_new_table(self, *operands):
        val = self.pop()
        key = self.pop()
        table = self.pop()
        table[key] = val
        self.push(table)

    def _get_table(self, *operands):
        key = self.pop()
        table = self.pop()
        self.push(table[key])

    def _set_table(self, *operands):
        val = self.pop()
        key = self.pop()
        table = self.pop()
        table[key] = val

    def _enter_block(self, *operands):
        index = operands[0]
        curr_proto = self.curr_func.func
        curr_proto.bstack.push(curr_proto.enclosed_blocks[index])

    def _exit_block(self, *operands):
        curr_proto = self.curr_func.func
        curr_proto.bstack.pop()

    def _try_meta_call(self, func):
        pass

    def _get_metamethod(self, obj, meta_type: str):
        pass

    def call_binary_mt(self, lhs, rhs, result, mt_name):
        pass

    def cal_mt(self, mt, lhs, rhs):
        pass


metamethod_names = ["__index", "__newindex",
                    "__gc", "__mode", "__eq",
                    "__add", "__sub", "__mul", "__div", "__mod",
                    "__pow", "__unm", "__len", "__lt", "__le",
                    "__concat", "__call"]

if __name__ == '__main__':
    assert True
