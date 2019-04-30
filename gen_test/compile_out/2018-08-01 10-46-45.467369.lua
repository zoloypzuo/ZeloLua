------------------------------
local a=a.b.c.d
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "a"  ; 0
.const  "a"  ; 0
.const  "b"  ; 1
.const  "c"  ; 2
.const  "d"  ; 3
[1] getglobal  0   0        ; R0 := a
[2] gettable   0   0   257  ; R0 := R0["b"]
[3] gettable   0   0   258  ; R0 := R0["c"]
[4] gettable   0   0   259  ; R0 := R0["d"]
[5] return     0   1        ; return 
; end of function 0


------------------------------
Pos   Hex Data           Description or Code
------------------------------------------------------------------------
0000                     ** source chunk: luac.out
                         ** global header start **
0000  1B4C7561           header signature: "\27Lua"
0004  51                 version (major:minor hex digits)
0005  00                 format (0=official)
0006  01                 endianness (1=little endian)
0007  04                 size of int (bytes)
0008  04                 size of size_t (bytes)
0009  04                 size of Instruction (bytes)
000A  08                 size of number (bytes)
000B  00                 integral (1=integral)
                         * number type: double
                         * x86 standard (32-bit, little endian, doubles)
                         ** global header end **
                         
000C                     ** function [0] definition (level 1) 0
                         ** start of function 0 **
000C  0B000000           string size (11)
0010  406C6561726E2E6C+  "@learn.l"
0018  756100             "ua\0"
                         source name: @learn.lua
001B  00000000           line defined (0)
001F  00000000           last line defined (0)
0023  00                 nups (0)
0024  00                 numparams (0)
0025  02                 is_vararg (2)
0026  02                 maxstacksize (2)
                         * code:
0027  05000000           sizecode (5)
002B  05000000           [1] getglobal  0   0        ; R0 := a
002F  06404000           [2] gettable   0   0   257  ; R0 := R0["b"]
0033  06804000           [3] gettable   0   0   258  ; R0 := R0["c"]
0037  06C04000           [4] gettable   0   0   259  ; R0 := R0["d"]
003B  1E008000           [5] return     0   1        ; return 
                         * constants:
003F  04000000           sizek (4)
0043  04                 const type 4
0044  02000000           string size (2)
0048  6100               "a\0"
                         const [0]: "a"
004A  04                 const type 4
004B  02000000           string size (2)
004F  6200               "b\0"
                         const [1]: "b"
0051  04                 const type 4
0052  02000000           string size (2)
0056  6300               "c\0"
                         const [2]: "c"
0058  04                 const type 4
0059  02000000           string size (2)
005D  6400               "d\0"
                         const [3]: "d"
                         * functions:
005F  00000000           sizep (0)
                         * lines:
0063  05000000           sizelineinfo (5)
                         [pc] (line)
0067  01000000           [1] (1)
006B  01000000           [2] (1)
006F  01000000           [3] (1)
0073  01000000           [4] (1)
0077  01000000           [5] (1)
                         * locals:
007B  01000000           sizelocvars (1)
007F  02000000           string size (2)
0083  6100               "a\0"
                         local [0]: a
0085  04000000             startpc (4)
0089  04000000             endpc   (4)
                         * upvalues:
008D  00000000           sizeupvalues (0)
                         ** end of function 0 **

0091                     ** end of chunk **
