using System;
using System.Collections;
using System.Collections.Generic;

using zlua.Compiler.CodeGenerator;
using zlua.Compiler.Lexer;

namespace zlua.Compiler.Parser
{
    #region 上下文类

    // 上下文基类
    //
    // * 对应antlr的RuleContext类
    // * 这里使用具体的LuaVisitor类，因为我确定我们只需要遍历一次ast，不需要其他visitor
    //   然而。还是要用luabasevisitor，因为必须提供默认的visitchildren实现，regex engine里没这么做
    //   导致必须手写，如果在luabasevisitor里则可以集中生成代码
    internal interface Context
    {
        void Accept(LuaBaseVisitor visitor);

        // 模板如下
        //{
        //    LuaVisitor luaVisitor = visitor as LuaVisitor;
        //    if (luaVisitor != null) {
        //        luaVisitor.VisitBlock(this);
        //    } else {
        //        visitor.VisitChildren(this);
        //    }
        //}
    }

    // antlr版本是有返回值的
    // 带来了复杂性
    // 似乎一整套必须统一返回类型为T
    // 《lua go book》使用void，因此我也用void
    //internal abstract class Context<T> : Context
    //{
    //    public T Accept(LuaBaseVisitor visitor)
    //    {
    //        LuaVisitor luaVisitor = visitor as LuaVisitor;
    //        if (luaVisitor != null) {
    //            return luaVisitor.VisitBlock(this);
    //        } else {
    //            return visitor.VisitChildren(this);
    //        }
    //    }
    //}

#pragma warning disable IDE1006 // Naming Styles

    // block ::= {stat} [retstat]
    internal class blockContext : Context
    {
        public int LastLine;
        public statContext[] StatStar;
        public retstatContext RetStatOptional;

        public void Accept(LuaBaseVisitor visitor)
        {
            LuaVisitor luaVisitor = visitor as LuaVisitor;
            if (luaVisitor != null) {
                luaVisitor.Visit_block(this);
            } else {
                visitor.VisitChildren(this);
            }
        }
    }

    /*
    stat ::=  ‘;’ |
         varlist ‘=’ explist |
         functioncall |
         label |
         break |
         goto Name |
         do block end |
         while exp do block end |
         repeat block until exp |
         if exp then block {elseif exp then block} [else block] end |
         for Name ‘=’ exp ‘,’ exp [‘,’ exp] do block end |
         for namelist in explist do block end |
         function funcname funcbody |
         local function Name funcbody |
         local namelist [‘=’ explist]
    */

    // 注意我使用了abstract
    // 如果是antlr，我会使用label语法为每种语句标记一个NT名字
    internal interface statContext : Context
    {
    }

    // retstat ::= return [explist] [‘;’]
    internal class retstatContext : statContext
    {
        public explistContext explistOptional;

        // 只有return一个词的空的返回语句
        public static retstatContext RetEmptyStat { get; } =
            new retstatContext { explistOptional = null };

        public void Accept(LuaBaseVisitor visitor)
        {
            LuaVisitor luaVisitor = visitor as LuaVisitor;
            if (luaVisitor != null) {
                //luaVisitor.Visit_retstat(this);
            } else {
                visitor.VisitChildren(this);
            }
        }
    }

    internal abstract class expContext
    {
    }

    // explist ::= exp {‘,’ exp}
    // 相当于exp+
    internal class explistContext : IEnumerable<expContext>
    {
        public expContext exp;
        public expContext[] expStar;

        // 辅助方法，把explist看做一整个数组迭代
        // 我保留了两种方法
        public IEnumerable<expContext> exps()
        {
            yield return exp;
            foreach (var item in expStar) {
                yield return item;
            }
        }

        public IEnumerator<expContext> GetEnumerator()
        {
            return exps().GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }

    // 只有分号的空语句
    //
    // -> ;
    // 解析时会被丢弃
    // antlr的label语法我们使用形如StatLabel的后缀
    internal class emptyStatLabelContext// : statContext
    {
        public static emptyStatLabelContext EmptyStat { get; } =
            new emptyStatLabelContext();

        public void Accept()
        {
        }
    }

    // -> break
    internal class breakStatLabelContext// : statContext
    {
        // 跳出控制块需要的行号
        public int Line;
    }

