------------------------------
local function assert(arg)
  if not arg then fail() end
end

assert(_ENV ~= nil)
assert(foo == nil)

foo = "bar"
assert(foo == "bar")
assert(_ENV["foo"] == "bar")

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "assert"  ; 0
.const  "_ENV"  ; 0
.const  nil  ; 1
.const  "foo"  ; 2
.const  "bar"  ; 3
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] move       1   0        ; R1 := R0
[03] getglobal  2   0        ; R2 := _ENV
[04] eq         0   2   257  ; R2 == nil, pc+=1 (goto [6]) if true
[05] jmp        1            ; pc+=1 (goto [7])
[06] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [8])
[07] loadbool   2   1   0    ; R2 := true
[08] call       1   2   1    ;  := R1(R2)
[09] move       1   0        ; R1 := R0
[10] getglobal  2   2        ; R2 := foo
[11] eq         1   2   257  ; R2 == nil, pc+=1 (goto [13]) if false
[12] jmp        1            ; pc+=1 (goto [14])
[13] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [15])
[14] loadbool   2   1   0    ; R2 := true
[15] call       1   2   1    ;  := R1(R2)
[16] loadk      1   3        ; R1 := "bar"
[17] setglobal  1   2        ; foo := R1
[18] move       1   0        ; R1 := R0
[19] getglobal  2   2        ; R2 := foo
[20] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [22]) if false
[21] jmp        1            ; pc+=1 (goto [23])
[22] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [24])
[23] loadbool   2   1   0    ; R2 := true
[24] call       1   2   1    ;  := R1(R2)
[25] move       1   0        ; R1 := R0
[26] getglobal  2   0        ; R2 := _ENV
[27] gettable   2   2   258  ; R2 := R2["foo"]
[28] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [30]) if false
[29] jmp        1            ; pc+=1 (goto [31])
[30] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [32])
[31] loadbool   2   1   0    ; R2 := true
[32] call       1   2   1    ;  := R1(R2)
[33] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "arg"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "assert"  ; 0
.const  "_ENV"  ; 0
.const  nil  ; 1
.const  "foo"  ; 2
.const  "bar"  ; 3
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] move       1   0        ; R1 := R0
[03] getglobal  2   0        ; R2 := _ENV
[04] eq         0   2   257  ; R2 == nil, pc+=1 (goto [6]) if true
[05] jmp        1            ; pc+=1 (goto [7])
[06] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [8])
[07] loadbool   2   1   0    ; R2 := true
[08] call       1   2   1    ;  := R1(R2)
[09] move       1   0        ; R1 := R0
[10] getglobal  2   2        ; R2 := foo
[11] eq         1   2   257  ; R2 == nil, pc+=1 (goto [13]) if false
[12] jmp        1            ; pc+=1 (goto [14])
[13] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [15])
[14] loadbool   2   1   0    ; R2 := true
[15] call       1   2   1    ;  := R1(R2)
[16] loadk      1   3        ; R1 := "bar"
[17] setglobal  1   2        ; foo := R1
[18] move       1   0        ; R1 := R0
[19] getglobal  2   2        ; R2 := foo
[20] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [22]) if false
[21] jmp        1            ; pc+=1 (goto [23])
[22] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [24])
[23] loadbool   2   1   0    ; R2 := true
[24] call       1   2   1    ;  := R1(R2)
[25] move       1   0        ; R1 := R0
[26] getglobal  2   0        ; R2 := _ENV
[27] gettable   2   2   258  ; R2 := R2["foo"]
[28] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [30]) if false
[29] jmp        1            ; pc+=1 (goto [31])
[30] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [32])
[31] loadbool   2   1   0    ; R2 := true
[32] call       1   2   1    ;  := R1(R2)
[33] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "arg"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  21000000           sizecode (33)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  40000000           [02] move       1   0        ; R1 := R0
0037  85000000           [03] getglobal  2   0        ; R2 := _ENV
003B  17404001           [04] eq         0   2   257  ; R2 == nil, pc+=1 (goto [6]) if true
003F  16000080           [05] jmp        1            ; pc+=1 (goto [7])
0043  82400000           [06] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [8])
0047  82008000           [07] loadbool   2   1   0    ; R2 := true
004B  5C400001           [08] call       1   2   1    ;  := R1(R2)
004F  40000000           [09] move       1   0        ; R1 := R0
0053  85800000           [10] getglobal  2   2        ; R2 := foo
0057  57404001           [11] eq         1   2   257  ; R2 == nil, pc+=1 (goto [13]) if false
005B  16000080           [12] jmp        1            ; pc+=1 (goto [14])
005F  82400000           [13] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [15])
0063  82008000           [14] loadbool   2   1   0    ; R2 := true
0067  5C400001           [15] call       1   2   1    ;  := R1(R2)
006B  41C00000           [16] loadk      1   3        ; R1 := "bar"
006F  47800000           [17] setglobal  1   2        ; foo := R1
0073  40000000           [18] move       1   0        ; R1 := R0
0077  85800000           [19] getglobal  2   2        ; R2 := foo
007B  57C04001           [20] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [22]) if false
007F  16000080           [21] jmp        1            ; pc+=1 (goto [23])
0083  82400000           [22] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [24])
0087  82008000           [23] loadbool   2   1   0    ; R2 := true
008B  5C400001           [24] call       1   2   1    ;  := R1(R2)
008F  40000000           [25] move       1   0        ; R1 := R0
0093  85000000           [26] getglobal  2   0        ; R2 := _ENV
0097  86804001           [27] gettable   2   2   258  ; R2 := R2["foo"]
009B  57C04001           [28] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [30]) if false
009F  16000080           [29] jmp        1            ; pc+=1 (goto [31])
00A3  82400000           [30] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [32])
00A7  82008000           [31] loadbool   2   1   0    ; R2 := true
00AB  5C400001           [32] call       1   2   1    ;  := R1(R2)
00AF  1E008000           [33] return     0   1        ; return 
                         * constants:
