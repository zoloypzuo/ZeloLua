------------------------------
function newCounter ()
  local count = 0
  return function () -- anonymous function
    count = count + 1
    return count
  end
end

c1 = newCounter()
print(c1()) --> 1
print(c1()) --> 2

c2 = newCounter()
print(c2()) --> 1
print(c1()) --> 3
print(c2()) --> 2
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "newCounter"  ; 0
.const  "c1"  ; 1
.const  "print"  ; 2
.const  "c2"  ; 3
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; newCounter := R0
[03] getglobal  0   0        ; R0 := newCounter
[04] call       0   1   2    ; R0 := R0()
[05] setglobal  0   1        ; c1 := R0
[06] getglobal  0   2        ; R0 := print
[07] getglobal  1   1        ; R1 := c1
[08] call       1   1   0    ; R1 to top := R1()
[09] call       0   0   1    ;  := R0(R1 to top)
[10] getglobal  0   2        ; R0 := print
[11] getglobal  1   1        ; R1 := c1
[12] call       1   1   0    ; R1 to top := R1()
[13] call       0   0   1    ;  := R0(R1 to top)
[14] getglobal  0   0        ; R0 := newCounter
[15] call       0   1   2    ; R0 := R0()
[16] setglobal  0   3        ; c2 := R0
[17] getglobal  0   2        ; R0 := print
[18] getglobal  1   3        ; R1 := c2
[19] call       1   1   0    ; R1 to top := R1()
[20] call       0   0   1    ;  := R0(R1 to top)
[21] getglobal  0   2        ; R0 := print
[22] getglobal  1   1        ; R1 := c1
[23] call       1   1   0    ; R1 to top := R1()
[24] call       0   0   1    ;  := R0(R1 to top)
[25] getglobal  0   2        ; R0 := print
[26] getglobal  1   3        ; R1 := c2
[27] call       1   1   0    ; R1 to top := R1()
[28] call       0   0   1    ;  := R0(R1 to top)
[29] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "count"  ; 0
.const  0  ; 0
[1] loadk      0   0        ; R0 := 0
[2] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
[3] move       0   0        ; R0 := R0
[4] return     1   2        ; return R1
[5] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.upvalue  "count"  ; 0
.const  1  ; 0
[1] getupval   0   0        ; R0 := U0 , count
[2] add        0   0   256  ; R0 := R0 + 1
[3] setupval   0   0        ; U0 := R0 , count
[4] getupval   0   0        ; R0 := U0 , count
[5] return     0   2        ; return R0
[6] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "newCounter"  ; 0
.const  "c1"  ; 1
.const  "print"  ; 2
.const  "c2"  ; 3
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; newCounter := R0
[03] getglobal  0   0        ; R0 := newCounter
[04] call       0   1   2    ; R0 := R0()
[05] setglobal  0   1        ; c1 := R0
[06] getglobal  0   2        ; R0 := print
[07] getglobal  1   1        ; R1 := c1
[08] call       1   1   0    ; R1 to top := R1()
[09] call       0   0   1    ;  := R0(R1 to top)
[10] getglobal  0   2        ; R0 := print
[11] getglobal  1   1        ; R1 := c1
[12] call       1   1   0    ; R1 to top := R1()
[13] call       0   0   1    ;  := R0(R1 to top)
[14] getglobal  0   0        ; R0 := newCounter
[15] call       0   1   2    ; R0 := R0()
[16] setglobal  0   3        ; c2 := R0
[17] getglobal  0   2        ; R0 := print
[18] getglobal  1   3        ; R1 := c2
[19] call       1   1   0    ; R1 to top := R1()
[20] call       0   0   1    ;  := R0(R1 to top)
[21] getglobal  0   2        ; R0 := print
[22] getglobal  1   1        ; R1 := c1
[23] call       1   1   0    ; R1 to top := R1()
[24] call       0   0   1    ;  := R0(R1 to top)
[25] getglobal  0   2        ; R0 := print
[26] getglobal  1   3        ; R1 := c2
[27] call       1   1   0    ; R1 to top := R1()
[28] call       0   0   1    ;  := R0(R1 to top)
[29] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "count"  ; 0
.const  0  ; 0
[1] loadk      0   0        ; R0 := 0
[2] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
[3] move       0   0        ; R0 := R0
[4] return     1   2        ; return R1
[5] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 1 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  1 0 0 2
.upvalue  "count"  ; 0
.const  1  ; 0
[1] getupval   0   0        ; R0 := U0 , count
[2] add        0   0   256  ; R0 := R0 + 1
[3] setupval   0   0        ; U0 := R0 , count
[4] getupval   0   0        ; R0 := U0 , count
[5] return     0   2        ; return R0
[6] return     0   1        ; return 
; end of function 0_0_0

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
002A  02                 maxstacksize (2)
                         * code:
002B  1D000000           sizecode (29)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; newCounter := R0
0037  05000000           [03] getglobal  0   0        ; R0 := newCounter
003B  1C808000           [04] call       0   1   2    ; R0 := R0()
003F  07400000           [05] setglobal  0   1        ; c1 := R0
0043  05800000           [06] getglobal  0   2        ; R0 := print
0047  45400000           [07] getglobal  1   1        ; R1 := c1
004B  5C008000           [08] call       1   1   0    ; R1 to top := R1()
004F  1C400000           [09] call       0   0   1    ;  := R0(R1 to top)
0053  05800000           [10] getglobal  0   2        ; R0 := print
0057  45400000           [11] getglobal  1   1        ; R1 := c1
005B  5C008000           [12] call       1   1   0    ; R1 to top := R1()
005F  1C400000           [13] call       0   0   1    ;  := R0(R1 to top)
0063  05000000           [14] getglobal  0   0        ; R0 := newCounter
0067  1C808000           [15] call       0   1   2    ; R0 := R0()
006B  07C00000           [16] setglobal  0   3        ; c2 := R0
006F  05800000           [17] getglobal  0   2        ; R0 := print
0073  45C00000           [18] getglobal  1   3        ; R1 := c2
0077  5C008000           [19] call       1   1   0    ; R1 to top := R1()
007B  1C400000           [20] call       0   0   1    ;  := R0(R1 to top)
007F  05800000           [21] getglobal  0   2        ; R0 := print
0083  45400000           [22] getglobal  1   1        ; R1 := c1
0087  5C008000           [23] call       1   1   0    ; R1 to top := R1()
008B  1C400000           [24] call       0   0   1    ;  := R0(R1 to top)
008F  05800000           [25] getglobal  0   2        ; R0 := print
0093  45C00000           [26] getglobal  1   3        ; R1 := c2
0097  5C008000           [27] call       1   1   0    ; R1 to top := R1()
009B  1C400000           [28] call       0   0   1    ;  := R0(R1 to top)
009F  1E008000           [29] return     0   1        ; return 
                         * constants:
00A3  04000000           sizek (4)
00A7  04                 const type 4
00A8  0B00000000000000   string size (11)
00B0  6E6577436F756E74+  "newCount"
00B8  657200             "er\0"
                         const [0]: "newCounter"
00BB  04                 const type 4
00BC  0300000000000000   string size (3)
00C4  633100             "c1\0"
                         const [1]: "c1"
00C7  04                 const type 4
00C8  0600000000000000   string size (6)
00D0  7072696E7400       "print\0"
                         const [2]: "print"
00D6  04                 const type 4
00D7  0300000000000000   string size (3)
00DF  633200             "c2\0"
                         const [3]: "c2"
                         * functions:
00E2  01000000           sizep (1)
                         
00E6                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E6  0000000000000000   string size (0)
                         source name: (none)
00EE  01000000           line defined (1)
00F2  07000000           last line defined (7)
00F6  00                 nups (0)
00F7  00                 numparams (0)
00F8  00                 is_vararg (0)
00F9  02                 maxstacksize (2)
                         * code:
00FA  05000000           sizecode (5)
00FE  01000000           [1] loadk      0   0        ; R0 := 0
0102  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
0106  00000000           [3] move       0   0        ; R0 := R0
010A  5E000001           [4] return     1   2        ; return R1
010E  1E008000           [5] return     0   1        ; return 
                         * constants:
0112  01000000           sizek (1)
0116  03                 const type 3
0117  0000000000000000   const [0]: (0)
                         * functions:
011F  01000000           sizep (1)
                         
0123                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0123  0000000000000000   string size (0)
                         source name: (none)
012B  03000000           line defined (3)
012F  06000000           last line defined (6)
0133  01                 nups (1)
0134  00                 numparams (0)
0135  00                 is_vararg (0)
0136  02                 maxstacksize (2)
                         * code:
0137  06000000           sizecode (6)
013B  04000000           [1] getupval   0   0        ; R0 := U0 , count
013F  0C004000           [2] add        0   0   256  ; R0 := R0 + 1
0143  08000000           [3] setupval   0   0        ; U0 := R0 , count
0147  04000000           [4] getupval   0   0        ; R0 := U0 , count
014B  1E000001           [5] return     0   2        ; return R0
014F  1E008000           [6] return     0   1        ; return 
                         * constants:
0153  01000000           sizek (1)
0157  03                 const type 3
0158  000000000000F03F   const [0]: (1)
                         * functions:
0160  00000000           sizep (0)
                         * lines:
0164  06000000           sizelineinfo (6)
                         [pc] (line)