    // -> label
    // label -> :: Name ::
    //
    // 这里偷个懒折叠一下树的层次，无伤大雅
    internal class labelStatLabelContext //: statContext
    {
        // 标签名
        public string Name;
    }

    // -> goto Name
    internal class gotoStatLabelContext// : statContext
    {
        // 标签名
        public string Name;
    }

    // -> do block end
    internal class doStatLabelContext //: statContext
    {
        public blockContext block;
    }

    // stat -> funtioncall
    //
    // 作者难道不区别语句和表达式吗，反正我要区别
    internal class functioncallStatLabelContext //: statContext
    {
        public functioncallContext functioncall;
    }

    // functioncall -> prefixexp args | prefixexp ':' name args
    internal class functioncallContext
    {
        // line of '('
        public int Line;

        // line of ')'
        public int LastLine;

        public prefixexpContext prefixexp;

        // TODO 这里需要行号吗
        //public NameExp name;
        public string name;

        public argsContext args;
    }

    // args ::= ‘(’ [explist] ‘)’ # parenedExplistArgs
    //        | tableconstructor # tablectorArgs
    //        | LiteralString # literalstrArgs

    internal abstract class argsContext
    {
    }

    internal class parenedExplistArgsLabelContext : argsContext
    {
        public explistContext explistOptional;
    }

    internal class tablectorArgsLabelContext : argsContext
    {
        public tablecontructorExpContext tableconstructor;
    }

    internal class literalstrArgsLabelContext : argsContext
    {
        public string s;
    }

    // if exp then block {elseif exp then block} [else block] end
    internal class ifStatLabelContext/* : statContext*/
    {
        public expContext exp;
        public blockContext block;
        public expContext[] expStar;
        public blockContext[] blockStar;
        public blockContext blockOptional;
    }

    // while exp do block end
    internal class whileStatLabelContext /*: statContext*/
    {
        public expContext exp;
        public blockContext block;
    }

    // repeat block until exp
    internal class repeatStatLabelContext/* : statContext*/
    {
        public blockContext block;
        public expContext exp;
    }

    // for namelist in explist do block end
    // namelist ::= Name {‘,’ Name}
    // explist ::= exp {‘,’ exp}
    // 可以看到，这些都可以通过代码生成
    // 一些额外的信息比如行号需要自己指定
    // 这些单纯是plus的NT，我们通过变通的方法不破坏lua语法
    // 让他们继承一个叫Plus<T>的接口或类并实现返回T []的方法
    internal class forinStatLabelContext// : statContext
    {
        public int LineOfDo;
        public namelistContext namelist;
        public explistContext explist;
        public blockContext block;
    }

    // for Name ‘=’ exp ‘,’ exp [‘,’ exp] do block end
    internal class forNumStatLabelContext// : statContext
    {
        public int LineOfFor;
        public int LineOfDo;
        public string Name;
        public expContext exp0;
        public expContext exp1;
        public expContext exp2Optional;
        public blockContext block;
    }

    // varlist ‘=’ explist
    internal class assignStatLabelContext// : statContext
    {
        public int LastLine;
        public varlistContext varlist;
        public explistContext explist;
    }

    // varlist ::= var {‘,’ var}
    internal class varlistContext
    {
        public varContext var;
        public varContext[] varStar;
    }

    // var := prefixexp
    //
    // 我重写了语法，注意上面这个是有约束的，就是prefixexp不是functioncall
    // var只在assignStat使用，这是一个特殊处理的语法
    internal class varContext
    {
        public prefixexpContext prefixexp {
            get { return _prefixexp; }
            set {
                if (value is functioncallPrefixexpLabelContext) {
                    throw new Exception("syntax error");
                } else {
                    _prefixexp = value;
                }
            }
        }

        private prefixexpContext _prefixexp;
    }

    // local namelist [‘=’ explist]
    // namelist ::= Name {‘,’ Name}
    // explist ::= exp {‘,’ exp}
    internal class localVarDeclStatLabelContext //: /*statContext*/
    {
        public int LastLine;
        public namelistContext namelist;
        public explistContext explistOptional;
    }

    // local function Name funcbody
    internal class localFuncDefStatLabelContext //: /*statContext*/
    {
        public string Name;
        public funcbodyContext funcbody;
    }

    // namelist ::= Name {‘,’ Name}
    internal class namelistContext
    {
        public string Name;
        public string[] CommaNameStar;
    }

