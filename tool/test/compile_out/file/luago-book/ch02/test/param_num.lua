------------------------------
function f0() end
function f1(a) end
function f2(a, b) end
function f3(a, b, c) end
function g0(...) end
function g1(a, ...) end
function g2(a, b, ...) end
function g3(a, b, c, ...) end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f0"  ; 0
.const  "f1"  ; 1
.const  "f2"  ; 2
.const  "f3"  ; 3
.const  "g0"  ; 4
.const  "g1"  ; 5
.const  "g2"  ; 6
.const  "g3"  ; 7
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; f0 := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; f1 := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   2        ; f2 := R0
[07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[08] setglobal  0   3        ; f3 := R0
[09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[10] setglobal  0   4        ; g0 := R0
[11] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
[12] setglobal  0   5        ; g1 := R0
[13] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
[14] setglobal  0   6        ; g2 := R0
[15] closure    0   7        ; R0 := closure(function[7]) 0 upvalues
[16] setglobal  0   7        ; g3 := R0
[17] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "a"  ; 0
[1] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 2 stacks
.function  0 2 0 2
.local  "a"  ; 0
.local  "b"  ; 1
[1] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 3 params, is_vararg = 0, 3 stacks
.function  0 3 0 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 0 params, is_vararg = 7, 2 stacks
.function  0 0 7 2
.local  "arg"  ; 0
[1] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 1 params, is_vararg = 7, 2 stacks
.function  0 1 7 2
.local  "a"  ; 0
.local  "arg"  ; 1
[1] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 2 params, is_vararg = 7, 3 stacks
.function  0 2 7 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "arg"  ; 2
[1] return     0   1        ; return 
; end of function 0_6


; function [7] definition (level 2) 0_7
; 0 upvalues, 3 params, is_vararg = 7, 4 stacks
.function  0 3 7 4
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "arg"  ; 3
[1] return     0   1        ; return 
; end of function 0_7

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f0"  ; 0
.const  "f1"  ; 1
.const  "f2"  ; 2
.const  "f3"  ; 3
.const  "g0"  ; 4
.const  "g1"  ; 5
.const  "g2"  ; 6
.const  "g3"  ; 7
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; f0 := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; f1 := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   2        ; f2 := R0
[07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[08] setglobal  0   3        ; f3 := R0
[09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[10] setglobal  0   4        ; g0 := R0
[11] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
[12] setglobal  0   5        ; g1 := R0
[13] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
[14] setglobal  0   6        ; g2 := R0
[15] closure    0   7        ; R0 := closure(function[7]) 0 upvalues
[16] setglobal  0   7        ; g3 := R0
[17] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "a"  ; 0
[1] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 2 stacks
.function  0 2 0 2
.local  "a"  ; 0
.local  "b"  ; 1
[1] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 3 params, is_vararg = 0, 3 stacks
.function  0 3 0 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 0 params, is_vararg = 7, 2 stacks
.function  0 0 7 2
.local  "arg"  ; 0
[1] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 1 params, is_vararg = 7, 2 stacks
.function  0 1 7 2
.local  "a"  ; 0
.local  "arg"  ; 1
[1] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 2 params, is_vararg = 7, 3 stacks
.function  0 2 7 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "arg"  ; 2
[1] return     0   1        ; return 
; end of function 0_6


; function [7] definition (level 2) 0_7
; 0 upvalues, 3 params, is_vararg = 7, 4 stacks
.function  0 3 7 4
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "arg"  ; 3
[1] return     0   1        ; return 
; end of function 0_7

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
002B  11000000           sizecode (17)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; f0 := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; f1 := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [06] setglobal  0   2        ; f2 := R0
0047  24C00000           [07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
004B  07C00000           [08] setglobal  0   3        ; f3 := R0
004F  24000100           [09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0053  07000100           [10] setglobal  0   4        ; g0 := R0
0057  24400100           [11] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
005B  07400100           [12] setglobal  0   5        ; g1 := R0
005F  24800100           [13] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
0063  07800100           [14] setglobal  0   6        ; g2 := R0
0067  24C00100           [15] closure    0   7        ; R0 := closure(function[7]) 0 upvalues
006B  07C00100           [16] setglobal  0   7        ; g3 := R0
006F  1E008000           [17] return     0   1        ; return 
                         * constants:
0073  08000000           sizek (8)
0077  04                 const type 4
0078  0300000000000000   string size (3)
0080  663000             "f0\0"
                         const [0]: "f0"
0083  04                 const type 4
0084  0300000000000000   string size (3)
008C  663100             "f1\0"
                         const [1]: "f1"
008F  04                 const type 4
0090  0300000000000000   string size (3)
0098  663200             "f2\0"
                         const [2]: "f2"
009B  04                 const type 4
009C  0300000000000000   string size (3)
00A4  663300             "f3\0"
                         const [3]: "f3"
00A7  04                 const type 4
00A8  0300000000000000   string size (3)
00B0  673000             "g0\0"
                         const [4]: "g0"
00B3  04                 const type 4
00B4  0300000000000000   string size (3)
00BC  673100             "g1\0"
                         const [5]: "g1"
00BF  04                 const type 4
00C0  0300000000000000   string size (3)
00C8  673200             "g2\0"
                         const [6]: "g2"
00CB  04                 const type 4
00CC  0300000000000000   string size (3)
00D4  673300             "g3\0"
                         const [7]: "g3"
                         * functions:
00D7  08000000           sizep (8)
                         
00DB                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00DB  0000000000000000   string size (0)
                         source name: (none)
00E3  01000000           line defined (1)
00E7  01000000           last line defined (1)
00EB  00                 nups (0)
00EC  00                 numparams (0)
00ED  00                 is_vararg (0)
00EE  02                 maxstacksize (2)
                         * code:
00EF  01000000           sizecode (1)
00F3  1E008000           [1] return     0   1        ; return 
                         * constants:
00F7  00000000           sizek (0)
                         * functions:
00FB  00000000           sizep (0)
                         * lines:
00FF  01000000           sizelineinfo (1)
                         [pc] (line)
0103  01000000           [1] (1)
                         * locals:
0107  00000000           sizelocvars (0)
                         * upvalues:
010B  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
010F                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
010F  0000000000000000   string size (0)
                         source name: (none)
0117  02000000           line defined (2)
011B  02000000           last line defined (2)
011F  00                 nups (0)
0120  01                 numparams (1)
0121  00                 is_vararg (0)
0122  02                 maxstacksize (2)
                         * code:
0123  01000000           sizecode (1)
0127  1E008000           [1] return     0   1        ; return 
                         * constants:
012B  00000000           sizek (0)
                         * functions:
012F  00000000           sizep (0)
                         * lines:
0133  01000000           sizelineinfo (1)
                         [pc] (line)
0137  02000000           [1] (2)
                         * locals:
013B  01000000           sizelocvars (1)
013F  0200000000000000   string size (2)
0147  6100               "a\0"
                         local [0]: a
0149  00000000             startpc (0)
014D  00000000             endpc   (0)
                         * upvalues:
0151  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
0155                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
0155  0000000000000000   string size (0)
                         source name: (none)
015D  03000000           line defined (3)
0161  03000000           last line defined (3)
0165  00                 nups (0)
0166  02                 numparams (2)
0167  00                 is_vararg (0)
0168  02                 maxstacksize (2)
                         * code:
0169  01000000           sizecode (1)
016D  1E008000           [1] return     0   1        ; return 
                         * constants:
0171  00000000           sizek (0)
                         * functions:
0175  00000000           sizep (0)
                         * lines:
0179  01000000           sizelineinfo (1)
                         [pc] (line)
017D  03000000           [1] (3)
                         * locals:
0181  02000000           sizelocvars (2)
0185  0200000000000000   string size (2)
018D  6100               "a\0"
                         local [0]: a
018F  00000000             startpc (0)
0193  00000000             endpc   (0)
0197  0200000000000000   string size (2)
019F  6200               "b\0"
                         local [1]: b
01A1  00000000             startpc (0)
01A5  00000000             endpc   (0)
                         * upvalues:
01A9  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
01AD                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
01AD  0000000000000000   string size (0)
                         source name: (none)
01B5  04000000           line defined (4)
01B9  04000000           last line defined (4)
01BD  00                 nups (0)
01BE  03                 numparams (3)
01BF  00                 is_vararg (0)
01C0  03                 maxstacksize (3)
                         * code:
01C1  01000000           sizecode (1)
01C5  1E008000           [1] return     0   1        ; return 
                         * constants:
01C9  00000000           sizek (0)
                         * functions:
01CD  00000000           sizep (0)
                         * lines:
01D1  01000000           sizelineinfo (1)
                         [pc] (line)
01D5  04000000           [1] (4)
                         * locals:
01D9  03000000           sizelocvars (3)
01DD  0200000000000000   string size (2)
01E5  6100               "a\0"
                         local [0]: a
01E7  00000000             startpc (0)
01EB  00000000             endpc   (0)
01EF  0200000000000000   string size (2)
01F7  6200               "b\0"
                         local [1]: b
01F9  00000000             startpc (0)
01FD  00000000             endpc   (0)
0201  0200000000000000   string size (2)
0209  6300               "c\0"
                         local [2]: c
020B  00000000             startpc (0)
020F  00000000             endpc   (0)
                         * upvalues:
0213  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0217                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0217  0000000000000000   string size (0)
                         source name: (none)
021F  05000000           line defined (5)
0223  05000000           last line defined (5)
0227  00                 nups (0)
0228  00                 numparams (0)
0229  07                 is_vararg (7)
022A  02                 maxstacksize (2)
                         * code:
022B  01000000           sizecode (1)
022F  1E008000           [1] return     0   1        ; return 
                         * constants:
0233  00000000           sizek (0)
                         * functions:
0237  00000000           sizep (0)
                         * lines:
023B  01000000           sizelineinfo (1)
                         [pc] (line)
023F  05000000           [1] (5)
                         * locals:
0243  01000000           sizelocvars (1)
0247  0400000000000000   string size (4)
024F  61726700           "arg\0"
                         local [0]: arg
0253  00000000             startpc (0)
0257  00000000             endpc   (0)
                         * upvalues:
025B  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
025F                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
025F  0000000000000000   string size (0)
                         source name: (none)
0267  06000000           line defined (6)
026B  06000000           last line defined (6)
026F  00                 nups (0)
0270  01                 numparams (1)
0271  07                 is_vararg (7)
0272  02                 maxstacksize (2)
                         * code:
0273  01000000           sizecode (1)
0277  1E008000           [1] return     0   1        ; return 
                         * constants:
027B  00000000           sizek (0)
                         * functions:
027F  00000000           sizep (0)
                         * lines:
0283  01000000           sizelineinfo (1)
                         [pc] (line)
0287  06000000           [1] (6)
                         * locals:
028B  02000000           sizelocvars (2)
028F  0200000000000000   string size (2)
0297  6100               "a\0"
                         local [0]: a
0299  00000000             startpc (0)
029D  00000000             endpc   (0)
02A1  0400000000000000   string size (4)
02A9  61726700           "arg\0"
                         local [1]: arg
02AD  00000000             startpc (0)
02B1  00000000             endpc   (0)
                         * upvalues:
02B5  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
02B9                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
02B9  0000000000000000   string size (0)
                         source name: (none)
02C1  07000000           line defined (7)
02C5  07000000           last line defined (7)
02C9  00                 nups (0)
02CA  02                 numparams (2)
02CB  07                 is_vararg (7)
02CC  03                 maxstacksize (3)
                         * code:
02CD  01000000           sizecode (1)
02D1  1E008000           [1] return     0   1        ; return 
                         * constants:
02D5  00000000           sizek (0)
                         * functions:
02D9  00000000           sizep (0)
                         * lines:
02DD  01000000           sizelineinfo (1)
                         [pc] (line)
02E1  07000000           [1] (7)
                         * locals:
02E5  03000000           sizelocvars (3)
02E9  0200000000000000   string size (2)
02F1  6100               "a\0"
                         local [0]: a
02F3  00000000             startpc (0)
02F7  00000000             endpc   (0)
02FB  0200000000000000   string size (2)
0303  6200               "b\0"
                         local [1]: b
0305  00000000             startpc (0)
0309  00000000             endpc   (0)
030D  0400000000000000   string size (4)
0315  61726700           "arg\0"
                         local [2]: arg
0319  00000000             startpc (0)
031D  00000000             endpc   (0)
                         * upvalues:
0321  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         
0325                     ** function [7] definition (level 2) 0_7
                         ** start of function 0_7 **
0325  0000000000000000   string size (0)
                         source name: (none)
032D  08000000           line defined (8)
0331  08000000           last line defined (8)
0335  00                 nups (0)
0336  03                 numparams (3)
0337  07                 is_vararg (7)
0338  04                 maxstacksize (4)
                         * code:
0339  01000000           sizecode (1)
033D  1E008000           [1] return     0   1        ; return 
                         * constants:
0341  00000000           sizek (0)
                         * functions:
0345  00000000           sizep (0)
                         * lines:
0349  01000000           sizelineinfo (1)
                         [pc] (line)
034D  08000000           [1] (8)
                         * locals:
0351  04000000           sizelocvars (4)
0355  0200000000000000   string size (2)
035D  6100               "a\0"
                         local [0]: a
035F  00000000             startpc (0)
0363  00000000             endpc   (0)
0367  0200000000000000   string size (2)
036F  6200               "b\0"
                         local [1]: b
0371  00000000             startpc (0)
0375  00000000             endpc   (0)
0379  0200000000000000   string size (2)
0381  6300               "c\0"
                         local [2]: c
0383  00000000             startpc (0)
0387  00000000             endpc   (0)
038B  0400000000000000   string size (4)
0393  61726700           "arg\0"
                         local [3]: arg
0397  00000000             startpc (0)
039B  00000000             endpc   (0)
                         * upvalues:
039F  00000000           sizeupvalues (0)
                         ** end of function 0_7 **

                         * lines:
03A3  11000000           sizelineinfo (17)
                         [pc] (line)
03A7  01000000           [01] (1)
03AB  01000000           [02] (1)
03AF  02000000           [03] (2)
03B3  02000000           [04] (2)
03B7  03000000           [05] (3)
03BB  03000000           [06] (3)
03BF  04000000           [07] (4)
03C3  04000000           [08] (4)
03C7  05000000           [09] (5)
03CB  05000000           [10] (5)
03CF  06000000           [11] (6)
03D3  06000000           [12] (6)
03D7  07000000           [13] (7)
03DB  07000000           [14] (7)
03DF  08000000           [15] (8)
03E3  08000000           [16] (8)
03E7  08000000           [17] (8)
                         * locals:
03EB  00000000           sizelocvars (0)
                         * upvalues:
03EF  00000000           sizeupvalues (0)
                         ** end of function 0 **

03F3                     ** end of chunk **
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
002B  11000000           sizecode (17)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; f0 := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; f1 := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [06] setglobal  0   2        ; f2 := R0
0047  24C00000           [07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
004B  07C00000           [08] setglobal  0   3        ; f3 := R0
004F  24000100           [09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0053  07000100           [10] setglobal  0   4        ; g0 := R0
0057  24400100           [11] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
005B  07400100           [12] setglobal  0   5        ; g1 := R0
005F  24800100           [13] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
0063  07800100           [14] setglobal  0   6        ; g2 := R0
0067  24C00100           [15] closure    0   7        ; R0 := closure(function[7]) 0 upvalues
006B  07C00100           [16] setglobal  0   7        ; g3 := R0
006F  1E008000           [17] return     0   1        ; return 
                         * constants:
0073  08000000           sizek (8)
0077  04                 const type 4
0078  0300000000000000   string size (3)
0080  663000             "f0\0"
                         const [0]: "f0"
0083  04                 const type 4
0084  0300000000000000   string size (3)
008C  663100             "f1\0"
                         const [1]: "f1"
008F  04                 const type 4
0090  0300000000000000   string size (3)
0098  663200             "f2\0"
                         const [2]: "f2"
009B  04                 const type 4
009C  0300000000000000   string size (3)
00A4  663300             "f3\0"
                         const [3]: "f3"
00A7  04                 const type 4
00A8  0300000000000000   string size (3)
00B0  673000             "g0\0"
                         const [4]: "g0"
00B3  04                 const type 4
00B4  0300000000000000   string size (3)
00BC  673100             "g1\0"
                         const [5]: "g1"
00BF  04                 const type 4
00C0  0300000000000000   string size (3)
00C8  673200             "g2\0"
                         const [6]: "g2"
00CB  04                 const type 4
00CC  0300000000000000   string size (3)
00D4  673300             "g3\0"
                         const [7]: "g3"
                         * functions:
00D7  08000000           sizep (8)
                         
00DB                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00DB  0000000000000000   string size (0)
                         source name: (none)
00E3  01000000           line defined (1)
00E7  01000000           last line defined (1)
00EB  00                 nups (0)
00EC  00                 numparams (0)
00ED  00                 is_vararg (0)
00EE  02                 maxstacksize (2)
                         * code:
00EF  01000000           sizecode (1)
00F3  1E008000           [1] return     0   1        ; return 
                         * constants:
00F7  00000000           sizek (0)
                         * functions:
00FB  00000000           sizep (0)
                         * lines:
00FF  01000000           sizelineinfo (1)
                         [pc] (line)
0103  01000000           [1] (1)
                         * locals:
0107  00000000           sizelocvars (0)
                         * upvalues:
010B  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
010F                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
010F  0000000000000000   string size (0)
                         source name: (none)
0117  02000000           line defined (2)
011B  02000000           last line defined (2)
011F  00                 nups (0)
0120  01                 numparams (1)
0121  00                 is_vararg (0)
0122  02                 maxstacksize (2)
                         * code:
0123  01000000           sizecode (1)
0127  1E008000           [1] return     0   1        ; return 
                         * constants:
012B  00000000           sizek (0)
                         * functions:
012F  00000000           sizep (0)
                         * lines:
0133  01000000           sizelineinfo (1)
                         [pc] (line)
0137  02000000           [1] (2)
                         * locals:
013B  01000000           sizelocvars (1)
013F  0200000000000000   string size (2)
0147  6100               "a\0"
                         local [0]: a
0149  00000000             startpc (0)
014D  00000000             endpc   (0)
                         * upvalues:
0151  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
0155                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
0155  0000000000000000   string size (0)
                         source name: (none)
015D  03000000           line defined (3)
0161  03000000           last line defined (3)
0165  00                 nups (0)
0166  02                 numparams (2)
0167  00                 is_vararg (0)
0168  02                 maxstacksize (2)
                         * code:
0169  01000000           sizecode (1)
016D  1E008000           [1] return     0   1        ; return 
                         * constants:
0171  00000000           sizek (0)
                         * functions:
0175  00000000           sizep (0)
                         * lines:
0179  01000000           sizelineinfo (1)
                         [pc] (line)
017D  03000000           [1] (3)
                         * locals:
0181  02000000           sizelocvars (2)
0185  0200000000000000   string size (2)
018D  6100               "a\0"
                         local [0]: a
018F  00000000             startpc (0)
0193  00000000             endpc   (0)
0197  0200000000000000   string size (2)
019F  6200               "b\0"
                         local [1]: b
01A1  00000000             startpc (0)
01A5  00000000             endpc   (0)
                         * upvalues:
01A9  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
01AD                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
01AD  0000000000000000   string size (0)
                         source name: (none)
01B5  04000000           line defined (4)
01B9  04000000           last line defined (4)
01BD  00                 nups (0)
01BE  03                 numparams (3)
01BF  00                 is_vararg (0)
01C0  03                 maxstacksize (3)
                         * code:
01C1  01000000           sizecode (1)
01C5  1E008000           [1] return     0   1        ; return 
                         * constants:
01C9  00000000           sizek (0)
                         * functions:
01CD  00000000           sizep (0)
                         * lines:
01D1  01000000           sizelineinfo (1)
                         [pc] (line)
01D5  04000000           [1] (4)
                         * locals:
01D9  03000000           sizelocvars (3)
01DD  0200000000000000   string size (2)
01E5  6100               "a\0"
                         local [0]: a
01E7  00000000             startpc (0)
01EB  00000000             endpc   (0)
01EF  0200000000000000   string size (2)
01F7  6200               "b\0"
                         local [1]: b
01F9  00000000             startpc (0)
01FD  00000000             endpc   (0)
0201  0200000000000000   string size (2)
0209  6300               "c\0"
                         local [2]: c
020B  00000000             startpc (0)
020F  00000000             endpc   (0)
                         * upvalues:
0213  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0217                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0217  0000000000000000   string size (0)
                         source name: (none)
021F  05000000           line defined (5)
0223  05000000           last line defined (5)
0227  00                 nups (0)
0228  00                 numparams (0)
0229  07                 is_vararg (7)
022A  02                 maxstacksize (2)
                         * code:
022B  01000000           sizecode (1)
022F  1E008000           [1] return     0   1        ; return 
                         * constants:
0233  00000000           sizek (0)
                         * functions:
0237  00000000           sizep (0)
                         * lines:
023B  01000000           sizelineinfo (1)
                         [pc] (line)
023F  05000000           [1] (5)
                         * locals:
0243  01000000           sizelocvars (1)
0247  0400000000000000   string size (4)
024F  61726700           "arg\0"
                         local [0]: arg
0253  00000000             startpc (0)
0257  00000000             endpc   (0)
                         * upvalues:
025B  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
025F                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
025F  0000000000000000   string size (0)
                         source name: (none)
0267  06000000           line defined (6)
026B  06000000           last line defined (6)
026F  00                 nups (0)
0270  01                 numparams (1)
0271  07                 is_vararg (7)
0272  02                 maxstacksize (2)
                         * code:
0273  01000000           sizecode (1)
0277  1E008000           [1] return     0   1        ; return 
                         * constants:
027B  00000000           sizek (0)
                         * functions:
027F  00000000           sizep (0)
                         * lines:
0283  01000000           sizelineinfo (1)
                         [pc] (line)
0287  06000000           [1] (6)
                         * locals:
028B  02000000           sizelocvars (2)
028F  0200000000000000   string size (2)
0297  6100               "a\0"
                         local [0]: a
0299  00000000             startpc (0)
029D  00000000             endpc   (0)
02A1  0400000000000000   string size (4)
02A9  61726700           "arg\0"
                         local [1]: arg
02AD  00000000             startpc (0)
02B1  00000000             endpc   (0)
                         * upvalues:
02B5  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
02B9                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
02B9  0000000000000000   string size (0)
                         source name: (none)
02C1  07000000           line defined (7)
02C5  07000000           last line defined (7)
02C9  00                 nups (0)
02CA  02                 numparams (2)
02CB  07                 is_vararg (7)
02CC  03                 maxstacksize (3)
                         * code:
02CD  01000000           sizecode (1)
02D1  1E008000           [1] return     0   1        ; return 
                         * constants:
02D5  00000000           sizek (0)
                         * functions:
02D9  00000000           sizep (0)
                         * lines:
02DD  01000000           sizelineinfo (1)
                         [pc] (line)
02E1  07000000           [1] (7)
                         * locals:
02E5  03000000           sizelocvars (3)
02E9  0200000000000000   string size (2)
02F1  6100               "a\0"
                         local [0]: a
02F3  00000000             startpc (0)
02F7  00000000             endpc   (0)
02FB  0200000000000000   string size (2)
0303  6200               "b\0"
                         local [1]: b
0305  00000000             startpc (0)
0309  00000000             endpc   (0)
030D  0400000000000000   string size (4)
0315  61726700           "arg\0"
                         local [2]: arg
0319  00000000             startpc (0)
031D  00000000             endpc   (0)
                         * upvalues:
0321  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         
0325                     ** function [7] definition (level 2) 0_7
                         ** start of function 0_7 **
0325  0000000000000000   string size (0)
                         source name: (none)
032D  08000000           line defined (8)
0331  08000000           last line defined (8)
0335  00                 nups (0)
0336  03                 numparams (3)
0337  07                 is_vararg (7)
0338  04                 maxstacksize (4)
                         * code:
0339  01000000           sizecode (1)
033D  1E008000           [1] return     0   1        ; return 
                         * constants:
0341  00000000           sizek (0)
                         * functions:
0345  00000000           sizep (0)
                         * lines:
0349  01000000           sizelineinfo (1)
                         [pc] (line)
034D  08000000           [1] (8)
                         * locals:
0351  04000000           sizelocvars (4)
0355  0200000000000000   string size (2)
035D  6100               "a\0"
                         local [0]: a
035F  00000000             startpc (0)
0363  00000000             endpc   (0)
0367  0200000000000000   string size (2)
036F  6200               "b\0"
                         local [1]: b
0371  00000000             startpc (0)
0375  00000000             endpc   (0)
0379  0200000000000000   string size (2)
0381  6300               "c\0"
                         local [2]: c
0383  00000000             startpc (0)
0387  00000000             endpc   (0)
038B  0400000000000000   string size (4)
0393  61726700           "arg\0"
                         local [3]: arg
0397  00000000             startpc (0)
039B  00000000             endpc   (0)
                         * upvalues:
039F  00000000           sizeupvalues (0)
                         ** end of function 0_7 **

                         * lines:
03A3  11000000           sizelineinfo (17)
                         [pc] (line)
03A7  01000000           [01] (1)
03AB  01000000           [02] (1)
03AF  02000000           [03] (2)
03B3  02000000           [04] (2)
03B7  03000000           [05] (3)
03BB  03000000           [06] (3)
03BF  04000000           [07] (4)
03C3  04000000           [08] (4)
03C7  05000000           [09] (5)
03CB  05000000           [10] (5)
03CF  06000000           [11] (6)
03D3  06000000           [12] (6)
03D7  07000000           [13] (7)
03DB  07000000           [14] (7)
03DF  08000000           [15] (8)
03E3  08000000           [16] (8)
03E7  08000000           [17] (8)
                         * locals:
03EB  00000000           sizelocvars (0)
                         * upvalues:
03EF  00000000           sizeupvalues (0)
                         ** end of function 0 **

03F3                     ** end of chunk **
