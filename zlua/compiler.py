'''
the compile stage part of zlua
'''
from functools import partial

from gen.zlua.LuaParser import LuaParser
from gen.zlua.LuaVisitor import LuaVisitor
from gen.zlua.LuaLexer import LuaLexer
from typing import *


class LuaCompileError(Exception):
    def __init__(self, msg):
        self.msg = msg

    def __str__(self):
        return self.msg.__str__()


class Scope:
    def __init__(self):
        self.enclosed_blocks: List[Block] = []
        self.locals = {}


class Upval:
    def __init__(self, state_func):
        self.state_func = state_func
        self.val = None

    def close(self):
        self.val = self.state_func()

    def __str__(self): return 'Upval'

    __repr__ = __str__


class Function: pass


class Proto(Scope, Function):

    def __init__(self):
        super().__init__()
        self.param_names: List[str] = None
        self.instrs: List[Instr] = []
        self.labels: Dict[str:int] = {}
        self.enclosed_protos = []
        self.scope_stack: List[Scope] = [self]  # 进入一个函数后会压入proto自己，然后每次进出block即压栈弹栈；换种说法，第一个是p自己，之后是blocks
        self.upvals: Dict[str:Upval] = {}
        self._label_counter = 0

    def _new_label(self):
        self._label_counter += 1
        return 'L' + str(self._label_counter)

    @property
    def curr_scope(self) -> Scope:
        return self.scope_stack[-1]

    @property
    def curr_locals(self):
        '''当前locals，注意不是“所有可见locals”，用于添加局部变量'''
        return self.curr_scope.locals

    @property
    def curr_enclosed_blocks(self):
        return self.curr_scope.enclosed_blocks

    def __getitem__(self, key):
        '''以当前可见scope查找key'''
        assert isinstance(key, str)
        for scope in reversed(self.scope_stack):
            if key in scope.locals:
                return scope.locals[key]

    def __setitem__(self, key, value):
        assert isinstance(key, str)
        for scope in reversed(self.scope_stack):
            if key in scope.locals:
                scope.locals[key]=value

    def __contains__(self, key):
        '''getitem的in版本，不重载这个可能导致误用in；功能有点不一样，这个是严格检查有没有key'''
        assert isinstance(key, str)
        for scope in reversed(self.scope_stack):
            if key in scope.locals:
                return True
        return False

    def enter_block(self):
        '''注意是编译期enter，要新建block和emit指令的'''
        new_b = Block()
        curr_ebs = self.curr_enclosed_blocks
        index = len(curr_ebs)
        self.scope_stack.append(new_b)
        curr_ebs.append(new_b)
        self.instrs.append(Instr('enter_block', index))

    def exit_block(self):
        self.instrs.append(Instr('exit_block'))
        self.scope_stack.pop()

    def __str__(self):
        return 'Proto'

    __repr__ = __str__


class Block(Scope):
    def __init__(self):
        super().__init__()

    def __str__(self): return 'Block'

    __repr__ = __str__


class Instr:

    def __init__(self, op, *operands):
        self.op = op
        self.operands = operands
        self.src_line_number = 0

    def __str__(self):
        return self.op + ' ' + ','.join(map(repr, self.operands))

    __repr__ = __str__