00B3  04000000           sizek (4)
00B7  04                 const type 4
00B8  0500000000000000   string size (5)
00C0  5F454E5600         "_ENV\0"
                         const [0]: "_ENV"
00C5  00                 const type 0
                         const [1]: nil
00C6  04                 const type 4
00C7  0400000000000000   string size (4)
00CF  666F6F00           "foo\0"
                         const [2]: "foo"
00D3  04                 const type 4
00D4  0400000000000000   string size (4)
00DC  62617200           "bar\0"
                         const [3]: "bar"
                         * functions:
00E0  01000000           sizep (1)
                         
00E4                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E4  0000000000000000   string size (0)
                         source name: (none)
00EC  01000000           line defined (1)
00F0  03000000           last line defined (3)
00F4  00                 nups (0)
00F5  01                 numparams (1)
00F6  00                 is_vararg (0)
00F7  02                 maxstacksize (2)
                         * code:
00F8  05000000           sizecode (5)
00FC  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
0100  16400080           [2] jmp        2            ; pc+=2 (goto [5])
0104  45000000           [3] getglobal  1   0        ; R1 := fail
0108  5C408000           [4] call       1   1   1    ;  := R1()
010C  1E008000           [5] return     0   1        ; return 
                         * constants:
0110  01000000           sizek (1)
0114  04                 const type 4
0115  0500000000000000   string size (5)
011D  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
0122  00000000           sizep (0)
                         * lines:
0126  05000000           sizelineinfo (5)
                         [pc] (line)
012A  02000000           [1] (2)
012E  02000000           [2] (2)
0132  02000000           [3] (2)
0136  02000000           [4] (2)
013A  03000000           [5] (3)
                         * locals:
013E  01000000           sizelocvars (1)
0142  0400000000000000   string size (4)
014A  61726700           "arg\0"
                         local [0]: arg
