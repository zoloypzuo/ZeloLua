------------------------------
function range(i, j)
  local next = i - 1
  return function()
    next = next + 1
    if next > j then next = nil end
    return next
  end
end

iter = range(1, 10)
while true do
  local next = iter()
  if next == nil then break end
  print(next)
end

for n in range(1, 10) do
  print(n)
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "next"  ; 0
.local  "(for generator)"  ; 1
.local  "(for state)"  ; 2
.local  "(for control)"  ; 3
.local  "n"  ; 4
.const  "range"  ; 0
.const  "iter"  ; 1
.const  1  ; 2
.const  10  ; 3
.const  nil  ; 4
.const  "print"  ; 5
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; range := R0
[03] getglobal  0   0        ; R0 := range
[04] loadk      1   2        ; R1 := 1
[05] loadk      2   3        ; R2 := 10
[06] call       0   3   2    ; R0 := R0(R1, R2)
[07] setglobal  0   1        ; iter := R0
[08] getglobal  0   1        ; R0 := iter
[09] call       0   1   2    ; R0 := R0()
[10] eq         0   0   260  ; R0 == nil, pc+=1 (goto [12]) if true
[11] jmp        1            ; pc+=1 (goto [13])
[12] jmp        4            ; pc+=4 (goto [17])
[13] getglobal  1   5        ; R1 := print
[14] move       2   0        ; R2 := R0
[15] call       1   2   1    ;  := R1(R2)
[16] jmp        -9           ; pc+=-9 (goto [8])
[17] getglobal  0   0        ; R0 := range
[18] loadk      1   2        ; R1 := 1
[19] loadk      2   3        ; R2 := 10
[20] call       0   3   4    ; R0 to R2 := R0(R1, R2)
[21] jmp        3            ; pc+=3 (goto [25])
[22] getglobal  4   5        ; R4 := print
[23] move       5   3        ; R5 := R3
[24] call       4   2   1    ;  := R4(R5)
[25] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 27
[26] jmp        -5           ; pc+=-5 (goto [22])
[27] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "i"  ; 0
.local  "j"  ; 1
.local  "next"  ; 2
.const  1  ; 0
[1] sub        2   0   256  ; R2 := R0 - 1
[2] closure    3   0        ; R3 := closure(function[0]) 2 upvalues
[3] move       0   2        ; R0 := R2
[4] move       0   1        ; R0 := R1
[5] return     3   2        ; return R3
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "next"  ; 0
.upvalue  "j"  ; 1
.const  1  ; 0
[01] getupval   0   0        ; R0 := U0 , next
[02] add        0   0   256  ; R0 := R0 + 1
[03] setupval   0   0        ; U0 := R0 , next
[04] getupval   0   0        ; R0 := U0 , next
[05] getupval   1   1        ; R1 := U1 , j
[06] lt         0   1   0    ; R1 < R0, pc+=1 (goto [8]) if true
[07] jmp        2            ; pc+=2 (goto [10])
[08] loadnil    0   0        ; R0,  := nil
[09] setupval   0   0        ; U0 := R0 , next
[10] getupval   0   0        ; R0 := U0 , next
[11] return     0   2        ; return R0
[12] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "next"  ; 0
.local  "(for generator)"  ; 1
.local  "(for state)"  ; 2
.local  "(for control)"  ; 3
.local  "n"  ; 4
.const  "range"  ; 0
.const  "iter"  ; 1
.const  1  ; 2
.const  10  ; 3
.const  nil  ; 4
.const  "print"  ; 5
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; range := R0
[03] getglobal  0   0        ; R0 := range
[04] loadk      1   2        ; R1 := 1
[05] loadk      2   3        ; R2 := 10
[06] call       0   3   2    ; R0 := R0(R1, R2)
[07] setglobal  0   1        ; iter := R0
[08] getglobal  0   1        ; R0 := iter
[09] call       0   1   2    ; R0 := R0()
[10] eq         0   0   260  ; R0 == nil, pc+=1 (goto [12]) if true
[11] jmp        1            ; pc+=1 (goto [13])
[12] jmp        4            ; pc+=4 (goto [17])
[13] getglobal  1   5        ; R1 := print
[14] move       2   0        ; R2 := R0
[15] call       1   2   1    ;  := R1(R2)
[16] jmp        -9           ; pc+=-9 (goto [8])
[17] getglobal  0   0        ; R0 := range
[18] loadk      1   2        ; R1 := 1
[19] loadk      2   3        ; R2 := 10
[20] call       0   3   4    ; R0 to R2 := R0(R1, R2)
[21] jmp        3            ; pc+=3 (goto [25])
[22] getglobal  4   5        ; R4 := print
[23] move       5   3        ; R5 := R3
[24] call       4   2   1    ;  := R4(R5)
[25] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 27
[26] jmp        -5           ; pc+=-5 (goto [22])
[27] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "i"  ; 0
.local  "j"  ; 1
.local  "next"  ; 2
.const  1  ; 0
[1] sub        2   0   256  ; R2 := R0 - 1
[2] closure    3   0        ; R3 := closure(function[0]) 2 upvalues
[3] move       0   2        ; R0 := R2
[4] move       0   1        ; R0 := R1
[5] return     3   2        ; return R3
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "next"  ; 0
.upvalue  "j"  ; 1
.const  1  ; 0
[01] getupval   0   0        ; R0 := U0 , next
[02] add        0   0   256  ; R0 := R0 + 1
[03] setupval   0   0        ; U0 := R0 , next
[04] getupval   0   0        ; R0 := U0 , next
[05] getupval   1   1        ; R1 := U1 , j
[06] lt         0   1   0    ; R1 < R0, pc+=1 (goto [8]) if true
[07] jmp        2            ; pc+=2 (goto [10])
[08] loadnil    0   0        ; R0,  := nil
[09] setupval   0   0        ; U0 := R0 , next
[10] getupval   0   0        ; R0 := U0 , next
[11] return     0   2        ; return R0
[12] return     0   1        ; return 
; end of function 0_0_0

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
002A  06                 maxstacksize (6)
                         * code:
