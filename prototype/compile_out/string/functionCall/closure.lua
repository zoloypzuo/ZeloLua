------------------------------
local a,b,c
local function f() end
local g = function() end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "f"  ; 3
.local  "g"  ; 4
[1] closure    3   0        ; R3 := closure(function[0]) 0 upvalues
[2] closure    4   1        ; R4 := closure(function[1]) 0 upvalues
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "f"  ; 3
.local  "g"  ; 4
[1] closure    3   0        ; R3 := closure(function[0]) 0 upvalues
[2] closure    4   1        ; R4 := closure(function[1]) 0 upvalues
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_1

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
002B  03000000           sizecode (3)
002F  E4000000           [1] closure    3   0        ; R3 := closure(function[0]) 0 upvalues
0033  24410000           [2] closure    4   1        ; R4 := closure(function[1]) 0 upvalues
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  00000000           sizek (0)
                         * functions:
003F  02000000           sizep (2)
                         
0043                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0043  0000000000000000   string size (0)
                         source name: (none)
004B  02000000           line defined (2)
004F  02000000           last line defined (2)
0053  00                 nups (0)
0054  00                 numparams (0)
0055  00                 is_vararg (0)
0056  02                 maxstacksize (2)
                         * code:
0057  01000000           sizecode (1)
005B  1E008000           [1] return     0   1        ; return 
                         * constants:
005F  00000000           sizek (0)
                         * functions:
0063  00000000           sizep (0)
                         * lines:
0067  01000000           sizelineinfo (1)
                         [pc] (line)
006B  02000000           [1] (2)
                         * locals:
006F  00000000           sizelocvars (0)
                         * upvalues:
0073  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0077                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0077  0000000000000000   string size (0)
                         source name: (none)
007F  03000000           line defined (3)
0083  03000000           last line defined (3)
0087  00                 nups (0)
0088  00                 numparams (0)
0089  00                 is_vararg (0)
008A  02                 maxstacksize (2)
                         * code:
008B  01000000           sizecode (1)
008F  1E008000           [1] return     0   1        ; return 
                         * constants:
0093  00000000           sizek (0)
                         * functions:
0097  00000000           sizep (0)
                         * lines:
009B  01000000           sizelineinfo (1)
                         [pc] (line)
009F  03000000           [1] (3)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
00AB  03000000           sizelineinfo (3)
                         [pc] (line)
00AF  02000000           [1] (2)
00B3  03000000           [2] (3)
00B7  03000000           [3] (3)
                         * locals:
00BB  05000000           sizelocvars (5)
00BF  0200000000000000   string size (2)
00C7  6100               "a\0"
                         local [0]: a
00C9  00000000             startpc (0)
00CD  02000000             endpc   (2)
00D1  0200000000000000   string size (2)
00D9  6200               "b\0"
                         local [1]: b
00DB  00000000             startpc (0)
00DF  02000000             endpc   (2)
00E3  0200000000000000   string size (2)
00EB  6300               "c\0"
                         local [2]: c
00ED  00000000             startpc (0)
00F1  02000000             endpc   (2)
00F5  0200000000000000   string size (2)
00FD  6600               "f\0"
                         local [3]: f
00FF  01000000             startpc (1)
0103  02000000             endpc   (2)
0107  0200000000000000   string size (2)
010F  6700               "g\0"
                         local [4]: g
0111  02000000             startpc (2)
0115  02000000             endpc   (2)
                         * upvalues:
0119  00000000           sizeupvalues (0)
                         ** end of function 0 **

011D                     ** end of chunk **
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
002B  03000000           sizecode (3)
002F  E4000000           [1] closure    3   0        ; R3 := closure(function[0]) 0 upvalues
0033  24410000           [2] closure    4   1        ; R4 := closure(function[1]) 0 upvalues
0037  1E008000           [3] return     0   1        ; return 
                         * constants:
003B  00000000           sizek (0)
                         * functions:
003F  02000000           sizep (2)
                         
0043                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0043  0000000000000000   string size (0)
                         source name: (none)
004B  02000000           line defined (2)
004F  02000000           last line defined (2)
0053  00                 nups (0)
0054  00                 numparams (0)
0055  00                 is_vararg (0)
0056  02                 maxstacksize (2)
                         * code:
0057  01000000           sizecode (1)
005B  1E008000           [1] return     0   1        ; return 
                         * constants:
005F  00000000           sizek (0)
                         * functions:
0063  00000000           sizep (0)
                         * lines:
0067  01000000           sizelineinfo (1)
                         [pc] (line)
006B  02000000           [1] (2)
                         * locals:
006F  00000000           sizelocvars (0)
                         * upvalues:
0073  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0077                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0077  0000000000000000   string size (0)
                         source name: (none)
007F  03000000           line defined (3)
0083  03000000           last line defined (3)
0087  00                 nups (0)
0088  00                 numparams (0)
0089  00                 is_vararg (0)
008A  02                 maxstacksize (2)
                         * code:
008B  01000000           sizecode (1)
008F  1E008000           [1] return     0   1        ; return 
                         * constants:
0093  00000000           sizek (0)
                         * functions:
0097  00000000           sizep (0)
                         * lines:
009B  01000000           sizelineinfo (1)
                         [pc] (line)
009F  03000000           [1] (3)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
00AB  03000000           sizelineinfo (3)
                         [pc] (line)
00AF  02000000           [1] (2)
00B3  03000000           [2] (3)
00B7  03000000           [3] (3)
                         * locals:
00BB  05000000           sizelocvars (5)
00BF  0200000000000000   string size (2)
00C7  6100               "a\0"
                         local [0]: a
00C9  00000000             startpc (0)
00CD  02000000             endpc   (2)
00D1  0200000000000000   string size (2)
00D9  6200               "b\0"
                         local [1]: b
00DB  00000000             startpc (0)
00DF  02000000             endpc   (2)
00E3  0200000000000000   string size (2)
00EB  6300               "c\0"
                         local [2]: c
00ED  00000000             startpc (0)
00F1  02000000             endpc   (2)
00F5  0200000000000000   string size (2)
00FD  6600               "f\0"
                         local [3]: f
00FF  01000000             startpc (1)
0103  02000000             endpc   (2)
0107  0200000000000000   string size (2)
010F  6700               "g\0"
                         local [4]: g
0111  02000000             startpc (2)
0115  02000000             endpc   (2)
                         * upvalues:
0119  00000000           sizeupvalues (0)
                         ** end of function 0 **

011D                     ** end of chunk **
