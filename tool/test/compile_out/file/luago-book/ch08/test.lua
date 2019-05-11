------------------------------
local function max(...)
  local args = {...}
  local val, idx
  for i = 1, #args do
    if val == nil or args[i] > val then
      val, idx = args[i], i
    end
  end
  return val, idx
end

local function assert(v)
  if not v then fail() end
end

local v1 = max(3, 9, 7, 128, 35)
assert(v1 == 128)
local v2, i2 = max(3, 9, 7, 128, 35)
assert(v2 == 128 and i2 == 4)
local v3, i3 = max(max(3, 9, 7, 128, 35))
assert(v3 == 128 and i3 == 1)
local t = {max(3, 9, 7, 128, 35)}
assert(t[1] == 128 and t[2] == 4)

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 14 stacks
.function  0 0 2 14
.local  "max"  ; 0
.local  "assert"  ; 1
.local  "v1"  ; 2
.local  "v2"  ; 3
.local  "i2"  ; 4
.local  "v3"  ; 5
.local  "i3"  ; 6
.local  "t"  ; 7
.const  3  ; 0
.const  9  ; 1
.const  7  ; 2
.const  128  ; 3
.const  35  ; 4
.const  4  ; 5
.const  1  ; 6
.const  2  ; 7
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[03] move       2   0        ; R2 := R0
[04] loadk      3   0        ; R3 := 3
[05] loadk      4   1        ; R4 := 9
[06] loadk      5   2        ; R5 := 7
[07] loadk      6   3        ; R6 := 128
[08] loadk      7   4        ; R7 := 35
[09] call       2   6   2    ; R2 := R2(R3 to R7)
[10] move       3   1        ; R3 := R1
[11] eq         1   2   259  ; R2 == 128, pc+=1 (goto [13]) if false
[12] jmp        1            ; pc+=1 (goto [14])
[13] loadbool   4   0   1    ; R4 := false; PC := pc+=1 (goto [15])
[14] loadbool   4   1   0    ; R4 := true
[15] call       3   2   1    ;  := R3(R4)
[16] move       3   0        ; R3 := R0
[17] loadk      4   0        ; R4 := 3
[18] loadk      5   1        ; R5 := 9
[19] loadk      6   2        ; R6 := 7
[20] loadk      7   3        ; R7 := 128
[21] loadk      8   4        ; R8 := 35
[22] call       3   6   3    ; R3, R4 := R3(R4 to R8)
[23] move       5   1        ; R5 := R1
[24] eq         0   3   259  ; R3 == 128, pc+=1 (goto [26]) if true
[25] jmp        2            ; pc+=2 (goto [28])
[26] eq         1   4   261  ; R4 == 4, pc+=1 (goto [28]) if false
[27] jmp        1            ; pc+=1 (goto [29])
[28] loadbool   6   0   1    ; R6 := false; PC := pc+=1 (goto [30])
[29] loadbool   6   1   0    ; R6 := true
[30] call       5   2   1    ;  := R5(R6)
[31] move       5   0        ; R5 := R0
[32] move       6   0        ; R6 := R0
[33] loadk      7   0        ; R7 := 3
[34] loadk      8   1        ; R8 := 9
[35] loadk      9   2        ; R9 := 7
[36] loadk      10  3        ; R10 := 128
[37] loadk      11  4        ; R11 := 35
[38] call       6   6   0    ; R6 to top := R6(R7 to R11)
[39] call       5   0   3    ; R5, R6 := R5(R6 to top)
[40] move       7   1        ; R7 := R1
[41] eq         0   5   259  ; R5 == 128, pc+=1 (goto [43]) if true
[42] jmp        2            ; pc+=2 (goto [45])
[43] eq         1   6   262  ; R6 == 1, pc+=1 (goto [45]) if false
[44] jmp        1            ; pc+=1 (goto [46])
[45] loadbool   8   0   1    ; R8 := false; PC := pc+=1 (goto [47])
[46] loadbool   8   1   0    ; R8 := true
[47] call       7   2   1    ;  := R7(R8)
[48] newtable   7   0   0    ; R7 := {} , array=0, hash=0
[49] move       8   0        ; R8 := R0
[50] loadk      9   0        ; R9 := 3
[51] loadk      10  1        ; R10 := 9
[52] loadk      11  2        ; R11 := 7
[53] loadk      12  3        ; R12 := 128
[54] loadk      13  4        ; R13 := 35
[55] call       8   6   0    ; R8 to top := R8(R9 to R13)
[56] setlist    7   0   1    ; R7[1 to top] := R8 to top
[57] move       8   1        ; R8 := R1
[58] gettable   9   7   262  ; R9 := R7[1]
[59] eq         0   9   259  ; R9 == 128, pc+=1 (goto [61]) if true
[60] jmp        3            ; pc+=3 (goto [64])
[61] gettable   9   7   263  ; R9 := R7[2]
[62] eq         1   9   261  ; R9 == 4, pc+=1 (goto [64]) if false
[63] jmp        1            ; pc+=1 (goto [65])
[64] loadbool   9   0   1    ; R9 := false; PC := pc+=1 (goto [66])
[65] loadbool   9   1   0    ; R9 := true
[66] call       8   2   1    ;  := R8(R9)
[67] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 3, 9 stacks
.function  0 0 3 9
.local  "arg"  ; 0
.local  "args"  ; 1
.local  "val"  ; 2
.local  "idx"  ; 3
.local  "(for index)"  ; 4
.local  "(for limit)"  ; 5
.local  "(for step)"  ; 6
.local  "i"  ; 7
.const  1  ; 0
.const  nil  ; 1
[01] newtable   1   0   0    ; R1 := {} , array=0, hash=0
[02] vararg     2   0        ; R2 to top := ...
[03] setlist    1   0   1    ; R1[1 to top] := R2 to top
[04] loadnil    2   3        ; R2, R3,  := nil
[05] loadk      4   0        ; R4 := 1
[06] len        5   1        ; R5 := #R1
[07] loadk      6   0        ; R6 := 1
[08] forprep    4   8        ; R4 -= R6; PC := 17
[09] eq         1   2   257  ; R2 == nil, pc+=1 (goto [11]) if false
[10] jmp        3            ; pc+=3 (goto [14])
[11] gettable   8   1   7    ; R8 := R1[R7]
[12] lt         0   2   8    ; R2 < R8, pc+=1 (goto [14]) if true
[13] jmp        3            ; pc+=3 (goto [17])
[14] gettable   8   1   7    ; R8 := R1[R7]
[15] move       3   7        ; R3 := R7
[16] move       2   8        ; R2 := R8
[17] forloop    4   -9       ; R4 += R6; if R4 <= R5 then begin PC := 9; R7 := R4 end
[18] move       4   2        ; R4 := R2
[19] move       5   3        ; R5 := R3
[20] return     4   3        ; return R4, R5
[21] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "v"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 14 stacks
.function  0 0 2 14
.local  "max"  ; 0
.local  "assert"  ; 1
.local  "v1"  ; 2
.local  "v2"  ; 3
.local  "i2"  ; 4
.local  "v3"  ; 5
.local  "i3"  ; 6
.local  "t"  ; 7
.const  3  ; 0
.const  9  ; 1
.const  7  ; 2
.const  128  ; 3
.const  35  ; 4
.const  4  ; 5
.const  1  ; 6
.const  2  ; 7
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[03] move       2   0        ; R2 := R0
[04] loadk      3   0        ; R3 := 3
[05] loadk      4   1        ; R4 := 9
[06] loadk      5   2        ; R5 := 7
[07] loadk      6   3        ; R6 := 128
[08] loadk      7   4        ; R7 := 35
[09] call       2   6   2    ; R2 := R2(R3 to R7)
[10] move       3   1        ; R3 := R1
[11] eq         1   2   259  ; R2 == 128, pc+=1 (goto [13]) if false
[12] jmp        1            ; pc+=1 (goto [14])
[13] loadbool   4   0   1    ; R4 := false; PC := pc+=1 (goto [15])
[14] loadbool   4   1   0    ; R4 := true
[15] call       3   2   1    ;  := R3(R4)
[16] move       3   0        ; R3 := R0
[17] loadk      4   0        ; R4 := 3
[18] loadk      5   1        ; R5 := 9
[19] loadk      6   2        ; R6 := 7
[20] loadk      7   3        ; R7 := 128
[21] loadk      8   4        ; R8 := 35
[22] call       3   6   3    ; R3, R4 := R3(R4 to R8)
[23] move       5   1        ; R5 := R1
[24] eq         0   3   259  ; R3 == 128, pc+=1 (goto [26]) if true
[25] jmp        2            ; pc+=2 (goto [28])
[26] eq         1   4   261  ; R4 == 4, pc+=1 (goto [28]) if false
[27] jmp        1            ; pc+=1 (goto [29])
[28] loadbool   6   0   1    ; R6 := false; PC := pc+=1 (goto [30])
[29] loadbool   6   1   0    ; R6 := true
[30] call       5   2   1    ;  := R5(R6)
[31] move       5   0        ; R5 := R0
[32] move       6   0        ; R6 := R0
[33] loadk      7   0        ; R7 := 3
[34] loadk      8   1        ; R8 := 9
[35] loadk      9   2        ; R9 := 7
[36] loadk      10  3        ; R10 := 128
[37] loadk      11  4        ; R11 := 35
[38] call       6   6   0    ; R6 to top := R6(R7 to R11)
[39] call       5   0   3    ; R5, R6 := R5(R6 to top)
[40] move       7   1        ; R7 := R1
[41] eq         0   5   259  ; R5 == 128, pc+=1 (goto [43]) if true
[42] jmp        2            ; pc+=2 (goto [45])
[43] eq         1   6   262  ; R6 == 1, pc+=1 (goto [45]) if false
[44] jmp        1            ; pc+=1 (goto [46])
[45] loadbool   8   0   1    ; R8 := false; PC := pc+=1 (goto [47])
[46] loadbool   8   1   0    ; R8 := true
[47] call       7   2   1    ;  := R7(R8)
[48] newtable   7   0   0    ; R7 := {} , array=0, hash=0
[49] move       8   0        ; R8 := R0
[50] loadk      9   0        ; R9 := 3
[51] loadk      10  1        ; R10 := 9
[52] loadk      11  2        ; R11 := 7
[53] loadk      12  3        ; R12 := 128
[54] loadk      13  4        ; R13 := 35
[55] call       8   6   0    ; R8 to top := R8(R9 to R13)
[56] setlist    7   0   1    ; R7[1 to top] := R8 to top
[57] move       8   1        ; R8 := R1
[58] gettable   9   7   262  ; R9 := R7[1]
[59] eq         0   9   259  ; R9 == 128, pc+=1 (goto [61]) if true
[60] jmp        3            ; pc+=3 (goto [64])
[61] gettable   9   7   263  ; R9 := R7[2]
[62] eq         1   9   261  ; R9 == 4, pc+=1 (goto [64]) if false
[63] jmp        1            ; pc+=1 (goto [65])
[64] loadbool   9   0   1    ; R9 := false; PC := pc+=1 (goto [66])
[65] loadbool   9   1   0    ; R9 := true
[66] call       8   2   1    ;  := R8(R9)
[67] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 3, 9 stacks
.function  0 0 3 9
.local  "arg"  ; 0
.local  "args"  ; 1
.local  "val"  ; 2
.local  "idx"  ; 3
.local  "(for index)"  ; 4
.local  "(for limit)"  ; 5
.local  "(for step)"  ; 6
.local  "i"  ; 7
.const  1  ; 0
.const  nil  ; 1
[01] newtable   1   0   0    ; R1 := {} , array=0, hash=0
[02] vararg     2   0        ; R2 to top := ...
[03] setlist    1   0   1    ; R1[1 to top] := R2 to top
[04] loadnil    2   3        ; R2, R3,  := nil
[05] loadk      4   0        ; R4 := 1
[06] len        5   1        ; R5 := #R1
[07] loadk      6   0        ; R6 := 1
[08] forprep    4   8        ; R4 -= R6; PC := 17
[09] eq         1   2   257  ; R2 == nil, pc+=1 (goto [11]) if false
[10] jmp        3            ; pc+=3 (goto [14])
[11] gettable   8   1   7    ; R8 := R1[R7]
[12] lt         0   2   8    ; R2 < R8, pc+=1 (goto [14]) if true
[13] jmp        3            ; pc+=3 (goto [17])
[14] gettable   8   1   7    ; R8 := R1[R7]
[15] move       3   7        ; R3 := R7
[16] move       2   8        ; R2 := R8
[17] forloop    4   -9       ; R4 += R6; if R4 <= R5 then begin PC := 9; R7 := R4 end
[18] move       4   2        ; R4 := R2
[19] move       5   3        ; R5 := R3
[20] return     4   3        ; return R4, R5
[21] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "v"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
; end of function 0_1

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
002A  0E                 maxstacksize (14)
                         * code:
002B  43000000           sizecode (67)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  64400000           [02] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
0037  80000000           [03] move       2   0        ; R2 := R0
003B  C1000000           [04] loadk      3   0        ; R3 := 3
003F  01410000           [05] loadk      4   1        ; R4 := 9
0043  41810000           [06] loadk      5   2        ; R5 := 7
0047  81C10000           [07] loadk      6   3        ; R6 := 128
004B  C1010100           [08] loadk      7   4        ; R7 := 35
004F  9C800003           [09] call       2   6   2    ; R2 := R2(R3 to R7)
0053  C0008000           [10] move       3   1        ; R3 := R1
0057  57C04001           [11] eq         1   2   259  ; R2 == 128, pc+=1 (goto [13]) if false
005B  16000080           [12] jmp        1            ; pc+=1 (goto [14])
005F  02410000           [13] loadbool   4   0   1    ; R4 := false; PC := pc+=1 (goto [15])
0063  02018000           [14] loadbool   4   1   0    ; R4 := true
0067  DC400001           [15] call       3   2   1    ;  := R3(R4)
006B  C0000000           [16] move       3   0        ; R3 := R0
006F  01010000           [17] loadk      4   0        ; R4 := 3
0073  41410000           [18] loadk      5   1        ; R5 := 9
0077  81810000           [19] loadk      6   2        ; R6 := 7
007B  C1C10000           [20] loadk      7   3        ; R7 := 128
007F  01020100           [21] loadk      8   4        ; R8 := 35
0083  DCC00003           [22] call       3   6   3    ; R3, R4 := R3(R4 to R8)
0087  40018000           [23] move       5   1        ; R5 := R1
008B  17C0C001           [24] eq         0   3   259  ; R3 == 128, pc+=1 (goto [26]) if true
008F  16400080           [25] jmp        2            ; pc+=2 (goto [28])
0093  57404102           [26] eq         1   4   261  ; R4 == 4, pc+=1 (goto [28]) if false
0097  16000080           [27] jmp        1            ; pc+=1 (goto [29])
009B  82410000           [28] loadbool   6   0   1    ; R6 := false; PC := pc+=1 (goto [30])
009F  82018000           [29] loadbool   6   1   0    ; R6 := true
00A3  5C410001           [30] call       5   2   1    ;  := R5(R6)
00A7  40010000           [31] move       5   0        ; R5 := R0
00AB  80010000           [32] move       6   0        ; R6 := R0
00AF  C1010000           [33] loadk      7   0        ; R7 := 3
00B3  01420000           [34] loadk      8   1        ; R8 := 9
00B7  41820000           [35] loadk      9   2        ; R9 := 7
00BB  81C20000           [36] loadk      10  3        ; R10 := 128
00BF  C1020100           [37] loadk      11  4        ; R11 := 35
00C3  9C010003           [38] call       6   6   0    ; R6 to top := R6(R7 to R11)
00C7  5CC10000           [39] call       5   0   3    ; R5, R6 := R5(R6 to top)
00CB  C0018000           [40] move       7   1        ; R7 := R1
00CF  17C0C002           [41] eq         0   5   259  ; R5 == 128, pc+=1 (goto [43]) if true
00D3  16400080           [42] jmp        2            ; pc+=2 (goto [45])
00D7  57804103           [43] eq         1   6   262  ; R6 == 1, pc+=1 (goto [45]) if false
00DB  16000080           [44] jmp        1            ; pc+=1 (goto [46])
00DF  02420000           [45] loadbool   8   0   1    ; R8 := false; PC := pc+=1 (goto [47])
00E3  02028000           [46] loadbool   8   1   0    ; R8 := true
00E7  DC410001           [47] call       7   2   1    ;  := R7(R8)
00EB  CA010000           [48] newtable   7   0   0    ; R7 := {} , array=0, hash=0
00EF  00020000           [49] move       8   0        ; R8 := R0
00F3  41020000           [50] loadk      9   0        ; R9 := 3
00F7  81420000           [51] loadk      10  1        ; R10 := 9
00FB  C1820000           [52] loadk      11  2        ; R11 := 7
00FF  01C30000           [53] loadk      12  3        ; R12 := 128
0103  41030100           [54] loadk      13  4        ; R13 := 35
0107  1C020003           [55] call       8   6   0    ; R8 to top := R8(R9 to R13)
010B  E2410000           [56] setlist    7   0   1    ; R7[1 to top] := R8 to top
010F  00028000           [57] move       8   1        ; R8 := R1
0113  4682C103           [58] gettable   9   7   262  ; R9 := R7[1]
0117  17C0C004           [59] eq         0   9   259  ; R9 == 128, pc+=1 (goto [61]) if true
011B  16800080           [60] jmp        3            ; pc+=3 (goto [64])
011F  46C2C103           [61] gettable   9   7   263  ; R9 := R7[2]
0123  5740C104           [62] eq         1   9   261  ; R9 == 4, pc+=1 (goto [64]) if false
0127  16000080           [63] jmp        1            ; pc+=1 (goto [65])
012B  42420000           [64] loadbool   9   0   1    ; R9 := false; PC := pc+=1 (goto [66])
012F  42028000           [65] loadbool   9   1   0    ; R9 := true
0133  1C420001           [66] call       8   2   1    ;  := R8(R9)
0137  1E008000           [67] return     0   1        ; return 
                         * constants:
013B  08000000           sizek (8)
013F  03                 const type 3
0140  0000000000000840   const [0]: (3)
0148  03                 const type 3
0149  0000000000002240   const [1]: (9)
0151  03                 const type 3
0152  0000000000001C40   const [2]: (7)
015A  03                 const type 3
015B  0000000000006040   const [3]: (128)
0163  03                 const type 3
0164  0000000000804140   const [4]: (35)
016C  03                 const type 3
016D  0000000000001040   const [5]: (4)
0175  03                 const type 3
0176  000000000000F03F   const [6]: (1)
017E  03                 const type 3
017F  0000000000000040   const [7]: (2)
                         * functions:
0187  02000000           sizep (2)
                         
018B                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
018B  0000000000000000   string size (0)
                         source name: (none)
0193  01000000           line defined (1)
0197  0A000000           last line defined (10)
019B  00                 nups (0)
019C  00                 numparams (0)
019D  03                 is_vararg (3)
019E  09                 maxstacksize (9)
                         * code:
019F  15000000           sizecode (21)
01A3  4A000000           [01] newtable   1   0   0    ; R1 := {} , array=0, hash=0
01A7  A5000000           [02] vararg     2   0        ; R2 to top := ...
01AB  62400000           [03] setlist    1   0   1    ; R1[1 to top] := R2 to top
01AF  83008001           [04] loadnil    2   3        ; R2, R3,  := nil
01B3  01010000           [05] loadk      4   0        ; R4 := 1
01B7  54018000           [06] len        5   1        ; R5 := #R1
01BB  81010000           [07] loadk      6   0        ; R6 := 1
01BF  20C10180           [08] forprep    4   8        ; R4 -= R6; PC := 17
01C3  57404001           [09] eq         1   2   257  ; R2 == nil, pc+=1 (goto [11]) if false
01C7  16800080           [10] jmp        3            ; pc+=3 (goto [14])
01CB  06C28100           [11] gettable   8   1   7    ; R8 := R1[R7]
01CF  18000201           [12] lt         0   2   8    ; R2 < R8, pc+=1 (goto [14]) if true
01D3  16800080           [13] jmp        3            ; pc+=3 (goto [17])
01D7  06C28100           [14] gettable   8   1   7    ; R8 := R1[R7]
01DB  C0008003           [15] move       3   7        ; R3 := R7
01DF  80000004           [16] move       2   8        ; R2 := R8
01E3  1F81FD7F           [17] forloop    4   -9       ; R4 += R6; if R4 <= R5 then begin PC := 9; R7 := R4 end
01E7  00010001           [18] move       4   2        ; R4 := R2
01EB  40018001           [19] move       5   3        ; R5 := R3
01EF  1E018001           [20] return     4   3        ; return R4, R5
01F3  1E008000           [21] return     0   1        ; return 
                         * constants:
01F7  02000000           sizek (2)
01FB  03                 const type 3
01FC  000000000000F03F   const [0]: (1)
0204  00                 const type 0
                         const [1]: nil
                         * functions:
0205  00000000           sizep (0)
                         * lines:
0209  15000000           sizelineinfo (21)
                         [pc] (line)
020D  02000000           [01] (2)
0211  02000000           [02] (2)
0215  02000000           [03] (2)
0219  03000000           [04] (3)
021D  04000000           [05] (4)
0221  04000000           [06] (4)
0225  04000000           [07] (4)
0229  04000000           [08] (4)
022D  05000000           [09] (5)
0231  05000000           [10] (5)
0235  05000000           [11] (5)
0239  05000000           [12] (5)
023D  05000000           [13] (5)
0241  06000000           [14] (6)
0245  06000000           [15] (6)
0249  06000000           [16] (6)
024D  04000000           [17] (4)
0251  09000000           [18] (9)
0255  09000000           [19] (9)
0259  09000000           [20] (9)
025D  0A000000           [21] (10)
                         * locals:
0261  08000000           sizelocvars (8)
0265  0400000000000000   string size (4)
026D  61726700           "arg\0"
                         local [0]: arg
0271  00000000             startpc (0)
0275  14000000             endpc   (20)
0279  0500000000000000   string size (5)
0281  6172677300         "args\0"
                         local [1]: args
0286  03000000             startpc (3)
028A  14000000             endpc   (20)
028E  0400000000000000   string size (4)
0296  76616C00           "val\0"
                         local [2]: val