    // funcbody ::= ‘(’ [parlist] ‘)’ block end
    // parlist ::= namelist [‘,’ ‘...’] | ‘...’
    internal class funcbodyContext
    {
        public parlistContext parlistOptional;
        public blockContext block;
    }

    // parlist ::= namelist [‘,’ ‘...’] | ‘...’
    //
    // 每个分支都这样拆开，就很好，性能不要管
    internal abstract class parlistContext
    {
    }

    internal class namelistParlistLabelContext : parlistContext
    {
        public namelistContext namelist;
        public bool IsVararg;
    }

    internal class varargParlistLabelContext : parlistContext
    {
    }

    // prefixexp ::= functioncall # functioncallPrefixexp
    //            | prefixexp '.' Name # dotNamePrefixexp
    //            | prefixexp '[' exp ']' # bracketedExpPrefixexp
    //            | Name # namePrefixexp
    //            | '(' exp ')' # parenedExpPrefixexp
    internal abstract class prefixexpContext : expContext
    {
    }

    // prefixexp ::= prefixexp ‘.’ Name
    internal class doNamePrefixexpLabelContext : prefixexpContext
    {
        public prefixexpContext prefixexp;
        public string Name;
    }

    // prefixexp ::= prefixexp ‘[’ exp ‘]’
    internal class bracketedExpPrefixex : prefixexpContext
    {
        public prefixexpContext prefixexp;
        public expContext exp;
    }

    internal class functioncallPrefixexpLabelContext : prefixexpContext
    {
        public functioncallContext functioncall;
    }

    internal class namePrefixexpLabelContext : prefixexpContext
    {
        public int Line;
        public string Name;
    }

    // 作者这里提到
    // 但是我这里没问题
    // p312 16.4.6
    internal class parenedExpPrefixexpLabelContext : prefixexpContext
    {
        public expContext exp;
    }

    // function funcname funcbody
    // funcname ::= Name {‘.’ Name} [‘:’ Name]
    // funcbody ::= ‘(’ [parlist] ‘)’ block end
    // parlist ::= namelist [‘,’ ‘...’] | ‘...’
    // namelist ::= Name {‘,’ Name}
    internal class funcDefStatLabelContext /*: statContext*/
    {
        public funcnameContext funcname;
        public funcbodyContext funcbody;
    }

    // funcname ::= Name {‘.’ Name} [‘:’ Name]
    //
    // funcname只被用在funcDefStat中
    // 因为funcDefStat被翻译成assignStat
    // 所以funcname对应var
    internal class funcnameContext
    {
        public string Name;
        public string[] DotNameStar;
        public string ColonNameOptional;
    }

    // 特殊上下文，大写了
    internal class BinopExpContext : expContext
    {
        // line of op
        public int Line;

        public TokenKind OpKind;

        // 取名为lhs和rhs也挺好
        public expContext exp0;

        public expContext exp1;
    }

    internal class ConcatExpContext : expContext
    {
        public int Line;
        public expContext[] exps;
    }

    internal class UnopExpContext : expContext
    {
        public int Line;
        public TokenKind OpKind;
        public expContext exp;
    }

    internal abstract class LiteralExpContext : expContext
    {
        public int Line;
    }

    internal class VarargExpContext : LiteralExpContext
    {
    }

    internal class NilExpContext : LiteralExpContext
    {
    }

    internal class TrueExpContext : LiteralExpContext
    {
    }

    internal class FalseExpContext : LiteralExpContext
    {
    }

    internal class StringExpContext : LiteralExpContext
    {
    }

    internal class IntegerExpContext : LiteralExpContext
    {
        public Int64 i;
    }

    internal class FloatExpContext : LiteralExpContext
    {
        public double n;
    }

    // tableconstructor ::= ‘{’ [fieldlist] ‘}’
    internal class tablecontructorExpContext : expContext
    {
        // line of {
        public int Line;

        // line of }
        public int LastLine;

        public fieldlistContext fieldlistOptional;
    }

    internal class fieldlistContext
    {
        public fieldContext field;
        public fieldContext[] fieldsepFieldStar;
    }

    internal class fieldContext
    {
        public expContext key;
        public expContext val;
    }

    internal class functiondefExpContext : expContext
    {
        public funcbodyContext funcbody;
    }

#pragma warning restore IDE1006 // Naming Styles

    #endregion 上下文类
}