------------------------------

local a = "a"
local p = {[a]=1}

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "a"  ; 0
.local  "p"  ; 1
.const  "a"  ; 0
.const  1  ; 1
[1] loadk      0   0        ; R0 := "a"
[2] newtable   1   0   1    ; R1 := {} , array=0, hash=1
[3] settable   1   0   257  ; R1[R0] := 1
[4] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "a"  ; 0
.local  "p"  ; 1
.const  "a"  ; 0
.const  1  ; 1
[1] loadk      0   0        ; R0 := "a"
[2] newtable   1   0   1    ; R1 := {} , array=0, hash=1
[3] settable   1   0   257  ; R1[R0] := 1
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
002F  01000000           [1] loadk      0   0        ; R0 := "a"
0033  4A400000           [2] newtable   1   0   1    ; R1 := {} , array=0, hash=1
0037  49404000           [3] settable   1   0   257  ; R1[R0] := 1
003B  1E008000           [4] return     0   1        ; return 
                         * constants:
003F  02000000           sizek (2)
0043  04                 const type 4
0044  0200000000000000   string size (2)
004C  6100               "a\0"
                         const [0]: "a"
004E  03                 const type 3
004F  000000000000F03F   const [1]: (1)
                         * functions:
0057  00000000           sizep (0)
                         * lines:
005B  04000000           sizelineinfo (4)
                         [pc] (line)
005F  02000000           [1] (2)
0063  03000000           [2] (3)
0067  03000000           [3] (3)
006B  03000000           [4] (3)
                         * locals:
006F  02000000           sizelocvars (2)
0073  0200000000000000   string size (2)
007B  6100               "a\0"
                         local [0]: a
007D  01000000             startpc (1)
0081  03000000             endpc   (3)
0085  0200000000000000   string size (2)
008D  7000               "p\0"
                         local [1]: p
008F  03000000             startpc (3)
0093  03000000             endpc   (3)
                         * upvalues:
0097  00000000           sizeupvalues (0)
                         ** end of function 0 **

009B                     ** end of chunk **
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
002F  01000000           [1] loadk      0   0        ; R0 := "a"
0033  4A400000           [2] newtable   1   0   1    ; R1 := {} , array=0, hash=1
0037  49404000           [3] settable   1   0   257  ; R1[R0] := 1
003B  1E008000           [4] return     0   1        ; return 
                         * constants:
003F  02000000           sizek (2)
0043  04                 const type 4
0044  0200000000000000   string size (2)
004C  6100               "a\0"
                         const [0]: "a"
004E  03                 const type 3
004F  000000000000F03F   const [1]: (1)
                         * functions:
0057  00000000           sizep (0)
                         * lines:
005B  04000000           sizelineinfo (4)
                         [pc] (line)
005F  02000000           [1] (2)
0063  03000000           [2] (3)
0067  03000000           [3] (3)
006B  03000000           [4] (3)
                         * locals:
006F  02000000           sizelocvars (2)
0073  0200000000000000   string size (2)
007B  6100               "a\0"
                         local [0]: a
007D  01000000             startpc (1)
0081  03000000             endpc   (3)
0085  0200000000000000   string size (2)
008D  7000               "p\0"
                         local [1]: p
008F  03000000             startpc (3)
0093  03000000             endpc   (3)
                         * upvalues:
0097  00000000           sizeupvalues (0)
                         ** end of function 0 **

009B                     ** end of chunk **
