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

chunk
    : block EOF
    ;

block
    : stat* retstat?
    ;

stat
    : ';' #emptyStat
    | varlist '=' explist #assignStat
    | functioncall #functioncallStat
    | 'break' #breakStat
    | 'do' block 'end' #doendStat
    | 'while' exp 'do' block 'end' #whileStat
    | 'repeat' block 'until' exp #repeatStat
    | 'if' exp 'then' block (elseif='elseif' exp 'then' block)* (else='else' block)? 'end' #ifelseStat
    | 'for' NAME '=' exp ',' exp (',' exp)? 'do' block 'end' #forijkStat
    | 'for' namelist 'in' explist 'do' block 'end' #forinStat
    | 'function' funcname funcbody #functiondefStat
    | 'local' 'function' NAME funcbody #localfunctiondefStat
    | 'local' namelist ('=' explist)? #localassignStat
    ;

retstat
    : 'return' explist? ';'? 
    ;

funcname
    : NAME ('.' NAME)* (':' NAME)?  //任意多次查表得到对象，然后调用方法
    ;

varlist
    : var (',' var)*
    ;

namelist
    : NAME (',' NAME)*
    ;

explist
    : exp (',' exp)*
    ;

exp
    : nilfalsetruevararg #nilfalsetruevarargExp 
    | number #numberExp
    | string #stringExp
    | functiondef #functiondefExp
    | prefixexp #prefixexpExp
    | tableconstructor #tablectorExp
    | <assoc=right> exp operatorPower exp #powExp
    | operatorUnary exp #unmExp
    | exp operatorMulDivMod exp #muldivExp
    | exp operatorAddSub exp #addsubExp
    | <assoc=right> exp operatorStrcat exp #concatExp
    | exp operatorComparison exp #cmpExp
    | exp operatorAnd exp #andExp
    | exp operatorOr exp #orExp
    | exp operatorBitwise exp #bitwiseExp
    ;

nilfalsetruevararg: 'nil'|'false'|'true'|'...';

prefixexp //exp，var或带括号的exp，并且，可以带args，此时变为函数调用exp
    : varOrExp nameAndArgs*
    ;

functioncall
    : varOrExp nameAndArgs+
    ;

varOrExp
    : var | '(' exp ')'  //其实还是exp，左值也要返回右值的
    ;

var
    : (NAME | '(' exp ')' varSuffix) varSuffix* 
    ;

varSuffix
    : nameAndArgs* ('[' exp ']' | '.' NAME)
    ;

nameAndArgs
    : (':' NAME)? args  
    ;

args  //arg list，一般的或一个表ctor或一个string
    : '(' explist? ')'  #normalArgs
	| tableconstructor #tablectorArgs
	| string  #stringArgs
    ;

functiondef
    : 'function' funcbody  //定义函数
    ;

funcbody
    : '(' parlist? ')' block 'end'
    ;

parlist
    : namelist (',' '...')? | '...'  //param list，一堆param后vararg或单独vararg
    ;

tableconstructor
    : '{' fieldlist? '}'
    ;

fieldlist
    : field (fieldsep field)* fieldsep?
    ;

field
    : '[' exp ']' '=' exp | NAME '=' exp | exp  //表ctor的字段初始化
    ;

fieldsep
    : ',' | ';'  //表ctor的字段分隔符
    ;

operatorOr 
    : 'or';

operatorAnd 
    : 'and';

operatorComparison 
    : '<' | '>' | '<=' | '>=' | '~=' | '==';

operatorStrcat
    : '..';

operatorAddSub
    : '+' | '-';

operatorMulDivMod
    : '*' | '/' | '%' | '//';

operatorBitwise
    : '&' | '|' | '~' | '<<' | '>>';

operatorUnary
    : 'not' | '#' | '-' | '~';

operatorPower
    : '^';

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