002B  1B000000           sizecode (27)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; range := R0
0037  05000000           [03] getglobal  0   0        ; R0 := range
003B  41800000           [04] loadk      1   2        ; R1 := 1
003F  81C00000           [05] loadk      2   3        ; R2 := 10
0043  1C808001           [06] call       0   3   2    ; R0 := R0(R1, R2)
0047  07400000           [07] setglobal  0   1        ; iter := R0
004B  05400000           [08] getglobal  0   1        ; R0 := iter
004F  1C808000           [09] call       0   1   2    ; R0 := R0()
0053  17004100           [10] eq         0   0   260  ; R0 == nil, pc+=1 (goto [12]) if true
0057  16000080           [11] jmp        1            ; pc+=1 (goto [13])
005B  16C00080           [12] jmp        4            ; pc+=4 (goto [17])
005F  45400100           [13] getglobal  1   5        ; R1 := print
0063  80000000           [14] move       2   0        ; R2 := R0
0067  5C400001           [15] call       1   2   1    ;  := R1(R2)
006B  1680FD7F           [16] jmp        -9           ; pc+=-9 (goto [8])
006F  05000000           [17] getglobal  0   0        ; R0 := range
0073  41800000           [18] loadk      1   2        ; R1 := 1
0077  81C00000           [19] loadk      2   3        ; R2 := 10
007B  1C008101           [20] call       0   3   4    ; R0 to R2 := R0(R1, R2)
007F  16800080           [21] jmp        3            ; pc+=3 (goto [25])
0083  05410100           [22] getglobal  4   5        ; R4 := print
0087  40018001           [23] move       5   3        ; R5 := R3
008B  1C410001           [24] call       4   2   1    ;  := R4(R5)
008F  21400000           [25] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 27
0093  1680FE7F           [26] jmp        -5           ; pc+=-5 (goto [22])
0097  1E008000           [27] return     0   1        ; return 
                         * constants:
009B  06000000           sizek (6)
009F  04                 const type 4
00A0  0600000000000000   string size (6)
00A8  72616E676500       "range\0"
                         const [0]: "range"
