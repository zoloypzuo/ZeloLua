------------------------------
function f1() end
function f2(...) end
function f3(...) print(...) end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f1"  ; 0
.const  "f2"  ; 1
.const  "f3"  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f1 := R0
[3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[4] setglobal  0   1        ; f2 := R0
[5] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[6] setglobal  0   2        ; f3 := R0
[7] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 7, 2 stacks
.function  0 0 7 2
.local  "arg"  ; 0
[1] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 3, 3 stacks
.function  0 0 3 3
.local  "arg"  ; 0
.const  "print"  ; 0
[1] getglobal  1   0        ; R1 := print
[2] vararg     2   0        ; R2 to top := ...
[3] call       1   0   1    ;  := R1(R2 to top)
[4] return     0   1        ; return 
; end of function 0_2

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f1"  ; 0
.const  "f2"  ; 1
.const  "f3"  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f1 := R0
[3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[4] setglobal  0   1        ; f2 := R0
[5] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[6] setglobal  0   2        ; f3 := R0
[7] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
[1] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 7, 2 stacks
.function  0 0 7 2
.local  "arg"  ; 0
[1] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 3, 3 stacks
.function  0 0 3 3
.local  "arg"  ; 0
.const  "print"  ; 0
[1] getglobal  1   0        ; R1 := print
[2] vararg     2   0        ; R2 to top := ...
[3] call       1   0   1    ;  := R1(R2 to top)
[4] return     0   1        ; return 
; end of function 0_2

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
002B  07000000           sizecode (7)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f1 := R0
0037  24400000           [3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [4] setglobal  0   1        ; f2 := R0
003F  24800000           [5] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [6] setglobal  0   2        ; f3 := R0
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  03000000           sizek (3)
004F  04                 const type 4
0050  0300000000000000   string size (3)
0058  663100             "f1\0"
                         const [0]: "f1"
005B  04                 const type 4
005C  0300000000000000   string size (3)
0064  663200             "f2\0"
                         const [1]: "f2"
0067  04                 const type 4
0068  0300000000000000   string size (3)
0070  663300             "f3\0"
                         const [2]: "f3"
                         * functions:
0073  03000000           sizep (3)
                         
0077                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0077  0000000000000000   string size (0)
                         source name: (none)
007F  01000000           line defined (1)
0083  01000000           last line defined (1)
0087  00                 nups (0)
0088  00                 numparams (0)
0089  00                 is_vararg (0)
008A  02                 maxstacksize (2)
                         * code:
008B  01000000           sizecode (1)
008F  1E008000           [1] return     0   1        ; return 
                         * constants:
0093  00000000           sizek (0)
                         * functions:
0097  00000000           sizep (0)
                         * lines:
009B  01000000           sizelineinfo (1)
                         [pc] (line)
009F  01000000           [1] (1)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
00AB                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
00AB  0000000000000000   string size (0)
                         source name: (none)
00B3  02000000           line defined (2)
00B7  02000000           last line defined (2)
00BB  00                 nups (0)
00BC  00                 numparams (0)
00BD  07                 is_vararg (7)
00BE  02                 maxstacksize (2)
                         * code:
00BF  01000000           sizecode (1)
00C3  1E008000           [1] return     0   1        ; return 
                         * constants:
00C7  00000000           sizek (0)
                         * functions:
00CB  00000000           sizep (0)
                         * lines:
00CF  01000000           sizelineinfo (1)
                         [pc] (line)
00D3  02000000           [1] (2)
                         * locals:
00D7  01000000           sizelocvars (1)
00DB  0400000000000000   string size (4)
00E3  61726700           "arg\0"
                         local [0]: arg
00E7  00000000             startpc (0)
00EB  00000000             endpc   (0)
                         * upvalues:
00EF  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
00F3                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
00F3  0000000000000000   string size (0)
                         source name: (none)
00FB  03000000           line defined (3)
00FF  03000000           last line defined (3)
0103  00                 nups (0)
0104  00                 numparams (0)
0105  03                 is_vararg (3)
0106  03                 maxstacksize (3)
                         * code:
0107  04000000           sizecode (4)
010B  45000000           [1] getglobal  1   0        ; R1 := print
010F  A5000000           [2] vararg     2   0        ; R2 to top := ...
0113  5C400000           [3] call       1   0   1    ;  := R1(R2 to top)
0117  1E008000           [4] return     0   1        ; return 
                         * constants:
011B  01000000           sizek (1)
011F  04                 const type 4
0120  0600000000000000   string size (6)
0128  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
012E  00000000           sizep (0)
                         * lines:
0132  04000000           sizelineinfo (4)
                         [pc] (line)
0136  03000000           [1] (3)
013A  03000000           [2] (3)
013E  03000000           [3] (3)
0142  03000000           [4] (3)
                         * locals:
0146  01000000           sizelocvars (1)
014A  0400000000000000   string size (4)
0152  61726700           "arg\0"
                         local [0]: arg
0156  00000000             startpc (0)
015A  03000000             endpc   (3)
                         * upvalues:
015E  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         * lines:
0162  07000000           sizelineinfo (7)
                         [pc] (line)
0166  01000000           [1] (1)
016A  01000000           [2] (1)
016E  02000000           [3] (2)
0172  02000000           [4] (2)
0176  03000000           [5] (3)
017A  03000000           [6] (3)
017E  03000000           [7] (3)
                         * locals:
0182  00000000           sizelocvars (0)
                         * upvalues:
0186  00000000           sizeupvalues (0)
                         ** end of function 0 **

018A                     ** end of chunk **
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
002B  07000000           sizecode (7)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; f1 := R0
0037  24400000           [3] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [4] setglobal  0   1        ; f2 := R0
003F  24800000           [5] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [6] setglobal  0   2        ; f3 := R0
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  03000000           sizek (3)
004F  04                 const type 4
0050  0300000000000000   string size (3)
0058  663100             "f1\0"
                         const [0]: "f1"
005B  04                 const type 4
005C  0300000000000000   string size (3)
0064  663200             "f2\0"
                         const [1]: "f2"
0067  04                 const type 4
0068  0300000000000000   string size (3)
0070  663300             "f3\0"
                         const [2]: "f3"
                         * functions:
0073  03000000           sizep (3)
                         
0077                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0077  0000000000000000   string size (0)
                         source name: (none)
007F  01000000           line defined (1)
0083  01000000           last line defined (1)
0087  00                 nups (0)
0088  00                 numparams (0)
0089  00                 is_vararg (0)
008A  02                 maxstacksize (2)
                         * code:
008B  01000000           sizecode (1)
008F  1E008000           [1] return     0   1        ; return 
                         * constants:
0093  00000000           sizek (0)
                         * functions:
0097  00000000           sizep (0)
                         * lines:
009B  01000000           sizelineinfo (1)
                         [pc] (line)
009F  01000000           [1] (1)
                         * locals:
00A3  00000000           sizelocvars (0)
                         * upvalues:
00A7  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
00AB                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
00AB  0000000000000000   string size (0)
                         source name: (none)
00B3  02000000           line defined (2)
00B7  02000000           last line defined (2)
00BB  00                 nups (0)
00BC  00                 numparams (0)
00BD  07                 is_vararg (7)
00BE  02                 maxstacksize (2)
                         * code:
00BF  01000000           sizecode (1)
00C3  1E008000           [1] return     0   1        ; return 
                         * constants:
00C7  00000000           sizek (0)
                         * functions:
00CB  00000000           sizep (0)
                         * lines:
00CF  01000000           sizelineinfo (1)
                         [pc] (line)
00D3  02000000           [1] (2)
                         * locals:
00D7  01000000           sizelocvars (1)
00DB  0400000000000000   string size (4)
00E3  61726700           "arg\0"
                         local [0]: arg
00E7  00000000             startpc (0)
00EB  00000000             endpc   (0)
                         * upvalues:
00EF  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
00F3                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
00F3  0000000000000000   string size (0)
                         source name: (none)
00FB  03000000           line defined (3)
00FF  03000000           last line defined (3)
0103  00                 nups (0)
0104  00                 numparams (0)
0105  03                 is_vararg (3)
0106  03                 maxstacksize (3)
                         * code:
0107  04000000           sizecode (4)
010B  45000000           [1] getglobal  1   0        ; R1 := print
010F  A5000000           [2] vararg     2   0        ; R2 to top := ...
0113  5C400000           [3] call       1   0   1    ;  := R1(R2 to top)
0117  1E008000           [4] return     0   1        ; return 
                         * constants:
011B  01000000           sizek (1)
011F  04                 const type 4
0120  0600000000000000   string size (6)
0128  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
012E  00000000           sizep (0)
                         * lines:
0132  04000000           sizelineinfo (4)
                         [pc] (line)
0136  03000000           [1] (3)
013A  03000000           [2] (3)
013E  03000000           [3] (3)
0142  03000000           [4] (3)
                         * locals:
0146  01000000           sizelocvars (1)
014A  0400000000000000   string size (4)
0152  61726700           "arg\0"
                         local [0]: arg
0156  00000000             startpc (0)
015A  03000000             endpc   (3)
                         * upvalues:
015E  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         * lines:
0162  07000000           sizelineinfo (7)
                         [pc] (line)
0166  01000000           [1] (1)
016A  01000000           [2] (1)
016E  02000000           [3] (2)
0172  02000000           [4] (2)
0176  03000000           [5] (3)
017A  03000000           [6] (3)
017E  03000000           [7] (3)
                         * locals:
0182  00000000           sizelocvars (0)
                         * upvalues:
0186  00000000           sizeupvalues (0)
                         ** end of function 0 **

018A                     ** end of chunk **
