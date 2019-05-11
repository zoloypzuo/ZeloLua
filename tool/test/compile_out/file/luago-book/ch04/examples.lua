------------------------------
local a, b, c
c = false     -- boolean
c = {1, 2, 3} -- table
c = "hello"   -- string
a = 3.14      -- number
b = a

--print(type(nil))                     --> nil
--print(type(true))                    --> boolean
--print(type(3.14))                    --> number
--print(type("Hello world"))           --> string
--print(type({}))                      --> table
--print(type(print))                   --> function
--print(type(coroutine.create(print))) --> thread
--print(type(io.stdin))                --> userdata

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 7 stacks
.function  0 0 2 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  "hello"  ; 3
.const  3.14  ; 4
[01] loadbool   2   0   0    ; R2 := false
[02] newtable   3   3   0    ; R3 := {} , array=3, hash=0
[03] loadk      4   0        ; R4 := 1
[04] loadk      5   1        ; R5 := 2
[05] loadk      6   2        ; R6 := 3
[06] setlist    3   3   1    ; R3[1 to 3] := R4 to R6
[07] move       2   3        ; R2 := R3
[08] loadk      2   3        ; R2 := "hello"
[09] loadk      0   4        ; R0 := 3.14
[10] move       1   0        ; R1 := R0
[11] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 7 stacks
.function  0 0 2 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
.const  "hello"  ; 3
.const  3.14  ; 4
[01] loadbool   2   0   0    ; R2 := false
[02] newtable   3   3   0    ; R3 := {} , array=3, hash=0
[03] loadk      4   0        ; R4 := 1
[04] loadk      5   1        ; R5 := 2
[05] loadk      6   2        ; R6 := 3
[06] setlist    3   3   1    ; R3[1 to 3] := R4 to R6
[07] move       2   3        ; R2 := R3
[08] loadk      2   3        ; R2 := "hello"
[09] loadk      0   4        ; R0 := 3.14
[10] move       1   0        ; R1 := R0
[11] return     0   1        ; return 
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
002A  07                 maxstacksize (7)
                         * code:
002B  0B000000           sizecode (11)
002F  82000000           [01] loadbool   2   0   0    ; R2 := false
0033  CA008001           [02] newtable   3   3   0    ; R3 := {} , array=3, hash=0
0037  01010000           [03] loadk      4   0        ; R4 := 1
003B  41410000           [04] loadk      5   1        ; R5 := 2
003F  81810000           [05] loadk      6   2        ; R6 := 3
0043  E2408001           [06] setlist    3   3   1    ; R3[1 to 3] := R4 to R6
0047  80008001           [07] move       2   3        ; R2 := R3
004B  81C00000           [08] loadk      2   3        ; R2 := "hello"
004F  01000100           [09] loadk      0   4        ; R0 := 3.14
0053  40000000           [10] move       1   0        ; R1 := R0
0057  1E008000           [11] return     0   1        ; return 
                         * constants:
005B  05000000           sizek (5)
005F  03                 const type 3
0060  000000000000F03F   const [0]: (1)
0068  03                 const type 3
0069  0000000000000040   const [1]: (2)
0071  03                 const type 3
0072  0000000000000840   const [2]: (3)
007A  04                 const type 4
007B  0600000000000000   string size (6)
0083  68656C6C6F00       "hello\0"
                         const [3]: "hello"
0089  03                 const type 3
008A  1F85EB51B81E0940   const [4]: (3.14)
                         * functions:
0092  00000000           sizep (0)
                         * lines:
0096  0B000000           sizelineinfo (11)
                         [pc] (line)
009A  02000000           [01] (2)
009E  03000000           [02] (3)
00A2  03000000           [03] (3)
00A6  03000000           [04] (3)
00AA  03000000           [05] (3)
00AE  03000000           [06] (3)
00B2  03000000           [07] (3)
00B6  04000000           [08] (4)
00BA  05000000           [09] (5)
00BE  06000000           [10] (6)
00C2  06000000           [11] (6)
                         * locals:
00C6  03000000           sizelocvars (3)
00CA  0200000000000000   string size (2)
00D2  6100               "a\0"
                         local [0]: a
00D4  00000000             startpc (0)
00D8  0A000000             endpc   (10)
00DC  0200000000000000   string size (2)
00E4  6200               "b\0"
                         local [1]: b
00E6  00000000             startpc (0)
00EA  0A000000             endpc   (10)
00EE  0200000000000000   string size (2)
00F6  6300               "c\0"
                         local [2]: c
00F8  00000000             startpc (0)
00FC  0A000000             endpc   (10)
                         * upvalues:
0100  00000000           sizeupvalues (0)
                         ** end of function 0 **

0104                     ** end of chunk **
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
002A  07                 maxstacksize (7)
                         * code:
002B  0B000000           sizecode (11)
002F  82000000           [01] loadbool   2   0   0    ; R2 := false
0033  CA008001           [02] newtable   3   3   0    ; R3 := {} , array=3, hash=0
0037  01010000           [03] loadk      4   0        ; R4 := 1
003B  41410000           [04] loadk      5   1        ; R5 := 2
003F  81810000           [05] loadk      6   2        ; R6 := 3
0043  E2408001           [06] setlist    3   3   1    ; R3[1 to 3] := R4 to R6
0047  80008001           [07] move       2   3        ; R2 := R3
004B  81C00000           [08] loadk      2   3        ; R2 := "hello"
004F  01000100           [09] loadk      0   4        ; R0 := 3.14
0053  40000000           [10] move       1   0        ; R1 := R0
0057  1E008000           [11] return     0   1        ; return 
                         * constants:
005B  05000000           sizek (5)
005F  03                 const type 3
0060  000000000000F03F   const [0]: (1)
0068  03                 const type 3
0069  0000000000000040   const [1]: (2)
0071  03                 const type 3
0072  0000000000000840   const [2]: (3)
007A  04                 const type 4
007B  0600000000000000   string size (6)
0083  68656C6C6F00       "hello\0"
                         const [3]: "hello"
0089  03                 const type 3
008A  1F85EB51B81E0940   const [4]: (3.14)
                         * functions:
0092  00000000           sizep (0)
                         * lines:
0096  0B000000           sizelineinfo (11)
                         [pc] (line)
009A  02000000           [01] (2)
009E  03000000           [02] (3)
00A2  03000000           [03] (3)
00A6  03000000           [04] (3)
00AA  03000000           [05] (3)
00AE  03000000           [06] (3)
00B2  03000000           [07] (3)
00B6  04000000           [08] (4)
00BA  05000000           [09] (5)
00BE  06000000           [10] (6)
00C2  06000000           [11] (6)
                         * locals:
00C6  03000000           sizelocvars (3)
00CA  0200000000000000   string size (2)
00D2  6100               "a\0"
                         local [0]: a
00D4  00000000             startpc (0)
00D8  0A000000             endpc   (10)
00DC  0200000000000000   string size (2)
00E4  6200               "b\0"
                         local [1]: b
00E6  00000000             startpc (0)
00EA  0A000000             endpc   (10)
00EE  0200000000000000   string size (2)
00F6  6300               "c\0"
                         local [2]: c
00F8  00000000             startpc (0)
00FC  0A000000             endpc   (10)
                         * upvalues:
0100  00000000           sizeupvalues (0)
                         ** end of function 0 **

0104                     ** end of chunk **
