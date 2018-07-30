using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.AntlrGen;
using zlua.ISA;
using zlua.TypeModel;
namespace zlua.Parser
{
    public class lparser : LuaBaseListener
    {
        /// <summary>
        /// 由chunk编译好的proto，返回给loadfile
        /// </summary>
        public Proto ChunkProto
        {
            get
            {
                Debug.Assert(fsStack.Count == 1); //chunk没有父
                Debug.Assert(P.nUpvals == 0); //chunk没有upval（别忘了是5.1.4）
                return P;
            }
        }
        /// <summary>
        /// 编译时函数块是一个同质的嵌套结构，因此是一个标准的Stack<T>，所以T=FuncState
        /// 其实只要Stack<Proto>就可以了，但是我们把需要的东西包裹起来,这里用单链表实现一个栈（可以改进）
        /// </summary>
        public class FuncState
        {
            public Proto f; //当前proto
            public Dictionary<string, TValue> k;
            //public FuncState prev; //父指针 /* enclosing function */
            public TTable h;  /* table to find (and reuse) elements in `k' */
                              //struct LexState *ls;  /* lexical state */
                              //struct lua_State *L;  /* copy of the Lua state */
                              //struct BlockCnt *bl;  /* chain of current blocks */
            int pc;  /* next position to code (equivalent to `ncode') */
            int lasttarget;   /* `pc' of last `jump target' */ // 这里存放的是所有空悬,也就是没有确定好跳转位置的pc链表
            int jpc;  /* list of pending jumps to `pc' */
            public int freereg;  /* first free register */
            //int nk;  /* number of elements in `k' */
            //int np;  /* number of elements in `p' */ 
            short nlocvars;  /* number of elements in `locvars' */
            int nactvar;  /* number of active local variables */ //活着的locals个数
                                                                 //upvaldesc upvalues[LUAI_MAXUPVALUES];  /* upvalues */  
                                                                 //unsigned short actvar[LUAI_MAXVARS];  /* declared-variable stack */ //已声明的变量栈
                                                                 /// <summary>
                                                                 /// 指向第一个指令数组的可用位置（名字换成next？）
                                                                 /// </summary>
            public int CurrPc { get => pc; }
        }
        Stack<FuncState> fsStack = new Stack<FuncState>();
        FuncState Fs { get => fsStack.Peek(); }
        Proto P { get => Fs.f; }
        /// <summary>
        /// 非常不好的编程方式，但是我想不到其他办法。exp必须独立计算，因此我们从stat部分生成一些控制信号。
        /// 左值的id个数
        /// </summary>
        int nNames = 0;
        public lparser()
        {
            fsStack.Push(new FuncState() {
                f = new Proto(),
            });  //压入chunk这个栈帧
        }
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
            var namelist = context.namelist().NAME();
            bool no_equal = context.GetToken(2, 0) == null;
            // local a,b,c=1,2,3 左侧加符号表，加初始化指令；右侧要从某个地方（exp栈可能）拿到exp的位置，而且不知道指令类型TODO
            // local a,b,c 只声明不赋值，根据有没有=判断，freereg+=n，names加入符号表
            // local a,b,c=1 右侧不足，同上
            // local a,b=1,2,3,4 截断

            //初始化locvar
            for (int i = 0; i < namelist.Length; i++) {
                var lv = new LocVar() {
                    var_name = namelist[i].GetText(),
                    startpc = Fs.CurrPc,
                };
                P.locvars.Add(lv);

            }
            nNames = namelist.Length;
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
        /// <summary>
        /// 'local' namelist ('=' explist)? #localassignStat
        /// </summary>
        /// <param name="context"></param>
        public override void ExitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        {
            //一次性补齐nil
            if (nNames > 0) {
                P.codes.Add(new Bytecode(Opcodes.LoadNil, Fs.freereg, Fs.freereg + nNames - 1, 0));
                Fs.freereg++;
                nNames = 0;
            }
        }

        public override void ExitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {

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
            if (nNames == 0)
                return;
            switch (context.GetText()) {
                case "nil":
                    P.codes.Add(new Bytecode(Opcodes.LoadNil, Fs.freereg, Fs.freereg, 0));
                    break;
                case "false":
                    P.codes.Add(new Bytecode(Opcodes.LoadBool, Fs.freereg, 0, 0));
                    break;
                case "true":
                    P.codes.Add(new Bytecode(Opcodes.LoadBool, Fs.freereg, 1, 0));
                    break;
                case "vararg":
                    //P.codes.Add(new Bytecode(Opcodes.VarArg,)) //《no frills》p51
                    throw new NotImplementedException();
                    break;
            }
            Fs.freereg++;
            nNames--;
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
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg++, P.k.Count));
            P.k.Add((TValue)Double.Parse(context.GetText()));
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
            if (nNames == 0) return;
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg,P.k.Count));
            P.k.Add((TValue)context.GetText().Trim(new char[]{ '\'','\"'})); //strip quotes on both sides 
            nNames--;
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
