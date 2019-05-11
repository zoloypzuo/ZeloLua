------------------------------
function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n-1)
  end
end

print(fact(10))

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "fact"  ; 0
.const  "print"  ; 1
.const  10  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; fact := R0
[3] getglobal  0   1        ; R0 := print
[4] getglobal  1   0        ; R1 := fact
[5] loadk      2   2        ; R2 := 10
[6] call       1   2   0    ; R1 to top := R1(R2)
[7] call       0   0   1    ;  := R0(R1 to top)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "n"  ; 0
.const  0  ; 0
.const  1  ; 1
.const  "fact"  ; 2
[01] eq         0   0   256  ; R0 == 0, pc+=1 (goto [3]) if true
[02] jmp        3            ; pc+=3 (goto [6])
[03] loadk      1   1        ; R1 := 1
[04] return     1   2        ; return R1
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  1   2        ; R1 := fact
[07] sub        2   0   257  ; R2 := R0 - 1
[08] call       1   2   2    ; R1 := R1(R2)
[09] mul        1   0   1    ; R1 := R0 * R1
[10] return     1   2        ; return R1
[11] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "fact"  ; 0
.const  "print"  ; 1
.const  10  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; fact := R0
[3] getglobal  0   1        ; R0 := print
[4] getglobal  1   0        ; R1 := fact
[5] loadk      2   2        ; R2 := 10
[6] call       1   2   0    ; R1 to top := R1(R2)
[7] call       0   0   1    ;  := R0(R1 to top)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "n"  ; 0
.const  0  ; 0
.const  1  ; 1
.const  "fact"  ; 2
[01] eq         0   0   256  ; R0 == 0, pc+=1 (goto [3]) if true
[02] jmp        3            ; pc+=3 (goto [6])
[03] loadk      1   1        ; R1 := 1
[04] return     1   2        ; return R1
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  1   2        ; R1 := fact
[07] sub        2   0   257  ; R2 := R0 - 1
[08] call       1   2   2    ; R1 := R1(R2)
[09] mul        1   0   1    ; R1 := R0 * R1
[10] return     1   2        ; return R1
[11] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; fact := R0
0037  05400000           [3] getglobal  0   1        ; R0 := print
003B  45000000           [4] getglobal  1   0        ; R1 := fact
003F  81800000           [5] loadk      2   2        ; R2 := 10
0043  5C000001           [6] call       1   2   0    ; R1 to top := R1(R2)
0047  1C400000           [7] call       0   0   1    ;  := R0(R1 to top)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  03000000           sizek (3)
0053  04                 const type 4
0054  0500000000000000   string size (5)
005C  6661637400         "fact\0"
                         const [0]: "fact"
0061  04                 const type 4
0062  0600000000000000   string size (6)
006A  7072696E7400       "print\0"
                         const [1]: "print"
0070  03                 const type 3
0071  0000000000002440   const [2]: (10)
                         * functions:
0079  01000000           sizep (1)
                         
007D                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
007D  0000000000000000   string size (0)
                         source name: (none)
0085  01000000           line defined (1)
0089  07000000           last line defined (7)
008D  00                 nups (0)
008E  01                 numparams (1)
008F  00                 is_vararg (0)
0090  03                 maxstacksize (3)
                         * code:
0091  0B000000           sizecode (11)
0095  17004000           [01] eq         0   0   256  ; R0 == 0, pc+=1 (goto [3]) if true
0099  16800080           [02] jmp        3            ; pc+=3 (goto [6])
009D  41400000           [03] loadk      1   1        ; R1 := 1
00A1  5E000001           [04] return     1   2        ; return R1
00A5  16000180           [05] jmp        5            ; pc+=5 (goto [11])
00A9  45800000           [06] getglobal  1   2        ; R1 := fact
00AD  8D404000           [07] sub        2   0   257  ; R2 := R0 - 1
00B1  5C800001           [08] call       1   2   2    ; R1 := R1(R2)
00B5  4E400000           [09] mul        1   0   1    ; R1 := R0 * R1
00B9  5E000001           [10] return     1   2        ; return R1
00BD  1E008000           [11] return     0   1        ; return 
                         * constants:
00C1  03000000           sizek (3)
00C5  03                 const type 3
00C6  0000000000000000   const [0]: (0)
00CE  03                 const type 3
00CF  000000000000F03F   const [1]: (1)
00D7  04                 const type 4
00D8  0500000000000000   string size (5)
00E0  6661637400         "fact\0"
                         const [2]: "fact"
                         * functions:
00E5  00000000           sizep (0)
                         * lines:
00E9  0B000000           sizelineinfo (11)
                         [pc] (line)
