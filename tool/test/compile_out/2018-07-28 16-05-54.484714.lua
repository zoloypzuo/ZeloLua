------------------------------
-- # more test added on 2018.7.27
local a,b,c=nil,nil,nil --simple normal
local a,b,c=1,2,3  --normal
local d,e,f=4,5  --right side less than left side
local g,h,i=6,7,8,9,10 -- ...
local j,k --only declaration
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 14 stacks
.function  0 0 2 14
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "a"  ; 3
.local  "b"  ; 4
.local  "c"  ; 5
.local  "d"  ; 6
.local  "e"  ; 7
.local  "f"  ; 8
.local  "g"  ; 9
.local  "h"  ; 10
.local  "i"  ; 11
.local  "j"  ; 12
.local  "k"  ; 13
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  4  ; 3
.const  5  ; 4
.const  6  ; 5
.const  7  ; 6
.const  8  ; 7
.const  9  ; 8
.const  10  ; 9
[01] loadk      3   0        ; R3 := 1
[02] loadk      4   1        ; R4 := 2
[03] loadk      5   2        ; R5 := 3
[04] loadk      6   3        ; R6 := 4
[05] loadk      7   4        ; R7 := 5
[06] loadnil    8   8        ; R8,  := nil
[07] loadk      9   5        ; R9 := 6
[08] loadk      10  6        ; R10 := 7
[09] loadk      11  7        ; R11 := 8
[10] loadk      12  8        ; R12 := 9
[11] loadk      13  9        ; R13 := 10
[12] loadnil    12  13       ; R12, R13,  := nil
[13] return     0   1        ; return 
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
0026  0E                 maxstacksize (14)
                         * code:
0027  0D000000           sizecode (13)
002B  C1000000           [01] loadk      3   0        ; R3 := 1
002F  01410000           [02] loadk      4   1        ; R4 := 2
0033  41810000           [03] loadk      5   2        ; R5 := 3
0037  81C10000           [04] loadk      6   3        ; R6 := 4
003B  C1010100           [05] loadk      7   4        ; R7 := 5
003F  03020004           [06] loadnil    8   8        ; R8,  := nil
0043  41420100           [07] loadk      9   5        ; R9 := 6
0047  81820100           [08] loadk      10  6        ; R10 := 7
004B  C1C20100           [09] loadk      11  7        ; R11 := 8
004F  01030200           [10] loadk      12  8        ; R12 := 9
0053  41430200           [11] loadk      13  9        ; R13 := 10
0057  03038006           [12] loadnil    12  13       ; R12, R13,  := nil
005B  1E008000           [13] return     0   1        ; return 
                         * constants:
005F  0A000000           sizek (10)
0063  03                 const type 3
0064  000000000000F03F   const [0]: (1)
006C  03                 const type 3
006D  0000000000000040   const [1]: (2)
0075  03                 const type 3
0076  0000000000000840   const [2]: (3)
007E  03                 const type 3
007F  0000000000001040   const [3]: (4)
0087  03                 const type 3
0088  0000000000001440   const [4]: (5)
0090  03                 const type 3
0091  0000000000001840   const [5]: (6)
0099  03                 const type 3
009A  0000000000001C40   const [6]: (7)
00A2  03                 const type 3
00A3  0000000000002040   const [7]: (8)
00AB  03                 const type 3
00AC  0000000000002240   const [8]: (9)
00B4  03                 const type 3
00B5  0000000000002440   const [9]: (10)
                         * functions:
00BD  00000000           sizep (0)
                         * lines:
00C1  0D000000           sizelineinfo (13)
                         [pc] (line)
00C5  03000000           [01] (3)
00C9  03000000           [02] (3)
00CD  03000000           [03] (3)
00D1  04000000           [04] (4)
00D5  04000000           [05] (4)
00D9  04000000           [06] (4)
00DD  05000000           [07] (5)
00E1  05000000           [08] (5)
00E5  05000000           [09] (5)
00E9  05000000           [10] (5)
00ED  05000000           [11] (5)
00F1  06000000           [12] (6)
00F5  06000000           [13] (6)
                         * locals:
00F9  0E000000           sizelocvars (14)
00FD  02000000           string size (2)
0101  6100               "a\0"
                         local [0]: a
0103  00000000             startpc (0)
0107  0C000000             endpc   (12)
010B  02000000           string size (2)
010F  6200               "b\0"
                         local [1]: b
0111  00000000             startpc (0)
0115  0C000000             endpc   (12)
0119  02000000           string size (2)
011D  6300               "c\0"
                         local [2]: c
011F  00000000             startpc (0)
0123  0C000000             endpc   (12)
0127  02000000           string size (2)
012B  6100               "a\0"
                         local [3]: a
012D  03000000             startpc (3)
0131  0C000000             endpc   (12)
0135  02000000           string size (2)
0139  6200               "b\0"
                         local [4]: b
013B  03000000             startpc (3)
013F  0C000000             endpc   (12)
0143  02000000           string size (2)
0147  6300               "c\0"
                         local [5]: c
0149  03000000             startpc (3)
014D  0C000000             endpc   (12)
0151  02000000           string size (2)
0155  6400               "d\0"
                         local [6]: d
0157  06000000             startpc (6)
015B  0C000000             endpc   (12)
015F  02000000           string size (2)
0163  6500               "e\0"
                         local [7]: e
0165  06000000             startpc (6)
0169  0C000000             endpc   (12)
016D  02000000           string size (2)
0171  6600               "f\0"
                         local [8]: f
0173  06000000             startpc (6)
0177  0C000000             endpc   (12)
017B  02000000           string size (2)
017F  6700               "g\0"
                         local [9]: g
0181  0B000000             startpc (11)
0185  0C000000             endpc   (12)
0189  02000000           string size (2)
018D  6800               "h\0"
                         local [10]: h
018F  0B000000             startpc (11)
0193  0C000000             endpc   (12)
0197  02000000           string size (2)
019B  6900               "i\0"
                         local [11]: i
019D  0B000000             startpc (11)
01A1  0C000000             endpc   (12)
01A5  02000000           string size (2)
01A9  6A00               "j\0"
                         local [12]: j
01AB  0C000000             startpc (12)
01AF  0C000000             endpc   (12)
01B3  02000000           string size (2)
01B7  6B00               "k\0"
                         local [13]: k
01B9  0C000000             startpc (12)
01BD  0C000000             endpc   (12)
                         * upvalues:
01C1  00000000           sizeupvalues (0)
                         ** end of function 0 **

01C5                     ** end of chunk **
