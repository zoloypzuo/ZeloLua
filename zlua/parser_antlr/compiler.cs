using System.Collections.Generic;
using System.Linq;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.TypeModel;
using zlua.ISA;
namespace zlua
{
    using lua_Number = System.Double;
    class Compiler : ILuaListener
    {
        public Proto main_func = new Proto(null, null);
        Proto curr_func;
        void append_instr(AssembledInstr instr)
        {
            curr_func.instrs.Add(instr);
        }
        public void EnterArgs([NotNull] LuaParser.ArgsContext context)
        {

        }

        public void EnterAssign_stat([NotNull] LuaParser.Assign_statContext context)
        {

        }

        public void EnterBlock([NotNull] LuaParser.BlockContext context)
        {

        }

        public void EnterBreak_stat([NotNull] LuaParser.Break_statContext context)
        {

        }

        public void EnterChunk([NotNull] LuaParser.ChunkContext context)
        {
            curr_func = main_func;
        }

        public void EnterDo_end_stat([NotNull] LuaParser.Do_end_statContext context)
        {

        }

        public void EnterEmpty_stat([NotNull] LuaParser.Empty_statContext context)
        {

        }

        public void EnterEveryRule(ParserRuleContext ctx)
        {

        }

        public void EnterExp([NotNull] LuaParser.ExpContext context)
        {

        }

        public void EnterExplist([NotNull] LuaParser.ExplistContext context)
        {

        }

        public void EnterFalse_exp([NotNull] LuaParser.False_expContext context)
        {

        }

        public void EnterField([NotNull] LuaParser.FieldContext context)
        {

        }

        public void EnterFieldlist([NotNull] LuaParser.FieldlistContext context)
        {

        }

        public void EnterFieldsep([NotNull] LuaParser.FieldsepContext context)
        {

        }

        public void EnterFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {

        }

        public void EnterFuncname([NotNull] LuaParser.FuncnameContext context)
        {

        }

        public void EnterFunctioncall([NotNull] LuaParser.FunctioncallContext context)
        {

        }

        public void EnterFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {

        }

        public void EnterFunc_call_stat([NotNull] LuaParser.Func_call_statContext context)
        {

        }

        public void EnterFunc_def_exp([NotNull] LuaParser.Func_def_expContext context)
        {

        }

        public void EnterFunc_def_stat([NotNull] LuaParser.Func_def_statContext context)
        {
            var para_list = context.funcbody().parlist().GetText().Split(',');
            var new_func = new Proto(curr_func, new List<string>(para_list));
            append_instr(new closure(curr_func.inner_funcs.Count()));
            append_instr(new mov(context.funcname().GetText()));
            curr_func.inner_funcs.Add(new_func);
            curr_func = new_func;
        }

        public void EnterGlobal_func_def_stat([NotNull] LuaParser.Global_func_def_statContext context)
        {

        }

        public void EnterGlobal_var_stat([NotNull] LuaParser.Global_var_statContext context)
        {

        }

        public void EnterIf_stat([NotNull] LuaParser.If_statContext context)
        {

        }

        public void EnterNameAndArgs([NotNull] LuaParser.NameAndArgsContext context)
        {

        }

        public void EnterNamelist([NotNull] LuaParser.NamelistContext context)
        {

        }

        public void EnterNil_exp([NotNull] LuaParser.Nil_expContext context)
        {

        }

        public void EnterNumber([NotNull] LuaParser.NumberContext context)
        {

        }

        public void EnterNum_exp([NotNull] LuaParser.Num_expContext context)
        {

        }

        public void EnterOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context)
        {

        }

        public void EnterOperatorAnd([NotNull] LuaParser.OperatorAndContext context)
        {

        }