00AE  04                 const type 4
00AF  0500000000000000   string size (5)
00B7  6974657200         "iter\0"
                         const [1]: "iter"
00BC  03                 const type 3
00BD  000000000000F03F   const [2]: (1)
00C5  03                 const type 3
00C6  0000000000002440   const [3]: (10)
00CE  00                 const type 0
                         const [4]: nil
00CF  04                 const type 4
00D0  0600000000000000   string size (6)
00D8  7072696E7400       "print\0"
                         const [5]: "print"
                         * functions:
00DE  01000000           sizep (1)
                         
00E2                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E2  0000000000000000   string size (0)
                         source name: (none)
00EA  01000000           line defined (1)
00EE  08000000           last line defined (8)
00F2  00                 nups (0)
00F3  02                 numparams (2)
00F4  00                 is_vararg (0)
00F5  04                 maxstacksize (4)
                         * code:
00F6  06000000           sizecode (6)
00FA  8D004000           [1] sub        2   0   256  ; R2 := R0 - 1
00FE  E4000000           [2] closure    3   0        ; R3 := closure(function[0]) 2 upvalues
0102  00000001           [3] move       0   2        ; R0 := R2
0106  00008000           [4] move       0   1        ; R0 := R1
010A  DE000001           [5] return     3   2        ; return R3
010E  1E008000           [6] return     0   1        ; return 
                         * constants:
0112  01000000           sizek (1)
0116  03                 const type 3
0117  000000000000F03F   const [0]: (1)
                         * functions:
011F  01000000           sizep (1)
                         
0123                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0123  0000000000000000   string size (0)
                         source name: (none)
012B  03000000           line defined (3)
012F  07000000           last line defined (7)
0133  02                 nups (2)
0134  00                 numparams (0)
0135  00                 is_vararg (0)
0136  02                 maxstacksize (2)
                         * code:
0137  0C000000           sizecode (12)
013B  04000000           [01] getupval   0   0        ; R0 := U0 , next
013F  0C004000           [02] add        0   0   256  ; R0 := R0 + 1
0143  08000000           [03] setupval   0   0        ; U0 := R0 , next
0147  04000000           [04] getupval   0   0        ; R0 := U0 , next
014B  44008000           [05] getupval   1   1        ; R1 := U1 , j
014F  18008000           [06] lt         0   1   0    ; R1 < R0, pc+=1 (goto [8]) if true
0153  16400080           [07] jmp        2            ; pc+=2 (goto [10])
0157  03000000           [08] loadnil    0   0        ; R0,  := nil
015B  08000000           [09] setupval   0   0        ; U0 := R0 , next
015F  04000000           [10] getupval   0   0        ; R0 := U0 , next
0163  1E000001           [11] return     0   2        ; return R0
0167  1E008000           [12] return     0   1        ; return 
                         * constants:
016B  01000000           sizek (1)
016F  03                 const type 3
0170  000000000000F03F   const [0]: (1)
                         * functions:
0178  00000000           sizep (0)
                         * lines:
017C  0C000000           sizelineinfo (12)
                         [pc] (line)
0180  04000000           [01] (4)
0184  04000000           [02] (4)
0188  04000000           [03] (4)
018C  05000000           [04] (5)
0190  05000000           [05] (5)
0194  05000000           [06] (5)
0198  05000000           [07] (5)
019C  05000000           [08] (5)
01A0  05000000           [09] (5)
01A4  06000000           [10] (6)
01A8  06000000           [11] (6)
01AC  07000000           [12] (7)
                         * locals:
01B0  00000000           sizelocvars (0)
                         * upvalues:
01B4  02000000           sizeupvalues (2)
01B8  0500000000000000   string size (5)
01C0  6E65787400         "next\0"
                         upvalue [0]: next
01C5  0200000000000000   string size (2)
01CD  6A00               "j\0"
                         upvalue [1]: j
                         ** end of function 0_0_0 **

                         * lines:
01CF  06000000           sizelineinfo (6)
                         [pc] (line)
01D3  02000000           [1] (2)
01D7  07000000           [2] (7)
01DB  07000000           [3] (7)
01DF  07000000           [4] (7)
01E3  07000000           [5] (7)
01E7  08000000           [6] (8)
                         * locals:
