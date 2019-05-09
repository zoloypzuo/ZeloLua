------------------------------
-- # assign global
a = nil
a1 = false
a2 = true

b = 1
b1 = 1.2

c = "lalala"

-- # assign local
local a=nil
local a1=false
local a2=true
local b=1
local b1=1.2
local c='lalala'

-- expression operation
local g=#{1,2}
local h = 1 * 2
local i = 1 + 2
local j = "1" + "2"
local k = 1 == 2
local l = true and false

-- func def, call
function add(a, b)
    return a + b
end
local p = add(1, 2)

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 15 stacks
.function  0 0 2 15
.local  "a"  ; 0
.local  "a1"  ; 1
.local  "a2"  ; 2
.local  "b"  ; 3
.local  "b1"  ; 4
.local  "c"  ; 5
.local  "g"  ; 6
.local  "h"  ; 7
.local  "i"  ; 8
.local  "j"  ; 9
.local  "k"  ; 10
.local  "l"  ; 11
.local  "p"  ; 12
.const  "a"  ; 0
.const  "a1"  ; 1
.const  "a2"  ; 2
.const  "b"  ; 3
.const  1  ; 4
.const  "b1"  ; 5
.const  1.2  ; 6
.const  "c"  ; 7
.const  "lalala"  ; 8
.const  2  ; 9
.const  3  ; 10
.const  "1"  ; 11
.const  "2"  ; 12
.const  "add"  ; 13
[01] setglobal  0   0        ; a := R0 -- should have a loadnil, but, so it is an error, but R0 maybe inited as nil
[02] loadbool   0   0   0    ; R0 := false
[03] setglobal  0   1        ; a1 := R0
[04] loadbool   0   1   0    ; R0 := true
[05] setglobal  0   2        ; a2 := R0
[06] loadk      0   4        ; R0 := 1
[07] setglobal  0   3        ; b := R0
[08] loadk      0   6        ; R0 := 1.2
[09] setglobal  0   5        ; b1 := R0
[10] loadk      0   8        ; R0 := "lalala"
[11] setglobal  0   7        ; c := R0
[12] loadnil    0   0        ; R0,  := nil
[13] loadbool   1   0   0    ; R1 := false
[14] loadbool   2   1   0    ; R2 := true
[15] loadk      3   4        ; R3 := 1
[16] loadk      4   6        ; R4 := 1.2
[17] loadk      5   8        ; R5 := "lalala"
[18] newtable   6   2   0    ; R6 := {} , array=2, hash=0
[19] loadk      7   4        ; R7 := 1
[20] loadk      8   9        ; R8 := 2
[21] setlist    6   2   1    ; R6[1 to 2] := R7 to R8
[22] len        6   6        ; R6 := #R6
[23] loadk      7   9        ; R7 := 2
[24] loadk      8   10       ; R8 := 3
[25] add        9   267 268  ; R9 := "1" + "2"
[26] eq         1   260 265  ; 1 == 2, pc+=1 (goto [28]) if false
[27] jmp        1            ; pc+=1 (goto [29])
[28] loadbool   10  0   1    ; R10 := false; PC := pc+=1 (goto [30])
[29] loadbool   10  1   0    ; R10 := true
[30] loadbool   11  0   0    ; R11 := false
[31] closure    12  0        ; R12 := closure(function[0]) 0 upvalues
[32] setglobal  12  13       ; add := R12
[33] getglobal  12  13       ; R12 := add
[34] loadk      13  4        ; R13 := 1
[35] loadk      14  9        ; R14 := 2
[36] call       12  3   2    ; R12 := R12(R13, R14)
[37] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "a"  ; 0
.local  "b"  ; 1
[1] add        2   0   1    ; R2 := R0 + R1
[2] return     2   2        ; return R2
[3] return     0   1        ; return 
; end of function 0_0

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
0026  0F                 maxstacksize (15)
                         * code:
0027  25000000           sizecode (37)
002B  07000000           [01] setglobal  0   0        ; a := R0   -- 07000000 is 07 00 00 00 => 00 00 00 07 => 7 (unsigned int/ true form) 
002F  02000000           [02] loadbool   0   0   0    ; R0 := false
0033  07400000           [03] setglobal  0   1        ; a1 := R0
0037  02008000           [04] loadbool   0   1   0    ; R0 := true
003B  07800000           [05] setglobal  0   2        ; a2 := R0
003F  01000100           [06] loadk      0   4        ; R0 := 1
0043  07C00000           [07] setglobal  0   3        ; b := R0
0047  01800100           [08] loadk      0   6        ; R0 := 1.2
004B  07400100           [09] setglobal  0   5        ; b1 := R0
004F  01000200           [10] loadk      0   8        ; R0 := "lalala"
0053  07C00100           [11] setglobal  0   7        ; c := R0
0057  03000000           [12] loadnil    0   0        ; R0,  := nil
005B  42000000           [13] loadbool   1   0   0    ; R1 := false
005F  82008000           [14] loadbool   2   1   0    ; R2 := true
0063  C1000100           [15] loadk      3   4        ; R3 := 1
0067  01810100           [16] loadk      4   6        ; R4 := 1.2
006B  41010200           [17] loadk      5   8        ; R5 := "lalala"
006F  8A010001           [18] newtable   6   2   0    ; R6 := {} , array=2, hash=0
0073  C1010100           [19] loadk      7   4        ; R7 := 1
0077  01420200           [20] loadk      8   9        ; R8 := 2
007B  A2410001           [21] setlist    6   2   1    ; R6[1 to 2] := R7 to R8
007F  94010003           [22] len        6   6        ; R6 := #R6
0083  C1410200           [23] loadk      7   9        ; R7 := 2
0087  01820200           [24] loadk      8   10       ; R8 := 3
008B  4C02C385           [25] add        9   267 268  ; R9 := "1" + "2"
008F  57404282           [26] eq         1   260 265  ; 1 == 2, pc+=1 (goto [28]) if false
0093  16000080           [27] jmp        1            ; pc+=1 (goto [29])
0097  82420000           [28] loadbool   10  0   1    ; R10 := false; PC := pc+=1 (goto [30])
009B  82028000           [29] loadbool   10  1   0    ; R10 := true
009F  C2020000           [30] loadbool   11  0   0    ; R11 := false
00A3  24030000           [31] closure    12  0        ; R12 := closure(function[0]) 0 upvalues
00A7  07430300           [32] setglobal  12  13       ; add := R12
00AB  05430300           [33] getglobal  12  13       ; R12 := add
00AF  41030100           [34] loadk      13  4        ; R13 := 1
00B3  81430200           [35] loadk      14  9        ; R14 := 2
00B7  1C838001           [36] call       12  3   2    ; R12 := R12(R13, R14)
00BB  1E008000           [37] return     0   1        ; return 
                         * constants:
00BF  0E000000           sizek (14)
00C3  04                 const type 4
00C4  02000000           string size (2)
00C8  6100               "a\0"
                         const [0]: "a"
00CA  04                 const type 4
00CB  03000000           string size (3)
00CF  613100             "a1\0"
                         const [1]: "a1"
00D2  04                 const type 4
00D3  03000000           string size (3)
00D7  613200             "a2\0"
                         const [2]: "a2"
00DA  04                 const type 4
00DB  02000000           string size (2)
00DF  6200               "b\0"
                         const [3]: "b"
00E1  03                 const type 3
00E2  000000000000F03F   const [4]: (1)
00EA  04                 const type 4
00EB  03000000           string size (3)
00EF  623100             "b1\0"
                         const [5]: "b1"
00F2  03                 const type 3
00F3  333333333333F33F   const [6]: (1.2)
00FB  04                 const type 4
00FC  02000000           string size (2)
0100  6300               "c\0"
                         const [7]: "c"
0102  04                 const type 4
0103  07000000           string size (7)
0107  6C616C616C6100     "lalala\0"
                         const [8]: "lalala"
010E  03                 const type 3
010F  0000000000000040   const [9]: (2)
0117  03                 const type 3
0118  0000000000000840   const [10]: (3)
0120  04                 const type 4
0121  02000000           string size (2)
0125  3100               "1\0"
                         const [11]: "1"
0127  04                 const type 4
0128  02000000           string size (2)
012C  3200               "2\0"
                         const [12]: "2"
012E  04                 const type 4
012F  04000000           string size (4)
0133  61646400           "add\0"
                         const [13]: "add"
                         * functions:
0137  01000000           sizep (1)
                         
013B                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
013B  00000000           string size (0)
                         source name: (none)
013F  1C000000           line defined (28)
0143  1E000000           last line defined (30)
0147  00                 nups (0)
0148  02                 numparams (2)
0149  00                 is_vararg (0)
014A  03                 maxstacksize (3)
                         * code:
014B  03000000           sizecode (3)
014F  8C400000           [1] add        2   0   1    ; R2 := R0 + R1
0153  9E000001           [2] return     2   2        ; return R2
0157  1E008000           [3] return     0   1        ; return 
                         * constants:
015B  00000000           sizek (0)
                         * functions:
015F  00000000           sizep (0)
                         * lines:
0163  03000000           sizelineinfo (3)
                         [pc] (line)
0167  1D000000           [1] (29)
016B  1D000000           [2] (29)
016F  1E000000           [3] (30)
                         * locals:
0173  02000000           sizelocvars (2)
0177  02000000           string size (2)
017B  6100               "a\0"
                         local [0]: a
017D  00000000             startpc (0)
0181  02000000             endpc   (2)
0185  02000000           string size (2)
0189  6200               "b\0"
                         local [1]: b
018B  00000000             startpc (0)
018F  02000000             endpc   (2)
                         * upvalues:
0193  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
0197  25000000           sizelineinfo (37)
                         [pc] (line)
019B  02000000           [01] (2)
019F  03000000           [02] (3)
01A3  03000000           [03] (3)
01A7  04000000           [04] (4)
01AB  04000000           [05] (4)
01AF  06000000           [06] (6)
01B3  06000000           [07] (6)
01B7  07000000           [08] (7)
01BB  07000000           [09] (7)
01BF  09000000           [10] (9)
01C3  09000000           [11] (9)
01C7  0C000000           [12] (12)
01CB  0D000000           [13] (13)
01CF  0E000000           [14] (14)
01D3  0F000000           [15] (15)
01D7  10000000           [16] (16)
01DB  11000000           [17] (17)
01DF  14000000           [18] (20)
01E3  14000000           [19] (20)
01E7  14000000           [20] (20)
01EB  14000000           [21] (20)
01EF  14000000           [22] (20)
01F3  15000000           [23] (21)
01F7  16000000           [24] (22)
01FB  17000000           [25] (23)
01FF  18000000           [26] (24)
0203  18000000           [27] (24)
0207  18000000           [28] (24)
020B  18000000           [29] (24)
020F  19000000           [30] (25)
0213  1E000000           [31] (30)
0217  1C000000           [32] (28)
021B  1F000000           [33] (31)
021F  1F000000           [34] (31)
0223  1F000000           [35] (31)
0227  1F000000           [36] (31)
022B  1F000000           [37] (31)
                         * locals:
022F  0D000000           sizelocvars (13)
0233  02000000           string size (2)
0237  6100               "a\0"
                         local [0]: a
0239  0C000000             startpc (12)
023D  24000000             endpc   (36)
0241  03000000           string size (3)
0245  613100             "a1\0"
                         local [1]: a1
0248  0D000000             startpc (13)
024C  24000000             endpc   (36)
0250  03000000           string size (3)
0254  613200             "a2\0"
                         local [2]: a2
0257  0E000000             startpc (14)
025B  24000000             endpc   (36)
025F  02000000           string size (2)
0263  6200               "b\0"
                         local [3]: b
0265  0F000000             startpc (15)
0269  24000000             endpc   (36)
026D  03000000           string size (3)
0271  623100             "b1\0"
                         local [4]: b1
0274  10000000             startpc (16)
0278  24000000             endpc   (36)
027C  02000000           string size (2)
0280  6300               "c\0"
                         local [5]: c
0282  11000000             startpc (17)
0286  24000000             endpc   (36)
028A  02000000           string size (2)
028E  6700               "g\0"
                         local [6]: g
0290  16000000             startpc (22)
0294  24000000             endpc   (36)
0298  02000000           string size (2)
029C  6800               "h\0"
                         local [7]: h
029E  17000000             startpc (23)
02A2  24000000             endpc   (36)
02A6  02000000           string size (2)
02AA  6900               "i\0"
                         local [8]: i
02AC  18000000             startpc (24)
02B0  24000000             endpc   (36)
02B4  02000000           string size (2)
02B8  6A00               "j\0"
                         local [9]: j
02BA  19000000             startpc (25)
02BE  24000000             endpc   (36)
02C2  02000000           string size (2)
02C6  6B00               "k\0"
                         local [10]: k
02C8  1D000000             startpc (29)
02CC  24000000             endpc   (36)
02D0  02000000           string size (2)
02D4  6C00               "l\0"
                         local [11]: l
02D6  1E000000             startpc (30)
02DA  24000000             endpc   (36)
02DE  02000000           string size (2)
02E2  7000               "p\0"
                         local [12]: p
02E4  24000000             startpc (36)
02E8  24000000             endpc   (36)
                         * upvalues:
02EC  00000000           sizeupvalues (0)
                         ** end of function 0 **

02F0                     ** end of chunk **
