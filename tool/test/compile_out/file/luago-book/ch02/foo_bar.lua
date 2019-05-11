------------------------------
function foo()
  function bar()
  end
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "foo"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; foo := R0
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "bar"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; bar := R0
[3] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "foo"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; foo := R0
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "bar"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; bar := R0
[3] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0_0

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
0033  07000000           [2] setglobal  0   0        ; foo := R0
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  01000000           sizek (1)
003F  04                 const type 4
0040  0400000000000000   string size (4)
0048  666F6F00           "foo\0"
                         const [0]: "foo"
                         * functions:
004C  01000000           sizep (1)
                         
0050                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0050  0000000000000000   string size (0)
                         source name: (none)
0058  01000000           line defined (1)
005C  04000000           last line defined (4)
0060  00                 nups (0)
0061  00                 numparams (0)
0062  00                 is_vararg (0)
0063  02                 maxstacksize (2)
                         * code:
0064  03000000           sizecode (3)
0068  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
006C  07000000           [2] setglobal  0   0        ; bar := R0
0070  1E008000           [3] return     0   1        ; return 
                         * constants:
0074  01000000           sizek (1)
0078  04                 const type 4
0079  0400000000000000   string size (4)
0081  62617200           "bar\0"
                         const [0]: "bar"
                         * functions:
0085  01000000           sizep (1)
                         
0089                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0089  0000000000000000   string size (0)
                         source name: (none)
0091  02000000           line defined (2)
0095  03000000           last line defined (3)
0099  00                 nups (0)
009A  00                 numparams (0)
009B  00                 is_vararg (0)
009C  02                 maxstacksize (2)
                         * code:
009D  01000000           sizecode (1)
00A1  1E008000           [1] return     0   1        ; return 
                         * constants:
00A5  00000000           sizek (0)
                         * functions:
00A9  00000000           sizep (0)
                         * lines:
00AD  01000000           sizelineinfo (1)
                         [pc] (line)
00B1  03000000           [1] (3)
                         * locals:
00B5  00000000           sizelocvars (0)
                         * upvalues:
00B9  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
00BD  03000000           sizelineinfo (3)
                         [pc] (line)
00C1  03000000           [1] (3)
00C5  02000000           [2] (2)
00C9  04000000           [3] (4)
                         * locals:
00CD  00000000           sizelocvars (0)
                         * upvalues:
00D1  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00D5  03000000           sizelineinfo (3)
                         [pc] (line)
00D9  04000000           [1] (4)
00DD  01000000           [2] (1)
00E1  04000000           [3] (4)
                         * locals:
00E5  00000000           sizelocvars (0)
                         * upvalues:
00E9  00000000           sizeupvalues (0)
                         ** end of function 0 **

00ED                     ** end of chunk **
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
0033  07000000           [2] setglobal  0   0        ; foo := R0
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  01000000           sizek (1)
003F  04                 const type 4
0040  0400000000000000   string size (4)
0048  666F6F00           "foo\0"
                         const [0]: "foo"
                         * functions:
004C  01000000           sizep (1)
                         
0050                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0050  0000000000000000   string size (0)
                         source name: (none)
0058  01000000           line defined (1)
005C  04000000           last line defined (4)
0060  00                 nups (0)
0061  00                 numparams (0)
0062  00                 is_vararg (0)
0063  02                 maxstacksize (2)
                         * code:
0064  03000000           sizecode (3)
0068  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
006C  07000000           [2] setglobal  0   0        ; bar := R0
0070  1E008000           [3] return     0   1        ; return 
                         * constants:
0074  01000000           sizek (1)
0078  04                 const type 4
0079  0400000000000000   string size (4)
0081  62617200           "bar\0"
                         const [0]: "bar"
                         * functions:
0085  01000000           sizep (1)
                         
0089                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0089  0000000000000000   string size (0)
                         source name: (none)
0091  02000000           line defined (2)
0095  03000000           last line defined (3)
0099  00                 nups (0)
009A  00                 numparams (0)
009B  00                 is_vararg (0)
009C  02                 maxstacksize (2)
                         * code:
009D  01000000           sizecode (1)
00A1  1E008000           [1] return     0   1        ; return 
                         * constants:
00A5  00000000           sizek (0)
                         * functions:
00A9  00000000           sizep (0)
                         * lines:
00AD  01000000           sizelineinfo (1)
                         [pc] (line)
00B1  03000000           [1] (3)
                         * locals:
00B5  00000000           sizelocvars (0)
                         * upvalues:
00B9  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
00BD  03000000           sizelineinfo (3)
                         [pc] (line)
00C1  03000000           [1] (3)
00C5  02000000           [2] (2)
00C9  04000000           [3] (4)
                         * locals:
00CD  00000000           sizelocvars (0)
                         * upvalues:
00D1  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00D5  03000000           sizelineinfo (3)
                         [pc] (line)
00D9  04000000           [1] (4)
00DD  01000000           [2] (1)
00E1  04000000           [3] (4)
                         * locals:
00E5  00000000           sizelocvars (0)
                         * upvalues:
00E9  00000000           sizeupvalues (0)
                         ** end of function 0 **

00ED                     ** end of chunk **
