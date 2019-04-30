------------------------------
function obj:f(a) end]
local a,obj; obj:f(a)
------------------------------
failed to compile learn.lua:1: unexpected symbol near ']'
; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "f"  ; 0
.const  "a"  ; 0
.const  "b"  ; 1
.const  "c"  ; 2
; (1)  function obj:f(a) end]

[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
; (2)  local a,obj; obj:f(a)
[2] move       1   0        ; R1 := R0
[3] getglobal  2   0        ; R2 := a
[4] getglobal  3   1        ; R3 := b
[5] getglobal  4   2        ; R4 := c
[6] tailcall   1   4   0    ; R1 to top := R1(R2 to R4)
[7] return     1   0        ; return R1 to top
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
; (1)  function obj:f(a) end]

[1] return     0   1        ; return 
; end of function 0_0

; end of function 0


------------------------------
failed to compile learn.lua:1: unexpected symbol near ']'
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
; (1)  function obj:f(a) end]

002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
; (2)  local a,obj; obj:f(a)
0033  40000000           [2] move       1   0        ; R1 := R0
0037  85000000           [3] getglobal  2   0        ; R2 := a
003B  C5400000           [4] getglobal  3   1        ; R3 := b
003F  05810000           [5] getglobal  4   2        ; R4 := c
0043  5D000002           [6] tailcall   1   4   0    ; R1 to top := R1(R2 to R4)
0047  5E000000           [7] return     1   0        ; return R1 to top
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  03000000           sizek (3)
0053  04                 const type 4
0054  0200000000000000   string size (2)
005C  6100               "a\0"
                         const [0]: "a"
005E  04                 const type 4
005F  0200000000000000   string size (2)
0067  6200               "b\0"
                         const [1]: "b"
0069  04                 const type 4
006A  0200000000000000   string size (2)
0072  6300               "c\0"
                         const [2]: "c"
                         * functions:
0074  01000000           sizep (1)
                         
0078                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0078  0000000000000000   string size (0)
                         source name: (none)
0080  01000000           line defined (1)
0084  01000000           last line defined (1)
0088  00                 nups (0)
0089  00                 numparams (0)
008A  00                 is_vararg (0)
008B  02                 maxstacksize (2)
                         * code:
008C  01000000           sizecode (1)
; (1)  function obj:f(a) end]

0090  1E008000           [1] return     0   1        ; return 
                         * constants:
0094  00000000           sizek (0)
                         * functions:
0098  00000000           sizep (0)
                         * lines:
009C  01000000           sizelineinfo (1)
                         [pc] (line)
00A0  01000000           [1] (1)
                         * locals:
00A4  00000000           sizelocvars (0)
                         * upvalues:
00A8  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00AC  08000000           sizelineinfo (8)
                         [pc] (line)
00B0  01000000           [1] (1)
00B4  02000000           [2] (2)
00B8  02000000           [3] (2)
00BC  02000000           [4] (2)
00C0  02000000           [5] (2)
00C4  02000000           [6] (2)
00C8  02000000           [7] (2)
00CC  02000000           [8] (2)
                         * locals:
00D0  01000000           sizelocvars (1)
00D4  0200000000000000   string size (2)
00DC  6600               "f\0"
                         local [0]: f
00DE  01000000             startpc (1)
00E2  07000000             endpc   (7)
                         * upvalues:
00E6  00000000           sizeupvalues (0)
                         ** end of function 0 **

00EA                     ** end of chunk **
