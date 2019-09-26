------------------------------
t = {1,2,f()}
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "t"  ; 0
.const  1  ; 1
.const  2  ; 2
.const  "f"  ; 3
[1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[2] loadk      1   1        ; R1 := 1
[3] loadk      2   2        ; R2 := 2
[4] getglobal  3   3        ; R3 := f
[5] call       3   1   0    ; R3 to top := R3()
[6] setlist    0   0   1    ; R0[1 to top] := R1 to top
[7] setglobal  0   0        ; t := R0
[8] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "t"  ; 0
.const  1  ; 1
.const  2  ; 2
.const  "f"  ; 3
[1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[2] loadk      1   1        ; R1 := 1
[3] loadk      2   2        ; R2 := 2
[4] getglobal  3   3        ; R3 := f
[5] call       3   1   0    ; R3 to top := R3()
[6] setlist    0   0   1    ; R0[1 to top] := R1 to top
[7] setglobal  0   0        ; t := R0
[8] return     0   1        ; return 
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
002A  04                 maxstacksize (4)
                         * code:
002B  08000000           sizecode (8)
002F  0A000001           [1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
0033  41400000           [2] loadk      1   1        ; R1 := 1
0037  81800000           [3] loadk      2   2        ; R2 := 2
003B  C5C00000           [4] getglobal  3   3        ; R3 := f
003F  DC008000           [5] call       3   1   0    ; R3 to top := R3()
0043  22400000           [6] setlist    0   0   1    ; R0[1 to top] := R1 to top
0047  07000000           [7] setglobal  0   0        ; t := R0
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  04                 const type 4
0054  0200000000000000   string size (2)
005C  7400               "t\0"
                         const [0]: "t"
005E  03                 const type 3
005F  000000000000F03F   const [1]: (1)
0067  03                 const type 3
0068  0000000000000040   const [2]: (2)
0070  04                 const type 4
0071  0200000000000000   string size (2)
0079  6600               "f\0"
                         const [3]: "f"
                         * functions:
007B  00000000           sizep (0)
                         * lines:
007F  08000000           sizelineinfo (8)
                         [pc] (line)
0083  01000000           [1] (1)
0087  01000000           [2] (1)
008B  01000000           [3] (1)
008F  01000000           [4] (1)
0093  01000000           [5] (1)
0097  01000000           [6] (1)
009B  01000000           [7] (1)
009F  01000000           [8] (1)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0 **

00AB                     ** end of chunk **
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
002A  04                 maxstacksize (4)
                         * code:
002B  08000000           sizecode (8)
002F  0A000001           [1] newtable   0   2   0    ; R0 := {} , array=2, hash=0
0033  41400000           [2] loadk      1   1        ; R1 := 1
0037  81800000           [3] loadk      2   2        ; R2 := 2
003B  C5C00000           [4] getglobal  3   3        ; R3 := f
003F  DC008000           [5] call       3   1   0    ; R3 to top := R3()
0043  22400000           [6] setlist    0   0   1    ; R0[1 to top] := R1 to top
0047  07000000           [7] setglobal  0   0        ; t := R0
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  04000000           sizek (4)
0053  04                 const type 4
0054  0200000000000000   string size (2)
005C  7400               "t\0"
                         const [0]: "t"
005E  03                 const type 3
005F  000000000000F03F   const [1]: (1)
0067  03                 const type 3
0068  0000000000000040   const [2]: (2)
0070  04                 const type 4
0071  0200000000000000   string size (2)
0079  6600               "f\0"
                         const [3]: "f"
                         * functions:
007B  00000000           sizep (0)
                         * lines:
007F  08000000           sizelineinfo (8)
                         [pc] (line)
0083  01000000           [1] (1)
0087  01000000           [2] (1)
008B  01000000           [3] (1)
008F  01000000           [4] (1)
0093  01000000           [5] (1)
0097  01000000           [6] (1)
009B  01000000           [7] (1)
009F  01000000           [8] (1)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0 **

00AB                     ** end of chunk **
