// 词法单元
//
// 语言的词法单元的静态信息

using System.Collections.Generic;
using System;
namespace zlua.Compiler
{
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
                    {"and",TokenKind.TOKEN_OP_AND},
                    {"break",TokenKind.TOKEN_KW_BREAK},
                    {"do",TokenKind.TOKEN_KW_DO},
                    {"else",TokenKind.TOKEN_KW_ELSE},
                    {"elseif",TokenKind.TOKEN_KW_ELSEIF},
                    {"end",TokenKind.TOKEN_KW_END},
                    {"false",TokenKind.TOKEN_KW_FALSE},
                    {"for",TokenKind.TOKEN_KW_FOR},
                    {"function",TokenKind.TOKEN_KW_FUNCTION},
                    {"goto",TokenKind.TOKEN_KW_GOTO},
                    {"if",TokenKind.TOKEN_KW_IF},
                    {"in",TokenKind.TOKEN_KW_IN},
                    {"local",TokenKind.TOKEN_KW_LOCAL},
                    {"nil",TokenKind.TOKEN_KW_NIL},
                    {"not",TokenKind.TOKEN_OP_NOT},
                    {"or",TokenKind.TOKEN_OP_OR},
                    {"repeat",TokenKind.TOKEN_KW_REPEAT},
                    {"return",TokenKind.TOKEN_KW_RETURN},
                    {"then",TokenKind.TOKEN_KW_THEN},
                    {"true",TokenKind.TOKEN_KW_TRUE},
                    {"until",TokenKind.TOKEN_KW_UNTIL},
                    {"while",TokenKind.TOKEN_KW_WHILE},
                };

        public static Dictionary<char, TokenKind> SingleCharKeywords { get; } =
                new Dictionary<char, TokenKind>
                {
                    {';',TokenKind.TOKEN_SEP_SEMI},
                    {',',TokenKind.TOKEN_SEP_COMMA},
                    {'(',TokenKind.TOKEN_SEP_LPAREN},
                    {')',TokenKind.TOKEN_SEP_RPAREN},
                    {']',TokenKind.TOKEN_SEP_RBRACK},
                    {'{',TokenKind.TOKEN_SEP_LCURLY},
                    {'}',TokenKind.TOKEN_SEP_RCURLY},
                    {'+',TokenKind.TOKEN_OP_ADD},
                    // 减号与注释都是以-开头，所以必须手工解析
                    //{'-',TokenKind.TOKEN_OP_MINUS},
                    {'*',TokenKind.TOKEN_OP_MUL},
                    {'^',TokenKind.TOKEN_OP_POW},
                    {'%',TokenKind.TOKEN_OP_MOD},
                    {'&',TokenKind.TOKEN_OP_BAND},
                    {'|',TokenKind.TOKEN_OP_BOR},
                    {'#',TokenKind.TOKEN_OP_LEN}
                };

        #endregion 公有常量

        public override string ToString()
        {
            return $"line:{Line} kind:{Kind} text:{Lexeme}";
        }
    }

    //
    //
    // 63个枚举值，为了方便判断First和Follow集合我们使用Flag
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
        TOKEN_OP_UNM = TOKEN_OP_MINUS,// unary minus
        TOKEN_OP_SUB = TOKEN_OP_MINUS,
        TOKEN_OP_BNOT = TOKEN_OP_WAVE,
        TOKEN_OP_BXOR = TOKEN_OP_WAVE
    }
}