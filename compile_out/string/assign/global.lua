------------------------------

a = 10
local b = a
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "b"  ; 0
.const  "a"  ; 0
.const  10  ; 1
[1] loadk      0   1        ; R0 := 10
[2] setglobal  0   0        ; a := R0
[3] getglobal  0   0        ; R0 := a
[4] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "b"  ; 0
.const  "a"  ; 0
.const  10  ; 1
[1] loadk      0   1        ; R0 := 10
[2] setglobal  0   0        ; a := R0
[3] getglobal  0   0        ; R0 := a
[4] return     0   1        ; return 
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
002B  04000000           sizecode (4)
002F  01400000           [1] loadk      0   1        ; R0 := 10
0033  07000000           [2] setglobal  0   0        ; a := R0
0037  05000000           [3] getglobal  0   0        ; R0 := a
003B  1E008000           [4] return     0   1        ; return 
                         * constants:
003F  02000000           sizek (2)
0043  04                 const type 4
0044  0200000000000000   string size (2)
004C  6100               "a\0"
                         const [0]: "a"
004E  03                 const type 3
004F  0000000000002440   const [1]: (10)
                         * functions:
0057  00000000           sizep (0)
                         * lines:
005B  04000000           sizelineinfo (4)
                         [pc] (line)
005F  02000000           [1] (2)
0063  02000000           [2] (2)
0067  03000000           [3] (3)
006B  03000000           [4] (3)
                         * locals:
006F  01000000           sizelocvars (1)
0073  0200000000000000   string size (2)
007B  6200               "b\0"
                         local [0]: b
007D  03000000             startpc (3)
0081  03000000             endpc   (3)
                         * upvalues:
0085  00000000           sizeupvalues (0)
                         ** end of function 0 **

0089                     ** end of chunk **
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
002B  04000000           sizecode (4)
002F  01400000           [1] loadk      0   1        ; R0 := 10
0033  07000000           [2] setglobal  0   0        ; a := R0
0037  05000000           [3] getglobal  0   0        ; R0 := a
003B  1E008000           [4] return     0   1        ; return 
                         * constants:
003F  02000000           sizek (2)
0043  04                 const type 4
0044  0200000000000000   string size (2)
004C  6100               "a\0"
                         const [0]: "a"
004E  03                 const type 3
004F  0000000000002440   const [1]: (10)
                         * functions:
0057  00000000           sizep (0)
                         * lines:
005B  04000000           sizelineinfo (4)
                         [pc] (line)
005F  02000000           [1] (2)
0063  02000000           [2] (2)
0067  03000000           [3] (3)
006B  03000000           [4] (3)
                         * locals:
006F  01000000           sizelocvars (1)
0073  0200000000000000   string size (2)
007B  6200               "b\0"
                         local [0]: b
007D  03000000             startpc (3)
0081  03000000             endpc   (3)
                         * upvalues:
0085  00000000           sizeupvalues (0)
                         ** end of function 0 **

0089                     ** end of chunk **
