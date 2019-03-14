/*This grammar file derived from:
    Lua 5.3 Reference Manual
    http://www.lua.org/manual/5.3/manual.html
    Lua 5.2 Reference Manual
    http://www.lua.org/manual/5.2/manual.html
    Lua 5.1 grammar written by Nicolai Mainiero
    http://www.antlr3.org/grammar/1178608849736/Lua.g
Tested by Kazunori Sakamoto with Test suite for Lua 5.2 (http://www.lua.org/tests/5.2/)
Tested by Alexander Alexeev with Test suite for Lua 5.3 http://www.lua.org/tests/lua-5.3.2-tests.tar.gz
*/
grammar Lua;
/* #region Top level*/
chunk: block EOF;

block: stat* retstat?;

retstat: 'return' explist? ';'?;
/* #endregion*/
/* #region Statement*/
stat
    : ';' #emptyStat
    | varlist '=' explist #assignStat
    | functioncall #functioncallStat
    | 'break' #breakStat
    | 'do' block 'end' #doendStat
    | 'while' exp 'do' block 'end' #whileStat
    //| 'repeat' block 'until' exp #repeatStat
    | 'if' exp 'then' block elseifBlock* elseBlock? 'end' #ifelseStat
    | 'for' NAME '=' exp ',' exp (',' exp)? 'do' block 'end' #forijkStat
    | 'for' namelist 'in' explist 'do' block 'end' #forinStat
    | 'function' funcname funcbody #functiondefStat
    | 'local' 'function' NAME funcbody #localfunctiondefStat
    | 'local' namelist ('=' explist)? #localassignStat;

elseifBlock:'elseif' exp 'then' block;

elseBlock:'else' block;

funcname: NAME tableOrFunc methodname; //任意多次查表得到对象，然后调用方法；最简单的情况下，就是单独一个name

tableOrFunc:('.' NAME)*;

methodname:(':' NAME)?;

varlist: var (',' var)*;

namelist: NAME (',' NAME)*;

explist: exp (',' exp)*;

doc:LONGSTRING; //chunk, function（其实都是proto）和表可以拥有doc
                //说到这里还是希望向py靠拢，func应该也有元表（用来支持doc）
                //希望提供正式的class机制，原型的问题在于没有封装原型为class，这点不好。参考LOOP
                // TODO要考虑几个问题：
                // 1.是否影响语法解析，不会出错吗
                // 2.python是怎么做的。是否允许字段有doc呢？
                // 3.怎么提供一个doc的接口，当然希望导出，否则干嘛 ，
                // 4.我希望format仍然是lua，利用dofile可以清晰简单地复用lua来处理doc
/* #endregion*/
/* #region Expression*/
exp
    : nilfalsetruevararg=('nil'|'false'|'true'|'...') #nilfalsetruevarargExp
    | number #numberExp
    | string #stringExp
    | functiondef #functiondefExp
    | prefixexp #prefixexpExp
    | tableconstructor #tablectorExp
    | <assoc=right> lhs=exp operatorPower='^' rhs=exp #powExp
    | operatorUnary=('not' | '#' | '-' /*| '~' not in 5.1*/) exp #unmExp
    | lhs=exp operatorMulDivMod=('*' | '/' | '%' /*| '//' not in 5.1*/) rhs=exp #muldivExp
    | lhs=exp operatorAddSub=('+' | '-') rhs=exp #addsubExp
    | <assoc=right> lhs=exp operatorStrcat='..' rhs=exp #concatExp
    | lhs=exp operatorComparison=('<' | '>' | '<=' | '>=' | '~=' | '==') rhs=exp #cmpExp
    | lhs=exp operatorAnd='and' rhs=exp #andExp
    | lhs=exp operatorOr='or' rhs=exp #orExp
    /*| lhs=exp operatorBitwise=('&' | '|' | '~' | '<<' | '>>') rhs=exp #bitwiseExp not in 5.1*/;