029A  04000000             startpc (4)
029E  14000000             endpc   (20)
02A2  0400000000000000   string size (4)
02AA  69647800           "idx\0"
                         local [3]: idx
02AE  04000000             startpc (4)
02B2  14000000             endpc   (20)
02B6  0C00000000000000   string size (12)
02BE  28666F7220696E64+  "(for ind"
02C6  65782900           "ex)\0"
                         local [4]: (for index)
02CA  07000000             startpc (7)
02CE  11000000             endpc   (17)
02D2  0C00000000000000   string size (12)
02DA  28666F72206C696D+  "(for lim"
02E2  69742900           "it)\0"
                         local [5]: (for limit)
02E6  07000000             startpc (7)
02EA  11000000             endpc   (17)
02EE  0B00000000000000   string size (11)
02F6  28666F7220737465+  "(for ste"
02FE  702900             "p)\0"
                         local [6]: (for step)
0301  07000000             startpc (7)
0305  11000000             endpc   (17)
0309  0200000000000000   string size (2)
0311  6900               "i\0"
                         local [7]: i
0313  08000000             startpc (8)
0317  10000000             endpc   (16)
                         * upvalues:
031B  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
031F                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
031F  0000000000000000   string size (0)
                         source name: (none)
0327  0C000000           line defined (12)
032B  0E000000           last line defined (14)
032F  00                 nups (0)
0330  01                 numparams (1)
0331  00                 is_vararg (0)
0332  02                 maxstacksize (2)
                         * code:
0333  05000000           sizecode (5)
0337  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
033B  16400080           [2] jmp        2            ; pc+=2 (goto [5])
033F  45000000           [3] getglobal  1   0        ; R1 := fail
0343  5C408000           [4] call       1   1   1    ;  := R1()
0347  1E008000           [5] return     0   1        ; return 
                         * constants:
034B  01000000           sizek (1)
034F  04                 const type 4
0350  0500000000000000   string size (5)
0358  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
035D  00000000           sizep (0)
                         * lines:
0361  05000000           sizelineinfo (5)
                         [pc] (line)
0365  0D000000           [1] (13)
0369  0D000000           [2] (13)
036D  0D000000           [3] (13)
0371  0D000000           [4] (13)
0375  0E000000           [5] (14)
                         * locals:
0379  01000000           sizelocvars (1)
037D  0200000000000000   string size (2)
0385  7600               "v\0"
                         local [0]: v
0387  00000000             startpc (0)
038B  04000000             endpc   (4)
                         * upvalues:
038F  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
0393  43000000           sizelineinfo (67)
                         [pc] (line)
0397  0A000000           [01] (10)
039B  0E000000           [02] (14)
039F  10000000           [03] (16)
03A3  10000000           [04] (16)
03A7  10000000           [05] (16)
03AB  10000000           [06] (16)
03AF  10000000           [07] (16)
03B3  10000000           [08] (16)
03B7  10000000           [09] (16)
03BB  11000000           [10] (17)
03BF  11000000           [11] (17)
03C3  11000000           [12] (17)
03C7  11000000           [13] (17)
03CB  11000000           [14] (17)
03CF  11000000           [15] (17)
03D3  12000000           [16] (18)
03D7  12000000           [17] (18)
03DB  12000000           [18] (18)
03DF  12000000           [19] (18)
03E3  12000000           [20] (18)
03E7  12000000           [21] (18)
03EB  12000000           [22] (18)
03EF  13000000           [23] (19)
03F3  13000000           [24] (19)
03F7  13000000           [25] (19)
03FB  13000000           [26] (19)
03FF  13000000           [27] (19)
0403  13000000           [28] (19)
0407  13000000           [29] (19)
040B  13000000           [30] (19)
040F  14000000           [31] (20)
0413  14000000           [32] (20)
0417  14000000           [33] (20)
041B  14000000           [34] (20)
041F  14000000           [35] (20)
0423  14000000           [36] (20)
0427  14000000           [37] (20)
042B  14000000           [38] (20)
042F  14000000           [39] (20)
0433  15000000           [40] (21)
0437  15000000           [41] (21)
043B  15000000           [42] (21)
043F  15000000           [43] (21)
0443  15000000           [44] (21)
0447  15000000           [45] (21)
044B  15000000           [46] (21)
044F  15000000           [47] (21)
0453  16000000           [48] (22)
0457  16000000           [49] (22)
045B  16000000           [50] (22)
045F  16000000           [51] (22)
0463  16000000           [52] (22)
0467  16000000           [53] (22)
046B  16000000           [54] (22)
046F  16000000           [55] (22)
0473  16000000           [56] (22)
0477  17000000           [57] (23)
047B  17000000           [58] (23)
047F  17000000           [59] (23)
0483  17000000           [60] (23)
0487  17000000           [61] (23)
048B  17000000           [62] (23)
048F  17000000           [63] (23)
0493  17000000           [64] (23)
0497  17000000           [65] (23)
049B  17000000           [66] (23)
049F  17000000           [67] (23)
                         * locals:
04A3  08000000           sizelocvars (8)
04A7  0400000000000000   string size (4)
04AF  6D617800           "max\0"
                         local [0]: max
04B3  01000000             startpc (1)
04B7  42000000             endpc   (66)
04BB  0700000000000000   string size (7)
04C3  61737365727400     "assert\0"
                         local [1]: assert
04CA  02000000             startpc (2)
04CE  42000000             endpc   (66)
04D2  0300000000000000   string size (3)
04DA  763100             "v1\0"
                         local [2]: v1
04DD  09000000             startpc (9)
04E1  42000000             endpc   (66)
04E5  0300000000000000   string size (3)
04ED  763200             "v2\0"
                         local [3]: v2
04F0  16000000             startpc (22)
04F4  42000000             endpc   (66)
04F8  0300000000000000   string size (3)
0500  693200             "i2\0"
                         local [4]: i2
