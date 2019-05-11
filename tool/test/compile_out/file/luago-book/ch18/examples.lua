------------------------------
print(_VERSION)    --> Lua 5.3
print(_G._VERSION) --> Lua 5.3
print(_G)          --> 0x7fce7e402710
print(_G._G)       --> 0x7fce7e402710
print(print)       --> 0x1073e2b90
print(_G.print)    --> 0x1073e2b90

print(select(1, "a", "b", "c"))		--> a    b    c
print(select(2, "a", "b", "c"))		--> b    c
print(select(3, "a", "b", "c"))		--> c
print(select(-1, "a", "b", "c"))	--> c
print(select("#", "a", "b", "c"))	--> 3

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.const  "print"  ; 0
.const  "_VERSION"  ; 1
.const  "_G"  ; 2
.const  "select"  ; 3
.const  1  ; 4
.const  "a"  ; 5
.const  "b"  ; 6
.const  "c"  ; 7
.const  2  ; 8
.const  3  ; 9
.const  -1  ; 10
.const  "#"  ; 11
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := _VERSION
[03] call       0   2   1    ;  := R0(R1)
[04] getglobal  0   0        ; R0 := print
[05] getglobal  1   2        ; R1 := _G
[06] gettable   1   1   257  ; R1 := R1["_VERSION"]
[07] call       0   2   1    ;  := R0(R1)
[08] getglobal  0   0        ; R0 := print
[09] getglobal  1   2        ; R1 := _G
[10] call       0   2   1    ;  := R0(R1)
[11] getglobal  0   0        ; R0 := print
[12] getglobal  1   2        ; R1 := _G
[13] gettable   1   1   258  ; R1 := R1["_G"]
[14] call       0   2   1    ;  := R0(R1)
[15] getglobal  0   0        ; R0 := print
[16] getglobal  1   0        ; R1 := print
[17] call       0   2   1    ;  := R0(R1)
[18] getglobal  0   0        ; R0 := print
[19] getglobal  1   2        ; R1 := _G
[20] gettable   1   1   256  ; R1 := R1["print"]
[21] call       0   2   1    ;  := R0(R1)
[22] getglobal  0   0        ; R0 := print
[23] getglobal  1   3        ; R1 := select
[24] loadk      2   4        ; R2 := 1
[25] loadk      3   5        ; R3 := "a"
[26] loadk      4   6        ; R4 := "b"
[27] loadk      5   7        ; R5 := "c"
[28] call       1   5   0    ; R1 to top := R1(R2 to R5)
[29] call       0   0   1    ;  := R0(R1 to top)
[30] getglobal  0   0        ; R0 := print
[31] getglobal  1   3        ; R1 := select
[32] loadk      2   8        ; R2 := 2
[33] loadk      3   5        ; R3 := "a"
[34] loadk      4   6        ; R4 := "b"
[35] loadk      5   7        ; R5 := "c"
[36] call       1   5   0    ; R1 to top := R1(R2 to R5)
[37] call       0   0   1    ;  := R0(R1 to top)
[38] getglobal  0   0        ; R0 := print
[39] getglobal  1   3        ; R1 := select
[40] loadk      2   9        ; R2 := 3
[41] loadk      3   5        ; R3 := "a"
[42] loadk      4   6        ; R4 := "b"
[43] loadk      5   7        ; R5 := "c"
[44] call       1   5   0    ; R1 to top := R1(R2 to R5)
[45] call       0   0   1    ;  := R0(R1 to top)
[46] getglobal  0   0        ; R0 := print
[47] getglobal  1   3        ; R1 := select
[48] loadk      2   10       ; R2 := -1
[49] loadk      3   5        ; R3 := "a"
[50] loadk      4   6        ; R4 := "b"
[51] loadk      5   7        ; R5 := "c"
[52] call       1   5   0    ; R1 to top := R1(R2 to R5)
[53] call       0   0   1    ;  := R0(R1 to top)
[54] getglobal  0   0        ; R0 := print
[55] getglobal  1   3        ; R1 := select
[56] loadk      2   11       ; R2 := "#"
[57] loadk      3   5        ; R3 := "a"
[58] loadk      4   6        ; R4 := "b"
[59] loadk      5   7        ; R5 := "c"
[60] call       1   5   0    ; R1 to top := R1(R2 to R5)
[61] call       0   0   1    ;  := R0(R1 to top)
[62] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.const  "print"  ; 0
.const  "_VERSION"  ; 1
.const  "_G"  ; 2
.const  "select"  ; 3
.const  1  ; 4
.const  "a"  ; 5
.const  "b"  ; 6
.const  "c"  ; 7
.const  2  ; 8
.const  3  ; 9
.const  -1  ; 10
.const  "#"  ; 11
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := _VERSION
[03] call       0   2   1    ;  := R0(R1)
[04] getglobal  0   0        ; R0 := print
[05] getglobal  1   2        ; R1 := _G
[06] gettable   1   1   257  ; R1 := R1["_VERSION"]
[07] call       0   2   1    ;  := R0(R1)
[08] getglobal  0   0        ; R0 := print
[09] getglobal  1   2        ; R1 := _G
[10] call       0   2   1    ;  := R0(R1)
[11] getglobal  0   0        ; R0 := print
[12] getglobal  1   2        ; R1 := _G
[13] gettable   1   1   258  ; R1 := R1["_G"]
[14] call       0   2   1    ;  := R0(R1)
[15] getglobal  0   0        ; R0 := print
[16] getglobal  1   0        ; R1 := print
[17] call       0   2   1    ;  := R0(R1)
[18] getglobal  0   0        ; R0 := print
[19] getglobal  1   2        ; R1 := _G
[20] gettable   1   1   256  ; R1 := R1["print"]
[21] call       0   2   1    ;  := R0(R1)
[22] getglobal  0   0        ; R0 := print
[23] getglobal  1   3        ; R1 := select
[24] loadk      2   4        ; R2 := 1
[25] loadk      3   5        ; R3 := "a"
[26] loadk      4   6        ; R4 := "b"
[27] loadk      5   7        ; R5 := "c"
[28] call       1   5   0    ; R1 to top := R1(R2 to R5)
[29] call       0   0   1    ;  := R0(R1 to top)
[30] getglobal  0   0        ; R0 := print
[31] getglobal  1   3        ; R1 := select
[32] loadk      2   8        ; R2 := 2
[33] loadk      3   5        ; R3 := "a"
[34] loadk      4   6        ; R4 := "b"
[35] loadk      5   7        ; R5 := "c"
[36] call       1   5   0    ; R1 to top := R1(R2 to R5)
[37] call       0   0   1    ;  := R0(R1 to top)
[38] getglobal  0   0        ; R0 := print
[39] getglobal  1   3        ; R1 := select
[40] loadk      2   9        ; R2 := 3
[41] loadk      3   5        ; R3 := "a"
[42] loadk      4   6        ; R4 := "b"
[43] loadk      5   7        ; R5 := "c"
[44] call       1   5   0    ; R1 to top := R1(R2 to R5)
[45] call       0   0   1    ;  := R0(R1 to top)
[46] getglobal  0   0        ; R0 := print
[47] getglobal  1   3        ; R1 := select
[48] loadk      2   10       ; R2 := -1
[49] loadk      3   5        ; R3 := "a"
[50] loadk      4   6        ; R4 := "b"
[51] loadk      5   7        ; R5 := "c"
[52] call       1   5   0    ; R1 to top := R1(R2 to R5)
[53] call       0   0   1    ;  := R0(R1 to top)
[54] getglobal  0   0        ; R0 := print
[55] getglobal  1   3        ; R1 := select
[56] loadk      2   11       ; R2 := "#"
[57] loadk      3   5        ; R3 := "a"
[58] loadk      4   6        ; R4 := "b"
[59] loadk      5   7        ; R5 := "c"
[60] call       1   5   0    ; R1 to top := R1(R2 to R5)
[61] call       0   0   1    ;  := R0(R1 to top)
[62] return     0   1        ; return 
; end of function 0


