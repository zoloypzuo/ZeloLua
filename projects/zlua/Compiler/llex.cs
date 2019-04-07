// 词法分析
//
// [x] 正确分析hello world
//     print("hello world") => (print, '(', hello world, '`'))
// [x] lexer返回token流，parser要lookahead怎么缓存
//     我构造了一个通用的缓存一次计算的流
// [x] 参考ANTLR API
// [ ] 为Token类添加位置，这样可以像python一样用^定位语法错误
// [x] Token类有必要有行号吗，每次都构造返回this.line，感觉很重复
//     A/ 使用闭包NewToken辅助lambda（md前几天面试还说自己不会用闭包的。。打脸了，真香）
// [x] 跳过空白和注释不能一起做，注释必须放到后面switch中一起，因为减号也是-开头，跳过注释时
//     我peek到一个-，但是要再peek一个字符才能确定是注释还是减号，peek只能一次，要想再前进，必须read
//     如果混在一起会让代码复杂
// [ ] 测试lua官方的错误信息
// [ ] 异常，打行号

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace zlua.Compiler
{
    // 词法分析器
    //
    // 请实例化传给TokenStream再给parser调用
    // 只有parser实现会调用这个类
    //
    // 使用字符串指针定位当前分析到的位置，需要正则表达式的时候才切片，避免切片，因为
    internal class Lexer : IEnumerable<Token>
    {
        #region 公有属性

        // 一开始用list<char>，发现没有必要。。
        // List有GetRange，数组没有
        public string Chunk { get; }

        public string ChunkName { get; }

        #endregion 公有属性

        #region 私有属性

        // chunk指针，指向还未处理的第一个字符
        //
        // 指针前进策略：
        // * 使用if或者switch语句前瞻预判时不修改/Position/
        // * 在控制语句块中第一行前进一格，表示字符已处理
        //
        // 这是件很琐碎很容易错的事情，不推荐在大范围内（比如几十行的switch）
        // 提取公共的Position++，自己写到那里容易想，前面有没有Position++啊
        // 我的想法有一些改变。。
        private int Position { get; set; } = 0;

        #endregion 私有属性

        #region 构造函数

        public Lexer(string chunk, string chunkName)
        {
            Chunk = chunk;
            ChunkName = chunkName;
        }

        #endregion 构造函数

        #region 公有方法

        public IEnumerator<Token> GetEnumerator()
        {
            int line = 1;

            #region 内嵌辅助函数

            // 构造带有当前行号的Token
            //
            // [x] 慢慢重构使用这个lambda
            // local function是c#7的功能，没必要使用，我们尽量维持在c#4以兼容unity
            Func<TokenKind, string, Token> NewToken = (TokenKind kind, string lexeme) => new Token(line, kind, lexeme);

            // [x] 慢慢重构使用这个lambda
            Func<TokenKind, Token> NewSymbol = (TokenKind kind) => new Token(line, kind, "");

            // 跳过空白符，遇到换行符时递增行号
            //
            // * 换行符有'\n'，'\r'，"\n\r"，"\r\n"
            // * 嵌入主要是因为捕获Line，避免传参
            // [x] debug支持lambda吗，网上没找到
            //     A/ 试验过了，支持的
            // * \f和\v是比较少见的空白符
            //   leptjson就是普通的tnr和space
            // * leptjson不记录行号，因此\n\r它不用考虑
            Action SkipWhitespace = () =>
            {
                // 用于跳出外层循环
                bool flag = true;
                while (IsNotEndOfChunk && flag) {
                    // 比较下面两种写法
                    // switch方式虽然多写一点不会死的
                    //if(c==' ' || c == '\f' || c == '\v') {
                    //reader.Read();
                    //}else if(c=='')
                    switch (Peek()) {
                        case ' ':
                            Position++;
                            break;

                        case '\t':
                            Position++;
                            break;

                        case '\f':
                            Position++;
                            break;

                        case '\v':
                            Position++;
                            break;

                        case '\n':
                            Position++;
                            line++;
                            // "\n\r"
                            TestAndRead('\r');
                            break;

                        case '\r':
                            Position++;
                            line++;
                            TestAndRead('\n');
                            break;

                        default:
                            flag = false;
                            break;
                    }
                }
            };

            // 处理转义字符
            //
            // 开头的反斜杠被读掉了
            // 传入builder是因为\z并不返回char
            // 而是执行动作
            // 内嵌式因为\z要调用SkipWhitespace
            Action<StringBuilder> Escape =
                (StringBuilder builder) =>
            {
                char c = Read();
                char outChar;
                if (Token.SingleCharEscapetable.TryGetValue(c, out outChar)) {
                    builder.Append(outChar);
                    return;
                } else {
                    switch (c) {
                        case 'z':
                            SkipWhitespace();
                            break;
                        // \xXX XX是两位十六进制代表的ascii码
                        case 'x':
                            // 一下子写不对的corner case，先跳过
                            // 下面的代码可能是错误的，因为XX需要专用的解析，标准库的可能不适用
                            //char[] cs = Chunk.GetRange(Position, 2).ToArray();
                            //byte outByte;
                            //if (!byte.TryParse(new String(cs), out outByte)) {
                            //    throw new Exception("两位ascii整数格式不正确"); // TODO看心情验证ascii首位为0，不知道一般的解码器是否验证。。
                            //} else {
                            //    builder.Append((char)outByte);
                            //}
                            throw new NotImplementedException();
                            break;
                        // \u{XXX} utf8字符
                        case 'u':
                            throw new NotImplementedException();
                            break;

                        default: {
                                // TODO \nnn 三位十进制，代表ascii，懒得搞了
                                throw new NotImplementedException();
                                throw new Exception("错误的转义字符内容");
                                break;
                            }
                    }
                }
            };

            // 扫描一段字符串，转换其中的转义字符
            //
            // 这里必须做好转义，因为长字符串是没有转义的，而字符串我们只定义了一个token类型，所以必须统一返回解析好的字符串
            Func<string> ScanShortString = () =>
             {
                 char leftQuote = Read();
                 StringBuilder builder = new StringBuilder();
                 while (IsNotEndOfChunk) {
                     char c = Read();
                     // 如果是转义，处理好
                     if (c == '\\') {
                         Escape(builder);
                     } else if (c == leftQuote) {
                         return builder.ToString();
                     } else {
                         builder.Append(c);
                     }
                 }
                 // TODO error
                 return "";
             };

            #endregion 内嵌辅助函数

            while (IsNotEndOfChunk) {
                SkipWhitespace();
                // 若源文本末尾是空白符，跳过空白后Position已经越界
                if (!IsNotEndOfChunk)
                    break;

                char c = Peek();

                // 查表是为了过滤，因为这些字符有共同特点
                TokenKind outKind;
                Tuple<TokenKind, char, TokenKind> ouTuple;
                if (Token.SingleCharSymbols.TryGetValue(c, out outKind)) {
                    Position++;
                    yield return NewSymbol(outKind);
                } else if (Token.DoubleCharSymbols.TryGetValue(c, out ouTuple)) {
                    Position++;
                    if (TestAndRead(ouTuple.Item2)) {
                        yield return NewSymbol(ouTuple.Item3);
                    } else {
                        yield return NewSymbol(ouTuple.Item1);
                    }
                } else {
                    switch (c) {
                        // 下面两个也是一样的逻辑，但是就两个，手写了
                        case '<': {
                                Position++;
                                // <<
                                if (TestAndRead('<')) {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_SHL);
                                }
                                // <=
                                else if (TestAndRead('=')) {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_LE);
                                }
                                // <
                                else {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_LT);
                                }
                                break;
                            }
                        case '>': {
                                Position++;
                                if (TestAndRead('>')) {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_SHR);
                                } else if (TestAndRead('=')) {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_GE);
                                } else {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_GT);
                                }
                                break;
                            }
                        // ...，..，.和.开头的浮点数
                        // 注意这里是贪婪的
                        case '.': {
                                // ...
                                if (Chunk[Position + 1] == '.' && Chunk[Position + 2] == '.') {
                                    Position += 3;
                                    yield return NewSymbol(TokenKind.TOKEN_VARARG);
                                }
                                // ..
                                else if (Chunk[Position + 1] == '.') {
                                    Position += 2;
                                    yield return NewSymbol(TokenKind.TOKEN_OP_CONCAT);
                                }
                                // .
                                else {
                                    // peek一个字符以区别浮点数
                                    // 这个浮点数必须在这里处理，因为c#的switch有严格的break要求
                                    // 事后ifelse也不好，所以这里多写一行
                                    // 注意相反的条件必须检查eof
                                    // if (i == -1 || !Char.IsDigit((char)i))
                                    if (Char.IsDigit(Chunk[Position + 1])) {
                                        yield return NewToken(TokenKind.TOKEN_NUMBER, ScanNumber());
                                    } else {
                                        Position++;
                                        yield return NewSymbol(TokenKind.TOKEN_SEP_DOT);
                                    }
                                }
                                break;
                            }
                        // 长字符串和表索引
                        case '[': {
                                Position++;
                                // 注意这里不读掉这个[或者=
                                c = Peek();
                                if (c == '[' || c == '=') {
                                    yield return NewToken(TokenKind.TOKEN_STRING, ScanLongString());
                                } else {
                                    yield return NewSymbol(TokenKind.TOKEN_SEP_LBRACK);
                                }
                                break;
                            }
                        case '\'': {
                                yield return NewToken(TokenKind.TOKEN_STRING, ScanShortString());
                                break;
                            }
                        case '"': {
                                yield return NewToken(TokenKind.TOKEN_STRING, ScanShortString());
                                break;
                            }
                        case '-': {
                                Position++;
                                if (TestAndRead('-')) {
                                    SkipComment();
                                } else {
                                    yield return NewSymbol(TokenKind.TOKEN_OP_MINUS);
                                }
                                break;
                            }
                        default: {
                                // 这里我们不处理dot开头的浮点数
                                // 在上面dot处处理
                                if ( /*c == '.' ||*/ Char.IsDigit(c)) {
                                    yield return NewToken(TokenKind.TOKEN_NUMBER, ScanNumber());
                                } else if (c == '_' || Char.IsLetter(c)) {
                                    string identifier = ScanIdentifier();
                                    if (Token.Keywords.TryGetValue(identifier, out outKind)) {
                                        yield return NewToken(outKind, identifier);
                                    } else {
                                        yield return NewToken(TokenKind.TOKEN_IDENTIFIER, identifier);
                                    }
                                } else {
                                    // TODO syntax error
                                    throw new Exception($"unexpected symbol near {c}");
                                }
                                break;
                            }
                    }
                }
            }
            // chunk结束，返回eof
            yield return NewSymbol(TokenKind.TOKEN_EOF);
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        #endregion 公有方法

        #region 私有方法

        // 测试前瞻字符是否为/c/，是则前进一格chunk指针
        //
        // 在条件中有副作用不是一个好习惯，但是这是一个辅助函数
        private bool TestAndRead(char c)
        {
            if ((Position) < Chunk.Length && Chunk[Position] == c) {
                Position++;
                return true;
            } else {
                return false;
            }
        }

        // 测试前瞻字符是否满足/predicate/，是则前进一格指针
        private bool TestAndRead(Predicate<char> predicate)
        {
            if (predicate(Peek())) {
                Position++;
                return true;
            } else {
                return false;
            }
        }

        private bool TestPeek(char c)
        {
            return Chunk[Position] == c;
        }

        private bool TestPeek(Predicate<char> predicate)
        {
            return predicate(Peek());
        }

        private char Read()
        {
            return Chunk[Position++];
        }

        private char Peek()
        {
            return Chunk[Position];
        }

        private bool IsNotEndOfChunk {
            // 初始值 0<n
            get { return Position < Chunk.Length; }
        }

        //
        //
        // 不会抛出异常
        private string ScanIdentifier()
        {
            int count = MaxLength(Token.MaxLengthOfIdentifier);
            var match = Regex.Match(Chunk.Substring(Position, count), Token.ReIdentifier);
            Position += match.Length;
            return match.Value;
        }

        private int MaxLength(int maxLength)
        {
            int count = Position + maxLength <= Chunk.Length ?
                maxLength : Chunk.Length - Position;
            return count;
        }

        private string ScanNumber()
        {
            int count = MaxLength(Token.MaxLengthOfNumber);
            Match match = Regex.Match(Chunk.Substring(Position, count), Token.ReNumber);
            if (match.Success) {
                Position += match.Length;
                return match.Value;
            } else {
                // TODO
                throw new Exception("parse number error");
            }
        }

        private int ScanNumLeftBracket()
        {
            int i = 0;
            while (TestAndRead('=')) {
                i++;
            }
            return i;
        }

        // 扫描并返回字符串内容
        //
        // [=[ xxx ]=] => xxx
        // 这里我们要验证等号个数相等
        // 这里我真的写得超级复杂。。没办法。。
        private string ScanLongString()
        {
            Read();

            int n = ScanNumLeftBracket();
            if (!TestAndRead('[')) {
                throw new Exception("invalid long string delimiter near");
            }
            // 跳过第一个换行符
            // TODO 没处理其他换行符
            // TODO 长字符串将四种换行符统一换成\n
            TestAndRead('\n');
            // 解析来正式解析字符串内容，不允许转义
            StringBuilder builder = new StringBuilder();
            while (IsNotEndOfChunk) {
                // 可能是字符串结尾，形如]==]
                // 如果没匹配就仍然是字符串内部，要把读出的加入builder
                // 检查过了，没问题，就是太烦了
                // 注意这里是没法正则的，所以只好手写逻辑
                if (TestAndRead(']')) {
                    List<char> cs = new List<char>('[');
                    bool pass = true;
                    // 尝试读出n个等号，不够就不是字符串结尾
                    for (int i = 0; i < n; i++) {
                        char c1 = Read();
                        cs.Add(c1);
                        if ('=' != c1) {
                            pass = false;
                            break;
                        }
                    }
                    if (pass) {
                        // end of long string
                        if (TestAndRead(']')) {
                            return builder.ToString();
                        } else {
                            builder.Append(cs);
                        }
                    }
                } else {
                    builder.Append(Read());
                }
            }
            return builder.ToString();
        }

        // 跳过注释，开头的--在/TokenStream/中已消耗
        private void SkipComment()
        {
            // 以[开头可能是长注释，匹配"^\[=**\["后一定是长注释
            // 换句话说，长注释时--加上长字符串
            // 从[开始ScanLongString，这个方法会递增行号
            // 实现上正则是做不到的，我今天忙了一天这件事了
            if (TestPeek('[')) {
                ScanLongString();
            }

            // [x] 先处理短注释
            // 短注释跳过这一行所有内容
            while (IsNotEndOfChunk && !IsNewlineChar(Peek())) {
                Position++;
            }
        }

        private bool IsNewlineChar(char c)
        {
            return c == '\r' || c == '\n';
        }

        #endregion 私有方法
    }

    // 包装Lexer为一个带前瞻的流对象
    //
    // 词法分析认为是复杂计算，因此前瞻时缓存结果
    // 内部维护一个List<Token>包含所有已经计算的Token值，不删除旧的值，所有Token都会一直在内存
    // NextToken对应于流的指针，而LookAhead(n)的n是相对于流指针的偏移
    // LookAhead有单个元素和数组两个版本，因为我暂时不知道parser是否要用哪种，干脆都写
    // NextToken和LookAhead在未计算所需Token时计算并缓存Token，从缓存中取出Token
    internal class TokenStream
    {
        #region 公有属性

        public bool IsNotEndOfStream { get; private set; }

        // 
        public int Line {
            get { return CachedTokens[StreamPosition].Line; }
        }
        #endregion 公有属性

        #region 私有属性

        private IEnumerator<Token> TokenEnumerator { get; }
        private List<Token> CachedTokens { get; } = new List<Token>();

        private int CachedPosition {
            get { return CachedTokens.Count; }
        }

        private int StreamPosition { get; set; } = -1;

        #endregion 私有属性

        #region 构造函数

        // 传入Lexer对象
        public TokenStream(IEnumerable<Token> tokens)
        {
            TokenEnumerator = tokens.GetEnumerator();
        }

        #endregion 构造函数

        #region 公有方法

        // 前瞻token，不前进流指针
        public Token LookAhead(int n = 1)
        {
            CacheIfNeeded(n);
            return CachedTokens[StreamPosition + n];
        }

        public Token[] LookAheadArray(int n)
        {
            CacheIfNeeded(n);
            return CachedTokens.GetRange(StreamPosition, n).ToArray();
        }

        // 返回下一个token并前进一格流指针
        public Token NextToken()
        {
            CacheIfNeeded(1);
            StreamPosition++;
            return CachedTokens[StreamPosition];
        }

        #endregion 公有方法

        #region 私有方法

        private void CacheIfNeeded(int n)
        {
            // 初始值 0<=-1+1
            if (CachedPosition <= StreamPosition + n) {
                // 初始值 -1+1-0+1
                int numToCache = StreamPosition + n - CachedPosition + 1;
                int i = 0;
                while (i < numToCache) {
                    IsNotEndOfStream = TokenEnumerator.MoveNext();
                    if (IsNotEndOfStream) {
                        CachedTokens.Add(TokenEnumerator.Current);
                    } else {
                        // TODO
                        // 这里会在parser报错
                        // 比如"print(1"缺少一个右括号，parser调用lexer时就会走到这里
                        // 我现在还不知道
                        // 到时候再说
                        // 别忘了可以捕获异常，但是要考虑性能
                        throw new Exception("no more tokens");
                    }
                    i++;
                }
            }
        }

        #endregion 私有方法
    }

    // 语言的词法单元的静态信息
    //
    // Token类中几个静态字典其实都是词法分析器的可配置部分
    // 抽象这一部分有利用在项目结束时抽象出可配置词法分析器
    internal class Token
    {
        #region 公有属性

        // 行号
        public int Line { get; }

        // 类型
        public TokenKind Kind { get; }

        // 对应的文本
        //
        // 只有字面量才有值，对于符号我们不使用这个字段，词法分析时设为空串
        public string Lexeme { get; }

        #endregion 公有属性

        #region 构造函数

        public Token(int line, TokenKind kind, string lexeme)
        {
            Line = line;
            Kind = kind;
            Lexeme = lexeme;
        }

        #endregion 构造函数

        #region 公有常量

        public static Dictionary<string, TokenKind> Keywords { get; } =
                new Dictionary<string, TokenKind>
                {
                    ["and"] = TokenKind.TOKEN_OP_AND,
                    ["break"] = TokenKind.TOKEN_KW_BREAK,
                    ["do"] = TokenKind.TOKEN_KW_DO,
                    ["else"] = TokenKind.TOKEN_KW_ELSE,
                    ["elseif"] = TokenKind.TOKEN_KW_ELSEIF,
                    ["end"] = TokenKind.TOKEN_KW_END,
                    ["false"] = TokenKind.TOKEN_KW_FALSE,
                    ["for"] = TokenKind.TOKEN_KW_FOR,
                    ["function"] = TokenKind.TOKEN_KW_FUNCTION,
                    ["goto"] = TokenKind.TOKEN_KW_GOTO,
                    ["if"] = TokenKind.TOKEN_KW_IF,
                    ["in"] = TokenKind.TOKEN_KW_IN,
                    ["local"] = TokenKind.TOKEN_KW_LOCAL,
                    ["nil"] = TokenKind.TOKEN_KW_NIL,
                    ["not"] = TokenKind.TOKEN_OP_NOT,
                    ["or"] = TokenKind.TOKEN_OP_OR,
                    ["repeat"] = TokenKind.TOKEN_KW_REPEAT,
                    ["return"] = TokenKind.TOKEN_KW_RETURN,
                    ["then"] = TokenKind.TOKEN_KW_THEN,
                    ["true"] = TokenKind.TOKEN_KW_TRUE,
                    ["until"] = TokenKind.TOKEN_KW_UNTIL,
                    ["while"] = TokenKind.TOKEN_KW_WHILE,
                };

        // peek一个字符即可区分出是这个token类型
        public static Dictionary<char, TokenKind> SingleCharSymbols { get; } =
                new Dictionary<char, TokenKind>
                {
                    [';'] = TokenKind.TOKEN_SEP_SEMI,
                    [','] = TokenKind.TOKEN_SEP_COMMA,
                    ['('] = TokenKind.TOKEN_SEP_LPAREN,
                    [')'] = TokenKind.TOKEN_SEP_RPAREN,
                    [']'] = TokenKind.TOKEN_SEP_RBRACK,
                    ['{'] = TokenKind.TOKEN_SEP_LCURLY,
                    ['}'] = TokenKind.TOKEN_SEP_RCURLY,
                    ['+'] = TokenKind.TOKEN_OP_ADD,
                    // 减号与注释都是以-开头，所以必须手工解析
                    //['-']=TokenKind.TOKEN_OP_MINUS,
                    ['*'] = TokenKind.TOKEN_OP_MUL,
                    ['^'] = TokenKind.TOKEN_OP_POW,
                    ['%'] = TokenKind.TOKEN_OP_MOD,
                    ['&'] = TokenKind.TOKEN_OP_BAND,
                    ['|'] = TokenKind.TOKEN_OP_BOR,
                    ['#'] = TokenKind.TOKEN_OP_LEN
                };

        // peek到key char，检查下一个char是不是第二个char，来判断是哪种符号
        public static Dictionary<char, Tuple<TokenKind, char, TokenKind>> DoubleCharSymbols { get; } =
            new Dictionary<char, Tuple<TokenKind, char, TokenKind>>
            {
                {':', new Tuple<TokenKind,char, TokenKind>(TokenKind.TOKEN_SEP_COLON,':',TokenKind.TOKEN_SEP_LABEL) },
                {'/', new Tuple<TokenKind, char, TokenKind>(TokenKind.TOKEN_OP_DIV,'/',TokenKind.TOKEN_OP_IDIV) },
                {'~', new Tuple<TokenKind, char, TokenKind>(TokenKind.TOKEN_OP_WAVE,'=',TokenKind.TOKEN_OP_NE) },
                {'=', new Tuple<TokenKind, char, TokenKind>(TokenKind.TOKEN_OP_ASSIGN,'=',TokenKind.TOKEN_OP_EQ) },
            };

        public static Dictionary<char, char> SingleCharEscapetable { get; } =
            new Dictionary<char, char>
            {
                ['a'] = (char)0x07,
                ['b'] = (char)0x08,
                ['t'] = (char)0x09,
                ['n'] = (char)0x0a,
                ['\v'] = (char)0x0b,
                ['\f'] = (char)0x0c,
                ['\r'] = (char)0x0d,
                ['"'] = (char)0x22,
                ['\\'] = (char)0x5c,
            };

        // 为了避免c#字符串切片，我指定一个最大长度，满足99%的需要
        public const int MaxLengthOfNumber = 20;

        public const int MaxLengthOfIdentifier = 20;

        public const string ReNumber =
            @"^0[xX][0-9a-fA-F]*(\.[0-9a-fA-F]*)?([pP][+\-]?[0-9]+)?|^[0-9]*(\.[0-9]*)?([eE][+\-]?[0-9]+)?";

        public const string ReIdentifier = @"[_a-zA-Z][_a-zA-Z0-9]*";

        #endregion 公有常量

        public override string ToString()
        {
            return $"line:{Line} kind:{Kind} text:{Lexeme}";
        }
    }

    //
    //
    // 64个枚举值，为了方便判断First和Follow集合我们使用Flag
    [Flags]
    internal enum TokenKind : long
    {
        TOKEN_EOF,// end-of-file
        TOKEN_VARARG,// ...
        TOKEN_SEP_SEMI,// ;
        TOKEN_SEP_COMMA,// ,
        TOKEN_SEP_DOT,// .
        TOKEN_SEP_COLON,// :
        TOKEN_SEP_LABEL,// ::
        TOKEN_SEP_LPAREN,// (
        TOKEN_SEP_RPAREN,// )
        TOKEN_SEP_LBRACK,// [
        TOKEN_SEP_RBRACK,// ]
        TOKEN_SEP_LCURLY,// {
        TOKEN_SEP_RCURLY,// }
        TOKEN_OP_ASSIGN,// =
        TOKEN_OP_MINUS,// - (sub or unm)
        TOKEN_OP_WAVE,// ~ (bnot or bxor)
        TOKEN_OP_ADD,// +
        TOKEN_OP_MUL,// *
        TOKEN_OP_DIV,// /
        TOKEN_OP_IDIV,// ,//
        TOKEN_OP_POW,// ^
        TOKEN_OP_MOD,// %
        TOKEN_OP_BAND,// &
        TOKEN_OP_BOR,// |
        TOKEN_OP_SHR,// >>
        TOKEN_OP_SHL,// <<
        TOKEN_OP_CONCAT,// ..
        TOKEN_OP_LT,// <
        TOKEN_OP_LE,// <=
        TOKEN_OP_GT,// >
        TOKEN_OP_GE,// >=
        TOKEN_OP_EQ,// ==
        TOKEN_OP_NE,// ~=
        TOKEN_OP_LEN,// #
        TOKEN_OP_AND,// and
        TOKEN_OP_OR,// or
        TOKEN_OP_NOT,// not
        TOKEN_KW_BREAK,// break
        TOKEN_KW_DO,// do
        TOKEN_KW_ELSE,// else
        TOKEN_KW_ELSEIF,// elseif
        TOKEN_KW_END,// end
        TOKEN_KW_FALSE,// false
        TOKEN_KW_FOR,// for
        TOKEN_KW_FUNCTION,// function
        TOKEN_KW_GOTO,// goto
        TOKEN_KW_IF,// if
        TOKEN_KW_IN,// in
        TOKEN_KW_LOCAL,// local
        TOKEN_KW_NIL,// nil
        TOKEN_KW_REPEAT,// repeat
        TOKEN_KW_RETURN,// return
        TOKEN_KW_THEN,// then
        TOKEN_KW_TRUE,// true
        TOKEN_KW_UNTIL,// until
        TOKEN_KW_WHILE,// while
        TOKEN_IDENTIFIER,// identifier
        TOKEN_NUMBER,// number literal
        TOKEN_STRING,// string literal

        //long string literal
        // 这里作者不太好的地方
        // 长字符串和短字符串的格式是不同的
        // 既然lexer只返回string，由parser解析就应该分清楚
        // 当然，这样做不是错的，只是不符合设计
        // 然后发现\z要跳过空白，所以只能最好在lexer做了。。
        // 放弃了。。
        //TOKEN_LONG_STRING,
        TOKEN_OP_UNM = TOKEN_OP_MINUS,// unary minus

        TOKEN_OP_SUB = TOKEN_OP_MINUS,
        TOKEN_OP_BNOT = TOKEN_OP_WAVE,
        TOKEN_OP_BXOR = TOKEN_OP_WAVE
    }
}