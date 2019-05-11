------------------------------
f, g = pcall, print; g("hello")   --> hello
t = {pcall, print}; t[2]("hello") --> hello
pcall(print, "hello")             --> hello
--return function (x) print(x) end


function add(x, y) return x + y end
add = function(x, y) return x + y end


--[[
x=1
function g () { echo $x ; x=2 ; }
function f () { local x=3 ; g ; }
f       # 3
echo $x # 1
]]
x = 1
function g() print(x); x = 2 end
function f() local x = 3; g() end
f()      -- 1
print(x) -- 2


local u,v,w
local function f()
  u = v
end


local u,v,w
local function f()
  local function g()
    x = y 
  end
end



-- function f1()
--   local v1, v2
--   function f2()
--     local v3, v4
--     function f3()
--       local v5, v6
--     end
--   end
-- end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "u"  ; 0
.local  "v"  ; 1
.local  "w"  ; 2
.local  "f"  ; 3
.local  "u"  ; 4
.local  "v"  ; 5
.local  "w"  ; 6
.local  "f"  ; 7
.const  "f"  ; 0
.const  "g"  ; 1
.const  "pcall"  ; 2
.const  "print"  ; 3
.const  "hello"  ; 4
.const  "t"  ; 5
.const  2  ; 6
.const  "add"  ; 7
.const  "x"  ; 8
.const  1  ; 9
[01] getglobal  0   2        ; R0 := pcall
[02] getglobal  1   3        ; R1 := print
[03] setglobal  1   1        ; g := R1
[04] setglobal  0   0        ; f := R0
[05] getglobal  0   1        ; R0 := g
[06] loadk      1   4        ; R1 := "hello"
[07] call       0   2   1    ;  := R0(R1)
[08] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[09] getglobal  1   2        ; R1 := pcall
[10] getglobal  2   3        ; R2 := print
[11] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
[12] setglobal  0   5        ; t := R0
[13] getglobal  0   5        ; R0 := t
[14] gettable   0   0   262  ; R0 := R0[2]
[15] loadk      1   4        ; R1 := "hello"
[16] call       0   2   1    ;  := R0(R1)
[17] getglobal  0   2        ; R0 := pcall
[18] getglobal  1   3        ; R1 := print
[19] loadk      2   4        ; R2 := "hello"
[20] call       0   3   1    ;  := R0(R1, R2)
[21] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[22] setglobal  0   7        ; add := R0
[23] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[24] setglobal  0   7        ; add := R0
[25] loadk      0   9        ; R0 := 1
[26] setglobal  0   8        ; x := R0
[27] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[28] setglobal  0   1        ; g := R0
[29] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[30] setglobal  0   0        ; f := R0
[31] getglobal  0   0        ; R0 := f
[32] call       0   1   1    ;  := R0()
[33] getglobal  0   3        ; R0 := print
[34] getglobal  1   8        ; R1 := x
[35] call       0   2   1    ;  := R0(R1)
[36] loadnil    0   2        ; R0, R1, R2,  := nil
[37] closure    3   4        ; R3 := closure(function[4]) 2 upvalues
[38] move       0   0        ; R0 := R0
[39] move       0   1        ; R0 := R1
[40] loadnil    4   6        ; R4, R5, R6,  := nil
[41] closure    7   5        ; R7 := closure(function[5]) 0 upvalues
[42] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "x"  ; 0
.local  "y"  ; 1
[1] add        2   0   1    ; R2 := R0 + R1
[2] return     2   2        ; return R2
[3] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "x"  ; 0
.local  "y"  ; 1
[1] add        2   0   1    ; R2 := R0 + R1
[2] return     2   2        ; return R2
[3] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "x"  ; 1
.const  2  ; 2
[1] getglobal  0   0        ; R0 := print
[2] getglobal  1   1        ; R1 := x
[3] call       0   2   1    ;  := R0(R1)
[4] loadk      0   2        ; R0 := 2
[5] setglobal  0   1        ; x := R0
[6] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "x"  ; 0
.const  3  ; 0
.const  "g"  ; 1
[1] loadk      0   0        ; R0 := 3
[2] getglobal  1   1        ; R1 := g
[3] call       1   1   1    ;  := R1()
[4] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "u"  ; 0
.upvalue  "v"  ; 1
[1] getupval   0   1        ; R0 := U1 , v
[2] setupval   0   0        ; U0 := R0 , u
[3] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "g"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] return     0   1        ; return 

; function [0] definition (level 3) 0_5_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "x"  ; 0
.const  "y"  ; 1
[1] getglobal  0   1        ; R0 := y
[2] setglobal  0   0        ; x := R0
[3] return     0   1        ; return 
; end of function 0_5_0

