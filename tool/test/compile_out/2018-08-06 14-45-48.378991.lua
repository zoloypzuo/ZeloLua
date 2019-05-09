------------------------------
function A.B.C.D.f()end
function g()end
function H.I.J.K:h()end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "A"  ; 0
.const  "B"  ; 1
.const  "C"  ; 2
.const  "D"  ; 3
.const  "f"  ; 4
.const  "g"  ; 5
.const  "H"  ; 6
.const  "I"  ; 7
.const  "J"  ; 8
.const  "K"  ; 9
.const  "h"  ; 10
[01] getglobal  0   0        ; R0 := A
[02] gettable   0   0   257  ; R0 := R0["B"]
[03] gettable   0   0   258  ; R0 := R0["C"]
[04] gettable   0   0   259  ; R0 := R0["D"]
[05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[06] settable   0   260 1    ; R0["f"] := R1

[07] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[08] setglobal  0   5        ; g := R0
[09] getglobal  0   6        ; R0 := H

[10] gettable   0   0   263  ; R0 := R0["I"]
[11] gettable   0   0   264  ; R0 := R0["J"]
[12] gettable   0   0   265  ; R0 := R0["K"]
[13] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[14] settable   0   266 1    ; R0["h"] := R1
[15] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "self"  ; 0
[1] return     0   1        ; return 
; end of function 0_2

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
0026  02                 maxstacksize (2)
                         * code:
0027  0F000000           sizecode (15)
002B  05000000           [01] getglobal  0   0        ; R0 := A
002F  06404000           [02] gettable   0   0   257  ; R0 := R0["B"]
0033  06804000           [03] gettable   0   0   258  ; R0 := R0["C"]
0037  06C04000           [04] gettable   0   0   259  ; R0 := R0["D"]
003B  64000000           [05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
003F  09400082           [06] settable   0   260 1    ; R0["f"] := R1
0043  24400000           [07] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
0047  07400100           [08] setglobal  0   5        ; g := R0
004B  05800100           [09] getglobal  0   6        ; R0 := H
004F  06C04100           [10] gettable   0   0   263  ; R0 := R0["I"]
0053  06004200           [11] gettable   0   0   264  ; R0 := R0["J"]
0057  06404200           [12] gettable   0   0   265  ; R0 := R0["K"]
005B  64800000           [13] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
005F  09400085           [14] settable   0   266 1    ; R0["h"] := R1
0063  1E008000           [15] return     0   1        ; return 
                         * constants:
0067  0B000000           sizek (11)
006B  04                 const type 4
006C  02000000           string size (2)
0070  4100               "A\0"
                         const [0]: "A"
0072  04                 const type 4
0073  02000000           string size (2)
0077  4200               "B\0"
                         const [1]: "B"
0079  04                 const type 4
007A  02000000           string size (2)
007E  4300               "C\0"
                         const [2]: "C"
0080  04                 const type 4
0081  02000000           string size (2)
0085  4400               "D\0"
                         const [3]: "D"
0087  04                 const type 4
0088  02000000           string size (2)
008C  6600               "f\0"
                         const [4]: "f"
008E  04                 const type 4
008F  02000000           string size (2)
0093  6700               "g\0"
                         const [5]: "g"
0095  04                 const type 4
0096  02000000           string size (2)
009A  4800               "H\0"
                         const [6]: "H"
009C  04                 const type 4
009D  02000000           string size (2)
00A1  4900               "I\0"
                         const [7]: "I"
00A3  04                 const type 4
00A4  02000000           string size (2)
00A8  4A00               "J\0"
                         const [8]: "J"
00AA  04                 const type 4
00AB  02000000           string size (2)
00AF  4B00               "K\0"
                         const [9]: "K"
00B1  04                 const type 4
00B2  02000000           string size (2)
00B6  6800               "h\0"
                         const [10]: "h"
                         * functions:
00B8  03000000           sizep (3)
                         
00BC                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00BC  00000000           string size (0)
                         source name: (none)
00C0  01000000           line defined (1)
00C4  01000000           last line defined (1)
00C8  00                 nups (0)
00C9  00                 numparams (0)
00CA  00                 is_vararg (0)
00CB  02                 maxstacksize (2)
                         * code:
00CC  01000000           sizecode (1)
00D0  1E008000           [1] return     0   1        ; return 
                         * constants:
00D4  00000000           sizek (0)
                         * functions:
00D8  00000000           sizep (0)
                         * lines:
00DC  01000000           sizelineinfo (1)
                         [pc] (line)
00E0  01000000           [1] (1)
                         * locals:
00E4  00000000           sizelocvars (0)
                         * upvalues:
00E8  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
00EC                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
00EC  00000000           string size (0)
                         source name: (none)
00F0  02000000           line defined (2)
00F4  02000000           last line defined (2)
00F8  00                 nups (0)
00F9  00                 numparams (0)
00FA  00                 is_vararg (0)
00FB  02                 maxstacksize (2)
                         * code:
00FC  01000000           sizecode (1)
0100  1E008000           [1] return     0   1        ; return 
                         * constants:
0104  00000000           sizek (0)
                         * functions:
0108  00000000           sizep (0)
                         * lines:
010C  01000000           sizelineinfo (1)
                         [pc] (line)
0110  02000000           [1] (2)
                         * locals:
0114  00000000           sizelocvars (0)
                         * upvalues:
0118  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
011C                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
011C  00000000           string size (0)
                         source name: (none)
0120  03000000           line defined (3)
0124  03000000           last line defined (3)
0128  00                 nups (0)
0129  01                 numparams (1)
012A  00                 is_vararg (0)
012B  02                 maxstacksize (2)
                         * code:
012C  01000000           sizecode (1)
0130  1E008000           [1] return     0   1        ; return 
                         * constants:
0134  00000000           sizek (0)
                         * functions:
0138  00000000           sizep (0)
                         * lines:
013C  01000000           sizelineinfo (1)
                         [pc] (line)
0140  03000000           [1] (3)
                         * locals:
0144  01000000           sizelocvars (1)
0148  05000000           string size (5)
014C  73656C6600         "self\0"
                         local [0]: self
0151  00000000             startpc (0)
0155  00000000             endpc   (0)
                         * upvalues:
0159  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         * lines:
015D  0F000000           sizelineinfo (15)
                         [pc] (line)
0161  01000000           [01] (1)
0165  01000000           [02] (1)
0169  01000000           [03] (1)
016D  01000000           [04] (1)
0171  01000000           [05] (1)
0175  01000000           [06] (1)
0179  02000000           [07] (2)
017D  02000000           [08] (2)
0181  03000000           [09] (3)
0185  03000000           [10] (3)
0189  03000000           [11] (3)
018D  03000000           [12] (3)
0191  03000000           [13] (3)
0195  03000000           [14] (3)
0199  03000000           [15] (3)
                         * locals:
019D  00000000           sizelocvars (0)
                         * upvalues:
01A1  00000000           sizeupvalues (0)
                         ** end of function 0 **

01A5                     ** end of chunk **
