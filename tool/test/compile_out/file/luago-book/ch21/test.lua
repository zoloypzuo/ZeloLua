------------------------------
function permgen (a, n)
  n = n or #a          -- default for 'n' is size of 'a'
  if n <= 1 then       -- nothing to change?
    coroutine.yield(a)
  else
    for i = 1, n do
      -- put i-th element as the last one
      a[n], a[i] = a[i], a[n]
      -- generate all permutations of the other elements
      permgen(a, n - 1)
      -- restore i-th element
      a[n], a[i] = a[i], a[n]
    end
  end
end

function permutations (a)
  local co = coroutine.create(function () permgen(a) end)
  return function ()   -- iterator
    local code, res = coroutine.resume(co)
    return res
  end
end

for p in permutations{"a", "b", "c"} do
  print(table.concat(p, ","))
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
.local  "p"  ; 3
.const  "permgen"  ; 0
.const  "permutations"  ; 1
.const  "a"  ; 2
.const  "b"  ; 3
.const  "c"  ; 4
.const  "print"  ; 5
.const  "table"  ; 6
.const  "concat"  ; 7
.const  ","  ; 8
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; permgen := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; permutations := R0
[05] getglobal  0   1        ; R0 := permutations
[06] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[07] loadk      2   2        ; R2 := "a"
[08] loadk      3   3        ; R3 := "b"
[09] loadk      4   4        ; R4 := "c"
[10] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[11] call       0   2   4    ; R0 to R2 := R0(R1)
[12] jmp        7            ; pc+=7 (goto [20])
[13] getglobal  4   5        ; R4 := print
[14] getglobal  5   6        ; R5 := table
[15] gettable   5   5   263  ; R5 := R5["concat"]
[16] move       6   3        ; R6 := R3
[17] loadk      7   8        ; R7 := ","
[18] call       5   3   0    ; R5 to top := R5(R6, R7)
[19] call       4   0   1    ;  := R4(R5 to top)
[20] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 22
[21] jmp        -9           ; pc+=-9 (goto [13])
[22] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 9 stacks
.function  0 2 0 9
.local  "a"  ; 0
.local  "n"  ; 1
.local  "(for index)"  ; 2
.local  "(for limit)"  ; 3
.local  "(for step)"  ; 4
.local  "i"  ; 5
.const  1  ; 0
.const  "coroutine"  ; 1
.const  "yield"  ; 2
.const  "permgen"  ; 3
[01] test       1       1    ; if not R1 then pc+=1 (goto [3])
[02] jmp        1            ; pc+=1 (goto [4])
[03] len        1   0        ; R1 := #R0
[04] le         0   1   256  ; R1 <= 1, pc+=1 (goto [6]) if true
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  2   1        ; R2 := coroutine
[07] gettable   2   2   258  ; R2 := R2["yield"]
[08] move       3   0        ; R3 := R0
[09] call       2   2   1    ;  := R2(R3)
[10] jmp        17           ; pc+=17 (goto [28])
[11] loadk      2   0        ; R2 := 1
[12] move       3   1        ; R3 := R1
[13] loadk      4   0        ; R4 := 1
[14] forprep    2   12       ; R2 -= R4; PC := 27
[15] gettable   6   0   5    ; R6 := R0[R5]
[16] gettable   7   0   1    ; R7 := R0[R1]
[17] settable   0   5   7    ; R0[R5] := R7
[18] settable   0   1   6    ; R0[R1] := R6
[19] getglobal  6   3        ; R6 := permgen
[20] move       7   0        ; R7 := R0
[21] sub        8   1   256  ; R8 := R1 - 1
[22] call       6   3   1    ;  := R6(R7, R8)
[23] gettable   6   0   5    ; R6 := R0[R5]
[24] gettable   7   0   1    ; R7 := R0[R1]
[25] settable   0   5   7    ; R0[R5] := R7
[26] settable   0   1   6    ; R0[R1] := R6
[27] forloop    2   -13      ; R2 += R4; if R2 <= R3 then begin PC := 15; R5 := R2 end
[28] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "a"  ; 0
.local  "co"  ; 1
.const  "coroutine"  ; 0
.const  "create"  ; 1
[1] getglobal  1   0        ; R1 := coroutine
[2] gettable   1   1   257  ; R1 := R1["create"]
[3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
[4] move       0   0        ; R0 := R0
[5] call       1   2   2    ; R1 := R1(R2)
[6] closure    2   1        ; R2 := closure(function[1]) 1 upvalues
[7] move       0   1        ; R0 := R1
[8] return     2   2        ; return R2
[9] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.upvalue  "a"  ; 0
.const  "permgen"  ; 0
[1] getglobal  0   0        ; R0 := permgen
[2] getupval   1   0        ; R1 := U0 , a
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_1_0


; function [1] definition (level 3) 0_1_1
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.local  "code"  ; 0
.local  "res"  ; 1
.upvalue  "co"  ; 0
.const  "coroutine"  ; 0
.const  "resume"  ; 1
[1] getglobal  0   0        ; R0 := coroutine
[2] gettable   0   0   257  ; R0 := R0["resume"]
[3] getupval   1   0        ; R1 := U0 , co
[4] call       0   2   3    ; R0, R1 := R0(R1)
[5] return     1   2        ; return R1
[6] return     0   1        ; return 
; end of function 0_1_1

; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "p"  ; 3
.const  "permgen"  ; 0
.const  "permutations"  ; 1
.const  "a"  ; 2
.const  "b"  ; 3
.const  "c"  ; 4
.const  "print"  ; 5
.const  "table"  ; 6
.const  "concat"  ; 7
.const  ","  ; 8
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; permgen := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; permutations := R0
[05] getglobal  0   1        ; R0 := permutations
[06] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[07] loadk      2   2        ; R2 := "a"
[08] loadk      3   3        ; R3 := "b"
[09] loadk      4   4        ; R4 := "c"
[10] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[11] call       0   2   4    ; R0 to R2 := R0(R1)
[12] jmp        7            ; pc+=7 (goto [20])
[13] getglobal  4   5        ; R4 := print
[14] getglobal  5   6        ; R5 := table
[15] gettable   5   5   263  ; R5 := R5["concat"]
[16] move       6   3        ; R6 := R3
[17] loadk      7   8        ; R7 := ","
[18] call       5   3   0    ; R5 to top := R5(R6, R7)
[19] call       4   0   1    ;  := R4(R5 to top)
[20] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 22
[21] jmp        -9           ; pc+=-9 (goto [13])
[22] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 9 stacks
.function  0 2 0 9
.local  "a"  ; 0
.local  "n"  ; 1
.local  "(for index)"  ; 2
.local  "(for limit)"  ; 3
.local  "(for step)"  ; 4
.local  "i"  ; 5
.const  1  ; 0
.const  "coroutine"  ; 1
.const  "yield"  ; 2
.const  "permgen"  ; 3
[01] test       1       1    ; if not R1 then pc+=1 (goto [3])
[02] jmp        1            ; pc+=1 (goto [4])
[03] len        1   0        ; R1 := #R0
[04] le         0   1   256  ; R1 <= 1, pc+=1 (goto [6]) if true
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  2   1        ; R2 := coroutine
[07] gettable   2   2   258  ; R2 := R2["yield"]
[08] move       3   0        ; R3 := R0
[09] call       2   2   1    ;  := R2(R3)
[10] jmp        17           ; pc+=17 (goto [28])
[11] loadk      2   0        ; R2 := 1
[12] move       3   1        ; R3 := R1
[13] loadk      4   0        ; R4 := 1
[14] forprep    2   12       ; R2 -= R4; PC := 27
[15] gettable   6   0   5    ; R6 := R0[R5]
[16] gettable   7   0   1    ; R7 := R0[R1]
[17] settable   0   5   7    ; R0[R5] := R7
[18] settable   0   1   6    ; R0[R1] := R6
[19] getglobal  6   3        ; R6 := permgen
[20] move       7   0        ; R7 := R0
[21] sub        8   1   256  ; R8 := R1 - 1
[22] call       6   3   1    ;  := R6(R7, R8)
[23] gettable   6   0   5    ; R6 := R0[R5]
[24] gettable   7   0   1    ; R7 := R0[R1]
[25] settable   0   5   7    ; R0[R5] := R7
[26] settable   0   1   6    ; R0[R1] := R6
[27] forloop    2   -13      ; R2 += R4; if R2 <= R3 then begin PC := 15; R5 := R2 end
[28] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "a"  ; 0
.local  "co"  ; 1
.const  "coroutine"  ; 0
.const  "create"  ; 1
[1] getglobal  1   0        ; R1 := coroutine
[2] gettable   1   1   257  ; R1 := R1["create"]
[3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
[4] move       0   0        ; R0 := R0
[5] call       1   2   2    ; R1 := R1(R2)
[6] closure    2   1        ; R2 := closure(function[1]) 1 upvalues
[7] move       0   1        ; R0 := R1
[8] return     2   2        ; return R2
[9] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.upvalue  "a"  ; 0
.const  "permgen"  ; 0
[1] getglobal  0   0        ; R0 := permgen
[2] getupval   1   0        ; R1 := U0 , a
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_1_0


; function [1] definition (level 3) 0_1_1
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.local  "code"  ; 0
.local  "res"  ; 1
.upvalue  "co"  ; 0
.const  "coroutine"  ; 0
.const  "resume"  ; 1
[1] getglobal  0   0        ; R0 := coroutine
[2] gettable   0   0   257  ; R0 := R0["resume"]
[3] getupval   1   0        ; R1 := U0 , co
[4] call       0   2   3    ; R0, R1 := R0(R1)
[5] return     1   2        ; return R1
[6] return     0   1        ; return 
; end of function 0_1_1

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
002A  08                 maxstacksize (8)
                         * code:
002B  16000000           sizecode (22)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; permgen := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; permutations := R0
003F  05400000           [05] getglobal  0   1        ; R0 := permutations
0043  4A008001           [06] newtable   1   3   0    ; R1 := {} , array=3, hash=0
0047  81800000           [07] loadk      2   2        ; R2 := "a"
004B  C1C00000           [08] loadk      3   3        ; R3 := "b"
004F  01010100           [09] loadk      4   4        ; R4 := "c"
0053  62408001           [10] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
0057  1C000101           [11] call       0   2   4    ; R0 to R2 := R0(R1)
005B  16800180           [12] jmp        7            ; pc+=7 (goto [20])
005F  05410100           [13] getglobal  4   5        ; R4 := print
0063  45810100           [14] getglobal  5   6        ; R5 := table
0067  46C1C102           [15] gettable   5   5   263  ; R5 := R5["concat"]
006B  80018001           [16] move       6   3        ; R6 := R3
006F  C1010200           [17] loadk      7   8        ; R7 := ","
0073  5C018001           [18] call       5   3   0    ; R5 to top := R5(R6, R7)
0077  1C410000           [19] call       4   0   1    ;  := R4(R5 to top)
007B  21400000           [20] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 22
007F  1680FD7F           [21] jmp        -9           ; pc+=-9 (goto [13])
0083  1E008000           [22] return     0   1        ; return 
                         * constants:
0087  09000000           sizek (9)
008B  04                 const type 4
008C  0800000000000000   string size (8)
0094  7065726D67656E00   "permgen\0"
                         const [0]: "permgen"
009C  04                 const type 4
009D  0D00000000000000   string size (13)
00A5  7065726D75746174+  "permutat"
00AD  696F6E7300         "ions\0"
                         const [1]: "permutations"
00B2  04                 const type 4
00B3  0200000000000000   string size (2)
00BB  6100               "a\0"
                         const [2]: "a"
00BD  04                 const type 4
00BE  0200000000000000   string size (2)
00C6  6200               "b\0"
                         const [3]: "b"
00C8  04                 const type 4
00C9  0200000000000000   string size (2)
00D1  6300               "c\0"
                         const [4]: "c"
00D3  04                 const type 4
00D4  0600000000000000   string size (6)
00DC  7072696E7400       "print\0"
                         const [5]: "print"
00E2  04                 const type 4
00E3  0600000000000000   string size (6)
00EB  7461626C6500       "table\0"
                         const [6]: "table"
00F1  04                 const type 4
00F2  0700000000000000   string size (7)
00FA  636F6E63617400     "concat\0"
                         const [7]: "concat"
0101  04                 const type 4
0102  0200000000000000   string size (2)
010A  2C00               ",\0"
                         const [8]: ","
                         * functions:
010C  02000000           sizep (2)
                         
0110                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0110  0000000000000000   string size (0)
                         source name: (none)
0118  01000000           line defined (1)
011C  0F000000           last line defined (15)
0120  00                 nups (0)
0121  02                 numparams (2)
0122  00                 is_vararg (0)
0123  09                 maxstacksize (9)
                         * code:
0124  1C000000           sizecode (28)
0128  5A400000           [01] test       1       1    ; if not R1 then pc+=1 (goto [3])
012C  16000080           [02] jmp        1            ; pc+=1 (goto [4])
0130  54000000           [03] len        1   0        ; R1 := #R0
0134  1900C000           [04] le         0   1   256  ; R1 <= 1, pc+=1 (goto [6]) if true
0138  16000180           [05] jmp        5            ; pc+=5 (goto [11])
013C  85400000           [06] getglobal  2   1        ; R2 := coroutine
0140  86804001           [07] gettable   2   2   258  ; R2 := R2["yield"]
0144  C0000000           [08] move       3   0        ; R3 := R0
0148  9C400001           [09] call       2   2   1    ;  := R2(R3)
014C  16000480           [10] jmp        17           ; pc+=17 (goto [28])
0150  81000000           [11] loadk      2   0        ; R2 := 1
0154  C0008000           [12] move       3   1        ; R3 := R1
0158  01010000           [13] loadk      4   0        ; R4 := 1
015C  A0C00280           [14] forprep    2   12       ; R2 -= R4; PC := 27
0160  86410100           [15] gettable   6   0   5    ; R6 := R0[R5]
0164  C6410000           [16] gettable   7   0   1    ; R7 := R0[R1]
0168  09C08102           [17] settable   0   5   7    ; R0[R5] := R7
016C  09808100           [18] settable   0   1   6    ; R0[R1] := R6
0170  85C10000           [19] getglobal  6   3        ; R6 := permgen
0174  C0010000           [20] move       7   0        ; R7 := R0
0178  0D02C000           [21] sub        8   1   256  ; R8 := R1 - 1
017C  9C418001           [22] call       6   3   1    ;  := R6(R7, R8)
0180  86410100           [23] gettable   6   0   5    ; R6 := R0[R5]
0184  C6410000           [24] gettable   7   0   1    ; R7 := R0[R1]
0188  09C08102           [25] settable   0   5   7    ; R0[R5] := R7
018C  09808100           [26] settable   0   1   6    ; R0[R1] := R6
0190  9F80FC7F           [27] forloop    2   -13      ; R2 += R4; if R2 <= R3 then begin PC := 15; R5 := R2 end
0194  1E008000           [28] return     0   1        ; return 
                         * constants:
0198  04000000           sizek (4)
019C  03                 const type 3
019D  000000000000F03F   const [0]: (1)
01A5  04                 const type 4
01A6  0A00000000000000   string size (10)
01AE  636F726F7574696E+  "coroutin"
01B6  6500               "e\0"
                         const [1]: "coroutine"
01B8  04                 const type 4
01B9  0600000000000000   string size (6)
01C1  7969656C6400       "yield\0"
                         const [2]: "yield"
01C7  04                 const type 4
01C8  0800000000000000   string size (8)
01D0  7065726D67656E00   "permgen\0"
                         const [3]: "permgen"
                         * functions:
01D8  00000000           sizep (0)
                         * lines:
01DC  1C000000           sizelineinfo (28)
                         [pc] (line)
01E0  02000000           [01] (2)
01E4  02000000           [02] (2)
01E8  02000000           [03] (2)
01EC  03000000           [04] (3)
01F0  03000000           [05] (3)
01F4  04000000           [06] (4)
01F8  04000000           [07] (4)
01FC  04000000           [08] (4)
0200  04000000           [09] (4)
0204  04000000           [10] (4)
0208  06000000           [11] (6)
020C  06000000           [12] (6)
0210  06000000           [13] (6)
0214  06000000           [14] (6)
0218  08000000           [15] (8)
021C  08000000           [16] (8)
0220  08000000           [17] (8)
0224  08000000           [18] (8)
0228  0A000000           [19] (10)
022C  0A000000           [20] (10)
0230  0A000000           [21] (10)
0234  0A000000           [22] (10)
0238  0C000000           [23] (12)
023C  0C000000           [24] (12)
0240  0C000000           [25] (12)
0244  0C000000           [26] (12)
0248  06000000           [27] (6)
024C  0F000000           [28] (15)
                         * locals:
0250  06000000           sizelocvars (6)
0254  0200000000000000   string size (2)
025C  6100               "a\0"
                         local [0]: a
025E  00000000             startpc (0)
0262  1B000000             endpc   (27)
0266  0200000000000000   string size (2)
026E  6E00               "n\0"
                         local [1]: n
0270  00000000             startpc (0)
0274  1B000000             endpc   (27)
0278  0C00000000000000   string size (12)
0280  28666F7220696E64+  "(for ind"
0288  65782900           "ex)\0"
                         local [2]: (for index)
028C  0D000000             startpc (13)
0290  1B000000             endpc   (27)
0294  0C00000000000000   string size (12)
029C  28666F72206C696D+  "(for lim"
02A4  69742900           "it)\0"
                         local [3]: (for limit)
02A8  0D000000             startpc (13)
02AC  1B000000             endpc   (27)
02B0  0B00000000000000   string size (11)
02B8  28666F7220737465+  "(for ste"
02C0  702900             "p)\0"
                         local [4]: (for step)
02C3  0D000000             startpc (13)
02C7  1B000000             endpc   (27)
02CB  0200000000000000   string size (2)
02D3  6900               "i\0"
                         local [5]: i
02D5  0E000000             startpc (14)
02D9  1A000000             endpc   (26)
                         * upvalues:
02DD  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
02E1                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
02E1  0000000000000000   string size (0)
                         source name: (none)
02E9  11000000           line defined (17)
02ED  17000000           last line defined (23)
02F1  00                 nups (0)
02F2  01                 numparams (1)
02F3  00                 is_vararg (0)
02F4  03                 maxstacksize (3)
                         * code:
02F5  09000000           sizecode (9)
02F9  45000000           [1] getglobal  1   0        ; R1 := coroutine
02FD  4640C000           [2] gettable   1   1   257  ; R1 := R1["create"]
0301  A4000000           [3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
0305  00000000           [4] move       0   0        ; R0 := R0
0309  5C800001           [5] call       1   2   2    ; R1 := R1(R2)
030D  A4400000           [6] closure    2   1        ; R2 := closure(function[1]) 1 upvalues
0311  00008000           [7] move       0   1        ; R0 := R1
0315  9E000001           [8] return     2   2        ; return R2
0319  1E008000           [9] return     0   1        ; return 
                         * constants:
031D  02000000           sizek (2)
0321  04                 const type 4
0322  0A00000000000000   string size (10)
032A  636F726F7574696E+  "coroutin"
0332  6500               "e\0"
                         const [0]: "coroutine"
0334  04                 const type 4
0335  0700000000000000   string size (7)
033D  63726561746500     "create\0"
                         const [1]: "create"
                         * functions:
0344  02000000           sizep (2)
                         
0348                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
0348  0000000000000000   string size (0)
                         source name: (none)
0350  12000000           line defined (18)
0354  12000000           last line defined (18)
0358  01                 nups (1)
0359  00                 numparams (0)
035A  00                 is_vararg (0)
035B  02                 maxstacksize (2)
                         * code:
035C  04000000           sizecode (4)
0360  05000000           [1] getglobal  0   0        ; R0 := permgen
0364  44000000           [2] getupval   1   0        ; R1 := U0 , a
0368  1C400001           [3] call       0   2   1    ;  := R0(R1)
036C  1E008000           [4] return     0   1        ; return 
                         * constants:
0370  01000000           sizek (1)
0374  04                 const type 4
0375  0800000000000000   string size (8)
037D  7065726D67656E00   "permgen\0"
                         const [0]: "permgen"
                         * functions:
0385  00000000           sizep (0)
                         * lines:
0389  04000000           sizelineinfo (4)
                         [pc] (line)
038D  12000000           [1] (18)
0391  12000000           [2] (18)
0395  12000000           [3] (18)
0399  12000000           [4] (18)
                         * locals:
039D  00000000           sizelocvars (0)
                         * upvalues:
03A1  01000000           sizeupvalues (1)
03A5  0200000000000000   string size (2)
03AD  6100               "a\0"
                         upvalue [0]: a
                         ** end of function 0_1_0 **

                         
03AF                     ** function [1] definition (level 3) 0_1_1
                         ** start of function 0_1_1 **
03AF  0000000000000000   string size (0)
                         source name: (none)
03B7  13000000           line defined (19)
03BB  16000000           last line defined (22)
03BF  01                 nups (1)
03C0  00                 numparams (0)
03C1  00                 is_vararg (0)
03C2  02                 maxstacksize (2)
                         * code:
03C3  06000000           sizecode (6)
03C7  05000000           [1] getglobal  0   0        ; R0 := coroutine
03CB  06404000           [2] gettable   0   0   257  ; R0 := R0["resume"]
03CF  44000000           [3] getupval   1   0        ; R1 := U0 , co
03D3  1CC00001           [4] call       0   2   3    ; R0, R1 := R0(R1)
03D7  5E000001           [5] return     1   2        ; return R1
03DB  1E008000           [6] return     0   1        ; return 
                         * constants:
03DF  02000000           sizek (2)
03E3  04                 const type 4
03E4  0A00000000000000   string size (10)
03EC  636F726F7574696E+  "coroutin"
03F4  6500               "e\0"
                         const [0]: "coroutine"
03F6  04                 const type 4
03F7  0700000000000000   string size (7)
03FF  726573756D6500     "resume\0"
                         const [1]: "resume"
                         * functions:
0406  00000000           sizep (0)
                         * lines:
040A  06000000           sizelineinfo (6)
                         [pc] (line)
040E  14000000           [1] (20)
0412  14000000           [2] (20)
0416  14000000           [3] (20)
041A  14000000           [4] (20)
041E  15000000           [5] (21)
0422  16000000           [6] (22)
                         * locals:
0426  02000000           sizelocvars (2)
042A  0500000000000000   string size (5)
0432  636F646500         "code\0"
                         local [0]: code
0437  04000000             startpc (4)
043B  05000000             endpc   (5)
043F  0400000000000000   string size (4)
0447  72657300           "res\0"
                         local [1]: res
044B  04000000             startpc (4)
044F  05000000             endpc   (5)
                         * upvalues:
0453  01000000           sizeupvalues (1)
0457  0300000000000000   string size (3)
045F  636F00             "co\0"
                         upvalue [0]: co
                         ** end of function 0_1_1 **

                         * lines:
0462  09000000           sizelineinfo (9)
                         [pc] (line)
0466  12000000           [1] (18)
046A  12000000           [2] (18)
046E  12000000           [3] (18)
0472  12000000           [4] (18)
0476  12000000           [5] (18)
047A  16000000           [6] (22)
047E  16000000           [7] (22)
0482  16000000           [8] (22)
0486  17000000           [9] (23)
                         * locals:
048A  02000000           sizelocvars (2)
048E  0200000000000000   string size (2)
0496  6100               "a\0"
                         local [0]: a
0498  00000000             startpc (0)
049C  08000000             endpc   (8)
04A0  0300000000000000   string size (3)
04A8  636F00             "co\0"
                         local [1]: co
04AB  05000000             startpc (5)
04AF  08000000             endpc   (8)
                         * upvalues:
04B3  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
04B7  16000000           sizelineinfo (22)
                         [pc] (line)
04BB  0F000000           [01] (15)
04BF  01000000           [02] (1)
04C3  17000000           [03] (23)
04C7  11000000           [04] (17)
04CB  19000000           [05] (25)
04CF  19000000           [06] (25)
04D3  19000000           [07] (25)
04D7  19000000           [08] (25)
04DB  19000000           [09] (25)
04DF  19000000           [10] (25)
04E3  19000000           [11] (25)
04E7  19000000           [12] (25)
04EB  1A000000           [13] (26)
04EF  1A000000           [14] (26)
04F3  1A000000           [15] (26)
04F7  1A000000           [16] (26)
04FB  1A000000           [17] (26)
04FF  1A000000           [18] (26)
0503  1A000000           [19] (26)
0507  19000000           [20] (25)
050B  1A000000           [21] (26)
050F  1B000000           [22] (27)
                         * locals:
0513  04000000           sizelocvars (4)
0517  1000000000000000   string size (16)
051F  28666F722067656E+  "(for gen"
0527  657261746F722900   "erator)\0"
                         local [0]: (for generator)
052F  0B000000             startpc (11)
0533  15000000             endpc   (21)
0537  0C00000000000000   string size (12)
053F  28666F7220737461+  "(for sta"
0547  74652900           "te)\0"
                         local [1]: (for state)
054B  0B000000             startpc (11)
054F  15000000             endpc   (21)
0553  0E00000000000000   string size (14)
055B  28666F7220636F6E+  "(for con"
0563  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0569  0B000000             startpc (11)
056D  15000000             endpc   (21)
0571  0200000000000000   string size (2)
0579  7000               "p\0"
                         local [3]: p
057B  0C000000             startpc (12)
057F  13000000             endpc   (19)
                         * upvalues:
0583  00000000           sizeupvalues (0)
                         ** end of function 0 **

0587                     ** end of chunk **
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
002B  16000000           sizecode (22)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; permgen := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; permutations := R0
003F  05400000           [05] getglobal  0   1        ; R0 := permutations
0043  4A008001           [06] newtable   1   3   0    ; R1 := {} , array=3, hash=0
0047  81800000           [07] loadk      2   2        ; R2 := "a"
004B  C1C00000           [08] loadk      3   3        ; R3 := "b"
004F  01010100           [09] loadk      4   4        ; R4 := "c"
0053  62408001           [10] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
0057  1C000101           [11] call       0   2   4    ; R0 to R2 := R0(R1)
005B  16800180           [12] jmp        7            ; pc+=7 (goto [20])
005F  05410100           [13] getglobal  4   5        ; R4 := print
0063  45810100           [14] getglobal  5   6        ; R5 := table
0067  46C1C102           [15] gettable   5   5   263  ; R5 := R5["concat"]
006B  80018001           [16] move       6   3        ; R6 := R3
006F  C1010200           [17] loadk      7   8        ; R7 := ","
0073  5C018001           [18] call       5   3   0    ; R5 to top := R5(R6, R7)
0077  1C410000           [19] call       4   0   1    ;  := R4(R5 to top)
007B  21400000           [20] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 22
007F  1680FD7F           [21] jmp        -9           ; pc+=-9 (goto [13])
0083  1E008000           [22] return     0   1        ; return 
                         * constants:
0087  09000000           sizek (9)
008B  04                 const type 4
008C  0800000000000000   string size (8)
0094  7065726D67656E00   "permgen\0"
                         const [0]: "permgen"
009C  04                 const type 4
009D  0D00000000000000   string size (13)
00A5  7065726D75746174+  "permutat"
00AD  696F6E7300         "ions\0"
                         const [1]: "permutations"
00B2  04                 const type 4
00B3  0200000000000000   string size (2)
00BB  6100               "a\0"
                         const [2]: "a"
00BD  04                 const type 4
00BE  0200000000000000   string size (2)
00C6  6200               "b\0"
                         const [3]: "b"
00C8  04                 const type 4
00C9  0200000000000000   string size (2)
00D1  6300               "c\0"
                         const [4]: "c"
00D3  04                 const type 4
00D4  0600000000000000   string size (6)
00DC  7072696E7400       "print\0"
                         const [5]: "print"
00E2  04                 const type 4
00E3  0600000000000000   string size (6)
00EB  7461626C6500       "table\0"
                         const [6]: "table"
00F1  04                 const type 4
00F2  0700000000000000   string size (7)
00FA  636F6E63617400     "concat\0"
                         const [7]: "concat"
0101  04                 const type 4
0102  0200000000000000   string size (2)
010A  2C00               ",\0"
                         const [8]: ","
                         * functions:
010C  02000000           sizep (2)
                         
0110                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0110  0000000000000000   string size (0)
                         source name: (none)
0118  01000000           line defined (1)
011C  0F000000           last line defined (15)
0120  00                 nups (0)
0121  02                 numparams (2)
0122  00                 is_vararg (0)
0123  09                 maxstacksize (9)
                         * code:
0124  1C000000           sizecode (28)
0128  5A400000           [01] test       1       1    ; if not R1 then pc+=1 (goto [3])
012C  16000080           [02] jmp        1            ; pc+=1 (goto [4])
0130  54000000           [03] len        1   0        ; R1 := #R0
0134  1900C000           [04] le         0   1   256  ; R1 <= 1, pc+=1 (goto [6]) if true
0138  16000180           [05] jmp        5            ; pc+=5 (goto [11])
013C  85400000           [06] getglobal  2   1        ; R2 := coroutine
0140  86804001           [07] gettable   2   2   258  ; R2 := R2["yield"]
0144  C0000000           [08] move       3   0        ; R3 := R0
0148  9C400001           [09] call       2   2   1    ;  := R2(R3)
014C  16000480           [10] jmp        17           ; pc+=17 (goto [28])
0150  81000000           [11] loadk      2   0        ; R2 := 1
0154  C0008000           [12] move       3   1        ; R3 := R1
0158  01010000           [13] loadk      4   0        ; R4 := 1
015C  A0C00280           [14] forprep    2   12       ; R2 -= R4; PC := 27
0160  86410100           [15] gettable   6   0   5    ; R6 := R0[R5]
0164  C6410000           [16] gettable   7   0   1    ; R7 := R0[R1]
0168  09C08102           [17] settable   0   5   7    ; R0[R5] := R7
016C  09808100           [18] settable   0   1   6    ; R0[R1] := R6
0170  85C10000           [19] getglobal  6   3        ; R6 := permgen
0174  C0010000           [20] move       7   0        ; R7 := R0
0178  0D02C000           [21] sub        8   1   256  ; R8 := R1 - 1
017C  9C418001           [22] call       6   3   1    ;  := R6(R7, R8)
0180  86410100           [23] gettable   6   0   5    ; R6 := R0[R5]
0184  C6410000           [24] gettable   7   0   1    ; R7 := R0[R1]
0188  09C08102           [25] settable   0   5   7    ; R0[R5] := R7
018C  09808100           [26] settable   0   1   6    ; R0[R1] := R6
0190  9F80FC7F           [27] forloop    2   -13      ; R2 += R4; if R2 <= R3 then begin PC := 15; R5 := R2 end
0194  1E008000           [28] return     0   1        ; return 
                         * constants:
0198  04000000           sizek (4)
019C  03                 const type 3
019D  000000000000F03F   const [0]: (1)
01A5  04                 const type 4
01A6  0A00000000000000   string size (10)
01AE  636F726F7574696E+  "coroutin"
01B6  6500               "e\0"
                         const [1]: "coroutine"
01B8  04                 const type 4
01B9  0600000000000000   string size (6)
01C1  7969656C6400       "yield\0"
                         const [2]: "yield"
01C7  04                 const type 4
01C8  0800000000000000   string size (8)
01D0  7065726D67656E00   "permgen\0"
                         const [3]: "permgen"
                         * functions:
01D8  00000000           sizep (0)
                         * lines:
01DC  1C000000           sizelineinfo (28)
                         [pc] (line)
01E0  02000000           [01] (2)
01E4  02000000           [02] (2)
01E8  02000000           [03] (2)
01EC  03000000           [04] (3)
01F0  03000000           [05] (3)
01F4  04000000           [06] (4)
01F8  04000000           [07] (4)
01FC  04000000           [08] (4)
0200  04000000           [09] (4)
0204  04000000           [10] (4)
0208  06000000           [11] (6)
020C  06000000           [12] (6)
0210  06000000           [13] (6)
0214  06000000           [14] (6)
0218  08000000           [15] (8)
021C  08000000           [16] (8)
0220  08000000           [17] (8)
0224  08000000           [18] (8)
0228  0A000000           [19] (10)
022C  0A000000           [20] (10)
0230  0A000000           [21] (10)
0234  0A000000           [22] (10)
0238  0C000000           [23] (12)
023C  0C000000           [24] (12)
0240  0C000000           [25] (12)
0244  0C000000           [26] (12)
0248  06000000           [27] (6)
024C  0F000000           [28] (15)
                         * locals:
0250  06000000           sizelocvars (6)
0254  0200000000000000   string size (2)
025C  6100               "a\0"
                         local [0]: a
025E  00000000             startpc (0)
0262  1B000000             endpc   (27)
0266  0200000000000000   string size (2)
026E  6E00               "n\0"
                         local [1]: n
0270  00000000             startpc (0)
0274  1B000000             endpc   (27)
0278  0C00000000000000   string size (12)
0280  28666F7220696E64+  "(for ind"
0288  65782900           "ex)\0"
                         local [2]: (for index)
028C  0D000000             startpc (13)
0290  1B000000             endpc   (27)
0294  0C00000000000000   string size (12)
029C  28666F72206C696D+  "(for lim"
02A4  69742900           "it)\0"
                         local [3]: (for limit)
02A8  0D000000             startpc (13)
02AC  1B000000             endpc   (27)
02B0  0B00000000000000   string size (11)
02B8  28666F7220737465+  "(for ste"
02C0  702900             "p)\0"
                         local [4]: (for step)
02C3  0D000000             startpc (13)
02C7  1B000000             endpc   (27)
02CB  0200000000000000   string size (2)
02D3  6900               "i\0"
                         local [5]: i
02D5  0E000000             startpc (14)
02D9  1A000000             endpc   (26)
                         * upvalues:
02DD  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
02E1                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
02E1  0000000000000000   string size (0)
                         source name: (none)
02E9  11000000           line defined (17)
02ED  17000000           last line defined (23)
02F1  00                 nups (0)
02F2  01                 numparams (1)
02F3  00                 is_vararg (0)
02F4  03                 maxstacksize (3)
                         * code:
02F5  09000000           sizecode (9)
02F9  45000000           [1] getglobal  1   0        ; R1 := coroutine
02FD  4640C000           [2] gettable   1   1   257  ; R1 := R1["create"]
0301  A4000000           [3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
0305  00000000           [4] move       0   0        ; R0 := R0
0309  5C800001           [5] call       1   2   2    ; R1 := R1(R2)
030D  A4400000           [6] closure    2   1        ; R2 := closure(function[1]) 1 upvalues
0311  00008000           [7] move       0   1        ; R0 := R1
0315  9E000001           [8] return     2   2        ; return R2
0319  1E008000           [9] return     0   1        ; return 
                         * constants:
031D  02000000           sizek (2)
0321  04                 const type 4
0322  0A00000000000000   string size (10)
032A  636F726F7574696E+  "coroutin"
0332  6500               "e\0"
                         const [0]: "coroutine"
0334  04                 const type 4
0335  0700000000000000   string size (7)
033D  63726561746500     "create\0"
                         const [1]: "create"
                         * functions:
0344  02000000           sizep (2)
                         
0348                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
0348  0000000000000000   string size (0)
                         source name: (none)
0350  12000000           line defined (18)
0354  12000000           last line defined (18)
0358  01                 nups (1)
0359  00                 numparams (0)
035A  00                 is_vararg (0)
035B  02                 maxstacksize (2)
                         * code:
035C  04000000           sizecode (4)
0360  05000000           [1] getglobal  0   0        ; R0 := permgen
0364  44000000           [2] getupval   1   0        ; R1 := U0 , a
0368  1C400001           [3] call       0   2   1    ;  := R0(R1)
036C  1E008000           [4] return     0   1        ; return 
                         * constants:
0370  01000000           sizek (1)
0374  04                 const type 4
0375  0800000000000000   string size (8)
037D  7065726D67656E00   "permgen\0"
                         const [0]: "permgen"
                         * functions:
0385  00000000           sizep (0)
                         * lines:
0389  04000000           sizelineinfo (4)
                         [pc] (line)
038D  12000000           [1] (18)
0391  12000000           [2] (18)
0395  12000000           [3] (18)
0399  12000000           [4] (18)
                         * locals:
039D  00000000           sizelocvars (0)
                         * upvalues:
03A1  01000000           sizeupvalues (1)
03A5  0200000000000000   string size (2)
03AD  6100               "a\0"
                         upvalue [0]: a
                         ** end of function 0_1_0 **

                         
03AF                     ** function [1] definition (level 3) 0_1_1
                         ** start of function 0_1_1 **
03AF  0000000000000000   string size (0)
                         source name: (none)
03B7  13000000           line defined (19)
03BB  16000000           last line defined (22)
03BF  01                 nups (1)
03C0  00                 numparams (0)
03C1  00                 is_vararg (0)
03C2  02                 maxstacksize (2)
                         * code:
03C3  06000000           sizecode (6)
03C7  05000000           [1] getglobal  0   0        ; R0 := coroutine
03CB  06404000           [2] gettable   0   0   257  ; R0 := R0["resume"]
03CF  44000000           [3] getupval   1   0        ; R1 := U0 , co
03D3  1CC00001           [4] call       0   2   3    ; R0, R1 := R0(R1)
03D7  5E000001           [5] return     1   2        ; return R1
03DB  1E008000           [6] return     0   1        ; return 
                         * constants:
03DF  02000000           sizek (2)
03E3  04                 const type 4
03E4  0A00000000000000   string size (10)
03EC  636F726F7574696E+  "coroutin"
03F4  6500               "e\0"
                         const [0]: "coroutine"
03F6  04                 const type 4
03F7  0700000000000000   string size (7)
03FF  726573756D6500     "resume\0"
                         const [1]: "resume"
                         * functions:
0406  00000000           sizep (0)
                         * lines:
040A  06000000           sizelineinfo (6)
                         [pc] (line)
040E  14000000           [1] (20)
0412  14000000           [2] (20)
0416  14000000           [3] (20)
041A  14000000           [4] (20)
041E  15000000           [5] (21)
0422  16000000           [6] (22)
                         * locals:
0426  02000000           sizelocvars (2)
042A  0500000000000000   string size (5)
0432  636F646500         "code\0"
                         local [0]: code
0437  04000000             startpc (4)
043B  05000000             endpc   (5)
043F  0400000000000000   string size (4)
0447  72657300           "res\0"
                         local [1]: res
044B  04000000             startpc (4)
044F  05000000             endpc   (5)
                         * upvalues:
0453  01000000           sizeupvalues (1)
0457  0300000000000000   string size (3)
045F  636F00             "co\0"
                         upvalue [0]: co
                         ** end of function 0_1_1 **

                         * lines:
0462  09000000           sizelineinfo (9)
                         [pc] (line)
0466  12000000           [1] (18)
046A  12000000           [2] (18)
046E  12000000           [3] (18)
0472  12000000           [4] (18)
0476  12000000           [5] (18)
047A  16000000           [6] (22)
047E  16000000           [7] (22)
0482  16000000           [8] (22)
0486  17000000           [9] (23)
                         * locals:
048A  02000000           sizelocvars (2)
048E  0200000000000000   string size (2)
0496  6100               "a\0"
                         local [0]: a
0498  00000000             startpc (0)
049C  08000000             endpc   (8)
04A0  0300000000000000   string size (3)
04A8  636F00             "co\0"
                         local [1]: co
04AB  05000000             startpc (5)
04AF  08000000             endpc   (8)
                         * upvalues:
04B3  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
04B7  16000000           sizelineinfo (22)
                         [pc] (line)
04BB  0F000000           [01] (15)
04BF  01000000           [02] (1)
04C3  17000000           [03] (23)
04C7  11000000           [04] (17)
04CB  19000000           [05] (25)
04CF  19000000           [06] (25)
04D3  19000000           [07] (25)
04D7  19000000           [08] (25)
04DB  19000000           [09] (25)
04DF  19000000           [10] (25)
04E3  19000000           [11] (25)
04E7  19000000           [12] (25)
04EB  1A000000           [13] (26)
04EF  1A000000           [14] (26)
04F3  1A000000           [15] (26)
04F7  1A000000           [16] (26)
04FB  1A000000           [17] (26)
04FF  1A000000           [18] (26)
0503  1A000000           [19] (26)
0507  19000000           [20] (25)
050B  1A000000           [21] (26)
050F  1B000000           [22] (27)
                         * locals:
0513  04000000           sizelocvars (4)
0517  1000000000000000   string size (16)
051F  28666F722067656E+  "(for gen"
0527  657261746F722900   "erator)\0"
                         local [0]: (for generator)
052F  0B000000             startpc (11)
0533  15000000             endpc   (21)
0537  0C00000000000000   string size (12)
053F  28666F7220737461+  "(for sta"
0547  74652900           "te)\0"
                         local [1]: (for state)
054B  0B000000             startpc (11)
054F  15000000             endpc   (21)
0553  0E00000000000000   string size (14)
055B  28666F7220636F6E+  "(for con"
0563  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0569  0B000000             startpc (11)
056D  15000000             endpc   (21)
0571  0200000000000000   string size (2)
0579  7000               "p\0"
                         local [3]: p
057B  0C000000             startpc (12)
057F  13000000             endpc   (19)
                         * upvalues:
0583  00000000           sizeupvalues (0)
                         ** end of function 0 **

0587                     ** end of chunk **
