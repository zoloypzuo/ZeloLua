// 代码生成
//
// 变量和作用域的原理请先看p321的例子代码和右侧的示意图，然后就能看懂代码了
// 相关代码在funcInfo的scope区域
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;

using ZoloLua.Core.ObjectModel;

namespace ZoloLua.Compiler.CodeGenerator
{
    // 我决定暂时，至少名字不用antlr visitor，而是使用作者的命名
    internal class LuaCodeGenerator : LuaBaseVisitor<int>
    {
        // 当前函数
        private funcInfo fi;

        public Proto Chunk { get; }

        #region visitor

        protected override int DefaultResult => base.DefaultResult;

        public override int Visit([NotNull] IParseTree tree)
        {
            return base.Visit(tree);
        }

        public override int VisitChildren([NotNull] IRuleNode node)
        {
            return base.VisitChildren(node);
        }

        public override int VisitTerminal([NotNull] ITerminalNode node)
        {
            return base.VisitTerminal(node);
        }

        public override int VisitErrorNode([NotNull] IErrorNode node)
        {
            return base.VisitErrorNode(node);
        }

        protected override int AggregateResult(int aggregate, int nextResult)
        {
            return base.AggregateResult(aggregate, nextResult);
        }

        protected override bool ShouldVisitNextChild([NotNull] IRuleNode node, int currentResult)
        {
            return base.ShouldVisitNextChild(node, currentResult);
        }

        public override int VisitEmptyStat([NotNull] LuaParser.EmptyStatContext context)
        {
            return base.VisitEmptyStat(context);
        }

        public override int VisitAssignStat([NotNull] LuaParser.AssignStatContext context)
        {
            return base.VisitAssignStat(context);
        }

        public override int VisitFunctionCallStat([NotNull] LuaParser.FunctionCallStatContext context)
        {
            var r = fi.allocReg();
            VisitFunctioncall(context.functioncall());
            fi.freeReg();
            return 0;
        }

        public override int VisitBreakStat([NotNull] LuaParser.BreakStatContext context)
        {
            //int pc = fi.emitJmp(0, 0);
            //fi.addBreakJmp(pc);
            return 0;
        }

        public override int VisitDoStat([NotNull] LuaParser.DoStatContext context)
        {
            fi.enterScope(false);
            VisitBlock(context.block());
            fi.closeOpenUpvals();
            fi.exitScope();
            return 0;
        }

        public override int VisitWhileStat([NotNull] LuaParser.WhileStatContext context)
        {
            return base.VisitWhileStat(context);
        }

        public override int VisitRepeatStat([NotNull] LuaParser.RepeatStatContext context)
        {
            return base.VisitRepeatStat(context);
        }

        public override int VisitIfStat([NotNull] LuaParser.IfStatContext context)
        {
            return base.VisitIfStat(context);
        }

        public override int VisitForNmericStat([NotNull] LuaParser.ForNmericStatContext context)
        {
            return base.VisitForNmericStat(context);
        }

        public override int VisitForGenericStat([NotNull] LuaParser.ForGenericStatContext context)
        {
            return base.VisitForGenericStat(context);
        }

        public override int VisitFunctionDefStat([NotNull] LuaParser.FunctionDefStatContext context)
        {
            return 0;
        }

        public override int VisitLocalFunctionDefStat([NotNull] LuaParser.LocalFunctionDefStatContext context)
        {
            // local function Name funcbody
            // 这里就只需要名字字符串
            var r = fi.addLocVar(context.NAME().GetText());
            VisitFuncbody(context.funcbody());
            return 0;
        }

        public override int VisitLocalDeclarationStat([NotNull] LuaParser.LocalDeclarationStatContext context)
        {
            return base.VisitLocalDeclarationStat(context);
        }

        public override int VisitNilExp([NotNull] LuaParser.NilExpContext context)
        {
            return base.VisitNilExp(context);
        }

        public override int VisitFalseExp([NotNull] LuaParser.FalseExpContext context)
        {
            return base.VisitFalseExp(context);
        }

        public override int VisitTrueExp([NotNull] LuaParser.TrueExpContext context)
        {
            return base.VisitTrueExp(context);
        }

        public override int VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            return base.VisitNumberExp(context);
        }

