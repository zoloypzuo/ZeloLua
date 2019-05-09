------------------------------
local a = 1
a=1+(2+(3+a))
local b=(4+a)+(5+a)
local c=(a+b)+(a+b)
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  1  ; 0
.const  3  ; 1
.const  2  ; 2
.const  4  ; 3
.const  5  ; 4
[01] loadk      0   0        ; R0 := 1
[02] add        1   257 0    ; R1 := 3 + R0
[03] add        1   258 1    ; R1 := 2 + R1
[04] add        0   256 1    ; R0 := 1 + R1
[05] add        1   259 0    ; R1 := 4 + R0
[06] add        2   260 0    ; R2 := 5 + R0
[07] add        1   1   2    ; R1 := R1 + R2
[08] add        2   0   1    ; R2 := R0 + R1
[09] add        3   0   1    ; R3 := R0 + R1
[10] add        2   2   3    ; R2 := R2 + R3
[11] return     0   1        ; return 
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
0026  04                 maxstacksize (4)
                         * code:
0027  0B000000           sizecode (11)
002B  01000000           [01] loadk      0   0        ; R0 := 1
002F  4C008080           [02] add        1   257 0    ; R1 := 3 + R0
0033  4C400081           [03] add        1   258 1    ; R1 := 2 + R1
0037  0C400080           [04] add        0   256 1    ; R0 := 1 + R1
003B  4C008081           [05] add        1   259 0    ; R1 := 4 + R0
003F  8C000082           [06] add        2   260 0    ; R2 := 5 + R0
0043  4C808000           [07] add        1   1   2    ; R1 := R1 + R2
0047  8C400000           [08] add        2   0   1    ; R2 := R0 + R1
004B  CC400000           [09] add        3   0   1    ; R3 := R0 + R1
004F  8CC00001           [10] add        2   2   3    ; R2 := R2 + R3
0053  1E008000           [11] return     0   1        ; return 
                         * constants:
0057  05000000           sizek (5)
005B  03                 const type 3
005C  000000000000F03F   const [0]: (1)
0064  03                 const type 3
0065  0000000000000840   const [1]: (3)
006D  03                 const type 3
006E  0000000000000040   const [2]: (2)
0076  03                 const type 3
0077  0000000000001040   const [3]: (4)
007F  03                 const type 3
0080  0000000000001440   const [4]: (5)
                         * functions:
0088  00000000           sizep (0)
                         * lines:
008C  0B000000           sizelineinfo (11)
                         [pc] (line)
0090  01000000           [01] (1)
0094  02000000           [02] (2)
0098  02000000           [03] (2)
009C  02000000           [04] (2)
00A0  03000000           [05] (3)
00A4  03000000           [06] (3)
00A8  03000000           [07] (3)
00AC  04000000           [08] (4)
00B0  04000000           [09] (4)
00B4  04000000           [10] (4)
00B8  04000000           [11] (4)
                         * locals:
00BC  03000000           sizelocvars (3)
00C0  02000000           string size (2)
00C4  6100               "a\0"
                         local [0]: a
00C6  01000000             startpc (1)
00CA  0A000000             endpc   (10)
00CE  02000000           string size (2)
00D2  6200               "b\0"
                         local [1]: b
00D4  07000000             startpc (7)
00D8  0A000000             endpc   (10)
00DC  02000000           string size (2)
00E0  6300               "c\0"
                         local [2]: c
00E2  0A000000             startpc (10)
00E6  0A000000             endpc   (10)
                         * upvalues:
00EA  00000000           sizeupvalues (0)
                         ** end of function 0 **

00EE                     ** end of chunk **