0168  04000000           [1] (4)
016C  04000000           [2] (4)
0170  04000000           [3] (4)
0174  05000000           [4] (5)
0178  05000000           [5] (5)
017C  06000000           [6] (6)
                         * locals:
0180  00000000           sizelocvars (0)
                         * upvalues:
0184  01000000           sizeupvalues (1)
0188  0600000000000000   string size (6)
0190  636F756E7400       "count\0"
                         upvalue [0]: count
                         ** end of function 0_0_0 **

                         * lines:
0196  05000000           sizelineinfo (5)
                         [pc] (line)
019A  02000000           [1] (2)
019E  06000000           [2] (6)
01A2  06000000           [3] (6)
01A6  06000000           [4] (6)
01AA  07000000           [5] (7)
                         * locals:
01AE  01000000           sizelocvars (1)
01B2  0600000000000000   string size (6)
01BA  636F756E7400       "count\0"
                         local [0]: count
01C0  01000000             startpc (1)
01C4  04000000             endpc   (4)
                         * upvalues:
01C8  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
01CC  1D000000           sizelineinfo (29)
                         [pc] (line)
01D0  07000000           [01] (7)
01D4  01000000           [02] (1)
01D8  09000000           [03] (9)
01DC  09000000           [04] (9)
01E0  09000000           [05] (9)
01E4  0A000000           [06] (10)
01E8  0A000000           [07] (10)
01EC  0A000000           [08] (10)
01F0  0A000000           [09] (10)
01F4  0B000000           [10] (11)
01F8  0B000000           [11] (11)
01FC  0B000000           [12] (11)
0200  0B000000           [13] (11)
0204  0D000000           [14] (13)
0208  0D000000           [15] (13)
020C  0D000000           [16] (13)
0210  0E000000           [17] (14)
0214  0E000000           [18] (14)
0218  0E000000           [19] (14)
021C  0E000000           [20] (14)
0220  0F000000           [21] (15)
0224  0F000000           [22] (15)
0228  0F000000           [23] (15)
022C  0F000000           [24] (15)
0230  10000000           [25] (16)
0234  10000000           [26] (16)
0238  10000000           [27] (16)
023C  10000000           [28] (16)
0240  10000000           [29] (16)
                         * locals:
0244  00000000           sizelocvars (0)
                         * upvalues:
0248  00000000           sizeupvalues (0)
                         ** end of function 0 **

024C                     ** end of chunk **
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
002B  1D000000           sizecode (29)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; newCounter := R0
0037  05000000           [03] getglobal  0   0        ; R0 := newCounter
003B  1C808000           [04] call       0   1   2    ; R0 := R0()
003F  07400000           [05] setglobal  0   1        ; c1 := R0
0043  05800000           [06] getglobal  0   2        ; R0 := print
0047  45400000           [07] getglobal  1   1        ; R1 := c1
004B  5C008000           [08] call       1   1   0    ; R1 to top := R1()
004F  1C400000           [09] call       0   0   1    ;  := R0(R1 to top)
0053  05800000           [10] getglobal  0   2        ; R0 := print
0057  45400000           [11] getglobal  1   1        ; R1 := c1
005B  5C008000           [12] call       1   1   0    ; R1 to top := R1()
005F  1C400000           [13] call       0   0   1    ;  := R0(R1 to top)
0063  05000000           [14] getglobal  0   0        ; R0 := newCounter
0067  1C808000           [15] call       0   1   2    ; R0 := R0()
006B  07C00000           [16] setglobal  0   3        ; c2 := R0
006F  05800000           [17] getglobal  0   2        ; R0 := print
0073  45C00000           [18] getglobal  1   3        ; R1 := c2
0077  5C008000           [19] call       1   1   0    ; R1 to top := R1()
007B  1C400000           [20] call       0   0   1    ;  := R0(R1 to top)
007F  05800000           [21] getglobal  0   2        ; R0 := print
0083  45400000           [22] getglobal  1   1        ; R1 := c1
0087  5C008000           [23] call       1   1   0    ; R1 to top := R1()
008B  1C400000           [24] call       0   0   1    ;  := R0(R1 to top)
008F  05800000           [25] getglobal  0   2        ; R0 := print
0093  45C00000           [26] getglobal  1   3        ; R1 := c2
0097  5C008000           [27] call       1   1   0    ; R1 to top := R1()
009B  1C400000           [28] call       0   0   1    ;  := R0(R1 to top)
009F  1E008000           [29] return     0   1        ; return 
                         * constants:
00A3  04000000           sizek (4)
00A7  04                 const type 4
00A8  0B00000000000000   string size (11)
00B0  6E6577436F756E74+  "newCount"
00B8  657200             "er\0"
                         const [0]: "newCounter"
