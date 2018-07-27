using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.AntlrGen;
namespace zlua.Parser
{
    public class lparser : LuaBaseListener
    {
        public override void EnterAddsubExp([NotNull] LuaParser.AddsubExpContext context)
        {
            base.EnterAddsubExp(context);
        }

        public override void EnterAndExp([NotNull] LuaParser.AndExpContext context)
        {
            base.EnterAndExp(context);
        }

        public override void EnterArgs([NotNull] LuaParser.ArgsContext context)
        {
            base.EnterArgs(context);
        }

        public override void EnterAssignStat([NotNull] LuaParser.AssignStatContext context)
        {
            base.EnterAssignStat(context);
        }

        public override void EnterBitwiseExp([NotNull] LuaParser.BitwiseExpContext context)
        {
            base.EnterBitwiseExp(context);
        }

        public override void EnterBlock([NotNull] LuaParser.BlockContext context)
        {
            base.EnterBlock(context);
        }

        public override void EnterBreakStat([NotNull] LuaParser.BreakStatContext context)
        {
            base.EnterBreakStat(context);
        }

        public override void EnterChunk([NotNull] LuaParser.ChunkContext context)
        {
            base.EnterChunk(context);
        }

        public override void EnterCmpExp([NotNull] LuaParser.CmpExpContext context)
        {
            base.EnterCmpExp(context);
        }

        public override void EnterConcatExp([NotNull] LuaParser.ConcatExpContext context)
        {
            base.EnterConcatExp(context);
        }

        public override void EnterDoendStat([NotNull] LuaParser.DoendStatContext context)
        {
            base.EnterDoendStat(context);
        }

        public override void EnterEmptyStat([NotNull] LuaParser.EmptyStatContext context)
        {
            base.EnterEmptyStat(context);
        }

        public override void EnterEveryRule([NotNull] ParserRuleContext context)
        {
            base.EnterEveryRule(context);
        }

        public override void EnterExp([NotNull] LuaParser.ExpContext context)
        {
            base.EnterExp(context);
        }

        public override void EnterExplist([NotNull] LuaParser.ExplistContext context)
        {
            base.EnterExplist(context);
        }

        public override void EnterField([NotNull] LuaParser.FieldContext context)
        {
            base.EnterField(context);
        }

        public override void EnterFieldlist([NotNull] LuaParser.FieldlistContext context)
        {
            base.EnterFieldlist(context);
        }

        public override void EnterFieldsep([NotNull] LuaParser.FieldsepContext context)
        {
            base.EnterFieldsep(context);
        }

        public override void EnterForijkStat([NotNull] LuaParser.ForijkStatContext context)
        {
            base.EnterForijkStat(context);
        }

        public override void EnterForinStat([NotNull] LuaParser.ForinStatContext context)
        {
            base.EnterForinStat(context);
        }

        public override void EnterFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {
            base.EnterFuncbody(context);
        }

        public override void EnterFuncname([NotNull] LuaParser.FuncnameContext context)
        {
            base.EnterFuncname(context);
        }

        public override void EnterFunctioncall([NotNull] LuaParser.FunctioncallContext context)
        {
            base.EnterFunctioncall(context);
        }

        public override void EnterFunctioncallStat([NotNull] LuaParser.FunctioncallStatContext context)
        {
            base.EnterFunctioncallStat(context);
        }

        public override void EnterFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {
            base.EnterFunctiondef(context);
        }

        public override void EnterFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context)
        {
            base.EnterFunctiondefExp(context);
        }