014E  00000000             startpc (0)
0152  04000000             endpc   (4)
                         * upvalues:
0156  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
015A  21000000           sizelineinfo (33)
                         [pc] (line)
015E  03000000           [01] (3)
0162  05000000           [02] (5)
0166  05000000           [03] (5)
016A  05000000           [04] (5)
016E  05000000           [05] (5)
0172  05000000           [06] (5)
0176  05000000           [07] (5)
017A  05000000           [08] (5)
017E  06000000           [09] (6)
0182  06000000           [10] (6)
0186  06000000           [11] (6)
018A  06000000           [12] (6)
018E  06000000           [13] (6)
0192  06000000           [14] (6)
0196  06000000           [15] (6)
019A  08000000           [16] (8)
019E  08000000           [17] (8)
01A2  09000000           [18] (9)
01A6  09000000           [19] (9)
01AA  09000000           [20] (9)
01AE  09000000           [21] (9)
01B2  09000000           [22] (9)
01B6  09000000           [23] (9)
01BA  09000000           [24] (9)
01BE  0A000000           [25] (10)
01C2  0A000000           [26] (10)
01C6  0A000000           [27] (10)
01CA  0A000000           [28] (10)
01CE  0A000000           [29] (10)
01D2  0A000000           [30] (10)
01D6  0A000000           [31] (10)
01DA  0A000000           [32] (10)
01DE  0A000000           [33] (10)
                         * locals:
01E2  01000000           sizelocvars (1)
01E6  0700000000000000   string size (7)
01EE  61737365727400     "assert\0"
                         local [0]: assert
01F5  01000000             startpc (1)
01F9  20000000             endpc   (32)
                         * upvalues:
01FD  00000000           sizeupvalues (0)
                         ** end of function 0 **

0201                     ** end of chunk **
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
002B  21000000           sizecode (33)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  40000000           [02] move       1   0        ; R1 := R0
0037  85000000           [03] getglobal  2   0        ; R2 := _ENV
003B  17404001           [04] eq         0   2   257  ; R2 == nil, pc+=1 (goto [6]) if true
003F  16000080           [05] jmp        1            ; pc+=1 (goto [7])
0043  82400000           [06] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [8])
0047  82008000           [07] loadbool   2   1   0    ; R2 := true
004B  5C400001           [08] call       1   2   1    ;  := R1(R2)
004F  40000000           [09] move       1   0        ; R1 := R0
0053  85800000           [10] getglobal  2   2        ; R2 := foo
0057  57404001           [11] eq         1   2   257  ; R2 == nil, pc+=1 (goto [13]) if false
005B  16000080           [12] jmp        1            ; pc+=1 (goto [14])
005F  82400000           [13] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [15])
0063  82008000           [14] loadbool   2   1   0    ; R2 := true
0067  5C400001           [15] call       1   2   1    ;  := R1(R2)
006B  41C00000           [16] loadk      1   3        ; R1 := "bar"
006F  47800000           [17] setglobal  1   2        ; foo := R1
0073  40000000           [18] move       1   0        ; R1 := R0
0077  85800000           [19] getglobal  2   2        ; R2 := foo
007B  57C04001           [20] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [22]) if false
007F  16000080           [21] jmp        1            ; pc+=1 (goto [23])
0083  82400000           [22] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [24])
0087  82008000           [23] loadbool   2   1   0    ; R2 := true
008B  5C400001           [24] call       1   2   1    ;  := R1(R2)
008F  40000000           [25] move       1   0        ; R1 := R0
0093  85000000           [26] getglobal  2   0        ; R2 := _ENV
0097  86804001           [27] gettable   2   2   258  ; R2 := R2["foo"]
009B  57C04001           [28] eq         1   2   259  ; R2 == "bar", pc+=1 (goto [30]) if false
009F  16000080           [29] jmp        1            ; pc+=1 (goto [31])
00A3  82400000           [30] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [32])
00A7  82008000           [31] loadbool   2   1   0    ; R2 := true
00AB  5C400001           [32] call       1   2   1    ;  := R1(R2)
00AF  1E008000           [33] return     0   1        ; return 
                         * constants:
