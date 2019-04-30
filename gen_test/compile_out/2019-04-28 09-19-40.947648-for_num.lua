------------------------------
for i=1,2,100 do f() end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
-- 三个特殊标识符（用圆括号）
-- 对应RA，RA+1，RA+2
-- 循环变量i对应RA+3
.local  "(for index)"  ; 0
.local  "(for limit)"  ; 1
.local  "(for step)"  ; 2
.local  "i"  ; 3
.const  1  ; 0
.const  2  ; 1
.const  100  ; 2
.const  "f"  ; 3
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 100
[4] forprep    0   2        ; R0 -= R2; PC := 7
[5] getglobal  4   3        ; R4 := f
[6] call       4   1   1    ;  := R4()
[7] forloop    0   -3       ; R0 += R2; if R0 <= R1 then begin PC := 5; R3 := R0 end
[8] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "(for index)"  ; 0
.local  "(for limit)"  ; 1
.local  "(for step)"  ; 2
.local  "i"  ; 3
.const  1  ; 0
.const  2  ; 1
.const  100  ; 2
.const  "f"  ; 3
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 100
[4] forprep    0   2        ; R0 -= R2; PC := 7
[5] getglobal  4   3        ; R4 := f
[6] call       4   1   1    ;  := R4()
[7] forloop    0   -3       ; R0 += R2; if R0 <= R1 then begin PC := 5; R3 := R0 end
[8] return     0   1        ; return 
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
002B  08000000           sizecode (8)
002F  01000000           [1] loadk      0   0        ; R0 := 1
0033  41400000           [2] loadk      1   1        ; R1 := 2
0037  81800000           [3] loadk      2   2        ; R2 := 100
003B  20400080           [4] forprep    0   2        ; R0 -= R2; PC := 7
003F  05C10000           [5] getglobal  4   3        ; R4 := f
0043  1C418000           [6] call       4   1   1    ;  := R4()
0047  1F00FF7F           [7] forloop    0   -3       ; R0 += R2; if R0 <= R1 then begin PC := 5; R3 := R0 end
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  000000000000F03F   const [0]: (1)
005C  03                 const type 3
005D  0000000000000040   const [1]: (2)
0065  03                 const type 3
0066  0000000000005940   const [2]: (100)
006E  04                 const type 4
006F  0200000000000000   string size (2)
0077  6600               "f\0"
                         const [3]: "f"
                         * functions:
0079  00000000           sizep (0)
                         * lines:
007D  08000000           sizelineinfo (8)
                         [pc] (line)
0081  01000000           [1] (1)
0085  01000000           [2] (1)
0089  01000000           [3] (1)
008D  01000000           [4] (1)
0091  01000000           [5] (1)
0095  01000000           [6] (1)
0099  01000000           [7] (1)
009D  01000000           [8] (1)
                         * locals:
00A1  04000000           sizelocvars (4)
00A5  0C00000000000000   string size (12)
00AD  28666F7220696E64+  "(for ind"
00B5  65782900           "ex)\0"
                         local [0]: (for index)
00B9  03000000             startpc (3)
00BD  07000000             endpc   (7)
00C1  0C00000000000000   string size (12)
00C9  28666F72206C696D+  "(for lim"
00D1  69742900           "it)\0"
                         local [1]: (for limit)
00D5  03000000             startpc (3)
00D9  07000000             endpc   (7)
00DD  0B00000000000000   string size (11)
00E5  28666F7220737465+  "(for ste"
00ED  702900             "p)\0"
                         local [2]: (for step)
00F0  03000000             startpc (3)
00F4  07000000             endpc   (7)
00F8  0200000000000000   string size (2)
0100  6900               "i\0"
                         local [3]: i
0102  04000000             startpc (4)
0106  06000000             endpc   (6)
                         * upvalues:
010A  00000000           sizeupvalues (0)
                         ** end of function 0 **

010E                     ** end of chunk **
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
002B  08000000           sizecode (8)
002F  01000000           [1] loadk      0   0        ; R0 := 1
0033  41400000           [2] loadk      1   1        ; R1 := 2
0037  81800000           [3] loadk      2   2        ; R2 := 100
003B  20400080           [4] forprep    0   2        ; R0 -= R2; PC := 7
003F  05C10000           [5] getglobal  4   3        ; R4 := f
0043  1C418000           [6] call       4   1   1    ;  := R4()
0047  1F00FF7F           [7] forloop    0   -3       ; R0 += R2; if R0 <= R1 then begin PC := 5; R3 := R0 end
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  000000000000F03F   const [0]: (1)
005C  03                 const type 3
005D  0000000000000040   const [1]: (2)
0065  03                 const type 3
0066  0000000000005940   const [2]: (100)
006E  04                 const type 4
006F  0200000000000000   string size (2)
0077  6600               "f\0"
                         const [3]: "f"
                         * functions:
0079  00000000           sizep (0)
                         * lines:
007D  08000000           sizelineinfo (8)
                         [pc] (line)
0081  01000000           [1] (1)
0085  01000000           [2] (1)
0089  01000000           [3] (1)
008D  01000000           [4] (1)
0091  01000000           [5] (1)
0095  01000000           [6] (1)
0099  01000000           [7] (1)
009D  01000000           [8] (1)
                         * locals:
00A1  04000000           sizelocvars (4)
00A5  0C00000000000000   string size (12)
00AD  28666F7220696E64+  "(for ind"
00B5  65782900           "ex)\0"
                         local [0]: (for index)
00B9  03000000             startpc (3)
00BD  07000000             endpc   (7)
00C1  0C00000000000000   string size (12)
00C9  28666F72206C696D+  "(for lim"
00D1  69742900           "it)\0"
                         local [1]: (for limit)
00D5  03000000             startpc (3)
00D9  07000000             endpc   (7)
00DD  0B00000000000000   string size (11)
00E5  28666F7220737465+  "(for ste"
00ED  702900             "p)\0"
                         local [2]: (for step)
00F0  03000000             startpc (3)
00F4  07000000             endpc   (7)
00F8  0200000000000000   string size (2)
0100  6900               "i\0"
                         local [3]: i
0102  04000000             startpc (4)
0106  06000000             endpc   (6)
                         * upvalues:
010A  00000000           sizeupvalues (0)
                         ** end of function 0 **

010E                     ** end of chunk **
