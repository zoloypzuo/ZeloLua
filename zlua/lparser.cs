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
    public enum ResultTypes
    {
        RegIndex,
        N,
        S,
        None, //没有返回值，比如语句
    }
    /// <summary>
    /// return type of `Visit* methods，递归时要获取结果，比如构建表达式；需要Reg
    /// 设计策略】通过ctor一次初始化，之后只读
    /// </summary>
    public struct Result
    {
        public int RegIndex { get; private set; }
        public double N { get; private set; }
        public string S { get; private set; }
        public ResultTypes ResultType { get; private set; }
        public Result(int regIndex)
        {
            this.RegIndex = regIndex;
            ResultType = ResultTypes.RegIndex;
            N = default(double);
            S = default(string);
        }
        public Result(double n)
        {
            this.N = n;
            ResultType = ResultTypes.N;
            RegIndex = default(int);
            S = default(string);
        }
        public Result(string s)
        {
            this.S = s;
            ResultType = ResultTypes.RegIndex;
            RegIndex = default(int);
            N = default(double);
        }
        /// <summary>
        /// 单例，表示没有返回值，比如语句
        /// </summary>
        public static readonly Result Void = new Result() { ResultType = ResultTypes.None };
    }

    public class LParser : LuaBaseVisitor<Result>
    {
        #region 辅助parse的数据结构和函数s
        /// <summary>
        /// 当前正在编译的函数块的编译期信息；编译时函数块s是一个同质的嵌套结构,这里用单链表实现一个栈
        /// </summary>
        public class FuncState
        {
            public Proto p = new Proto(); //当前proto
            /// <summary>
            /// first free register index
            /// </summary>
            public int freeRegIndex = 0;
            /// <summary>
            /// 指向第一个指令数组的第一个可用位置
            /// </summary>
            public int CurrPc { get => p.codes.Count; }
            public FuncState prev;
            /// <summary>
            /// 反向索引局部变量名的左值；重复声明直接覆盖，所以不用管
            /// </summary>
            public Dictionary<string, int> localName2RegIndex = new Dictionary<string, int>();
            public Dictionary<double, int> n2NsIndex = new Dictionary<double, int>();
            public Dictionary<string, int> s2StrsIndex = new Dictionary<string, int>();
            public FuncState()
            {

            }
        }
        #region 处理FS
        /// <summary>
        /// 进入新函数块
        /// </summary>
        void EnterNewFunc()
        {
            var new_fs = new FuncState();
            currFs.p.inner_funcs.Add(new_fs.p);
            currFs = new_fs;
        }
        /// <summary>
        /// 离开当前函数块
        /// </summary>
        void ExitCurrFunc()
        {
            Debug.Assert(currFs.prev != null, "");
            currFs = currFs.prev;
        }
        FuncState currFs = new FuncState(); //push chunk 
        public Proto CurrP { get => currFs.p; }
        #endregion
        #region  处理scope
        /// <summary>
        /// name通过scope映射到lvalue（龙书第二章重点），因此还要有反向索引表
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        int Name2RegIndex(string name)
        {
            if (currFs.localName2RegIndex.ContainsKey(name)) /*name is local*/
                return currFs.localName2RegIndex[name];
            else {
                /*name is not local to all functions from current function to the chunk, so it is global*/
                return name.GetHashCode(); //暂时这样。事实上先check uv再。
                /*name is upval?*/
                throw new NotImplementedException();//TODO
                var fs = currFs;
                while (fs != null) {
                    if (fs.localName2RegIndex.ContainsKey(name))
                        return fs.localName2RegIndex[name];
                    fs = fs.prev;
                }
            }
            
        }
        #endregion
        int nLabels = 0;
        public LParser()
        {

        }
        #endregion
        #region 自动生成的部分
        //public override Result VisitCmpExp([NotNull] LuaParser.CmpExpContext context)
        //{
        //    switch (context.operatorComparison.Type) {
        //        case LuaLexer.LtKW:
        //            Console.WriteLine("Lt " + (nTemps++) + Visit(context.exp(0)) + Visit(context.exp(1)));
        //            Console.WriteLine("Jmp " + "foo");
        //            break;
        //        case LuaLexer.MtKW:
        //            Console.WriteLine("Lt " + (nTemps++) + Visit(context.exp(1)) + Visit(context.exp(0)));
        //            Console.WriteLine("Jmp " + "foo");
        //            break;
        //        default:
        //            break;
        //    }
        //    return nTemps;
        //}

        //public override Result VisitIfelseStat([NotNull] LuaParser.IfelseStatContext context)
        //{
        //    Visit(context.exp());
        //    Visit(context.block());
        //    Console.WriteLine("L" + nLabels + ":");
        //    foreach (var item in context.elseifBlock()) {
        //        Visit(item);
        //        Console.WriteLine("L" + nLabels + ":");
        //    }
        //    Visit(context.elseBlock());
        //    Console.WriteLine("L" + nLabels + ":");
        //    return -1;
        //}

        public override Result VisitNumberExp([NotNull] LuaParser.NumberExpContext context)
        {
            double n = Double.Parse(context.GetText());
            currFs.n2NsIndex.Add(n, CurrP.ns.Count);
            CurrP.ns.Add(n);
            return new Result(n);
        }

        public override Result VisitUnmExp([NotNull] LuaParser.UnmExpContext context)
        {
            switch (context.operatorUnary.Type) {
                case LuaLexer.NotKW:
                    //Console.WriteLine("Not" + Visit(context.exp()));
                    break;
                default:
                    break;
            }
            return -1;
        }

        public override Result VisitLocalassignStat([NotNull] LuaParser.LocalassignStatContext context)
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
                CurrP.locvars.Add(lv);
            }
            nNames = namelist.Length;
            return -1;
        }
        public override Result VisitFunctiondef([NotNull] LuaParser.FunctiondefContext context)
        {
            EnterNewFunc();
            return -1;
        }
        public override Result VisitNilfalsetruevarargExp([NotNull] LuaParser.NilfalsetruevarargExpContext context)
        {
            switch (context.nilfalsetruevararg.Type) {
                case LuaLexer.NilKW:
                    break;
                case LuaLexer.FalseKW:
                    break;
                case LuaLexer.TrueKW:
                    break;
                case LuaLexer.VarargKW:
                    throw new NotImplementedException();
                    break;
            }
            Fs.freeRegIndex++;
            return -1;
        }
        public override Result VisitStringExp([NotNull] LuaParser.StringExpContext context)
        {
            CurrP.codes.Add(new Bytecode(Opcodes.LoadK, Fs.freeRegIndex, CurrP.k.Count));
            CurrP.k.Add((TValue)context.GetText().Trim(new char[] { '\'', '\"' })); //strip quotes on both sides
            return -1;
        }
        #endregion
    }
}
