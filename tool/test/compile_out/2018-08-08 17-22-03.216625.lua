------------------------------
a=f()
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "a"  ; 0
.const  "f"  ; 1
[1] getglobal  0   1        ; R0 := f
[2] call       0   1   2    ; R0 := R0()
[3] setglobal  0   0        ; a := R0
[4] return     0   1        ; return 
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
0027  04000000           sizecode (4)
002B  05400000           [1] getglobal  0   1        ; R0 := f
002F  1C808000           [2] call       0   1   2    ; R0 := R0()
0033  07000000           [3] setglobal  0   0        ; a := R0
0037  1E008000           [4] return     0   1        ; return 
                         * constants:
003B  02000000           sizek (2)
003F  04                 const type 4
0040  02000000           string size (2)
0044  6100               "a\0"
                         const [0]: "a"
0046  04                 const type 4
0047  02000000           string size (2)
004B  6600               "f\0"
                         const [1]: "f"
                         * functions:
004D  00000000           sizep (0)
                         * lines:
0051  04000000           sizelineinfo (4)
                         [pc] (line)
0055  01000000           [1] (1)
0059  01000000           [2] (1)
005D  01000000           [3] (1)
0061  01000000           [4] (1)
                         * locals:
0065  00000000           sizelocvars (0)
                         * upvalues:
0069  00000000           sizeupvalues (0)
                         ** end of function 0 **

006D                     ** end of chunk **
