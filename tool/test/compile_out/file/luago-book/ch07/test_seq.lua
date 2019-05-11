------------------------------
local t = {1,2,3}
-- print(#t)
t[3]=nil
-- print(#t)
t[2]=nil
-- print(#t)
if #t ~= 1 then
  fail()
else
  -- print("ok")
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.local  "t"  ; 0
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  nil  ; 3
.const  "fail"  ; 4
[01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[02] loadk      1   0        ; R1 := 1
[03] loadk      2   1        ; R2 := 2
[04] loadk      3   2        ; R3 := 3
[05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[06] settable   0   258 259  ; R0[3] := nil
[07] settable   0   257 259  ; R0[2] := nil
[08] len        1   0        ; R1 := #R0
[09] eq         1   1   256  ; R1 == 1, pc+=1 (goto [11]) if false
[10] jmp        3            ; pc+=3 (goto [14])
[11] getglobal  1   4        ; R1 := fail
[12] call       1   1   1    ;  := R1()
[13] jmp        0            ; pc+=0 (goto [14])
[14] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.local  "t"  ; 0
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  nil  ; 3
.const  "fail"  ; 4
[01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[02] loadk      1   0        ; R1 := 1
[03] loadk      2   1        ; R2 := 2
[04] loadk      3   2        ; R3 := 3
[05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[06] settable   0   258 259  ; R0[3] := nil
[07] settable   0   257 259  ; R0[2] := nil
[08] len        1   0        ; R1 := #R0
[09] eq         1   1   256  ; R1 == 1, pc+=1 (goto [11]) if false
[10] jmp        3            ; pc+=3 (goto [14])
[11] getglobal  1   4        ; R1 := fail
[12] call       1   1   1    ;  := R1()
[13] jmp        0            ; pc+=0 (goto [14])
[14] return     0   1        ; return 
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
002A  04                 maxstacksize (4)
                         * code:
002B  0E000000           sizecode (14)
002F  0A008001           [01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0033  41000000           [02] loadk      1   0        ; R1 := 1
0037  81400000           [03] loadk      2   1        ; R2 := 2
003B  C1800000           [04] loadk      3   2        ; R3 := 3
003F  22408001           [05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
0043  09C04081           [06] settable   0   258 259  ; R0[3] := nil
0047  09C0C080           [07] settable   0   257 259  ; R0[2] := nil
004B  54000000           [08] len        1   0        ; R1 := #R0
004F  5700C000           [09] eq         1   1   256  ; R1 == 1, pc+=1 (goto [11]) if false
0053  16800080           [10] jmp        3            ; pc+=3 (goto [14])
0057  45000100           [11] getglobal  1   4        ; R1 := fail
005B  5C408000           [12] call       1   1   1    ;  := R1()
005F  16C0FF7F           [13] jmp        0            ; pc+=0 (goto [14])
0063  1E008000           [14] return     0   1        ; return 
                         * constants:
0067  05000000           sizek (5)
006B  03                 const type 3
006C  000000000000F03F   const [0]: (1)
0074  03                 const type 3
0075  0000000000000040   const [1]: (2)
007D  03                 const type 3
007E  0000000000000840   const [2]: (3)
0086  00                 const type 0
                         const [3]: nil
0087  04                 const type 4
0088  0500000000000000   string size (5)
0090  6661696C00         "fail\0"
                         const [4]: "fail"
                         * functions:
0095  00000000           sizep (0)
                         * lines:
0099  0E000000           sizelineinfo (14)
                         [pc] (line)
009D  01000000           [01] (1)
00A1  01000000           [02] (1)
00A5  01000000           [03] (1)
00A9  01000000           [04] (1)
00AD  01000000           [05] (1)
00B1  03000000           [06] (3)
00B5  05000000           [07] (5)
00B9  07000000           [08] (7)
00BD  07000000           [09] (7)
00C1  07000000           [10] (7)
00C5  08000000           [11] (8)
00C9  08000000           [12] (8)
00CD  08000000           [13] (8)
00D1  0B000000           [14] (11)
                         * locals:
00D5  01000000           sizelocvars (1)
00D9  0200000000000000   string size (2)
00E1  7400               "t\0"
                         local [0]: t
00E3  05000000             startpc (5)
00E7  0D000000             endpc   (13)
                         * upvalues:
00EB  00000000           sizeupvalues (0)
                         ** end of function 0 **

00EF                     ** end of chunk **
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
002A  04                 maxstacksize (4)
                         * code:
002B  0E000000           sizecode (14)
002F  0A008001           [01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0033  41000000           [02] loadk      1   0        ; R1 := 1
0037  81400000           [03] loadk      2   1        ; R2 := 2
003B  C1800000           [04] loadk      3   2        ; R3 := 3
003F  22408001           [05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
0043  09C04081           [06] settable   0   258 259  ; R0[3] := nil
0047  09C0C080           [07] settable   0   257 259  ; R0[2] := nil
004B  54000000           [08] len        1   0        ; R1 := #R0
004F  5700C000           [09] eq         1   1   256  ; R1 == 1, pc+=1 (goto [11]) if false
0053  16800080           [10] jmp        3            ; pc+=3 (goto [14])
0057  45000100           [11] getglobal  1   4        ; R1 := fail
005B  5C408000           [12] call       1   1   1    ;  := R1()
005F  16C0FF7F           [13] jmp        0            ; pc+=0 (goto [14])
0063  1E008000           [14] return     0   1        ; return 
                         * constants:
0067  05000000           sizek (5)
006B  03                 const type 3
006C  000000000000F03F   const [0]: (1)
0074  03                 const type 3
0075  0000000000000040   const [1]: (2)
007D  03                 const type 3
007E  0000000000000840   const [2]: (3)
0086  00                 const type 0
                         const [3]: nil
0087  04                 const type 4
0088  0500000000000000   string size (5)
0090  6661696C00         "fail\0"
                         const [4]: "fail"
                         * functions:
0095  00000000           sizep (0)
                         * lines:
0099  0E000000           sizelineinfo (14)
                         [pc] (line)
009D  01000000           [01] (1)
00A1  01000000           [02] (1)
00A5  01000000           [03] (1)
00A9  01000000           [04] (1)
00AD  01000000           [05] (1)
00B1  03000000           [06] (3)
00B5  05000000           [07] (5)
00B9  07000000           [08] (7)
00BD  07000000           [09] (7)
00C1  07000000           [10] (7)
00C5  08000000           [11] (8)
00C9  08000000           [12] (8)
00CD  08000000           [13] (8)
00D1  0B000000           [14] (11)
                         * locals:
00D5  01000000           sizelocvars (1)
00D9  0200000000000000   string size (2)
00E1  7400               "t\0"
                         local [0]: t
00E3  05000000             startpc (5)
00E7  0D000000             endpc   (13)
                         * upvalues:
00EB  00000000           sizeupvalues (0)
                         ** end of function 0 **

00EF                     ** end of chunk **
