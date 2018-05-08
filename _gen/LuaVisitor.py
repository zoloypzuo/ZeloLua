# Generated from C:/Users/91018/PycharmProjects/XASM_Assembler/_gen\Lua.g4 by ANTLR 4.7
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


    # Visit a parse tree produced by LuaParser#empty_stat.
    def visitEmpty_stat(self, ctx:LuaParser.Empty_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#assign_stat.
    def visitAssign_stat(self, ctx:LuaParser.Assign_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#func_call_stat.
    def visitFunc_call_stat(self, ctx:LuaParser.Func_call_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#break_stat.
    def visitBreak_stat(self, ctx:LuaParser.Break_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#do_end_stat.
    def visitDo_end_stat(self, ctx:LuaParser.Do_end_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#while_stat.
    def visitWhile_stat(self, ctx:LuaParser.While_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#if_stat.
    def visitIf_stat(self, ctx:LuaParser.If_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#func_def_stat.
    def visitFunc_def_stat(self, ctx:LuaParser.Func_def_statContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#retstat.
    def visitRetstat(self, ctx:LuaParser.RetstatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#funcname.
    def visitFuncname(self, ctx:LuaParser.FuncnameContext):
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


    # Visit a parse tree produced by LuaParser#op_and_exp.
    def visitOp_and_exp(self, ctx:LuaParser.Op_and_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_or_exp.
    def visitOp_or_exp(self, ctx:LuaParser.Op_or_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#num_exp.
    def visitNum_exp(self, ctx:LuaParser.Num_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#prefix_exp_exp.
    def visitPrefix_exp_exp(self, ctx:LuaParser.Prefix_exp_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_mul_div_exp.
    def visitOp_mul_div_exp(self, ctx:LuaParser.Op_mul_div_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#table_ctor_exp.
    def visitTable_ctor_exp(self, ctx:LuaParser.Table_ctor_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_concat_exp.
    def visitOp_concat_exp(self, ctx:LuaParser.Op_concat_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#string_exp.
    def visitString_exp(self, ctx:LuaParser.String_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#false_exp.
    def visitFalse_exp(self, ctx:LuaParser.False_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_add_sub_exp.
    def visitOp_add_sub_exp(self, ctx:LuaParser.Op_add_sub_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nil_exp.
    def visitNil_exp(self, ctx:LuaParser.Nil_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_unary_exp.
    def visitOp_unary_exp(self, ctx:LuaParser.Op_unary_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#op_caompare_exp.
    def visitOp_caompare_exp(self, ctx:LuaParser.Op_caompare_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#true_exp.
    def visitTrue_exp(self, ctx:LuaParser.True_expContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#func_def_exp.
    def visitFunc_def_exp(self, ctx:LuaParser.Func_def_expContext):
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


    # Visit a parse tree produced by LuaParser#var.
    def visitVar(self, ctx:LuaParser.VarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#varSuffix.
    def visitVarSuffix(self, ctx:LuaParser.VarSuffixContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#nameAndArgs.
    def visitNameAndArgs(self, ctx:LuaParser.NameAndArgsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#args.
    def visitArgs(self, ctx:LuaParser.ArgsContext):
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


    # Visit a parse tree produced by LuaParser#operatorOr.
    def visitOperatorOr(self, ctx:LuaParser.OperatorOrContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorAnd.
    def visitOperatorAnd(self, ctx:LuaParser.OperatorAndContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorComparison.
    def visitOperatorComparison(self, ctx:LuaParser.OperatorComparisonContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorStrcat.
    def visitOperatorStrcat(self, ctx:LuaParser.OperatorStrcatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorAddSub.
    def visitOperatorAddSub(self, ctx:LuaParser.OperatorAddSubContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorMulDivMod.
    def visitOperatorMulDivMod(self, ctx:LuaParser.OperatorMulDivModContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorBitwise.
    def visitOperatorBitwise(self, ctx:LuaParser.OperatorBitwiseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorUnary.
    def visitOperatorUnary(self, ctx:LuaParser.OperatorUnaryContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#operatorPower.
    def visitOperatorPower(self, ctx:LuaParser.OperatorPowerContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#number.
    def visitNumber(self, ctx:LuaParser.NumberContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by LuaParser#string.
    def visitString(self, ctx:LuaParser.StringContext):
        return self.visitChildren(ctx)



del LuaParser