------------------------------
local a = 1+2
local b=a+1
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "a"  ; 0
.local  "b"  ; 1
.const  3  ; 0
.const  1  ; 1
[1] loadk      0   0        ; R0 := 3
[2] add        1   0   257  ; R1 := R0 + 1
[3] return     0   1        ; return 
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
0027  03000000           sizecode (3)
002B  01000000           [1] loadk      0   0        ; R0 := 3
002F  4C404000           [2] add        1   0   257  ; R1 := R0 + 1
0033  1E008000           [3] return     0   1        ; return 
                         * constants:
0037  02000000           sizek (2)
003B  03                 const type 3
003C  0000000000000840   const [0]: (3)
0044  03                 const type 3
0045  000000000000F03F   const [1]: (1)
                         * functions:
004D  00000000           sizep (0)
                         * lines:
0051  03000000           sizelineinfo (3)
                         [pc] (line)
0055  01000000           [1] (1)
0059  02000000           [2] (2)
005D  02000000           [3] (2)
                         * locals:
0061  02000000           sizelocvars (2)
0065  02000000           string size (2)
0069  6100               "a\0"
                         local [0]: a
006B  01000000             startpc (1)
006F  02000000             endpc   (2)
0073  02000000           string size (2)
0077  6200               "b\0"
                         local [1]: b
0079  02000000             startpc (2)
007D  02000000             endpc   (2)
                         * upvalues:
0081  00000000           sizeupvalues (0)
                         ** end of function 0 **

0085                     ** end of chunk **
