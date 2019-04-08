// 复习编译原理
//
// * LL要求并列规则的First集合不相交
// * LL要求无左递归和左公因子
// * LL的算法是前瞻一个T来选择分支，验证分支，选哪个分支已经在解析表中先写好了
// * 确实可以表驱动，但是我们把表手写成parse*函数

// 我简单复习了一下leptjson
// json语法简单，生成代码这个过程相当于解释执行生成了表达式值，生成是在解析中就完成的，一遍pass，没有中间数据结构
// 解析从简单到复杂，分别是关键字值（null，true，false），字符串值，数组和字典，只有最后两个是可以嵌套的
// json里唯一一步表驱动就是顶层的ParseValue，根据第一个字母就能判断具体是哪种类型

// S0 -> S $
//S0 parse(char* src)
//{
//ctx = new Context(src);
//ctx.skipws();
//S0 = ctx.parseS();
//testpeek(eof);
//// clear parser resource here
//return S0;
//}

//class Context
//{
//    S ParseS()
//    {
//        // 表驱动选择分支
//        // value -> literal
//        //        | string
//        //        | array
//        //        | object
//        //        | number
//        // default: error
//        switch (peek) {
//            case '':...;
//            case '':...;
//            default:...;
//                error;
//        }
//    }
//}

// 我们要完成的内容
// 把克林闭包转换成LL语法或者手写解析，提供直接的访问方式
// 因此克林闭包必须是封装普通的语法
// 作者做的太简单了，答案是正确的，但是自己写会混乱
// 解析方法使用Parse前缀，使用Optional，Star，Plus后缀
// Symbol类使用Context后缀

// 这里可以看到重复模式是怎么解析的
// while(lookahead not in Follow(Stat){
//   ParseStat();
// }
// ParseNTs对应NT*或者{NT}，plus的版本拆成NT NT*即可

// ParseSymbol则Symbol是不为空的
// 我决定打破命名规范
// 使用语法中的名字以保持一致性

// 可选对象用null表示没有
// 使用一些静态的对象表示一些空的上下文，比如空的返回语句，对于空对象，值是重要的，因此只需要一个就够了

// 你可能想TokenKind的枚举值太长太丑了，但是事实是兼容参考的代码是最重要的，具体的风格只是口味问题，不要华经理

using System;
using System.Collections.Generic;

using zlua.Compiler.Lexer;

namespace zlua.Compiler.Parser
{
    internal class LuaParser
    {
        // 取名无所谓，主要是TS有一个智能提示TimeSpan老是在前面搞得我烦
        // 这个名字取自antlr的api
        private TokenStream TokenStream { get; }

        public LuaParser(TokenStream tokenStream)
        {
            TokenStream = tokenStream;
        }

        // 顶层解析方法
        // chunk -> block $
        public blockContext ParseChunk()
        {
            var block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_EOF);
            return block;
        }

        #region 私有方法

        #region 包装TokenStream的辅助方法

        private Token AssertAndRead(TokenKind kind)
        {
            if (TokenStream.LookAhead(1).Kind == kind) {
                return TokenStream.NextToken();
            } else {
                throw new Exception("sytax error");
            }
        }

        private bool TestAndRead(TokenKind kind)
        {
            if (TokenStream.LookAhead().Kind == kind) {
                TokenStream.NextToken();
                return true;
            } else {
                return false;
            }
        }

        private bool TestPeek(TokenKind kind)
        {
            return TokenStream.LookAhead().Kind == kind;
        }

        private bool TestPeekIn(TokenKind flagSet)
        {
            return TokenStream.LookAhead().Kind.IsFlagIn(flagSet);
        }

        private bool TestPeekNotIn(TokenKind flagSet)
        {
            return TokenStream.LookAhead().Kind.IsFlagNotIn(flagSet);
        }

        // 验证下一Token是标识符并返回标识符的名字
        private string NextIdentifier()
        {
            return AssertAndRead(TokenKind.TOKEN_IDENTIFIER).Lexeme;
        }

        private Token NextToken()
        {
            return TokenStream.NextToken();
        }

        private Token LookAhead(int i = 1)
        {
            return TokenStream.LookAhead(i);
        }

        private int Line()
        {
            return TokenStream.Line;
        }

        #endregion 包装TokenStream的辅助方法

        // block ::= {stat} [retstat]
        private blockContext Parse_block()
        {
            return new blockContext
            {
                StatStar = Parse_statStar(),
                RetStatOptional = Parse_retstatOptional(),
                LastLine = TokenStream.Line
            };
        }

