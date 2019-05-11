------------------------------
local t = {"a", "b", "c"}
t[2] = "B"
t["foo"] = "Bar"
local s = t[3] .. t[2] .. t[1] .. t["foo"] .. #t
--print(s)

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "t"  ; 0
.local  "s"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
.const  "c"  ; 2
.const  2  ; 3
.const  "B"  ; 4
.const  "foo"  ; 5
.const  "Bar"  ; 6
.const  3  ; 7
.const  1  ; 8
[01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[02] loadk      1   0        ; R1 := "a"
[03] loadk      2   1        ; R2 := "b"
[04] loadk      3   2        ; R3 := "c"
[05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[06] settable   0   259 260  ; R0[2] := "B"
[07] settable   0   261 262  ; R0["foo"] := "Bar"
[08] gettable   1   0   263  ; R1 := R0[3]
[09] gettable   2   0   259  ; R2 := R0[2]
[10] gettable   3   0   264  ; R3 := R0[1]
[11] gettable   4   0   261  ; R4 := R0["foo"]
[12] len        5   0        ; R5 := #R0
[13] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
[14] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "t"  ; 0
.local  "s"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
.const  "c"  ; 2
.const  2  ; 3
.const  "B"  ; 4
.const  "foo"  ; 5
.const  "Bar"  ; 6
.const  3  ; 7
.const  1  ; 8
[01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[02] loadk      1   0        ; R1 := "a"
[03] loadk      2   1        ; R2 := "b"
[04] loadk      3   2        ; R3 := "c"
[05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[06] settable   0   259 260  ; R0[2] := "B"
[07] settable   0   261 262  ; R0["foo"] := "Bar"
[08] gettable   1   0   263  ; R1 := R0[3]
[09] gettable   2   0   259  ; R2 := R0[2]
[10] gettable   3   0   264  ; R3 := R0[1]
[11] gettable   4   0   261  ; R4 := R0["foo"]
[12] len        5   0        ; R5 := #R0
[13] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
[14] return     0   1        ; return 
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
002B  0E000000           sizecode (14)
002F  0A008001           [01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0033  41000000           [02] loadk      1   0        ; R1 := "a"
0037  81400000           [03] loadk      2   1        ; R2 := "b"
003B  C1800000           [04] loadk      3   2        ; R3 := "c"
003F  22408001           [05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
0043  0900C181           [06] settable   0   259 260  ; R0[2] := "B"
0047  0980C182           [07] settable   0   261 262  ; R0["foo"] := "Bar"
004B  46C04100           [08] gettable   1   0   263  ; R1 := R0[3]
004F  86C04000           [09] gettable   2   0   259  ; R2 := R0[2]
0053  C6004200           [10] gettable   3   0   264  ; R3 := R0[1]
0057  06414100           [11] gettable   4   0   261  ; R4 := R0["foo"]
005B  54010000           [12] len        5   0        ; R5 := #R0
005F  55408100           [13] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
0063  1E008000           [14] return     0   1        ; return 
                         * constants:
0067  09000000           sizek (9)
006B  04                 const type 4
006C  0200000000000000   string size (2)
0074  6100               "a\0"
                         const [0]: "a"
0076  04                 const type 4
0077  0200000000000000   string size (2)
007F  6200               "b\0"
                         const [1]: "b"
0081  04                 const type 4
0082  0200000000000000   string size (2)
008A  6300               "c\0"
                         const [2]: "c"
008C  03                 const type 3
008D  0000000000000040   const [3]: (2)
0095  04                 const type 4
0096  0200000000000000   string size (2)
009E  4200               "B\0"
                         const [4]: "B"
00A0  04                 const type 4
00A1  0400000000000000   string size (4)
00A9  666F6F00           "foo\0"
                         const [5]: "foo"
00AD  04                 const type 4
00AE  0400000000000000   string size (4)
00B6  42617200           "Bar\0"
                         const [6]: "Bar"
00BA  03                 const type 3
00BB  0000000000000840   const [7]: (3)
00C3  03                 const type 3
00C4  000000000000F03F   const [8]: (1)
                         * functions:
00CC  00000000           sizep (0)
                         * lines:
00D0  0E000000           sizelineinfo (14)
                         [pc] (line)
00D4  01000000           [01] (1)
00D8  01000000           [02] (1)
00DC  01000000           [03] (1)
00E0  01000000           [04] (1)
00E4  01000000           [05] (1)
00E8  02000000           [06] (2)
00EC  03000000           [07] (3)
00F0  04000000           [08] (4)
00F4  04000000           [09] (4)
00F8  04000000           [10] (4)
00FC  04000000           [11] (4)
0100  04000000           [12] (4)
0104  04000000           [13] (4)
0108  04000000           [14] (4)
                         * locals:
010C  02000000           sizelocvars (2)
0110  0200000000000000   string size (2)
0118  7400               "t\0"
                         local [0]: t
011A  05000000             startpc (5)
011E  0D000000             endpc   (13)
0122  0200000000000000   string size (2)
012A  7300               "s\0"
                         local [1]: s
012C  0D000000             startpc (13)
0130  0D000000             endpc   (13)
                         * upvalues:
0134  00000000           sizeupvalues (0)
                         ** end of function 0 **

0138                     ** end of chunk **
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
002B  0E000000           sizecode (14)
002F  0A008001           [01] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0033  41000000           [02] loadk      1   0        ; R1 := "a"
0037  81400000           [03] loadk      2   1        ; R2 := "b"
003B  C1800000           [04] loadk      3   2        ; R3 := "c"
003F  22408001           [05] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
0043  0900C181           [06] settable   0   259 260  ; R0[2] := "B"
0047  0980C182           [07] settable   0   261 262  ; R0["foo"] := "Bar"
004B  46C04100           [08] gettable   1   0   263  ; R1 := R0[3]
004F  86C04000           [09] gettable   2   0   259  ; R2 := R0[2]
0053  C6004200           [10] gettable   3   0   264  ; R3 := R0[1]
0057  06414100           [11] gettable   4   0   261  ; R4 := R0["foo"]
005B  54010000           [12] len        5   0        ; R5 := #R0
005F  55408100           [13] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
0063  1E008000           [14] return     0   1        ; return 
                         * constants:
0067  09000000           sizek (9)
006B  04                 const type 4
006C  0200000000000000   string size (2)
0074  6100               "a\0"
                         const [0]: "a"
0076  04                 const type 4
0077  0200000000000000   string size (2)
007F  6200               "b\0"
                         const [1]: "b"
0081  04                 const type 4
0082  0200000000000000   string size (2)
008A  6300               "c\0"
                         const [2]: "c"
008C  03                 const type 3
008D  0000000000000040   const [3]: (2)
0095  04                 const type 4
0096  0200000000000000   string size (2)
009E  4200               "B\0"
                         const [4]: "B"
00A0  04                 const type 4
00A1  0400000000000000   string size (4)
00A9  666F6F00           "foo\0"
                         const [5]: "foo"
00AD  04                 const type 4
00AE  0400000000000000   string size (4)
00B6  42617200           "Bar\0"
                         const [6]: "Bar"
00BA  03                 const type 3
00BB  0000000000000840   const [7]: (3)
00C3  03                 const type 3
00C4  000000000000F03F   const [8]: (1)
                         * functions:
00CC  00000000           sizep (0)
                         * lines:
00D0  0E000000           sizelineinfo (14)
                         [pc] (line)
00D4  01000000           [01] (1)
00D8  01000000           [02] (1)
00DC  01000000           [03] (1)
00E0  01000000           [04] (1)
00E4  01000000           [05] (1)
00E8  02000000           [06] (2)
00EC  03000000           [07] (3)
00F0  04000000           [08] (4)
00F4  04000000           [09] (4)
00F8  04000000           [10] (4)
00FC  04000000           [11] (4)
0100  04000000           [12] (4)
0104  04000000           [13] (4)
0108  04000000           [14] (4)
                         * locals:
010C  02000000           sizelocvars (2)
0110  0200000000000000   string size (2)
0118  7400               "t\0"
                         local [0]: t
011A  05000000             startpc (5)
011E  0D000000             endpc   (13)
0122  0200000000000000   string size (2)
012A  7300               "s\0"
                         local [1]: s
012C  0D000000             startpc (13)
0130  0D000000             endpc   (13)
                         * upvalues:
0134  00000000           sizeupvalues (0)
                         ** end of function 0 **

0138                     ** end of chunk **