00BB  04                 const type 4
00BC  0300000000000000   string size (3)
00C4  633100             "c1\0"
                         const [1]: "c1"
00C7  04                 const type 4
00C8  0600000000000000   string size (6)
00D0  7072696E7400       "print\0"
                         const [2]: "print"
00D6  04                 const type 4
00D7  0300000000000000   string size (3)
00DF  633200             "c2\0"
                         const [3]: "c2"
                         * functions:
00E2  01000000           sizep (1)
                         
00E6                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E6  0000000000000000   string size (0)
                         source name: (none)
00EE  01000000           line defined (1)
00F2  07000000           last line defined (7)
00F6  00                 nups (0)
00F7  00                 numparams (0)
00F8  00                 is_vararg (0)
00F9  02                 maxstacksize (2)
                         * code:
00FA  05000000           sizecode (5)
00FE  01000000           [1] loadk      0   0        ; R0 := 0
0102  64000000           [2] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
0106  00000000           [3] move       0   0        ; R0 := R0
010A  5E000001           [4] return     1   2        ; return R1
010E  1E008000           [5] return     0   1        ; return 
                         * constants:
0112  01000000           sizek (1)
0116  03                 const type 3
0117  0000000000000000   const [0]: (0)
                         * functions:
011F  01000000           sizep (1)
                         
0123                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0123  0000000000000000   string size (0)
                         source name: (none)
012B  03000000           line defined (3)
012F  06000000           last line defined (6)
0133  01                 nups (1)
0134  00                 numparams (0)
0135  00                 is_vararg (0)
0136  02                 maxstacksize (2)
                         * code:
0137  06000000           sizecode (6)
013B  04000000           [1] getupval   0   0        ; R0 := U0 , count
013F  0C004000           [2] add        0   0   256  ; R0 := R0 + 1
0143  08000000           [3] setupval   0   0        ; U0 := R0 , count
0147  04000000           [4] getupval   0   0        ; R0 := U0 , count
014B  1E000001           [5] return     0   2        ; return R0
014F  1E008000           [6] return     0   1        ; return 
                         * constants:
0153  01000000           sizek (1)
0157  03                 const type 3
0158  000000000000F03F   const [0]: (1)
                         * functions:
0160  00000000           sizep (0)
                         * lines:
0164  06000000           sizelineinfo (6)
                         [pc] (line)
0168  04000000           [1] (4)
016C  04000000           [2] (4)
0170  04000000           [3] (4)
0174  05000000           [4] (5)
0178  05000000           [5] (5)
017C  06000000           [6] (6)
                         * locals:
0180  00000000           sizelocvars (0)
                         * upvalues:
0184  01000000           sizeupvalues (1)
0188  0600000000000000   string size (6)
0190  636F756E7400       "count\0"
                         upvalue [0]: count
                         ** end of function 0_0_0 **

                         * lines:
0196  05000000           sizelineinfo (5)
                         [pc] (line)
019A  02000000           [1] (2)
019E  06000000           [2] (6)
01A2  06000000           [3] (6)
01A6  06000000           [4] (6)
01AA  07000000           [5] (7)
                         * locals:
01AE  01000000           sizelocvars (1)
01B2  0600000000000000   string size (6)
01BA  636F756E7400       "count\0"
                         local [0]: count
01C0  01000000             startpc (1)
01C4  04000000             endpc   (4)
                         * upvalues:
01C8  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
01CC  1D000000           sizelineinfo (29)
                         [pc] (line)
01D0  07000000           [01] (7)
01D4  01000000           [02] (1)
01D8  09000000           [03] (9)
01DC  09000000           [04] (9)
01E0  09000000           [05] (9)
01E4  0A000000           [06] (10)
01E8  0A000000           [07] (10)
01EC  0A000000           [08] (10)
01F0  0A000000           [09] (10)
01F4  0B000000           [10] (11)
01F8  0B000000           [11] (11)
01FC  0B000000           [12] (11)
0200  0B000000           [13] (11)
0204  0D000000           [14] (13)
0208  0D000000           [15] (13)
020C  0D000000           [16] (13)
0210  0E000000           [17] (14)
0214  0E000000           [18] (14)
0218  0E000000           [19] (14)
021C  0E000000           [20] (14)
0220  0F000000           [21] (15)
0224  0F000000           [22] (15)
0228  0F000000           [23] (15)
022C  0F000000           [24] (15)
0230  10000000           [25] (16)
0234  10000000           [26] (16)
0238  10000000           [27] (16)
023C  10000000           [28] (16)
0240  10000000           [29] (16)
                         * locals:
0244  00000000           sizelocvars (0)
                         * upvalues:
0248  00000000           sizeupvalues (0)
                         ** end of function 0 **

024C                     ** end of chunk **