class LuaCompiler(LuaVisitor):
    def __init__(self):
        self.chunk_proto = Proto()
        self.pstack: List[Proto] = [self.chunk_proto]

    @property
    def _currp(self) -> Proto:
        return self.pstack[-1]

    def _emit(self, op, *operands):
        i = Instr(op, *operands)
        i.src_line_number = (self._curr_tree.start.line, self._curr_tree.start.getInputStream().strdata)
        self._currp.instrs.append(i)

    def _local_upval_global(self, name):
        '''分析右值name是从哪来的，local一定是local声明时已经加入符号表的，但是upval一定是右值，所以第一次要检查一下并注册到upval符号表
        global不需要符号表_G，默认就是有的
        '''
        assert isinstance(name, str)
        if name in self._currp:  # local一定是通过声明已经注册的
            return 'local'
        if name in self._currp.upvals:  # 已经注册的upval
            return 'upval'
        # 否则我们得第一次检查这个名字的作用域
        for p in reversed(self.pstack[:-1]):  # 栈顶是local p，前面检查过local了
            for scope in reversed(p.scope_stack):
                if name in scope.locals:
                    self._currp.upvals[name] = Upval(partial(lambda scope: scope.locals[name], scope=scope))
                    return 'upval'
        return 'global'

    def _handle_get_name(self, name):
        '''辅助生成指令'''
        lug = self._local_upval_global(name)  # ps，你一定会想直接+get前缀，debug时你就知道不直接了
        if lug == 'local':
            self._emit('get_local', name)
        elif lug == 'upval':
            self._emit('get_upval', name)
        elif lug == 'global':
            self._emit('get_global', name)

    def _handle_set_name(self, name):
        lug = self._local_upval_global(name)
        if lug == 'local':
            self._emit('set_local', name)
        elif lug == 'upval':
            self._emit('set_upval', name)
        elif lug == 'global':
            self._emit('set_global', name)

    # region handle literals
    def visitNumberExp(self, ctx: LuaParser.NumberExpContext):
        n = float(ctx.getText())
        self._emit('push_l', n)

    def visitStringExp(self, ctx: LuaParser.StringExpContext):
        self.visit(ctx.string())

    def visitString(self, ctx: LuaParser.StringContext):
        s = ctx.getText().strip('\'\"')
        self._emit('push_l', s)

    def visitNilfalsetrueExp(self, ctx: LuaParser.NilfalsetrueExpContext):
        switch = {
            LuaLexer.NilKW: lambda: self._emit('push_l', None),
            LuaLexer.FalseKW: lambda: self._emit('push_l', False),
            LuaLexer.TrueKW: lambda: self._emit('push_l', True)
        }
        switch[ctx.nilfalsetrue.type]()

    # endregion
    # region handle arithmetic
    def visitPowExp(self, ctx: LuaParser.PowExpContext):
        self.visit(ctx.lhs)
        self.visit(ctx.rhs)
        self._emit('pow')

    def visitUnmExp(self, ctx: LuaParser.UnmExpContext):
        self.visit(ctx.exp())
        switch = {
            LuaLexer.NotKW: lambda: self._emit('not'),
            LuaLexer.LenKW: lambda: self._emit('len'),
            LuaLexer.MinusKW: lambda: self._emit('minus')
        }
        switch[ctx.operatorUnary.type]()

    def visitMuldivExp(self, ctx: LuaParser.MuldivExpContext):
        self.visit(ctx.lhs)
        self.visit(ctx.rhs)
        switch = {
            LuaLexer.MulKW: lambda: self._emit('mul'),
            LuaLexer.DivKW: lambda: self._emit('div'),
            LuaLexer.ModKW: lambda: self._emit('mod')
        }
        switch[ctx.operatorMulDivMod.type]()

    def visitAddsubExp(self, ctx: LuaParser.AddsubExpContext):
        self.visit(ctx.lhs)
        self.visit(ctx.rhs)
        switch = {
            LuaLexer.AddKW: lambda: self._emit('add'),
            LuaLexer.MinusKW: lambda: self._emit('sub')
        }
        switch[ctx.operatorAddSub.type]()

    def visitConcatExp(self, ctx: LuaParser.ConcatExpContext):
        self.visit(ctx.lhs)
        self.visit(ctx.rhs)
        self._emit('concat')

    def visitCmpExp(self, ctx: LuaParser.CmpExpContext):
        self.visit(ctx.lhs)
        self.visit(ctx.rhs)
        switch = {
            LuaLexer.LtKW: lambda: self._emit('lt'),
            LuaLexer.MtKW: lambda: self._emit('mt'),
            LuaLexer.LeKW: lambda: self._emit('le'),
            LuaLexer.MeKW: lambda: self._emit('me'),
            LuaLexer.EqKW: lambda: self._emit('eq'),
            LuaLexer.NeKW: lambda: self._emit('ne')
        }
        switch[ctx.operatorComparison.type]()

    # endregion
    # region table ctor
    def visitTablectorExp(self, ctx: LuaParser.TablectorExpContext):
        self.visit(ctx.tableconstructor())

    def visitTableconstructor(self, ctx: LuaParser.TableconstructorContext):
        self._emit('new_table')
        self.visitChildren(ctx)

    def visitKeyValField(self, ctx: LuaParser.KeyValFieldContext):
        self.visitChildren(ctx)
        self._emit('set_new_table')

    def visitNameValField(self, ctx: LuaParser.NameValFieldContext):
        self._emit('push_l', ctx.NAME().getText())
        self.visit(ctx.exp())
        self._emit('set_new_table')

    def visitExpField(self, ctx: LuaParser.ExpFieldContext):
        self.visit(ctx.exp())
        self._emit('append_new_list')

    # endregion
    # region prefixexp
    def visitLvalueVar(self, ctx: LuaParser.LvalueVarContext):
        self._handle_get_name(ctx.NAME().getText())
        list(map(self.visit, ctx.varSuffix()))

    def visitDotGetter(self, ctx: LuaParser.DotGetterContext):
        self._emit('push_l', ctx.NAME().getText())
        self._emit('get_table')

    def visitNormalGetter(self, ctx: LuaParser.NormalGetterContext):
        self.visit(ctx.exp())
        self._emit('get_table')

    def visitNameAndArgs(self, ctx: LuaParser.NameAndArgsContext):
        if ctx.NAME():
            self._emit('self', ctx.NAME().getText())
        self.visit(ctx.args())

    def visitNormalArgs(self, ctx: LuaParser.NormalArgsContext):
        n_args = 0
        if ctx.explist():
            exps = ctx.explist().exp()
            n_args = len(exps)
            list((map(self.visit, exps)))
        self._emit('call', n_args)

    def visitTablectorArgs(self, ctx: LuaParser.TablectorArgsContext):
        n_args = 1
        self.visit(ctx.tableconstructor())
        self._emit('call', n_args)

    def visitStringArgs(self, ctx: LuaParser.StringArgsContext):
        n_args = 1
        self.visit(ctx.string())
        self._emit('call', n_args)

    # endregion
    # region assign stat
    def visitLocalDeclarationStat(self, ctx: LuaParser.LocalDeclarationStatContext):
        names = list(map(lambda x: x.getText(), ctx.namelist().NAME()))
        exps = ctx.explist().exp() if ctx.explist() else []
        for exp in exps:
            self.visit(exp)
        for name in names:  # 在locals里创建新局部变量
            if name in self._currp:
                raise Exception('重复声明标识符')
            self._currp.curr_locals[name] = None
        if len(exps) == 0: return  # 'local a'直接跳过
        if len(names) > 1:
            if len(exps) == 1:
                # eg. local a,b,c={1,2,3} or f()
                self._emit('unpack', len(names))

            self._emit('new_locals', *names)
        else:
            self._emit('set_local', names[0])

    def visitAssignStat(self, ctx: LuaParser.AssignStatContext):
        tag, o = self.visit(ctx.lvalue())
        self.visit(ctx.exp())
        if tag == 'nameLvalue':
            self._handle_set_name(o)
        else:
            self._emit('set_table')

    def visitNameLvalue(self, ctx: LuaParser.NameLvalueContext):
        return 'nameLvalue', ctx.NAME().getText()

    def visitFieldLvalue(self, ctx: LuaParser.FieldLvalueContext):
        self.visitChildren(ctx)
        return 'fieldLvalue', None

    def visitNormalSetter(self, ctx: LuaParser.NormalSetterContext):
        self.visit(ctx.exp())

    def visitDotSetter(self, ctx: LuaParser.DotSetterContext):
        self._emit('push_l', ctx.NAME().getText())

    # region function def
    def visitFunctiondefExp(self, ctx: LuaParser.FunctiondefExpContext):
        index = len(self._currp.enclosed_protos)
        self.visit(ctx.functiondef().funcbody())
        self._emit('proto', index)

    def visitFunctiondefStat(self, ctx: LuaParser.FunctiondefStatContext):
        # 'function' funcname funcbody #functiondefStat
        # funcname: NAME tableOrFunc methodname; //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name
        # tableOrFunc:('.' NAME)*;
        # methodname:(':' NAME)?;
        name = ctx.funcname().NAME().getText()
        index = len(self._currp.enclosed_protos)
        fn = ctx.funcname()
        mn = fn.methodname().NAME()
        tof = fn.tableOrFunc().NAME()
        if not mn and not tof:
            # 'function f() end'
            self.visit(ctx.funcbody())
            self._emit('proto', index)
            self._emit('set_global', name)
        else:
            self._handle_get_name(name)
            if tof:  # 'local t={["obj"]={}}; function t.obj:m() end'
                names = list(map(lambda x: x.getText(), tof))
                if len(names) > 1:
                    for i in names[:-1]:
                        self._emit('push_l', i)
                        self._emit('get_table')
                self._emit('push_l', names[-1])
                if mn:
                    self._emit('get_table')
            if mn:
                # 'local obj={}; function obj:m() end'
                self._emit('push_l', mn.getText())
            self.visit(ctx.funcbody())
            self._emit('proto', index)
            if mn:
                self._currp.enclosed_protos[index].param_names.insert(0, 'self')
            self._emit('set_table')

    def visitLocalfunctiondefStat(self, ctx: LuaParser.LocalfunctiondefStatContext):
        # 'local' 'function' NAME funcbody #localfunctiondefStat
        name = ctx.NAME().getText()
        index = len(self._currp.enclosed_protos)
        self._currp.curr_locals[name] = None
        self.visit(ctx.funcbody())
        self._emit('proto', index)  # closure runtime创建其实只是为了proto序列化
        self._emit('set_local', name)  # 我们的很多东西其实已经直接放入你可以

    def visitFuncbody(self, ctx: LuaParser.FuncbodyContext):
        new_p = Proto()
        self._currp.enclosed_protos.append(new_p)
        self.pstack.append(new_p)
        if ctx.parlist():  # 可选项一定要检查null
            param_names = list(map(lambda x: x.getText(), ctx.parlist().namelist().NAME()))
            self._currp.param_names = param_names
            self._currp.curr_locals[
                'self'] = None  # 这是一个妥协，self虽然不是关键字，其实就是关键字，你不该用它声明局部变量，这里是因为method的情况，self在funcbody外处理。要么把new proto移出去，那很烦
            for i in param_names:
                self._currp.curr_locals[i] = None  # 形参加入符号表
        else:
            self._currp.param_names = []  # 一个corner case，没形参列表时也要初始化
        self.visit(ctx.block())
        self._emit('ret', 0)
        self.pstack.pop()

    def visitRetstat(self, ctx: LuaParser.RetstatContext):
        # retstat: 'return' explist? ';'?;
        if ctx.explist():
            exps = ctx.explist().exp()
            n_exps = len(exps)
            if n_exps > 1:
                self._emit('new_table')
            list(map(self.visit, exps))
            if n_exps > 1:
                self._emit('set_new_list', n_exps)  # 大于一个值要压缩成table
            self._emit('ret', 1)
        else:
            self._emit('ret', 0)

    def visitDoendStat(self, ctx: LuaParser.DoendStatContext):
        self._currp.enter_block()
        self.visitChildren(ctx)
        self._currp.exit_block()

    def visitChunk(self, ctx: LuaParser.ChunkContext):
        self.visitChildren(ctx)
        self._emit('ret', 0)

    # endregion
    # region ctrl flow and relation operation
    # | 'break' #breakStat
    # | 'while' exp 'do' block 'end' #whileStat
    # | 'if' exp 'then' block elseifBlock* elseBlock? 'end' #ifelseStat
    # | 'for' NAME '=' exp ',' exp (',' exp)? 'do' block 'end' #forijkStat
    # | 'for' namelist 'in' explist 'do' block 'end' #forinStat
    def _register_label(self, label):
        self._currp.labels[label] = len(self._currp.instrs) - 1

    def visitWhileStat(self, ctx: LuaParser.WhileStatContext):
        nl1 = self._currp._new_label()
        nl2 = self._currp._new_label()
        nl3 = self._currp._new_label()
        self._emit('jmp', nl1)
        self._register_label(nl2)
        self._currp.enter_block()
        self.visit(ctx.block())
        self._currp.exit_block()  # while cond exp is outside the block
        self._register_label(nl1)
        self.visit(ctx.exp())
        self._emit('test')
        self._emit('jmp', nl3)  # just for correctness, false => jmp
        self._emit('jmp', nl2)
        self._register_label(nl3)

    def visitIfelseStat(self, ctx: LuaParser.IfelseStatContext):
        '''
        'if' exp 'then' block elseifBlock* elseBlock? 'end' #ifelseStat
        elseifBlock:'elseif' exp 'then' block;
        elseBlock:'else' block;'''
        eibs = ctx.elseifBlock()
        labels = [self._currp._new_label() for i in range(len(eibs) + 1)]
        end = self._currp._new_label()
        self.visit(ctx.exp())
        self._emit('test')
        self._emit('jmp', labels[0])
        self._currp.enter_block()
        self.visit(ctx.block())
        self._currp.exit_block()
        for i in range(len(eibs)):
            self._register_label(labels[i])
            self.visit(eibs[i].exp())
            self._emit('test')
            self._emit('jmp', labels[i + 1])
            self._currp.enter_block()
            self.visit(eibs[i].block())
            self._currp.exit_block()
            self._emit('jmp', end)
        self._register_label(labels[-1])
        if ctx.elseBlock():
            self._currp.enter_block()
            self.visit(ctx.elseBlock())
            self._currp.exit_block()
        self._register_label(end)

    def visitForijkStat(self, ctx: LuaParser.ForijkStatContext):
        # 'for' NAME '=' exp ',' exp (',' exp)? 'do' block 'end' #forijkStat
        nl2 = self._currp._new_label()
        nl3 = self._currp._new_label()
        name = ctx.NAME().getText()
        list(map(self.visit, ctx.exp()))
        self._currp.enter_block()
        self._currp.curr_locals[name] = None  # 加入符号表，因为是第一个local，不用检查重名
        self._emit('for_ijk_prep', name, len(ctx.exp()))
        self._emit('jmp', nl3)
        self._register_label(nl2)
        self.visit(ctx.block())
        # self.visit(ctx.exp()) 这是从while复制过来的，保留。看一下区别
        # self._emit('test') 我们不要test，因为bool是指令计算出来的
        self._emit('for_ijk_loop', name)
        self._emit('jmp', nl3)  # just for correctness, false => jmp
        self._emit('jmp', nl2)
        self._register_label(nl3)
        self._currp.exit_block()  # 注意name在循环体作用域内

    def visitForinStat(self, ctx: LuaParser.ForinStatContext):
        # 'for' namelist 'in' explist 'do' block 'end' #forinStat
        kname, vname = list(map(lambda x: x.getText(), ctx.NAME()))
        nl1 = self._currp._new_label()
        nl2 = self._currp._new_label()
        nl3 = self._currp._new_label()
        self._currp.enter_block()
        self._currp.curr_locals[kname] = None
        self._currp.curr_locals[vname] = None
        self.visit(ctx.exp())
        self._emit('for_in_prep', kname, vname)
        self._emit('jmp', nl1)
        self._register_label(nl2)
        self.visit(ctx.block())
        self._register_label(nl1)
        self._emit('for_in_loop', kname, vname)
        self._emit('jmp', nl3)  # just for correctness, false => jmp
        self._emit('jmp', nl2)
        self._register_label(nl3)
        self._currp.exit_block()  # 注意name在循环体作用域内

    # endregion
    def visitAndExp(self, ctx: LuaParser.AndExpContext):
        nl1 = self._currp._new_label()
        self.visit(ctx.lhs)
        self._emit('test_and')
        self._emit('jmp', nl1)
        self.visit(ctx.rhs)
        self._emit('and')
        self._register_label(nl1)

    def visitOrExp(self, ctx: LuaParser.OrExpContext):
        nl1 = self._currp._new_label()
        self.visit(ctx.lhs)
        self._emit('test_or')
        self._emit('jmp', nl1)
        self.visit(ctx.rhs)
        self._emit('or')
        self._register_label(nl1)

    def visitFunctioncallStat(self, ctx: LuaParser.FunctioncallStatContext):
        self.visitChildren(ctx)
        self._emit('procedure_pop')

    def visitErrorNode(self, node):
        # node.symbol.getInputStream().getText(start,end) 没用，你拿不到行
        # node.symbol.line symbol是Token，line是行号，没用，没有行api。因此你放弃把。拿不到什么信息
        raise SyntaxError('lua syntax error: ')  # + node.symbol.getInputStream().strdata)

    def visit(self, tree):
        self._curr_tree = tree
        return tree.accept(self)


if __name__ == '__main__':
    pass
