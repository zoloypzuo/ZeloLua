------------------------------
function obj:f(a) end
local a,obj; obj:f(a)
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "obj"  ; 1
.const  "obj"  ; 0
.const  "f"  ; 1
[1] getglobal  0   0        ; R0 := obj
[2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[3] settable   0   257 1    ; R0["f"] := R1
[4] loadnil    0   1        ; R0, R1,  := nil
[5] self       2   1   257  ; R3 := R1; R2 := R1["f"]
[6] move       4   0        ; R4 := R0
[7] call       2   3   1    ;  := R2(R3, R4)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 2 stacks
.function  0 2 0 2
.local  "self"  ; 0
.local  "a"  ; 1
[1] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "obj"  ; 1
.const  "obj"  ; 0
.const  "f"  ; 1
[1] getglobal  0   0        ; R0 := obj
[2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[3] settable   0   257 1    ; R0["f"] := R1
[4] loadnil    0   1        ; R0, R1,  := nil
[5] self       2   1   257  ; R3 := R1; R2 := R1["f"]
[6] move       4   0        ; R4 := R0
[7] call       2   3   1    ;  := R2(R3, R4)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 2 stacks
.function  0 2 0 2
.local  "self"  ; 0
.local  "a"  ; 1
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
002A  05                 maxstacksize (5)
                         * code:
002B  08000000           sizecode (8)
002F  05000000           [1] getglobal  0   0        ; R0 := obj
0033  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09408080           [3] settable   0   257 1    ; R0["f"] := R1
003B  03008000           [4] loadnil    0   1        ; R0, R1,  := nil
003F  8B40C000           [5] self       2   1   257  ; R3 := R1; R2 := R1["f"]
0043  00010000           [6] move       4   0        ; R4 := R0
0047  9C408001           [7] call       2   3   1    ;  := R2(R3, R4)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  02000000           sizek (2)
0053  04                 const type 4
0054  0400000000000000   string size (4)
005C  6F626A00           "obj\0"
                         const [0]: "obj"
0060  04                 const type 4
0061  0200000000000000   string size (2)
0069  6600               "f\0"
                         const [1]: "f"
                         * functions:
006B  01000000           sizep (1)
                         
006F                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
006F  0000000000000000   string size (0)
                         source name: (none)
0077  01000000           line defined (1)
007B  01000000           last line defined (1)
007F  00                 nups (0)
0080  02                 numparams (2)
0081  00                 is_vararg (0)
0082  02                 maxstacksize (2)
                         * code:
0083  01000000           sizecode (1)
0087  1E008000           [1] return     0   1        ; return 
                         * constants:
008B  00000000           sizek (0)
                         * functions:
008F  00000000           sizep (0)
                         * lines:
0093  01000000           sizelineinfo (1)
                         [pc] (line)
0097  01000000           [1] (1)
                         * locals:
009B  02000000           sizelocvars (2)
009F  0500000000000000   string size (5)
00A7  73656C6600         "self\0"
                         local [0]: self
00AC  00000000             startpc (0)
00B0  00000000             endpc   (0)
00B4  0200000000000000   string size (2)
00BC  6100               "a\0"
                         local [1]: a
00BE  00000000             startpc (0)
00C2  00000000             endpc   (0)
                         * upvalues:
00C6  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00CA  08000000           sizelineinfo (8)
                         [pc] (line)
00CE  01000000           [1] (1)
00D2  01000000           [2] (1)
00D6  01000000           [3] (1)
00DA  02000000           [4] (2)
00DE  02000000           [5] (2)
00E2  02000000           [6] (2)
00E6  02000000           [7] (2)
00EA  02000000           [8] (2)
                         * locals:
00EE  02000000           sizelocvars (2)
00F2  0200000000000000   string size (2)
00FA  6100               "a\0"
                         local [0]: a
00FC  04000000             startpc (4)
0100  07000000             endpc   (7)
0104  0400000000000000   string size (4)
010C  6F626A00           "obj\0"
                         local [1]: obj
0110  04000000             startpc (4)
0114  07000000             endpc   (7)
                         * upvalues:
0118  00000000           sizeupvalues (0)
                         ** end of function 0 **

011C                     ** end of chunk **
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
002B  08000000           sizecode (8)
002F  05000000           [1] getglobal  0   0        ; R0 := obj
0033  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09408080           [3] settable   0   257 1    ; R0["f"] := R1
003B  03008000           [4] loadnil    0   1        ; R0, R1,  := nil
003F  8B40C000           [5] self       2   1   257  ; R3 := R1; R2 := R1["f"]
0043  00010000           [6] move       4   0        ; R4 := R0
0047  9C408001           [7] call       2   3   1    ;  := R2(R3, R4)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  02000000           sizek (2)
0053  04                 const type 4
0054  0400000000000000   string size (4)
005C  6F626A00           "obj\0"
                         const [0]: "obj"
0060  04                 const type 4
0061  0200000000000000   string size (2)
0069  6600               "f\0"
                         const [1]: "f"
                         * functions:
006B  01000000           sizep (1)
                         
006F                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
006F  0000000000000000   string size (0)
                         source name: (none)
0077  01000000           line defined (1)
007B  01000000           last line defined (1)
007F  00                 nups (0)
0080  02                 numparams (2)
0081  00                 is_vararg (0)
0082  02                 maxstacksize (2)
                         * code:
0083  01000000           sizecode (1)
0087  1E008000           [1] return     0   1        ; return 
                         * constants:
008B  00000000           sizek (0)
                         * functions:
008F  00000000           sizep (0)
                         * lines:
0093  01000000           sizelineinfo (1)
                         [pc] (line)
0097  01000000           [1] (1)
                         * locals:
009B  02000000           sizelocvars (2)
009F  0500000000000000   string size (5)
00A7  73656C6600         "self\0"
                         local [0]: self
00AC  00000000             startpc (0)
00B0  00000000             endpc   (0)
00B4  0200000000000000   string size (2)
00BC  6100               "a\0"
                         local [1]: a
00BE  00000000             startpc (0)
00C2  00000000             endpc   (0)
                         * upvalues:
00C6  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00CA  08000000           sizelineinfo (8)
                         [pc] (line)
00CE  01000000           [1] (1)
00D2  01000000           [2] (1)
00D6  01000000           [3] (1)
00DA  02000000           [4] (2)
00DE  02000000           [5] (2)
00E2  02000000           [6] (2)
00E6  02000000           [7] (2)
00EA  02000000           [8] (2)
                         * locals:
00EE  02000000           sizelocvars (2)
00F2  0200000000000000   string size (2)
00FA  6100               "a\0"
                         local [0]: a
00FC  04000000             startpc (4)
0100  07000000             endpc   (7)
0104  0400000000000000   string size (4)
010C  6F626A00           "obj\0"
                         local [1]: obj
0110  04000000             startpc (4)
0114  07000000             endpc   (7)
                         * upvalues:
0118  00000000           sizeupvalues (0)
                         ** end of function 0 **

011C                     ** end of chunk **
