// 词法分析
//
// [x] 正确分析hello world
//     print("hello world") => (print, `(, hello world, `))
// [ ] 学习和处理utf8字符串
//     * 使用utf8编码文件，运行时使用utf16
// [ ] 复习和参考leptjson解析基本字面量
// [ ] 先使用简单的方法，而不是严格实现lua标准
//    比如字符串转义，我们不转义，去掉引号输出就完事了
//    比如浮点数，用c#库解析就完事了
// [x] 为什么正则表达式不支持流，我觉得这是没道理的
//     因为正则表达式要回溯 by 钟牧含
// [x] 学习和使用流
//     * 流基本的操作只有两个：Read和Peek
//     * 因此流的基本特征是只能往前读，不能回退，且Peek只能看额外一个字符
//     * 因此我们往往只能手工解析
//     [ ] 写一个库可以match一个流，检查完了回退到开始，正则表达式不能回溯（反复回溯会替换缓冲，缓存命中率低，事实上我们不需要复杂的正则表达式），这样节省手工
//         StreamReader.BaseStream是内在的流对象，拥有Position和Seek可以访问和设置位置
//     * 读取流前总是要检查是否为eof
//     * 但是peek就不必，因为peek本身可以用来检查eof
//     * StreamReader
//     * StringWriter
//     * 处理eof可以暂缓一下，不是重点
// [ ] Token类包含Token的信息（也就是attribute），像符号就不需要lexeme，只有字面量需要
//     怎么搞
//     antlr是有text字段的，我明确知道自己不需要，就全部设为空串，这是没什么开销的
// [ ] lexer返回token流，parser要lookahead怎么缓存
// [ ] 参考ANTLR API
//     [ ] 为Token类添加位置，这样可以像python一样用^定位语法错误
// [x] Token类有必要有行号吗，每次都构造返回this.line，感觉很重复
//     A/ NewToken辅助lambda
// [x] 我还是使用斜杠代替冒号，因为冒号的中英文很像，左边英文右边中文哪个都让人很烦躁
// [ ] 跳过空白和注释不能一起做，注释必须放到后面switch中一起，因为减号也是-开头，跳过注释时
//     我peek到一个-，但是要再peek一个字符才能确定是注释还是减号，peek只能一次，要想再前进，必须read
//     如果混在一起会让代码复杂
// lexer返回的Token包含lexeme，实际上，对于lua，在分词阶段可以返回TValue
// 返回lexeme再让parser解析成值，其实多了一遍检查，你可以想象到，然而，自己读流开头然后手工解析是不实际的
// 浮点数解析算法太复杂了，int勉强可以
// antlr也是返回字符串的，而手写解析器这一步确实可以确定类型，那么早确定吧，这样符号的lexeme返回null
// 不不不，为了简单性还是字符串把

using System;
using System.Collections.Generic;
using System.IO;

