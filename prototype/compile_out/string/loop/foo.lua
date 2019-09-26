------------------------------
local a = 0; for i = 1, 100, 5 do a = a + i end;
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "(for index)"  ; 1
.local  "(for limit)"  ; 2
.local  "(for step)"  ; 3
.local  "i"  ; 4
.const  0  ; 0
.const  1  ; 1
.const  100  ; 2
.const  5  ; 3
[1] loadk      0   0        ; R0 := 0
[2] loadk      1   1        ; R1 := 1
[3] loadk      2   2        ; R2 := 100
[4] loadk      3   3        ; R3 := 5
[5] forprep    1   1        ; R1 -= R3; PC := 7
[6] add        0   0   4    ; R0 := R0 + R4
[7] forloop    1   -2       ; R1 += R3; if R1 <= R2 then begin PC := 6; R4 := R1 end
[8] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "(for index)"  ; 1
.local  "(for limit)"  ; 2
.local  "(for step)"  ; 3
.local  "i"  ; 4
.const  0  ; 0
.const  1  ; 1
.const  100  ; 2
.const  5  ; 3
[1] loadk      0   0        ; R0 := 0
[2] loadk      1   1        ; R1 := 1
[3] loadk      2   2        ; R2 := 100
[4] loadk      3   3        ; R3 := 5
[5] forprep    1   1        ; R1 -= R3; PC := 7
[6] add        0   0   4    ; R0 := R0 + R4
[7] forloop    1   -2       ; R1 += R3; if R1 <= R2 then begin PC := 6; R4 := R1 end
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
002F  01000000           [1] loadk      0   0        ; R0 := 0
0033  41400000           [2] loadk      1   1        ; R1 := 1
0037  81800000           [3] loadk      2   2        ; R2 := 100
003B  C1C00000           [4] loadk      3   3        ; R3 := 5
003F  60000080           [5] forprep    1   1        ; R1 -= R3; PC := 7
0043  0C000100           [6] add        0   0   4    ; R0 := R0 + R4
0047  5F40FF7F           [7] forloop    1   -2       ; R1 += R3; if R1 <= R2 then begin PC := 6; R4 := R1 end
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  0000000000000000   const [0]: (0)
005C  03                 const type 3
005D  000000000000F03F   const [1]: (1)
0065  03                 const type 3
0066  0000000000005940   const [2]: (100)
006E  03                 const type 3
006F  0000000000001440   const [3]: (5)
                         * functions:
0077  00000000           sizep (0)
                         * lines:
007B  08000000           sizelineinfo (8)
                         [pc] (line)
007F  01000000           [1] (1)
0083  01000000           [2] (1)
0087  01000000           [3] (1)
008B  01000000           [4] (1)
008F  01000000           [5] (1)
0093  01000000           [6] (1)
0097  01000000           [7] (1)
009B  01000000           [8] (1)
                         * locals:
009F  05000000           sizelocvars (5)
00A3  0200000000000000   string size (2)
00AB  6100               "a\0"
                         local [0]: a
00AD  01000000             startpc (1)
00B1  07000000             endpc   (7)
00B5  0C00000000000000   string size (12)
00BD  28666F7220696E64+  "(for ind"
00C5  65782900           "ex)\0"
                         local [1]: (for index)
00C9  04000000             startpc (4)
00CD  07000000             endpc   (7)
00D1  0C00000000000000   string size (12)
00D9  28666F72206C696D+  "(for lim"
00E1  69742900           "it)\0"
                         local [2]: (for limit)
00E5  04000000             startpc (4)
00E9  07000000             endpc   (7)
00ED  0B00000000000000   string size (11)
00F5  28666F7220737465+  "(for ste"
00FD  702900             "p)\0"
                         local [3]: (for step)
0100  04000000             startpc (4)
0104  07000000             endpc   (7)
0108  0200000000000000   string size (2)
0110  6900               "i\0"
                         local [4]: i
0112  05000000             startpc (5)
0116  06000000             endpc   (6)
                         * upvalues:
011A  00000000           sizeupvalues (0)
                         ** end of function 0 **

011E                     ** end of chunk **
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
002F  01000000           [1] loadk      0   0        ; R0 := 0
0033  41400000           [2] loadk      1   1        ; R1 := 1
0037  81800000           [3] loadk      2   2        ; R2 := 100
003B  C1C00000           [4] loadk      3   3        ; R3 := 5
003F  60000080           [5] forprep    1   1        ; R1 -= R3; PC := 7
0043  0C000100           [6] add        0   0   4    ; R0 := R0 + R4
0047  5F40FF7F           [7] forloop    1   -2       ; R1 += R3; if R1 <= R2 then begin PC := 6; R4 := R1 end
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  0000000000000000   const [0]: (0)
005C  03                 const type 3
005D  000000000000F03F   const [1]: (1)
0065  03                 const type 3
0066  0000000000005940   const [2]: (100)
006E  03                 const type 3
006F  0000000000001440   const [3]: (5)
                         * functions:
0077  00000000           sizep (0)
                         * lines:
007B  08000000           sizelineinfo (8)
                         [pc] (line)
007F  01000000           [1] (1)
0083  01000000           [2] (1)
0087  01000000           [3] (1)
008B  01000000           [4] (1)
008F  01000000           [5] (1)
0093  01000000           [6] (1)
0097  01000000           [7] (1)
009B  01000000           [8] (1)
                         * locals:
009F  05000000           sizelocvars (5)
00A3  0200000000000000   string size (2)
00AB  6100               "a\0"
                         local [0]: a
00AD  01000000             startpc (1)
00B1  07000000             endpc   (7)
00B5  0C00000000000000   string size (12)
00BD  28666F7220696E64+  "(for ind"
00C5  65782900           "ex)\0"
                         local [1]: (for index)
00C9  04000000             startpc (4)
00CD  07000000             endpc   (7)
00D1  0C00000000000000   string size (12)
00D9  28666F72206C696D+  "(for lim"
00E1  69742900           "it)\0"
                         local [2]: (for limit)
00E5  04000000             startpc (4)
00E9  07000000             endpc   (7)
00ED  0B00000000000000   string size (11)
00F5  28666F7220737465+  "(for ste"
00FD  702900             "p)\0"
                         local [3]: (for step)
0100  04000000             startpc (4)
0104  07000000             endpc   (7)
0108  0200000000000000   string size (2)
0110  6900               "i\0"
                         local [4]: i
0112  05000000             startpc (5)
0116  06000000             endpc   (6)
                         * upvalues:
011A  00000000           sizeupvalues (0)
                         ** end of function 0 **

011E                     ** end of chunk **