/*keywords*/
NilKW:'nil';
FalseKW:'false';
TrueKW:'true';
VarargKW:'...';
NotKW:'not';
LenKW:'#';
MinusKW:'-'; //both unary and binary op
MulKW:'*';
DivKW:'/';
ModKW:'%';
AddKW:'+';
ConcatKW:'..';
LtKW:'<'; //less than
MtKW:'>'; //more than
LeKW:'<='; //less equal
MeKW:'>='; //more equal
NeKW:'~='; //not equal
EqKW:'=='; //equal
AndKW:'and';
OrKW:'or';

prefixexp: varOrExp nameAndArgs*; //var或带括号的exp；注意看下一条，如果有nameAndArgs就是函数调用。

functioncall: varOrExp nameAndArgs+; 

varOrExp: var | '(' exp ')' ; //其实还是exp，左值也要返回右值的

var: (NAME | '(' exp ')' varSuffix) varSuffix*; //左值，name或者表字段

varSuffix: nameAndArgs* ('[' exp ']' | '.' NAME);

nameAndArgs: (':' NAME)? args;

args 
    : '(' explist? ')'  #normalArgs //arg list，一般的或一个表ctor或一个string
	| tableconstructor #tablectorArgs
	| string  #stringArgs;

functiondef: 'function' funcbody;  //定义函数;

funcbody: '(' parlist? ')' block 'end';

parlist: namelist (',' '...')? | '...' ; //param list，一堆param后vararg或单独vararg;

tableconstructor: '{' fieldlist? '}';

fieldlist: field (fieldsep field)* fieldsep?;

field: '[' exp ']' '=' exp | NAME '=' exp | exp ; //表ctor的字段初始化;

fieldsep: ',' | ';' ; //表ctor的字段分隔符;

number: INT | HEX | FLOAT /*| HEX_FLOAT dont use that :) */;

string: NORMALSTRING | CHARSTRING | LONGSTRING; // "..." or '...' or [=[...]=]
/* #endregion*/


// LEXER
NAME: [a-zA-Z_][a-zA-Z_0-9]*;

NORMALSTRING: '"' ( EscapeSequence | ~('\\'|'"') )* '"';

CHARSTRING: '\'' ( EscapeSequence | ~('\''|'\\') )* '\'';

LONGSTRING: '[' NESTED_STR ']';

fragment
NESTED_STR  // =[ ... ]=， =可以任意多，[]标志了str的界
    : '=' NESTED_STR '='
    | '[' .*? ']';

INT: Digit+;

HEX: '0' [xX] HexDigit+;

FLOAT: Digit+ '.' Digit* ExponentPart?
    | '.' Digit+ ExponentPart?
    | Digit+ ExponentPart;

/*
HEX_FLOAT: '0' [xX] HexDigit+ '.' HexDigit* HexExponentPart?
    | '0' [xX] '.' HexDigit+ HexExponentPart?
    | '0' [xX] HexDigit+ HexExponentPart;
*/

fragment
ExponentPart: [eE] [+-]? Digit+;

fragment
HexExponentPart: [pP] [+-]? Digit+;

fragment
EscapeSequence: '\\' [abfnrtvz"'\\]
    | '\\' '\r'? '\n'
    | DecimalEscape
    | HexEscape
    | UtfEscape;

fragment
DecimalEscape: '\\' Digit
    | '\\' Digit Digit
    | '\\' [0-2] Digit Digit;

fragment
HexEscape: '\\' 'x' HexDigit HexDigit;

fragment
UtfEscape: '\\' 'u{' HexDigit+ '}';

fragment
Digit: [0-9];

fragment
HexDigit: [0-9a-fA-F];

COMMENT: '--[' NESTED_STR ']' -> channel(HIDDEN); // --[=[...]=]

LINE_COMMENT
    : '--'
    (                                               // --
    | '[' '='*                                      // --[==
    | '[' '='* ~('='|'['|'\r'|'\n') ~('\r'|'\n')*   // --[==AA
    | ~('['|'\r'|'\n') ~('\r'|'\n')*                // --AAA
    ) ('\r\n'|'\r'|'\n'|EOF)
    -> channel(HIDDEN);

WS: [ \t\u000C\r\n]+ -> skip;

SHEBANG: '#' '!' ~('\n'|'\r')* -> channel(HIDDEN);