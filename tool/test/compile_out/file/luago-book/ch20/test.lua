------------------------------
assert(require("math") == math)
local mymod = require "mymod"
mymod.foo()
mymod.bar()

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "mymod"  ; 0
.const  "assert"  ; 0
.const  "require"  ; 1
.const  "math"  ; 2
.const  "mymod"  ; 3
.const  "foo"  ; 4
.const  "bar"  ; 5
[01] getglobal  0   0        ; R0 := assert
[02] getglobal  1   1        ; R1 := require
[03] loadk      2   2        ; R2 := "math"
[04] call       1   2   2    ; R1 := R1(R2)
[05] getglobal  2   2        ; R2 := math
[06] eq         1   1   2    ; R1 == R2, pc+=1 (goto [8]) if false
[07] jmp        1            ; pc+=1 (goto [9])
[08] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [10])
[09] loadbool   1   1   0    ; R1 := true
[10] call       0   2   1    ;  := R0(R1)
[11] getglobal  0   1        ; R0 := require
[12] loadk      1   3        ; R1 := "mymod"
[13] call       0   2   2    ; R0 := R0(R1)
[14] gettable   1   0   260  ; R1 := R0["foo"]
[15] call       1   1   1    ;  := R1()
[16] gettable   1   0   261  ; R1 := R0["bar"]
[17] call       1   1   1    ;  := R1()
[18] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "mymod"  ; 0
.const  "assert"  ; 0
.const  "require"  ; 1
.const  "math"  ; 2
.const  "mymod"  ; 3
.const  "foo"  ; 4
.const  "bar"  ; 5
[01] getglobal  0   0        ; R0 := assert
[02] getglobal  1   1        ; R1 := require
[03] loadk      2   2        ; R2 := "math"
[04] call       1   2   2    ; R1 := R1(R2)
[05] getglobal  2   2        ; R2 := math
[06] eq         1   1   2    ; R1 == R2, pc+=1 (goto [8]) if false
[07] jmp        1            ; pc+=1 (goto [9])
[08] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [10])
[09] loadbool   1   1   0    ; R1 := true
[10] call       0   2   1    ;  := R0(R1)
[11] getglobal  0   1        ; R0 := require
[12] loadk      1   3        ; R1 := "mymod"
[13] call       0   2   2    ; R0 := R0(R1)
[14] gettable   1   0   260  ; R1 := R0["foo"]
[15] call       1   1   1    ;  := R1()
[16] gettable   1   0   261  ; R1 := R0["bar"]
[17] call       1   1   1    ;  := R1()
[18] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  12000000           sizecode (18)
002F  05000000           [01] getglobal  0   0        ; R0 := assert
0033  45400000           [02] getglobal  1   1        ; R1 := require
0037  81800000           [03] loadk      2   2        ; R2 := "math"
003B  5C800001           [04] call       1   2   2    ; R1 := R1(R2)
003F  85800000           [05] getglobal  2   2        ; R2 := math
0043  57808000           [06] eq         1   1   2    ; R1 == R2, pc+=1 (goto [8]) if false
0047  16000080           [07] jmp        1            ; pc+=1 (goto [9])
004B  42400000           [08] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [10])
004F  42008000           [09] loadbool   1   1   0    ; R1 := true
0053  1C400001           [10] call       0   2   1    ;  := R0(R1)
0057  05400000           [11] getglobal  0   1        ; R0 := require
005B  41C00000           [12] loadk      1   3        ; R1 := "mymod"
005F  1C800001           [13] call       0   2   2    ; R0 := R0(R1)
0063  46004100           [14] gettable   1   0   260  ; R1 := R0["foo"]
0067  5C408000           [15] call       1   1   1    ;  := R1()
006B  46404100           [16] gettable   1   0   261  ; R1 := R0["bar"]
006F  5C408000           [17] call       1   1   1    ;  := R1()
0073  1E008000           [18] return     0   1        ; return 
                         * constants:
0077  06000000           sizek (6)
007B  04                 const type 4
007C  0700000000000000   string size (7)
0084  61737365727400     "assert\0"
                         const [0]: "assert"
008B  04                 const type 4
008C  0800000000000000   string size (8)
0094  7265717569726500   "require\0"
                         const [1]: "require"
009C  04                 const type 4
009D  0500000000000000   string size (5)
00A5  6D61746800         "math\0"
                         const [2]: "math"
00AA  04                 const type 4
00AB  0600000000000000   string size (6)
00B3  6D796D6F6400       "mymod\0"
                         const [3]: "mymod"
00B9  04                 const type 4
00BA  0400000000000000   string size (4)
00C2  666F6F00           "foo\0"
                         const [4]: "foo"
00C6  04                 const type 4
00C7  0400000000000000   string size (4)
00CF  62617200           "bar\0"
                         const [5]: "bar"
                         * functions:
