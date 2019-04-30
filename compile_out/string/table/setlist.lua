------------------------------
local t = {1,2,3,4}
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "t"  ; 0
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  4  ; 3
[1] newtable   0   4   0    ; R0 := {} , array=4, hash=0
[2] loadk      1   0        ; R1 := 1
[3] loadk      2   1        ; R2 := 2
[4] loadk      3   2        ; R3 := 3
[5] loadk      4   3        ; R4 := 4
[6] setlist    0   4   1    ; R0[1 to 4] := R1 to R4
[7] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "t"  ; 0
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  4  ; 3
[1] newtable   0   4   0    ; R0 := {} , array=4, hash=0
[2] loadk      1   0        ; R1 := 1
[3] loadk      2   1        ; R2 := 2
[4] loadk      3   2        ; R3 := 3
[5] loadk      4   3        ; R4 := 4
[6] setlist    0   4   1    ; R0[1 to 4] := R1 to R4
[7] return     0   1        ; return 
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
002B  07000000           sizecode (7)
002F  0A000002           [1] newtable   0   4   0    ; R0 := {} , array=4, hash=0
0033  41000000           [2] loadk      1   0        ; R1 := 1
0037  81400000           [3] loadk      2   1        ; R2 := 2
003B  C1800000           [4] loadk      3   2        ; R3 := 3
003F  01C10000           [5] loadk      4   3        ; R4 := 4
0043  22400002           [6] setlist    0   4   1    ; R0[1 to 4] := R1 to R4
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  04000000           sizek (4)
004F  03                 const type 3
0050  000000000000F03F   const [0]: (1)
0058  03                 const type 3
0059  0000000000000040   const [1]: (2)
0061  03                 const type 3
0062  0000000000000840   const [2]: (3)
006A  03                 const type 3
006B  0000000000001040   const [3]: (4)
                         * functions:
0073  00000000           sizep (0)
                         * lines:
0077  07000000           sizelineinfo (7)
                         [pc] (line)
007B  01000000           [1] (1)
007F  01000000           [2] (1)
0083  01000000           [3] (1)
0087  01000000           [4] (1)
008B  01000000           [5] (1)
008F  01000000           [6] (1)
0093  01000000           [7] (1)
                         * locals:
0097  01000000           sizelocvars (1)
009B  0200000000000000   string size (2)
00A3  7400               "t\0"
                         local [0]: t
00A5  06000000             startpc (6)
00A9  06000000             endpc   (6)
                         * upvalues:
00AD  00000000           sizeupvalues (0)
                         ** end of function 0 **

00B1                     ** end of chunk **
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
002B  07000000           sizecode (7)
002F  0A000002           [1] newtable   0   4   0    ; R0 := {} , array=4, hash=0
0033  41000000           [2] loadk      1   0        ; R1 := 1
0037  81400000           [3] loadk      2   1        ; R2 := 2
003B  C1800000           [4] loadk      3   2        ; R3 := 3
003F  01C10000           [5] loadk      4   3        ; R4 := 4
0043  22400002           [6] setlist    0   4   1    ; R0[1 to 4] := R1 to R4
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  04000000           sizek (4)
004F  03                 const type 3
0050  000000000000F03F   const [0]: (1)
0058  03                 const type 3
0059  0000000000000040   const [1]: (2)
0061  03                 const type 3
0062  0000000000000840   const [2]: (3)
006A  03                 const type 3
006B  0000000000001040   const [3]: (4)
                         * functions:
0073  00000000           sizep (0)
                         * lines:
0077  07000000           sizelineinfo (7)
                         [pc] (line)
007B  01000000           [1] (1)
007F  01000000           [2] (1)
0083  01000000           [3] (1)
0087  01000000           [4] (1)
008B  01000000           [5] (1)
008F  01000000           [6] (1)
0093  01000000           [7] (1)
                         * locals:
0097  01000000           sizelocvars (1)
009B  0200000000000000   string size (2)
00A3  7400               "t\0"
                         local [0]: t
00A5  06000000             startpc (6)
00A9  06000000             endpc   (6)
                         * upvalues:
00AD  00000000           sizeupvalues (0)
                         ** end of function 0 **

00B1                     ** end of chunk **
