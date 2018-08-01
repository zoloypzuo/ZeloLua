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
        /// 编译时函数块是一个同质的嵌套结构，因此是一个标准的Stack<T>，所以T=FuncState
        /// 其实只要Stack<Proto>就可以了，但是我们把需要的东西包裹起来,这里用单链表实现一个栈（可以改进）
        /// </summary>
        public class FuncState
        {
            public Proto p = new Proto(); //当前proto
            /// <summary>
            /// first free register
            /// </summary>
            public int freereg = 1;
            /// <summary>
            /// 指向第一个指令数组的可用位置
            /// </summary>
            public int CurrPc { get => p.codes.Count; }
        }
        Stack<FuncState> fsStack = new Stack<FuncState>();
        /// <summary>
        /// 进入新函数
        /// </summary>
        void EnterNewFunc()
        {
            var fs = fsStack.Peek();
            var new_fs = new FuncState();
            fs.p.inner_funcs.Add(new_fs.p);
            fsStack.Push(new_fs);
        }
        /// <summary>
        /// 离开当前函数
        /// </summary>
        void ExitCurrFunc()
        {
            fsStack.Pop();
        }
        FuncState Fs { get => fsStack.Peek(); }
        public Proto P { get => Fs.p; }
        /// <summary>
        /// exp必须独立计算，因此我们从stat部分生成一些控制信号。
        /// 左值的id个数
        /// </summary>
        int nNames = 0;
        public lparser()
        {
            fsStack.Push(new FuncState()); //压入chunk这个栈帧
        }
        public override void EnterAddsubExp([NotNull] LuaParser.AddsubExpContext context) { }
        public override void EnterAndExp([NotNull] LuaParser.AndExpContext context) { }
        public override void EnterArgs([NotNull] LuaParser.ArgsContext context) { }
        public override void EnterAssignStat([NotNull] LuaParser.AssignStatContext context) { }
        public override void EnterBitwiseExp([NotNull] LuaParser.BitwiseExpContext context) { }
        public override void EnterBlock([NotNull] LuaParser.BlockContext context) { }
        public override void EnterBreakStat([NotNull] LuaParser.BreakStatContext context) { }
        public override void EnterChunk([NotNull] LuaParser.ChunkContext context) { }
        public override void EnterCmpExp([NotNull] LuaParser.CmpExpContext context) { }
        public override void EnterConcatExp([NotNull] LuaParser.ConcatExpContext context) { }
        public override void EnterDoendStat([NotNull] LuaParser.DoendStatContext context) { }
        public override void EnterEmptyStat([NotNull] LuaParser.EmptyStatContext context) { }
        public override void EnterEveryRule([NotNull] ParserRuleContext context) { }
        public override void EnterExp([NotNull] LuaParser.ExpContext context)
        {

        }
        public override void EnterExplist([NotNull] LuaParser.ExplistContext context) { }
        public override void EnterField([NotNull] LuaParser.FieldContext context) { }
        public override void EnterFieldlist([NotNull] LuaParser.FieldlistContext context) { }
        public override void EnterFieldsep([NotNull] LuaParser.FieldsepContext context) { }
        public override void EnterForijkStat([NotNull] LuaParser.ForijkStatContext context) { }
        public override void EnterForinStat([NotNull] LuaParser.ForinStatContext context) { }
        public override void EnterFuncbody([NotNull] LuaParser.FuncbodyContext context) { }
        public override void EnterFuncname([NotNull] LuaParser.FuncnameContext context) { }
        public override void EnterFunctioncall([NotNull] LuaParser.FunctioncallContext context) { }
        public override void EnterFunctioncallStat([NotNull] LuaParser.FunctioncallStatContext context) { }
        public override void EnterFunctiondef([NotNull] LuaParser.FunctiondefContext context) { }
        public override void EnterFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context)
        {

            //准备新的FS
            EnterNewFunc();
        }
        public override void EnterFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context) { }
        public override void EnterIfelseStat([NotNull] LuaParser.IfelseStatContext context) { }
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
        public override void EnterLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context) { }
        public override void EnterMuldivExp([NotNull] LuaParser.MuldivExpContext context) { }
        public override void EnterNameAndArgs([NotNull] LuaParser.NameAndArgsContext context) { }
        public override void EnterNamelist([NotNull] LuaParser.NamelistContext context) { }
        public override void EnterNilfalsetruevararg([NotNull] LuaParser.NilfalsetruevarargContext context) { }
        public override void EnterNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context) { }
        public override void EnterNormalArgs([NotNull] LuaParser.NormalArgsContext context) { }
        public override void EnterNumber([NotNull] LuaParser.NumberContext context) { }
        public override void EnterNumberExp([NotNull] LuaParser.NumberExpContext context) { }
        public override void EnterOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context) { }
        public override void EnterOperatorAnd([NotNull] LuaParser.OperatorAndContext context) { }
        public override void EnterOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context) { }
        public override void EnterOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context) { }
        public override void EnterOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context) { }
        public override void EnterOperatorOr([NotNull] LuaParser.OperatorOrContext context) { }
        public override void EnterOperatorPower([NotNull] LuaParser.OperatorPowerContext context) { }
        public override void EnterOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context) { }
        public override void EnterOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context) { }
        public override void EnterOrExp([NotNull] LuaParser.OrExpContext context) { }
        public override void EnterParlist([NotNull] LuaParser.ParlistContext context) { }
        public override void EnterPowExp([NotNull] LuaParser.PowExpContext context) { }
        public override void EnterPrefixexp([NotNull] LuaParser.PrefixexpContext context) { }
        public override void EnterPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context) { }
        public override void EnterRepeatStat([NotNull] LuaParser.RepeatStatContext context) { }
        public override void EnterRetstat([NotNull] LuaParser.RetstatContext context) { }
        public override void EnterStat([NotNull] LuaParser.StatContext context) { }
        public override void EnterString([NotNull] LuaParser.StringContext context) { }
        public override void EnterStringArgs([NotNull] LuaParser.StringArgsContext context) { }
        public override void EnterStringExp([NotNull] LuaParser.StringExpContext context) { }
        public override void EnterTableconstructor([NotNull] LuaParser.TableconstructorContext context) { }
        public override void EnterTablectorArgs([NotNull] LuaParser.TablectorArgsContext context) { }
        public override void EnterTablectorExp([NotNull] LuaParser.TablectorExpContext context) { }
        public override void EnterUnmExp([NotNull] LuaParser.UnmExpContext context) { }
        public override void EnterVar([NotNull] LuaParser.VarContext context) { }
        public override void EnterVarlist([NotNull] LuaParser.VarlistContext context) { }
        public override void EnterVarOrExp([NotNull] LuaParser.VarOrExpContext context) { }
        public override void EnterVarSuffix([NotNull] LuaParser.VarSuffixContext context) { }
        public override void EnterWhileStat([NotNull] LuaParser.WhileStatContext context) { }
        public override void ExitAddsubExp([NotNull] LuaParser.AddsubExpContext context) { }
        public override void ExitAndExp([NotNull] LuaParser.AndExpContext context) { }
        public override void ExitArgs([NotNull] LuaParser.ArgsContext context) { }
        public override void ExitAssignStat([NotNull] LuaParser.AssignStatContext context) { }
        public override void ExitBitwiseExp([NotNull] LuaParser.BitwiseExpContext context) { }
        public override void ExitBlock([NotNull] LuaParser.BlockContext context) { }
        public override void ExitBreakStat([NotNull] LuaParser.BreakStatContext context) { }
        public override void ExitChunk([NotNull] LuaParser.ChunkContext context) { }
        public override void ExitCmpExp([NotNull] LuaParser.CmpExpContext context) { }
        public override void ExitConcatExp([NotNull] LuaParser.ConcatExpContext context) { }
        public override void ExitDoendStat([NotNull] LuaParser.DoendStatContext context) { }
        public override void ExitEmptyStat([NotNull] LuaParser.EmptyStatContext context) { }
        public override void ExitEveryRule([NotNull] ParserRuleContext context) { }
        public override void ExitExp([NotNull] LuaParser.ExpContext context)
        {
            if (nNames == 0)
                return;
            nNames--;
        }
        public override void ExitExplist([NotNull] LuaParser.ExplistContext context) { }
        public override void ExitField([NotNull] LuaParser.FieldContext context) { }
        public override void ExitFieldlist([NotNull] LuaParser.FieldlistContext context) { }
        public override void ExitFieldsep([NotNull] LuaParser.FieldsepContext context) { }
        public override void ExitForijkStat([NotNull] LuaParser.ForijkStatContext context) { }
        public override void ExitForinStat([NotNull] LuaParser.ForinStatContext context) { }
        public override void ExitFuncbody([NotNull] LuaParser.FuncbodyContext context) { }
        public override void ExitFuncname([NotNull] LuaParser.FuncnameContext context) { }
        public override void ExitFunctioncall([NotNull] LuaParser.FunctioncallContext context) { }
        public override void ExitFunctioncallStat([NotNull] LuaParser.FunctioncallStatContext context) { }
        public override void ExitFunctiondef([NotNull] LuaParser.FunctiondefContext context) { }
        public override void ExitFunctiondefExp([NotNull] LuaParser.FunctiondefExpContext context) { }
        public override void ExitFunctiondefStat([NotNull] LuaParser.FunctiondefStatContext context) { }
        public override void ExitIfelseStat([NotNull] LuaParser.IfelseStatContext context) { }
        public override void ExitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
        {
            //一次性补齐nil
            if (nNames != 0) {
                P.codes.Add(new Bytecode(Opcodes.LoadNil, Fs.freereg, Fs.freereg + nNames - 1, 0));
                Fs.freereg++;
                nNames = 0;
            }
            Debug.Assert(nNames == 0); //每次结束nNames应消耗完
        }
        public override void ExitLocalfunctiondefStat([NotNull] LuaParser.LocalfunctiondefStatContext context)
        {
        }
        public override void ExitMuldivExp([NotNull] LuaParser.MuldivExpContext context) { }
        public override void ExitNameAndArgs([NotNull] LuaParser.NameAndArgsContext context) { }
        public override void ExitNamelist([NotNull] LuaParser.NamelistContext context) { }
        public override void ExitNilfalsetruevararg([NotNull] LuaParser.NilfalsetruevarargContext context) { }
        public override void ExitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
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
        }
        public override void ExitNormalArgs([NotNull] LuaParser.NormalArgsContext context) { }
        public override void ExitNumber([NotNull] LuaParser.NumberContext context) { }
        public override void ExitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg++, P.k.Count));
            P.k.Add((TValue)Double.Parse(context.GetText()));
        }
        public override void ExitOperatorAddSub([NotNull] LuaParser.OperatorAddSubContext context) { }
        public override void ExitOperatorAnd([NotNull] LuaParser.OperatorAndContext context) { }
        public override void ExitOperatorBitwise([NotNull] LuaParser.OperatorBitwiseContext context) { }
        public override void ExitOperatorComparison([NotNull] LuaParser.OperatorComparisonContext context) { }
        public override void ExitOperatorMulDivMod([NotNull] LuaParser.OperatorMulDivModContext context) { }
        public override void ExitOperatorOr([NotNull] LuaParser.OperatorOrContext context) { }
        public override void ExitOperatorPower([NotNull] LuaParser.OperatorPowerContext context) { }
        public override void ExitOperatorStrcat([NotNull] LuaParser.OperatorStrcatContext context) { }
        public override void ExitOperatorUnary([NotNull] LuaParser.OperatorUnaryContext context) { }
        public override void ExitOrExp([NotNull] LuaParser.OrExpContext context) { }
        public override void ExitParlist([NotNull] LuaParser.ParlistContext context) { }
        public override void ExitPowExp([NotNull] LuaParser.PowExpContext context) { }
        public override void ExitPrefixexp([NotNull] LuaParser.PrefixexpContext context) { }
        public override void ExitPrefixexpExp([NotNull] LuaParser.PrefixexpExpContext context) { }
        public override void ExitRepeatStat([NotNull] LuaParser.RepeatStatContext context) { }
        public override void ExitRetstat([NotNull] LuaParser.RetstatContext context) { }
        public override void ExitStat([NotNull] LuaParser.StatContext context) { }
        public override void ExitString([NotNull] LuaParser.StringContext context) { }
        public override void ExitStringArgs([NotNull] LuaParser.StringArgsContext context) { }
        public override void ExitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg, P.k.Count));
            P.k.Add((TValue)context.GetText().Trim(new char[] { '\'', '\"' })); //strip quotes on both sides
        }
        public override void ExitTableconstructor([NotNull] LuaParser.TableconstructorContext context) { }
        public override void ExitTablectorArgs([NotNull] LuaParser.TablectorArgsContext context) { }
        public override void ExitTablectorExp([NotNull] LuaParser.TablectorExpContext context) { }
        public override void ExitUnmExp([NotNull] LuaParser.UnmExpContext context) { }
        public override void ExitVar([NotNull] LuaParser.VarContext context) { }
        public override void ExitVarlist([NotNull] LuaParser.VarlistContext context) { }
        public override void ExitVarOrExp([NotNull] LuaParser.VarOrExpContext context) { }
        public override void ExitVarSuffix([NotNull] LuaParser.VarSuffixContext context) { }
        public override void ExitWhileStat([NotNull] LuaParser.WhileStatContext context) { }
        public override void VisitErrorNode([NotNull] IErrorNode node) { }
        [DebuggerStepThrough]
        public override void VisitTerminal([NotNull] ITerminalNode node) { }
    }
}
