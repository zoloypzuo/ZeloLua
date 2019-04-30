------------------------------
local a,b,c,d; b = {x=1,y=2}
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
.local  "d"  ; 3
.const  "x"  ; 0
.const  1  ; 1
.const  "y"  ; 2
.const  2  ; 3
[1] newtable   4   0   2    ; R4 := {} , array=0, hash=2
[2] settable   4   256 257  ; R4["x"] := 1
[3] settable   4   258 259  ; R4["y"] := 2
[4] move       1   4        ; R1 := R4
[5] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "d"  ; 3
.const  "x"  ; 0
.const  1  ; 1
.const  "y"  ; 2
.const  2  ; 3
[1] newtable   4   0   2    ; R4 := {} , array=0, hash=2
[2] settable   4   256 257  ; R4["x"] := 1
[3] settable   4   258 259  ; R4["y"] := 2
[4] move       1   4        ; R1 := R4
[5] return     0   1        ; return 
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
002B  05000000           sizecode (5)
002F  0A810000           [1] newtable   4   0   2    ; R4 := {} , array=0, hash=2
0033  09414080           [2] settable   4   256 257  ; R4["x"] := 1
0037  09C14081           [3] settable   4   258 259  ; R4["y"] := 2
003B  40000002           [4] move       1   4        ; R1 := R4
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  04000000           sizek (4)
0047  04                 const type 4
0048  0200000000000000   string size (2)
0050  7800               "x\0"
                         const [0]: "x"
0052  03                 const type 3
0053  000000000000F03F   const [1]: (1)
005B  04                 const type 4
005C  0200000000000000   string size (2)
0064  7900               "y\0"
                         const [2]: "y"
0066  03                 const type 3
0067  0000000000000040   const [3]: (2)
                         * functions:
006F  00000000           sizep (0)
                         * lines:
0073  05000000           sizelineinfo (5)
                         [pc] (line)
0077  01000000           [1] (1)
007B  01000000           [2] (1)
007F  01000000           [3] (1)
0083  01000000           [4] (1)
0087  01000000           [5] (1)
                         * locals:
008B  04000000           sizelocvars (4)
008F  0200000000000000   string size (2)
0097  6100               "a\0"
                         local [0]: a
0099  00000000             startpc (0)
009D  04000000             endpc   (4)
00A1  0200000000000000   string size (2)
00A9  6200               "b\0"
                         local [1]: b
00AB  00000000             startpc (0)
00AF  04000000             endpc   (4)
00B3  0200000000000000   string size (2)
00BB  6300               "c\0"
                         local [2]: c
00BD  00000000             startpc (0)
00C1  04000000             endpc   (4)
00C5  0200000000000000   string size (2)
00CD  6400               "d\0"
                         local [3]: d
00CF  00000000             startpc (0)
00D3  04000000             endpc   (4)
                         * upvalues:
00D7  00000000           sizeupvalues (0)
                         ** end of function 0 **

00DB                     ** end of chunk **
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
002B  05000000           sizecode (5)
002F  0A810000           [1] newtable   4   0   2    ; R4 := {} , array=0, hash=2
0033  09414080           [2] settable   4   256 257  ; R4["x"] := 1
0037  09C14081           [3] settable   4   258 259  ; R4["y"] := 2
003B  40000002           [4] move       1   4        ; R1 := R4
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  04000000           sizek (4)
0047  04                 const type 4
0048  0200000000000000   string size (2)
0050  7800               "x\0"
                         const [0]: "x"
0052  03                 const type 3
0053  000000000000F03F   const [1]: (1)
005B  04                 const type 4
005C  0200000000000000   string size (2)
0064  7900               "y\0"
                         const [2]: "y"
0066  03                 const type 3
0067  0000000000000040   const [3]: (2)
                         * functions:
006F  00000000           sizep (0)
                         * lines:
0073  05000000           sizelineinfo (5)
                         [pc] (line)
0077  01000000           [1] (1)
007B  01000000           [2] (1)
007F  01000000           [3] (1)
0083  01000000           [4] (1)
0087  01000000           [5] (1)
                         * locals:
008B  04000000           sizelocvars (4)
008F  0200000000000000   string size (2)
0097  6100               "a\0"
                         local [0]: a
0099  00000000             startpc (0)
009D  04000000             endpc   (4)
00A1  0200000000000000   string size (2)
00A9  6200               "b\0"
                         local [1]: b
00AB  00000000             startpc (0)
00AF  04000000             endpc   (4)
00B3  0200000000000000   string size (2)
00BB  6300               "c\0"
                         local [2]: c
00BD  00000000             startpc (0)
00C1  04000000             endpc   (4)
00C5  0200000000000000   string size (2)
00CD  6400               "d\0"
                         local [3]: d
00CF  00000000             startpc (0)
00D3  04000000             endpc   (4)
                         * upvalues:
00D7  00000000           sizeupvalues (0)
                         ** end of function 0 **

00DB                     ** end of chunk **
