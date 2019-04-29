// 基于 https://github.com/antlr/grammars-v4/blob/master/lua/Lua.g4
// 修改说明：
// * 运算符
//   * 标点符号被尽量整合到exp语法规则中
//   * 删除了部分运算符，以符合5.1标准
// * 语句
//   * 删除了部分语句，以符合5.1标准
// * prefixexp被完全重写
//   * exp，functioncall和var使用prefixexp
//   * prefixexp被展开，使用star避免了左递归
// * funcname被改写，否则难以生成代码
// * parlist以及后面是完整复制，没有改动的
//   TODO 因此比如字面量规格可能是5.3而不是5.1
grammar Lua;

// 顶层语法符号
chunk: block EOF;

// 注意返回语句只能出现在block最后
block: stat* retstat?;

retstat: 'return' explist? ';'?;

stat
    : ';' #emptyStat
    | varlist '=' explist #assignStat
    | functioncall #functionCallStat
    | 'break' #breakStat
    | 'do' block 'end' #doStat
    | 'while' exp 'do' block 'end' #whileStat
    | 'repeat' block 'until' exp #repeatStat
    | 'if' exp 'then' block elseifBlock* elseBlock? 'end' #ifStat
    | 'for' NAME '=' exp ',' exp (',' exp)? 'do' block 'end' #forNmericStat
    | 'for' namelist 'in' exp 'do' block 'end' #forGenericStat
    | 'function' funcname funcbody #functionDefStat
    | 'local' 'function' NAME funcbody #localFunctionDefStat
    | 'local' namelist ('=' explist)? #localDeclarationStat;

elseifBlock:'elseif' exp 'then' block;

elseBlock:'else' block;

//TODO
funcname: NAME dotName* colonName?; //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name

dotName: '.' NAME;

colonName: ':' NAME;

varlist: var (',' var)*;

namelist: NAME (',' NAME)*;

explist: exp (',' exp)*;

exp
    : 'nil' #nilExp
    | 'false' #falseExp
    | 'true' #trueExp
    | number #numberExp
    | string #stringExp
    | '...' #varargExp
    | functiondef #functionDefExp
    | prefixexp #prefixexpExp
    | tableconstructor #tableCtorExp
    | <assoc=right> lhs=exp '^' rhs=exp #powExp
    | opUnary exp #unaryExp
    | lhs=exp opMulOrDivOrMod rhs=exp #mulOrDivOrModExp
    | lhs=exp opAddOrSub rhs=exp #addOrSubExp
    | <assoc=right> lhs=exp '..' rhs=exp #concatExp
    | lhs=exp opCmp rhs=exp #compareExp
    | lhs=exp 'and' rhs=exp #andExp
    | lhs=exp 'or' rhs=exp #orExp;

opUnary: NotKW | LenKW | MinusKW;

opMulOrDivOrMod: MulKW | DivKW | ModKW;

opAddOrSub: AddKW | MinusKW;

opCmp: LtKW | MtKW | LeKW | MeKW | NeKW | EqKW;

/*region keywords*/
NotKW:'not';
LenKW:'#';
MinusKW:'-';  // both for unary and binary op
MulKW:'*';
DivKW:'/';
ModKW:'%';
AddKW:'+';
LtKW:'<';  // less than
MtKW:'>';  // more than
LeKW:'<=';  // less equal
MeKW:'>=';  // more equal
NeKW:'~=';  // not equal
EqKW:'==';  // equal
/*endregion keywords*/

// 前缀表达式
//
// * “前缀”指prefixexp是functioncall和var的前缀
// * prefixexp是NAME，括号表达式，表或函数
//prefixexp: ((NAME | '(' exp ')' varSuffix) varSuffix* | '(' exp ')') nameAndArgs*;
prefixexp: prefixexp0 prefixexp1* ;

prefixexp0
    : NAME #nameP0
    | '(' exp ')' #bracedExpP1
    ;

