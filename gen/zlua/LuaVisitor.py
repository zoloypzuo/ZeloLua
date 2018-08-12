# Generated from C:/Users/91018/Documents/GitHub/zlua_prototype\Lua.g4 by ANTLR 4.7
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .LuaParser import LuaParser
else:
    from LuaParser import LuaParser

# This class defines a complete generic visitor for a parse tree produced by LuaParser.

class LuaVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by LuaParser#chunk.
    def visitChunk(self, ctx:LuaParser.ChunkContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#block.
    def visitBlock(self, ctx:LuaParser.BlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#retstat.
    def visitRetstat(self, ctx:LuaParser.RetstatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#emptyStat.
    def visitEmptyStat(self, ctx:LuaParser.EmptyStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#assignStat.
    def visitAssignStat(self, ctx:LuaParser.AssignStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functioncallStat.
    def visitFunctioncallStat(self, ctx:LuaParser.FunctioncallStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#breakStat.
    def visitBreakStat(self, ctx:LuaParser.BreakStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#doendStat.
    def visitDoendStat(self, ctx:LuaParser.DoendStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#whileStat.
    def visitWhileStat(self, ctx:LuaParser.WhileStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#ifelseStat.
    def visitIfelseStat(self, ctx:LuaParser.IfelseStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#forijkStat.
    def visitForijkStat(self, ctx:LuaParser.ForijkStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#forinStat.
    def visitForinStat(self, ctx:LuaParser.ForinStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functiondefStat.
    def visitFunctiondefStat(self, ctx:LuaParser.FunctiondefStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#localfunctiondefStat.
    def visitLocalfunctiondefStat(self, ctx:LuaParser.LocalfunctiondefStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#localDeclarationStat.
    def visitLocalDeclarationStat(self, ctx:LuaParser.LocalDeclarationStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#elseifBlock.
    def visitElseifBlock(self, ctx:LuaParser.ElseifBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#elseBlock.
    def visitElseBlock(self, ctx:LuaParser.ElseBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#funcname.
    def visitFuncname(self, ctx:LuaParser.FuncnameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#tableOrFunc.
    def visitTableOrFunc(self, ctx:LuaParser.TableOrFuncContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#methodname.
    def visitMethodname(self, ctx:LuaParser.MethodnameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#varlist.
    def visitVarlist(self, ctx:LuaParser.VarlistContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#namelist.
    def visitNamelist(self, ctx:LuaParser.NamelistContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#explist.
    def visitExplist(self, ctx:LuaParser.ExplistContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#doc.
    def visitDoc(self, ctx:LuaParser.DocContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#muldivExp.
    def visitMuldivExp(self, ctx:LuaParser.MuldivExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functiondefExp.
    def visitFunctiondefExp(self, ctx:LuaParser.FunctiondefExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#numberExp.
    def visitNumberExp(self, ctx:LuaParser.NumberExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#andExp.
    def visitAndExp(self, ctx:LuaParser.AndExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#concatExp.
    def visitConcatExp(self, ctx:LuaParser.ConcatExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#orExp.
    def visitOrExp(self, ctx:LuaParser.OrExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#unmExp.
    def visitUnmExp(self, ctx:LuaParser.UnmExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#prefixexpExp.
    def visitPrefixexpExp(self, ctx:LuaParser.PrefixexpExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#addsubExp.
    def visitAddsubExp(self, ctx:LuaParser.AddsubExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#cmpExp.
    def visitCmpExp(self, ctx:LuaParser.CmpExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#powExp.
    def visitPowExp(self, ctx:LuaParser.PowExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#stringExp.
    def visitStringExp(self, ctx:LuaParser.StringExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nilfalsetrueExp.
    def visitNilfalsetrueExp(self, ctx:LuaParser.NilfalsetrueExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#tablectorExp.
    def visitTablectorExp(self, ctx:LuaParser.TablectorExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#prefixexp.
    def visitPrefixexp(self, ctx:LuaParser.PrefixexpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functioncall.
    def visitFunctioncall(self, ctx:LuaParser.FunctioncallContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#varOrExp.
    def visitVarOrExp(self, ctx:LuaParser.VarOrExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#lvalueName.
    def visitLvalueName(self, ctx:LuaParser.LvalueNameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#rvalueName.
    def visitRvalueName(self, ctx:LuaParser.RvalueNameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#varSuffix.
    def visitVarSuffix(self, ctx:LuaParser.VarSuffixContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nameAndArgs.
    def visitNameAndArgs(self, ctx:LuaParser.NameAndArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#normalArgs.
    def visitNormalArgs(self, ctx:LuaParser.NormalArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#tablectorArgs.
    def visitTablectorArgs(self, ctx:LuaParser.TablectorArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#stringArgs.
    def visitStringArgs(self, ctx:LuaParser.StringArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functiondef.
    def visitFunctiondef(self, ctx:LuaParser.FunctiondefContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#funcbody.
    def visitFuncbody(self, ctx:LuaParser.FuncbodyContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#parlist.
    def visitParlist(self, ctx:LuaParser.ParlistContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#tableconstructor.
    def visitTableconstructor(self, ctx:LuaParser.TableconstructorContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#fieldlist.
    def visitFieldlist(self, ctx:LuaParser.FieldlistContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#field.
    def visitField(self, ctx:LuaParser.FieldContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#fieldsep.
    def visitFieldsep(self, ctx:LuaParser.FieldsepContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#number.
    def visitNumber(self, ctx:LuaParser.NumberContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#string.
    def visitString(self, ctx:LuaParser.StringContext):
        return self.visitChildren(ctx)



del LuaParser