------------------------------
function f()
  local a, b = 1, 2; print(a, b)   -->	1	2
  local a, b = 3, 4; print(a, b)   -->	3	4
  do
    print(a, b)                    -->	3	4
    local a, b = 5, 6; print(a, b) -->	5	6
  end
  print(a, b)                      -->	3	4
end

f()
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f := R0
[3] getglobal  0   0        ; R0 := f
[4] call       0   1   1    ;  := R0()
[5] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 9 stacks
.function  0 0 0 9
.local  "a"  ; 0
.local  "b"  ; 1
.local  "a"  ; 2
.local  "b"  ; 3
.local  "a"  ; 4
.local  "b"  ; 5
.const  1  ; 0
.const  2  ; 1
.const  "print"  ; 2
.const  3  ; 3
.const  4  ; 4
.const  5  ; 5
.const  6  ; 6
[01] loadk      0   0        ; R0 := 1
[02] loadk      1   1        ; R1 := 2
[03] getglobal  2   2        ; R2 := print
[04] move       3   0        ; R3 := R0
[05] move       4   1        ; R4 := R1
[06] call       2   3   1    ;  := R2(R3, R4)
[07] loadk      2   3        ; R2 := 3
[08] loadk      3   4        ; R3 := 4
[09] getglobal  4   2        ; R4 := print
[10] move       5   2        ; R5 := R2
[11] move       6   3        ; R6 := R3
[12] call       4   3   1    ;  := R4(R5, R6)
[13] getglobal  4   2        ; R4 := print
[14] move       5   2        ; R5 := R2
[15] move       6   3        ; R6 := R3
[16] call       4   3   1    ;  := R4(R5, R6)
[17] loadk      4   5        ; R4 := 5
[18] loadk      5   6        ; R5 := 6
[19] getglobal  6   2        ; R6 := print
[20] move       7   4        ; R7 := R4
[21] move       8   5        ; R8 := R5
[22] call       6   3   1    ;  := R6(R7, R8)
[23] getglobal  4   2        ; R4 := print
[24] move       5   2        ; R5 := R2
[25] move       6   3        ; R6 := R3
[26] call       4   3   1    ;  := R4(R5, R6)
[27] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f := R0
[3] getglobal  0   0        ; R0 := f
[4] call       0   1   1    ;  := R0()
[5] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 9 stacks
.function  0 0 0 9
.local  "a"  ; 0
.local  "b"  ; 1
.local  "a"  ; 2
.local  "b"  ; 3
.local  "a"  ; 4
.local  "b"  ; 5
.const  1  ; 0
.const  2  ; 1
.const  "print"  ; 2
.const  3  ; 3
.const  4  ; 4
.const  5  ; 5
.const  6  ; 6
[01] loadk      0   0        ; R0 := 1
[02] loadk      1   1        ; R1 := 2
[03] getglobal  2   2        ; R2 := print
[04] move       3   0        ; R3 := R0
[05] move       4   1        ; R4 := R1
[06] call       2   3   1    ;  := R2(R3, R4)
[07] loadk      2   3        ; R2 := 3
[08] loadk      3   4        ; R3 := 4
[09] getglobal  4   2        ; R4 := print
[10] move       5   2        ; R5 := R2
[11] move       6   3        ; R6 := R3
[12] call       4   3   1    ;  := R4(R5, R6)
[13] getglobal  4   2        ; R4 := print
[14] move       5   2        ; R5 := R2
[15] move       6   3        ; R6 := R3
[16] call       4   3   1    ;  := R4(R5, R6)
[17] loadk      4   5        ; R4 := 5
[18] loadk      5   6        ; R5 := 6
[19] getglobal  6   2        ; R6 := print
[20] move       7   4        ; R7 := R4
[21] move       8   5        ; R8 := R5
[22] call       6   3   1    ;  := R6(R7, R8)
[23] getglobal  4   2        ; R4 := print
[24] move       5   2        ; R5 := R2
[25] move       6   3        ; R6 := R3
[26] call       4   3   1    ;  := R4(R5, R6)
[27] return     0   1        ; return 
; end of function 0_0

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
002A  02                 maxstacksize (2)
                         * code:
002B  05000000           sizecode (5)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f := R0
0037  05000000           [3] getglobal  0   0        ; R0 := f
003B  1C408000           [4] call       0   1   1    ;  := R0()
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  01000000           sizek (1)
0047  04                 const type 4
0048  0200000000000000   string size (2)
0050  6600               "f\0"
                         const [0]: "f"
                         * functions:
0052  01000000           sizep (1)
                         
0056                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0056  0000000000000000   string size (0)
                         source name: (none)
005E  01000000           line defined (1)
0062  09000000           last line defined (9)
0066  00                 nups (0)
0067  00                 numparams (0)
0068  00                 is_vararg (0)
0069  09                 maxstacksize (9)
                         * code:
006A  1B000000           sizecode (27)
006E  01000000           [01] loadk      0   0        ; R0 := 1
0072  41400000           [02] loadk      1   1        ; R1 := 2
0076  85800000           [03] getglobal  2   2        ; R2 := print
007A  C0000000           [04] move       3   0        ; R3 := R0
007E  00018000           [05] move       4   1        ; R4 := R1
0082  9C408001           [06] call       2   3   1    ;  := R2(R3, R4)
0086  81C00000           [07] loadk      2   3        ; R2 := 3
008A  C1000100           [08] loadk      3   4        ; R3 := 4
008E  05810000           [09] getglobal  4   2        ; R4 := print
0092  40010001           [10] move       5   2        ; R5 := R2
0096  80018001           [11] move       6   3        ; R6 := R3
009A  1C418001           [12] call       4   3   1    ;  := R4(R5, R6)
009E  05810000           [13] getglobal  4   2        ; R4 := print
00A2  40010001           [14] move       5   2        ; R5 := R2
00A6  80018001           [15] move       6   3        ; R6 := R3
00AA  1C418001           [16] call       4   3   1    ;  := R4(R5, R6)
00AE  01410100           [17] loadk      4   5        ; R4 := 5
00B2  41810100           [18] loadk      5   6        ; R5 := 6
00B6  85810000           [19] getglobal  6   2        ; R6 := print
00BA  C0010002           [20] move       7   4        ; R7 := R4
00BE  00028002           [21] move       8   5        ; R8 := R5
00C2  9C418001           [22] call       6   3   1    ;  := R6(R7, R8)
00C6  05810000           [23] getglobal  4   2        ; R4 := print
00CA  40010001           [24] move       5   2        ; R5 := R2
00CE  80018001           [25] move       6   3        ; R6 := R3
00D2  1C418001           [26] call       4   3   1    ;  := R4(R5, R6)
00D6  1E008000           [27] return     0   1        ; return 
                         * constants:
00DA  07000000           sizek (7)
00DE  03                 const type 3
00DF  000000000000F03F   const [0]: (1)
00E7  03                 const type 3
00E8  0000000000000040   const [1]: (2)
00F0  04                 const type 4
00F1  0600000000000000   string size (6)
00F9  7072696E7400       "print\0"
                         const [2]: "print"
00FF  03                 const type 3
0100  0000000000000840   const [3]: (3)
0108  03                 const type 3
0109  0000000000001040   const [4]: (4)
0111  03                 const type 3
0112  0000000000001440   const [5]: (5)
011A  03                 const type 3
011B  0000000000001840   const [6]: (6)
                         * functions:
0123  00000000           sizep (0)
                         * lines:
0127  1B000000           sizelineinfo (27)
                         [pc] (line)
012B  02000000           [01] (2)
012F  02000000           [02] (2)
0133  02000000           [03] (2)
0137  02000000           [04] (2)
013B  02000000           [05] (2)
013F  02000000           [06] (2)
0143  03000000           [07] (3)
0147  03000000           [08] (3)
014B  03000000           [09] (3)
014F  03000000           [10] (3)
0153  03000000           [11] (3)
0157  03000000           [12] (3)
015B  05000000           [13] (5)
015F  05000000           [14] (5)
0163  05000000           [15] (5)
0167  05000000           [16] (5)
016B  06000000           [17] (6)
016F  06000000           [18] (6)
0173  06000000           [19] (6)
0177  06000000           [20] (6)
017B  06000000           [21] (6)
017F  06000000           [22] (6)
0183  08000000           [23] (8)
0187  08000000           [24] (8)
018B  08000000           [25] (8)
018F  08000000           [26] (8)
0193  09000000           [27] (9)
                         * locals:
0197  06000000           sizelocvars (6)
019B  0200000000000000   string size (2)
01A3  6100               "a\0"
                         local [0]: a
01A5  02000000             startpc (2)
01A9  1A000000             endpc   (26)
01AD  0200000000000000   string size (2)
01B5  6200               "b\0"
                         local [1]: b
01B7  02000000             startpc (2)
01BB  1A000000             endpc   (26)
01BF  0200000000000000   string size (2)
01C7  6100               "a\0"
                         local [2]: a
01C9  08000000             startpc (8)
01CD  1A000000             endpc   (26)
01D1  0200000000000000   string size (2)
01D9  6200               "b\0"
                         local [3]: b
01DB  08000000             startpc (8)
01DF  1A000000             endpc   (26)
01E3  0200000000000000   string size (2)
01EB  6100               "a\0"
                         local [4]: a
01ED  12000000             startpc (18)
01F1  16000000             endpc   (22)
01F5  0200000000000000   string size (2)
01FD  6200               "b\0"
                         local [5]: b
01FF  12000000             startpc (18)
0203  16000000             endpc   (22)
                         * upvalues:
0207  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
020B  05000000           sizelineinfo (5)
                         [pc] (line)
020F  09000000           [1] (9)
0213  01000000           [2] (1)
0217  0B000000           [3] (11)
021B  0B000000           [4] (11)
021F  0B000000           [5] (11)
                         * locals:
0223  00000000           sizelocvars (0)
                         * upvalues:
0227  00000000           sizeupvalues (0)
                         ** end of function 0 **

022B                     ** end of chunk **
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
002A  02                 maxstacksize (2)
                         * code:
002B  05000000           sizecode (5)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f := R0
0037  05000000           [3] getglobal  0   0        ; R0 := f
003B  1C408000           [4] call       0   1   1    ;  := R0()
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  01000000           sizek (1)
0047  04                 const type 4
0048  0200000000000000   string size (2)
0050  6600               "f\0"
                         const [0]: "f"
                         * functions:
0052  01000000           sizep (1)
                         
0056                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0056  0000000000000000   string size (0)
                         source name: (none)
005E  01000000           line defined (1)
0062  09000000           last line defined (9)
0066  00                 nups (0)
0067  00                 numparams (0)
0068  00                 is_vararg (0)
0069  09                 maxstacksize (9)
                         * code:
006A  1B000000           sizecode (27)
006E  01000000           [01] loadk      0   0        ; R0 := 1
0072  41400000           [02] loadk      1   1        ; R1 := 2
0076  85800000           [03] getglobal  2   2        ; R2 := print
007A  C0000000           [04] move       3   0        ; R3 := R0
007E  00018000           [05] move       4   1        ; R4 := R1
0082  9C408001           [06] call       2   3   1    ;  := R2(R3, R4)
0086  81C00000           [07] loadk      2   3        ; R2 := 3
008A  C1000100           [08] loadk      3   4        ; R3 := 4
008E  05810000           [09] getglobal  4   2        ; R4 := print
0092  40010001           [10] move       5   2        ; R5 := R2
0096  80018001           [11] move       6   3        ; R6 := R3
009A  1C418001           [12] call       4   3   1    ;  := R4(R5, R6)
009E  05810000           [13] getglobal  4   2        ; R4 := print
00A2  40010001           [14] move       5   2        ; R5 := R2
00A6  80018001           [15] move       6   3        ; R6 := R3
00AA  1C418001           [16] call       4   3   1    ;  := R4(R5, R6)
00AE  01410100           [17] loadk      4   5        ; R4 := 5
00B2  41810100           [18] loadk      5   6        ; R5 := 6
00B6  85810000           [19] getglobal  6   2        ; R6 := print
00BA  C0010002           [20] move       7   4        ; R7 := R4
00BE  00028002           [21] move       8   5        ; R8 := R5
00C2  9C418001           [22] call       6   3   1    ;  := R6(R7, R8)
00C6  05810000           [23] getglobal  4   2        ; R4 := print
00CA  40010001           [24] move       5   2        ; R5 := R2
00CE  80018001           [25] move       6   3        ; R6 := R3
00D2  1C418001           [26] call       4   3   1    ;  := R4(R5, R6)
00D6  1E008000           [27] return     0   1        ; return 
                         * constants:
00DA  07000000           sizek (7)
00DE  03                 const type 3
00DF  000000000000F03F   const [0]: (1)
00E7  03                 const type 3
00E8  0000000000000040   const [1]: (2)
00F0  04                 const type 4
00F1  0600000000000000   string size (6)
00F9  7072696E7400       "print\0"
                         const [2]: "print"
00FF  03                 const type 3
0100  0000000000000840   const [3]: (3)
0108  03                 const type 3
0109  0000000000001040   const [4]: (4)
0111  03                 const type 3
0112  0000000000001440   const [5]: (5)
011A  03                 const type 3
011B  0000000000001840   const [6]: (6)
                         * functions:
0123  00000000           sizep (0)
                         * lines:
0127  1B000000           sizelineinfo (27)
                         [pc] (line)
012B  02000000           [01] (2)
012F  02000000           [02] (2)
0133  02000000           [03] (2)
0137  02000000           [04] (2)
013B  02000000           [05] (2)
013F  02000000           [06] (2)
0143  03000000           [07] (3)
0147  03000000           [08] (3)
014B  03000000           [09] (3)
014F  03000000           [10] (3)
0153  03000000           [11] (3)
0157  03000000           [12] (3)
015B  05000000           [13] (5)
015F  05000000           [14] (5)
0163  05000000           [15] (5)
0167  05000000           [16] (5)
016B  06000000           [17] (6)
016F  06000000           [18] (6)
0173  06000000           [19] (6)
0177  06000000           [20] (6)
017B  06000000           [21] (6)
017F  06000000           [22] (6)
0183  08000000           [23] (8)
0187  08000000           [24] (8)
018B  08000000           [25] (8)
018F  08000000           [26] (8)
0193  09000000           [27] (9)
                         * locals:
0197  06000000           sizelocvars (6)
019B  0200000000000000   string size (2)
01A3  6100               "a\0"
                         local [0]: a
01A5  02000000             startpc (2)
01A9  1A000000             endpc   (26)
01AD  0200000000000000   string size (2)
01B5  6200               "b\0"
                         local [1]: b
01B7  02000000             startpc (2)
01BB  1A000000             endpc   (26)
01BF  0200000000000000   string size (2)
01C7  6100               "a\0"
                         local [2]: a
01C9  08000000             startpc (8)
01CD  1A000000             endpc   (26)
01D1  0200000000000000   string size (2)
01D9  6200               "b\0"
                         local [3]: b
01DB  08000000             startpc (8)
01DF  1A000000             endpc   (26)
01E3  0200000000000000   string size (2)
01EB  6100               "a\0"
                         local [4]: a
01ED  12000000             startpc (18)
01F1  16000000             endpc   (22)
01F5  0200000000000000   string size (2)
01FD  6200               "b\0"
                         local [5]: b
01FF  12000000             startpc (18)
0203  16000000             endpc   (22)
                         * upvalues:
0207  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
020B  05000000           sizelineinfo (5)
                         [pc] (line)
020F  09000000           [1] (9)
0213  01000000           [2] (1)
0217  0B000000           [3] (11)
021B  0B000000           [4] (11)
021F  0B000000           [5] (11)
                         * locals:
0223  00000000           sizelocvars (0)
                         * upvalues:
0227  00000000           sizeupvalues (0)
                         ** end of function 0 **

022B                     ** end of chunk **