00ED  02000000           [01] (2)
00F1  02000000           [02] (2)
00F5  03000000           [03] (3)
00F9  03000000           [04] (3)
00FD  03000000           [05] (3)
0101  05000000           [06] (5)
0105  05000000           [07] (5)
0109  05000000           [08] (5)
010D  05000000           [09] (5)
0111  05000000           [10] (5)
0115  07000000           [11] (7)
                         * locals:
0119  01000000           sizelocvars (1)
011D  0200000000000000   string size (2)
0125  6E00               "n\0"
                         local [0]: n
0127  00000000             startpc (0)
012B  0A000000             endpc   (10)
                         * upvalues:
012F  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
0133  08000000           sizelineinfo (8)
                         [pc] (line)
0137  07000000           [1] (7)
013B  01000000           [2] (1)
013F  09000000           [3] (9)
0143  09000000           [4] (9)
0147  09000000           [5] (9)
014B  09000000           [6] (9)
014F  09000000           [7] (9)
0153  09000000           [8] (9)
                         * locals:
0157  00000000           sizelocvars (0)
                         * upvalues:
015B  00000000           sizeupvalues (0)
                         ** end of function 0 **

015F                     ** end of chunk **
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
002A  03                 maxstacksize (3)
                         * code:
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; fact := R0
0037  05400000           [3] getglobal  0   1        ; R0 := print
003B  45000000           [4] getglobal  1   0        ; R1 := fact
003F  81800000           [5] loadk      2   2        ; R2 := 10
0043  5C000001           [6] call       1   2   0    ; R1 to top := R1(R2)
0047  1C400000           [7] call       0   0   1    ;  := R0(R1 to top)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  03000000           sizek (3)
0053  04                 const type 4
0054  0500000000000000   string size (5)
005C  6661637400         "fact\0"
                         const [0]: "fact"
0061  04                 const type 4
0062  0600000000000000   string size (6)
006A  7072696E7400       "print\0"
                         const [1]: "print"
0070  03                 const type 3
0071  0000000000002440   const [2]: (10)
                         * functions:
0079  01000000           sizep (1)
                         
007D                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
007D  0000000000000000   string size (0)
                         source name: (none)
0085  01000000           line defined (1)
0089  07000000           last line defined (7)
008D  00                 nups (0)
008E  01                 numparams (1)
008F  00                 is_vararg (0)
0090  03                 maxstacksize (3)
                         * code:
0091  0B000000           sizecode (11)
0095  17004000           [01] eq         0   0   256  ; R0 == 0, pc+=1 (goto [3]) if true
0099  16800080           [02] jmp        3            ; pc+=3 (goto [6])
009D  41400000           [03] loadk      1   1        ; R1 := 1
00A1  5E000001           [04] return     1   2        ; return R1
00A5  16000180           [05] jmp        5            ; pc+=5 (goto [11])
00A9  45800000           [06] getglobal  1   2        ; R1 := fact
00AD  8D404000           [07] sub        2   0   257  ; R2 := R0 - 1
00B1  5C800001           [08] call       1   2   2    ; R1 := R1(R2)
00B5  4E400000           [09] mul        1   0   1    ; R1 := R0 * R1
00B9  5E000001           [10] return     1   2        ; return R1
00BD  1E008000           [11] return     0   1        ; return 
                         * constants:
00C1  03000000           sizek (3)
00C5  03                 const type 3
00C6  0000000000000000   const [0]: (0)
00CE  03                 const type 3
00CF  000000000000F03F   const [1]: (1)
00D7  04                 const type 4
00D8  0500000000000000   string size (5)
00E0  6661637400         "fact\0"
                         const [2]: "fact"
                         * functions:
00E5  00000000           sizep (0)
                         * lines:
00E9  0B000000           sizelineinfo (11)
                         [pc] (line)
00ED  02000000           [01] (2)
00F1  02000000           [02] (2)
00F5  03000000           [03] (3)
00F9  03000000           [04] (3)
00FD  03000000           [05] (3)
0101  05000000           [06] (5)
0105  05000000           [07] (5)
0109  05000000           [08] (5)
010D  05000000           [09] (5)
0111  05000000           [10] (5)
0115  07000000           [11] (7)
                         * locals:
0119  01000000           sizelocvars (1)
011D  0200000000000000   string size (2)
0125  6E00               "n\0"
                         local [0]: n
0127  00000000             startpc (0)
012B  0A000000             endpc   (10)
                         * upvalues:
012F  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
0133  08000000           sizelineinfo (8)
                         [pc] (line)
0137  07000000           [1] (7)
013B  01000000           [2] (1)
013F  09000000           [3] (9)
0143  09000000           [4] (9)
0147  09000000           [5] (9)
014B  09000000           [6] (9)
014F  09000000           [7] (9)
0153  09000000           [8] (9)
                         * locals:
0157  00000000           sizelocvars (0)
                         * upvalues:
015B  00000000           sizeupvalues (0)
                         ** end of function 0 **

015F                     ** end of chunk **