        public override void EnterFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context)
        {
            base.EnterFunctiondefStat(context);
        }

        public override void EnterIfelseStat([NotNull] LuaParser.IfelseStatContext context)
        {
            base.EnterIfelseStat(context);
        }

        public override void EnterLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        {
            base.EnterLocalassignStat(context);
        }

        public override void EnterLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {
            base.EnterLocalfunctiondefStat(context);
        }

        public override void EnterMuldivExp([NotNull] LuaParser.MuldivExpContext context)
        {
            base.EnterMuldivExp(context);
        }

        public override void EnterNameAndArgs([NotNull] LuaParser.NameAndArgsContext context)
        {
            base.EnterNameAndArgs(context);
        }

        public override void EnterNamelist([NotNull] LuaParser.NamelistContext context)
        {
            base.EnterNamelist(context);
        }

        public override void EnterNilfalsetruevararg([NotNull] LuaParser.NilfalsetruevarargContext context)
        {
            base.EnterNilfalsetruevararg(context);
        }

        public override void EnterNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            base.EnterNilfalsetruevarargExp(context);
        }

        public override void EnterNormalArgs([NotNull] LuaParser.NormalArgsContext context)
        {
            base.EnterNormalArgs(context);
        }

        public override void EnterNumber([NotNull] LuaParser.NumberContext context)
        {
            base.EnterNumber(context);
        }

        public override void EnterNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            base.EnterNumberExp(context);
        }

        public override void EnterOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context)
        {
            base.EnterOperatorAddSub(context);
        }

        public override void EnterOperatorAnd([NotNull] LuaParser.OperatorAndContext context)
        {
            base.EnterOperatorAnd(context);
        }

        public override void EnterOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context)
        {
            base.EnterOperatorBitwise(context);
        }

        public override void EnterOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context)
        {
            base.EnterOperatorComparison(context);
        }

        public override void EnterOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context)
        {
            base.EnterOperatorMulDivMod(context);
        }

        public override void EnterOperatorOr([NotNull] LuaParser.OperatorOrContext context)
        {
            base.EnterOperatorOr(context);
        }

        public override void EnterOperatorPower([NotNull] LuaParser.OperatorPowerContext context)
        {
            base.EnterOperatorPower(context);
        }

        public override void EnterOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context)
        {
            base.EnterOperatorStrcat(context);
        }

        public override void EnterOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context)
        {
            base.EnterOperatorUnary(context);
        }

        public override void EnterOrExp([NotNull] LuaParser.OrExpContext context)
        {
            base.EnterOrExp(context);
        }

        public override void EnterParlist([NotNull] LuaParser.ParlistContext context)
        {
            base.EnterParlist(context);
        }

        public override void EnterPowExp([NotNull] LuaParser.PowExpContext context)
        {
            base.EnterPowExp(context);
        }

        public override void EnterPrefixexp([NotNull] LuaParser.PrefixexpContext context)
        {
            base.EnterPrefixexp(context);
        }

        public override void EnterPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context)
        {
            base.EnterPrefixexpExp(context);
        }

        public override void EnterRepeatStat([NotNull] LuaParser.RepeatStatContext context)
        {
            base.EnterRepeatStat(context);
        }

        public override void EnterRetstat([NotNull] LuaParser.RetstatContext context)
        {
            base.EnterRetstat(context);
        }

        public override void EnterStat([NotNull] LuaParser.StatContext context)
        {
            base.EnterStat(context);
        }

        public override void EnterString([NotNull] LuaParser.StringContext context)
        {
            base.EnterString(context);
        }

        public override void EnterStringArgs([NotNull] LuaParser.StringArgsContext context)
        {
            base.EnterStringArgs(context);
        }

        public override void EnterStringExp([NotNull] LuaParser.StringExpContext context)
        {
            base.EnterStringExp(context);
        }

        public override void EnterTableconstructor([NotNull] LuaParser.TableconstructorContext context)
        {
            base.EnterTableconstructor(context);
        }

        public override void EnterTablectorArgs([NotNull] LuaParser.TablectorArgsContext context)
        {
            base.EnterTablectorArgs(context);
        }

        public override void EnterTablectorExp([NotNull] LuaParser.TablectorExpContext context)
        {
            base.EnterTablectorExp(context);
        }

        public override void EnterUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            base.EnterUnmExp(context);
        }

        public override void EnterVar([NotNull] LuaParser.VarContext context)
        {
            base.EnterVar(context);
        }

        public override void EnterVarlist([NotNull] LuaParser.VarlistContext context)
        {
            base.EnterVarlist(context);
        }

        public override void EnterVarOrExp([NotNull] LuaParser.VarOrExpContext context)
        {
            base.EnterVarOrExp(context);
        }

        public override void EnterVarSuffix([NotNull] LuaParser.VarSuffixContext context)
        {
            base.EnterVarSuffix(context);
        }

        public override void EnterWhileStat([NotNull] LuaParser.WhileStatContext context)
        {
            base.EnterWhileStat(context);
        }

        public override void ExitAddsubExp([NotNull] LuaParser.AddsubExpContext context)
        {
            base.ExitAddsubExp(context);
        }

        public override void ExitAndExp([NotNull] LuaParser.AndExpContext context)
        {
            base.ExitAndExp(context);
        }

        public override void ExitArgs([NotNull] LuaParser.ArgsContext context)
        {
            base.ExitArgs(context);
        }

        public override void ExitAssignStat([NotNull] LuaParser.AssignStatContext context)
        {
            base.ExitAssignStat(context);
        }

        public override void ExitBitwiseExp([NotNull] LuaParser.BitwiseExpContext context)
        {
            base.ExitBitwiseExp(context);
        }

        public override void ExitBlock([NotNull] LuaParser.BlockContext context)
        {
            base.ExitBlock(context);
        }

        public override void ExitBreakStat([NotNull] LuaParser.BreakStatContext context)
        {
            base.ExitBreakStat(context);
        }

        public override void ExitChunk([NotNull] LuaParser.ChunkContext context)
        {
            base.ExitChunk(context);
        }

        public override void ExitCmpExp([NotNull] LuaParser.CmpExpContext context)
        {
            base.ExitCmpExp(context);
        }

        public override void ExitConcatExp([NotNull] LuaParser.ConcatExpContext context)
        {
            base.ExitConcatExp(context);
        }

        public override void ExitDoendStat([NotNull] LuaParser.DoendStatContext context)
        {
            base.ExitDoendStat(context);
        }

        public override void ExitEmptyStat([NotNull] LuaParser.EmptyStatContext context)
        {
            base.ExitEmptyStat(context);
        }

        public override void ExitEveryRule([NotNull] ParserRuleContext context)
        {
            base.ExitEveryRule(context);
        }

        public override void ExitExp([NotNull] LuaParser.ExpContext context)
        {
            base.ExitExp(context);
        }

        public override void ExitExplist([NotNull] LuaParser.ExplistContext context)
        {
            base.ExitExplist(context);
        }

        public override void ExitField([NotNull] LuaParser.FieldContext context)
        {
            base.ExitField(context);
        }

        public override void ExitFieldlist([NotNull] LuaParser.FieldlistContext context)
        {
            base.ExitFieldlist(context);
        }

        public override void ExitFieldsep([NotNull] LuaParser.FieldsepContext context)
        {
            base.ExitFieldsep(context);
        }

        public override void ExitForijkStat([NotNull] LuaParser.ForijkStatContext context)
        {
            base.ExitForijkStat(context);
        }

        public override void ExitForinStat([NotNull] LuaParser.ForinStatContext context)
        {
            base.ExitForinStat(context);
        }

        public override void ExitFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {
            base.ExitFuncbody(context);
        }

        public override void ExitFuncname([NotNull] LuaParser.FuncnameContext context)
        {
            base.ExitFuncname(context);
        }

        public override void ExitFunctioncall([NotNull] LuaParser.FunctioncallContext context)
        {
            base.ExitFunctioncall(context);
        }

        public override void ExitFunctioncallStat([NotNull] LuaParser.FunctioncallStatContext context)
        {
            base.ExitFunctioncallStat(context);
        }

        public override void ExitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {
            base.ExitFunctiondef(context);
        }

        public override void ExitFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context)
        {
            base.ExitFunctiondefExp(context);
        }

        public override void ExitFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context)
        {
            base.ExitFunctiondefStat(context);
        }

        public override void ExitIfelseStat([NotNull] LuaParser.IfelseStatContext context)
        {
            base.ExitIfelseStat(context);
        }

        public override void ExitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        {
            base.ExitLocalassignStat(context);
        }

        public override void ExitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {
            base.ExitLocalfunctiondefStat(context);
        }

        public override void ExitMuldivExp([NotNull] LuaParser.MuldivExpContext context)
        {
            base.ExitMuldivExp(context);
        }

        public override void ExitNameAndArgs([NotNull] LuaParser.NameAndArgsContext context)
        {
            base.ExitNameAndArgs(context);
        }

        public override void ExitNamelist([NotNull] LuaParser.NamelistContext context)
        {
            base.ExitNamelist(context);
        }

        public override void ExitNilfalsetruevararg([NotNull] LuaParser.NilfalsetruevarargContext context)
        {
            base.ExitNilfalsetruevararg(context);
        }

        public override void ExitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            base.ExitNilfalsetruevarargExp(context);
        }

        public override void ExitNormalArgs([NotNull] LuaParser.NormalArgsContext context)
        {
            base.ExitNormalArgs(context);
        }

        public override void ExitNumber([NotNull] LuaParser.NumberContext context)
        {
            base.ExitNumber(context);
        }

        public override void ExitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            base.ExitNumberExp(context);
        }

        public override void ExitOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context)
        {
            base.ExitOperatorAddSub(context);
        }

        public override void ExitOperatorAnd([NotNull] LuaParser.OperatorAndContext context)
        {
            base.ExitOperatorAnd(context);
        }

        public override void ExitOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context)
        {
            base.ExitOperatorBitwise(context);
        }

        public override void ExitOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context)
        {
            base.ExitOperatorComparison(context);
        }

        public override void ExitOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context)
        {
            base.ExitOperatorMulDivMod(context);
        }

        public override void ExitOperatorOr([NotNull] LuaParser.OperatorOrContext context)
        {
            base.ExitOperatorOr(context);
        }

        public override void ExitOperatorPower([NotNull] LuaParser.OperatorPowerContext context)
        {
            base.ExitOperatorPower(context);
        }

        public override void ExitOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context)
        {
            base.ExitOperatorStrcat(context);
        }

        public override void ExitOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context)
        {
            base.ExitOperatorUnary(context);
        }

        public override void ExitOrExp([NotNull] LuaParser.OrExpContext context)
        {
            base.ExitOrExp(context);
        }

        public override void ExitParlist([NotNull] LuaParser.ParlistContext context)
        {
            base.ExitParlist(context);
        }

        public override void ExitPowExp([NotNull] LuaParser.PowExpContext context)
        {
            base.ExitPowExp(context);
        }

        public override void ExitPrefixexp([NotNull] LuaParser.PrefixexpContext context)
        {
            base.ExitPrefixexp(context);
        }

        public override void ExitPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context)
        {
            base.ExitPrefixexpExp(context);
        }

        public override void ExitRepeatStat([NotNull] LuaParser.RepeatStatContext context)
        {
            base.ExitRepeatStat(context);
        }

        public override void ExitRetstat([NotNull] LuaParser.RetstatContext context)
        {
            base.ExitRetstat(context);
        }

        public override void ExitStat([NotNull] LuaParser.StatContext context)
        {
            base.ExitStat(context);
        }

        public override void ExitString([NotNull] LuaParser.StringContext context)
        {
            base.ExitString(context);
        }

        public override void ExitStringArgs([NotNull] LuaParser.StringArgsContext context)
        {
            base.ExitStringArgs(context);
        }

        public override void ExitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            base.ExitStringExp(context);
        }

        public override void ExitTableconstructor([NotNull] LuaParser.TableconstructorContext context)
        {
            base.ExitTableconstructor(context);
        }

        public override void ExitTablectorArgs([NotNull] LuaParser.TablectorArgsContext context)
        {
            base.ExitTablectorArgs(context);
        }

        public override void ExitTablectorExp([NotNull] LuaParser.TablectorExpContext context)
        {
            base.ExitTablectorExp(context);
        }

        public override void ExitUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            base.ExitUnmExp(context);
        }

        public override void ExitVar([NotNull] LuaParser.VarContext context)
        {
            base.ExitVar(context);
        }

        public override void ExitVarlist([NotNull] LuaParser.VarlistContext context)
        {
            base.ExitVarlist(context);
        }

        public override void ExitVarOrExp([NotNull] LuaParser.VarOrExpContext context)
        {
            base.ExitVarOrExp(context);
        }

        public override void ExitVarSuffix([NotNull] LuaParser.VarSuffixContext context)
        {
            base.ExitVarSuffix(context);
        }

        public override void ExitWhileStat([NotNull] LuaParser.WhileStatContext context)
        {
            base.ExitWhileStat(context);
        }

        public override void VisitErrorNode([NotNull] IErrorNode node)
        {
            base.VisitErrorNode(node);
        }

        public override void VisitTerminal([NotNull] ITerminalNode node)
        {
            base.VisitTerminal(node);
        }
    }
}