; end of function 0_5

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "u"  ; 0
.local  "v"  ; 1
.local  "w"  ; 2
.local  "f"  ; 3
.local  "u"  ; 4
.local  "v"  ; 5
.local  "w"  ; 6
.local  "f"  ; 7
.const  "f"  ; 0
.const  "g"  ; 1
.const  "pcall"  ; 2
.const  "print"  ; 3
.const  "hello"  ; 4
.const  "t"  ; 5
.const  2  ; 6
.const  "add"  ; 7
.const  "x"  ; 8
.const  1  ; 9
[01] getglobal  0   2        ; R0 := pcall
[02] getglobal  1   3        ; R1 := print
[03] setglobal  1   1        ; g := R1
[04] setglobal  0   0        ; f := R0
[05] getglobal  0   1        ; R0 := g
[06] loadk      1   4        ; R1 := "hello"
[07] call       0   2   1    ;  := R0(R1)
[08] newtable   0   2   0    ; R0 := {} , array=2, hash=0
[09] getglobal  1   2        ; R1 := pcall
[10] getglobal  2   3        ; R2 := print
[11] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
[12] setglobal  0   5        ; t := R0
[13] getglobal  0   5        ; R0 := t
[14] gettable   0   0   262  ; R0 := R0[2]
[15] loadk      1   4        ; R1 := "hello"
[16] call       0   2   1    ;  := R0(R1)
[17] getglobal  0   2        ; R0 := pcall
[18] getglobal  1   3        ; R1 := print
[19] loadk      2   4        ; R2 := "hello"
[20] call       0   3   1    ;  := R0(R1, R2)
[21] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[22] setglobal  0   7        ; add := R0
[23] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[24] setglobal  0   7        ; add := R0
[25] loadk      0   9        ; R0 := 1
[26] setglobal  0   8        ; x := R0
[27] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[28] setglobal  0   1        ; g := R0
[29] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[30] setglobal  0   0        ; f := R0
[31] getglobal  0   0        ; R0 := f
[32] call       0   1   1    ;  := R0()
[33] getglobal  0   3        ; R0 := print
[34] getglobal  1   8        ; R1 := x
[35] call       0   2   1    ;  := R0(R1)
[36] loadnil    0   2        ; R0, R1, R2,  := nil
[37] closure    3   4        ; R3 := closure(function[4]) 2 upvalues
[38] move       0   0        ; R0 := R0
[39] move       0   1        ; R0 := R1
[40] loadnil    4   6        ; R4, R5, R6,  := nil
[41] closure    7   5        ; R7 := closure(function[5]) 0 upvalues
[42] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "x"  ; 0
.local  "y"  ; 1
[1] add        2   0   1    ; R2 := R0 + R1
[2] return     2   2        ; return R2
[3] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "x"  ; 0
.local  "y"  ; 1
[1] add        2   0   1    ; R2 := R0 + R1
[2] return     2   2        ; return R2
[3] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "x"  ; 1
.const  2  ; 2
[1] getglobal  0   0        ; R0 := print
[2] getglobal  1   1        ; R1 := x
[3] call       0   2   1    ;  := R0(R1)
[4] loadk      0   2        ; R0 := 2
[5] setglobal  0   1        ; x := R0
[6] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "x"  ; 0
.const  3  ; 0
.const  "g"  ; 1
[1] loadk      0   0        ; R0 := 3
[2] getglobal  1   1        ; R1 := g
[3] call       1   1   1    ;  := R1()
[4] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "u"  ; 0
.upvalue  "v"  ; 1
[1] getupval   0   1        ; R0 := U1 , v
[2] setupval   0   0        ; U0 := R0 , u
[3] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.local  "g"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] return     0   1        ; return 

; function [0] definition (level 3) 0_5_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "x"  ; 0
.const  "y"  ; 1
[1] getglobal  0   1        ; R0 := y
[2] setglobal  0   0        ; x := R0
[3] return     0   1        ; return 
; end of function 0_5_0

; end of function 0_5

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
002A  08                 maxstacksize (8)
                         * code:
002B  2A000000           sizecode (42)
002F  05800000           [01] getglobal  0   2        ; R0 := pcall
0033  45C00000           [02] getglobal  1   3        ; R1 := print
0037  47400000           [03] setglobal  1   1        ; g := R1
003B  07000000           [04] setglobal  0   0        ; f := R0
003F  05400000           [05] getglobal  0   1        ; R0 := g
0043  41000100           [06] loadk      1   4        ; R1 := "hello"
0047  1C400001           [07] call       0   2   1    ;  := R0(R1)
004B  0A000001           [08] newtable   0   2   0    ; R0 := {} , array=2, hash=0
004F  45800000           [09] getglobal  1   2        ; R1 := pcall
0053  85C00000           [10] getglobal  2   3        ; R2 := print
0057  22400001           [11] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
005B  07400100           [12] setglobal  0   5        ; t := R0
005F  05400100           [13] getglobal  0   5        ; R0 := t
0063  06804100           [14] gettable   0   0   262  ; R0 := R0[2]
0067  41000100           [15] loadk      1   4        ; R1 := "hello"
006B  1C400001           [16] call       0   2   1    ;  := R0(R1)
006F  05800000           [17] getglobal  0   2        ; R0 := pcall
0073  45C00000           [18] getglobal  1   3        ; R1 := print
0077  81000100           [19] loadk      2   4        ; R2 := "hello"
007B  1C408001           [20] call       0   3   1    ;  := R0(R1, R2)
007F  24000000           [21] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0083  07C00100           [22] setglobal  0   7        ; add := R0
0087  24400000           [23] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
008B  07C00100           [24] setglobal  0   7        ; add := R0
008F  01400200           [25] loadk      0   9        ; R0 := 1
0093  07000200           [26] setglobal  0   8        ; x := R0
0097  24800000           [27] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
009B  07400000           [28] setglobal  0   1        ; g := R0
009F  24C00000           [29] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
00A3  07000000           [30] setglobal  0   0        ; f := R0
00A7  05000000           [31] getglobal  0   0        ; R0 := f
00AB  1C408000           [32] call       0   1   1    ;  := R0()
00AF  05C00000           [33] getglobal  0   3        ; R0 := print
00B3  45000200           [34] getglobal  1   8        ; R1 := x
00B7  1C400001           [35] call       0   2   1    ;  := R0(R1)
00BB  03000001           [36] loadnil    0   2        ; R0, R1, R2,  := nil
00BF  E4000100           [37] closure    3   4        ; R3 := closure(function[4]) 2 upvalues
00C3  00000000           [38] move       0   0        ; R0 := R0
00C7  00008000           [39] move       0   1        ; R0 := R1
00CB  03010003           [40] loadnil    4   6        ; R4, R5, R6,  := nil
00CF  E4410100           [41] closure    7   5        ; R7 := closure(function[5]) 0 upvalues
00D3  1E008000           [42] return     0   1        ; return 
                         * constants:
00D7  0A000000           sizek (10)
00DB  04                 const type 4
00DC  0200000000000000   string size (2)
00E4  6600               "f\0"
                         const [0]: "f"
00E6  04                 const type 4
00E7  0200000000000000   string size (2)
00EF  6700               "g\0"
                         const [1]: "g"
00F1  04                 const type 4
00F2  0600000000000000   string size (6)
00FA  7063616C6C00       "pcall\0"
                         const [2]: "pcall"
0100  04                 const type 4
0101  0600000000000000   string size (6)
0109  7072696E7400       "print\0"
                         const [3]: "print"
010F  04                 const type 4
0110  0600000000000000   string size (6)
0118  68656C6C6F00       "hello\0"
                         const [4]: "hello"
011E  04                 const type 4
011F  0200000000000000   string size (2)
0127  7400               "t\0"
                         const [5]: "t"
0129  03                 const type 3
012A  0000000000000040   const [6]: (2)
0132  04                 const type 4
0133  0400000000000000   string size (4)
013B  61646400           "add\0"
                         const [7]: "add"
013F  04                 const type 4
0140  0200000000000000   string size (2)
0148  7800               "x\0"
                         const [8]: "x"
014A  03                 const type 3
014B  000000000000F03F   const [9]: (1)
                         * functions:
0153  06000000           sizep (6)
                         
0157                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0157  0000000000000000   string size (0)
                         source name: (none)
015F  07000000           line defined (7)
0163  07000000           last line defined (7)
0167  00                 nups (0)
0168  02                 numparams (2)
0169  00                 is_vararg (0)
016A  03                 maxstacksize (3)
                         * code:
016B  03000000           sizecode (3)
016F  8C400000           [1] add        2   0   1    ; R2 := R0 + R1
0173  9E000001           [2] return     2   2        ; return R2
0177  1E008000           [3] return     0   1        ; return 
                         * constants:
017B  00000000           sizek (0)
                         * functions:
017F  00000000           sizep (0)
                         * lines:
0183  03000000           sizelineinfo (3)
                         [pc] (line)
0187  07000000           [1] (7)
018B  07000000           [2] (7)
018F  07000000           [3] (7)
                         * locals:
0193  02000000           sizelocvars (2)
0197  0200000000000000   string size (2)
019F  7800               "x\0"
                         local [0]: x
01A1  00000000             startpc (0)
01A5  02000000             endpc   (2)
01A9  0200000000000000   string size (2)
01B1  7900               "y\0"
                         local [1]: y
01B3  00000000             startpc (0)
01B7  02000000             endpc   (2)
                         * upvalues:
01BB  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
01BF                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
01BF  0000000000000000   string size (0)
                         source name: (none)
01C7  08000000           line defined (8)
01CB  08000000           last line defined (8)
01CF  00                 nups (0)
01D0  02                 numparams (2)
01D1  00                 is_vararg (0)
01D2  03                 maxstacksize (3)
                         * code:
01D3  03000000           sizecode (3)
01D7  8C400000           [1] add        2   0   1    ; R2 := R0 + R1
01DB  9E000001           [2] return     2   2        ; return R2
01DF  1E008000           [3] return     0   1        ; return 
                         * constants:
01E3  00000000           sizek (0)
                         * functions:
01E7  00000000           sizep (0)
                         * lines:
01EB  03000000           sizelineinfo (3)
                         [pc] (line)
01EF  08000000           [1] (8)
01F3  08000000           [2] (8)
01F7  08000000           [3] (8)
                         * locals:
01FB  02000000           sizelocvars (2)
01FF  0200000000000000   string size (2)
0207  7800               "x\0"
                         local [0]: x
0209  00000000             startpc (0)
020D  02000000             endpc   (2)
0211  0200000000000000   string size (2)
0219  7900               "y\0"
                         local [1]: y
021B  00000000             startpc (0)
021F  02000000             endpc   (2)
                         * upvalues:
0223  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
0227                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
0227  0000000000000000   string size (0)
                         source name: (none)
022F  13000000           line defined (19)
0233  13000000           last line defined (19)
0237  00                 nups (0)
0238  00                 numparams (0)
0239  00                 is_vararg (0)
023A  02                 maxstacksize (2)
                         * code:
023B  06000000           sizecode (6)
023F  05000000           [1] getglobal  0   0        ; R0 := print
0243  45400000           [2] getglobal  1   1        ; R1 := x
0247  1C400001           [3] call       0   2   1    ;  := R0(R1)
024B  01800000           [4] loadk      0   2        ; R0 := 2
024F  07400000           [5] setglobal  0   1        ; x := R0
0253  1E008000           [6] return     0   1        ; return 
                         * constants:
0257  03000000           sizek (3)
025B  04                 const type 4
025C  0600000000000000   string size (6)
0264  7072696E7400       "print\0"
                         const [0]: "print"
026A  04                 const type 4
026B  0200000000000000   string size (2)
0273  7800               "x\0"
                         const [1]: "x"
0275  03                 const type 3
0276  0000000000000040   const [2]: (2)
                         * functions:
027E  00000000           sizep (0)
                         * lines:
0282  06000000           sizelineinfo (6)
                         [pc] (line)
0286  13000000           [1] (19)
028A  13000000           [2] (19)
028E  13000000           [3] (19)
0292  13000000           [4] (19)
0296  13000000           [5] (19)
029A  13000000           [6] (19)
                         * locals:
029E  00000000           sizelocvars (0)
                         * upvalues:
02A2  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
02A6                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
02A6  0000000000000000   string size (0)
                         source name: (none)
02AE  14000000           line defined (20)
02B2  14000000           last line defined (20)
02B6  00                 nups (0)
02B7  00                 numparams (0)
02B8  00                 is_vararg (0)
02B9  02                 maxstacksize (2)
                         * code:
02BA  04000000           sizecode (4)
02BE  01000000           [1] loadk      0   0        ; R0 := 3
02C2  45400000           [2] getglobal  1   1        ; R1 := g
02C6  5C408000           [3] call       1   1   1    ;  := R1()
02CA  1E008000           [4] return     0   1        ; return 
                         * constants:
02CE  02000000           sizek (2)
02D2  03                 const type 3
02D3  0000000000000840   const [0]: (3)
02DB  04                 const type 4
02DC  0200000000000000   string size (2)
02E4  6700               "g\0"
                         const [1]: "g"
                         * functions:
02E6  00000000           sizep (0)
                         * lines:
02EA  04000000           sizelineinfo (4)
                         [pc] (line)
02EE  14000000           [1] (20)
02F2  14000000           [2] (20)
02F6  14000000           [3] (20)
02FA  14000000           [4] (20)
                         * locals:
02FE  01000000           sizelocvars (1)
0302  0200000000000000   string size (2)
030A  7800               "x\0"
                         local [0]: x
030C  01000000             startpc (1)
0310  03000000             endpc   (3)
                         * upvalues:
0314  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0318                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0318  0000000000000000   string size (0)
                         source name: (none)
0320  1A000000           line defined (26)
0324  1C000000           last line defined (28)
0328  02                 nups (2)
0329  00                 numparams (0)
032A  00                 is_vararg (0)
032B  02                 maxstacksize (2)
                         * code:
032C  03000000           sizecode (3)
0330  04008000           [1] getupval   0   1        ; R0 := U1 , v
0334  08000000           [2] setupval   0   0        ; U0 := R0 , u
0338  1E008000           [3] return     0   1        ; return 
                         * constants:
033C  00000000           sizek (0)
                         * functions:
0340  00000000           sizep (0)
                         * lines:
0344  03000000           sizelineinfo (3)
                         [pc] (line)
0348  1B000000           [1] (27)
034C  1B000000           [2] (27)
0350  1C000000           [3] (28)
                         * locals:
0354  00000000           sizelocvars (0)
                         * upvalues:
0358  02000000           sizeupvalues (2)
035C  0200000000000000   string size (2)
0364  7500               "u\0"
                         upvalue [0]: u
0366  0200000000000000   string size (2)
036E  7600               "v\0"
                         upvalue [1]: v
                         ** end of function 0_4 **

                         
0370                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
0370  0000000000000000   string size (0)
                         source name: (none)
0378  20000000           line defined (32)
037C  24000000           last line defined (36)
0380  00                 nups (0)
0381  00                 numparams (0)
0382  00                 is_vararg (0)
0383  02                 maxstacksize (2)
                         * code:
0384  02000000           sizecode (2)
0388  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
038C  1E008000           [2] return     0   1        ; return 
                         * constants:
0390  00000000           sizek (0)
                         * functions:
0394  01000000           sizep (1)
                         
0398                     ** function [0] definition (level 3) 0_5_0
                         ** start of function 0_5_0 **
0398  0000000000000000   string size (0)
                         source name: (none)
03A0  21000000           line defined (33)
03A4  23000000           last line defined (35)
03A8  00                 nups (0)
03A9  00                 numparams (0)
03AA  00                 is_vararg (0)
03AB  02                 maxstacksize (2)
                         * code:
03AC  03000000           sizecode (3)
03B0  05400000           [1] getglobal  0   1        ; R0 := y
03B4  07000000           [2] setglobal  0   0        ; x := R0
03B8  1E008000           [3] return     0   1        ; return 
                         * constants:
03BC  02000000           sizek (2)
03C0  04                 const type 4
03C1  0200000000000000   string size (2)
03C9  7800               "x\0"
                         const [0]: "x"
03CB  04                 const type 4
03CC  0200000000000000   string size (2)
03D4  7900               "y\0"
                         const [1]: "y"
                         * functions:
03D6  00000000           sizep (0)
                         * lines:
03DA  03000000           sizelineinfo (3)
                         [pc] (line)
03DE  22000000           [1] (34)
03E2  22000000           [2] (34)
03E6  23000000           [3] (35)
                         * locals:
03EA  00000000           sizelocvars (0)
                         * upvalues:
03EE  00000000           sizeupvalues (0)
                         ** end of function 0_5_0 **

                         * lines:
03F2  02000000           sizelineinfo (2)
                         [pc] (line)
03F6  23000000           [1] (35)
03FA  24000000           [2] (36)
                         * locals:
03FE  01000000           sizelocvars (1)
0402  0200000000000000   string size (2)
040A  6700               "g\0"
                         local [0]: g
040C  01000000             startpc (1)
0410  01000000             endpc   (1)
                         * upvalues:
0414  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         * lines:
0418  2A000000           sizelineinfo (42)
                         [pc] (line)
041C  01000000           [01] (1)
0420  01000000           [02] (1)
0424  01000000           [03] (1)
0428  01000000           [04] (1)
042C  01000000           [05] (1)
0430  01000000           [06] (1)
0434  01000000           [07] (1)
0438  02000000           [08] (2)
043C  02000000           [09] (2)
0440  02000000           [10] (2)
0444  02000000           [11] (2)
0448  02000000           [12] (2)
044C  02000000           [13] (2)
0450  02000000           [14] (2)
0454  02000000           [15] (2)
0458  02000000           [16] (2)
045C  03000000           [17] (3)
0460  03000000           [18] (3)
0464  03000000           [19] (3)
0468  03000000           [20] (3)
046C  07000000           [21] (7)
0470  07000000           [22] (7)
0474  08000000           [23] (8)
0478  08000000           [24] (8)
047C  12000000           [25] (18)
0480  12000000           [26] (18)
0484  13000000           [27] (19)
0488  13000000           [28] (19)
048C  14000000           [29] (20)
0490  14000000           [30] (20)
0494  15000000           [31] (21)
0498  15000000           [32] (21)
049C  16000000           [33] (22)
04A0  16000000           [34] (22)
04A4  16000000           [35] (22)
04A8  19000000           [36] (25)
04AC  1C000000           [37] (28)
04B0  1C000000           [38] (28)
04B4  1C000000           [39] (28)
04B8  1F000000           [40] (31)
04BC  24000000           [41] (36)
04C0  24000000           [42] (36)
                         * locals:
04C4  08000000           sizelocvars (8)
04C8  0200000000000000   string size (2)
04D0  7500               "u\0"
                         local [0]: u
04D2  24000000             startpc (36)
04D6  29000000             endpc   (41)
04DA  0200000000000000   string size (2)
04E2  7600               "v\0"
                         local [1]: v
04E4  24000000             startpc (36)
04E8  29000000             endpc   (41)
04EC  0200000000000000   string size (2)
04F4  7700               "w\0"
                         local [2]: w
04F6  24000000             startpc (36)
04FA  29000000             endpc   (41)
04FE  0200000000000000   string size (2)
0506  6600               "f\0"
                         local [3]: f
0508  27000000             startpc (39)
050C  29000000             endpc   (41)
0510  0200000000000000   string size (2)
0518  7500               "u\0"
                         local [4]: u
051A  28000000             startpc (40)
051E  29000000             endpc   (41)
0522  0200000000000000   string size (2)
052A  7600               "v\0"
                         local [5]: v
052C  28000000             startpc (40)
0530  29000000             endpc   (41)
0534  0200000000000000   string size (2)
053C  7700               "w\0"
                         local [6]: w
053E  28000000             startpc (40)
0542  29000000             endpc   (41)
0546  0200000000000000   string size (2)
054E  6600               "f\0"
                         local [7]: f
0550  29000000             startpc (41)
0554  29000000             endpc   (41)
                         * upvalues:
0558  00000000           sizeupvalues (0)
                         ** end of function 0 **

055C                     ** end of chunk **
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
002A  08                 maxstacksize (8)
                         * code:
002B  2A000000           sizecode (42)
002F  05800000           [01] getglobal  0   2        ; R0 := pcall
0033  45C00000           [02] getglobal  1   3        ; R1 := print
0037  47400000           [03] setglobal  1   1        ; g := R1
003B  07000000           [04] setglobal  0   0        ; f := R0
003F  05400000           [05] getglobal  0   1        ; R0 := g
0043  41000100           [06] loadk      1   4        ; R1 := "hello"
0047  1C400001           [07] call       0   2   1    ;  := R0(R1)
004B  0A000001           [08] newtable   0   2   0    ; R0 := {} , array=2, hash=0
004F  45800000           [09] getglobal  1   2        ; R1 := pcall
0053  85C00000           [10] getglobal  2   3        ; R2 := print
0057  22400001           [11] setlist    0   2   1    ; R0[1 to 2] := R1 to R2
005B  07400100           [12] setglobal  0   5        ; t := R0
005F  05400100           [13] getglobal  0   5        ; R0 := t
0063  06804100           [14] gettable   0   0   262  ; R0 := R0[2]
0067  41000100           [15] loadk      1   4        ; R1 := "hello"
006B  1C400001           [16] call       0   2   1    ;  := R0(R1)
006F  05800000           [17] getglobal  0   2        ; R0 := pcall
0073  45C00000           [18] getglobal  1   3        ; R1 := print
0077  81000100           [19] loadk      2   4        ; R2 := "hello"
007B  1C408001           [20] call       0   3   1    ;  := R0(R1, R2)
007F  24000000           [21] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0083  07C00100           [22] setglobal  0   7        ; add := R0
0087  24400000           [23] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
008B  07C00100           [24] setglobal  0   7        ; add := R0
008F  01400200           [25] loadk      0   9        ; R0 := 1
0093  07000200           [26] setglobal  0   8        ; x := R0
0097  24800000           [27] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
009B  07400000           [28] setglobal  0   1        ; g := R0
009F  24C00000           [29] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
00A3  07000000           [30] setglobal  0   0        ; f := R0
00A7  05000000           [31] getglobal  0   0        ; R0 := f
00AB  1C408000           [32] call       0   1   1    ;  := R0()
00AF  05C00000           [33] getglobal  0   3        ; R0 := print
00B3  45000200           [34] getglobal  1   8        ; R1 := x
00B7  1C400001           [35] call       0   2   1    ;  := R0(R1)
00BB  03000001           [36] loadnil    0   2        ; R0, R1, R2,  := nil
00BF  E4000100           [37] closure    3   4        ; R3 := closure(function[4]) 2 upvalues
00C3  00000000           [38] move       0   0        ; R0 := R0
00C7  00008000           [39] move       0   1        ; R0 := R1
00CB  03010003           [40] loadnil    4   6        ; R4, R5, R6,  := nil
00CF  E4410100           [41] closure    7   5        ; R7 := closure(function[5]) 0 upvalues
00D3  1E008000           [42] return     0   1        ; return 
                         * constants:
00D7  0A000000           sizek (10)
00DB  04                 const type 4
00DC  0200000000000000   string size (2)
00E4  6600               "f\0"
                         const [0]: "f"
00E6  04                 const type 4
00E7  0200000000000000   string size (2)
00EF  6700               "g\0"
                         const [1]: "g"
00F1  04                 const type 4
00F2  0600000000000000   string size (6)
00FA  7063616C6C00       "pcall\0"
                         const [2]: "pcall"
0100  04                 const type 4
0101  0600000000000000   string size (6)
0109  7072696E7400       "print\0"
                         const [3]: "print"
010F  04                 const type 4
0110  0600000000000000   string size (6)
0118  68656C6C6F00       "hello\0"
                         const [4]: "hello"
011E  04                 const type 4
011F  0200000000000000   string size (2)
0127  7400               "t\0"
                         const [5]: "t"
0129  03                 const type 3
012A  0000000000000040   const [6]: (2)
0132  04                 const type 4
0133  0400000000000000   string size (4)
013B  61646400           "add\0"
                         const [7]: "add"
013F  04                 const type 4
0140  0200000000000000   string size (2)
0148  7800               "x\0"
                         const [8]: "x"
014A  03                 const type 3
014B  000000000000F03F   const [9]: (1)
                         * functions:
0153  06000000           sizep (6)
                         
0157                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0157  0000000000000000   string size (0)
                         source name: (none)
015F  07000000           line defined (7)
0163  07000000           last line defined (7)
0167  00                 nups (0)
0168  02                 numparams (2)
0169  00                 is_vararg (0)
016A  03                 maxstacksize (3)
                         * code:
016B  03000000           sizecode (3)
016F  8C400000           [1] add        2   0   1    ; R2 := R0 + R1
0173  9E000001           [2] return     2   2        ; return R2
0177  1E008000           [3] return     0   1        ; return 
                         * constants:
017B  00000000           sizek (0)
                         * functions:
017F  00000000           sizep (0)
                         * lines:
0183  03000000           sizelineinfo (3)
                         [pc] (line)
0187  07000000           [1] (7)
018B  07000000           [2] (7)
018F  07000000           [3] (7)
                         * locals:
0193  02000000           sizelocvars (2)
0197  0200000000000000   string size (2)
019F  7800               "x\0"
                         local [0]: x
01A1  00000000             startpc (0)
01A5  02000000             endpc   (2)
01A9  0200000000000000   string size (2)
01B1  7900               "y\0"
                         local [1]: y
01B3  00000000             startpc (0)
01B7  02000000             endpc   (2)
                         * upvalues:
01BB  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
01BF                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
01BF  0000000000000000   string size (0)
                         source name: (none)
01C7  08000000           line defined (8)
01CB  08000000           last line defined (8)
01CF  00                 nups (0)
01D0  02                 numparams (2)
01D1  00                 is_vararg (0)
01D2  03                 maxstacksize (3)
                         * code:
01D3  03000000           sizecode (3)
01D7  8C400000           [1] add        2   0   1    ; R2 := R0 + R1
01DB  9E000001           [2] return     2   2        ; return R2
01DF  1E008000           [3] return     0   1        ; return 
                         * constants:
01E3  00000000           sizek (0)
                         * functions:
01E7  00000000           sizep (0)
                         * lines:
01EB  03000000           sizelineinfo (3)
                         [pc] (line)
01EF  08000000           [1] (8)
01F3  08000000           [2] (8)
01F7  08000000           [3] (8)
                         * locals:
01FB  02000000           sizelocvars (2)
01FF  0200000000000000   string size (2)
0207  7800               "x\0"
                         local [0]: x
0209  00000000             startpc (0)
020D  02000000             endpc   (2)
0211  0200000000000000   string size (2)
0219  7900               "y\0"
                         local [1]: y
021B  00000000             startpc (0)
021F  02000000             endpc   (2)
                         * upvalues:
0223  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
0227                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
0227  0000000000000000   string size (0)
                         source name: (none)
022F  13000000           line defined (19)
0233  13000000           last line defined (19)
0237  00                 nups (0)
0238  00                 numparams (0)
0239  00                 is_vararg (0)
023A  02                 maxstacksize (2)
                         * code:
023B  06000000           sizecode (6)
023F  05000000           [1] getglobal  0   0        ; R0 := print
0243  45400000           [2] getglobal  1   1        ; R1 := x
0247  1C400001           [3] call       0   2   1    ;  := R0(R1)
024B  01800000           [4] loadk      0   2        ; R0 := 2
024F  07400000           [5] setglobal  0   1        ; x := R0
0253  1E008000           [6] return     0   1        ; return 
                         * constants:
0257  03000000           sizek (3)
025B  04                 const type 4
025C  0600000000000000   string size (6)
0264  7072696E7400       "print\0"
                         const [0]: "print"
026A  04                 const type 4
026B  0200000000000000   string size (2)
0273  7800               "x\0"
                         const [1]: "x"
0275  03                 const type 3
0276  0000000000000040   const [2]: (2)
                         * functions:
027E  00000000           sizep (0)
                         * lines:
0282  06000000           sizelineinfo (6)
                         [pc] (line)
0286  13000000           [1] (19)
028A  13000000           [2] (19)
028E  13000000           [3] (19)
0292  13000000           [4] (19)
0296  13000000           [5] (19)
029A  13000000           [6] (19)
                         * locals:
029E  00000000           sizelocvars (0)
                         * upvalues:
02A2  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
02A6                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
02A6  0000000000000000   string size (0)
                         source name: (none)
02AE  14000000           line defined (20)
02B2  14000000           last line defined (20)
02B6  00                 nups (0)
02B7  00                 numparams (0)
02B8  00                 is_vararg (0)
02B9  02                 maxstacksize (2)
                         * code:
02BA  04000000           sizecode (4)
02BE  01000000           [1] loadk      0   0        ; R0 := 3
02C2  45400000           [2] getglobal  1   1        ; R1 := g
02C6  5C408000           [3] call       1   1   1    ;  := R1()
02CA  1E008000           [4] return     0   1        ; return 
                         * constants:
02CE  02000000           sizek (2)
02D2  03                 const type 3
02D3  0000000000000840   const [0]: (3)
02DB  04                 const type 4
02DC  0200000000000000   string size (2)
02E4  6700               "g\0"
                         const [1]: "g"
                         * functions:
02E6  00000000           sizep (0)
                         * lines:
02EA  04000000           sizelineinfo (4)
                         [pc] (line)
02EE  14000000           [1] (20)
02F2  14000000           [2] (20)
02F6  14000000           [3] (20)
02FA  14000000           [4] (20)
                         * locals:
02FE  01000000           sizelocvars (1)
0302  0200000000000000   string size (2)
030A  7800               "x\0"
                         local [0]: x
030C  01000000             startpc (1)
0310  03000000             endpc   (3)
                         * upvalues:
0314  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0318                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0318  0000000000000000   string size (0)
                         source name: (none)
0320  1A000000           line defined (26)
0324  1C000000           last line defined (28)
0328  02                 nups (2)
0329  00                 numparams (0)
032A  00                 is_vararg (0)
032B  02                 maxstacksize (2)
                         * code:
032C  03000000           sizecode (3)
0330  04008000           [1] getupval   0   1        ; R0 := U1 , v
0334  08000000           [2] setupval   0   0        ; U0 := R0 , u
0338  1E008000           [3] return     0   1        ; return 
                         * constants:
033C  00000000           sizek (0)
                         * functions:
0340  00000000           sizep (0)
                         * lines:
0344  03000000           sizelineinfo (3)
                         [pc] (line)
0348  1B000000           [1] (27)
034C  1B000000           [2] (27)
0350  1C000000           [3] (28)
                         * locals:
0354  00000000           sizelocvars (0)
                         * upvalues:
0358  02000000           sizeupvalues (2)
035C  0200000000000000   string size (2)
0364  7500               "u\0"
                         upvalue [0]: u
0366  0200000000000000   string size (2)
036E  7600               "v\0"
                         upvalue [1]: v
                         ** end of function 0_4 **

                         
0370                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
0370  0000000000000000   string size (0)
                         source name: (none)
0378  20000000           line defined (32)
037C  24000000           last line defined (36)
0380  00                 nups (0)
0381  00                 numparams (0)
0382  00                 is_vararg (0)
0383  02                 maxstacksize (2)
                         * code:
0384  02000000           sizecode (2)
0388  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
038C  1E008000           [2] return     0   1        ; return 
                         * constants:
0390  00000000           sizek (0)
                         * functions:
0394  01000000           sizep (1)
                         
0398                     ** function [0] definition (level 3) 0_5_0
                         ** start of function 0_5_0 **
0398  0000000000000000   string size (0)
                         source name: (none)
03A0  21000000           line defined (33)
03A4  23000000           last line defined (35)
03A8  00                 nups (0)
03A9  00                 numparams (0)
03AA  00                 is_vararg (0)
03AB  02                 maxstacksize (2)
                         * code:
03AC  03000000           sizecode (3)
03B0  05400000           [1] getglobal  0   1        ; R0 := y
03B4  07000000           [2] setglobal  0   0        ; x := R0
03B8  1E008000           [3] return     0   1        ; return 
                         * constants:
03BC  02000000           sizek (2)
03C0  04                 const type 4
03C1  0200000000000000   string size (2)
03C9  7800               "x\0"
                         const [0]: "x"
03CB  04                 const type 4
03CC  0200000000000000   string size (2)
03D4  7900               "y\0"
                         const [1]: "y"
                         * functions:
03D6  00000000           sizep (0)
                         * lines:
03DA  03000000           sizelineinfo (3)
                         [pc] (line)
03DE  22000000           [1] (34)
03E2  22000000           [2] (34)
03E6  23000000           [3] (35)
                         * locals:
03EA  00000000           sizelocvars (0)
                         * upvalues:
03EE  00000000           sizeupvalues (0)
                         ** end of function 0_5_0 **

                         * lines:
03F2  02000000           sizelineinfo (2)
                         [pc] (line)
03F6  23000000           [1] (35)
03FA  24000000           [2] (36)
                         * locals:
03FE  01000000           sizelocvars (1)
0402  0200000000000000   string size (2)
040A  6700               "g\0"
                         local [0]: g
040C  01000000             startpc (1)
0410  01000000             endpc   (1)
                         * upvalues:
0414  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         * lines:
0418  2A000000           sizelineinfo (42)
                         [pc] (line)
041C  01000000           [01] (1)
0420  01000000           [02] (1)
0424  01000000           [03] (1)
0428  01000000           [04] (1)
042C  01000000           [05] (1)
0430  01000000           [06] (1)
0434  01000000           [07] (1)
0438  02000000           [08] (2)
043C  02000000           [09] (2)
0440  02000000           [10] (2)
0444  02000000           [11] (2)
0448  02000000           [12] (2)
044C  02000000           [13] (2)
0450  02000000           [14] (2)
0454  02000000           [15] (2)
0458  02000000           [16] (2)
045C  03000000           [17] (3)
0460  03000000           [18] (3)
0464  03000000           [19] (3)
0468  03000000           [20] (3)
046C  07000000           [21] (7)
0470  07000000           [22] (7)
0474  08000000           [23] (8)
0478  08000000           [24] (8)
047C  12000000           [25] (18)
0480  12000000           [26] (18)
0484  13000000           [27] (19)
0488  13000000           [28] (19)
048C  14000000           [29] (20)
0490  14000000           [30] (20)
0494  15000000           [31] (21)
0498  15000000           [32] (21)
049C  16000000           [33] (22)
04A0  16000000           [34] (22)
04A4  16000000           [35] (22)
04A8  19000000           [36] (25)
04AC  1C000000           [37] (28)
04B0  1C000000           [38] (28)
04B4  1C000000           [39] (28)
04B8  1F000000           [40] (31)
04BC  24000000           [41] (36)
04C0  24000000           [42] (36)
                         * locals:
04C4  08000000           sizelocvars (8)
04C8  0200000000000000   string size (2)
04D0  7500               "u\0"
                         local [0]: u
04D2  24000000             startpc (36)
04D6  29000000             endpc   (41)
04DA  0200000000000000   string size (2)
04E2  7600               "v\0"
                         local [1]: v
04E4  24000000             startpc (36)
04E8  29000000             endpc   (41)
04EC  0200000000000000   string size (2)
04F4  7700               "w\0"
                         local [2]: w
04F6  24000000             startpc (36)
04FA  29000000             endpc   (41)
04FE  0200000000000000   string size (2)
0506  6600               "f\0"
                         local [3]: f
0508  27000000             startpc (39)
050C  29000000             endpc   (41)
0510  0200000000000000   string size (2)
0518  7500               "u\0"
                         local [4]: u
051A  28000000             startpc (40)
051E  29000000             endpc   (41)
0522  0200000000000000   string size (2)
052A  7600               "v\0"
                         local [5]: v
052C  28000000             startpc (40)
0530  29000000             endpc   (41)
0534  0200000000000000   string size (2)
053C  7700               "w\0"
                         local [6]: w
053E  28000000             startpc (40)
0542  29000000             endpc   (41)
0546  0200000000000000   string size (2)
054E  6600               "f\0"
                         local [7]: f
0550  29000000             startpc (41)
0554  29000000             endpc   (41)
                         * upvalues:
0558  00000000           sizeupvalues (0)
                         ** end of function 0 **

055C                     ** end of chunk **
