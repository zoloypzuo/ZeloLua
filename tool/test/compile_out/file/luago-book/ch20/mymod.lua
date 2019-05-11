------------------------------
local t = {}
t.foo = function() print("foo") end
t.bar = function() print("bar") end
return t

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "t"  ; 0
.const  "foo"  ; 0
.const  "bar"  ; 1
[1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[3] settable   0   256 1    ; R0["foo"] := R1
[4] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[5] settable   0   257 1    ; R0["bar"] := R1
[6] return     0   2        ; return R0
[7] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "foo"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "foo"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "bar"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "bar"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "t"  ; 0
.const  "foo"  ; 0
.const  "bar"  ; 1
[1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[3] settable   0   256 1    ; R0["foo"] := R1
[4] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[5] settable   0   257 1    ; R0["bar"] := R1
[6] return     0   2        ; return R0
[7] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "foo"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "foo"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "bar"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "bar"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_1

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
002F  0A000000           [1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09400080           [3] settable   0   256 1    ; R0["foo"] := R1
003B  64400000           [4] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
003F  09408080           [5] settable   0   257 1    ; R0["bar"] := R1
0043  1E000001           [6] return     0   2        ; return R0
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  02000000           sizek (2)
004F  04                 const type 4
0050  0400000000000000   string size (4)
0058  666F6F00           "foo\0"
                         const [0]: "foo"
005C  04                 const type 4
005D  0400000000000000   string size (4)
0065  62617200           "bar\0"
                         const [1]: "bar"
                         * functions:
0069  02000000           sizep (2)
                         
006D                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
006D  0000000000000000   string size (0)
                         source name: (none)
0075  02000000           line defined (2)
0079  02000000           last line defined (2)
007D  00                 nups (0)
007E  00                 numparams (0)
007F  00                 is_vararg (0)
0080  02                 maxstacksize (2)
                         * code:
0081  04000000           sizecode (4)
0085  05000000           [1] getglobal  0   0        ; R0 := print
0089  41400000           [2] loadk      1   1        ; R1 := "foo"
008D  1C400001           [3] call       0   2   1    ;  := R0(R1)
0091  1E008000           [4] return     0   1        ; return 
                         * constants:
0095  02000000           sizek (2)
0099  04                 const type 4
009A  0600000000000000   string size (6)
00A2  7072696E7400       "print\0"
                         const [0]: "print"
00A8  04                 const type 4
00A9  0400000000000000   string size (4)
00B1  666F6F00           "foo\0"
                         const [1]: "foo"
                         * functions:
00B5  00000000           sizep (0)
                         * lines:
00B9  04000000           sizelineinfo (4)
                         [pc] (line)
00BD  02000000           [1] (2)
00C1  02000000           [2] (2)
00C5  02000000           [3] (2)
00C9  02000000           [4] (2)
                         * locals:
00CD  00000000           sizelocvars (0)
                         * upvalues:
00D1  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
00D5                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
00D5  0000000000000000   string size (0)
                         source name: (none)
00DD  03000000           line defined (3)
00E1  03000000           last line defined (3)
00E5  00                 nups (0)
00E6  00                 numparams (0)
00E7  00                 is_vararg (0)
00E8  02                 maxstacksize (2)
                         * code:
00E9  04000000           sizecode (4)
00ED  05000000           [1] getglobal  0   0        ; R0 := print
00F1  41400000           [2] loadk      1   1        ; R1 := "bar"
00F5  1C400001           [3] call       0   2   1    ;  := R0(R1)
00F9  1E008000           [4] return     0   1        ; return 
                         * constants:
00FD  02000000           sizek (2)
0101  04                 const type 4
0102  0600000000000000   string size (6)
010A  7072696E7400       "print\0"
                         const [0]: "print"
0110  04                 const type 4
0111  0400000000000000   string size (4)
0119  62617200           "bar\0"
                         const [1]: "bar"
                         * functions:
011D  00000000           sizep (0)
                         * lines:
0121  04000000           sizelineinfo (4)
                         [pc] (line)
0125  03000000           [1] (3)
0129  03000000           [2] (3)
012D  03000000           [3] (3)
0131  03000000           [4] (3)
                         * locals:
0135  00000000           sizelocvars (0)
                         * upvalues:
0139  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
013D  07000000           sizelineinfo (7)
                         [pc] (line)
0141  01000000           [1] (1)
0145  02000000           [2] (2)
0149  02000000           [3] (2)
014D  03000000           [4] (3)
0151  03000000           [5] (3)
0155  04000000           [6] (4)
0159  04000000           [7] (4)
                         * locals:
015D  01000000           sizelocvars (1)
0161  0200000000000000   string size (2)
0169  7400               "t\0"
                         local [0]: t
016B  01000000             startpc (1)
016F  06000000             endpc   (6)
                         * upvalues:
0173  00000000           sizeupvalues (0)
                         ** end of function 0 **

0177                     ** end of chunk **
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
002F  0A000000           [1] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09400080           [3] settable   0   256 1    ; R0["foo"] := R1
003B  64400000           [4] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
003F  09408080           [5] settable   0   257 1    ; R0["bar"] := R1
0043  1E000001           [6] return     0   2        ; return R0
0047  1E008000           [7] return     0   1        ; return 
                         * constants:
004B  02000000           sizek (2)
004F  04                 const type 4
0050  0400000000000000   string size (4)
0058  666F6F00           "foo\0"
                         const [0]: "foo"
005C  04                 const type 4
005D  0400000000000000   string size (4)
0065  62617200           "bar\0"
                         const [1]: "bar"
                         * functions:
0069  02000000           sizep (2)
                         
006D                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
006D  0000000000000000   string size (0)
                         source name: (none)
0075  02000000           line defined (2)
0079  02000000           last line defined (2)
007D  00                 nups (0)
007E  00                 numparams (0)
007F  00                 is_vararg (0)
0080  02                 maxstacksize (2)
                         * code:
0081  04000000           sizecode (4)
0085  05000000           [1] getglobal  0   0        ; R0 := print
0089  41400000           [2] loadk      1   1        ; R1 := "foo"
008D  1C400001           [3] call       0   2   1    ;  := R0(R1)
0091  1E008000           [4] return     0   1        ; return 
                         * constants:
0095  02000000           sizek (2)
0099  04                 const type 4
009A  0600000000000000   string size (6)
00A2  7072696E7400       "print\0"
                         const [0]: "print"
00A8  04                 const type 4
00A9  0400000000000000   string size (4)
00B1  666F6F00           "foo\0"
                         const [1]: "foo"
                         * functions:
00B5  00000000           sizep (0)
                         * lines:
00B9  04000000           sizelineinfo (4)
                         [pc] (line)
00BD  02000000           [1] (2)
00C1  02000000           [2] (2)
00C5  02000000           [3] (2)
00C9  02000000           [4] (2)
                         * locals:
00CD  00000000           sizelocvars (0)
                         * upvalues:
00D1  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
00D5                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
00D5  0000000000000000   string size (0)
                         source name: (none)
00DD  03000000           line defined (3)
00E1  03000000           last line defined (3)
00E5  00                 nups (0)
00E6  00                 numparams (0)
00E7  00                 is_vararg (0)
00E8  02                 maxstacksize (2)
                         * code:
00E9  04000000           sizecode (4)
00ED  05000000           [1] getglobal  0   0        ; R0 := print
00F1  41400000           [2] loadk      1   1        ; R1 := "bar"
00F5  1C400001           [3] call       0   2   1    ;  := R0(R1)
00F9  1E008000           [4] return     0   1        ; return 
                         * constants:
00FD  02000000           sizek (2)
0101  04                 const type 4
0102  0600000000000000   string size (6)
010A  7072696E7400       "print\0"
                         const [0]: "print"
0110  04                 const type 4
0111  0400000000000000   string size (4)
0119  62617200           "bar\0"
                         const [1]: "bar"
                         * functions:
011D  00000000           sizep (0)
                         * lines:
0121  04000000           sizelineinfo (4)
                         [pc] (line)
0125  03000000           [1] (3)
0129  03000000           [2] (3)
012D  03000000           [3] (3)
0131  03000000           [4] (3)
                         * locals:
0135  00000000           sizelocvars (0)
                         * upvalues:
0139  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
013D  07000000           sizelineinfo (7)
                         [pc] (line)
0141  01000000           [1] (1)
0145  02000000           [2] (2)
0149  02000000           [3] (2)
014D  03000000           [4] (3)
0151  03000000           [5] (3)
0155  04000000           [6] (4)
0159  04000000           [7] (4)
                         * locals:
015D  01000000           sizelocvars (1)
0161  0200000000000000   string size (2)
0169  7400               "t\0"
                         local [0]: t
016B  01000000             startpc (1)
016F  06000000             endpc   (6)
                         * upvalues:
0173  00000000           sizeupvalues (0)
                         ** end of function 0 **

0177                     ** end of chunk **
