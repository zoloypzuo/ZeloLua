------------------------------
local function f(v)
    local function g()
        return v * v
    end
    local a = g()
    return g
end
f(2)()

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "f"  ; 0
.const  2  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] move       1   0        ; R1 := R0
[3] loadk      2   0        ; R2 := 2
[4] call       1   2   2    ; R1 := R1(R2)
[5] call       1   1   1    ;  := R1()
[6] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "v"  ; 0
.local  "g"  ; 1
.local  "a"  ; 2
[1] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
[2] move       0   0        ; R0 := R0
[3] move       2   1        ; R2 := R1
[4] call       2   1   2    ; R2 := R2()
[5] return     1   2        ; return R1
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.upvalue  "v"  ; 0
[1] getupval   0   0        ; R0 := U0 , v
[2] getupval   1   0        ; R1 := U0 , v
[3] mul        0   0   1    ; R0 := R0 * R1
[4] return     0   2        ; return R0
[5] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

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
0026  03                 maxstacksize (3)
                         * code:
0027  06000000           sizecode (6)
002B  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
002F  40000000           [2] move       1   0        ; R1 := R0
0033  81000000           [3] loadk      2   0        ; R2 := 2
0037  5C800001           [4] call       1   2   2    ; R1 := R1(R2)
003B  5C408000           [5] call       1   1   1    ;  := R1()
003F  1E008000           [6] return     0   1        ; return 
                         * constants:
0043  01000000           sizek (1)
0047  03                 const type 3
0048  0000000000000040   const [0]: (2)
                         * functions:
0050  01000000           sizep (1)
                         
0054                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0054  00000000           string size (0)
                         source name: (none)
0058  01000000           line defined (1)
005C  07000000           last line defined (7)
0060  00                 nups (0)
0061  01                 numparams (1)
0062  00                 is_vararg (0)
0063  03                 maxstacksize (3)
                         * code:
0064  06000000           sizecode (6)
0068  64000000           [1] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
006C  00000000           [2] move       0   0        ; R0 := R0
0070  80008000           [3] move       2   1        ; R2 := R1
0074  9C808000           [4] call       2   1   2    ; R2 := R2()
0078  5E000001           [5] return     1   2        ; return R1
007C  1E008000           [6] return     0   1        ; return 
                         * constants:
0080  00000000           sizek (0)
                         * functions:
0084  01000000           sizep (1)
                         
0088                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0088  00000000           string size (0)
                         source name: (none)
008C  02000000           line defined (2)
0090  04000000           last line defined (4)
0094  01                 nups (1)
0095  00                 numparams (0)
0096  00                 is_vararg (0)
0097  02                 maxstacksize (2)
                         * code:
0098  05000000           sizecode (5)
009C  04000000           [1] getupval   0   0        ; R0 := U0 , v
00A0  44000000           [2] getupval   1   0        ; R1 := U0 , v
00A4  0E400000           [3] mul        0   0   1    ; R0 := R0 * R1
00A8  1E000001           [4] return     0   2        ; return R0
00AC  1E008000           [5] return     0   1        ; return 
                         * constants:
00B0  00000000           sizek (0)
                         * functions:
00B4  00000000           sizep (0)
                         * lines:
00B8  05000000           sizelineinfo (5)
                         [pc] (line)
00BC  03000000           [1] (3)
00C0  03000000           [2] (3)
00C4  03000000           [3] (3)
00C8  03000000           [4] (3)
00CC  04000000           [5] (4)
                         * locals:
00D0  00000000           sizelocvars (0)
                         * upvalues:
00D4  01000000           sizeupvalues (1)
00D8  02000000           string size (2)
00DC  7600               "v\0"
                         upvalue [0]: v
                         ** end of function 0_0_0 **

                         * lines:
00DE  06000000           sizelineinfo (6)
                         [pc] (line)
00E2  04000000           [1] (4)
00E6  04000000           [2] (4)
00EA  05000000           [3] (5)
00EE  05000000           [4] (5)
00F2  06000000           [5] (6)
00F6  07000000           [6] (7)
                         * locals:
00FA  03000000           sizelocvars (3)
00FE  02000000           string size (2)
0102  7600               "v\0"
                         local [0]: v
0104  00000000             startpc (0)
0108  05000000             endpc   (5)
010C  02000000           string size (2)
0110  6700               "g\0"
                         local [1]: g
0112  02000000             startpc (2)
0116  05000000             endpc   (5)
011A  02000000           string size (2)
011E  6100               "a\0"
                         local [2]: a
0120  04000000             startpc (4)
0124  05000000             endpc   (5)
                         * upvalues:
0128  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
012C  06000000           sizelineinfo (6)
                         [pc] (line)
0130  07000000           [1] (7)
0134  08000000           [2] (8)
0138  08000000           [3] (8)
013C  08000000           [4] (8)
0140  08000000           [5] (8)
0144  08000000           [6] (8)
                         * locals:
0148  01000000           sizelocvars (1)
014C  02000000           string size (2)
0150  6600               "f\0"
                         local [0]: f
0152  01000000             startpc (1)
0156  05000000             endpc   (5)
                         * upvalues:
015A  00000000           sizeupvalues (0)
                         ** end of function 0 **

015E                     ** end of chunk **
