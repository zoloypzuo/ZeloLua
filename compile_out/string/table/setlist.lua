------------------------------
local p = {1,2}
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "p"  ; 0
.const  1  ; 0
.const  2  ; 1
[1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[2] loadk      1   0        ; R1 := 1
[3] loadk      2   1        ; R2 := 2
[4] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
[5] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "p"  ; 0
.const  1  ; 0
.const  2  ; 1
[1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[2] loadk      1   0        ; R1 := 1
[3] loadk      2   1        ; R2 := 2
[4] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
[5] return     0   1        ; return 
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
002B  05000000           sizecode (5)
002F  0A000001           [1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
0033  41000000           [2] loadk      1   0        ; R1 := 1
0037  81400000           [3] loadk      2   1        ; R2 := 2
003B  22400001           [4] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  02000000           sizek (2)
0047  03                 const type 3
0048  000000000000F03F   const [0]: (1)
0050  03                 const type 3
0051  0000000000000040   const [1]: (2)
                         * functions:
0059  00000000           sizep (0)
                         * lines:
005D  05000000           sizelineinfo (5)
                         [pc] (line)
0061  01000000           [1] (1)
0065  01000000           [2] (1)
0069  01000000           [3] (1)
006D  01000000           [4] (1)
0071  01000000           [5] (1)
                         * locals:
0075  01000000           sizelocvars (1)
0079  0200000000000000   string size (2)
0081  7000               "p\0"
                         local [0]: p
0083  04000000             startpc (4)
0087  04000000             endpc   (4)
                         * upvalues:
008B  00000000           sizeupvalues (0)
                         ** end of function 0 **

008F                     ** end of chunk **
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
002B  05000000           sizecode (5)
002F  0A000001           [1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
0033  41000000           [2] loadk      1   0        ; R1 := 1
0037  81400000           [3] loadk      2   1        ; R2 := 2
003B  22400001           [4] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  02000000           sizek (2)
0047  03                 const type 3
0048  000000000000F03F   const [0]: (1)
0050  03                 const type 3
0051  0000000000000040   const [1]: (2)
                         * functions:
0059  00000000           sizep (0)
                         * lines:
005D  05000000           sizelineinfo (5)
                         [pc] (line)
0061  01000000           [1] (1)
0065  01000000           [2] (1)
0069  01000000           [3] (1)
006D  01000000           [4] (1)
0071  01000000           [5] (1)
                         * locals:
0075  01000000           sizelocvars (1)
0079  0200000000000000   string size (2)
0081  7000               "p\0"
                         local [0]: p
0083  04000000             startpc (4)
0087  04000000             endpc   (4)
                         * upvalues:
008B  00000000           sizeupvalues (0)
                         ** end of function 0 **

008F                     ** end of chunk **
