------------------------------

function f(a, b, c)
end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f := R0
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 3 stacks
.function  0 3 0 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f := R0
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 3 stacks
.function  0 3 0 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] return     0   1        ; return 
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
002A  02                 maxstacksize (2)
                         * code:
002B  03000000           sizecode (3)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f := R0
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  01000000           sizek (1)
003F  04                 const type 4
0040  0200000000000000   string size (2)
0048  6600               "f\0"
                         const [0]: "f"
                         * functions:
004A  01000000           sizep (1)
                         
004E                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
004E  0000000000000000   string size (0)
                         source name: (none)
0056  02000000           line defined (2)
005A  03000000           last line defined (3)
005E  00                 nups (0)
005F  03                 numparams (3)
0060  00                 is_vararg (0)
0061  03                 maxstacksize (3)
                         * code:
0062  01000000           sizecode (1)
0066  1E008000           [1] return     0   1        ; return 
                         * constants:
006A  00000000           sizek (0)
                         * functions:
006E  00000000           sizep (0)
                         * lines:
0072  01000000           sizelineinfo (1)
                         [pc] (line)
0076  03000000           [1] (3)
                         * locals:
007A  03000000           sizelocvars (3)
007E  0200000000000000   string size (2)
0086  6100               "a\0"
                         local [0]: a
0088  00000000             startpc (0)
008C  00000000             endpc   (0)
0090  0200000000000000   string size (2)
0098  6200               "b\0"
                         local [1]: b
009A  00000000             startpc (0)
009E  00000000             endpc   (0)
00A2  0200000000000000   string size (2)
00AA  6300               "c\0"
                         local [2]: c
00AC  00000000             startpc (0)
00B0  00000000             endpc   (0)
                         * upvalues:
00B4  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00B8  03000000           sizelineinfo (3)
                         [pc] (line)
00BC  03000000           [1] (3)
00C0  02000000           [2] (2)
00C4  03000000           [3] (3)
                         * locals:
00C8  00000000           sizelocvars (0)
                         * upvalues:
00CC  00000000           sizeupvalues (0)
                         ** end of function 0 **

00D0                     ** end of chunk **
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
002B  03000000           sizecode (3)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f := R0
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  01000000           sizek (1)
003F  04                 const type 4
0040  0200000000000000   string size (2)
0048  6600               "f\0"
                         const [0]: "f"
                         * functions:
004A  01000000           sizep (1)
                         
004E                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
004E  0000000000000000   string size (0)
                         source name: (none)
0056  02000000           line defined (2)
005A  03000000           last line defined (3)
005E  00                 nups (0)
005F  03                 numparams (3)
0060  00                 is_vararg (0)
0061  03                 maxstacksize (3)
                         * code:
0062  01000000           sizecode (1)
0066  1E008000           [1] return     0   1        ; return 
                         * constants:
006A  00000000           sizek (0)
                         * functions:
006E  00000000           sizep (0)
                         * lines:
0072  01000000           sizelineinfo (1)
                         [pc] (line)
0076  03000000           [1] (3)
                         * locals:
007A  03000000           sizelocvars (3)
007E  0200000000000000   string size (2)
0086  6100               "a\0"
                         local [0]: a
0088  00000000             startpc (0)
008C  00000000             endpc   (0)
0090  0200000000000000   string size (2)
0098  6200               "b\0"
                         local [1]: b
009A  00000000             startpc (0)
009E  00000000             endpc   (0)
00A2  0200000000000000   string size (2)
00AA  6300               "c\0"
                         local [2]: c
00AC  00000000             startpc (0)
00B0  00000000             endpc   (0)
                         * upvalues:
00B4  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00B8  03000000           sizelineinfo (3)
                         [pc] (line)
00BC  03000000           [1] (3)
00C0  02000000           [2] (2)
00C4  03000000           [3] (3)
                         * locals:
00C8  00000000           sizelocvars (0)
                         * upvalues:
00CC  00000000           sizeupvalues (0)
                         ** end of function 0 **

00D0                     ** end of chunk **
