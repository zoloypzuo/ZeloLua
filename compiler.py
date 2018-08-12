'''
the compile stage part of zlua
'''
from gen.zlua.LuaParser import LuaParser
from gen.zlua.LuaVisitor import LuaVisitor
from gen.zlua.LuaLexer import LuaLexer
from typing import *


class Proto:

    def __init__(self):
        self.param_names: List[str] = None
        self.instrs: List[Instr] = []
        self.labels: Dict[str:int] = {}
        self.locals = {}
        self.enclosed_protos = []
        self.enclosed_blocks = []
        self.bstack: List[Block] = []
        self.upvals = {}

    @property
    def _curr_scope(self):
        if self.bstack:
            return self.bstack[-1]
        else:
            return self

    @property
    def curr_locals(self):
        '''当前locals，'''
        return self._curr_scope.locals

    @property
    def _curr_enclosed_bs(self):
        return self._curr_scope.enclosed_blocks

    def __getitem__(self, key):
        '''以当前可见scope查找key，如果是block可能在上层，如果proto找不到说明没有'''
        assert isinstance(key, str)
        for i in reversed(self.bstack):
            if key in i.locals:
                return i.locals[key]
        return self.locals[key]

    def __setitem__(self, key, value):
        assert isinstance(key, str)
        self.bstack[-1].locals[key] = value

    def __contains__(self, key):
        '''getitem的in版本，不重载可能误用in'''
        assert isinstance(key, str)
        for i in reversed(self.bstack):
            if key in i.locals:
                return True
        if key in self.locals: return True
        return False

    def enter_newb(self):
        new_b = Block()
        self.bstack.append(new_b)
        curr_enclosed_bs = self._curr_enclosed_bs
        index = len(curr_enclosed_bs)
        curr_enclosed_bs.append(new_b)
        self.instrs.append('enter_block', index)

    def exit_b(self):
        self.instrs.append('exit_block')
        self._curr_enclosed_bs.pop()


class Block:
    def __init__(self):
        self.enclosed_blocks: List[Block] = []
        self.locals = {}


class Instr:

    def __init__(self, op, *operands):
        self.op = op
        self.operands = operands

    def __str__(self):
        return self.op + ' ' + ','.join(map(repr, self.operands))


class LuaCompiler(LuaVisitor):
    def __init__(self):
        self.pstack: List[Proto] = []
        self.chunk_proto = Proto()
        self.pstack.append(self.chunk_proto)

    @property
    def _currp(self) -> Proto:
        return self.pstack[-1]

    def _emit(self, op, *operands):
        self._currp.instrs.append(Instr(op, *operands))

    def _local_upval_global(self, name):
        '''分析右值name是从哪来的，local一定是local声明时已经加入符号表的，但是upval一定是右值，所以第一次要检查一下并注册到upval符号表
        global不需要符号表_G，默认就是有的
        '''
        assert isinstance(name, str)
        if name in self._currp:
            return 'local'
        if name in self._currp.upvals:
            return 'upval'
        locals = None
        for p in (reversed(self.pstack[:-1]) if len(self.pstack) > 0 else []):  # 检查pstack为空
            for b in reversed(p.bstack):
                if name in b.locals:
                    locals = b.locals
                    break
            if name in p.locals:
                locals = p.locals
        if locals:
            self._currp.upvals[name] = lambda: locals[name]
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

    def _handle_exp(self, ret: tuple):
        '''辅助为exp生成指令,ret就是visit*的返回值，本身是tuple'''
        tag, o = ret
        if tag == 'name': pass

    # region handle literals
    def visitNumberExp(self, ctx: LuaParser.NumberExpContext):
        n = float(ctx.getText())
        self._emit('push_l', n)

    def visitStringExp(self, ctx: LuaParser.StringExpContext):
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
    # region function def, table ctor
    def visitFunctiondefExp(self, ctx: LuaParser.FunctiondefExpContext):
        pass

    def visitTablectorExp(self, ctx: LuaParser.TablectorExpContext):
        pass

    # endregion
    # region tough ones
    def visitLvalueName(self, ctx: LuaParser.LvalueNameContext):
        self._handle_get_name(ctx.NAME().getText())  # 这里我们自然地处理了很多（很难做好）
        list(map(self.visit, ctx.varSuffix()))

    def visitVarSuffix(self, ctx: LuaParser.VarSuffixContext):
        list(map(self.visit, ctx.nameAndArgs()))
        self.visit(ctx.exp())
        name = ctx.NAME()
        if name:  # 这里是alternative，用if null简单判断一下
            self._emit('push_l', name)  # 这里name是一个str key
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

    def visitAndExp(self, ctx: LuaParser.AndExpContext):
        pass

    def visitOrExp(self, ctx: LuaParser.OrExpContext):
        pass

    # endregion
    # region
    def visitLocalDeclarationStat(self, ctx: LuaParser.LocalDeclarationStatContext):
        names = list(map(lambda x: x.getText(), ctx.namelist().NAME()))
        exps = ctx.explist().exp()
        for exp in exps:
            self.visit(exp)
        for name in names:  # 在locals里创建新局部变量
            if name in self._currp.curr_locals:
                raise Exception('重复声明标识符')
            self._currp.curr_locals[name] = None
        if len(names) > 1:
            if len(exps) == 1:
                # eg. local a,b,c={1,2,3} or f()
                self._emit('unpack', len(names))

            self._emit('new_locals', *names)
        else:
            self._emit('set_local', names[0])

    def visitAssignStat(self, ctx: LuaParser.AssignStatContext):
        pass

    def visitFunctiondefStat(self, ctx: LuaParser.FunctiondefStatContext):
        self.visit(ctx.funcbody())

    def visitLocalfunctiondefStat(self, ctx: LuaParser.LocalfunctiondefStatContext):
        name = ctx.NAME().getText()
        index = len(self._currp.enclosed_protos)
        self._currp.curr_locals[name] = None
        self.visit(ctx.funcbody())
        self._emit('closure', index)  # closure runtime创建其实只是为了proto序列化
        self._emit('set_local', name)  # 我们的很多东西其实已经直接放入你可以

    def visitFuncbody(self, ctx: LuaParser.FuncbodyContext):
        new_p = Proto()
        self.pstack.append(new_p)
        self._currp.enclosed_protos.append(new_p)
        if ctx.parlist():  # 可选项一定要检查null
            param_names = list(map(lambda x: x.getText(), ctx.parlist().namelist()))
            self._currp.param_names = param_names
            for i in param_names:
                self._currp.curr_locals[i] = None  # 形参加入符号表
        self.visit(ctx.block())
        self._emit('ret', 0)
        self.pstack.pop()

    def visitDoendStat(self, ctx: LuaParser.DoendStatContext):
        self._currp.enter_newb()
        self.visitChildren(ctx)
        self._currp.exit_b()

    def visitRetstat(self, ctx: LuaParser.RetstatContext):
        # retstat: 'return' explist? ';'?;
        if ctx.explist():
            exps = ctx.explist().exp()
            n_exps = len(exps)
            if n_exps > 1:
                self._emit('new_table')
            list(map(self.visit, exps))
            if n_exps > 1:
                self._emit('set_list', n_exps)  # 大于一个值要压缩成table
            self._emit('ret', 1)
        else:
            self._emit('ret', 0)

    # endregion
    def visitChunk(self, ctx: LuaParser.ChunkContext):
        self.visitChildren(ctx)
        self._emit('ret', 0)


if __name__ == '__main__':
    pass
