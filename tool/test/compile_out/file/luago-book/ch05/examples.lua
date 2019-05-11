------------------------------
-- diff between 5.1 and 5.3
-- no // and no bit op

--print(5 // 3)       --> 1
--print(-5 // 3)      --> -2
--print(5 // -3.0)    --> -2.0
--print(-5.0 // -3.0) --> 1.0

print(5 % 3)       --> 2
print(-5 % 3)      --> 1
print(5 % -3.0)    --> -1.0
print(-5.0 % -3.0) --> -2.0

print(100 / 10 / 2) -- (100/10)/2 == 5.0
print(4 ^ 3 ^ 2)    -- 4^(3^2) == 262144.0

--print(-1 >> 63)   --> 1
--print(2 << -1)    --> 1
--print("1" << 1.0) --> 2

print(#"hello")   --> 5
print(#{ 7, 8, 9 }) --> 3

print("a" .. "b" .. "c") --> abc
print(1 .. 2 .. 3)       --> 123

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.const  "print"  ; 0
.const  2  ; 1
.const  1  ; 2
.const  -1  ; 3
.const  -2  ; 4
.const  5  ; 5
.const  262144  ; 6
.const  "hello"  ; 7
.const  7  ; 8
.const  8  ; 9
.const  9  ; 10
.const  "a"  ; 11
.const  "b"  ; 12
.const  "c"  ; 13
.const  3  ; 14
[01] getglobal  0   0        ; R0 := print
[02] loadk      1   1        ; R1 := 2
[03] call       0   2   1    ;  := R0(R1)
[04] getglobal  0   0        ; R0 := print
[05] loadk      1   2        ; R1 := 1
[06] call       0   2   1    ;  := R0(R1)
[07] getglobal  0   0        ; R0 := print
[08] loadk      1   3        ; R1 := -1
[09] call       0   2   1    ;  := R0(R1)
[10] getglobal  0   0        ; R0 := print
[11] loadk      1   4        ; R1 := -2
[12] call       0   2   1    ;  := R0(R1)
[13] getglobal  0   0        ; R0 := print
[14] loadk      1   5        ; R1 := 5
[15] call       0   2   1    ;  := R0(R1)
[16] getglobal  0   0        ; R0 := print
[17] loadk      1   6        ; R1 := 262144
[18] call       0   2   1    ;  := R0(R1)
[19] getglobal  0   0        ; R0 := print
[20] loadk      1   7        ; R1 := "hello"
[21] len        1   1        ; R1 := #R1
[22] call       0   2   1    ;  := R0(R1)
[23] getglobal  0   0        ; R0 := print
[24] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[25] loadk      2   8        ; R2 := 7
[26] loadk      3   9        ; R3 := 8
[27] loadk      4   10       ; R4 := 9
[28] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[29] len        1   1        ; R1 := #R1
[30] call       0   2   1    ;  := R0(R1)
[31] getglobal  0   0        ; R0 := print
[32] loadk      1   11       ; R1 := "a"
[33] loadk      2   12       ; R2 := "b"
[34] loadk      3   13       ; R3 := "c"
[35] concat     1   1   3    ; R1 := R1..R2..R3
[36] call       0   2   1    ;  := R0(R1)
[37] getglobal  0   0        ; R0 := print
[38] loadk      1   2        ; R1 := 1
[39] loadk      2   1        ; R2 := 2
[40] loadk      3   14       ; R3 := 3
[41] concat     1   1   3    ; R1 := R1..R2..R3
[42] call       0   2   1    ;  := R0(R1)
[43] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.const  "print"  ; 0
.const  2  ; 1
.const  1  ; 2
.const  -1  ; 3
.const  -2  ; 4
.const  5  ; 5
.const  262144  ; 6
.const  "hello"  ; 7
.const  7  ; 8
.const  8  ; 9
.const  9  ; 10
.const  "a"  ; 11
.const  "b"  ; 12
.const  "c"  ; 13
.const  3  ; 14
[01] getglobal  0   0        ; R0 := print
[02] loadk      1   1        ; R1 := 2
[03] call       0   2   1    ;  := R0(R1)
[04] getglobal  0   0        ; R0 := print
[05] loadk      1   2        ; R1 := 1
[06] call       0   2   1    ;  := R0(R1)
[07] getglobal  0   0        ; R0 := print
[08] loadk      1   3        ; R1 := -1
[09] call       0   2   1    ;  := R0(R1)
[10] getglobal  0   0        ; R0 := print
[11] loadk      1   4        ; R1 := -2
[12] call       0   2   1    ;  := R0(R1)
[13] getglobal  0   0        ; R0 := print
[14] loadk      1   5        ; R1 := 5
[15] call       0   2   1    ;  := R0(R1)
[16] getglobal  0   0        ; R0 := print
[17] loadk      1   6        ; R1 := 262144
[18] call       0   2   1    ;  := R0(R1)
[19] getglobal  0   0        ; R0 := print
[20] loadk      1   7        ; R1 := "hello"
[21] len        1   1        ; R1 := #R1
[22] call       0   2   1    ;  := R0(R1)
[23] getglobal  0   0        ; R0 := print
[24] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[25] loadk      2   8        ; R2 := 7
[26] loadk      3   9        ; R3 := 8
[27] loadk      4   10       ; R4 := 9
[28] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[29] len        1   1        ; R1 := #R1
[30] call       0   2   1    ;  := R0(R1)
[31] getglobal  0   0        ; R0 := print
[32] loadk      1   11       ; R1 := "a"
[33] loadk      2   12       ; R2 := "b"
[34] loadk      3   13       ; R3 := "c"
[35] concat     1   1   3    ; R1 := R1..R2..R3
[36] call       0   2   1    ;  := R0(R1)
[37] getglobal  0   0        ; R0 := print
[38] loadk      1   2        ; R1 := 1
[39] loadk      2   1        ; R2 := 2
[40] loadk      3   14       ; R3 := 3
[41] concat     1   1   3    ; R1 := R1..R2..R3
[42] call       0   2   1    ;  := R0(R1)
[43] return     0   1        ; return 
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
002A  05                 maxstacksize (5)
                         * code:
002B  2B000000           sizecode (43)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  41400000           [02] loadk      1   1        ; R1 := 2
0037  1C400001           [03] call       0   2   1    ;  := R0(R1)
003B  05000000           [04] getglobal  0   0        ; R0 := print
003F  41800000           [05] loadk      1   2        ; R1 := 1
0043  1C400001           [06] call       0   2   1    ;  := R0(R1)
0047  05000000           [07] getglobal  0   0        ; R0 := print
004B  41C00000           [08] loadk      1   3        ; R1 := -1
004F  1C400001           [09] call       0   2   1    ;  := R0(R1)
0053  05000000           [10] getglobal  0   0        ; R0 := print
0057  41000100           [11] loadk      1   4        ; R1 := -2
005B  1C400001           [12] call       0   2   1    ;  := R0(R1)
005F  05000000           [13] getglobal  0   0        ; R0 := print
0063  41400100           [14] loadk      1   5        ; R1 := 5
0067  1C400001           [15] call       0   2   1    ;  := R0(R1)
006B  05000000           [16] getglobal  0   0        ; R0 := print
006F  41800100           [17] loadk      1   6        ; R1 := 262144
0073  1C400001           [18] call       0   2   1    ;  := R0(R1)
0077  05000000           [19] getglobal  0   0        ; R0 := print
007B  41C00100           [20] loadk      1   7        ; R1 := "hello"
007F  54008000           [21] len        1   1        ; R1 := #R1
0083  1C400001           [22] call       0   2   1    ;  := R0(R1)
0087  05000000           [23] getglobal  0   0        ; R0 := print
008B  4A008001           [24] newtable   1   3   0    ; R1 := {} , array=3, hash=0
008F  81000200           [25] loadk      2   8        ; R2 := 7
0093  C1400200           [26] loadk      3   9        ; R3 := 8
0097  01810200           [27] loadk      4   10       ; R4 := 9
009B  62408001           [28] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
009F  54008000           [29] len        1   1        ; R1 := #R1
00A3  1C400001           [30] call       0   2   1    ;  := R0(R1)
00A7  05000000           [31] getglobal  0   0        ; R0 := print
00AB  41C00200           [32] loadk      1   11       ; R1 := "a"
00AF  81000300           [33] loadk      2   12       ; R2 := "b"
00B3  C1400300           [34] loadk      3   13       ; R3 := "c"
00B7  55C08000           [35] concat     1   1   3    ; R1 := R1..R2..R3
00BB  1C400001           [36] call       0   2   1    ;  := R0(R1)
00BF  05000000           [37] getglobal  0   0        ; R0 := print
00C3  41800000           [38] loadk      1   2        ; R1 := 1
00C7  81400000           [39] loadk      2   1        ; R2 := 2
00CB  C1800300           [40] loadk      3   14       ; R3 := 3
00CF  55C08000           [41] concat     1   1   3    ; R1 := R1..R2..R3
00D3  1C400001           [42] call       0   2   1    ;  := R0(R1)
00D7  1E008000           [43] return     0   1        ; return 
                         * constants:
00DB  0F000000           sizek (15)
00DF  04                 const type 4
00E0  0600000000000000   string size (6)
00E8  7072696E7400       "print\0"
                         const [0]: "print"
00EE  03                 const type 3
00EF  0000000000000040   const [1]: (2)
00F7  03                 const type 3
00F8  000000000000F03F   const [2]: (1)
0100  03                 const type 3
0101  000000000000F0BF   const [3]: (-1)
0109  03                 const type 3
010A  00000000000000C0   const [4]: (-2)
0112  03                 const type 3
0113  0000000000001440   const [5]: (5)
011B  03                 const type 3
011C  0000000000001041   const [6]: (262144)
0124  04                 const type 4
0125  0600000000000000   string size (6)
012D  68656C6C6F00       "hello\0"
                         const [7]: "hello"
0133  03                 const type 3
0134  0000000000001C40   const [8]: (7)
013C  03                 const type 3
013D  0000000000002040   const [9]: (8)
0145  03                 const type 3
0146  0000000000002240   const [10]: (9)
014E  04                 const type 4
014F  0200000000000000   string size (2)
0157  6100               "a\0"
                         const [11]: "a"
0159  04                 const type 4
015A  0200000000000000   string size (2)
0162  6200               "b\0"
                         const [12]: "b"
0164  04                 const type 4
0165  0200000000000000   string size (2)
016D  6300               "c\0"
                         const [13]: "c"
016F  03                 const type 3
0170  0000000000000840   const [14]: (3)
                         * functions:
0178  00000000           sizep (0)
                         * lines:
017C  2B000000           sizelineinfo (43)
                         [pc] (line)
0180  09000000           [01] (9)
0184  09000000           [02] (9)
0188  09000000           [03] (9)
018C  0A000000           [04] (10)
0190  0A000000           [05] (10)
0194  0A000000           [06] (10)
0198  0B000000           [07] (11)
019C  0B000000           [08] (11)
01A0  0B000000           [09] (11)
01A4  0C000000           [10] (12)
01A8  0C000000           [11] (12)
01AC  0C000000           [12] (12)
01B0  0E000000           [13] (14)
01B4  0E000000           [14] (14)
01B8  0E000000           [15] (14)
01BC  0F000000           [16] (15)
01C0  0F000000           [17] (15)
01C4  0F000000           [18] (15)
01C8  15000000           [19] (21)
01CC  15000000           [20] (21)
01D0  15000000           [21] (21)
01D4  15000000           [22] (21)
01D8  16000000           [23] (22)
01DC  16000000           [24] (22)
01E0  16000000           [25] (22)
01E4  16000000           [26] (22)
01E8  16000000           [27] (22)
01EC  16000000           [28] (22)
01F0  16000000           [29] (22)
01F4  16000000           [30] (22)
01F8  18000000           [31] (24)
01FC  18000000           [32] (24)
0200  18000000           [33] (24)
0204  18000000           [34] (24)
0208  18000000           [35] (24)
020C  18000000           [36] (24)
0210  19000000           [37] (25)
0214  19000000           [38] (25)
0218  19000000           [39] (25)
021C  19000000           [40] (25)
0220  19000000           [41] (25)
0224  19000000           [42] (25)
0228  19000000           [43] (25)
                         * locals:
022C  00000000           sizelocvars (0)
                         * upvalues:
0230  00000000           sizeupvalues (0)
                         ** end of function 0 **

0234                     ** end of chunk **
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
002A  05                 maxstacksize (5)
                         * code:
002B  2B000000           sizecode (43)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  41400000           [02] loadk      1   1        ; R1 := 2
0037  1C400001           [03] call       0   2   1    ;  := R0(R1)
003B  05000000           [04] getglobal  0   0        ; R0 := print
003F  41800000           [05] loadk      1   2        ; R1 := 1
0043  1C400001           [06] call       0   2   1    ;  := R0(R1)
0047  05000000           [07] getglobal  0   0        ; R0 := print
004B  41C00000           [08] loadk      1   3        ; R1 := -1
004F  1C400001           [09] call       0   2   1    ;  := R0(R1)
0053  05000000           [10] getglobal  0   0        ; R0 := print
0057  41000100           [11] loadk      1   4        ; R1 := -2
005B  1C400001           [12] call       0   2   1    ;  := R0(R1)
005F  05000000           [13] getglobal  0   0        ; R0 := print
0063  41400100           [14] loadk      1   5        ; R1 := 5
0067  1C400001           [15] call       0   2   1    ;  := R0(R1)
006B  05000000           [16] getglobal  0   0        ; R0 := print
006F  41800100           [17] loadk      1   6        ; R1 := 262144
0073  1C400001           [18] call       0   2   1    ;  := R0(R1)
0077  05000000           [19] getglobal  0   0        ; R0 := print
007B  41C00100           [20] loadk      1   7        ; R1 := "hello"
007F  54008000           [21] len        1   1        ; R1 := #R1
0083  1C400001           [22] call       0   2   1    ;  := R0(R1)
0087  05000000           [23] getglobal  0   0        ; R0 := print
008B  4A008001           [24] newtable   1   3   0    ; R1 := {} , array=3, hash=0
008F  81000200           [25] loadk      2   8        ; R2 := 7
0093  C1400200           [26] loadk      3   9        ; R3 := 8
0097  01810200           [27] loadk      4   10       ; R4 := 9
009B  62408001           [28] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
009F  54008000           [29] len        1   1        ; R1 := #R1
00A3  1C400001           [30] call       0   2   1    ;  := R0(R1)
00A7  05000000           [31] getglobal  0   0        ; R0 := print
00AB  41C00200           [32] loadk      1   11       ; R1 := "a"
00AF  81000300           [33] loadk      2   12       ; R2 := "b"
00B3  C1400300           [34] loadk      3   13       ; R3 := "c"
00B7  55C08000           [35] concat     1   1   3    ; R1 := R1..R2..R3
00BB  1C400001           [36] call       0   2   1    ;  := R0(R1)
00BF  05000000           [37] getglobal  0   0        ; R0 := print
00C3  41800000           [38] loadk      1   2        ; R1 := 1
00C7  81400000           [39] loadk      2   1        ; R2 := 2
00CB  C1800300           [40] loadk      3   14       ; R3 := 3
00CF  55C08000           [41] concat     1   1   3    ; R1 := R1..R2..R3
00D3  1C400001           [42] call       0   2   1    ;  := R0(R1)
00D7  1E008000           [43] return     0   1        ; return 
                         * constants:
00DB  0F000000           sizek (15)
00DF  04                 const type 4
00E0  0600000000000000   string size (6)
00E8  7072696E7400       "print\0"
                         const [0]: "print"
00EE  03                 const type 3
00EF  0000000000000040   const [1]: (2)
00F7  03                 const type 3
00F8  000000000000F03F   const [2]: (1)
0100  03                 const type 3
0101  000000000000F0BF   const [3]: (-1)
0109  03                 const type 3
010A  00000000000000C0   const [4]: (-2)
0112  03                 const type 3
0113  0000000000001440   const [5]: (5)
011B  03                 const type 3
011C  0000000000001041   const [6]: (262144)
0124  04                 const type 4
0125  0600000000000000   string size (6)
012D  68656C6C6F00       "hello\0"
                         const [7]: "hello"
0133  03                 const type 3
0134  0000000000001C40   const [8]: (7)
013C  03                 const type 3
013D  0000000000002040   const [9]: (8)
0145  03                 const type 3
0146  0000000000002240   const [10]: (9)
014E  04                 const type 4
014F  0200000000000000   string size (2)
0157  6100               "a\0"
                         const [11]: "a"
0159  04                 const type 4
015A  0200000000000000   string size (2)
0162  6200               "b\0"
                         const [12]: "b"
0164  04                 const type 4
0165  0200000000000000   string size (2)
016D  6300               "c\0"
                         const [13]: "c"
016F  03                 const type 3
0170  0000000000000840   const [14]: (3)
                         * functions:
0178  00000000           sizep (0)
                         * lines:
017C  2B000000           sizelineinfo (43)
                         [pc] (line)
0180  09000000           [01] (9)
0184  09000000           [02] (9)
0188  09000000           [03] (9)
018C  0A000000           [04] (10)
0190  0A000000           [05] (10)
0194  0A000000           [06] (10)
0198  0B000000           [07] (11)
019C  0B000000           [08] (11)
01A0  0B000000           [09] (11)
01A4  0C000000           [10] (12)
01A8  0C000000           [11] (12)
01AC  0C000000           [12] (12)
01B0  0E000000           [13] (14)
01B4  0E000000           [14] (14)
01B8  0E000000           [15] (14)
01BC  0F000000           [16] (15)
01C0  0F000000           [17] (15)
01C4  0F000000           [18] (15)
01C8  15000000           [19] (21)
01CC  15000000           [20] (21)
01D0  15000000           [21] (21)
01D4  15000000           [22] (21)
01D8  16000000           [23] (22)
01DC  16000000           [24] (22)
01E0  16000000           [25] (22)
01E4  16000000           [26] (22)
01E8  16000000           [27] (22)
01EC  16000000           [28] (22)
01F0  16000000           [29] (22)
01F4  16000000           [30] (22)
01F8  18000000           [31] (24)
01FC  18000000           [32] (24)
0200  18000000           [33] (24)
0204  18000000           [34] (24)
0208  18000000           [35] (24)
020C  18000000           [36] (24)
0210  19000000           [37] (25)
0214  19000000           [38] (25)
0218  19000000           [39] (25)
021C  19000000           [40] (25)
0220  19000000           [41] (25)
0224  19000000           [42] (25)
0228  19000000           [43] (25)
                         * locals:
022C  00000000           sizelocvars (0)
                         * upvalues:
0230  00000000           sizeupvalues (0)
                         ** end of function 0 **

0234                     ** end of chunk **