------------------------------
success compiling learn.lua
Pos   Hex Data           Description or Code
------------------------------------------------------------------------
0000                     ** source chunk: learn.lua
                         ** global header start **
0000  1B4C7561           header signature: "\27Lua"
0004  51                 version (major:minor hex digits)
0005  00                 format (0=official)
0006  01                 endianness (1=little endian)
0007  04                 size of int (bytes)
0008  08                 size of size_t (bytes)
0009  04                 size of Instruction (bytes)
000A  08                 size of number (bytes)
000B  00                 integral (1=integral)
                         * number type: double
                         * x86 standard (32-bit, little endian, doubles)
                         ** global header end **
                         
000C                     ** function [0] definition (level 1) 0
                         ** start of function 0 **
000C  0B00000000000000   string size (11)
0014  406C6561726E2E6C+  "@learn.l"
001C  756100             "ua\0"
                         source name: @learn.lua
001F  00000000           line defined (0)
0023  00000000           last line defined (0)
0027  00                 nups (0)
0028  00                 numparams (0)
0029  02                 is_vararg (2)
002A  06                 maxstacksize (6)
                         * code:
002B  3E000000           sizecode (62)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  45400000           [02] getglobal  1   1        ; R1 := _VERSION
0037  1C400001           [03] call       0   2   1    ;  := R0(R1)
003B  05000000           [04] getglobal  0   0        ; R0 := print
003F  45800000           [05] getglobal  1   2        ; R1 := _G
0043  4640C000           [06] gettable   1   1   257  ; R1 := R1["_VERSION"]
0047  1C400001           [07] call       0   2   1    ;  := R0(R1)
004B  05000000           [08] getglobal  0   0        ; R0 := print
004F  45800000           [09] getglobal  1   2        ; R1 := _G
0053  1C400001           [10] call       0   2   1    ;  := R0(R1)
0057  05000000           [11] getglobal  0   0        ; R0 := print
005B  45800000           [12] getglobal  1   2        ; R1 := _G
005F  4680C000           [13] gettable   1   1   258  ; R1 := R1["_G"]
0063  1C400001           [14] call       0   2   1    ;  := R0(R1)
0067  05000000           [15] getglobal  0   0        ; R0 := print
006B  45000000           [16] getglobal  1   0        ; R1 := print
006F  1C400001           [17] call       0   2   1    ;  := R0(R1)
0073  05000000           [18] getglobal  0   0        ; R0 := print
0077  45800000           [19] getglobal  1   2        ; R1 := _G
007B  4600C000           [20] gettable   1   1   256  ; R1 := R1["print"]
007F  1C400001           [21] call       0   2   1    ;  := R0(R1)
0083  05000000           [22] getglobal  0   0        ; R0 := print
0087  45C00000           [23] getglobal  1   3        ; R1 := select
008B  81000100           [24] loadk      2   4        ; R2 := 1
008F  C1400100           [25] loadk      3   5        ; R3 := "a"
0093  01810100           [26] loadk      4   6        ; R4 := "b"
0097  41C10100           [27] loadk      5   7        ; R5 := "c"
009B  5C008002           [28] call       1   5   0    ; R1 to top := R1(R2 to R5)
009F  1C400000           [29] call       0   0   1    ;  := R0(R1 to top)
00A3  05000000           [30] getglobal  0   0        ; R0 := print
00A7  45C00000           [31] getglobal  1   3        ; R1 := select
00AB  81000200           [32] loadk      2   8        ; R2 := 2
00AF  C1400100           [33] loadk      3   5        ; R3 := "a"
00B3  01810100           [34] loadk      4   6        ; R4 := "b"
00B7  41C10100           [35] loadk      5   7        ; R5 := "c"
00BB  5C008002           [36] call       1   5   0    ; R1 to top := R1(R2 to R5)
00BF  1C400000           [37] call       0   0   1    ;  := R0(R1 to top)
00C3  05000000           [38] getglobal  0   0        ; R0 := print
00C7  45C00000           [39] getglobal  1   3        ; R1 := select
00CB  81400200           [40] loadk      2   9        ; R2 := 3
00CF  C1400100           [41] loadk      3   5        ; R3 := "a"
00D3  01810100           [42] loadk      4   6        ; R4 := "b"
00D7  41C10100           [43] loadk      5   7        ; R5 := "c"
00DB  5C008002           [44] call       1   5   0    ; R1 to top := R1(R2 to R5)
00DF  1C400000           [45] call       0   0   1    ;  := R0(R1 to top)
00E3  05000000           [46] getglobal  0   0        ; R0 := print
00E7  45C00000           [47] getglobal  1   3        ; R1 := select
00EB  81800200           [48] loadk      2   10       ; R2 := -1
00EF  C1400100           [49] loadk      3   5        ; R3 := "a"
00F3  01810100           [50] loadk      4   6        ; R4 := "b"
00F7  41C10100           [51] loadk      5   7        ; R5 := "c"
00FB  5C008002           [52] call       1   5   0    ; R1 to top := R1(R2 to R5)
00FF  1C400000           [53] call       0   0   1    ;  := R0(R1 to top)
0103  05000000           [54] getglobal  0   0        ; R0 := print
0107  45C00000           [55] getglobal  1   3        ; R1 := select
010B  81C00200           [56] loadk      2   11       ; R2 := "#"
010F  C1400100           [57] loadk      3   5        ; R3 := "a"
0113  01810100           [58] loadk      4   6        ; R4 := "b"
0117  41C10100           [59] loadk      5   7        ; R5 := "c"
011B  5C008002           [60] call       1   5   0    ; R1 to top := R1(R2 to R5)
011F  1C400000           [61] call       0   0   1    ;  := R0(R1 to top)
0123  1E008000           [62] return     0   1        ; return 
                         * constants:
0127  0C000000           sizek (12)
012B  04                 const type 4
012C  0600000000000000   string size (6)
0134  7072696E7400       "print\0"
                         const [0]: "print"
013A  04                 const type 4
013B  0900000000000000   string size (9)
0143  5F56455253494F4E+  "_VERSION"
014B  00                 "\0"
                         const [1]: "_VERSION"
014C  04                 const type 4
014D  0300000000000000   string size (3)
0155  5F4700             "_G\0"
                         const [2]: "_G"
0158  04                 const type 4
0159  0700000000000000   string size (7)
0161  73656C65637400     "select\0"
                         const [3]: "select"
0168  03                 const type 3
0169  000000000000F03F   const [4]: (1)
0171  04                 const type 4
0172  0200000000000000   string size (2)
017A  6100               "a\0"
                         const [5]: "a"
017C  04                 const type 4
017D  0200000000000000   string size (2)
0185  6200               "b\0"
                         const [6]: "b"
0187  04                 const type 4
0188  0200000000000000   string size (2)
0190  6300               "c\0"
                         const [7]: "c"
0192  03                 const type 3
0193  0000000000000040   const [8]: (2)
019B  03                 const type 3
019C  0000000000000840   const [9]: (3)
01A4  03                 const type 3
01A5  000000000000F0BF   const [10]: (-1)
01AD  04                 const type 4
01AE  0200000000000000   string size (2)
01B6  2300               "#\0"
                         const [11]: "#"
                         * functions:
01B8  00000000           sizep (0)
                         * lines:
01BC  3E000000           sizelineinfo (62)
                         [pc] (line)
01C0  01000000           [01] (1)
01C4  01000000           [02] (1)
01C8  01000000           [03] (1)
01CC  02000000           [04] (2)
01D0  02000000           [05] (2)
01D4  02000000           [06] (2)
01D8  02000000           [07] (2)
01DC  03000000           [08] (3)
01E0  03000000           [09] (3)
01E4  03000000           [10] (3)
01E8  04000000           [11] (4)
01EC  04000000           [12] (4)
01F0  04000000           [13] (4)
01F4  04000000           [14] (4)
01F8  05000000           [15] (5)
01FC  05000000           [16] (5)
0200  05000000           [17] (5)
0204  06000000           [18] (6)
0208  06000000           [19] (6)
020C  06000000           [20] (6)
0210  06000000           [21] (6)
0214  08000000           [22] (8)
0218  08000000           [23] (8)
021C  08000000           [24] (8)
0220  08000000           [25] (8)
0224  08000000           [26] (8)
0228  08000000           [27] (8)
022C  08000000           [28] (8)
0230  08000000           [29] (8)
0234  09000000           [30] (9)
0238  09000000           [31] (9)
023C  09000000           [32] (9)
0240  09000000           [33] (9)
0244  09000000           [34] (9)
0248  09000000           [35] (9)
024C  09000000           [36] (9)
0250  09000000           [37] (9)
0254  0A000000           [38] (10)
0258  0A000000           [39] (10)
025C  0A000000           [40] (10)
0260  0A000000           [41] (10)
0264  0A000000           [42] (10)
0268  0A000000           [43] (10)
026C  0A000000           [44] (10)
0270  0A000000           [45] (10)
0274  0B000000           [46] (11)
0278  0B000000           [47] (11)
027C  0B000000           [48] (11)
0280  0B000000           [49] (11)
0284  0B000000           [50] (11)
0288  0B000000           [51] (11)
028C  0B000000           [52] (11)
0290  0B000000           [53] (11)
0294  0C000000           [54] (12)
0298  0C000000           [55] (12)
029C  0C000000           [56] (12)
02A0  0C000000           [57] (12)
02A4  0C000000           [58] (12)
02A8  0C000000           [59] (12)
02AC  0C000000           [60] (12)
02B0  0C000000           [61] (12)
02B4  0C000000           [62] (12)
                         * locals:
02B8  00000000           sizelocvars (0)
                         * upvalues:
02BC  00000000           sizeupvalues (0)
                         ** end of function 0 **

02C0                     ** end of chunk **
Pos   Hex Data           Description or Code
------------------------------------------------------------------------
0000                     ** source chunk: luac.out
                         ** global header start **
0000  1B4C7561           header signature: "\27Lua"
0004  51                 version (major:minor hex digits)
0005  00                 format (0=official)
0006  01                 endianness (1=little endian)
0007  04                 size of int (bytes)
0008  08                 size of size_t (bytes)
0009  04                 size of Instruction (bytes)
000A  08                 size of number (bytes)
000B  00                 integral (1=integral)
                         * number type: double
                         * x86 standard (32-bit, little endian, doubles)
                         ** global header end **
                         
000C                     ** function [0] definition (level 1) 0
                         ** start of function 0 **
000C  0B00000000000000   string size (11)
0014  406C6561726E2E6C+  "@learn.l"
001C  756100             "ua\0"
                         source name: @learn.lua
001F  00000000           line defined (0)
0023  00000000           last line defined (0)
0027  00                 nups (0)
0028  00                 numparams (0)
0029  02                 is_vararg (2)
002A  06                 maxstacksize (6)
                         * code:
002B  3E000000           sizecode (62)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  45400000           [02] getglobal  1   1        ; R1 := _VERSION
0037  1C400001           [03] call       0   2   1    ;  := R0(R1)
003B  05000000           [04] getglobal  0   0        ; R0 := print
003F  45800000           [05] getglobal  1   2        ; R1 := _G
0043  4640C000           [06] gettable   1   1   257  ; R1 := R1["_VERSION"]
0047  1C400001           [07] call       0   2   1    ;  := R0(R1)
004B  05000000           [08] getglobal  0   0        ; R0 := print
004F  45800000           [09] getglobal  1   2        ; R1 := _G
0053  1C400001           [10] call       0   2   1    ;  := R0(R1)
0057  05000000           [11] getglobal  0   0        ; R0 := print
005B  45800000           [12] getglobal  1   2        ; R1 := _G
005F  4680C000           [13] gettable   1   1   258  ; R1 := R1["_G"]
0063  1C400001           [14] call       0   2   1    ;  := R0(R1)
0067  05000000           [15] getglobal  0   0        ; R0 := print
006B  45000000           [16] getglobal  1   0        ; R1 := print
006F  1C400001           [17] call       0   2   1    ;  := R0(R1)
0073  05000000           [18] getglobal  0   0        ; R0 := print
0077  45800000           [19] getglobal  1   2        ; R1 := _G
007B  4600C000           [20] gettable   1   1   256  ; R1 := R1["print"]
007F  1C400001           [21] call       0   2   1    ;  := R0(R1)
0083  05000000           [22] getglobal  0   0        ; R0 := print
0087  45C00000           [23] getglobal  1   3        ; R1 := select
008B  81000100           [24] loadk      2   4        ; R2 := 1
008F  C1400100           [25] loadk      3   5        ; R3 := "a"
0093  01810100           [26] loadk      4   6        ; R4 := "b"
0097  41C10100           [27] loadk      5   7        ; R5 := "c"
009B  5C008002           [28] call       1   5   0    ; R1 to top := R1(R2 to R5)
009F  1C400000           [29] call       0   0   1    ;  := R0(R1 to top)
00A3  05000000           [30] getglobal  0   0        ; R0 := print
00A7  45C00000           [31] getglobal  1   3        ; R1 := select
00AB  81000200           [32] loadk      2   8        ; R2 := 2
00AF  C1400100           [33] loadk      3   5        ; R3 := "a"
00B3  01810100           [34] loadk      4   6        ; R4 := "b"
00B7  41C10100           [35] loadk      5   7        ; R5 := "c"
00BB  5C008002           [36] call       1   5   0    ; R1 to top := R1(R2 to R5)
00BF  1C400000           [37] call       0   0   1    ;  := R0(R1 to top)
00C3  05000000           [38] getglobal  0   0        ; R0 := print
00C7  45C00000           [39] getglobal  1   3        ; R1 := select
00CB  81400200           [40] loadk      2   9        ; R2 := 3
00CF  C1400100           [41] loadk      3   5        ; R3 := "a"
00D3  01810100           [42] loadk      4   6        ; R4 := "b"
00D7  41C10100           [43] loadk      5   7        ; R5 := "c"
00DB  5C008002           [44] call       1   5   0    ; R1 to top := R1(R2 to R5)
00DF  1C400000           [45] call       0   0   1    ;  := R0(R1 to top)
00E3  05000000           [46] getglobal  0   0        ; R0 := print
00E7  45C00000           [47] getglobal  1   3        ; R1 := select
00EB  81800200           [48] loadk      2   10       ; R2 := -1
00EF  C1400100           [49] loadk      3   5        ; R3 := "a"
00F3  01810100           [50] loadk      4   6        ; R4 := "b"
00F7  41C10100           [51] loadk      5   7        ; R5 := "c"
00FB  5C008002           [52] call       1   5   0    ; R1 to top := R1(R2 to R5)
00FF  1C400000           [53] call       0   0   1    ;  := R0(R1 to top)
0103  05000000           [54] getglobal  0   0        ; R0 := print
0107  45C00000           [55] getglobal  1   3        ; R1 := select
010B  81C00200           [56] loadk      2   11       ; R2 := "#"
010F  C1400100           [57] loadk      3   5        ; R3 := "a"
0113  01810100           [58] loadk      4   6        ; R4 := "b"
0117  41C10100           [59] loadk      5   7        ; R5 := "c"
011B  5C008002           [60] call       1   5   0    ; R1 to top := R1(R2 to R5)
011F  1C400000           [61] call       0   0   1    ;  := R0(R1 to top)
0123  1E008000           [62] return     0   1        ; return 
                         * constants:
0127  0C000000           sizek (12)
012B  04                 const type 4
012C  0600000000000000   string size (6)
0134  7072696E7400       "print\0"
                         const [0]: "print"
013A  04                 const type 4
013B  0900000000000000   string size (9)
0143  5F56455253494F4E+  "_VERSION"
014B  00                 "\0"
                         const [1]: "_VERSION"
014C  04                 const type 4
014D  0300000000000000   string size (3)
0155  5F4700             "_G\0"
                         const [2]: "_G"
0158  04                 const type 4
0159  0700000000000000   string size (7)
0161  73656C65637400     "select\0"
                         const [3]: "select"
0168  03                 const type 3
0169  000000000000F03F   const [4]: (1)
0171  04                 const type 4
0172  0200000000000000   string size (2)
017A  6100               "a\0"
                         const [5]: "a"
017C  04                 const type 4
017D  0200000000000000   string size (2)
0185  6200               "b\0"
                         const [6]: "b"
0187  04                 const type 4
0188  0200000000000000   string size (2)
0190  6300               "c\0"
                         const [7]: "c"
0192  03                 const type 3
0193  0000000000000040   const [8]: (2)
019B  03                 const type 3
019C  0000000000000840   const [9]: (3)
01A4  03                 const type 3
01A5  000000000000F0BF   const [10]: (-1)
01AD  04                 const type 4
01AE  0200000000000000   string size (2)
01B6  2300               "#\0"
                         const [11]: "#"
                         * functions:
01B8  00000000           sizep (0)
                         * lines:
01BC  3E000000           sizelineinfo (62)
                         [pc] (line)
01C0  01000000           [01] (1)
01C4  01000000           [02] (1)
01C8  01000000           [03] (1)
01CC  02000000           [04] (2)
01D0  02000000           [05] (2)
01D4  02000000           [06] (2)
01D8  02000000           [07] (2)
01DC  03000000           [08] (3)
01E0  03000000           [09] (3)
01E4  03000000           [10] (3)
01E8  04000000           [11] (4)
01EC  04000000           [12] (4)
01F0  04000000           [13] (4)
01F4  04000000           [14] (4)
01F8  05000000           [15] (5)
01FC  05000000           [16] (5)
0200  05000000           [17] (5)
0204  06000000           [18] (6)
0208  06000000           [19] (6)
020C  06000000           [20] (6)
0210  06000000           [21] (6)
0214  08000000           [22] (8)
0218  08000000           [23] (8)
021C  08000000           [24] (8)
0220  08000000           [25] (8)
0224  08000000           [26] (8)
0228  08000000           [27] (8)
022C  08000000           [28] (8)
0230  08000000           [29] (8)
0234  09000000           [30] (9)
0238  09000000           [31] (9)
023C  09000000           [32] (9)
0240  09000000           [33] (9)
0244  09000000           [34] (9)
0248  09000000           [35] (9)
024C  09000000           [36] (9)
0250  09000000           [37] (9)
0254  0A000000           [38] (10)
0258  0A000000           [39] (10)
025C  0A000000           [40] (10)
0260  0A000000           [41] (10)
0264  0A000000           [42] (10)
0268  0A000000           [43] (10)
026C  0A000000           [44] (10)
0270  0A000000           [45] (10)
0274  0B000000           [46] (11)
0278  0B000000           [47] (11)
027C  0B000000           [48] (11)
0280  0B000000           [49] (11)
0284  0B000000           [50] (11)
0288  0B000000           [51] (11)
028C  0B000000           [52] (11)
0290  0B000000           [53] (11)
0294  0C000000           [54] (12)
0298  0C000000           [55] (12)
029C  0C000000           [56] (12)
02A0  0C000000           [57] (12)
02A4  0C000000           [58] (12)
02A8  0C000000           [59] (12)
02AC  0C000000           [60] (12)
02B0  0C000000           [61] (12)
02B4  0C000000           [62] (12)
                         * locals:
02B8  00000000           sizelocvars (0)
                         * upvalues:
02BC  00000000           sizeupvalues (0)
                         ** end of function 0 **

02C0                     ** end of chunk **