00D3  00000000           sizep (0)
                         * lines:
00D7  12000000           sizelineinfo (18)
                         [pc] (line)
00DB  01000000           [01] (1)
00DF  01000000           [02] (1)
00E3  01000000           [03] (1)
00E7  01000000           [04] (1)
00EB  01000000           [05] (1)
00EF  01000000           [06] (1)
00F3  01000000           [07] (1)
00F7  01000000           [08] (1)
00FB  01000000           [09] (1)
00FF  01000000           [10] (1)
0103  02000000           [11] (2)
0107  02000000           [12] (2)
010B  02000000           [13] (2)
010F  03000000           [14] (3)
0113  03000000           [15] (3)
0117  04000000           [16] (4)
011B  04000000           [17] (4)
011F  04000000           [18] (4)
                         * locals:
0123  01000000           sizelocvars (1)
0127  0600000000000000   string size (6)
012F  6D796D6F6400       "mymod\0"
                         local [0]: mymod
0135  0D000000             startpc (13)
0139  11000000             endpc   (17)
                         * upvalues:
013D  00000000           sizeupvalues (0)
                         ** end of function 0 **

0141                     ** end of chunk **
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
002A  03                 maxstacksize (3)
                         * code:
002B  12000000           sizecode (18)
002F  05000000           [01] getglobal  0   0        ; R0 := assert
0033  45400000           [02] getglobal  1   1        ; R1 := require
0037  81800000           [03] loadk      2   2        ; R2 := "math"
003B  5C800001           [04] call       1   2   2    ; R1 := R1(R2)
003F  85800000           [05] getglobal  2   2        ; R2 := math
0043  57808000           [06] eq         1   1   2    ; R1 == R2, pc+=1 (goto [8]) if false
0047  16000080           [07] jmp        1            ; pc+=1 (goto [9])
004B  42400000           [08] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [10])
004F  42008000           [09] loadbool   1   1   0    ; R1 := true
0053  1C400001           [10] call       0   2   1    ;  := R0(R1)
0057  05400000           [11] getglobal  0   1        ; R0 := require
005B  41C00000           [12] loadk      1   3        ; R1 := "mymod"
005F  1C800001           [13] call       0   2   2    ; R0 := R0(R1)
0063  46004100           [14] gettable   1   0   260  ; R1 := R0["foo"]
0067  5C408000           [15] call       1   1   1    ;  := R1()
006B  46404100           [16] gettable   1   0   261  ; R1 := R0["bar"]
006F  5C408000           [17] call       1   1   1    ;  := R1()
0073  1E008000           [18] return     0   1        ; return 
                         * constants:
0077  06000000           sizek (6)
007B  04                 const type 4
007C  0700000000000000   string size (7)
0084  61737365727400     "assert\0"
                         const [0]: "assert"
008B  04                 const type 4
008C  0800000000000000   string size (8)
0094  7265717569726500   "require\0"
                         const [1]: "require"
009C  04                 const type 4
009D  0500000000000000   string size (5)
00A5  6D61746800         "math\0"
                         const [2]: "math"
00AA  04                 const type 4
00AB  0600000000000000   string size (6)
00B3  6D796D6F6400       "mymod\0"
                         const [3]: "mymod"
00B9  04                 const type 4
00BA  0400000000000000   string size (4)
00C2  666F6F00           "foo\0"
                         const [4]: "foo"
00C6  04                 const type 4
00C7  0400000000000000   string size (4)
00CF  62617200           "bar\0"
                         const [5]: "bar"
                         * functions:
00D3  00000000           sizep (0)
                         * lines:
00D7  12000000           sizelineinfo (18)
                         [pc] (line)
00DB  01000000           [01] (1)
00DF  01000000           [02] (1)
00E3  01000000           [03] (1)
00E7  01000000           [04] (1)
00EB  01000000           [05] (1)
00EF  01000000           [06] (1)
00F3  01000000           [07] (1)
00F7  01000000           [08] (1)
00FB  01000000           [09] (1)
00FF  01000000           [10] (1)
0103  02000000           [11] (2)
0107  02000000           [12] (2)
010B  02000000           [13] (2)
010F  03000000           [14] (3)
0113  03000000           [15] (3)
0117  04000000           [16] (4)
011B  04000000           [17] (4)
011F  04000000           [18] (4)
                         * locals:
0123  01000000           sizelocvars (1)
0127  0600000000000000   string size (6)
012F  6D796D6F6400       "mymod\0"
                         local [0]: mymod
0135  0D000000             startpc (13)
0139  11000000             endpc   (17)
                         * upvalues:
013D  00000000           sizeupvalues (0)
                         ** end of function 0 **

0141                     ** end of chunk **