        public override int VisitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            return base.VisitStringExp(context);
        }

        public override int VisitVarargExp([NotNull] LuaParser.VarargExpContext context)
        {
            return base.VisitVarargExp(context);
        }

        public override int VisitFunctionDefExp([NotNull] LuaParser.FunctionDefExpContext context)
        {
            return base.VisitFunctionDefExp(context);
        }

        public override int VisitPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context)
        {
            return base.VisitPrefixexpExp(context);
        }

        public override int VisitTableCtorExp([NotNull] LuaParser.TableCtorExpContext context)
        {
            return base.VisitTableCtorExp(context);
        }

        public override int VisitPowExp([NotNull] LuaParser.PowExpContext context)
        {
            return base.VisitPowExp(context);
        }

        public override int VisitUnaryExp([NotNull] LuaParser.UnaryExpContext context)
        {
            return base.VisitUnaryExp(context);
        }

        public override int VisitMulOrDivOrModExp([NotNull] LuaParser.MulOrDivOrModExpContext context)
        {
            return base.VisitMulOrDivOrModExp(context);
        }

        public override int VisitAddOrSubExp([NotNull] LuaParser.AddOrSubExpContext context)
        {
            return base.VisitAddOrSubExp(context);
        }

        public override int VisitConcatExp([NotNull] LuaParser.ConcatExpContext context)
        {
            return base.VisitConcatExp(context);
        }

        public override int VisitCompareExp([NotNull] LuaParser.CompareExpContext context)
        {
            return base.VisitCompareExp(context);
        }

        public override int VisitAndExp([NotNull] LuaParser.AndExpContext context)
        {
            return base.VisitAndExp(context);
        }

        public override int VisitOrExp([NotNull] LuaParser.OrExpContext context)
        {
            return base.VisitOrExp(context);
        }

        public override int VisitNameP0([NotNull] LuaParser.NameP0Context context)
        {
            return base.VisitNameP0(context);
        }

        public override int VisitBracedExpP1([NotNull] LuaParser.BracedExpP1Context context)
        {
            return base.VisitBracedExpP1(context);
        }

        public override int VisitIndexerP1([NotNull] LuaParser.IndexerP1Context context)
        {
            return base.VisitIndexerP1(context);
        }

        public override int VisitNameAndArgsP1([NotNull] LuaParser.NameAndArgsP1Context context)
        {
            return base.VisitNameAndArgsP1(context);
        }

        public override int VisitNameLvalue([NotNull] LuaParser.NameLvalueContext context)
        {
            return base.VisitNameLvalue(context);
        }

        public override int VisitIndexerLvalue([NotNull] LuaParser.IndexerLvalueContext context)
        {
            return base.VisitIndexerLvalue(context);
        }

        public override int VisitBracketIndexer([NotNull] LuaParser.BracketIndexerContext context)
        {
            return base.VisitBracketIndexer(context);
        }

        public override int VisitDotIndexer([NotNull] LuaParser.DotIndexerContext context)
        {
            return base.VisitDotIndexer(context);
        }

        public override int VisitBracedArgs([NotNull] LuaParser.BracedArgsContext context)
        {
            return base.VisitBracedArgs(context);
        }

        public override int VisitTablectorArgs([NotNull] LuaParser.TablectorArgsContext context)
        {
            return base.VisitTablectorArgs(context);
        }

        public override int VisitStringArgs([NotNull] LuaParser.StringArgsContext context)
        {
            return base.VisitStringArgs(context);
        }

        public override int VisitNamelistParlist([NotNull] LuaParser.NamelistParlistContext context)
        {
            return base.VisitNamelistParlist(context);
        }

        public override int VisitVarargParlist([NotNull] LuaParser.VarargParlistContext context)
        {
            return base.VisitVarargParlist(context);
        }

        public override int VisitChunk([NotNull] LuaParser.ChunkContext context)
        {
            VisitBlock(context.block());
            return 0;
        }

        public override int VisitBlock([NotNull] LuaParser.BlockContext context)
        {
            foreach (var stat in context.stat()) {
                VisitStat(stat);
            }
            var retstat = context.retstat();
            if (retstat != null) {
                VisitRetstat(retstat);
            }
            return 0;
        }

        public override int VisitRetstat([NotNull] LuaParser.RetstatContext context)
        {
            var explist = context.explist();
            // "return"
            if (explist == null) {
                // 生成return nil语句
                fi.emitReturn(0, 0);
                return 0;
            } else {
                var expStar = explist.exp();
                // 确认explist最后一个元素是vararg或函数
                bool multRet = isVarargOrFuncCall(expStar[expStar.Length - 1]);
                //TODO
                // 这里很依赖最后一个元素
                // 如果最后一个exp是vararg或函数
                // 要visit exp(fi,exp,r,-1)
                // 对于前面的元素，要visit exp(fi,exp,r,1)
                //fi.freeRegs(nExps);
                foreach (var item in expStar) {
                }
                int a = fi.usedRegs;
                if (multRet) {
                    fi.emitReturn(a, -1);
                } else {
                    //fi.emitReturn(a.nExps);
                }
            }
            // p328 最下面
            // 作者不实现尾递归
            return 0;
        }

        private bool isVarargOrFuncCall(LuaParser.ExpContext context)
        {
            //TODO
            bool isFuncCall = context is LuaParser.PrefixexpExpContext;
            return context is LuaParser.VarargExpContext || isFuncCall;
        }

        public override int VisitStat([NotNull] LuaParser.StatContext context)
        {
            return base.VisitStat(context);
        }

        public override int VisitElseifBlock([NotNull] LuaParser.ElseifBlockContext context)
        {
            return base.VisitElseifBlock(context);
        }

        public override int VisitElseBlock([NotNull] LuaParser.ElseBlockContext context)
        {
            return base.VisitElseBlock(context);
        }

        public override int VisitFuncname([NotNull] LuaParser.FuncnameContext context)
        {
            return base.VisitFuncname(context);
        }

        public override int VisitDotName([NotNull] LuaParser.DotNameContext context)
        {
            return base.VisitDotName(context);
        }

        public override int VisitColonName([NotNull] LuaParser.ColonNameContext context)
        {
            return base.VisitColonName(context);
        }

        public override int VisitVarlist([NotNull] LuaParser.VarlistContext context)
        {
            return base.VisitVarlist(context);
        }

        public override int VisitNamelist([NotNull] LuaParser.NamelistContext context)
        {
            return base.VisitNamelist(context);
        }

        public override int VisitExplist([NotNull] LuaParser.ExplistContext context)
        {
            return base.VisitExplist(context);
        }

        public override int VisitExp([NotNull] LuaParser.ExpContext context)
        {
            return base.VisitExp(context);
        }

        public override int VisitOpUnary([NotNull] LuaParser.OpUnaryContext context)
        {
            return base.VisitOpUnary(context);
        }

        public override int VisitOpMulOrDivOrMod([NotNull] LuaParser.OpMulOrDivOrModContext context)
        {
            return base.VisitOpMulOrDivOrMod(context);
        }

        public override int VisitOpAddOrSub([NotNull] LuaParser.OpAddOrSubContext context)
        {
            return base.VisitOpAddOrSub(context);
        }

        public override int VisitOpCmp([NotNull] LuaParser.OpCmpContext context)
        {
            return base.VisitOpCmp(context);
        }

        public override int VisitPrefixexp([NotNull] LuaParser.PrefixexpContext context)
        {
            return base.VisitPrefixexp(context);
        }

        public override int VisitPrefixexp0([NotNull] LuaParser.Prefixexp0Context context)
        {
            return base.VisitPrefixexp0(context);
        }

        public override int VisitPrefixexp1([NotNull] LuaParser.Prefixexp1Context context)
        {
            return base.VisitPrefixexp1(context);
        }

        public override int VisitFunctioncall([NotNull] LuaParser.FunctioncallContext context)
        {
            return base.VisitFunctioncall(context);
        }

        public override int VisitVar([NotNull] LuaParser.VarContext context)
        {
            return base.VisitVar(context);
        }

        public override int VisitIndexer([NotNull] LuaParser.IndexerContext context)
        {
            return base.VisitIndexer(context);
        }

        public override int VisitNameAndArgs([NotNull] LuaParser.NameAndArgsContext context)
        {
            return base.VisitNameAndArgs(context);
        }

        public override int VisitArgs([NotNull] LuaParser.ArgsContext context)
        {
            return base.VisitArgs(context);
        }

        public override int VisitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {
            return base.VisitFunctiondef(context);
        }

        public override int VisitFuncbody([NotNull] LuaParser.FuncbodyContext context)
        {
            return base.VisitFuncbody(context);
        }

        public override int VisitParlist([NotNull] LuaParser.ParlistContext context)
        {
            return base.VisitParlist(context);
        }

        public override int VisitTableconstructor([NotNull] LuaParser.TableconstructorContext context)
        {
            return base.VisitTableconstructor(context);
        }

        public override int VisitFieldlist([NotNull] LuaParser.FieldlistContext context)
        {
            return base.VisitFieldlist(context);
        }

        public override int VisitField([NotNull] LuaParser.FieldContext context)
        {
            return base.VisitField(context);
        }

        public override int VisitFieldsep([NotNull] LuaParser.FieldsepContext context)
        {
            return base.VisitFieldsep(context);
        }

        public override int VisitNumber([NotNull] LuaParser.NumberContext context)
        {
            return base.VisitNumber(context);
        }

        public override int VisitString([NotNull] LuaParser.StringContext context)
        {
            return base.VisitString(context);
        }

        #endregion visitor
    }
}