00B3  04000000           sizek (4)
00B7  04                 const type 4
00B8  0500000000000000   string size (5)
00C0  5F454E5600         "_ENV\0"
                         const [0]: "_ENV"
00C5  00                 const type 0
                         const [1]: nil
00C6  04                 const type 4
00C7  0400000000000000   string size (4)
00CF  666F6F00           "foo\0"
                         const [2]: "foo"
00D3  04                 const type 4
00D4  0400000000000000   string size (4)
00DC  62617200           "bar\0"
                         const [3]: "bar"
                         * functions:
00E0  01000000           sizep (1)
                         
00E4                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E4  0000000000000000   string size (0)
                         source name: (none)
00EC  01000000           line defined (1)
00F0  03000000           last line defined (3)
00F4  00                 nups (0)
00F5  01                 numparams (1)
00F6  00                 is_vararg (0)
00F7  02                 maxstacksize (2)
                         * code:
00F8  05000000           sizecode (5)
00FC  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
0100  16400080           [2] jmp        2            ; pc+=2 (goto [5])
0104  45000000           [3] getglobal  1   0        ; R1 := fail
0108  5C408000           [4] call       1   1   1    ;  := R1()
010C  1E008000           [5] return     0   1        ; return 
                         * constants:
0110  01000000           sizek (1)
0114  04                 const type 4
0115  0500000000000000   string size (5)
011D  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
0122  00000000           sizep (0)
                         * lines:
0126  05000000           sizelineinfo (5)
                         [pc] (line)
012A  02000000           [1] (2)
012E  02000000           [2] (2)
0132  02000000           [3] (2)
0136  02000000           [4] (2)
013A  03000000           [5] (3)
                         * locals:
013E  01000000           sizelocvars (1)
0142  0400000000000000   string size (4)
014A  61726700           "arg\0"
                         local [0]: arg
014E  00000000             startpc (0)
0152  04000000             endpc   (4)
                         * upvalues:
0156  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
015A  21000000           sizelineinfo (33)
                         [pc] (line)
015E  03000000           [01] (3)
0162  05000000           [02] (5)
0166  05000000           [03] (5)
016A  05000000           [04] (5)
016E  05000000           [05] (5)
0172  05000000           [06] (5)
0176  05000000           [07] (5)
017A  05000000           [08] (5)
017E  06000000           [09] (6)
0182  06000000           [10] (6)
0186  06000000           [11] (6)
018A  06000000           [12] (6)
018E  06000000           [13] (6)
0192  06000000           [14] (6)
0196  06000000           [15] (6)
019A  08000000           [16] (8)
019E  08000000           [17] (8)
01A2  09000000           [18] (9)
01A6  09000000           [19] (9)
01AA  09000000           [20] (9)
01AE  09000000           [21] (9)
01B2  09000000           [22] (9)
01B6  09000000           [23] (9)
01BA  09000000           [24] (9)
01BE  0A000000           [25] (10)
01C2  0A000000           [26] (10)
01C6  0A000000           [27] (10)
01CA  0A000000           [28] (10)
01CE  0A000000           [29] (10)
01D2  0A000000           [30] (10)
01D6  0A000000           [31] (10)
01DA  0A000000           [32] (10)
01DE  0A000000           [33] (10)
                         * locals:
01E2  01000000           sizelocvars (1)
01E6  0700000000000000   string size (7)
01EE  61737365727400     "assert\0"
                         local [0]: assert
01F5  01000000             startpc (1)
01F9  20000000             endpc   (32)
                         * upvalues:
01FD  00000000           sizeupvalues (0)
                         ** end of function 0 **

0201                     ** end of chunk **
