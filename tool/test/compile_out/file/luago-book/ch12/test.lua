------------------------------
t = {a = 1, b = 2, c = 3}
for k, v in pairs(t) do
  print(k, v)
end

t = {"a", "b", "c"}
for k, v in ipairs(t) do
  print(k, v)
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "k"  ; 3
.local  "v"  ; 4
.local  "(for generator)"  ; 5
.local  "(for state)"  ; 6
.local  "(for control)"  ; 7
.local  "k"  ; 8
.local  "v"  ; 9
.const  "t"  ; 0
.const  "a"  ; 1
.const  1  ; 2
.const  "b"  ; 3
.const  2  ; 4
.const  "c"  ; 5
.const  3  ; 6
.const  "pairs"  ; 7
.const  "print"  ; 8
.const  "ipairs"  ; 9
[01] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[02] settable   0   257 258  ; R0["a"] := 1
[03] settable   0   259 260  ; R0["b"] := 2
[04] settable   0   261 262  ; R0["c"] := 3
[05] setglobal  0   0        ; t := R0
[06] getglobal  0   7        ; R0 := pairs
[07] getglobal  1   0        ; R1 := t
[08] call       0   2   4    ; R0 to R2 := R0(R1)
[09] jmp        4            ; pc+=4 (goto [14])
[10] getglobal  5   8        ; R5 := print
[11] move       6   3        ; R6 := R3
[12] move       7   4        ; R7 := R4
[13] call       5   3   1    ;  := R5(R6, R7)
[14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
[15] jmp        -6           ; pc+=-6 (goto [10])
[16] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[17] loadk      1   1        ; R1 := "a"
[18] loadk      2   3        ; R2 := "b"
[19] loadk      3   5        ; R3 := "c"
[20] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[21] setglobal  0   0        ; t := R0
[22] getglobal  0   9        ; R0 := ipairs
[23] getglobal  1   0        ; R1 := t
[24] call       0   2   4    ; R0 to R2 := R0(R1)
[25] jmp        4            ; pc+=4 (goto [30])
[26] getglobal  5   8        ; R5 := print
[27] move       6   3        ; R6 := R3
[28] move       7   4        ; R7 := R4
[29] call       5   3   1    ;  := R5(R6, R7)
[30] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 32
[31] jmp        -6           ; pc+=-6 (goto [26])
[32] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "k"  ; 3
.local  "v"  ; 4
.local  "(for generator)"  ; 5
.local  "(for state)"  ; 6
.local  "(for control)"  ; 7
.local  "k"  ; 8
.local  "v"  ; 9
.const  "t"  ; 0
.const  "a"  ; 1
.const  1  ; 2
.const  "b"  ; 3
.const  2  ; 4
.const  "c"  ; 5
.const  3  ; 6
.const  "pairs"  ; 7
.const  "print"  ; 8
.const  "ipairs"  ; 9
[01] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[02] settable   0   257 258  ; R0["a"] := 1
[03] settable   0   259 260  ; R0["b"] := 2
[04] settable   0   261 262  ; R0["c"] := 3
[05] setglobal  0   0        ; t := R0
[06] getglobal  0   7        ; R0 := pairs
[07] getglobal  1   0        ; R1 := t
[08] call       0   2   4    ; R0 to R2 := R0(R1)
[09] jmp        4            ; pc+=4 (goto [14])
[10] getglobal  5   8        ; R5 := print
[11] move       6   3        ; R6 := R3
[12] move       7   4        ; R7 := R4
[13] call       5   3   1    ;  := R5(R6, R7)
[14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
[15] jmp        -6           ; pc+=-6 (goto [10])
[16] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[17] loadk      1   1        ; R1 := "a"
[18] loadk      2   3        ; R2 := "b"
[19] loadk      3   5        ; R3 := "c"
[20] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[21] setglobal  0   0        ; t := R0
[22] getglobal  0   9        ; R0 := ipairs
[23] getglobal  1   0        ; R1 := t
[24] call       0   2   4    ; R0 to R2 := R0(R1)
[25] jmp        4            ; pc+=4 (goto [30])
[26] getglobal  5   8        ; R5 := print
[27] move       6   3        ; R6 := R3
[28] move       7   4        ; R7 := R4
[29] call       5   3   1    ;  := R5(R6, R7)
[30] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 32
[31] jmp        -6           ; pc+=-6 (goto [26])
[32] return     0   1        ; return 
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
002A  08                 maxstacksize (8)
                         * code:
002B  20000000           sizecode (32)
002F  0AC00000           [01] newtable   0   0   3    ; R0 := {} , array=0, hash=3
0033  0980C080           [02] settable   0   257 258  ; R0["a"] := 1
0037  0900C181           [03] settable   0   259 260  ; R0["b"] := 2
003B  0980C182           [04] settable   0   261 262  ; R0["c"] := 3
003F  07000000           [05] setglobal  0   0        ; t := R0
0043  05C00100           [06] getglobal  0   7        ; R0 := pairs
0047  45000000           [07] getglobal  1   0        ; R1 := t
004B  1C000101           [08] call       0   2   4    ; R0 to R2 := R0(R1)
004F  16C00080           [09] jmp        4            ; pc+=4 (goto [14])
0053  45010200           [10] getglobal  5   8        ; R5 := print
0057  80018001           [11] move       6   3        ; R6 := R3
005B  C0010002           [12] move       7   4        ; R7 := R4
005F  5C418001           [13] call       5   3   1    ;  := R5(R6, R7)
0063  21800000           [14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
0067  1640FE7F           [15] jmp        -6           ; pc+=-6 (goto [10])
006B  0A008001           [16] newtable   0   3   0    ; R0 := {} , array=3, hash=0
006F  41400000           [17] loadk      1   1        ; R1 := "a"
0073  81C00000           [18] loadk      2   3        ; R2 := "b"
0077  C1400100           [19] loadk      3   5        ; R3 := "c"
007B  22408001           [20] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
007F  07000000           [21] setglobal  0   0        ; t := R0
0083  05400200           [22] getglobal  0   9        ; R0 := ipairs
0087  45000000           [23] getglobal  1   0        ; R1 := t
008B  1C000101           [24] call       0   2   4    ; R0 to R2 := R0(R1)
008F  16C00080           [25] jmp        4            ; pc+=4 (goto [30])
0093  45010200           [26] getglobal  5   8        ; R5 := print
0097  80018001           [27] move       6   3        ; R6 := R3
009B  C0010002           [28] move       7   4        ; R7 := R4
009F  5C418001           [29] call       5   3   1    ;  := R5(R6, R7)
00A3  21800000           [30] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 32
00A7  1640FE7F           [31] jmp        -6           ; pc+=-6 (goto [26])
00AB  1E008000           [32] return     0   1        ; return 
                         * constants:
00AF  0A000000           sizek (10)
00B3  04                 const type 4
00B4  0200000000000000   string size (2)
00BC  7400               "t\0"
                         const [0]: "t"
00BE  04                 const type 4
00BF  0200000000000000   string size (2)
00C7  6100               "a\0"
                         const [1]: "a"
00C9  03                 const type 3
00CA  000000000000F03F   const [2]: (1)
00D2  04                 const type 4
00D3  0200000000000000   string size (2)
00DB  6200               "b\0"
                         const [3]: "b"
00DD  03                 const type 3
00DE  0000000000000040   const [4]: (2)
00E6  04                 const type 4
00E7  0200000000000000   string size (2)
00EF  6300               "c\0"
                         const [5]: "c"
00F1  03                 const type 3
00F2  0000000000000840   const [6]: (3)
00FA  04                 const type 4
00FB  0600000000000000   string size (6)
0103  706169727300       "pairs\0"
                         const [7]: "pairs"
0109  04                 const type 4
010A  0600000000000000   string size (6)
0112  7072696E7400       "print\0"
                         const [8]: "print"
0118  04                 const type 4
0119  0700000000000000   string size (7)
0121  69706169727300     "ipairs\0"
                         const [9]: "ipairs"
                         * functions:
0128  00000000           sizep (0)
                         * lines:
012C  20000000           sizelineinfo (32)
                         [pc] (line)
0130  01000000           [01] (1)
0134  01000000           [02] (1)
0138  01000000           [03] (1)
013C  01000000           [04] (1)
0140  01000000           [05] (1)
0144  02000000           [06] (2)
0148  02000000           [07] (2)
014C  02000000           [08] (2)
0150  02000000           [09] (2)
0154  03000000           [10] (3)
0158  03000000           [11] (3)
015C  03000000           [12] (3)
0160  03000000           [13] (3)
0164  02000000           [14] (2)
0168  03000000           [15] (3)
016C  06000000           [16] (6)
0170  06000000           [17] (6)
0174  06000000           [18] (6)
0178  06000000           [19] (6)
017C  06000000           [20] (6)
0180  06000000           [21] (6)
0184  07000000           [22] (7)
0188  07000000           [23] (7)
018C  07000000           [24] (7)
0190  07000000           [25] (7)
0194  08000000           [26] (8)
0198  08000000           [27] (8)
019C  08000000           [28] (8)
01A0  08000000           [29] (8)
01A4  07000000           [30] (7)
01A8  08000000           [31] (8)
01AC  09000000           [32] (9)
                         * locals:
01B0  0A000000           sizelocvars (10)
01B4  1000000000000000   string size (16)
01BC  28666F722067656E+  "(for gen"
01C4  657261746F722900   "erator)\0"
                         local [0]: (for generator)
01CC  08000000             startpc (8)
01D0  0F000000             endpc   (15)
01D4  0C00000000000000   string size (12)
01DC  28666F7220737461+  "(for sta"
01E4  74652900           "te)\0"
                         local [1]: (for state)
01E8  08000000             startpc (8)
01EC  0F000000             endpc   (15)
01F0  0E00000000000000   string size (14)
01F8  28666F7220636F6E+  "(for con"
0200  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0206  08000000             startpc (8)
020A  0F000000             endpc   (15)
020E  0200000000000000   string size (2)
0216  6B00               "k\0"
                         local [3]: k
0218  09000000             startpc (9)
021C  0D000000             endpc   (13)
0220  0200000000000000   string size (2)
0228  7600               "v\0"
                         local [4]: v
022A  09000000             startpc (9)
022E  0D000000             endpc   (13)
0232  1000000000000000   string size (16)
023A  28666F722067656E+  "(for gen"
0242  657261746F722900   "erator)\0"
                         local [5]: (for generator)
024A  18000000             startpc (24)
024E  1F000000             endpc   (31)
0252  0C00000000000000   string size (12)
025A  28666F7220737461+  "(for sta"
0262  74652900           "te)\0"
                         local [6]: (for state)
0266  18000000             startpc (24)
026A  1F000000             endpc   (31)
026E  0E00000000000000   string size (14)
0276  28666F7220636F6E+  "(for con"
027E  74726F6C2900       "trol)\0"
                         local [7]: (for control)
0284  18000000             startpc (24)
0288  1F000000             endpc   (31)
028C  0200000000000000   string size (2)
0294  6B00               "k\0"
                         local [8]: k
0296  19000000             startpc (25)
029A  1D000000             endpc   (29)
029E  0200000000000000   string size (2)
02A6  7600               "v\0"
                         local [9]: v
02A8  19000000             startpc (25)
02AC  1D000000             endpc   (29)
                         * upvalues:
02B0  00000000           sizeupvalues (0)
                         ** end of function 0 **

02B4                     ** end of chunk **
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
002A  08                 maxstacksize (8)
                         * code:
002B  20000000           sizecode (32)
002F  0AC00000           [01] newtable   0   0   3    ; R0 := {} , array=0, hash=3
0033  0980C080           [02] settable   0   257 258  ; R0["a"] := 1
0037  0900C181           [03] settable   0   259 260  ; R0["b"] := 2
003B  0980C182           [04] settable   0   261 262  ; R0["c"] := 3
003F  07000000           [05] setglobal  0   0        ; t := R0
0043  05C00100           [06] getglobal  0   7        ; R0 := pairs
0047  45000000           [07] getglobal  1   0        ; R1 := t
004B  1C000101           [08] call       0   2   4    ; R0 to R2 := R0(R1)
004F  16C00080           [09] jmp        4            ; pc+=4 (goto [14])
0053  45010200           [10] getglobal  5   8        ; R5 := print
0057  80018001           [11] move       6   3        ; R6 := R3
005B  C0010002           [12] move       7   4        ; R7 := R4
005F  5C418001           [13] call       5   3   1    ;  := R5(R6, R7)
0063  21800000           [14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
0067  1640FE7F           [15] jmp        -6           ; pc+=-6 (goto [10])
006B  0A008001           [16] newtable   0   3   0    ; R0 := {} , array=3, hash=0
006F  41400000           [17] loadk      1   1        ; R1 := "a"
0073  81C00000           [18] loadk      2   3        ; R2 := "b"
0077  C1400100           [19] loadk      3   5        ; R3 := "c"
007B  22408001           [20] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
007F  07000000           [21] setglobal  0   0        ; t := R0
0083  05400200           [22] getglobal  0   9        ; R0 := ipairs
0087  45000000           [23] getglobal  1   0        ; R1 := t
008B  1C000101           [24] call       0   2   4    ; R0 to R2 := R0(R1)
008F  16C00080           [25] jmp        4            ; pc+=4 (goto [30])
0093  45010200           [26] getglobal  5   8        ; R5 := print
0097  80018001           [27] move       6   3        ; R6 := R3
009B  C0010002           [28] move       7   4        ; R7 := R4
009F  5C418001           [29] call       5   3   1    ;  := R5(R6, R7)
00A3  21800000           [30] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 32
00A7  1640FE7F           [31] jmp        -6           ; pc+=-6 (goto [26])
00AB  1E008000           [32] return     0   1        ; return 
                         * constants:
00AF  0A000000           sizek (10)
00B3  04                 const type 4
00B4  0200000000000000   string size (2)
00BC  7400               "t\0"
                         const [0]: "t"
00BE  04                 const type 4
00BF  0200000000000000   string size (2)
00C7  6100               "a\0"
                         const [1]: "a"
00C9  03                 const type 3
00CA  000000000000F03F   const [2]: (1)
00D2  04                 const type 4
00D3  0200000000000000   string size (2)
00DB  6200               "b\0"
                         const [3]: "b"
00DD  03                 const type 3
00DE  0000000000000040   const [4]: (2)
00E6  04                 const type 4
00E7  0200000000000000   string size (2)
00EF  6300               "c\0"
                         const [5]: "c"
00F1  03                 const type 3
00F2  0000000000000840   const [6]: (3)
00FA  04                 const type 4
00FB  0600000000000000   string size (6)
0103  706169727300       "pairs\0"
                         const [7]: "pairs"
0109  04                 const type 4
010A  0600000000000000   string size (6)
0112  7072696E7400       "print\0"
                         const [8]: "print"
0118  04                 const type 4
0119  0700000000000000   string size (7)
0121  69706169727300     "ipairs\0"
                         const [9]: "ipairs"
                         * functions:
0128  00000000           sizep (0)
                         * lines:
012C  20000000           sizelineinfo (32)
                         [pc] (line)
0130  01000000           [01] (1)
0134  01000000           [02] (1)
0138  01000000           [03] (1)
013C  01000000           [04] (1)
0140  01000000           [05] (1)
0144  02000000           [06] (2)
0148  02000000           [07] (2)
014C  02000000           [08] (2)
0150  02000000           [09] (2)
0154  03000000           [10] (3)
0158  03000000           [11] (3)
015C  03000000           [12] (3)
0160  03000000           [13] (3)
0164  02000000           [14] (2)
0168  03000000           [15] (3)
016C  06000000           [16] (6)
0170  06000000           [17] (6)
0174  06000000           [18] (6)
0178  06000000           [19] (6)
017C  06000000           [20] (6)
0180  06000000           [21] (6)
0184  07000000           [22] (7)
0188  07000000           [23] (7)
018C  07000000           [24] (7)
0190  07000000           [25] (7)
0194  08000000           [26] (8)
0198  08000000           [27] (8)
019C  08000000           [28] (8)
01A0  08000000           [29] (8)
01A4  07000000           [30] (7)
01A8  08000000           [31] (8)
01AC  09000000           [32] (9)
                         * locals:
01B0  0A000000           sizelocvars (10)
01B4  1000000000000000   string size (16)
01BC  28666F722067656E+  "(for gen"
01C4  657261746F722900   "erator)\0"
                         local [0]: (for generator)
01CC  08000000             startpc (8)
01D0  0F000000             endpc   (15)
01D4  0C00000000000000   string size (12)
01DC  28666F7220737461+  "(for sta"
01E4  74652900           "te)\0"
                         local [1]: (for state)
01E8  08000000             startpc (8)
01EC  0F000000             endpc   (15)
01F0  0E00000000000000   string size (14)
01F8  28666F7220636F6E+  "(for con"
0200  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0206  08000000             startpc (8)
020A  0F000000             endpc   (15)
020E  0200000000000000   string size (2)
0216  6B00               "k\0"
                         local [3]: k
0218  09000000             startpc (9)
021C  0D000000             endpc   (13)
0220  0200000000000000   string size (2)
0228  7600               "v\0"
                         local [4]: v
022A  09000000             startpc (9)
022E  0D000000             endpc   (13)
0232  1000000000000000   string size (16)
023A  28666F722067656E+  "(for gen"
0242  657261746F722900   "erator)\0"
                         local [5]: (for generator)
024A  18000000             startpc (24)
024E  1F000000             endpc   (31)
0252  0C00000000000000   string size (12)
025A  28666F7220737461+  "(for sta"
0262  74652900           "te)\0"
                         local [6]: (for state)
0266  18000000             startpc (24)
026A  1F000000             endpc   (31)
026E  0E00000000000000   string size (14)
0276  28666F7220636F6E+  "(for con"
027E  74726F6C2900       "trol)\0"
                         local [7]: (for control)
0284  18000000             startpc (24)
0288  1F000000             endpc   (31)
028C  0200000000000000   string size (2)
0294  6B00               "k\0"
                         local [8]: k
0296  19000000             startpc (25)
029A  1D000000             endpc   (29)
029E  0200000000000000   string size (2)
02A6  7600               "v\0"
                         local [9]: v
02A8  19000000             startpc (25)
02AC  1D000000             endpc   (29)
                         * upvalues:
02B0  00000000           sizeupvalues (0)
                         ** end of function 0 **

02B4                     ** end of chunk **