01EB  03000000           sizelocvars (3)
01EF  0200000000000000   string size (2)
01F7  6900               "i\0"
                         local [0]: i
01F9  00000000             startpc (0)
01FD  05000000             endpc   (5)
0201  0200000000000000   string size (2)
0209  6A00               "j\0"
                         local [1]: j
020B  00000000             startpc (0)
020F  05000000             endpc   (5)
0213  0500000000000000   string size (5)
021B  6E65787400         "next\0"
                         local [2]: next
0220  01000000             startpc (1)
0224  05000000             endpc   (5)
                         * upvalues:
0228  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
022C  1B000000           sizelineinfo (27)
                         [pc] (line)
0230  08000000           [01] (8)
0234  01000000           [02] (1)
0238  0A000000           [03] (10)
023C  0A000000           [04] (10)
0240  0A000000           [05] (10)
0244  0A000000           [06] (10)
0248  0A000000           [07] (10)
024C  0C000000           [08] (12)
0250  0C000000           [09] (12)
0254  0D000000           [10] (13)
0258  0D000000           [11] (13)
025C  0D000000           [12] (13)
0260  0E000000           [13] (14)
0264  0E000000           [14] (14)
0268  0E000000           [15] (14)
026C  0E000000           [16] (14)
0270  11000000           [17] (17)
0274  11000000           [18] (17)
0278  11000000           [19] (17)
027C  11000000           [20] (17)
0280  11000000           [21] (17)
0284  12000000           [22] (18)
0288  12000000           [23] (18)
028C  12000000           [24] (18)
0290  11000000           [25] (17)
0294  12000000           [26] (18)
0298  13000000           [27] (19)
                         * locals:
029C  05000000           sizelocvars (5)
02A0  0500000000000000   string size (5)
02A8  6E65787400         "next\0"
                         local [0]: next
02AD  09000000             startpc (9)
02B1  0F000000             endpc   (15)
02B5  1000000000000000   string size (16)
02BD  28666F722067656E+  "(for gen"
02C5  657261746F722900   "erator)\0"
                         local [1]: (for generator)
02CD  14000000             startpc (20)
02D1  1A000000             endpc   (26)
02D5  0C00000000000000   string size (12)
02DD  28666F7220737461+  "(for sta"
02E5  74652900           "te)\0"
                         local [2]: (for state)
02E9  14000000             startpc (20)
02ED  1A000000             endpc   (26)
02F1  0E00000000000000   string size (14)
02F9  28666F7220636F6E+  "(for con"
0301  74726F6C2900       "trol)\0"
                         local [3]: (for control)
0307  14000000             startpc (20)
030B  1A000000             endpc   (26)
030F  0200000000000000   string size (2)
0317  6E00               "n\0"
                         local [4]: n
0319  15000000             startpc (21)
031D  18000000             endpc   (24)
                         * upvalues:
0321  00000000           sizeupvalues (0)
                         ** end of function 0 **

0325                     ** end of chunk **
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
002B  1B000000           sizecode (27)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; range := R0
0037  05000000           [03] getglobal  0   0        ; R0 := range
003B  41800000           [04] loadk      1   2        ; R1 := 1
003F  81C00000           [05] loadk      2   3        ; R2 := 10
0043  1C808001           [06] call       0   3   2    ; R0 := R0(R1, R2)
0047  07400000           [07] setglobal  0   1        ; iter := R0
004B  05400000           [08] getglobal  0   1        ; R0 := iter
004F  1C808000           [09] call       0   1   2    ; R0 := R0()
0053  17004100           [10] eq         0   0   260  ; R0 == nil, pc+=1 (goto [12]) if true
0057  16000080           [11] jmp        1            ; pc+=1 (goto [13])
005B  16C00080           [12] jmp        4            ; pc+=4 (goto [17])
005F  45400100           [13] getglobal  1   5        ; R1 := print
0063  80000000           [14] move       2   0        ; R2 := R0
0067  5C400001           [15] call       1   2   1    ;  := R1(R2)
006B  1680FD7F           [16] jmp        -9           ; pc+=-9 (goto [8])
006F  05000000           [17] getglobal  0   0        ; R0 := range
0073  41800000           [18] loadk      1   2        ; R1 := 1
0077  81C00000           [19] loadk      2   3        ; R2 := 10
007B  1C008101           [20] call       0   3   4    ; R0 to R2 := R0(R1, R2)
007F  16800080           [21] jmp        3            ; pc+=3 (goto [25])
0083  05410100           [22] getglobal  4   5        ; R4 := print
0087  40018001           [23] move       5   3        ; R5 := R3
008B  1C410001           [24] call       4   2   1    ;  := R4(R5)
008F  21400000           [25] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 27
0093  1680FE7F           [26] jmp        -5           ; pc+=-5 (goto [22])
0097  1E008000           [27] return     0   1        ; return 
                         * constants:
009B  06000000           sizek (6)
009F  04                 const type 4
00A0  0600000000000000   string size (6)
00A8  72616E676500       "range\0"
                         const [0]: "range"
00AE  04                 const type 4
00AF  0500000000000000   string size (5)
00B7  6974657200         "iter\0"
                         const [1]: "iter"
00BC  03                 const type 3
00BD  000000000000F03F   const [2]: (1)
00C5  03                 const type 3
00C6  0000000000002440   const [3]: (10)
00CE  00                 const type 0
                         const [4]: nil
00CF  04                 const type 4
00D0  0600000000000000   string size (6)
00D8  7072696E7400       "print\0"
                         const [5]: "print"
                         * functions:
00DE  01000000           sizep (1)
                         
00E2                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E2  0000000000000000   string size (0)
                         source name: (none)
00EA  01000000           line defined (1)
00EE  08000000           last line defined (8)
00F2  00                 nups (0)
00F3  02                 numparams (2)
00F4  00                 is_vararg (0)
00F5  04                 maxstacksize (4)
                         * code:
00F6  06000000           sizecode (6)
00FA  8D004000           [1] sub        2   0   256  ; R2 := R0 - 1
00FE  E4000000           [2] closure    3   0        ; R3 := closure(function[0]) 2 upvalues
0102  00000001           [3] move       0   2        ; R0 := R2
0106  00008000           [4] move       0   1        ; R0 := R1
010A  DE000001           [5] return     3   2        ; return R3
010E  1E008000           [6] return     0   1        ; return 
                         * constants:
0112  01000000           sizek (1)
0116  03                 const type 3
0117  000000000000F03F   const [0]: (1)
                         * functions:
011F  01000000           sizep (1)
                         
0123                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0123  0000000000000000   string size (0)
                         source name: (none)
012B  03000000           line defined (3)
012F  07000000           last line defined (7)
0133  02                 nups (2)
0134  00                 numparams (0)
0135  00                 is_vararg (0)
0136  02                 maxstacksize (2)
                         * code:
0137  0C000000           sizecode (12)
013B  04000000           [01] getupval   0   0        ; R0 := U0 , next
013F  0C004000           [02] add        0   0   256  ; R0 := R0 + 1
0143  08000000           [03] setupval   0   0        ; U0 := R0 , next
0147  04000000           [04] getupval   0   0        ; R0 := U0 , next
014B  44008000           [05] getupval   1   1        ; R1 := U1 , j
014F  18008000           [06] lt         0   1   0    ; R1 < R0, pc+=1 (goto [8]) if true
0153  16400080           [07] jmp        2            ; pc+=2 (goto [10])
0157  03000000           [08] loadnil    0   0        ; R0,  := nil
015B  08000000           [09] setupval   0   0        ; U0 := R0 , next
015F  04000000           [10] getupval   0   0        ; R0 := U0 , next
0163  1E000001           [11] return     0   2        ; return R0
0167  1E008000           [12] return     0   1        ; return 
                         * constants:
016B  01000000           sizek (1)
016F  03                 const type 3
0170  000000000000F03F   const [0]: (1)
                         * functions:
0178  00000000           sizep (0)
                         * lines:
017C  0C000000           sizelineinfo (12)
                         [pc] (line)