        public void EnterOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context)
        {

        }

        public void EnterOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context)
        {

        }

        public void EnterOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context)
        {

        }

        public void EnterOperatorOr([NotNull] LuaParser.OperatorOrContext context)
        {

        }

        public void EnterOperatorPower([NotNull] LuaParser.OperatorPowerContext context)
        {

        }

        public void EnterOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context)
        {

        }

        public void EnterOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context)
        {

        }

        public void EnterOp_add_sub_exp([NotNull] LuaParser.Op_add_sub_expContext context)
        {

        }

        public void EnterOp_and_exp([NotNull] LuaParser.Op_and_expContext context)
        {

        }

        public void EnterOp_caompare_exp([NotNull] LuaParser.Op_caompare_expContext context)
        {

        }

        public void EnterOp_concat_exp([NotNull] LuaParser.Op_concat_expContext context)
        {

        }

        public void EnterOp_mul_div_exp([NotNull] LuaParser.Op_mul_div_expContext context)
        {

        }

        public void EnterOp_or_exp([NotNull] LuaParser.Op_or_expContext context)
        {

        }

        public void EnterOp_unary_exp([NotNull] LuaParser.Op_unary_expContext context)
        {

        }

        public void EnterParlist([NotNull] LuaParser.ParlistContext context)
        {

        }

        public void EnterPrefixexp([NotNull] LuaParser.PrefixexpContext context)
        {

        }

        public void EnterPrefix_exp_exp([NotNull] LuaParser.Prefix_exp_expContext context)
        {

        }

        public void EnterRetstat([NotNull] LuaParser.RetstatContext context)
        {

        }

        public void EnterStat([NotNull] LuaParser.StatContext context)
        {

        }

        public void EnterString([NotNull] LuaParser.StringContext context)
        {

        }

        public void EnterString_exp([NotNull] LuaParser.String_expContext context)
        {

        }

        public void EnterTableconstructor([NotNull] LuaParser.TableconstructorContext context)
        {

        }

        public void EnterTable_ctor_exp([NotNull] LuaParser.Table_ctor_expContext context)
        {

        }

        public void EnterTrue_exp([NotNull] LuaParser.True_expContext context)
        {

        }

        public void EnterVar([NotNull] LuaParser.VarContext context)
        {

        }

        public void EnterVarlist([NotNull] LuaParser.VarlistContext context)
        {

        }

        public void EnterVarOrExp([NotNull] LuaParser.VarOrExpContext context)
        {

        }

        public void EnterVarSuffix([NotNull] LuaParser.VarSuffixContext context)
        {

        }

        public void EnterWhile_stat([NotNull] LuaParser.While_statContext context)
        {

        }

        public void ExitArgs([NotNull] LuaParser.ArgsContext context)
        {

        }

        public void ExitAssign_stat([NotNull] LuaParser.Assign_statContext context)
        {
            append_instr(new mov(context.var().GetText()));
        }

        public void ExitBlock([NotNull] LuaParser.BlockContext context)
        {

        }

        public void ExitBreak_stat([NotNull] LuaParser.Break_statContext context)
        {

        }

        public void ExitChunk([NotNull] LuaParser.ChunkContext context)
        {
            append_instr(new ret());
        }

        public void ExitDo_end_stat([NotNull] LuaParser.Do_end_statContext context)
        {

        }

        public void ExitEmpty_stat([NotNull] LuaParser.Empty_statContext context)
        {

        }

        public void ExitEveryRule(ParserRuleContext ctx)
        {

        }

        public void ExitExp([NotNull] LuaParser.ExpContext context)
        {

        }

        public void ExitExplist([NotNull] LuaParser.ExplistContext context)
        {

        }

        public void ExitFalse_exp([NotNull] LuaParser.False_expContext context)
        {
            append_instr(new push(TValue.bool_factory(false)));
        }

        public void ExitField([NotNull] LuaParser.FieldContext context)
        {

        }

        public void ExitFieldlist([NotNull] LuaParser.FieldlistContext context)
        {

        }

        public void ExitFieldsep([NotNull] LuaParser.FieldsepContext context)
        {

        }

        public void ExitFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {

        }

        public void ExitFuncname([NotNull] LuaParser.FuncnameContext context)
        {

        }

        public void ExitFunctioncall([NotNull] LuaParser.FunctioncallContext context)
        {
            append_instr(new call(context.varOrExp().var().NAME().GetText()));
        }

        public void ExitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {

        }

        public void ExitFunc_call_stat([NotNull] LuaParser.Func_call_statContext context)
        {

        }

        public void ExitFunc_def_exp([NotNull] LuaParser.Func_def_expContext context)
        {

        }

        public void ExitFunc_def_stat([NotNull] LuaParser.Func_def_statContext context)
        {
            append_instr(new ret());
            curr_func = curr_func.parent;
        }

        public void ExitGlobal_func_def_stat([NotNull] LuaParser.Global_func_def_statContext context)
        {

        }

        public void ExitGlobal_var_stat([NotNull] LuaParser.Global_var_statContext context)
        {

        }

        public void ExitIf_stat([NotNull] LuaParser.If_statContext context)
        {

        }

        public void ExitNameAndArgs([NotNull] LuaParser.NameAndArgsContext context)
        {

        }

        public void ExitNamelist([NotNull] LuaParser.NamelistContext context)
        {

        }

        public void ExitNil_exp([NotNull] LuaParser.Nil_expContext context)
        {
            append_instr(new push(TValue.nil_factory()));
        }

        public void ExitNumber([NotNull] LuaParser.NumberContext context)
        {

        }

        public void ExitNum_exp([NotNull] LuaParser.Num_expContext context)
        {
            var num = TValue.n_factory(lua_Number.Parse(context.number().GetText()));
            append_instr(new push(num));
        }

        public void ExitOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context)
        {

        }

        public void ExitOperatorAnd([NotNull] LuaParser.OperatorAndContext context)
        {

        }

        public void ExitOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context)
        {

        }

        public void ExitOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context)
        {

        }

        public void ExitOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context)
        {

        }

        public void ExitOperatorOr([NotNull] LuaParser.OperatorOrContext context)
        {

        }

        public void ExitOperatorPower([NotNull] LuaParser.OperatorPowerContext context)
        {

        }

        public void ExitOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context)
        {

        }

        public void ExitOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context)
        {

        }

        public void ExitOp_add_sub_exp([NotNull] LuaParser.Op_add_sub_expContext context)
        {
            var punc = context.operatorAddSub().GetText();
            if (punc == "+") append_instr(new add());
            //else if (punc == "-") append_instr(new sub());
        }

        public void ExitOp_and_exp([NotNull] LuaParser.Op_and_expContext context)
        {

        }

        public void ExitOp_caompare_exp([NotNull] LuaParser.Op_caompare_expContext context)
        {
            var punc = context.operatorComparison().GetText();
            append_instr(new eq());
        }

        public void ExitOp_concat_exp([NotNull] LuaParser.Op_concat_expContext context)
        {

        }

        public void ExitOp_mul_div_exp([NotNull] LuaParser.Op_mul_div_expContext context)
        {
            var punc = context.operatorMulDivMod().GetText();
            if (punc == "*") append_instr(new mul());
            //else if (punc == "/") append_instr(new div());
        }

        public void ExitOp_or_exp([NotNull] LuaParser.Op_or_expContext context)
        {

        }

        public void ExitOp_unary_exp([NotNull] LuaParser.Op_unary_expContext context)
        {

        }

        public void ExitParlist([NotNull] LuaParser.ParlistContext context)
        {

        }

        public void ExitPrefixexp([NotNull] LuaParser.PrefixexpContext context)
        {
            var a = context.nameAndArgs();
            if (a.Length == 0) append_instr(new push_var(context.varOrExp().GetText()));
            else append_instr(new call( context.varOrExp().var().NAME().GetText()));
        }

        public void ExitPrefix_exp_exp([NotNull] LuaParser.Prefix_exp_expContext context)
        {

        }

        public void ExitRetstat([NotNull] LuaParser.RetstatContext context)
        {

        }

        public void ExitStat([NotNull] LuaParser.StatContext context)
        {

        }

        public void ExitString([NotNull] LuaParser.StringContext context)
        {

        }

        public void ExitString_exp([NotNull] LuaParser.String_expContext context)
        {
            var s = context.@string().GetText().Trim('"');
            append_instr(new push(TValue.tstring_factory(s)));
        }

        public void ExitTableconstructor([NotNull] LuaParser.TableconstructorContext context)
        {

        }

        public void ExitTable_ctor_exp([NotNull] LuaParser.Table_ctor_expContext context)
        {

        }

        public void ExitTrue_exp([NotNull] LuaParser.True_expContext context)
        {
            append_instr(new push(TValue.bool_factory(true)));
        }

        public void ExitVar([NotNull] LuaParser.VarContext context)
        {

        }

        public void ExitVarlist([NotNull] LuaParser.VarlistContext context)
        {

        }

        public void ExitVarOrExp([NotNull] LuaParser.VarOrExpContext context)
        {

        }

        public void ExitVarSuffix([NotNull] LuaParser.VarSuffixContext context)
        {

        }

        public void ExitWhile_stat([NotNull] LuaParser.While_statContext context)
        {

        }

        public void VisitErrorNode(IErrorNode node)
        {

        }

        public void VisitTerminal(ITerminalNode node)
        {

        }
    }
}