namespace zlua.Compiler
{
    internal class Lexer
    {
        #region 公有方法
        //
        //
        // chunk/ lua源代码
        //
        public static IEnumerable<Token> TokenStream(Stream chunk, string chunkName)
        {
            int line = 1;
            // 辅助函数，构造带有当前行号的Token
            //
            // [x] 慢慢重构使用这个lambda
            // local function是c#7的功能，没必要使用，我们尽量维持在c#4以兼容unity
            Func<TokenKind, string, Token> NewToken = (kind, lexeme) => { return new Token(line, kind, lexeme); };

            // [ ] 慢慢重构使用这个lambda
            Func<TokenKind, Token> NewSymbol = (kind) => { return new Token(line, kind, ""); };

            // 跳过空白符，遇到换行符时递增行号
            //
            // 换行符有'\n'，'\r'，"\n\r"，"\r\n"
            // 嵌入主要是因为捕获Line，避免传参
            // TODO debug支持lambda吗，网上没找到
            Action<StreamReader> SkipWhitespace = (StreamReader reader) =>
              {
                  while (!reader.EndOfStream) {
                      // 跳过空白时只能peek再read
                      char c = (char)reader.Peek();
                      // 比较下面两种写法，switch多写一点不会死的
                      //if(c==' ' || c == '\f' || c == '\v') {
                      //reader.Read();
                      //}else if(c=='')

                      // \f和\v是比较少见的空白符
                      // leptjson就是普通的tnr和space
                      // 另一个特点是leptjson不记录行号，因此\n\r它不用考虑
                      // 我们必须考虑，手写状态机
                      switch (c) {
                          case ' ':
                              reader.Read();
                              break;

                          case '\t':
                              reader.Read();
                              break;

                          case '\f':
                              reader.Read();
                              break;

                          case '\v':
                              reader.Read();
                              break;

                          case '\n':
                              reader.Read();
                              line++;
                              // "\n\r"
                              if ('\r' == (char)reader.Peek()) {
                                  reader.Read();
                              } else {
                              }
                              break;

                          case '\r':
                              reader.Read();
                              line++;
                              if ('\n' == (char)reader.Peek()) {
                                  reader.Read();
                              } else {
                              }
                              break;

                          default:
                              break;
                      }
                  }
              };

            using (StreamReader reader = new StreamReader(chunk)) {
                // TODO 这样真的检查好了eof吗
                while (!reader.EndOfStream) {
                    SkipWhitespace(reader);
                    // 按标准，这里是peek或者说lookahead，然后匹配了再步进或者说消耗
                    // 然而前面一大片符号时都是不需要这个字符的，因此我只在解析字面量时传入这第一个字符
                    char c = (char)reader.Read();
                    if (Token.SingleCharKeywords.TryGetValue(c, out TokenKind kind)) {
                        yield return NewToken(kind, "");
                    } else {
                        switch (c) {
                            case ':': {
                                    if (TestAndAdvanceC(reader, ':')) {
                                        yield return NewToken(TokenKind.TOKEN_SEP_LABEL, "");
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_SEP_COLON, "");
                                    }
                                    break;  // yield return和return还是不一样的，必须有break
                                }
                            case '/': {
                                    if (TestAndAdvanceC(reader, '/')) {
                                        yield return NewToken(TokenKind.TOKEN_OP_IDIV, "");
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_OP_DIV, "");
                                    }
                                    break;
                                }
                            case '~': {
                                    if (TestAndAdvanceC(reader, '=')) {
                                        yield return NewToken(TokenKind.TOKEN_OP_NE, "");
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_OP_WAVE, "");
                                    }
                                    break;
                                }
                            case '=': {
                                    if (TestAndAdvanceC(reader, '=')) {
                                        yield return NewToken(TokenKind.TOKEN_OP_EQ, "");
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_OP_ASSIGN, "");
                                    }
                                    break;
                                }
                            // TODO 跳过一些，我们先完成helloworld需要的内容
                            case '\'':
                                yield return NewToken(TokenKind.TOKEN_STRING, ScanShortString(reader, c));
                                break;

                            case '"':
                                // TODO 两条分支相同。。有没有set写法。。
                                // 答案是没有，就两个case你就想优化成set？不会有好结果的。。
                                yield return NewToken(TokenKind.TOKEN_STRING, ScanShortString(reader, c));
                                break;

                            case '-': {
                                    if ('-' == (char)reader.Peek()) {
                                        reader.Read();
                                        SkipComment(reader);
                                    } else {
                                        yield return NewSymbol(TokenKind.TOKEN_OP_MINUS);
                                    }
                                    break;
                                }

                            default:
                                if (c == '.' || Char.IsDigit(c)) {
                                    yield return NewToken(TokenKind.TOKEN_NUMBER, ScanNumber(reader, c));
                                } else if (c == '_' || Char.IsLetter(c)) {
                                    string l = ScanIdentifier(reader, c);
                                    if (Token.Keywords.TryGetValue(l, out kind)) {
                                        yield return NewToken(kind, l);
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_IDENTIFIER, l);
                                    }
                                } else {
                                    // TODO syntax error
                                    throw new Exception($"unexpected symbol near {c}");
                                }
                                break;
                        }
                    }
                }
                // 可以在这里yield一个eof
            };
        }

        #endregion 公有方法

        #region 私有方法

        //
        //private bool TestC(StreamReader reader, char c)
        //{
        //    return c == (char)reader.Peek();
        //}

        private static bool TestAndAdvanceC(StreamReader reader, char c)
        {
            if (c == (char)reader.Peek()) {
                reader.Read();
                return true;
            } else {
                return false;
            }
        }

        // 跳过注释，开头的--在/TokenStream/中已消耗
        private static void SkipComment(StreamReader reader)
        {
            // 以[开头可能是长注释，匹配"^\[=**\["后一定是长注释
            // 换句话说，长注释时--加上长字符串
            // 从[开始ScanLongString，这个方法会递增行号
            // TODO 这里正则要想一想 可以放一放
            if ('[' == (char)reader.Peek()) {
            } else {
                // [x] 先处理短注释
                // 短注释跳过这一行所有内容
                while (!reader.EndOfStream) {
                    if (!IsNewline((char)reader.Peek())) {
                        reader.Read();
                    }
                }
            }
        }

        //private bool Test2C(StreamReader reader, char c1, char c2)
        //{
        //}

        // 扫描一段字符串，转换其中的转义字符
        //
        // /leftQuote/是传入的左引号，因为/TokenStream/把这个字符先消耗了，还是要传入验证的
        //
        // * 使用了流无法直接应用regex，regex不接受流，只接受字符串，然而你没法确定要读出多长的字符串
        //   所以我们干脆手写，这样边验证边转换转义字符
        //   leptjson做过，我觉得ok
        // TODO 先通过helloworld测试
        private static string ScanShortString(StreamReader reader, char leftQuote)
        {
            using (StringWriter writer = new StringWriter()) {
                while (!reader.EndOfStream) {
                    char c = (char)reader.Read();
                    if (c == leftQuote) {
                        return writer.ToString();
                    } else {
                        writer.Write(c);
                    }
                }
                // TODO error
                return "";
            }
        }

        private static string ScanIdentifier(StreamReader reader, char start)
        {
            using (StringWriter writer = new StringWriter()) {
                writer.Write(start);
                while (!reader.EndOfStream) {
                    char c = (char)reader.Read();
                    if (c == '_' || Char.IsLetterOrDigit(c)) {
                        writer.Write(c);
                    } else {
                        return writer.ToString();
                    }
                }
                // TODO
                return "";
            }
        }

        private static string ScanNumber(StreamReader reader, char start)
        {
            // TODO
            return "";
        }

        // 没用了
        // lua标准如下，如果有需要。。我的想法是用c#标准库
        // '\t', '\n', '\v', '\f', '\r', ' '
        //private static bool IsWhitespace(char c)
        //{
        //    return Char.IsWhiteSpace(c);
        //}

        private static bool IsNewline(char c)
        {
            return c == '\r' || c == '\n';
        }

        #endregion 私有方法
    }

    // 包装Lexer.TokenStream为一个带前瞻的
    // 
    // TODO 为什么不和Lexer合并呢
    //      我觉得现在分开挺好的，antlr也是分开的，多写一行不会死的
    //      antlr是传入lexer对象，而我因为用迭代器封装了状态，传入静态方法的返回值即可
    // peek和read，因为peek的解析是复杂过程，需要缓存结果
    // LookAheadToken有未缓存和有缓存两个状态，LookAhead方法计算出下一个Token缓存进去
    // NextToken方法在有缓存时先返回并清空该缓存，否则计算下一个Token并返回

    internal class TokenStream
    {
        #region 公有属性

        public bool IsEndOfStream { get; private set; }

        #endregion 公有属性

        #region 私有属性

        private IEnumerator<Token> Tokens { get; }
        private Token LookAheadToken { get; set; }

        #endregion 私有属性

        #region 构造函数

        // 传入Lexer.TokenStream
        public TokenStream(IEnumerable<Token> tokens)
        {
            Tokens = tokens.GetEnumerator();
        }

        #endregion 构造函数

        #region 公有方法

        // 前瞻一个token，不前进指针
        public Token LookAhead()
        {
            if (LookAheadToken == null) {
                IsEndOfStream = !Tokens.MoveNext();
                LookAheadToken = Tokens.Current;
            } else {
            }
            return LookAheadToken;
        }

        // 返回下一个token并前进一格指针
        public Token NextToken()
        {
            if (LookAheadToken != null) {
                return LookAheadToken;
            } else {
                LookAheadToken = null;
                IsEndOfStream = !Tokens.MoveNext();
                return Tokens.Current;
            }
        }

        #endregion 公有方法
    }
}