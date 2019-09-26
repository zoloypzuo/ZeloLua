------------------------------
local p = {}
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "p"  ; 0
[1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[2] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "p"  ; 0
[1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[2] return     0   1        ; return 
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
002A  02                 maxstacksize (2)
                         * code:
002B  02000000           sizecode (2)
002F  0A000000           [1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  1E008000           [2] return     0   1        ; return 
                         * constants:
0037  00000000           sizek (0)
                         * functions:
003B  00000000           sizep (0)
                         * lines:
003F  02000000           sizelineinfo (2)
                         [pc] (line)
0043  01000000           [1] (1)
0047  01000000           [2] (1)
                         * locals:
004B  01000000           sizelocvars (1)
004F  0200000000000000   string size (2)
0057  7000               "p\0"
                         local [0]: p
0059  01000000             startpc (1)
005D  01000000             endpc   (1)
                         * upvalues:
0061  00000000           sizeupvalues (0)
                         ** end of function 0 **

0065                     ** end of chunk **
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
002A  02                 maxstacksize (2)
                         * code:
002B  02000000           sizecode (2)
002F  0A000000           [1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  1E008000           [2] return     0   1        ; return 
                         * constants:
0037  00000000           sizek (0)
                         * functions:
003B  00000000           sizep (0)
                         * lines:
003F  02000000           sizelineinfo (2)
                         [pc] (line)
0043  01000000           [1] (1)
0047  01000000           [2] (1)
                         * locals:
004B  01000000           sizelocvars (1)
004F  0200000000000000   string size (2)
0057  7000               "p\0"
                         local [0]: p
0059  01000000             startpc (1)
005D  01000000             endpc   (1)
                         * upvalues:
0061  00000000           sizeupvalues (0)
                         ** end of function 0 **

0065                     ** end of chunk **
