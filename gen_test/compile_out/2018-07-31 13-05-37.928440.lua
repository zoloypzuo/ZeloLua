------------------------------
local a,f1,f2,f3,f4
if a>1 then
	f1()
elseif a<0 then
	f2()
elseif a>0 and a<0.5 then
	f3()
else
	f4()
end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "a"  ; 0
.local  "f1"  ; 1
.local  "f2"  ; 2
.local  "f3"  ; 3
.local  "f4"  ; 4
.const  1  ; 0
.const  0  ; 1
.const  0.5  ; 2
[01] lt         0   256 0    ; 1 < R0, pc+=1 (goto [3]) if true
[02] jmp        3            ; pc+=3 (goto [6])
[03] move       5   1        ; R5 := R1
[04] call       5   1   1    ;  := R5()
[05] jmp        14           ; pc+=14 (goto [20])
[06] lt         0   0   257  ; R0 < 0, pc+=1 (goto [8]) if true
[07] jmp        3            ; pc+=3 (goto [11])
[08] move       5   2        ; R5 := R2
[09] call       5   1   1    ;  := R5()
[10] jmp        9            ; pc+=9 (goto [20])
[11] lt         0   257 0    ; 0 < R0, pc+=1 (goto [13]) if true
[12] jmp        5            ; pc+=5 (goto [18])
[13] lt         0   0   258  ; R0 < 0.5, pc+=1 (goto [15]) if true
[14] jmp        3            ; pc+=3 (goto [18])
[15] move       5   3        ; R5 := R3
[16] call       5   1   1    ;  := R5()
[17] jmp        2            ; pc+=2 (goto [20])
[18] move       5   4        ; R5 := R4
[19] call       5   1   1    ;  := R5()
[20] return     0   1        ; return 
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
0026  06                 maxstacksize (6)
                         * code:
0027  14000000           sizecode (20)
002B  18000080           [01] lt         0   256 0    ; 1 < R0, pc+=1 (goto [3]) if true
002F  16800080           [02] jmp        3            ; pc+=3 (goto [6])
0033  40018000           [03] move       5   1        ; R5 := R1
0037  5C418000           [04] call       5   1   1    ;  := R5()
003B  16400380           [05] jmp        14           ; pc+=14 (goto [20])
003F  18404000           [06] lt         0   0   257  ; R0 < 0, pc+=1 (goto [8]) if true
0043  16800080           [07] jmp        3            ; pc+=3 (goto [11])
0047  40010001           [08] move       5   2        ; R5 := R2
004B  5C418000           [09] call       5   1   1    ;  := R5()
004F  16000280           [10] jmp        9            ; pc+=9 (goto [20])
0053  18008080           [11] lt         0   257 0    ; 0 < R0, pc+=1 (goto [13]) if true
0057  16000180           [12] jmp        5            ; pc+=5 (goto [18])
005B  18804000           [13] lt         0   0   258  ; R0 < 0.5, pc+=1 (goto [15]) if true
005F  16800080           [14] jmp        3            ; pc+=3 (goto [18])
0063  40018001           [15] move       5   3        ; R5 := R3
0067  5C418000           [16] call       5   1   1    ;  := R5()
006B  16400080           [17] jmp        2            ; pc+=2 (goto [20])
006F  40010002           [18] move       5   4        ; R5 := R4
0073  5C418000           [19] call       5   1   1    ;  := R5()
0077  1E008000           [20] return     0   1        ; return 
                         * constants:
007B  03000000           sizek (3)
007F  03                 const type 3
0080  000000000000F03F   const [0]: (1)
0088  03                 const type 3
0089  0000000000000000   const [1]: (0)
0091  03                 const type 3
0092  000000000000E03F   const [2]: (0.5)
                         * functions:
009A  00000000           sizep (0)
                         * lines:
009E  14000000           sizelineinfo (20)
                         [pc] (line)
00A2  02000000           [01] (2)
00A6  02000000           [02] (2)
00AA  03000000           [03] (3)
00AE  03000000           [04] (3)
00B2  03000000           [05] (3)
00B6  04000000           [06] (4)
00BA  04000000           [07] (4)
00BE  05000000           [08] (5)
00C2  05000000           [09] (5)
00C6  05000000           [10] (5)
00CA  06000000           [11] (6)
00CE  06000000           [12] (6)
00D2  06000000           [13] (6)
00D6  06000000           [14] (6)
00DA  07000000           [15] (7)
00DE  07000000           [16] (7)
00E2  07000000           [17] (7)
00E6  09000000           [18] (9)
00EA  09000000           [19] (9)
00EE  0A000000           [20] (10)
                         * locals:
00F2  05000000           sizelocvars (5)
00F6  02000000           string size (2)
00FA  6100               "a\0"
                         local [0]: a
00FC  00000000             startpc (0)
0100  13000000             endpc   (19)
0104  03000000           string size (3)
0108  663100             "f1\0"
                         local [1]: f1
010B  00000000             startpc (0)
010F  13000000             endpc   (19)
0113  03000000           string size (3)
0117  663200             "f2\0"
                         local [2]: f2
011A  00000000             startpc (0)
011E  13000000             endpc   (19)
0122  03000000           string size (3)
0126  663300             "f3\0"
                         local [3]: f3
0129  00000000             startpc (0)
012D  13000000             endpc   (19)
0131  03000000           string size (3)
0135  663400             "f4\0"
                         local [4]: f4
0138  00000000             startpc (0)
013C  13000000             endpc   (19)
                         * upvalues:
0140  00000000           sizeupvalues (0)
                         ** end of function 0 **

0144                     ** end of chunk **