        private statContext[] Parse_statStar()
        {
            var stats = new List<statContext>();
            while (TestPeekNotIn(
                   TokenKind.TOKEN_KW_RETURN | TokenKind.TOKEN_EOF |
                   TokenKind.TOKEN_KW_END | TokenKind.TOKEN_KW_ELSE |
                   TokenKind.TOKEN_KW_ELSEIF | TokenKind.TOKEN_KW_UNTIL)) {
                var stat = Parse_stat();
                //if(stat is not empty stat) 忽略空语句
                stats.Add(stat);
            }
            return stats.ToArray();
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

        private statContext Parse_stat()
        {
            switch (TokenStream.LookAhead().Kind) {
                case TokenKind.TOKEN_SEP_SEMI: return Parse_emptyStat();
                case TokenKind.TOKEN_KW_BREAK: return Parse_breakStat();
                case TokenKind.TOKEN_SEP_LABEL: return Parse_labelStat();
                case TokenKind.TOKEN_KW_GOTO: return Parse_gotoStat();
                case TokenKind.TOKEN_KW_DO: return Parse_doStat();
                case TokenKind.TOKEN_KW_WHILE: return Parse_whileStat();
                case TokenKind.TOKEN_KW_REPEAT: return Parse_repeatStat();
                case TokenKind.TOKEN_KW_IF: return Parse_ifStat();
                case TokenKind.TOKEN_KW_FOR: return Parse_forStat();
                case TokenKind.TOKEN_KW_FUNCTION: return Parse_funcDefStat();
                case TokenKind.TOKEN_KW_LOCAL: {
                        // 作者是下面这样写的
                        // 和for是一样的，这里我换种写法，把这层折叠掉
                        //return ParseLocalAssignOrFuncDefStat();
                        if (TokenStream.LookAhead(2).Kind == TokenKind.TOKEN_KW_FUNCTION) {
                            return Parse_localFuncDefStat();
                        } else {
                            return Parse_localVarDeclStat();
                        }
                    }
                default:
                    // flagsin需要在default里重新用ifelse来判断
                    //
                    // prefixexp的First集合是Name和左括号
                    if (LookAhead().Kind.IsFlagIn(TokenKind.TOKEN_IDENTIFIER | TokenKind.TOKEN_SEP_LPAREN)) {
                        // * 这里的策略很特殊
                        //   functioncall和assignStat无法通过前瞻决议
                        //   而且functioncall可能是assignStat的前缀
                        //   但是一个特征是你先尝试解析出functioncall
                        //   如果解析出来了就一定是functioncall语句，因为函数调用一定不是左值
                        var prefixexp = Parse_prefixexp();
                        if (prefixexp is functioncallPrefixexpLabelContext) {
                            return new functioncallStatLabelContext
                            {
                                functioncall = (prefixexp as functioncallPrefixexpLabelContext).functioncall
                            };
                        } else {
                            return Parse_assignStatLabelContext(prefixexp);
                        }
                    } else {
                        throw new Exception("sytax error");
                    }
            }
        }

        private retstatContext Parse_retstatOptional()
        {
            // 编译原理】可选符号，peek如果不是first，则返回null
            if (!TestPeek(TokenKind.TOKEN_KW_RETURN)) {
                return null;
            }
            return Parse_retstat();
        }

        // retstat ::= return [explist] [‘;’]
        private retstatContext Parse_retstat()
        {
            // 消耗return
            TokenStream.NextToken();
            switch (TokenStream.LookAhead().Kind) {
                // 从右往左，如果有分号则跳过
                case TokenKind.TOKEN_SEP_SEMI:
                    TokenStream.NextToken();
                    return retstatContext.RetEmptyStat;

                default:
                    // 编译原理】一串可选项，如果peek是follow，可选项为空
                    // 这里是从右往左的，出现分号右侧才会出现的NT说明explist和分号都没有
                    // 然后explist和分号至少有一个
                    // 如果是分号则一定只有分号
                    // 否则一定有explist，分号可能有
                    if (TestPeekIn(TokenKind.TOKEN_EOF | TokenKind.TOKEN_KW_END |
                    TokenKind.TOKEN_KW_ELSEIF | TokenKind.TOKEN_KW_ELSEIF |
                    TokenKind.TOKEN_KW_UNTIL)) {
                        return retstatContext.RetEmptyStat;
                    } else {
                        var explist = Parse_explist();
                        TestAndRead(TokenKind.TOKEN_SEP_SEMI);
                        return new retstatContext { explistOptional = explist };
                    }
            }
        }

        // explist ::= exp {‘,’ exp}
        //
        // 这里其实就是plus，但是它不这样写
        // 其实我们在访问ast时要的是列表
        // 不过为了简单性，我们暂时不考虑这点，先做，有问题，或者说写完觉得不好，到时候再改
        private explistContext Parse_explist()
        {
            var exp = Parse_exp();
            var exps = new List<expContext>();
            while (TestPeek(TokenKind.TOKEN_SEP_COMMA)) {
                TokenStream.NextToken();
                exps.Add(Parse_exp());
            }
            return new explistContext
            {
                exp = exp,
                expStar = exps.ToArray()
            };
        }

        // Parse_*用下划线分开，因为NT小写开头还是难以阅读的
        private emptyStatLabelContext Parse_emptyStat()
        {
            AssertAndRead(TokenKind.TOKEN_SEP_SEMI);
            return emptyStatLabelContext.EmptyStat;
        }

        private breakStatLabelContext Parse_breakStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_BREAK);
            return new breakStatLabelContext { Line = TokenStream.Line };
        }

        private labelStatLabelContext Parse_labelStat()
        {
            AssertAndRead(TokenKind.TOKEN_SEP_LABEL);
            var id = AssertAndRead(TokenKind.TOKEN_IDENTIFIER);
            AssertAndRead(TokenKind.TOKEN_SEP_LABEL);
            return new labelStatLabelContext { Name = id.Lexeme };
        }

        private gotoStatLabelContext Parse_gotoStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_GOTO);
            var id = AssertAndRead(TokenKind.TOKEN_IDENTIFIER);
            return new gotoStatLabelContext { Name = id.Lexeme };
        }

        private doStatLabelContext Parse_doStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_DO);
            var block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_END);
            return new doStatLabelContext { block = block };
        }

        private whileStatLabelContext Parse_whileStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_WHILE);
            var exp = Parse_exp();
            AssertAndRead(TokenKind.TOKEN_KW_DO);
            var block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_END);
            return new whileStatLabelContext { exp = exp, block = block };
        }

        private repeatStatLabelContext Parse_repeatStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_REPEAT);
            var block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_UNTIL);
            var exp = Parse_exp();
            return new repeatStatLabelContext { block = block, exp = exp };
        }

        // if exp then block {elseif exp then block} [else block] end
        private ifStatLabelContext Parse_ifStat()
        {
            AssertAndRead(TokenKind.TOKEN_KW_IF);
            var exp = Parse_exp();
            AssertAndRead(TokenKind.TOKEN_KW_THEN);
            var block = Parse_block();

            var expStar = new List<expContext>();
            var blockStar = new List<blockContext>();
            while (TestPeek(TokenKind.TOKEN_KW_ELSEIF)) {
                TokenStream.NextToken();
                expStar.Add(Parse_exp());
                AssertAndRead(TokenKind.TOKEN_KW_THEN);
                blockStar.Add(Parse_block());
            }

            // 作者的写法是把else块看做条件为真的elseif块，以此便于代码生成，可以考虑一下
            blockContext blockOptional = null;
            if (TestAndRead(TokenKind.TOKEN_KW_ELSE)) {
                blockOptional = Parse_block();
            }
            return new ifStatLabelContext
            {
                exp = exp,
                block = block,
                expStar = expStar.ToArray(),
                blockStar = blockStar.ToArray(),
                blockOptional = blockOptional
            };
        }

        // for Name ‘=’ exp ‘,’ exp [‘,’ exp] do block end
        // for namelist in explist do block end
        //
        // 这里是因为两种for需要前瞻到等号
        // 作者只是用前瞻一格，而我有前瞻任意格，避免向下面注释掉的代码一样传参
        // 这里懒得，也没必要定义一格中间类型forstatcontext
        private statContext Parse_forStat()
        {
            //var t=AssertAndRead(TokenKind.TOKEN_KW_FOR);
            //int lineOfFor = t.Line;
            //var id = AssertAndRead(TokenKind.TOKEN_IDENTIFIER);
            //if (TestPeek(TokenKind.TOKEN_OP_ASSIGN)) {
            //    return finishForNumStat(lineOfFor)
            //}
            if (TokenStream.LookAhead(3).Kind ==
                 TokenKind.TOKEN_OP_ASSIGN) {
                return Parse_forNumStat();
            } else {
                return Parse_forInStat();
            }
        }

        // for Name ‘=’ exp ‘,’ exp [‘,’ exp] do block end
        private forNumStatLabelContext Parse_forNumStat()
        {
            int LineOfFor;
            int LineOfDo;
            string Name;
            expContext exp0;
            expContext exp1;
            // 嗯，虽然默认值是1，作者在这里设置默认值其实
            // 不太好，这是代码生成时做的
            expContext exp2Optional = null;
            blockContext block;

            var t = AssertAndRead(TokenKind.TOKEN_KW_FOR);
            LineOfFor = t.Line;
            var id = AssertAndRead(TokenKind.TOKEN_IDENTIFIER);
            Name = id.Lexeme;
            AssertAndRead(TokenKind.TOKEN_OP_ASSIGN);
            exp0 = Parse_exp();
            AssertAndRead(TokenKind.TOKEN_SEP_COMMA);
            exp1 = Parse_exp();
            if (TestAndRead(TokenKind.TOKEN_SEP_COMMA)) {
                exp2Optional = Parse_exp();
            }
            LineOfDo = AssertAndRead(TokenKind.TOKEN_KW_DO).Line;
            block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_END);
            return new forNumStatLabelContext
            {
                LineOfFor = LineOfFor,
                LineOfDo = LineOfDo,
                exp0 = exp0,
                exp1 = exp1,
                exp2Optional = exp2Optional,
                block = block
            };
        }

        // for namelist in explist do block end
        private forinStatLabelContext Parse_forInStat()
        {
            int LineOfDo;
            namelistContext namelist;
            explistContext explist;
            blockContext block;
            namelist = Parse_namelist();
            AssertAndRead(TokenKind.TOKEN_KW_IN);
            explist = Parse_explist();
            LineOfDo = AssertAndRead(TokenKind.TOKEN_KW_DO).Line;
            block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_END);
            return new forinStatLabelContext
            {
                LineOfDo = LineOfDo,
                namelist = namelist,
                explist = explist,
                block = block,
            };
        }

        // namelist ::= Name {‘,’ Name}
        private namelistContext Parse_namelist()
        {
            string Name;
            List<string> NameStar = new List<string>();
            Name = AssertAndRead(TokenKind.TOKEN_IDENTIFIER).Lexeme;
            while (TestPeek(TokenKind.TOKEN_SEP_COMMA)) {
                TokenStream.NextToken();
                // TODO 重构为NextId
                var id = AssertAndRead(TokenKind.TOKEN_IDENTIFIER);
                NameStar.Add(id.Lexeme);
            }
            return new namelistContext
            {
                Name = Name,
                CommaNameStar = NameStar.ToArray()
            };
        }

        /*
        http://www.lua.org/manual/5.3/manual.html#3.4.11

        function f() end          =>  f = function() end
        function t.a.b.c.f() end  =>  t.a.b.c.f = function() end
        function t.a.b.c:f() end  =>  t.a.b.c.f = function(self) end
        local function f() end    =>  local f; f = function() end

        The statement `local function f () body end`
        translates to `local f; f = function () body end`
        not to `local f = function () body end`
        (This only makes a difference when the body of the function
         contains references to f.)
        */

        // local function Name funcbody
        private localFuncDefStatLabelContext Parse_localFuncDefStat()
        {
            string Name;
            funcbodyContext funcbody;

            AssertAndRead(TokenKind.TOKEN_KW_LOCAL);
            Name = NextIdentifier();
            AssertAndRead(TokenKind.TOKEN_KW_FUNCTION);
            // 这里作者没写好
            funcbody = Parse_funcbody();
            return new localFuncDefStatLabelContext
            {
                Name = Name,
                funcbody = funcbody
            };
        }

        // local namelist [‘=’ explist]
        private localVarDeclStatLabelContext Parse_localVarDeclStat()
        {
            int LastLine;
            namelistContext namelist;
            explistContext explistOptional = null;

            AssertAndRead(TokenKind.TOKEN_KW_LOCAL);
            namelist = Parse_namelist();
            if (TestAndRead(TokenKind.TOKEN_OP_ASSIGN)) {
                explistOptional = Parse_explist();
            }
            LastLine = Line();
            return new localVarDeclStatLabelContext
            {
                LastLine = LastLine,
                namelist = namelist,
                explistOptional = explistOptional
            };
        }

        // exp ::=  nil | false | true | Numeral | LiteralString | ‘...’ | functiondef |
        //      prefixexp | tableconstructor | exp binop exp | unop exp
        //
        // exp   ::= exp12
        // exp12 ::= exp11 {or exp11}
        // exp11 ::= exp10 {and exp10}
        // exp10 ::= exp9 {(‘<’ | ‘>’ | ‘<=’ | ‘>=’ | ‘~=’ | ‘==’) exp9}
        // exp9  ::= exp8 {‘|’ exp8}
        // exp8  ::= exp7 {‘~’ exp7}
        // exp7  ::= exp6 {‘&’ exp6}
        // exp6  ::= exp5 {(‘<<’ | ‘>>’) exp5}
        // exp5  ::= exp4 {‘..’ exp4}
        // exp4  ::= exp3 {(‘+’ | ‘-’ | ‘*’ | ‘/’ | ‘//’ | ‘%’) exp3}
        // exp2  ::= {(‘not’ | ‘#’ | ‘-’ | ‘~’)} exp1
        // exp1  ::= exp0 {‘^’ exp2}
        // exp0  ::= nil | false | true | Numeral | LiteralString
        //         | ‘...’ | functiondef | prefixexp | tableconstructor
        private expContext Parse_exp()
        {
            return Parse_exp12();
        }

        // exp11 {or exp11}
        //
        // 典型的左结合运算符，大部分运算符都是这样的
        private expContext Parse_exp12()
        {
            var exp = Parse_exp11();
            while (TestPeek(TokenKind.TOKEN_OP_OR)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp11()
                };
            }
            return exp;
        }

        // and
        private expContext Parse_exp11()
        {
            expContext exp = Parse_exp10();
            while (TestPeek(TokenKind.TOKEN_OP_AND)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp10()
                };
            }
            return exp;
        }

        // compare
        private expContext Parse_exp10()
        {
            expContext exp = Parse_exp9();
            while (TestPeekIn(
                TokenKind.TOKEN_OP_LT | TokenKind.TOKEN_OP_GT |
                TokenKind.TOKEN_OP_NE | TokenKind.TOKEN_OP_LE |
                TokenKind.TOKEN_OP_GE | TokenKind.TOKEN_OP_EQ)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp9()
                };
            }
            return exp;
        }

        // |
        private expContext Parse_exp9()
        {
            expContext exp = Parse_exp8();
            while (TestPeek(TokenKind.TOKEN_OP_BOR)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp8()
                };
            }
            return exp;
        }

        // ~
        private expContext Parse_exp8()
        {
            expContext exp = Parse_exp7();
            while (TestPeek(TokenKind.TOKEN_OP_BXOR)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp7()
                };
            }
            return exp;
        }

        // &
        private expContext Parse_exp7()
        {
            expContext exp = Parse_exp6();
            while (TestPeek(TokenKind.TOKEN_OP_BAND)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp6()
                };
            }
            return exp;
        }

        // shift
        private expContext Parse_exp6()
        {
            expContext exp = Parse_exp5();
            while (TestPeekIn(TokenKind.TOKEN_OP_SHL | TokenKind.TOKEN_OP_SHR)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp5()
                };
            }
            return exp;
        }

        // ..
        //
        // 注意是唯二右结合的op之一
        // TODO 也没管。。我对这个主题不太在意。。。
        private expContext Parse_exp5()
        {
            expContext exp = Parse_exp4();
            if (!TestPeek(TokenKind.TOKEN_OP_CONCAT)) {
                return exp;
            }

            int line = 0;
            List<expContext> exps = new List<expContext>();
            while (TestPeek(TokenKind.TOKEN_OP_CONCAT)) {
                var t = NextToken();
                line = t.Line;
                exps.Add(Parse_exp4());
            }
            return new ConcatExpContext
            {
                Line = line,
                exps = exps.ToArray()
            };
        }

        // +-
        private expContext Parse_exp4()
        {
            expContext exp = Parse_exp3();
            while (TestPeekIn(TokenKind.TOKEN_OP_ADD | TokenKind.TOKEN_OP_SUB)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp3()
                };
            }
            return exp;
        }

        // *, %, /, //
        private expContext Parse_exp3()
        {
            expContext exp = Parse_exp2();
            while (TestPeekIn(
                TokenKind.TOKEN_OP_MUL | TokenKind.TOKEN_OP_MOD |
                TokenKind.TOKEN_OP_DIV | TokenKind.TOKEN_OP_IDIV)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp2()
                };
            }
            return exp;
        }

        // unary
        //
        // 也是特殊的
        private expContext Parse_exp2()
        {
            if (TestPeekIn(
                TokenKind.TOKEN_OP_UNM | TokenKind.TOKEN_OP_BNOT |
                TokenKind.TOKEN_OP_LEN | TokenKind.TOKEN_OP_NOT)) {
                var t = NextToken();
                return new UnopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp = Parse_exp2()
                };
            } else {
                return Parse_exp1();
            }
        }

        // ^
        //
        // 右结合
        private expContext Parse_exp1()
        {
            expContext exp = Parse_exp0();
            if (TestPeek(TokenKind.TOKEN_OP_POW)) {
                var t = NextToken();
                exp = new BinopExpContext
                {
                    Line = t.Line,
                    OpKind = t.Kind,
                    exp0 = exp,
                    exp1 = Parse_exp2()
                };
            }
            return exp;
        }

        private expContext Parse_exp0()
        {
            switch (LookAhead().Kind) {
                case TokenKind.TOKEN_VARARG:
                    return new VarargExpContext { Line = NextToken().Line };

                case TokenKind.TOKEN_KW_NIL:
                    return new NilExpContext { Line = NextToken().Line };

                case TokenKind.TOKEN_KW_TRUE:
                    return new TrueExpContext { Line = NextToken().Line };

                case TokenKind.TOKEN_KW_FALSE:
                    return new FalseExpContext { Line = NextToken().Line };

                case TokenKind.TOKEN_STRING:
                    return new StringExpContext { Line = NextToken().Line };

                case TokenKind.TOKEN_NUMBER: {
                        // parse number
                        var t = NextToken();
                        // 优先判断为整数
                        long outL;
                        if (Int64.TryParse(t.Lexeme, out outL)) {
                            return new IntegerExpContext
                            {
                                Line = t.Line,
                                i = outL
                            };
                        }
                        // 数字的格式在lexer经过验证，因此一定是合法的
                        // 没必要抛出错误
                        else {
                            return new FloatExpContext
                            {
                                Line = t.Line,
                                n = Double.Parse(t.Lexeme)
                            };
                        }
                    }
                case TokenKind.TOKEN_SEP_LCURLY:
                    return Parse_tableconstructorExp();

                case TokenKind.TOKEN_KW_FUNCTION:
                    NextToken();
                    return new functiondefExpContext
                    {
                        funcbody = Parse_funcbody()
                    };

                default:
                    // ???default不错误么
                    return Parse_prefixexp();
            }
        }

        private tablecontructorExpContext Parse_tableconstructorExp()
        {
            int line = Line();
            fieldlistContext fieldlistOptional = null;
            int lastline;

            TestAndRead(TokenKind.TOKEN_SEP_LCURLY);
            // 如果不是右括号
            if (!TestPeek(TokenKind.TOKEN_SEP_RCURLY)) {
                fieldlistOptional = Parse_fieldlist();
            }
            TestAndRead(TokenKind.TOKEN_SEP_RCURLY);
            lastline = Line();
            return new tablecontructorExpContext
            {
                Line = line,
                LastLine = lastline,
                fieldlistOptional = fieldlistOptional
            };
        }

        // fieldlist ::= field {fieldsep field} [fieldsep]
        private fieldlistContext Parse_fieldlist()
        {
            fieldContext field = Parse_field();
            List<fieldContext> fieldsepFieldStar = new List<fieldContext>();

            // 这里连着两个可选，从右到左
            // Follow集合是}，换句话说，右括号意味着fieldlist结束
            while (!TestPeek(TokenKind.TOKEN_SEP_RCURLY)) {
                // 如果前瞻不是右括号，则{fieldsep field} [fieldsep]至少有一个
                // 因为两个都是fieldsep开头
                if (TestPeekNotIn(
                    TokenKind.TOKEN_SEP_COMMA | TokenKind.TOKEN_SEP_SEMI)) {
                    throw new Exception("syntax error");
                } else {
                    NextToken();
                }
                // 消耗掉sep后 {fieldsep field} [fieldsep]
                // 应该是field或右括号
                // 如果是右括号就结束了
                if (TestPeek(TokenKind.TOKEN_SEP_RCURLY)) {
                    break;
                } else {
                    fieldsepFieldStar.Add(Parse_field());
                }
            }
            return new fieldlistContext
            {
                field = field,
                fieldsepFieldStar = fieldsepFieldStar.ToArray()
            };
        }

        // field ::= ‘[’ exp ‘]’ ‘=’ exp | Name ‘=’ exp | exp
        private fieldContext Parse_field()
        {
            expContext key;
            expContext val;

            if (TestAndRead(TokenKind.TOKEN_SEP_LBRACK)) {
                key = Parse_exp();
                AssertAndRead(TokenKind.TOKEN_SEP_RBRACK);
                AssertAndRead(TokenKind.TOKEN_OP_ASSIGN);
                val = Parse_exp();
                return new fieldContext
                {
                    key = key,
                    val = val
                };
            } else {
                var exp = Parse_exp();
                if (/*TODO exp is nameexp &&*/TestAndRead(TokenKind.TOKEN_OP_ASSIGN)) {
                    key = exp; //TODO 作者这里吧nameexp转换成stringexp
                    val = Parse_exp();
                    return new fieldContext
                    {
                        key = key,
                        val = val
                    };
                } else {
                    // 因为数组和字典混合，数组字面量的key设为null
                    return new fieldContext
                    {
                        key = null,
                        val = exp
                    };
                }
            }
        }

        // function funcname funcbody
        // funcname ::= Name {‘.’ Name} [‘:’ Name]
        // funcbody ::= ‘(’ [parlist] ‘)’ block end
        // parlist ::= namelist [‘,’ ‘...’] | ‘...’
        // namelist ::= Name {‘,’ Name}
        //
        // 作者这里把函数定义语句翻译成赋值语句
        // 我认为是可能是错的
        // 全局函数定义语句是特殊的，因为它能定义方法
        // 所以function obj:m() ... end的obj:m不能作为var
        // 你看一下我们定义的语法就知道了，var和prefixexp
        private funcDefStatLabelContext Parse_funcDefStat()
        {
            funcnameContext funcname;
            funcbodyContext funcbody;

            AssertAndRead(TokenKind.TOKEN_KW_FUNCTION);
            funcname = Parse_funcname();
            funcbody = Parse_funcbody();
            bool hasColonName = funcname.ColonNameOptional != null;
            if (hasColonName) {
                // 这里容易错
                // 我们要向parlist的最左端插入self这个名字
                // 事实上我们不得不检查三种情况
                // f()：parlist是空的
                // f(a)：parlist不是空的
                // f(...)：是vararg
                // 最后我们总是新构造一个namelistParlistLabel
                parlistContext parlist;
                if (funcbody.parlistOptional == null) {
                    parlist = new namelistParlistLabelContext
                    {
                        namelist = new namelistContext
                        {
                            Name = "self",
                            // star的零元我总是构造空数组
                            CommaNameStar = new string[0]
                        }
                    };
                } else {
                    if (funcbody.parlistOptional is namelistParlistLabelContext) {
                        // 构造新的namelist
                        // 把Name设为self
                        // 把旧的Name作为新namestar的第一个元素，然后把旧的namestar元素复制到新的namestar
                        namelistContext namelist;
                        var a = funcbody.parlistOptional as namelistParlistLabelContext;
                        var namestar = new List<string>() { a.namelist.Name };
                        for (int i = 0; i < a.namelist.CommaNameStar.Length; i++) {
                            namestar.Add(a.namelist.CommaNameStar[i]);
                        }
                        namelist = new namelistContext
                        {
                            Name = "self",
                            CommaNameStar = namestar.ToArray()
                        };
                        a.namelist = namelist;
                        parlist = funcbody.parlistOptional;
                    }
                    // vararg
                    else {
                        parlist = new namelistParlistLabelContext
                        {
                            namelist = new namelistContext
                            {
                                Name = "self",
                                CommaNameStar = new string[0]
                            },
                            IsVararg = true
                        };
                    }
                    funcbody.parlistOptional = parlist;
                }
            }
            return new funcDefStatLabelContext
            {
                funcname = funcname,
                funcbody = funcbody
            };
        }

        // funcname ::= Name {‘.’ Name} [‘:’ Name]
        private funcnameContext Parse_funcname()
        {
            string Name;
            List<string> DotNameStar = new List<string>();
            string ColonNameOptional = null;

            Name = NextIdentifier();
            while (TestAndRead(TokenKind.TOKEN_SEP_DOT)) {
                DotNameStar.Add(NextIdentifier());
            }
            if (TestAndRead(TokenKind.TOKEN_SEP_COLON)) {
                ColonNameOptional = NextIdentifier();
            }
            return new funcnameContext
            {
                Name = Name,
                DotNameStar = DotNameStar.ToArray(),
                ColonNameOptional = ColonNameOptional
            };
        }

        // funcbody ::= ‘(’ [parlist] ‘)’ block end
        private funcbodyContext Parse_funcbody()
        {
            parlistContext parlistOptional = null;
            blockContext block;

            AssertAndRead(TokenKind.TOKEN_SEP_LPAREN);
            // parlist的First集合是'...'和Name
            // parlist ::= namelist [‘,’ ‘...’] | ‘...’
            if (TestPeekIn(TokenKind.TOKEN_VARARG | TokenKind.TOKEN_IDENTIFIER)) {
                parlistOptional = Parse_parlist();
            }
            AssertAndRead(TokenKind.TOKEN_SEP_RPAREN);
            block = Parse_block();
            AssertAndRead(TokenKind.TOKEN_KW_END);
            return new funcbodyContext
            {
                parlistOptional = parlistOptional,
                block = block
            };
        }

        // parlist ::= namelist [‘,’ ‘...’] | ‘...’
        private parlistContext Parse_parlist()
        {
            switch (LookAhead().Kind) {
                case TokenKind.TOKEN_IDENTIFIER:
                    bool IsVararg = false;
                    if (TestAndRead(TokenKind.TOKEN_SEP_COMMA)) {
                        AssertAndRead(TokenKind.TOKEN_VARARG);
                        IsVararg = true;
                    }

                    return new namelistParlistLabelContext
                    {
                        namelist = Parse_namelist(),
                        IsVararg = IsVararg
                    };

                case TokenKind.TOKEN_VARARG:
                    return new varargParlistLabelContext();

                default:
                    throw new Exception("syntax error");
            }
        }

        // varlist := explist
        //
        // 这里是特殊处理，不得不把第一个var传入
        private assignStatLabelContext Parse_assignStatLabelContext(prefixexpContext prefixexp)
        {
            int LastLine;
            varlistContext varlist;
            explistContext explist;
            varContext var = new varContext { prefixexp = prefixexp };
            var varStar = Parse_varStar();
            varlist = new varlistContext { var = var, varStar = varStar };
            explist = Parse_explist();
            LastLine = Line();
            return new assignStatLabelContext
            {
                LastLine = LastLine,
                varlist = varlist,
                explist = explist
            };
        }

        // {‘,’ var}
        private varContext[] Parse_varStar()
        {
            List<varContext> vars = new List<varContext>();
            while (TestAndRead(TokenKind.TOKEN_SEP_COMMA)) {
                var var = new varContext { prefixexp = Parse_prefixexp() };
                vars.Add(var);
            }
            return vars.ToArray();
        }

        // 原来的语法如下：
        // prefixexp ::= var | functioncall | ‘(’ exp ‘)’
        // var ::=  Name | prefixexp ‘[’ exp ‘]’ | prefixexp ‘.’ Name
        // functioncall ::=  prefixexp args | prefixexp ‘:’ Name args
        //
        // 多次推导完全展开成非终结符序列如下：
        // prefixexp ::= (Name | ‘(’ exp ‘)’) (‘[’ exp ‘]’ | ‘.’ Name | [‘:’ Name] args)*
        // 所以我定义varSuffix -> ‘[’ exp ‘]’ | ‘.’ Name | [‘:’ Name] args
        //
        // 最终修改后的语法如下：
        // prefixexp ::= functioncall # functioncallPrefixexp
        //            | prefixexp '.' Name # dotNamePrefixexp
        //            | prefixexp '[' exp ']' # bracketedExpPrefixexp
        //            | Name # NamePrefixexp
        //            | '(' exp ')' # parenedExpPrefixexp
        private prefixexpContext Parse_prefixexp()
        {
            // 下面的处理是特殊的
            // 分为前后两部分
            // 前半部分(Name | ‘(’ exp ‘)’)是必须的
            // 然后再代入贪婪地解析成更长的prefixexp，直到前瞻不在First集合内
            prefixexpContext prefixexp;
            switch (LookAhead().Kind) {
                case TokenKind.TOKEN_IDENTIFIER:
                    string Name;
                    int line;

                    Name = NextIdentifier();
                    line = Line();
                    prefixexp = new namePrefixexpLabelContext
                    {
                        Line = line,
                        Name = Name
                    };
                    break;

                case TokenKind.TOKEN_SEP_LPAREN:
                    expContext exp;
                    NextToken();
                    exp = Parse_exp();
                    AssertAndRead(TokenKind.TOKEN_SEP_RPAREN);
                    prefixexp = new bracketedExpPrefixex
                    {
                        exp = exp
                    };
                    break;

                default:
                    throw new Exception();
            }

            while (true) {
                switch (LookAhead().Kind) {
                    // '[' exp ']'
                    case TokenKind.TOKEN_SEP_LBRACK: {
                            expContext exp;
                            NextToken();
                            exp = Parse_exp();
                            AssertAndRead(TokenKind.TOKEN_SEP_RBRACK);
                            prefixexp = new bracketedExpPrefixex
                            {
                                prefixexp = prefixexp,
                                exp = exp
                            };
                            break;
                        }
                    // '.' Name
                    case TokenKind.TOKEN_SEP_DOT: {
                            string Name;

                            NextToken();
                            Name = NextIdentifier();
                            prefixexp = new doNamePrefixexpLabelContext
                            {
                                prefixexp = prefixexp,
                                Name = Name
                            };
                            break;
                        }
                    default: {
                            // [':' Name] args
                            // 下面是First集合
                            if (TestPeekIn(TokenKind.TOKEN_SEP_COLON | TokenKind.TOKEN_SEP_LPAREN |
                             TokenKind.TOKEN_SEP_LCURLY | TokenKind.TOKEN_STRING)) {
                                // line of '('
                                int line;
                                // line of ')'
                                int LastLine;
                                string name = null;
                                argsContext args;

                                if (TestAndRead(TokenKind.TOKEN_SEP_COLON)) {
                                    name = NextIdentifier();
                                }
                                line = Line();
                                args = Parse_args();
                                LastLine = Line();

                                // 函数调用并不需要添加self，运行时会把name作为第一个参数
                                prefixexp = new functioncallPrefixexpLabelContext
                                {
                                    functioncall = new functioncallContext
                                    {
                                        Line = line,
                                        LastLine = LastLine,
                                        name = name,
                                        prefixexp = prefixexp,
                                        args = args
                                    }
                                };
                                break;
                            } else {
                                return prefixexp;
                            }
                        }
                }
            }
        }

        // args ::=  ‘(’ [explist] ‘)’ | tableconstructor | LiteralString
        private argsContext Parse_args()
        {
            switch (LookAhead().Kind) {
                case TokenKind.TOKEN_SEP_LPAREN:
                    explistContext explistOptional = null;

                    NextToken();
                    // 如果前瞻不是右括号
                    if (!TestPeek(TokenKind.TOKEN_SEP_RPAREN)) {
                        explistOptional = Parse_explist();
                    }
                    AssertAndRead(TokenKind.TOKEN_SEP_RPAREN);
                    return new parenedExplistArgsLabelContext
                    {
                        explistOptional = explistOptional
                    };

                case TokenKind.TOKEN_SEP_LCURLY:
                    return new tablectorArgsLabelContext
                    {
                        tableconstructor = Parse_tableconstructorExp()
                    };

                case TokenKind.TOKEN_STRING:
                    return new literalstrArgsLabelContext
                    {
                        s = NextToken().Lexeme
                    };

                default:
                    throw new Exception("syntax error");
            }
        }

        // 注意这是另一种star的写法
        // 这里要是找follow集合就很难找，实际上，我大概证明了用follow是不可行的
        // 因为有左值和右值的区别
        // f().a = 1，prefixexp是f()，而f().a是var
        // b = f().a，prefixexp是f().a
        // 而试图区别是在等号左边还是右边是不可行的，因为stat->预测分支时functioncall和varlist = explist这两个语句
        // 本来就分不开，你不能通过读到等号（因为如果不是赋值那读不到等号）而functioncall没有可以判断的东西
        // 这里判断first集合，贪婪匹配
        //varSuffixContext[] Parse_varSuffixStar()
        //{
        //    while (LookAhead().Kind ==
        //        (TokenKind.TOKEN_SEP_LBRACK |
        //        TokenKind.TOKEN_SEP_DOT |
        //        TokenKind.TOKEN_SEP_LPAREN | TokenKind.TOKEN_SEP_LCURLY | TokenKind.TOKEN_STRING)) {
        //    }
        //}

        //// varSuffix -> ‘[’ exp ‘]’ | ‘.’ Name | [‘:’ Name] args
        //varSuffixContext Parse_varSuffix()
        //{
        //    switch (LookAhead().Kind) {
        //        case TokenKind.TOKEN_SEP_LBRACK:
        //            break;
        //        case TokenKind.TOKEN_SEP_DOT:
        //            break;
        //        case TokenKind.TOKEN_SEP_LPAREN | TokenKind.TOKEN_SEP_LCURLY | TokenKind.TOKEN_STRING:
        //            break;
        //        default:
        //            throw new Exception();
        //            break;
        //    }
        //}

        #endregion 私有方法
    }
}