------------------------------
function hello()
     function in_hello()
          print('hello')
     end
end

function t()
     print('test')
end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "hello"  ; 0
.const  "t"  ; 1
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; hello := R0
[3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[4] setglobal  0   1        ; t := R0
[5] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; in_hello := R0
[3] return     0   1        ; return 
.const  "in_hello"  ; 0

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "hello"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "hello"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "test"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "test"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_1

; end of function 0


------------------------------
Pos   Hex Data           Description or Code
------------------------------------------------------------------------
0000                     ** source chunk: luac.out
                         ** global header start **
0000  1B4C7561           header signature: "\27Lua"
0004  51                 version (major:minor hex digits)
0005  00                 format (0=official)
0006  01                 endianness (1=little endian)
0007  04                 size of int (bytes)
0008  04                 size of size_t (bytes)
0009  04                 size of Instruction (bytes)
000A  08                 size of number (bytes)
000B  00                 integral (1=integral)
                         * number type: double
                         * x86 standard (32-bit, little endian, doubles)
                         ** global header end **
                         
000C                     ** function [0] definition (level 1) 0
                         ** start of function 0 **
000C  0B000000           string size (11)
0010  406C6561726E2E6C+  "@learn.l"
0018  756100             "ua\0"
                         source name: @learn.lua
001B  00000000           line defined (0)
001F  00000000           last line defined (0)
0023  00                 nups (0)
0024  00                 numparams (0)
0025  02                 is_vararg (2)
0026  02                 maxstacksize (2)
                         * code:
0027  05000000           sizecode (5)
002B  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
002F  07000000           [2] setglobal  0   0        ; hello := R0
0033  24400000           [3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
0037  07400000           [4] setglobal  0   1        ; t := R0
003B  1E008000           [5] return     0   1        ; return 
                         * constants:
003F  02000000           sizek (2)
0043  04                 const type 4
0044  06000000           string size (6)
0048  68656C6C6F00       "hello\0"
                         const [0]: "hello"
004E  04                 const type 4
004F  02000000           string size (2)
0053  7400               "t\0"
                         const [1]: "t"
                         * functions:
0055  02000000           sizep (2)
                         
0059                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0059  00000000           string size (0)
                         source name: (none)
005D  01000000           line defined (1)
0061  05000000           last line defined (5)
0065  00                 nups (0)
0066  00                 numparams (0)
0067  00                 is_vararg (0)
0068  02                 maxstacksize (2)
                         * code:
0069  03000000           sizecode (3)
006D  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0071  07000000           [2] setglobal  0   0        ; in_hello := R0
0075  1E008000           [3] return     0   1        ; return 
                         * constants:
0079  01000000           sizek (1)
007D  04                 const type 4
007E  09000000           string size (9)
0082  696E5F68656C6C6F+  "in_hello"
008A  00                 "\0"
                         const [0]: "in_hello"
                         * functions:
008B  01000000           sizep (1)
                         
008F                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
008F  00000000           string size (0)
                         source name: (none)
0093  02000000           line defined (2)
0097  04000000           last line defined (4)
009B  00                 nups (0)
009C  00                 numparams (0)
009D  00                 is_vararg (0)
009E  02                 maxstacksize (2)
                         * code:
009F  04000000           sizecode (4)
00A3  05000000           [1] getglobal  0   0        ; R0 := print
00A7  41400000           [2] loadk      1   1        ; R1 := "hello"
00AB  1C400001           [3] call       0   2   1    ;  := R0(R1)
00AF  1E008000           [4] return     0   1        ; return 
                         * constants:
00B3  02000000           sizek (2)
00B7  04                 const type 4
00B8  06000000           string size (6)
00BC  7072696E7400       "print\0"
                         const [0]: "print"
00C2  04                 const type 4
00C3  06000000           string size (6)
00C7  68656C6C6F00       "hello\0"
                         const [1]: "hello"
                         * functions:
00CD  00000000           sizep (0)
                         * lines:
00D1  04000000           sizelineinfo (4)
                         [pc] (line)
00D5  03000000           [1] (3)
00D9  03000000           [2] (3)
00DD  03000000           [3] (3)
00E1  04000000           [4] (4)
                         * locals:
00E5  00000000           sizelocvars (0)
                         * upvalues:
00E9  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
00ED  03000000           sizelineinfo (3)
                         [pc] (line)
00F1  04000000           [1] (4)
00F5  02000000           [2] (2)
00F9  05000000           [3] (5)
                         * locals:
00FD  00000000           sizelocvars (0)
                         * upvalues:
0101  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0105                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0105  00000000           string size (0)
                         source name: (none)
0109  07000000           line defined (7)
010D  09000000           last line defined (9)
0111  00                 nups (0)
0112  00                 numparams (0)
0113  00                 is_vararg (0)
0114  02                 maxstacksize (2)
                         * code:
0115  04000000           sizecode (4)
0119  05000000           [1] getglobal  0   0        ; R0 := print
011D  41400000           [2] loadk      1   1        ; R1 := "test"
0121  1C400001           [3] call       0   2   1    ;  := R0(R1)
0125  1E008000           [4] return     0   1        ; return 
                         * constants:
0129  02000000           sizek (2)
012D  04                 const type 4
012E  06000000           string size (6)
0132  7072696E7400       "print\0"
                         const [0]: "print"
0138  04                 const type 4
0139  05000000           string size (5)
013D  7465737400         "test\0"
                         const [1]: "test"
                         * functions:
0142  00000000           sizep (0)
                         * lines:
0146  04000000           sizelineinfo (4)
                         [pc] (line)
014A  08000000           [1] (8)
014E  08000000           [2] (8)
0152  08000000           [3] (8)
0156  09000000           [4] (9)
                         * locals:
015A  00000000           sizelocvars (0)
                         * upvalues:
015E  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
0162  05000000           sizelineinfo (5)
                         [pc] (line)
0166  05000000           [1] (5)
016A  01000000           [2] (1)
016E  09000000           [3] (9)
0172  07000000           [4] (7)
0176  09000000           [5] (9)
                         * locals:
017A  00000000           sizelocvars (0)
                         * upvalues:
017E  00000000           sizeupvalues (0)
                         ** end of function 0 **

0182                     ** end of chunk **
