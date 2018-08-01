using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;
using zlua.Gen;
using zlua.ISA;
using zlua.TypeModel;
namespace zlua.Parser
{
    public class lparser : LuaBaseVisitor<int>
    {
        #region 辅助parse的数据结构和函数s

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

        int nLabels = 0;
        int nTemps = 0;
        #endregion
        #region 自动生成的部分
        public override int VisitCmpExp([NotNull] LuaParser.CmpExpContext context)
        {
            switch (context.operatorComparison.Type) {
                case LuaLexer.LtKW:
                    Console.WriteLine( "Lt " + (nTemps++) + Visit(context.exp(0)) + Visit(context.exp(1)));
                    Console.WriteLine( "Jmp " + "foo");
                    break;
                case    LuaLexer.MtKW:
                    Console.WriteLine( "Lt " + (nTemps++) + Visit(context.exp(1)) + Visit(context.exp(0)));
                    Console.WriteLine( "Jmp " + "foo");
                    break;
                default:
                    break;
            }
            return  nTemps;
        }

        public override int VisitIfelseStat([NotNull] LuaParser.IfelseStatContext context)
        {
            Visit(context.exp());
            Visit(context.block());
            Console.WriteLine("L" + nLabels + ":");
            foreach (var item in context.elseifBlock()) {
                Visit(item);
                Console.WriteLine("L" + nLabels + ":");
            }
            Visit(context.elseBlock());
            Console.WriteLine("L" + nLabels + ":");
            return -1;
        }

        public override int VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg++, P.k.Count));
            P.k.Add((TValue)Double.Parse(context.GetText()));
            return -1;
        }

        public override int VisitUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            switch (context.operatorUnary.Type) {
                case LuaLexer.NotKW:
                    Console.WriteLine( "Not" + Visit(context.exp()));
                    break;
                default:
                    break;
            }
            return -1;
        }

        public override int VisitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
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
            return - 1;
        }
        public override int VisitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {
            EnterNewFunc();
            return -1;
        }
        public override int VisitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            switch (context.nilfalsetruevararg.Type) {
                case LuaLexer.NilKW:
                    P.codes.Add(new Bytecode(Opcodes.LoadNil, Fs.freereg, Fs.freereg, 0));
                    break;
                case LuaLexer.FalseKW:
                    P.codes.Add(new Bytecode(Opcodes.LoadBool, Fs.freereg, 0, 0));
                    break;
                case LuaLexer.TrueKW:
                    P.codes.Add(new Bytecode(Opcodes.LoadBool, Fs.freereg, 1, 0));
                    break;
                case LuaLexer.VarargKW:
                    //P.codes.Add(new Bytecode(Opcodes.VarArg,)) //《no frills》p51
                    throw new NotImplementedException();
                    break;
            }
            Fs.freereg++;
            return -1;
        }
        public override int VisitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            P.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freereg, P.k.Count));
            P.k.Add((TValue)context.GetText().Trim(new char[] { '\'', '\"' })); //strip quotes on both sides
            return -1;
        }
        #endregion
    }
}
