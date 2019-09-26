------------------------------
local a,b; return 1,a,b
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  1  ; 0
[1] loadk      2   0        ; R2 := 1
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] return     2   4        ; return R2 to R4
[5] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  1  ; 0
[1] loadk      2   0        ; R2 := 1
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] return     2   4        ; return R2 to R4
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
002A  05                 maxstacksize (5)
                         * code:
002B  05000000           sizecode (5)
002F  81000000           [1] loadk      2   0        ; R2 := 1
0033  C0000000           [2] move       3   0        ; R3 := R0
0037  00018000           [3] move       4   1        ; R4 := R1
003B  9E000002           [4] return     2   4        ; return R2 to R4
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  01000000           sizek (1)
0047  03                 const type 3
0048  000000000000F03F   const [0]: (1)
                         * functions:
0050  00000000           sizep (0)
                         * lines:
0054  05000000           sizelineinfo (5)
                         [pc] (line)
0058  01000000           [1] (1)
005C  01000000           [2] (1)
0060  01000000           [3] (1)
0064  01000000           [4] (1)
0068  01000000           [5] (1)
                         * locals:
006C  02000000           sizelocvars (2)
0070  0200000000000000   string size (2)
0078  6100               "a\0"
                         local [0]: a
007A  00000000             startpc (0)
007E  04000000             endpc   (4)
0082  0200000000000000   string size (2)
008A  6200               "b\0"
                         local [1]: b
008C  00000000             startpc (0)
0090  04000000             endpc   (4)
                         * upvalues:
0094  00000000           sizeupvalues (0)
                         ** end of function 0 **

0098                     ** end of chunk **
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
002B  05000000           sizecode (5)
002F  81000000           [1] loadk      2   0        ; R2 := 1
0033  C0000000           [2] move       3   0        ; R3 := R0
0037  00018000           [3] move       4   1        ; R4 := R1
003B  9E000002           [4] return     2   4        ; return R2 to R4
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  01000000           sizek (1)
0047  03                 const type 3
0048  000000000000F03F   const [0]: (1)
                         * functions:
0050  00000000           sizep (0)
                         * lines:
0054  05000000           sizelineinfo (5)
                         [pc] (line)
0058  01000000           [1] (1)
005C  01000000           [2] (1)
0060  01000000           [3] (1)
0064  01000000           [4] (1)
0068  01000000           [5] (1)
                         * locals:
006C  02000000           sizelocvars (2)
0070  0200000000000000   string size (2)
0078  6100               "a\0"
                         local [0]: a
007A  00000000             startpc (0)
007E  04000000             endpc   (4)
0082  0200000000000000   string size (2)
008A  6200               "b\0"
                         local [1]: b
008C  00000000             startpc (0)
0090  04000000             endpc   (4)
                         * upvalues:
0094  00000000           sizeupvalues (0)
                         ** end of function 0 **

0098                     ** end of chunk **
