'''
the runtime stage part of zlua

'''

from typing import *

from compiler import Proto
from type_model import Table, lua_not, lua_cond_true_false, get_metamethod


class Closure: pass


class PythonClosure(Closure):
    def __init__(self, py_func):
        self.py_func = py_func

    def __call__(self, *args):
        return self.py_func(*args)


class LuaClosure(Closure):

    def __init__(self, func: Proto):
        self.saved_pc = 0
        self.p: Proto = func
        self.exp_stack = []  # "stack-based vm"


class LuaThread:
    def __init__(self):
        self.frame_stack: List[LuaClosure] = []
        self.globals: Dict[str,] = {}
        self.pc = 0

        def lua_assert(b):
            assert b

        self.register(lua_assert, 'assert')
        self.register(print, 'print')

    def register(self, python_func, name):
        self.globals[name] = PythonClosure(python_func)

    @property
    def curr_cl(self) -> LuaClosure:
        return self.frame_stack[-1]

    @property
    def _instrs(self):  # just for debug
        return self.curr_cl.p.instrs

    def push(self, val):
        self.curr_cl.exp_stack.append(val)

    def pop(self):
        return self.curr_cl.exp_stack.pop()

    def pushn(self, l: list):
        self.curr_cl.exp_stack += l  # [1]+=[2,3] => [1,2,3]

    def popn(self, n):
        '''正序弹出n个栈顶元素，eg s=[1,2,3,4], popn(2) => [3,4]'''
        assert n >= 0
        if n > 0:
            exps = self.curr_cl.exp_stack[-n:]  # tricky: [1,2,3][-1:] => [3] but [1,2,3][-0:] => [1,2,3]
            del self.curr_cl.exp_stack[-n:]
            return exps
        else:
            return []

    def execute(self):
        while True:
            self.curr_instr = self.curr_cl.p.instrs[self.pc]
            op_name = self.curr_instr.op
            operands = self.curr_instr.operands
            if op_name in binary_arith_op:
                self._binary(op_name)
            elif getattr(self, '_' + op_name)(*operands) == 'return from chunk':  # 为了能从chunk返回
                return
            self.pc += 1

    def _push_l(self, *operands):
        o = operands[0]
        self.push(o)

    def _get_upval(self, *operands):
        name = operands[0]
        self.push(self.curr_cl.p.upvals[name].val)

    def _set_upval(self, *operands):
        name = operands[0]
        self.curr_cl.p.upvals[name].val = self.pop()

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
        self.curr_cl.p.curr_locals.update(dict(zip(names, exps)))

    def _get_local(self, *operands):
        name = operands[0]
        self.push(self.curr_cl.p[name])

    def _set_local(self, *operands):
        name = operands[0]
        self.curr_cl.p[name] = self.pop()

    def _call(self, *operands):
        n_args = operands[0]
        args = self.popn(n_args)
        closure = self.pop()
        if not isinstance(closure, Closure):  # 不是函数，尝试元方法
            try:
                closure = get_metamethod(closure, '__call')
                if not isinstance(closure, Closure):
                    raise TypeError('对象不可调用')  # __call不是函数
            except TypeError:
                raise TypeError('对象不可调用')  # 没有metatable字段

        if isinstance(closure, LuaClosure):
            self.curr_cl.saved_pc = self.pc
            self.frame_stack.append(closure)
            closure.p.locals.update(
                dict(zip(closure.p.param_names, args)))  # 这句很复杂，一行把param names和args组合起来加入locals
            for uv in closure.p.upvals.values():
                uv.close()
            self.pc = -1
        else:
            assert isinstance(closure, PythonClosure)
            ret_val = closure(*args)
            self.push(ret_val)  # push ret val

    def _call_procedure(self, *operands):
        self._call(*operands)
        self.pop()  # 抛弃返回值

    def _closure(self, *operands):
        index = operands[0]
        lc = LuaClosure(self.curr_cl.p.enclosed_protos[index])
        self.push(lc)

    def _ret(self, *operands):
        n_ret = operands[0]
        ret_val = None
        if n_ret == 1:  # ret 0则返回值为None，否则弹出一个值
            ret_val = self.pop()
        self.frame_stack.pop()
        if not self.frame_stack:
            return 'return from chunk'
        self.pc = self.curr_cl.saved_pc
        self.push(ret_val)

    def _procedure_pop(self, *operands):
        self.pop()

    def _self(self, *operands):
        func_name = operands[0]
        table: Table = self.pop()
        self.push(table[func_name])
        self.push(table)

    def _unary(self, op):
        oprd = self.pop()
        self.push(op(oprd))

    def _binary(self, op_name):
        rhs = self.pop()
        lhs = self.pop()
        direct_or_mt = isinstance(lhs, (float, int)) and isinstance(rhs, (float, int))
        if direct_or_mt:
            self.push(binary_arith_op[op_name](lhs, rhs))
        else:
            mt_name = '__' + op_name
            mt = None
            # 尝试调用元方法，如果没有说明错误，这里因为python不支持赋值是表达式，所以不能短路，判断丑了点
            if mt_name in metamethod_names:
                mt = get_metamethod(lhs, mt_name) or get_metamethod(rhs, mt_name)
                if mt:
                    self.push(mt)
                    self.push(lhs)
                    self.push(rhs)
                    self._call(2)
            if not mt:
                raise TypeError('操作数不支持 ', op_name)

    def _concat(self, *operands):
        rhs = self.pop()
        lhs = self.pop()
        if isinstance(lhs, str) and isinstance(rhs, str):
            self.push(lhs + rhs)
        else:
            raise TypeError('只有字符串可以concat')

    def _jmp(self, *operands):
        label = operands[0]
        abs_addr = self.curr_cl.p.labels[label]
        self.pc = abs_addr

    def _not(self, *operands):
        self._unary(lua_not)

    def _test(self, *operands):
        oprd = self.pop()
        if lua_cond_true_false(oprd):
            self.pc += 1

    def _test_and(self, *operands):
        oprd = self.pop()
        if lua_cond_true_false(oprd):
            self.pc += 1
        self.push(oprd)

    def _test_or(self, *operands):
        oprd = self.pop()
        if not lua_cond_true_false(oprd):
            self.pc += 1
        self.push(oprd)

    def _minus(self, *operands):
        self._unary(lambda x: -x)

    def _len(self, *operands):
        self._unary(len)

    def _for_ijk_prep(self, *operands):
        k = 1
        name, len = operands
        if len == 3: k = self.pop()
        j = self.pop()
        i = self.pop()
        self.curr_cl.p.curr_locals['@' + name] = (j, k)  # j:limit k:step
        self.curr_cl.p.curr_locals[name] = i - k  # 倒退一步，因为for loop每次都加，一开始要倒退一步

    def _for_ijk_loop(self, *operands):
        name = operands[0]
        j, k = self.curr_cl.p.curr_locals['@' + name]
        i = self.curr_cl.p.curr_locals[name]
        if i + k <= j:
            self.curr_cl.p.curr_locals[name] = i + k
            self.pc += 1

    def _for_in_prep(self, *operands):
        kname, vname = operands
        table = self.pop()
        self.curr_cl.p.curr_locals['@iter'] = table.__iter__()

    def _for_in_loop(self, *operands):
        kname, vname = operands
        iter = self.curr_cl.p.curr_locals['@iter']
        try:
            kval, vval = next(iter)
            self.curr_cl.p.curr_locals[kname] = kval
            self.curr_cl.p.curr_locals[vname] = vval
            self.pc += 1
        except StopIteration:
            pass

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
        val = None
        while key not in table:
            table = get_metamethod(table, '__getter')
        else:
            val = table[key]
        self.push(val)

    def _set_table(self, *operands):
        val = self.pop()
        key = self.pop()
        table = self.pop()
        while key not in table:
            table = get_metamethod(table, '__setter')
        else:
            table[key] = val

    def _enter_block(self, *operands):
        index = operands[0]
        curr_proto = self.curr_cl.p
        curr_proto.scope_stack.append(curr_proto.curr_enclosed_blocks[index])

    def _exit_block(self, *operands):
        curr_proto = self.curr_cl.p
        curr_proto.scope_stack.pop()


metamethod_names = ["__getter", "__setter",  # table 替代了index和newindex，垃圾名字
                    "__call",  # func
                    "__eq",  # eq
                    "__add", "__sub", "__mul", "__div", "__mod", "__pow",  # arith
                    "__unm", "__len",  # unary
                    "__lt", "__le",  # relation op
                    ]
from operator import *

binary_arith_op = {
    'add': add,
    'sub': sub,
    'mul': mul,
    'div': truediv,
    'mod': mod,
    'pow': pow,
    'and': lambda x, y: x and y,
    'or': lambda x, y: x or y,
    'eq': eq,
    'ne': ne,
    'lt': lt,
    'le': le,
    'mt': lambda x, y: x > y,
    'me': lambda x, y: x >= y,
}

if __name__ == '__main__':
    assert True
