------------------------------
local a,b,c,d
do
	local e,f,g
end
local h,i,j
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 7 stacks
.function  0 0 2 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "d"  ; 3
.local  "e"  ; 4
.local  "f"  ; 5
.local  "g"  ; 6
.local  "h"  ; 7
.local  "i"  ; 8
.local  "j"  ; 9
[1] loadnil    4   6        ; R4, R5, R6,  := nil
[2] return     0   1        ; return 
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
0026  07                 maxstacksize (7)
                         * code:
0027  02000000           sizecode (2)
002B  03010003           [1] loadnil    4   6        ; R4, R5, R6,  := nil
002F  1E008000           [2] return     0   1        ; return 
                         * constants:
0033  00000000           sizek (0)
                         * functions:
0037  00000000           sizep (0)
                         * lines:
003B  02000000           sizelineinfo (2)
                         [pc] (line)
003F  05000000           [1] (5)
0043  05000000           [2] (5)
                         * locals:
0047  0A000000           sizelocvars (10)
004B  02000000           string size (2)
004F  6100               "a\0"
                         local [0]: a
0051  00000000             startpc (0)
0055  01000000             endpc   (1)
0059  02000000           string size (2)
005D  6200               "b\0"
                         local [1]: b
005F  00000000             startpc (0)
0063  01000000             endpc   (1)
0067  02000000           string size (2)
006B  6300               "c\0"
                         local [2]: c
006D  00000000             startpc (0)
0071  01000000             endpc   (1)
0075  02000000           string size (2)
0079  6400               "d\0"
                         local [3]: d
007B  00000000             startpc (0)
007F  01000000             endpc   (1)
0083  02000000           string size (2)
0087  6500               "e\0"
                         local [4]: e
0089  00000000             startpc (0)
008D  00000000             endpc   (0)
0091  02000000           string size (2)
0095  6600               "f\0"
                         local [5]: f
0097  00000000             startpc (0)
009B  00000000             endpc   (0)
009F  02000000           string size (2)
00A3  6700               "g\0"
                         local [6]: g
00A5  00000000             startpc (0)
00A9  00000000             endpc   (0)
00AD  02000000           string size (2)
00B1  6800               "h\0"
                         local [7]: h
00B3  01000000             startpc (1)
00B7  01000000             endpc   (1)
00BB  02000000           string size (2)
00BF  6900               "i\0"
                         local [8]: i
00C1  01000000             startpc (1)
00C5  01000000             endpc   (1)
00C9  02000000           string size (2)
00CD  6A00               "j\0"
                         local [9]: j
00CF  01000000             startpc (1)
00D3  01000000             endpc   (1)
                         * upvalues:
00D7  00000000           sizeupvalues (0)
                         ** end of function 0 **

00DB                     ** end of chunk **