prefixexp1
    : indexer #indexerP1
    | nameAndArgs #nameAndArgsP1
    ;

// 函数调用
//
// prefixexp求值得到一个表或函数
// 表:NAME(...)是方法调用
// 函数(...)是函数调用
functioncall: prefixexp nameAndArgs;

// 左值
//
// 名字，或表索引器
var
    : NAME #nameLvalue
    | prefixexp indexer #indexerLvalue;

indexer
    : '[' exp ']' #bracketIndexer
    | '.' NAME #dotIndexer;

nameAndArgs: (':' NAME)? args;

// 实参列表
args
    : '(' explist? ')'  #bracedArgs
	| tableconstructor #tablectorArgs
	| string  #stringArgs;

// 函数定义
functiondef: 'function' funcbody;

funcbody: '(' parlist? ')' block 'end';

// 形参列表
parlist
    : namelist (',' '...')? #namelistParlist
    | '...' # varargParlist
    ;

tableconstructor
    : '{' fieldlist? '}'
    ;

fieldlist
    : field (fieldsep field)* fieldsep?
    ;

field
    : '[' exp ']' '=' exp | NAME '=' exp | exp
    ;

fieldsep
    : ',' | ';'
    ;

number
    : INT | HEX | FLOAT | HEX_FLOAT
    ;

string
    : NORMALSTRING | CHARSTRING | LONGSTRING
    ;

// LEXER

NAME
    : [a-zA-Z_][a-zA-Z_0-9]*
    ;

NORMALSTRING
    : '"' ( EscapeSequence | ~('\\'|'"') )* '"'
    ;

CHARSTRING
    : '\'' ( EscapeSequence | ~('\''|'\\') )* '\''
    ;

LONGSTRING
    : '[' NESTED_STR ']'
    ;

fragment
NESTED_STR
    : '=' NESTED_STR '='
    | '[' .*? ']'
    ;

INT
    : Digit+
    ;

HEX
    : '0' [xX] HexDigit+
    ;

FLOAT
    : Digit+ '.' Digit* ExponentPart?
    | '.' Digit+ ExponentPart?
    | Digit+ ExponentPart
    ;

HEX_FLOAT
    : '0' [xX] HexDigit+ '.' HexDigit* HexExponentPart?
    | '0' [xX] '.' HexDigit+ HexExponentPart?
    | '0' [xX] HexDigit+ HexExponentPart
    ;

fragment
ExponentPart
    : [eE] [+-]? Digit+
    ;

fragment
HexExponentPart
    : [pP] [+-]? Digit+
    ;

fragment
EscapeSequence
    : '\\' [abfnrtvz"'\\]
    | '\\' '\r'? '\n'
    | DecimalEscape
    | HexEscape
    | UtfEscape
    ;

fragment
DecimalEscape
    : '\\' Digit
    | '\\' Digit Digit
    | '\\' [0-2] Digit Digit
    ;

fragment
HexEscape
    : '\\' 'x' HexDigit HexDigit
    ;

fragment
UtfEscape
    : '\\' 'u{' HexDigit+ '}'
    ;

fragment
Digit
    : [0-9]
    ;

fragment
HexDigit
    : [0-9a-fA-F]
    ;

COMMENT
    : '--[' NESTED_STR ']' -> channel(HIDDEN)
    ;

LINE_COMMENT
    : '--'
    (                                               // --
    | '[' '='*                                      // --[==
    | '[' '='* ~('='|'['|'\r'|'\n') ~('\r'|'\n')*   // --[==AA
    | ~('['|'\r'|'\n') ~('\r'|'\n')*                // --AAA
    ) ('\r\n'|'\r'|'\n'|EOF)
    -> channel(HIDDEN)
    ;

WS
    : [ \t\u000C\r\n]+ -> skip
    ;

SHEBANG
    : '#' '!' ~('\n'|'\r')* -> channel(HIDDEN)
    ;