0503  16000000             startpc (22)
0507  42000000             endpc   (66)
050B  0300000000000000   string size (3)
0513  763300             "v3\0"
                         local [5]: v3
0516  27000000             startpc (39)
051A  42000000             endpc   (66)
051E  0300000000000000   string size (3)
0526  693300             "i3\0"
                         local [6]: i3
0529  27000000             startpc (39)
052D  42000000             endpc   (66)
0531  0200000000000000   string size (2)
0539  7400               "t\0"
                         local [7]: t
053B  38000000             startpc (56)
053F  42000000             endpc   (66)
                         * upvalues:
0543  00000000           sizeupvalues (0)
                         ** end of function 0 **

0547                     ** end of chunk **
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
002A  0E                 maxstacksize (14)
                         * code:
002B  43000000           sizecode (67)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  64400000           [02] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
0037  80000000           [03] move       2   0        ; R2 := R0
003B  C1000000           [04] loadk      3   0        ; R3 := 3
003F  01410000           [05] loadk      4   1        ; R4 := 9
0043  41810000           [06] loadk      5   2        ; R5 := 7
0047  81C10000           [07] loadk      6   3        ; R6 := 128
004B  C1010100           [08] loadk      7   4        ; R7 := 35
004F  9C800003           [09] call       2   6   2    ; R2 := R2(R3 to R7)
0053  C0008000           [10] move       3   1        ; R3 := R1
0057  57C04001           [11] eq         1   2   259  ; R2 == 128, pc+=1 (goto [13]) if false
005B  16000080           [12] jmp        1            ; pc+=1 (goto [14])
005F  02410000           [13] loadbool   4   0   1    ; R4 := false; PC := pc+=1 (goto [15])
0063  02018000           [14] loadbool   4   1   0    ; R4 := true
0067  DC400001           [15] call       3   2   1    ;  := R3(R4)
006B  C0000000           [16] move       3   0        ; R3 := R0
006F  01010000           [17] loadk      4   0        ; R4 := 3
0073  41410000           [18] loadk      5   1        ; R5 := 9
0077  81810000           [19] loadk      6   2        ; R6 := 7
007B  C1C10000           [20] loadk      7   3        ; R7 := 128
007F  01020100           [21] loadk      8   4        ; R8 := 35
0083  DCC00003           [22] call       3   6   3    ; R3, R4 := R3(R4 to R8)
0087  40018000           [23] move       5   1        ; R5 := R1
008B  17C0C001           [24] eq         0   3   259  ; R3 == 128, pc+=1 (goto [26]) if true
008F  16400080           [25] jmp        2            ; pc+=2 (goto [28])
0093  57404102           [26] eq         1   4   261  ; R4 == 4, pc+=1 (goto [28]) if false
0097  16000080           [27] jmp        1            ; pc+=1 (goto [29])
009B  82410000           [28] loadbool   6   0   1    ; R6 := false; PC := pc+=1 (goto [30])
009F  82018000           [29] loadbool   6   1   0    ; R6 := true
00A3  5C410001           [30] call       5   2   1    ;  := R5(R6)
00A7  40010000           [31] move       5   0        ; R5 := R0
00AB  80010000           [32] move       6   0        ; R6 := R0
00AF  C1010000           [33] loadk      7   0        ; R7 := 3
00B3  01420000           [34] loadk      8   1        ; R8 := 9
00B7  41820000           [35] loadk      9   2        ; R9 := 7
00BB  81C20000           [36] loadk      10  3        ; R10 := 128
00BF  C1020100           [37] loadk      11  4        ; R11 := 35
00C3  9C010003           [38] call       6   6   0    ; R6 to top := R6(R7 to R11)
00C7  5CC10000           [39] call       5   0   3    ; R5, R6 := R5(R6 to top)
00CB  C0018000           [40] move       7   1        ; R7 := R1
00CF  17C0C002           [41] eq         0   5   259  ; R5 == 128, pc+=1 (goto [43]) if true
00D3  16400080           [42] jmp        2            ; pc+=2 (goto [45])
00D7  57804103           [43] eq         1   6   262  ; R6 == 1, pc+=1 (goto [45]) if false
00DB  16000080           [44] jmp        1            ; pc+=1 (goto [46])
00DF  02420000           [45] loadbool   8   0   1    ; R8 := false; PC := pc+=1 (goto [47])
00E3  02028000           [46] loadbool   8   1   0    ; R8 := true
00E7  DC410001           [47] call       7   2   1    ;  := R7(R8)
00EB  CA010000           [48] newtable   7   0   0    ; R7 := {} , array=0, hash=0
00EF  00020000           [49] move       8   0        ; R8 := R0
00F3  41020000           [50] loadk      9   0        ; R9 := 3
00F7  81420000           [51] loadk      10  1        ; R10 := 9
00FB  C1820000           [52] loadk      11  2        ; R11 := 7
00FF  01C30000           [53] loadk      12  3        ; R12 := 128
0103  41030100           [54] loadk      13  4        ; R13 := 35
0107  1C020003           [55] call       8   6   0    ; R8 to top := R8(R9 to R13)
010B  E2410000           [56] setlist    7   0   1    ; R7[1 to top] := R8 to top
010F  00028000           [57] move       8   1        ; R8 := R1
0113  4682C103           [58] gettable   9   7   262  ; R9 := R7[1]
0117  17C0C004           [59] eq         0   9   259  ; R9 == 128, pc+=1 (goto [61]) if true
011B  16800080           [60] jmp        3            ; pc+=3 (goto [64])
011F  46C2C103           [61] gettable   9   7   263  ; R9 := R7[2]
0123  5740C104           [62] eq         1   9   261  ; R9 == 4, pc+=1 (goto [64]) if false
0127  16000080           [63] jmp        1            ; pc+=1 (goto [65])
012B  42420000           [64] loadbool   9   0   1    ; R9 := false; PC := pc+=1 (goto [66])
012F  42028000           [65] loadbool   9   1   0    ; R9 := true
0133  1C420001           [66] call       8   2   1    ;  := R8(R9)
0137  1E008000           [67] return     0   1        ; return 
                         * constants:
013B  08000000           sizek (8)
013F  03                 const type 3
0140  0000000000000840   const [0]: (3)
0148  03                 const type 3
0149  0000000000002240   const [1]: (9)
0151  03                 const type 3
0152  0000000000001C40   const [2]: (7)
015A  03                 const type 3
015B  0000000000006040   const [3]: (128)
0163  03                 const type 3
0164  0000000000804140   const [4]: (35)
016C  03                 const type 3
016D  0000000000001040   const [5]: (4)
0175  03                 const type 3
0176  000000000000F03F   const [6]: (1)
017E  03                 const type 3
017F  0000000000000040   const [7]: (2)
                         * functions:
0187  02000000           sizep (2)
                         
018B                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
018B  0000000000000000   string size (0)
                         source name: (none)
0193  01000000           line defined (1)
0197  0A000000           last line defined (10)
019B  00                 nups (0)
019C  00                 numparams (0)
019D  03                 is_vararg (3)
019E  09                 maxstacksize (9)
                         * code:
019F  15000000           sizecode (21)
01A3  4A000000           [01] newtable   1   0   0    ; R1 := {} , array=0, hash=0
01A7  A5000000           [02] vararg     2   0        ; R2 to top := ...
01AB  62400000           [03] setlist    1   0   1    ; R1[1 to top] := R2 to top
01AF  83008001           [04] loadnil    2   3        ; R2, R3,  := nil
01B3  01010000           [05] loadk      4   0        ; R4 := 1
01B7  54018000           [06] len        5   1        ; R5 := #R1
01BB  81010000           [07] loadk      6   0        ; R6 := 1
01BF  20C10180           [08] forprep    4   8        ; R4 -= R6; PC := 17
01C3  57404001           [09] eq         1   2   257  ; R2 == nil, pc+=1 (goto [11]) if false
01C7  16800080           [10] jmp        3            ; pc+=3 (goto [14])
01CB  06C28100           [11] gettable   8   1   7    ; R8 := R1[R7]
01CF  18000201           [12] lt         0   2   8    ; R2 < R8, pc+=1 (goto [14]) if true
01D3  16800080           [13] jmp        3            ; pc+=3 (goto [17])
01D7  06C28100           [14] gettable   8   1   7    ; R8 := R1[R7]
01DB  C0008003           [15] move       3   7        ; R3 := R7
01DF  80000004           [16] move       2   8        ; R2 := R8
01E3  1F81FD7F           [17] forloop    4   -9       ; R4 += R6; if R4 <= R5 then begin PC := 9; R7 := R4 end
01E7  00010001           [18] move       4   2        ; R4 := R2
01EB  40018001           [19] move       5   3        ; R5 := R3
01EF  1E018001           [20] return     4   3        ; return R4, R5
01F3  1E008000           [21] return     0   1        ; return 
                         * constants:
01F7  02000000           sizek (2)
01FB  03                 const type 3
01FC  000000000000F03F   const [0]: (1)
0204  00                 const type 0
                         const [1]: nil
                         * functions:
0205  00000000           sizep (0)
                         * lines:
0209  15000000           sizelineinfo (21)
                         [pc] (line)
020D  02000000           [01] (2)
0211  02000000           [02] (2)
0215  02000000           [03] (2)
0219  03000000           [04] (3)
021D  04000000           [05] (4)
0221  04000000           [06] (4)
0225  04000000           [07] (4)
0229  04000000           [08] (4)
022D  05000000           [09] (5)
0231  05000000           [10] (5)
0235  05000000           [11] (5)
0239  05000000           [12] (5)
023D  05000000           [13] (5)
0241  06000000           [14] (6)
0245  06000000           [15] (6)
0249  06000000           [16] (6)
024D  04000000           [17] (4)
0251  09000000           [18] (9)
0255  09000000           [19] (9)
0259  09000000           [20] (9)
025D  0A000000           [21] (10)
                         * locals:
0261  08000000           sizelocvars (8)
0265  0400000000000000   string size (4)
026D  61726700           "arg\0"
                         local [0]: arg
0271  00000000             startpc (0)
0275  14000000             endpc   (20)
0279  0500000000000000   string size (5)
0281  6172677300         "args\0"
                         local [1]: args
0286  03000000             startpc (3)
028A  14000000             endpc   (20)
028E  0400000000000000   string size (4)
0296  76616C00           "val\0"
                         local [2]: val
029A  04000000             startpc (4)
029E  14000000             endpc   (20)
02A2  0400000000000000   string size (4)
02AA  69647800           "idx\0"
                         local [3]: idx
02AE  04000000             startpc (4)
02B2  14000000             endpc   (20)
02B6  0C00000000000000   string size (12)
02BE  28666F7220696E64+  "(for ind"
02C6  65782900           "ex)\0"
                         local [4]: (for index)
02CA  07000000             startpc (7)
02CE  11000000             endpc   (17)
02D2  0C00000000000000   string size (12)
02DA  28666F72206C696D+  "(for lim"
02E2  69742900           "it)\0"
                         local [5]: (for limit)
02E6  07000000             startpc (7)
02EA  11000000             endpc   (17)
02EE  0B00000000000000   string size (11)
02F6  28666F7220737465+  "(for ste"
02FE  702900             "p)\0"
                         local [6]: (for step)