0180  04000000           [01] (4)
0184  04000000           [02] (4)
0188  04000000           [03] (4)
018C  05000000           [04] (5)
0190  05000000           [05] (5)
0194  05000000           [06] (5)
0198  05000000           [07] (5)
019C  05000000           [08] (5)
01A0  05000000           [09] (5)
01A4  06000000           [10] (6)
01A8  06000000           [11] (6)
01AC  07000000           [12] (7)
                         * locals:
01B0  00000000           sizelocvars (0)
                         * upvalues:
01B4  02000000           sizeupvalues (2)
01B8  0500000000000000   string size (5)
01C0  6E65787400         "next\0"
                         upvalue [0]: next
01C5  0200000000000000   string size (2)
01CD  6A00               "j\0"
                         upvalue [1]: j
                         ** end of function 0_0_0 **

                         * lines:
01CF  06000000           sizelineinfo (6)
                         [pc] (line)
01D3  02000000           [1] (2)
01D7  07000000           [2] (7)
01DB  07000000           [3] (7)
01DF  07000000           [4] (7)
01E3  07000000           [5] (7)
01E7  08000000           [6] (8)
                         * locals:
01EB  03000000           sizelocvars (3)
01EF  0200000000000000   string size (2)
01F7  6900               "i\0"
                         local [0]: i
01F9  00000000             startpc (0)
01FD  05000000             endpc   (5)
0201  0200000000000000   string size (2)
0209  6A00               "j\0"
                         local [1]: j
020B  00000000             startpc (0)
020F  05000000             endpc   (5)
0213  0500000000000000   string size (5)
021B  6E65787400         "next\0"
                         local [2]: next
0220  01000000             startpc (1)
0224  05000000             endpc   (5)
                         * upvalues:
0228  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
022C  1B000000           sizelineinfo (27)
                         [pc] (line)
0230  08000000           [01] (8)
0234  01000000           [02] (1)
0238  0A000000           [03] (10)
023C  0A000000           [04] (10)
0240  0A000000           [05] (10)
0244  0A000000           [06] (10)
0248  0A000000           [07] (10)
024C  0C000000           [08] (12)
0250  0C000000           [09] (12)
0254  0D000000           [10] (13)
0258  0D000000           [11] (13)
025C  0D000000           [12] (13)
0260  0E000000           [13] (14)
0264  0E000000           [14] (14)
0268  0E000000           [15] (14)
026C  0E000000           [16] (14)
0270  11000000           [17] (17)
0274  11000000           [18] (17)
0278  11000000           [19] (17)
027C  11000000           [20] (17)
0280  11000000           [21] (17)
0284  12000000           [22] (18)
0288  12000000           [23] (18)
028C  12000000           [24] (18)
0290  11000000           [25] (17)
0294  12000000           [26] (18)
0298  13000000           [27] (19)
                         * locals:
029C  05000000           sizelocvars (5)
02A0  0500000000000000   string size (5)
02A8  6E65787400         "next\0"
                         local [0]: next
02AD  09000000             startpc (9)
02B1  0F000000             endpc   (15)
02B5  1000000000000000   string size (16)
02BD  28666F722067656E+  "(for gen"
02C5  657261746F722900   "erator)\0"
                         local [1]: (for generator)
02CD  14000000             startpc (20)
02D1  1A000000             endpc   (26)
02D5  0C00000000000000   string size (12)
02DD  28666F7220737461+  "(for sta"
02E5  74652900           "te)\0"
                         local [2]: (for state)
02E9  14000000             startpc (20)
02ED  1A000000             endpc   (26)
02F1  0E00000000000000   string size (14)
02F9  28666F7220636F6E+  "(for con"
0301  74726F6C2900       "trol)\0"
                         local [3]: (for control)
0307  14000000             startpc (20)
030B  1A000000             endpc   (26)
030F  0200000000000000   string size (2)
0317  6E00               "n\0"
                         local [4]: n
0319  15000000             startpc (21)
031D  18000000             endpc   (24)
                         * upvalues:
0321  00000000           sizeupvalues (0)
                         ** end of function 0 **

0325                     ** end of chunk **
