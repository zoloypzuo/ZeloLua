------------------------------
local a = 1
a=1+(2+(3+a))
local b,c=(4+a)+(5+a),(a+b)+(a+b)

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
.const  "b"  ; 5
[01] loadk      0   0        ; R0 := 1
[02] add        1   257 0    ; R1 := 3 + R0
[03] add        1   258 1    ; R1 := 2 + R1
[04] add        0   256 1    ; R0 := 1 + R1
[05] add        1   259 0    ; R1 := 4 + R0
[06] add        2   260 0    ; R2 := 5 + R0
[07] add        1   1   2    ; R1 := R1 + R2
[08] getglobal  2   5        ; R2 := b
[09] add        2   0   2    ; R2 := R0 + R2
[10] getglobal  3   5        ; R3 := b
[11] add        3   0   3    ; R3 := R0 + R3
[12] add        2   2   3    ; R2 := R2 + R3
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
0026  04                 maxstacksize (4)
                         * code:
0027  0D000000           sizecode (13)
002B  01000000           [01] loadk      0   0        ; R0 := 1
002F  4C008080           [02] add        1   257 0    ; R1 := 3 + R0
0033  4C400081           [03] add        1   258 1    ; R1 := 2 + R1
0037  0C400080           [04] add        0   256 1    ; R0 := 1 + R1
003B  4C008081           [05] add        1   259 0    ; R1 := 4 + R0
003F  8C000082           [06] add        2   260 0    ; R2 := 5 + R0
0043  4C808000           [07] add        1   1   2    ; R1 := R1 + R2
0047  85400100           [08] getglobal  2   5        ; R2 := b
004B  8C800000           [09] add        2   0   2    ; R2 := R0 + R2
004F  C5400100           [10] getglobal  3   5        ; R3 := b
0053  CCC00000           [11] add        3   0   3    ; R3 := R0 + R3
0057  8CC00001           [12] add        2   2   3    ; R2 := R2 + R3
005B  1E008000           [13] return     0   1        ; return 
                         * constants:
005F  06000000           sizek (6)
0063  03                 const type 3
0064  000000000000F03F   const [0]: (1)
006C  03                 const type 3
006D  0000000000000840   const [1]: (3)
0075  03                 const type 3
0076  0000000000000040   const [2]: (2)
007E  03                 const type 3
007F  0000000000001040   const [3]: (4)
0087  03                 const type 3
0088  0000000000001440   const [4]: (5)
0090  04                 const type 4
0091  02000000           string size (2)
0095  6200               "b\0"
                         const [5]: "b"
                         * functions:
0097  00000000           sizep (0)
                         * lines:
009B  0D000000           sizelineinfo (13)
                         [pc] (line)
009F  01000000           [01] (1)
00A3  02000000           [02] (2)
00A7  02000000           [03] (2)
00AB  02000000           [04] (2)
00AF  03000000           [05] (3)
00B3  03000000           [06] (3)
00B7  03000000           [07] (3)
00BB  03000000           [08] (3)
00BF  03000000           [09] (3)
00C3  03000000           [10] (3)
00C7  03000000           [11] (3)
00CB  03000000           [12] (3)
00CF  03000000           [13] (3)
                         * locals:
00D3  03000000           sizelocvars (3)
00D7  02000000           string size (2)
00DB  6100               "a\0"
                         local [0]: a
00DD  01000000             startpc (1)
00E1  0C000000             endpc   (12)
00E5  02000000           string size (2)
00E9  6200               "b\0"
                         local [1]: b
00EB  0C000000             startpc (12)
00EF  0C000000             endpc   (12)
00F3  02000000           string size (2)
00F7  6300               "c\0"
                         local [2]: c
00F9  0C000000             startpc (12)
00FD  0C000000             endpc   (12)
                         * upvalues:
0101  00000000           sizeupvalues (0)
                         ** end of function 0 **

0105                     ** end of chunk **
