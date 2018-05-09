# Generated from C:/Users/91018/PycharmProjects/XASM_Assembler/_gen\Lua.g4 by ANTLR 4.7
from antlr4 import *

if __name__ is not None and "." in __name__:
    from .LuaParser import LuaParser
else:
    from LuaParser import LuaParser

from zasm import *


# This class defines a complete listener for a parse tree produced by LuaParser.
class LuaListener(ParseTreeListener):

    # Enter a parse tree produced by LuaParser#chunk.
    def enterChunk(self, ctx: LuaParser.ChunkContext):
        self.main_func = Function(None)
        self.current_func = self.main_func

        self.exp_stakc = []

    # Exit a parse tree produced by LuaParser#chunk.
    def exitChunk(self, ctx: LuaParser.ChunkContext):
        pass

    # Enter a parse tree produced by LuaParser#block.
    def enterBlock(self, ctx: LuaParser.BlockContext):
        pass

    # Exit a parse tree produced by LuaParser#block.
    def exitBlock(self, ctx: LuaParser.BlockContext):
        pass

    # Enter a parse tree produced by LuaParser#empty_stat.
    def enterEmpty_stat(self, ctx: LuaParser.Empty_statContext):
        pass

    # Exit a parse tree produced by LuaParser#empty_stat.
    def exitEmpty_stat(self, ctx: LuaParser.Empty_statContext):
        pass

    # Enter a parse tree produced by LuaParser#assign_stat.
    def enterAssign_stat(self, ctx: LuaParser.Assign_statContext):
        pass
    def append_instr(self,op,*operands):
        ai=AssembledInstr(op,operands or [])
        self.current_func.instrs.append(ai)
    # Exit a parse tree produced by LuaParser#assign_stat.
    def exitAssign_stat(self, ctx: LuaParser.Assign_statContext):
        self.append_instr('mov', ctx.var().getText())
        pass

    # Enter a parse tree produced by LuaParser#func_call_stat.
    def enterFunc_call_stat(self, ctx: LuaParser.Func_call_statContext):
        pass

    # Exit a parse tree produced by LuaParser#func_call_stat.
    def exitFunc_call_stat(self, ctx: LuaParser.Func_call_statContext):
        pass

    # Enter a parse tree produced by LuaParser#break_stat.
    def enterBreak_stat(self, ctx: LuaParser.Break_statContext):
        pass

    # Exit a parse tree produced by LuaParser#break_stat.
    def exitBreak_stat(self, ctx: LuaParser.Break_statContext):
        pass

    # Enter a parse tree produced by LuaParser#do_end_stat.
    def enterDo_end_stat(self, ctx: LuaParser.Do_end_statContext):
        pass

    # Exit a parse tree produced by LuaParser#do_end_stat.
    def exitDo_end_stat(self, ctx: LuaParser.Do_end_statContext):
        pass

    # Enter a parse tree produced by LuaParser#while_stat.
    def enterWhile_stat(self, ctx: LuaParser.While_statContext):
        pass

    # Exit a parse tree produced by LuaParser#while_stat.
    def exitWhile_stat(self, ctx: LuaParser.While_statContext):
        pass

    # Enter a parse tree produced by LuaParser#if_stat.
    def enterIf_stat(self, ctx: LuaParser.If_statContext):
        pass

    # Exit a parse tree produced by LuaParser#if_stat.
    def exitIf_stat(self, ctx: LuaParser.If_statContext):
        pass

    # Enter a parse tree produced by LuaParser#func_def_stat.
    def enterFunc_def_stat(self, ctx: LuaParser.Func_def_statContext):
        '''enter a new func def'''
        para_list=ctx.funcbody().parlist().getText()
        para_list=para_list.split(',')
        new_func=Function(self.current_func,*para_list)
        self.current_func.inner_funcs.append(new_func)
        self.current_func=new_func

    # Exit a parse tree produced by LuaParser#func_def_stat.
    def exitFunc_def_stat(self, ctx: LuaParser.Func_def_statContext):
        ''' 'function' funcname funcbody  #func_def_stat'''
        self.append_instr('ret') #???需要吗
        self.current_func=self.current_func.parent

    # Enter a parse tree produced by LuaParser#global_func_def_stat.
    def enterGlobal_func_def_stat(self, ctx: LuaParser.Global_func_def_statContext):
        pass

    # Exit a parse tree produced by LuaParser#global_func_def_stat.
    def exitGlobal_func_def_stat(self, ctx: LuaParser.Global_func_def_statContext):
        pass

    # Enter a parse tree produced by LuaParser#global_var_stat.
    def enterGlobal_var_stat(self, ctx: LuaParser.Global_var_statContext):
        pass

    # Exit a parse tree produced by LuaParser#global_var_stat.
    def exitGlobal_var_stat(self, ctx: LuaParser.Global_var_statContext):
        pass

    # Enter a parse tree produced by LuaParser#retstat.
    def enterRetstat(self, ctx: LuaParser.RetstatContext):
        pass

    # Exit a parse tree produced by LuaParser#retstat.
    def exitRetstat(self, ctx: LuaParser.RetstatContext):
        pass

    # Enter a parse tree produced by LuaParser#funcname.
    def enterFuncname(self, ctx: LuaParser.FuncnameContext):
        pass

    # Exit a parse tree produced by LuaParser#funcname.
    def exitFuncname(self, ctx: LuaParser.FuncnameContext):
        pass

    # Enter a parse tree produced by LuaParser#varlist.
    def enterVarlist(self, ctx: LuaParser.VarlistContext):
        pass

    # Exit a parse tree produced by LuaParser#varlist.
    def exitVarlist(self, ctx: LuaParser.VarlistContext):
        pass

    # Enter a parse tree produced by LuaParser#namelist.
    def enterNamelist(self, ctx: LuaParser.NamelistContext):
        pass

    # Exit a parse tree produced by LuaParser#namelist.
    def exitNamelist(self, ctx: LuaParser.NamelistContext):
        pass

    # Enter a parse tree produced by LuaParser#explist.
    def enterExplist(self, ctx: LuaParser.ExplistContext):
        pass

    # Exit a parse tree produced by LuaParser#explist.
    def exitExplist(self, ctx: LuaParser.ExplistContext):
        pass

    # Enter a parse tree produced by LuaParser#op_and_exp.
    def enterOp_and_exp(self, ctx: LuaParser.Op_and_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_and_exp.
    def exitOp_and_exp(self, ctx: LuaParser.Op_and_expContext):
        self.append_instr('_and')

    # Enter a parse tree produced by LuaParser#op_or_exp.
    def enterOp_or_exp(self, ctx: LuaParser.Op_or_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_or_exp.
    def exitOp_or_exp(self, ctx: LuaParser.Op_or_expContext):
        pass

    # Enter a parse tree produced by LuaParser#num_exp.
    def enterNum_exp(self, ctx: LuaParser.Num_expContext):
        pass

    # Exit a parse tree produced by LuaParser#num_exp.
    def exitNum_exp(self, ctx: LuaParser.Num_expContext):
        num=eval(ctx.number().getText())
        #ast.eval or eval is more pythonic?
        self.append_instr('push',num)


    # Enter a parse tree produced by LuaParser#prefix_exp_exp.
    def enterPrefix_exp_exp(self, ctx: LuaParser.Prefix_exp_expContext):
        pass

    # Exit a parse tree produced by LuaParser#prefix_exp_exp.
    def exitPrefix_exp_exp(self, ctx: LuaParser.Prefix_exp_expContext):
        pass

    # Enter a parse tree produced by LuaParser#op_mul_div_exp.
    def enterOp_mul_div_exp(self, ctx: LuaParser.Op_mul_div_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_mul_div_exp.
    def exitOp_mul_div_exp(self, ctx: LuaParser.Op_mul_div_expContext):
        punc2op={
            '*':'mul',
            '/':'div',
        }
        punc=ctx.operatorMulDivMod().getText()
        self.append_instr(punc2op[punc])

    # Enter a parse tree produced by LuaParser#table_ctor_exp.
    def enterTable_ctor_exp(self, ctx: LuaParser.Table_ctor_expContext):
        pass

    # Exit a parse tree produced by LuaParser#table_ctor_exp.
    def exitTable_ctor_exp(self, ctx: LuaParser.Table_ctor_expContext):
        pass

    # Enter a parse tree produced by LuaParser#op_concat_exp.
    def enterOp_concat_exp(self, ctx: LuaParser.Op_concat_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_concat_exp.
    def exitOp_concat_exp(self, ctx: LuaParser.Op_concat_expContext):
        pass

    # Enter a parse tree produced by LuaParser#string_exp.
    def enterString_exp(self, ctx: LuaParser.String_expContext):
        pass

    # Exit a parse tree produced by LuaParser#string_exp.
    def exitString_exp(self, ctx: LuaParser.String_expContext):
        s=ctx.string().getText()
        s=s.strip('"')
        self.append_instr('push',s)

    # Enter a parse tree produced by LuaParser#false_exp.
    def enterFalse_exp(self, ctx: LuaParser.False_expContext):
        pass

    # Exit a parse tree produced by LuaParser#false_exp.
    def exitFalse_exp(self, ctx: LuaParser.False_expContext):
        self.append_instr('push',False)

    # Enter a parse tree produced by LuaParser#op_add_sub_exp.
    def enterOp_add_sub_exp(self, ctx: LuaParser.Op_add_sub_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_add_sub_exp.
    def exitOp_add_sub_exp(self, ctx: LuaParser.Op_add_sub_expContext):
        punc2op={
            '+':'add',
            '-':'sub',
        }
        punc=ctx.operatorAddSub().getText()
        self.append_instr(punc2op[punc])

    # Enter a parse tree produced by LuaParser#nil_exp.
    def enterNil_exp(self, ctx: LuaParser.Nil_expContext):
        pass

    # Exit a parse tree produced by LuaParser#nil_exp.
    def exitNil_exp(self, ctx: LuaParser.Nil_expContext):
        self.append_instr('push',None)

    # Enter a parse tree produced by LuaParser#op_unary_exp.
    def enterOp_unary_exp(self, ctx: LuaParser.Op_unary_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_unary_exp.
    def exitOp_unary_exp(self, ctx: LuaParser.Op_unary_expContext):
        pass

    # Enter a parse tree produced by LuaParser#op_caompare_exp.
    def enterOp_caompare_exp(self, ctx: LuaParser.Op_caompare_expContext):
        pass

    # Exit a parse tree produced by LuaParser#op_caompare_exp.
    def exitOp_caompare_exp(self, ctx: LuaParser.Op_caompare_expContext):
        punc2op={
            '==':'eq',

        # '<':,'>' | '<=' | '>=' | '~=' ;
        }
        punc=ctx.operatorComparison().getText()
        self.append_instr(punc2op[punc])

    # Enter a parse tree produced by LuaParser#true_exp.
    def enterTrue_exp(self, ctx: LuaParser.True_expContext):
        pass

    # Exit a parse tree produced by LuaParser#true_exp.
    def exitTrue_exp(self, ctx: LuaParser.True_expContext):
        self.append_instr('push',True)

    def push(self,item):
        self.current_func.stack.append(item)


    # Enter a parse tree produced by LuaParser#func_def_exp.
    def enterFunc_def_exp(self, ctx: LuaParser.Func_def_expContext):
        pass

    # Exit a parse tree produced by LuaParser#func_def_exp.
    def exitFunc_def_exp(self, ctx: LuaParser.Func_def_expContext):
        pass

    # Enter a parse tree produced by LuaParser#prefixexp.
    def enterPrefixexp(self, ctx: LuaParser.PrefixexpContext):
        pass

    # Exit a parse tree produced by LuaParser#prefixexp.
    def exitPrefixexp(self, ctx: LuaParser.PrefixexpContext):
        pass

    # Enter a parse tree produced by LuaParser#functioncall.
    def enterFunctioncall(self, ctx: LuaParser.FunctioncallContext):
        pass

    # Exit a parse tree produced by LuaParser#functioncall.
    def exitFunctioncall(self, ctx: LuaParser.FunctioncallContext):
        pass

    # Enter a parse tree produced by LuaParser#varOrExp.
    def enterVarOrExp(self, ctx: LuaParser.VarOrExpContext):
        pass

    # Exit a parse tree produced by LuaParser#varOrExp.
    def exitVarOrExp(self, ctx: LuaParser.VarOrExpContext):
        pass

    # Enter a parse tree produced by LuaParser#var.
    def enterVar(self, ctx: LuaParser.VarContext):
        pass

    # Exit a parse tree produced by LuaParser#var.
    def exitVar(self, ctx: LuaParser.VarContext):
        pass

    # Enter a parse tree produced by LuaParser#varSuffix.
    def enterVarSuffix(self, ctx: LuaParser.VarSuffixContext):
        pass

    # Exit a parse tree produced by LuaParser#varSuffix.
    def exitVarSuffix(self, ctx: LuaParser.VarSuffixContext):
        pass

    # Enter a parse tree produced by LuaParser#nameAndArgs.
    def enterNameAndArgs(self, ctx: LuaParser.NameAndArgsContext):
        pass

    # Exit a parse tree produced by LuaParser#nameAndArgs.
    def exitNameAndArgs(self, ctx: LuaParser.NameAndArgsContext):
        pass

    # Enter a parse tree produced by LuaParser#args.
    def enterArgs(self, ctx: LuaParser.ArgsContext):
        pass

    # Exit a parse tree produced by LuaParser#args.
    def exitArgs(self, ctx: LuaParser.ArgsContext):
        pass

    # Enter a parse tree produced by LuaParser#functiondef.
    def enterFunctiondef(self, ctx: LuaParser.FunctiondefContext):
        pass

    # Exit a parse tree produced by LuaParser#functiondef.
    def exitFunctiondef(self, ctx: LuaParser.FunctiondefContext):
        pass

    # Enter a parse tree produced by LuaParser#funcbody.
    def enterFuncbody(self, ctx: LuaParser.FuncbodyContext):
        pass

    # Exit a parse tree produced by LuaParser#funcbody.
    def exitFuncbody(self, ctx: LuaParser.FuncbodyContext):
        pass

    # Enter a parse tree produced by LuaParser#parlist.
    def enterParlist(self, ctx: LuaParser.ParlistContext):
        pass

    # Exit a parse tree produced by LuaParser#parlist.
    def exitParlist(self, ctx: LuaParser.ParlistContext):
        pass

    # Enter a parse tree produced by LuaParser#tableconstructor.
    def enterTableconstructor(self, ctx: LuaParser.TableconstructorContext):
        pass

    # Exit a parse tree produced by LuaParser#tableconstructor.
    def exitTableconstructor(self, ctx: LuaParser.TableconstructorContext):
        pass

    # Enter a parse tree produced by LuaParser#fieldlist.
    def enterFieldlist(self, ctx: LuaParser.FieldlistContext):
        pass

    # Exit a parse tree produced by LuaParser#fieldlist.
    def exitFieldlist(self, ctx: LuaParser.FieldlistContext):
        pass

    # Enter a parse tree produced by LuaParser#field.
    def enterField(self, ctx: LuaParser.FieldContext):
        pass

    # Exit a parse tree produced by LuaParser#field.
    def exitField(self, ctx: LuaParser.FieldContext):
        pass

    # Enter a parse tree produced by LuaParser#fieldsep.
    def enterFieldsep(self, ctx: LuaParser.FieldsepContext):
        pass

    # Exit a parse tree produced by LuaParser#fieldsep.
    def exitFieldsep(self, ctx: LuaParser.FieldsepContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorOr.
    def enterOperatorOr(self, ctx: LuaParser.OperatorOrContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorOr.
    def exitOperatorOr(self, ctx: LuaParser.OperatorOrContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorAnd.
    def enterOperatorAnd(self, ctx: LuaParser.OperatorAndContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorAnd.
    def exitOperatorAnd(self, ctx: LuaParser.OperatorAndContext):
        pass
    # Enter a parse tree produced by LuaParser#operatorComparison.
    def enterOperatorComparison(self, ctx: LuaParser.OperatorComparisonContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorComparison.
    def exitOperatorComparison(self, ctx: LuaParser.OperatorComparisonContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorStrcat.
    def enterOperatorStrcat(self, ctx: LuaParser.OperatorStrcatContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorStrcat.
    def exitOperatorStrcat(self, ctx: LuaParser.OperatorStrcatContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorAddSub.
    def enterOperatorAddSub(self, ctx: LuaParser.OperatorAddSubContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorAddSub.
    def exitOperatorAddSub(self, ctx: LuaParser.OperatorAddSubContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorMulDivMod.
    def enterOperatorMulDivMod(self, ctx: LuaParser.OperatorMulDivModContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorMulDivMod.
    def exitOperatorMulDivMod(self, ctx: LuaParser.OperatorMulDivModContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorBitwise.
    def enterOperatorBitwise(self, ctx: LuaParser.OperatorBitwiseContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorBitwise.
    def exitOperatorBitwise(self, ctx: LuaParser.OperatorBitwiseContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorUnary.
    def enterOperatorUnary(self, ctx: LuaParser.OperatorUnaryContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorUnary.
    def exitOperatorUnary(self, ctx: LuaParser.OperatorUnaryContext):
        pass

    # Enter a parse tree produced by LuaParser#operatorPower.
    def enterOperatorPower(self, ctx: LuaParser.OperatorPowerContext):
        pass

    # Exit a parse tree produced by LuaParser#operatorPower.
    def exitOperatorPower(self, ctx: LuaParser.OperatorPowerContext):
        pass

    # Enter a parse tree produced by LuaParser#number.
    def enterNumber(self, ctx: LuaParser.NumberContext):
        pass

    # Exit a parse tree produced by LuaParser#number.
    def exitNumber(self, ctx: LuaParser.NumberContext):
        pass

    # Enter a parse tree produced by LuaParser#string.
    def enterString(self, ctx: LuaParser.StringContext):
        pass

    # Exit a parse tree produced by LuaParser#string.
    def exitString(self, ctx: LuaParser.StringContext):
        pass