0301  07000000             startpc (7)
0305  11000000             endpc   (17)
0309  0200000000000000   string size (2)
0311  6900               "i\0"
                         local [7]: i
0313  08000000             startpc (8)
0317  10000000             endpc   (16)
                         * upvalues:
031B  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
031F                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
031F  0000000000000000   string size (0)
                         source name: (none)
0327  0C000000           line defined (12)
032B  0E000000           last line defined (14)
032F  00                 nups (0)
0330  01                 numparams (1)
0331  00                 is_vararg (0)
0332  02                 maxstacksize (2)
                         * code:
0333  05000000           sizecode (5)
0337  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
033B  16400080           [2] jmp        2            ; pc+=2 (goto [5])
033F  45000000           [3] getglobal  1   0        ; R1 := fail
0343  5C408000           [4] call       1   1   1    ;  := R1()
0347  1E008000           [5] return     0   1        ; return 
                         * constants:
034B  01000000           sizek (1)
034F  04                 const type 4
0350  0500000000000000   string size (5)
0358  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
035D  00000000           sizep (0)
                         * lines:
0361  05000000           sizelineinfo (5)
                         [pc] (line)
0365  0D000000           [1] (13)
0369  0D000000           [2] (13)
036D  0D000000           [3] (13)
0371  0D000000           [4] (13)
0375  0E000000           [5] (14)
                         * locals:
0379  01000000           sizelocvars (1)
037D  0200000000000000   string size (2)
0385  7600               "v\0"
                         local [0]: v
0387  00000000             startpc (0)
038B  04000000             endpc   (4)
                         * upvalues:
038F  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
0393  43000000           sizelineinfo (67)
                         [pc] (line)
0397  0A000000           [01] (10)
039B  0E000000           [02] (14)
039F  10000000           [03] (16)
03A3  10000000           [04] (16)
03A7  10000000           [05] (16)
03AB  10000000           [06] (16)
03AF  10000000           [07] (16)
03B3  10000000           [08] (16)
03B7  10000000           [09] (16)
03BB  11000000           [10] (17)
03BF  11000000           [11] (17)
03C3  11000000           [12] (17)
03C7  11000000           [13] (17)
03CB  11000000           [14] (17)
03CF  11000000           [15] (17)
03D3  12000000           [16] (18)
03D7  12000000           [17] (18)
03DB  12000000           [18] (18)
03DF  12000000           [19] (18)
03E3  12000000           [20] (18)
03E7  12000000           [21] (18)
03EB  12000000           [22] (18)
03EF  13000000           [23] (19)
03F3  13000000           [24] (19)
03F7  13000000           [25] (19)
03FB  13000000           [26] (19)
03FF  13000000           [27] (19)
0403  13000000           [28] (19)
0407  13000000           [29] (19)
040B  13000000           [30] (19)
040F  14000000           [31] (20)
0413  14000000           [32] (20)
0417  14000000           [33] (20)
041B  14000000           [34] (20)
041F  14000000           [35] (20)
0423  14000000           [36] (20)
0427  14000000           [37] (20)
042B  14000000           [38] (20)
042F  14000000           [39] (20)
0433  15000000           [40] (21)
0437  15000000           [41] (21)
043B  15000000           [42] (21)
043F  15000000           [43] (21)
0443  15000000           [44] (21)
0447  15000000           [45] (21)
044B  15000000           [46] (21)
044F  15000000           [47] (21)
0453  16000000           [48] (22)
0457  16000000           [49] (22)
045B  16000000           [50] (22)
045F  16000000           [51] (22)
0463  16000000           [52] (22)
0467  16000000           [53] (22)
046B  16000000           [54] (22)
046F  16000000           [55] (22)
0473  16000000           [56] (22)
0477  17000000           [57] (23)
047B  17000000           [58] (23)
047F  17000000           [59] (23)
0483  17000000           [60] (23)
0487  17000000           [61] (23)
048B  17000000           [62] (23)
048F  17000000           [63] (23)
0493  17000000           [64] (23)
0497  17000000           [65] (23)
049B  17000000           [66] (23)
049F  17000000           [67] (23)
                         * locals:
04A3  08000000           sizelocvars (8)
04A7  0400000000000000   string size (4)
04AF  6D617800           "max\0"
                         local [0]: max
04B3  01000000             startpc (1)
04B7  42000000             endpc   (66)
04BB  0700000000000000   string size (7)
04C3  61737365727400     "assert\0"
                         local [1]: assert
04CA  02000000             startpc (2)
04CE  42000000             endpc   (66)
04D2  0300000000000000   string size (3)
04DA  763100             "v1\0"
                         local [2]: v1
04DD  09000000             startpc (9)
04E1  42000000             endpc   (66)
04E5  0300000000000000   string size (3)
04ED  763200             "v2\0"
                         local [3]: v2
04F0  16000000             startpc (22)
04F4  42000000             endpc   (66)
04F8  0300000000000000   string size (3)
0500  693200             "i2\0"
                         local [4]: i2
0503  16000000             startpc (22)
0507  42000000             endpc   (66)
050B  0300000000000000   string size (3)
0513  763300             "v3\0"
                         local [5]: v3
0516  27000000             startpc (39)
051A  42000000             endpc   (66)
051E  0300000000000000   string size (3)
0526  693300             "i3\0"
                         local [6]: i3
0529  27000000             startpc (39)
052D  42000000             endpc   (66)
0531  0200000000000000   string size (2)
0539  7400               "t\0"
                         local [7]: t
053B  38000000             startpc (56)
053F  42000000             endpc   (66)
                         * upvalues:
0543  00000000           sizeupvalues (0)
                         ** end of function 0 **

0547                     ** end of chunk **
