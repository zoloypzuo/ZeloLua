using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.AntlrGen;
using zlua.TypeModel;
namespace zlua
{
    class lvisitor : LuaBaseVisitor<TValue>
    {
        protected override TValue DefaultResult => base.DefaultResult;
        public override TValue Visit(IParseTree tree) { return base.Visit(tree); }
        public override TValue VisitAddsubExp([NotNull] LuaParser.AddsubExpContext context) { return base.VisitAddsubExp(context); }
        public override TValue VisitAndExp([NotNull] LuaParser.AndExpContext context) { return base.VisitAndExp(context); }
        public override TValue VisitArgs([NotNull] LuaParser.ArgsContext context) { return base.VisitArgs(context); }
        public override TValue VisitAssignStat([NotNull] LuaParser.AssignStatContext context) { return base.VisitAssignStat(context); }
        public override TValue VisitBitwiseExp([NotNull] LuaParser.BitwiseExpContext context) { return base.VisitBitwiseExp(context); }
        public override TValue VisitBlock([NotNull] LuaParser.BlockContext context) { return base.VisitBlock(context); }
        public override TValue VisitBreakStat([NotNull] LuaParser.BreakStatContext context) { return base.VisitBreakStat(context); }
        public override TValue VisitChildren(IRuleNode node) { return base.VisitChildren(node); }
        public override TValue VisitChunk([NotNull] LuaParser.ChunkContext context) { return base.VisitChunk(context); }
        public override TValue VisitCmpExp([NotNull] LuaParser.CmpExpContext context) { return base.VisitCmpExp(context); }
        public override TValue VisitConcatExp([NotNull] LuaParser.ConcatExpContext context) { return base.VisitConcatExp(context); }
        public override TValue VisitDoendStat([NotNull] LuaParser.DoendStatContext context) { return base.VisitDoendStat(context); }
        public override TValue VisitEmptyStat([NotNull] LuaParser.EmptyStatContext context) { return base.VisitEmptyStat(context); }
        public override TValue VisitErrorNode(IErrorNode node) { return base.VisitErrorNode(node); }
        public override TValue VisitExp([NotNull] LuaParser.ExpContext context) { return base.VisitExp(context); }
        public override TValue VisitExplist([NotNull] LuaParser.ExplistContext context) { return base.VisitExplist(context); }
        public override TValue VisitField([NotNull] LuaParser.FieldContext context) { return base.VisitField(context); }
        public override TValue VisitFieldlist([NotNull] LuaParser.FieldlistContext context) { return base.VisitFieldlist(context); }
        public override TValue VisitFieldsep([NotNull] LuaParser.FieldsepContext context) { return base.VisitFieldsep(context); }
        public override TValue VisitForijkStat([NotNull] LuaParser.ForijkStatContext context) { return base.VisitForijkStat(context); }
        public override TValue VisitForinStat([NotNull] LuaParser.ForinStatContext context) { return base.VisitForinStat(context); }
        public override TValue VisitFuncbody([NotNull] LuaParser.FuncbodyContext context) { return base.VisitFuncbody(context); }
        public override TValue VisitFuncname([NotNull] LuaParser.FuncnameContext context) { return base.VisitFuncname(context); }
        public override TValue VisitFunctioncall([NotNull] LuaParser.FunctioncallContext context) { return base.VisitFunctioncall(context); }
        public override TValue VisitFunctioncallStat([NotNull] LuaParser.FunctioncallStatContext context) { return base.VisitFunctioncallStat(context); }
        public override TValue VisitFunctiondef([NotNull] LuaParser.FunctiondefContext context) { return base.VisitFunctiondef(context); }
        public override TValue VisitFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context) { return base.VisitFunctiondefExp(context); }
        public override TValue VisitFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context) { return base.VisitFunctiondefStat(context); }
        public override TValue VisitIfelseStat([NotNull] LuaParser.IfelseStatContext context) { return base.VisitIfelseStat(context); }
        public override TValue VisitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context) { return base.VisitLocalassignStat(context); }
        public override TValue VisitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context) { return base.VisitLocalfunctiondefStat(context); }
        public override TValue VisitMuldivExp([NotNull] LuaParser.MuldivExpContext context) { return base.VisitMuldivExp(context); }
        public override TValue VisitNameAndArgs([NotNull] LuaParser.NameAndArgsContext context) { return base.VisitNameAndArgs(context); }
        public override TValue VisitNamelist([NotNull] LuaParser.NamelistContext context) { return base.VisitNamelist(context); }
        public override TValue VisitNilfalsetruevararg([NotNull] LuaParser.NilfalsetruevarargContext context) { return base.VisitNilfalsetruevararg(context); }
        public override TValue VisitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context) { return base.VisitNilfalsetruevarargExp(context); }
        public override TValue VisitNormalArgs([NotNull] LuaParser.NormalArgsContext context) { return base.VisitNormalArgs(context); }
        public override TValue VisitNumber([NotNull] LuaParser.NumberContext context) { return base.VisitNumber(context); }
        public override TValue VisitNumberExp([NotNull] LuaParser.NumberExpContext context) { return base.VisitNumberExp(context); }
        public override TValue VisitOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context) { return base.VisitOperatorAddSub(context); }
        public override TValue VisitOperatorAnd([NotNull] LuaParser.OperatorAndContext context) { return base.VisitOperatorAnd(context); }
        public override TValue VisitOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context) { return base.VisitOperatorBitwise(context); }
        public override TValue VisitOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context) { return base.VisitOperatorComparison(context); }
        public override TValue VisitOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context) { return base.VisitOperatorMulDivMod(context); }
        public override TValue VisitOperatorOr([NotNull] LuaParser.OperatorOrContext context) { return base.VisitOperatorOr(context); }
        public override TValue VisitOperatorPower([NotNull] LuaParser.OperatorPowerContext context) { return base.VisitOperatorPower(context); }
        public override TValue VisitOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context) { return base.VisitOperatorStrcat(context); }
        public override TValue VisitOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context) { return base.VisitOperatorUnary(context); }
        public override TValue VisitOrExp([NotNull] LuaParser.OrExpContext context) { return base.VisitOrExp(context); }
        public override TValue VisitParlist([NotNull] LuaParser.ParlistContext context) { return base.VisitParlist(context); }
        public override TValue VisitPowExp([NotNull] LuaParser.PowExpContext context) { return base.VisitPowExp(context); }
        public override TValue VisitPrefixexp([NotNull] LuaParser.PrefixexpContext context) { return base.VisitPrefixexp(context); }
        public override TValue VisitPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context) { return base.VisitPrefixexpExp(context); }
        public override TValue VisitRepeatStat([NotNull] LuaParser.RepeatStatContext context) { return base.VisitRepeatStat(context); }
        public override TValue VisitRetstat([NotNull] LuaParser.RetstatContext context) { return base.VisitRetstat(context); }
        public override TValue VisitStat([NotNull] LuaParser.StatContext context) { return base.VisitStat(context); }
        public override TValue VisitString([NotNull] LuaParser.StringContext context) { return base.VisitString(context); }
        public override TValue VisitStringArgs([NotNull] LuaParser.StringArgsContext context) { return base.VisitStringArgs(context); }
        public override TValue VisitStringExp([NotNull] LuaParser.StringExpContext context) { return base.VisitStringExp(context); }
        public override TValue VisitTableconstructor([NotNull] LuaParser.TableconstructorContext context) { return base.VisitTableconstructor(context); }
        public override TValue VisitTablectorArgs([NotNull] LuaParser.TablectorArgsContext context) { return base.VisitTablectorArgs(context); }
        public override TValue VisitTablectorExp([NotNull] LuaParser.TablectorExpContext context) { return base.VisitTablectorExp(context); }
        public override TValue VisitTerminal(ITerminalNode node) { return base.VisitTerminal(node); }
        public override TValue VisitUnmExp([NotNull] LuaParser.UnmExpContext context) { return base.VisitUnmExp(context); }
        public override TValue VisitVar([NotNull] LuaParser.VarContext context) { return base.VisitVar(context); }
        public override TValue VisitVarlist([NotNull] LuaParser.VarlistContext context) { return base.VisitVarlist(context); }
        public override TValue VisitVarOrExp([NotNull] LuaParser.VarOrExpContext context) { return base.VisitVarOrExp(context); }
        public override TValue VisitVarSuffix([NotNull] LuaParser.VarSuffixContext context) { return base.VisitVarSuffix(context); }
        public override TValue VisitWhileStat([NotNull] LuaParser.WhileStatContext context) { return base.VisitWhileStat(context); }
        protected override TValue AggregateResult(TValue aggregate, TValue nextResult) { return base.AggregateResult(aggregate, nextResult); }
        protected override bool ShouldVisitNextChild(IRuleNode node, TValue currentResult) { return base.ShouldVisitNextChild(node, currentResult); }
    }
}
