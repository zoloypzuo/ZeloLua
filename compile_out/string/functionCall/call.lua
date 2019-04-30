------------------------------
local function f() end
local a,b,c = f(1,2,3,4)
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "f"  ; 0
.local  "a"  ; 1
.local  "b"  ; 2
.local  "c"  ; 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  4  ; 3
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] move       1   0        ; R1 := R0
[3] loadk      2   0        ; R2 := 1
[4] loadk      3   1        ; R3 := 2
[5] loadk      4   2        ; R4 := 3
[6] loadk      5   3        ; R5 := 4
[7] call       1   5   4    ; R1 to R3 := R1(R2 to R5)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "f"  ; 0
.local  "a"  ; 1
.local  "b"  ; 2
.local  "c"  ; 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  4  ; 3
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] move       1   0        ; R1 := R0
[3] loadk      2   0        ; R2 := 1
[4] loadk      3   1        ; R3 := 2
[5] loadk      4   2        ; R4 := 3
[6] loadk      5   3        ; R5 := 4
[7] call       1   5   4    ; R1 to R3 := R1(R2 to R5)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
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
002A  06                 maxstacksize (6)
                         * code:
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  40000000           [2] move       1   0        ; R1 := R0
0037  81000000           [3] loadk      2   0        ; R2 := 1
003B  C1400000           [4] loadk      3   1        ; R3 := 2
003F  01810000           [5] loadk      4   2        ; R4 := 3
0043  41C10000           [6] loadk      5   3        ; R5 := 4
0047  5C008102           [7] call       1   5   4    ; R1 to R3 := R1(R2 to R5)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  000000000000F03F   const [0]: (1)
005C  03                 const type 3
005D  0000000000000040   const [1]: (2)
0065  03                 const type 3
0066  0000000000000840   const [2]: (3)
006E  03                 const type 3
006F  0000000000001040   const [3]: (4)
                         * functions:
0077  01000000           sizep (1)
                         
007B                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
007B  0000000000000000   string size (0)
                         source name: (none)
0083  01000000           line defined (1)
0087  01000000           last line defined (1)
008B  00                 nups (0)
008C  00                 numparams (0)
008D  00                 is_vararg (0)
008E  02                 maxstacksize (2)
                         * code:
008F  01000000           sizecode (1)
0093  1E008000           [1] return     0   1        ; return 
                         * constants:
0097  00000000           sizek (0)
                         * functions:
009B  00000000           sizep (0)
                         * lines:
009F  01000000           sizelineinfo (1)
                         [pc] (line)
00A3  01000000           [1] (1)
                         * locals:
00A7  00000000           sizelocvars (0)
                         * upvalues:
00AB  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00AF  08000000           sizelineinfo (8)
                         [pc] (line)
00B3  01000000           [1] (1)
00B7  02000000           [2] (2)
00BB  02000000           [3] (2)
00BF  02000000           [4] (2)
00C3  02000000           [5] (2)
00C7  02000000           [6] (2)
00CB  02000000           [7] (2)
00CF  02000000           [8] (2)
                         * locals:
00D3  04000000           sizelocvars (4)
00D7  0200000000000000   string size (2)
00DF  6600               "f\0"
                         local [0]: f
00E1  01000000             startpc (1)
00E5  07000000             endpc   (7)
00E9  0200000000000000   string size (2)
00F1  6100               "a\0"
                         local [1]: a
00F3  07000000             startpc (7)
00F7  07000000             endpc   (7)
00FB  0200000000000000   string size (2)
0103  6200               "b\0"
                         local [2]: b
0105  07000000             startpc (7)
0109  07000000             endpc   (7)
010D  0200000000000000   string size (2)
0115  6300               "c\0"
                         local [3]: c
0117  07000000             startpc (7)
011B  07000000             endpc   (7)
                         * upvalues:
011F  00000000           sizeupvalues (0)
                         ** end of function 0 **

0123                     ** end of chunk **
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
002A  06                 maxstacksize (6)
                         * code:
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  40000000           [2] move       1   0        ; R1 := R0
0037  81000000           [3] loadk      2   0        ; R2 := 1
003B  C1400000           [4] loadk      3   1        ; R3 := 2
003F  01810000           [5] loadk      4   2        ; R4 := 3
0043  41C10000           [6] loadk      5   3        ; R5 := 4
0047  5C008102           [7] call       1   5   4    ; R1 to R3 := R1(R2 to R5)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  03                 const type 3
0054  000000000000F03F   const [0]: (1)
005C  03                 const type 3
005D  0000000000000040   const [1]: (2)
0065  03                 const type 3
0066  0000000000000840   const [2]: (3)
006E  03                 const type 3
006F  0000000000001040   const [3]: (4)
                         * functions:
0077  01000000           sizep (1)
                         
007B                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
007B  0000000000000000   string size (0)
                         source name: (none)
0083  01000000           line defined (1)
0087  01000000           last line defined (1)
008B  00                 nups (0)
008C  00                 numparams (0)
008D  00                 is_vararg (0)
008E  02                 maxstacksize (2)
                         * code:
008F  01000000           sizecode (1)
0093  1E008000           [1] return     0   1        ; return 
                         * constants:
0097  00000000           sizek (0)
                         * functions:
009B  00000000           sizep (0)
                         * lines:
009F  01000000           sizelineinfo (1)
                         [pc] (line)
00A3  01000000           [1] (1)
                         * locals:
00A7  00000000           sizelocvars (0)
                         * upvalues:
00AB  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00AF  08000000           sizelineinfo (8)
                         [pc] (line)
00B3  01000000           [1] (1)
00B7  02000000           [2] (2)
00BB  02000000           [3] (2)
00BF  02000000           [4] (2)
00C3  02000000           [5] (2)
00C7  02000000           [6] (2)
00CB  02000000           [7] (2)
00CF  02000000           [8] (2)
                         * locals:
00D3  04000000           sizelocvars (4)
00D7  0200000000000000   string size (2)
00DF  6600               "f\0"
                         local [0]: f
00E1  01000000             startpc (1)
00E5  07000000             endpc   (7)
00E9  0200000000000000   string size (2)
00F1  6100               "a\0"
                         local [1]: a
00F3  07000000             startpc (7)
00F7  07000000             endpc   (7)
00FB  0200000000000000   string size (2)
0103  6200               "b\0"
                         local [2]: b
0105  07000000             startpc (7)
0109  07000000             endpc   (7)
010D  0200000000000000   string size (2)
0115  6300               "c\0"
                         local [3]: c
0117  07000000             startpc (7)
011B  07000000             endpc   (7)
                         * upvalues:
011F  00000000           sizeupvalues (0)
                         ** end of function 0 **

0123                     ** end of chunk **
