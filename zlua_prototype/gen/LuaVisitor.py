# Generated from C:/Users/91018/Documents/GitHub/zlua_prototype\Lua.g4 by ANTLR 4.7.2
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


    # Visit a parse tree produced by LuaParser#functionCallStat.
    def visitFunctionCallStat(self, ctx:LuaParser.FunctionCallStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#breakStat.
    def visitBreakStat(self, ctx:LuaParser.BreakStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#doStat.
    def visitDoStat(self, ctx:LuaParser.DoStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#whileStat.
    def visitWhileStat(self, ctx:LuaParser.WhileStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#repeatStat.
    def visitRepeatStat(self, ctx:LuaParser.RepeatStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#ifStat.
    def visitIfStat(self, ctx:LuaParser.IfStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#forNmericStat.
    def visitForNmericStat(self, ctx:LuaParser.ForNmericStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#forGenericStat.
    def visitForGenericStat(self, ctx:LuaParser.ForGenericStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functionDefStat.
    def visitFunctionDefStat(self, ctx:LuaParser.FunctionDefStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#localFunctionDefStat.
    def visitLocalFunctionDefStat(self, ctx:LuaParser.LocalFunctionDefStatContext):
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


    # Visit a parse tree produced by LuaParser#dotName.
    def visitDotName(self, ctx:LuaParser.DotNameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#colonName.
    def visitColonName(self, ctx:LuaParser.ColonNameContext):
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


    # Visit a parse tree produced by LuaParser#nilExp.
    def visitNilExp(self, ctx:LuaParser.NilExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#numberExp.
    def visitNumberExp(self, ctx:LuaParser.NumberExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#andExp.
    def visitAndExp(self, ctx:LuaParser.AndExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#tableCtorExp.
    def visitTableCtorExp(self, ctx:LuaParser.TableCtorExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functionDefExp.
    def visitFunctionDefExp(self, ctx:LuaParser.FunctionDefExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#concatExp.
    def visitConcatExp(self, ctx:LuaParser.ConcatExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#orExp.
    def visitOrExp(self, ctx:LuaParser.OrExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#prefixexpExp.
    def visitPrefixexpExp(self, ctx:LuaParser.PrefixexpExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#compareExp.
    def visitCompareExp(self, ctx:LuaParser.CompareExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#varargExp.
    def visitVarargExp(self, ctx:LuaParser.VarargExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#mulOrDivOrModExp.
    def visitMulOrDivOrModExp(self, ctx:LuaParser.MulOrDivOrModExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#trueExp.
    def visitTrueExp(self, ctx:LuaParser.TrueExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#unaryExp.
    def visitUnaryExp(self, ctx:LuaParser.UnaryExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#addOrSubExp.
    def visitAddOrSubExp(self, ctx:LuaParser.AddOrSubExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#powExp.
    def visitPowExp(self, ctx:LuaParser.PowExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#falseExp.
    def visitFalseExp(self, ctx:LuaParser.FalseExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#stringExp.
    def visitStringExp(self, ctx:LuaParser.StringExpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#opUnary.
    def visitOpUnary(self, ctx:LuaParser.OpUnaryContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#opMulOrDivOrMod.
    def visitOpMulOrDivOrMod(self, ctx:LuaParser.OpMulOrDivOrModContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#opAddOrSub.
    def visitOpAddOrSub(self, ctx:LuaParser.OpAddOrSubContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#opCmp.
    def visitOpCmp(self, ctx:LuaParser.OpCmpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#prefixexp.
    def visitPrefixexp(self, ctx:LuaParser.PrefixexpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#functioncall.
    def visitFunctioncall(self, ctx:LuaParser.FunctioncallContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nameLvalue.
    def visitNameLvalue(self, ctx:LuaParser.NameLvalueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#indexerLvalue.
    def visitIndexerLvalue(self, ctx:LuaParser.IndexerLvalueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#bracketIndexer.
    def visitBracketIndexer(self, ctx:LuaParser.BracketIndexerContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#dotIndexer.
    def visitDotIndexer(self, ctx:LuaParser.DotIndexerContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nameAndArgs.
    def visitNameAndArgs(self, ctx:LuaParser.NameAndArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#bracedArgs.
    def visitBracedArgs(self, ctx:LuaParser.BracedArgsContext):
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