------------------------------
print(getmetatable("foo")) --> table: 0x7f8aab4050c0
print(getmetatable("bar")) --> table: 0x7f8aab4050c0
print(getmetatable(nil))   --> nil
print(getmetatable(false)) --> nil
print(getmetatable(100))   --> nil
print(getmetatable({}))    --> nil
print(getmetatable(print)) --> nil

t = {}
mt = {}
setmetatable(t, mt)
print(getmetatable(t) == mt)   --> true
debug.setmetatable(100, mt)
print(getmetatable(200) == mt) --> true


mt = {}
mt.__add = function(v1, v2)
  return vector(v1.x + v2.x, v1.y + v2.y)
end

function vector(x, y)
  local v = {x = x, y = y}
  setmetatable(v, mt)
  return v
end

v1 = vector(1, 2)
v2 = vector(3, 5)
v3 = v1 + v2
print(v3.x, v3.y) --> 4	7

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "print"  ; 0
.const  "getmetatable"  ; 1
.const  "foo"  ; 2
.const  "bar"  ; 3
.const  100  ; 4
.const  "t"  ; 5
.const  "mt"  ; 6
.const  "setmetatable"  ; 7
.const  "debug"  ; 8
.const  200  ; 9
.const  "__add"  ; 10
.const  "vector"  ; 11
.const  "v1"  ; 12
.const  1  ; 13
.const  2  ; 14
.const  "v2"  ; 15
.const  3  ; 16
.const  5  ; 17
.const  "v3"  ; 18
.const  "x"  ; 19
.const  "y"  ; 20
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := getmetatable
[03] loadk      2   2        ; R2 := "foo"
[04] call       1   2   0    ; R1 to top := R1(R2)
[05] call       0   0   1    ;  := R0(R1 to top)
[06] getglobal  0   0        ; R0 := print
[07] getglobal  1   1        ; R1 := getmetatable
[08] loadk      2   3        ; R2 := "bar"
[09] call       1   2   0    ; R1 to top := R1(R2)
[10] call       0   0   1    ;  := R0(R1 to top)
[11] getglobal  0   0        ; R0 := print
[12] getglobal  1   1        ; R1 := getmetatable
[13] loadnil    2   2        ; R2,  := nil
[14] call       1   2   0    ; R1 to top := R1(R2)
[15] call       0   0   1    ;  := R0(R1 to top)
[16] getglobal  0   0        ; R0 := print
[17] getglobal  1   1        ; R1 := getmetatable
[18] loadbool   2   0   0    ; R2 := false
[19] call       1   2   0    ; R1 to top := R1(R2)
[20] call       0   0   1    ;  := R0(R1 to top)
[21] getglobal  0   0        ; R0 := print
[22] getglobal  1   1        ; R1 := getmetatable
[23] loadk      2   4        ; R2 := 100
[24] call       1   2   0    ; R1 to top := R1(R2)
[25] call       0   0   1    ;  := R0(R1 to top)
[26] getglobal  0   0        ; R0 := print
[27] getglobal  1   1        ; R1 := getmetatable
[28] newtable   2   0   0    ; R2 := {} , array=0, hash=0
[29] call       1   2   0    ; R1 to top := R1(R2)
[30] call       0   0   1    ;  := R0(R1 to top)
[31] getglobal  0   0        ; R0 := print
[32] getglobal  1   1        ; R1 := getmetatable
[33] getglobal  2   0        ; R2 := print
[34] call       1   2   0    ; R1 to top := R1(R2)
[35] call       0   0   1    ;  := R0(R1 to top)
[36] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[37] setglobal  0   5        ; t := R0
[38] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[39] setglobal  0   6        ; mt := R0
[40] getglobal  0   7        ; R0 := setmetatable
[41] getglobal  1   5        ; R1 := t
[42] getglobal  2   6        ; R2 := mt
[43] call       0   3   1    ;  := R0(R1, R2)
[44] getglobal  0   0        ; R0 := print
[45] getglobal  1   1        ; R1 := getmetatable
[46] getglobal  2   5        ; R2 := t
[47] call       1   2   2    ; R1 := R1(R2)
[48] getglobal  2   6        ; R2 := mt
[49] eq         1   1   2    ; R1 == R2, pc+=1 (goto [51]) if false
[50] jmp        1            ; pc+=1 (goto [52])
[51] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [53])
[52] loadbool   1   1   0    ; R1 := true
[53] call       0   2   1    ;  := R0(R1)
[54] getglobal  0   8        ; R0 := debug
[55] gettable   0   0   263  ; R0 := R0["setmetatable"]
[56] loadk      1   4        ; R1 := 100
[57] getglobal  2   6        ; R2 := mt
[58] call       0   3   1    ;  := R0(R1, R2)
[59] getglobal  0   0        ; R0 := print
[60] getglobal  1   1        ; R1 := getmetatable
[61] loadk      2   9        ; R2 := 200
[62] call       1   2   2    ; R1 := R1(R2)
[63] getglobal  2   6        ; R2 := mt
[64] eq         1   1   2    ; R1 == R2, pc+=1 (goto [66]) if false
[65] jmp        1            ; pc+=1 (goto [67])
[66] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [68])
[67] loadbool   1   1   0    ; R1 := true
[68] call       0   2   1    ;  := R0(R1)
[69] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[70] setglobal  0   6        ; mt := R0
[71] getglobal  0   6        ; R0 := mt
[72] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[73] settable   0   266 1    ; R0["__add"] := R1
[74] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[75] setglobal  0   11       ; vector := R0
[76] getglobal  0   11       ; R0 := vector
[77] loadk      1   13       ; R1 := 1
[78] loadk      2   14       ; R2 := 2
[79] call       0   3   2    ; R0 := R0(R1, R2)
[80] setglobal  0   12       ; v1 := R0
[81] getglobal  0   11       ; R0 := vector
[82] loadk      1   16       ; R1 := 3
[83] loadk      2   17       ; R2 := 5
[84] call       0   3   2    ; R0 := R0(R1, R2)
[85] setglobal  0   15       ; v2 := R0
[86] getglobal  0   12       ; R0 := v1
[87] getglobal  1   15       ; R1 := v2
[88] add        0   0   1    ; R0 := R0 + R1
[89] setglobal  0   18       ; v3 := R0
[90] getglobal  0   0        ; R0 := print
[91] getglobal  1   18       ; R1 := v3
[92] gettable   1   1   275  ; R1 := R1["x"]
[93] getglobal  2   18       ; R2 := v3
[94] gettable   2   2   276  ; R2 := R2["y"]
[95] call       0   3   1    ;  := R0(R1, R2)
[96] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "v1"  ; 0
.local  "v2"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[01] getglobal  2   0        ; R2 := vector
[02] gettable   3   0   257  ; R3 := R0["x"]
[03] gettable   4   1   257  ; R4 := R1["x"]
[04] add        3   3   4    ; R3 := R3 + R4
[05] gettable   4   0   258  ; R4 := R0["y"]
[06] gettable   5   1   258  ; R5 := R1["y"]
[07] add        4   4   5    ; R4 := R4 + R5
[08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[09] return     2   0        ; return R2 to top
[10] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.local  "v"  ; 2
.const  "x"  ; 0
.const  "y"  ; 1
.const  "setmetatable"  ; 2
.const  "mt"  ; 3
[1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[2] settable   2   256 0    ; R2["x"] := R0
[3] settable   2   257 1    ; R2["y"] := R1
[4] getglobal  3   2        ; R3 := setmetatable
[5] move       4   2        ; R4 := R2
[6] getglobal  5   3        ; R5 := mt
[7] call       3   3   1    ;  := R3(R4, R5)
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "print"  ; 0
.const  "getmetatable"  ; 1
.const  "foo"  ; 2
.const  "bar"  ; 3
.const  100  ; 4
.const  "t"  ; 5
.const  "mt"  ; 6
.const  "setmetatable"  ; 7
.const  "debug"  ; 8
.const  200  ; 9
.const  "__add"  ; 10
.const  "vector"  ; 11
.const  "v1"  ; 12
.const  1  ; 13
.const  2  ; 14
.const  "v2"  ; 15
.const  3  ; 16
.const  5  ; 17
.const  "v3"  ; 18
.const  "x"  ; 19
.const  "y"  ; 20
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := getmetatable
[03] loadk      2   2        ; R2 := "foo"
[04] call       1   2   0    ; R1 to top := R1(R2)
[05] call       0   0   1    ;  := R0(R1 to top)
[06] getglobal  0   0        ; R0 := print
[07] getglobal  1   1        ; R1 := getmetatable
[08] loadk      2   3        ; R2 := "bar"
[09] call       1   2   0    ; R1 to top := R1(R2)
[10] call       0   0   1    ;  := R0(R1 to top)
[11] getglobal  0   0        ; R0 := print
[12] getglobal  1   1        ; R1 := getmetatable
[13] loadnil    2   2        ; R2,  := nil
[14] call       1   2   0    ; R1 to top := R1(R2)
[15] call       0   0   1    ;  := R0(R1 to top)
[16] getglobal  0   0        ; R0 := print
[17] getglobal  1   1        ; R1 := getmetatable
[18] loadbool   2   0   0    ; R2 := false
[19] call       1   2   0    ; R1 to top := R1(R2)
[20] call       0   0   1    ;  := R0(R1 to top)
[21] getglobal  0   0        ; R0 := print
[22] getglobal  1   1        ; R1 := getmetatable
[23] loadk      2   4        ; R2 := 100
[24] call       1   2   0    ; R1 to top := R1(R2)
[25] call       0   0   1    ;  := R0(R1 to top)
[26] getglobal  0   0        ; R0 := print
[27] getglobal  1   1        ; R1 := getmetatable
[28] newtable   2   0   0    ; R2 := {} , array=0, hash=0
[29] call       1   2   0    ; R1 to top := R1(R2)
[30] call       0   0   1    ;  := R0(R1 to top)
[31] getglobal  0   0        ; R0 := print
[32] getglobal  1   1        ; R1 := getmetatable
[33] getglobal  2   0        ; R2 := print
[34] call       1   2   0    ; R1 to top := R1(R2)
[35] call       0   0   1    ;  := R0(R1 to top)
[36] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[37] setglobal  0   5        ; t := R0
[38] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[39] setglobal  0   6        ; mt := R0
[40] getglobal  0   7        ; R0 := setmetatable
[41] getglobal  1   5        ; R1 := t
[42] getglobal  2   6        ; R2 := mt
[43] call       0   3   1    ;  := R0(R1, R2)
[44] getglobal  0   0        ; R0 := print
[45] getglobal  1   1        ; R1 := getmetatable
[46] getglobal  2   5        ; R2 := t
[47] call       1   2   2    ; R1 := R1(R2)
[48] getglobal  2   6        ; R2 := mt
[49] eq         1   1   2    ; R1 == R2, pc+=1 (goto [51]) if false
[50] jmp        1            ; pc+=1 (goto [52])
[51] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [53])
[52] loadbool   1   1   0    ; R1 := true
[53] call       0   2   1    ;  := R0(R1)
[54] getglobal  0   8        ; R0 := debug
[55] gettable   0   0   263  ; R0 := R0["setmetatable"]
[56] loadk      1   4        ; R1 := 100
[57] getglobal  2   6        ; R2 := mt
[58] call       0   3   1    ;  := R0(R1, R2)
[59] getglobal  0   0        ; R0 := print
[60] getglobal  1   1        ; R1 := getmetatable
[61] loadk      2   9        ; R2 := 200
[62] call       1   2   2    ; R1 := R1(R2)
[63] getglobal  2   6        ; R2 := mt
[64] eq         1   1   2    ; R1 == R2, pc+=1 (goto [66]) if false
[65] jmp        1            ; pc+=1 (goto [67])
[66] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [68])
[67] loadbool   1   1   0    ; R1 := true
[68] call       0   2   1    ;  := R0(R1)
[69] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[70] setglobal  0   6        ; mt := R0
[71] getglobal  0   6        ; R0 := mt
[72] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[73] settable   0   266 1    ; R0["__add"] := R1
[74] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[75] setglobal  0   11       ; vector := R0
[76] getglobal  0   11       ; R0 := vector
[77] loadk      1   13       ; R1 := 1
[78] loadk      2   14       ; R2 := 2
[79] call       0   3   2    ; R0 := R0(R1, R2)
[80] setglobal  0   12       ; v1 := R0
[81] getglobal  0   11       ; R0 := vector
[82] loadk      1   16       ; R1 := 3
[83] loadk      2   17       ; R2 := 5
[84] call       0   3   2    ; R0 := R0(R1, R2)
[85] setglobal  0   15       ; v2 := R0
[86] getglobal  0   12       ; R0 := v1
[87] getglobal  1   15       ; R1 := v2
[88] add        0   0   1    ; R0 := R0 + R1
[89] setglobal  0   18       ; v3 := R0
[90] getglobal  0   0        ; R0 := print
[91] getglobal  1   18       ; R1 := v3
[92] gettable   1   1   275  ; R1 := R1["x"]
[93] getglobal  2   18       ; R2 := v3
[94] gettable   2   2   276  ; R2 := R2["y"]
[95] call       0   3   1    ;  := R0(R1, R2)
[96] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "v1"  ; 0
.local  "v2"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[01] getglobal  2   0        ; R2 := vector
[02] gettable   3   0   257  ; R3 := R0["x"]
[03] gettable   4   1   257  ; R4 := R1["x"]
[04] add        3   3   4    ; R3 := R3 + R4
[05] gettable   4   0   258  ; R4 := R0["y"]
[06] gettable   5   1   258  ; R5 := R1["y"]
[07] add        4   4   5    ; R4 := R4 + R5
[08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[09] return     2   0        ; return R2 to top
[10] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.local  "v"  ; 2
.const  "x"  ; 0
.const  "y"  ; 1
.const  "setmetatable"  ; 2
.const  "mt"  ; 3
[1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[2] settable   2   256 0    ; R2["x"] := R0
[3] settable   2   257 1    ; R2["y"] := R1
[4] getglobal  3   2        ; R3 := setmetatable
[5] move       4   2        ; R4 := R2
[6] getglobal  5   3        ; R5 := mt
[7] call       3   3   1    ;  := R3(R4, R5)
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  60000000           sizecode (96)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  45400000           [02] getglobal  1   1        ; R1 := getmetatable
0037  81800000           [03] loadk      2   2        ; R2 := "foo"
003B  5C000001           [04] call       1   2   0    ; R1 to top := R1(R2)
003F  1C400000           [05] call       0   0   1    ;  := R0(R1 to top)
0043  05000000           [06] getglobal  0   0        ; R0 := print
0047  45400000           [07] getglobal  1   1        ; R1 := getmetatable
004B  81C00000           [08] loadk      2   3        ; R2 := "bar"
004F  5C000001           [09] call       1   2   0    ; R1 to top := R1(R2)
0053  1C400000           [10] call       0   0   1    ;  := R0(R1 to top)
0057  05000000           [11] getglobal  0   0        ; R0 := print
005B  45400000           [12] getglobal  1   1        ; R1 := getmetatable
005F  83000001           [13] loadnil    2   2        ; R2,  := nil
0063  5C000001           [14] call       1   2   0    ; R1 to top := R1(R2)
0067  1C400000           [15] call       0   0   1    ;  := R0(R1 to top)
006B  05000000           [16] getglobal  0   0        ; R0 := print
006F  45400000           [17] getglobal  1   1        ; R1 := getmetatable
0073  82000000           [18] loadbool   2   0   0    ; R2 := false
0077  5C000001           [19] call       1   2   0    ; R1 to top := R1(R2)
007B  1C400000           [20] call       0   0   1    ;  := R0(R1 to top)
007F  05000000           [21] getglobal  0   0        ; R0 := print
0083  45400000           [22] getglobal  1   1        ; R1 := getmetatable
0087  81000100           [23] loadk      2   4        ; R2 := 100
008B  5C000001           [24] call       1   2   0    ; R1 to top := R1(R2)
008F  1C400000           [25] call       0   0   1    ;  := R0(R1 to top)
0093  05000000           [26] getglobal  0   0        ; R0 := print
0097  45400000           [27] getglobal  1   1        ; R1 := getmetatable
009B  8A000000           [28] newtable   2   0   0    ; R2 := {} , array=0, hash=0
009F  5C000001           [29] call       1   2   0    ; R1 to top := R1(R2)
00A3  1C400000           [30] call       0   0   1    ;  := R0(R1 to top)
00A7  05000000           [31] getglobal  0   0        ; R0 := print
00AB  45400000           [32] getglobal  1   1        ; R1 := getmetatable
00AF  85000000           [33] getglobal  2   0        ; R2 := print
00B3  5C000001           [34] call       1   2   0    ; R1 to top := R1(R2)
00B7  1C400000           [35] call       0   0   1    ;  := R0(R1 to top)
00BB  0A000000           [36] newtable   0   0   0    ; R0 := {} , array=0, hash=0
00BF  07400100           [37] setglobal  0   5        ; t := R0
00C3  0A000000           [38] newtable   0   0   0    ; R0 := {} , array=0, hash=0
00C7  07800100           [39] setglobal  0   6        ; mt := R0
00CB  05C00100           [40] getglobal  0   7        ; R0 := setmetatable
00CF  45400100           [41] getglobal  1   5        ; R1 := t
00D3  85800100           [42] getglobal  2   6        ; R2 := mt
00D7  1C408001           [43] call       0   3   1    ;  := R0(R1, R2)
00DB  05000000           [44] getglobal  0   0        ; R0 := print
00DF  45400000           [45] getglobal  1   1        ; R1 := getmetatable
00E3  85400100           [46] getglobal  2   5        ; R2 := t
00E7  5C800001           [47] call       1   2   2    ; R1 := R1(R2)
00EB  85800100           [48] getglobal  2   6        ; R2 := mt
00EF  57808000           [49] eq         1   1   2    ; R1 == R2, pc+=1 (goto [51]) if false
00F3  16000080           [50] jmp        1            ; pc+=1 (goto [52])
00F7  42400000           [51] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [53])
00FB  42008000           [52] loadbool   1   1   0    ; R1 := true
00FF  1C400001           [53] call       0   2   1    ;  := R0(R1)
0103  05000200           [54] getglobal  0   8        ; R0 := debug
0107  06C04100           [55] gettable   0   0   263  ; R0 := R0["setmetatable"]
010B  41000100           [56] loadk      1   4        ; R1 := 100
010F  85800100           [57] getglobal  2   6        ; R2 := mt
0113  1C408001           [58] call       0   3   1    ;  := R0(R1, R2)
0117  05000000           [59] getglobal  0   0        ; R0 := print
011B  45400000           [60] getglobal  1   1        ; R1 := getmetatable
011F  81400200           [61] loadk      2   9        ; R2 := 200
0123  5C800001           [62] call       1   2   2    ; R1 := R1(R2)
0127  85800100           [63] getglobal  2   6        ; R2 := mt
012B  57808000           [64] eq         1   1   2    ; R1 == R2, pc+=1 (goto [66]) if false
012F  16000080           [65] jmp        1            ; pc+=1 (goto [67])
0133  42400000           [66] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [68])
0137  42008000           [67] loadbool   1   1   0    ; R1 := true
013B  1C400001           [68] call       0   2   1    ;  := R0(R1)
013F  0A000000           [69] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0143  07800100           [70] setglobal  0   6        ; mt := R0
0147  05800100           [71] getglobal  0   6        ; R0 := mt
014B  64000000           [72] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
014F  09400085           [73] settable   0   266 1    ; R0["__add"] := R1
0153  24400000           [74] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
0157  07C00200           [75] setglobal  0   11       ; vector := R0
015B  05C00200           [76] getglobal  0   11       ; R0 := vector
015F  41400300           [77] loadk      1   13       ; R1 := 1
0163  81800300           [78] loadk      2   14       ; R2 := 2
0167  1C808001           [79] call       0   3   2    ; R0 := R0(R1, R2)
016B  07000300           [80] setglobal  0   12       ; v1 := R0
016F  05C00200           [81] getglobal  0   11       ; R0 := vector
0173  41000400           [82] loadk      1   16       ; R1 := 3
0177  81400400           [83] loadk      2   17       ; R2 := 5
017B  1C808001           [84] call       0   3   2    ; R0 := R0(R1, R2)
017F  07C00300           [85] setglobal  0   15       ; v2 := R0
0183  05000300           [86] getglobal  0   12       ; R0 := v1
0187  45C00300           [87] getglobal  1   15       ; R1 := v2
018B  0C400000           [88] add        0   0   1    ; R0 := R0 + R1
018F  07800400           [89] setglobal  0   18       ; v3 := R0
0193  05000000           [90] getglobal  0   0        ; R0 := print
0197  45800400           [91] getglobal  1   18       ; R1 := v3
019B  46C0C400           [92] gettable   1   1   275  ; R1 := R1["x"]
019F  85800400           [93] getglobal  2   18       ; R2 := v3
01A3  86004501           [94] gettable   2   2   276  ; R2 := R2["y"]
01A7  1C408001           [95] call       0   3   1    ;  := R0(R1, R2)
01AB  1E008000           [96] return     0   1        ; return 
                         * constants:
01AF  15000000           sizek (21)
01B3  04                 const type 4
01B4  0600000000000000   string size (6)
01BC  7072696E7400       "print\0"
                         const [0]: "print"
01C2  04                 const type 4
01C3  0D00000000000000   string size (13)
01CB  6765746D65746174+  "getmetat"
01D3  61626C6500         "able\0"
                         const [1]: "getmetatable"
01D8  04                 const type 4
01D9  0400000000000000   string size (4)
01E1  666F6F00           "foo\0"
                         const [2]: "foo"
01E5  04                 const type 4
01E6  0400000000000000   string size (4)
01EE  62617200           "bar\0"
                         const [3]: "bar"
01F2  03                 const type 3
01F3  0000000000005940   const [4]: (100)
01FB  04                 const type 4
01FC  0200000000000000   string size (2)
0204  7400               "t\0"
                         const [5]: "t"
0206  04                 const type 4
0207  0300000000000000   string size (3)
020F  6D7400             "mt\0"
                         const [6]: "mt"
0212  04                 const type 4
0213  0D00000000000000   string size (13)
021B  7365746D65746174+  "setmetat"
0223  61626C6500         "able\0"
                         const [7]: "setmetatable"
0228  04                 const type 4
0229  0600000000000000   string size (6)
0231  646562756700       "debug\0"
                         const [8]: "debug"
0237  03                 const type 3
0238  0000000000006940   const [9]: (200)
0240  04                 const type 4
0241  0600000000000000   string size (6)
0249  5F5F61646400       "__add\0"
                         const [10]: "__add"
024F  04                 const type 4
0250  0700000000000000   string size (7)
0258  766563746F7200     "vector\0"
                         const [11]: "vector"
025F  04                 const type 4
0260  0300000000000000   string size (3)
0268  763100             "v1\0"
                         const [12]: "v1"
026B  03                 const type 3
026C  000000000000F03F   const [13]: (1)
0274  03                 const type 3
0275  0000000000000040   const [14]: (2)
027D  04                 const type 4
027E  0300000000000000   string size (3)
0286  763200             "v2\0"
                         const [15]: "v2"
0289  03                 const type 3
028A  0000000000000840   const [16]: (3)
0292  03                 const type 3
0293  0000000000001440   const [17]: (5)
029B  04                 const type 4
029C  0300000000000000   string size (3)
02A4  763300             "v3\0"
                         const [18]: "v3"
02A7  04                 const type 4
02A8  0200000000000000   string size (2)
02B0  7800               "x\0"
                         const [19]: "x"
02B2  04                 const type 4
02B3  0200000000000000   string size (2)
02BB  7900               "y\0"
                         const [20]: "y"
                         * functions:
02BD  02000000           sizep (2)
                         
02C1                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
02C1  0000000000000000   string size (0)
                         source name: (none)
02C9  12000000           line defined (18)
02CD  14000000           last line defined (20)
02D1  00                 nups (0)
02D2  02                 numparams (2)
02D3  00                 is_vararg (0)
02D4  06                 maxstacksize (6)
                         * code:
02D5  0A000000           sizecode (10)
02D9  85000000           [01] getglobal  2   0        ; R2 := vector
02DD  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
02E1  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
02E5  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
02E9  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
02ED  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
02F1  0C410102           [07] add        4   4   5    ; R4 := R4 + R5
02F5  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
02F9  9E000000           [09] return     2   0        ; return R2 to top
02FD  1E008000           [10] return     0   1        ; return 
                         * constants:
0301  03000000           sizek (3)
0305  04                 const type 4
0306  0700000000000000   string size (7)
030E  766563746F7200     "vector\0"
                         const [0]: "vector"
0315  04                 const type 4
0316  0200000000000000   string size (2)
031E  7800               "x\0"
                         const [1]: "x"
0320  04                 const type 4
0321  0200000000000000   string size (2)
0329  7900               "y\0"
                         const [2]: "y"
                         * functions:
032B  00000000           sizep (0)
                         * lines:
032F  0A000000           sizelineinfo (10)
                         [pc] (line)
0333  13000000           [01] (19)
0337  13000000           [02] (19)
033B  13000000           [03] (19)
033F  13000000           [04] (19)
0343  13000000           [05] (19)
0347  13000000           [06] (19)
034B  13000000           [07] (19)
034F  13000000           [08] (19)
0353  13000000           [09] (19)
0357  14000000           [10] (20)
                         * locals:
035B  02000000           sizelocvars (2)
035F  0300000000000000   string size (3)
0367  763100             "v1\0"
                         local [0]: v1
036A  00000000             startpc (0)
036E  09000000             endpc   (9)
0372  0300000000000000   string size (3)
037A  763200             "v2\0"
                         local [1]: v2
037D  00000000             startpc (0)
0381  09000000             endpc   (9)
                         * upvalues:
0385  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0389                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0389  0000000000000000   string size (0)
                         source name: (none)
0391  16000000           line defined (22)
0395  1A000000           last line defined (26)
0399  00                 nups (0)
039A  02                 numparams (2)
039B  00                 is_vararg (0)
039C  06                 maxstacksize (6)
                         * code:
039D  09000000           sizecode (9)
03A1  8A800000           [1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
03A5  89000080           [2] settable   2   256 0    ; R2["x"] := R0
03A9  89408080           [3] settable   2   257 1    ; R2["y"] := R1
03AD  C5800000           [4] getglobal  3   2        ; R3 := setmetatable
03B1  00010001           [5] move       4   2        ; R4 := R2
03B5  45C10000           [6] getglobal  5   3        ; R5 := mt
03B9  DC408001           [7] call       3   3   1    ;  := R3(R4, R5)
03BD  9E000001           [8] return     2   2        ; return R2
03C1  1E008000           [9] return     0   1        ; return 
                         * constants:
03C5  04000000           sizek (4)
03C9  04                 const type 4
03CA  0200000000000000   string size (2)
03D2  7800               "x\0"
                         const [0]: "x"
03D4  04                 const type 4
03D5  0200000000000000   string size (2)
03DD  7900               "y\0"
                         const [1]: "y"
03DF  04                 const type 4
03E0  0D00000000000000   string size (13)
03E8  7365746D65746174+  "setmetat"
03F0  61626C6500         "able\0"
                         const [2]: "setmetatable"
03F5  04                 const type 4
03F6  0300000000000000   string size (3)
03FE  6D7400             "mt\0"
                         const [3]: "mt"
                         * functions:
0401  00000000           sizep (0)
                         * lines:
0405  09000000           sizelineinfo (9)
                         [pc] (line)
0409  17000000           [1] (23)
040D  17000000           [2] (23)
0411  17000000           [3] (23)
0415  18000000           [4] (24)
0419  18000000           [5] (24)
041D  18000000           [6] (24)
0421  18000000           [7] (24)
0425  19000000           [8] (25)
0429  1A000000           [9] (26)
                         * locals:
042D  03000000           sizelocvars (3)
0431  0200000000000000   string size (2)
0439  7800               "x\0"
                         local [0]: x
043B  00000000             startpc (0)
043F  08000000             endpc   (8)
0443  0200000000000000   string size (2)
044B  7900               "y\0"
                         local [1]: y
044D  00000000             startpc (0)
0451  08000000             endpc   (8)
0455  0200000000000000   string size (2)
045D  7600               "v\0"
                         local [2]: v
045F  03000000             startpc (3)
0463  08000000             endpc   (8)
                         * upvalues:
0467  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
046B  60000000           sizelineinfo (96)
                         [pc] (line)
046F  01000000           [01] (1)
0473  01000000           [02] (1)
0477  01000000           [03] (1)
047B  01000000           [04] (1)
047F  01000000           [05] (1)
0483  02000000           [06] (2)
0487  02000000           [07] (2)
048B  02000000           [08] (2)
048F  02000000           [09] (2)
0493  02000000           [10] (2)
0497  03000000           [11] (3)
049B  03000000           [12] (3)
049F  03000000           [13] (3)
04A3  03000000           [14] (3)
04A7  03000000           [15] (3)
04AB  04000000           [16] (4)
04AF  04000000           [17] (4)
04B3  04000000           [18] (4)
04B7  04000000           [19] (4)
04BB  04000000           [20] (4)
04BF  05000000           [21] (5)
04C3  05000000           [22] (5)
04C7  05000000           [23] (5)
04CB  05000000           [24] (5)
04CF  05000000           [25] (5)
04D3  06000000           [26] (6)
04D7  06000000           [27] (6)
04DB  06000000           [28] (6)
04DF  06000000           [29] (6)
04E3  06000000           [30] (6)
04E7  07000000           [31] (7)
04EB  07000000           [32] (7)
04EF  07000000           [33] (7)
04F3  07000000           [34] (7)
04F7  07000000           [35] (7)
04FB  09000000           [36] (9)
04FF  09000000           [37] (9)
0503  0A000000           [38] (10)
0507  0A000000           [39] (10)
050B  0B000000           [40] (11)
050F  0B000000           [41] (11)
0513  0B000000           [42] (11)
0517  0B000000           [43] (11)
051B  0C000000           [44] (12)
051F  0C000000           [45] (12)
0523  0C000000           [46] (12)
0527  0C000000           [47] (12)
052B  0C000000           [48] (12)
052F  0C000000           [49] (12)
0533  0C000000           [50] (12)
0537  0C000000           [51] (12)
053B  0C000000           [52] (12)
053F  0C000000           [53] (12)
0543  0D000000           [54] (13)
0547  0D000000           [55] (13)
054B  0D000000           [56] (13)
054F  0D000000           [57] (13)
0553  0D000000           [58] (13)
0557  0E000000           [59] (14)
055B  0E000000           [60] (14)
055F  0E000000           [61] (14)
0563  0E000000           [62] (14)
0567  0E000000           [63] (14)
056B  0E000000           [64] (14)
056F  0E000000           [65] (14)
0573  0E000000           [66] (14)
0577  0E000000           [67] (14)
057B  0E000000           [68] (14)
057F  11000000           [69] (17)
0583  11000000           [70] (17)
0587  12000000           [71] (18)
058B  14000000           [72] (20)
058F  14000000           [73] (20)
0593  1A000000           [74] (26)
0597  16000000           [75] (22)
059B  1C000000           [76] (28)
059F  1C000000           [77] (28)
05A3  1C000000           [78] (28)
05A7  1C000000           [79] (28)
05AB  1C000000           [80] (28)
05AF  1D000000           [81] (29)
05B3  1D000000           [82] (29)
05B7  1D000000           [83] (29)
05BB  1D000000           [84] (29)
05BF  1D000000           [85] (29)
05C3  1E000000           [86] (30)
05C7  1E000000           [87] (30)
05CB  1E000000           [88] (30)
05CF  1E000000           [89] (30)
05D3  1F000000           [90] (31)
05D7  1F000000           [91] (31)
05DB  1F000000           [92] (31)
05DF  1F000000           [93] (31)
05E3  1F000000           [94] (31)
05E7  1F000000           [95] (31)
05EB  1F000000           [96] (31)
                         * locals:
05EF  00000000           sizelocvars (0)
                         * upvalues:
05F3  00000000           sizeupvalues (0)
                         ** end of function 0 **

05F7                     ** end of chunk **
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
002B  60000000           sizecode (96)
002F  05000000           [01] getglobal  0   0        ; R0 := print
0033  45400000           [02] getglobal  1   1        ; R1 := getmetatable
0037  81800000           [03] loadk      2   2        ; R2 := "foo"
003B  5C000001           [04] call       1   2   0    ; R1 to top := R1(R2)
003F  1C400000           [05] call       0   0   1    ;  := R0(R1 to top)
0043  05000000           [06] getglobal  0   0        ; R0 := print
0047  45400000           [07] getglobal  1   1        ; R1 := getmetatable
004B  81C00000           [08] loadk      2   3        ; R2 := "bar"
004F  5C000001           [09] call       1   2   0    ; R1 to top := R1(R2)
0053  1C400000           [10] call       0   0   1    ;  := R0(R1 to top)
0057  05000000           [11] getglobal  0   0        ; R0 := print
005B  45400000           [12] getglobal  1   1        ; R1 := getmetatable
005F  83000001           [13] loadnil    2   2        ; R2,  := nil
0063  5C000001           [14] call       1   2   0    ; R1 to top := R1(R2)
0067  1C400000           [15] call       0   0   1    ;  := R0(R1 to top)
006B  05000000           [16] getglobal  0   0        ; R0 := print
006F  45400000           [17] getglobal  1   1        ; R1 := getmetatable
0073  82000000           [18] loadbool   2   0   0    ; R2 := false
0077  5C000001           [19] call       1   2   0    ; R1 to top := R1(R2)
007B  1C400000           [20] call       0   0   1    ;  := R0(R1 to top)
007F  05000000           [21] getglobal  0   0        ; R0 := print
0083  45400000           [22] getglobal  1   1        ; R1 := getmetatable
0087  81000100           [23] loadk      2   4        ; R2 := 100
008B  5C000001           [24] call       1   2   0    ; R1 to top := R1(R2)
008F  1C400000           [25] call       0   0   1    ;  := R0(R1 to top)
0093  05000000           [26] getglobal  0   0        ; R0 := print
0097  45400000           [27] getglobal  1   1        ; R1 := getmetatable
009B  8A000000           [28] newtable   2   0   0    ; R2 := {} , array=0, hash=0
009F  5C000001           [29] call       1   2   0    ; R1 to top := R1(R2)
00A3  1C400000           [30] call       0   0   1    ;  := R0(R1 to top)
00A7  05000000           [31] getglobal  0   0        ; R0 := print
00AB  45400000           [32] getglobal  1   1        ; R1 := getmetatable
00AF  85000000           [33] getglobal  2   0        ; R2 := print
00B3  5C000001           [34] call       1   2   0    ; R1 to top := R1(R2)
00B7  1C400000           [35] call       0   0   1    ;  := R0(R1 to top)
00BB  0A000000           [36] newtable   0   0   0    ; R0 := {} , array=0, hash=0
00BF  07400100           [37] setglobal  0   5        ; t := R0
00C3  0A000000           [38] newtable   0   0   0    ; R0 := {} , array=0, hash=0
00C7  07800100           [39] setglobal  0   6        ; mt := R0
00CB  05C00100           [40] getglobal  0   7        ; R0 := setmetatable
00CF  45400100           [41] getglobal  1   5        ; R1 := t
00D3  85800100           [42] getglobal  2   6        ; R2 := mt
00D7  1C408001           [43] call       0   3   1    ;  := R0(R1, R2)
00DB  05000000           [44] getglobal  0   0        ; R0 := print
00DF  45400000           [45] getglobal  1   1        ; R1 := getmetatable
00E3  85400100           [46] getglobal  2   5        ; R2 := t
00E7  5C800001           [47] call       1   2   2    ; R1 := R1(R2)
00EB  85800100           [48] getglobal  2   6        ; R2 := mt
00EF  57808000           [49] eq         1   1   2    ; R1 == R2, pc+=1 (goto [51]) if false
00F3  16000080           [50] jmp        1            ; pc+=1 (goto [52])
00F7  42400000           [51] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [53])
00FB  42008000           [52] loadbool   1   1   0    ; R1 := true
00FF  1C400001           [53] call       0   2   1    ;  := R0(R1)
0103  05000200           [54] getglobal  0   8        ; R0 := debug
0107  06C04100           [55] gettable   0   0   263  ; R0 := R0["setmetatable"]
010B  41000100           [56] loadk      1   4        ; R1 := 100
010F  85800100           [57] getglobal  2   6        ; R2 := mt
0113  1C408001           [58] call       0   3   1    ;  := R0(R1, R2)
0117  05000000           [59] getglobal  0   0        ; R0 := print
011B  45400000           [60] getglobal  1   1        ; R1 := getmetatable
011F  81400200           [61] loadk      2   9        ; R2 := 200
0123  5C800001           [62] call       1   2   2    ; R1 := R1(R2)
0127  85800100           [63] getglobal  2   6        ; R2 := mt
012B  57808000           [64] eq         1   1   2    ; R1 == R2, pc+=1 (goto [66]) if false
012F  16000080           [65] jmp        1            ; pc+=1 (goto [67])
0133  42400000           [66] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [68])
0137  42008000           [67] loadbool   1   1   0    ; R1 := true
013B  1C400001           [68] call       0   2   1    ;  := R0(R1)
013F  0A000000           [69] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0143  07800100           [70] setglobal  0   6        ; mt := R0
0147  05800100           [71] getglobal  0   6        ; R0 := mt
014B  64000000           [72] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
014F  09400085           [73] settable   0   266 1    ; R0["__add"] := R1
0153  24400000           [74] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
0157  07C00200           [75] setglobal  0   11       ; vector := R0
015B  05C00200           [76] getglobal  0   11       ; R0 := vector
015F  41400300           [77] loadk      1   13       ; R1 := 1
0163  81800300           [78] loadk      2   14       ; R2 := 2
0167  1C808001           [79] call       0   3   2    ; R0 := R0(R1, R2)
016B  07000300           [80] setglobal  0   12       ; v1 := R0
016F  05C00200           [81] getglobal  0   11       ; R0 := vector
0173  41000400           [82] loadk      1   16       ; R1 := 3
0177  81400400           [83] loadk      2   17       ; R2 := 5
017B  1C808001           [84] call       0   3   2    ; R0 := R0(R1, R2)
017F  07C00300           [85] setglobal  0   15       ; v2 := R0
0183  05000300           [86] getglobal  0   12       ; R0 := v1
0187  45C00300           [87] getglobal  1   15       ; R1 := v2
018B  0C400000           [88] add        0   0   1    ; R0 := R0 + R1
018F  07800400           [89] setglobal  0   18       ; v3 := R0
0193  05000000           [90] getglobal  0   0        ; R0 := print
0197  45800400           [91] getglobal  1   18       ; R1 := v3
019B  46C0C400           [92] gettable   1   1   275  ; R1 := R1["x"]
019F  85800400           [93] getglobal  2   18       ; R2 := v3
01A3  86004501           [94] gettable   2   2   276  ; R2 := R2["y"]
01A7  1C408001           [95] call       0   3   1    ;  := R0(R1, R2)
01AB  1E008000           [96] return     0   1        ; return 
                         * constants:
01AF  15000000           sizek (21)
01B3  04                 const type 4
01B4  0600000000000000   string size (6)
01BC  7072696E7400       "print\0"
                         const [0]: "print"
01C2  04                 const type 4
01C3  0D00000000000000   string size (13)
01CB  6765746D65746174+  "getmetat"
01D3  61626C6500         "able\0"
                         const [1]: "getmetatable"
01D8  04                 const type 4
01D9  0400000000000000   string size (4)
01E1  666F6F00           "foo\0"
                         const [2]: "foo"
01E5  04                 const type 4
01E6  0400000000000000   string size (4)
01EE  62617200           "bar\0"
                         const [3]: "bar"
01F2  03                 const type 3
01F3  0000000000005940   const [4]: (100)
01FB  04                 const type 4
01FC  0200000000000000   string size (2)
0204  7400               "t\0"
                         const [5]: "t"
0206  04                 const type 4
0207  0300000000000000   string size (3)
020F  6D7400             "mt\0"
                         const [6]: "mt"
0212  04                 const type 4
0213  0D00000000000000   string size (13)
021B  7365746D65746174+  "setmetat"
0223  61626C6500         "able\0"
                         const [7]: "setmetatable"
0228  04                 const type 4
0229  0600000000000000   string size (6)
0231  646562756700       "debug\0"
                         const [8]: "debug"
0237  03                 const type 3
0238  0000000000006940   const [9]: (200)
0240  04                 const type 4
0241  0600000000000000   string size (6)
0249  5F5F61646400       "__add\0"
                         const [10]: "__add"
024F  04                 const type 4
0250  0700000000000000   string size (7)
0258  766563746F7200     "vector\0"
                         const [11]: "vector"
025F  04                 const type 4
0260  0300000000000000   string size (3)
0268  763100             "v1\0"
                         const [12]: "v1"
026B  03                 const type 3
026C  000000000000F03F   const [13]: (1)
0274  03                 const type 3
0275  0000000000000040   const [14]: (2)
027D  04                 const type 4
027E  0300000000000000   string size (3)
0286  763200             "v2\0"
                         const [15]: "v2"
0289  03                 const type 3
028A  0000000000000840   const [16]: (3)
0292  03                 const type 3
0293  0000000000001440   const [17]: (5)
029B  04                 const type 4
029C  0300000000000000   string size (3)
02A4  763300             "v3\0"
                         const [18]: "v3"
02A7  04                 const type 4
02A8  0200000000000000   string size (2)
02B0  7800               "x\0"
                         const [19]: "x"
02B2  04                 const type 4
02B3  0200000000000000   string size (2)
02BB  7900               "y\0"
                         const [20]: "y"
                         * functions:
02BD  02000000           sizep (2)
                         
02C1                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
02C1  0000000000000000   string size (0)
                         source name: (none)
02C9  12000000           line defined (18)
02CD  14000000           last line defined (20)
02D1  00                 nups (0)
02D2  02                 numparams (2)
02D3  00                 is_vararg (0)
02D4  06                 maxstacksize (6)
                         * code:
02D5  0A000000           sizecode (10)
02D9  85000000           [01] getglobal  2   0        ; R2 := vector
02DD  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
02E1  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
02E5  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
02E9  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
02ED  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
02F1  0C410102           [07] add        4   4   5    ; R4 := R4 + R5
02F5  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
02F9  9E000000           [09] return     2   0        ; return R2 to top
02FD  1E008000           [10] return     0   1        ; return 
                         * constants:
0301  03000000           sizek (3)
0305  04                 const type 4
0306  0700000000000000   string size (7)
030E  766563746F7200     "vector\0"
                         const [0]: "vector"
0315  04                 const type 4
0316  0200000000000000   string size (2)
031E  7800               "x\0"
                         const [1]: "x"
0320  04                 const type 4
0321  0200000000000000   string size (2)
0329  7900               "y\0"
                         const [2]: "y"
                         * functions:
032B  00000000           sizep (0)
                         * lines:
032F  0A000000           sizelineinfo (10)
                         [pc] (line)
0333  13000000           [01] (19)
0337  13000000           [02] (19)
033B  13000000           [03] (19)
033F  13000000           [04] (19)
0343  13000000           [05] (19)
0347  13000000           [06] (19)
034B  13000000           [07] (19)
034F  13000000           [08] (19)
0353  13000000           [09] (19)
0357  14000000           [10] (20)
                         * locals:
035B  02000000           sizelocvars (2)
035F  0300000000000000   string size (3)
0367  763100             "v1\0"
                         local [0]: v1
036A  00000000             startpc (0)
036E  09000000             endpc   (9)
0372  0300000000000000   string size (3)
037A  763200             "v2\0"
                         local [1]: v2
037D  00000000             startpc (0)
0381  09000000             endpc   (9)
                         * upvalues:
0385  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0389                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0389  0000000000000000   string size (0)
                         source name: (none)
0391  16000000           line defined (22)
0395  1A000000           last line defined (26)
0399  00                 nups (0)
039A  02                 numparams (2)
039B  00                 is_vararg (0)
039C  06                 maxstacksize (6)
                         * code:
039D  09000000           sizecode (9)
03A1  8A800000           [1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
03A5  89000080           [2] settable   2   256 0    ; R2["x"] := R0
03A9  89408080           [3] settable   2   257 1    ; R2["y"] := R1
03AD  C5800000           [4] getglobal  3   2        ; R3 := setmetatable
03B1  00010001           [5] move       4   2        ; R4 := R2
03B5  45C10000           [6] getglobal  5   3        ; R5 := mt
03B9  DC408001           [7] call       3   3   1    ;  := R3(R4, R5)
03BD  9E000001           [8] return     2   2        ; return R2
03C1  1E008000           [9] return     0   1        ; return 
                         * constants:
03C5  04000000           sizek (4)
03C9  04                 const type 4
03CA  0200000000000000   string size (2)
03D2  7800               "x\0"
                         const [0]: "x"
03D4  04                 const type 4
03D5  0200000000000000   string size (2)
03DD  7900               "y\0"
                         const [1]: "y"
03DF  04                 const type 4
03E0  0D00000000000000   string size (13)
03E8  7365746D65746174+  "setmetat"
03F0  61626C6500         "able\0"
                         const [2]: "setmetatable"
03F5  04                 const type 4
03F6  0300000000000000   string size (3)
03FE  6D7400             "mt\0"
                         const [3]: "mt"
                         * functions:
0401  00000000           sizep (0)
                         * lines:
0405  09000000           sizelineinfo (9)
                         [pc] (line)
0409  17000000           [1] (23)
040D  17000000           [2] (23)
0411  17000000           [3] (23)
0415  18000000           [4] (24)
0419  18000000           [5] (24)
041D  18000000           [6] (24)
0421  18000000           [7] (24)
0425  19000000           [8] (25)
0429  1A000000           [9] (26)
                         * locals:
042D  03000000           sizelocvars (3)
0431  0200000000000000   string size (2)
0439  7800               "x\0"
                         local [0]: x
043B  00000000             startpc (0)
043F  08000000             endpc   (8)
0443  0200000000000000   string size (2)
044B  7900               "y\0"
                         local [1]: y
044D  00000000             startpc (0)
0451  08000000             endpc   (8)
0455  0200000000000000   string size (2)
045D  7600               "v\0"
                         local [2]: v
045F  03000000             startpc (3)
0463  08000000             endpc   (8)
                         * upvalues:
0467  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
046B  60000000           sizelineinfo (96)
                         [pc] (line)
046F  01000000           [01] (1)
0473  01000000           [02] (1)
0477  01000000           [03] (1)
047B  01000000           [04] (1)
047F  01000000           [05] (1)
0483  02000000           [06] (2)
0487  02000000           [07] (2)
048B  02000000           [08] (2)
048F  02000000           [09] (2)
0493  02000000           [10] (2)
0497  03000000           [11] (3)
049B  03000000           [12] (3)
049F  03000000           [13] (3)
04A3  03000000           [14] (3)
04A7  03000000           [15] (3)
04AB  04000000           [16] (4)
04AF  04000000           [17] (4)
04B3  04000000           [18] (4)
04B7  04000000           [19] (4)
04BB  04000000           [20] (4)
04BF  05000000           [21] (5)
04C3  05000000           [22] (5)
04C7  05000000           [23] (5)
04CB  05000000           [24] (5)
04CF  05000000           [25] (5)
04D3  06000000           [26] (6)
04D7  06000000           [27] (6)
04DB  06000000           [28] (6)
04DF  06000000           [29] (6)
04E3  06000000           [30] (6)
04E7  07000000           [31] (7)
04EB  07000000           [32] (7)
04EF  07000000           [33] (7)
04F3  07000000           [34] (7)
04F7  07000000           [35] (7)
04FB  09000000           [36] (9)
04FF  09000000           [37] (9)
0503  0A000000           [38] (10)
0507  0A000000           [39] (10)
050B  0B000000           [40] (11)
050F  0B000000           [41] (11)
0513  0B000000           [42] (11)
0517  0B000000           [43] (11)
051B  0C000000           [44] (12)
051F  0C000000           [45] (12)
0523  0C000000           [46] (12)
0527  0C000000           [47] (12)
052B  0C000000           [48] (12)
052F  0C000000           [49] (12)
0533  0C000000           [50] (12)
0537  0C000000           [51] (12)
053B  0C000000           [52] (12)
053F  0C000000           [53] (12)
0543  0D000000           [54] (13)
0547  0D000000           [55] (13)
054B  0D000000           [56] (13)
054F  0D000000           [57] (13)
0553  0D000000           [58] (13)
0557  0E000000           [59] (14)
055B  0E000000           [60] (14)
055F  0E000000           [61] (14)
0563  0E000000           [62] (14)
0567  0E000000           [63] (14)
056B  0E000000           [64] (14)
056F  0E000000           [65] (14)
0573  0E000000           [66] (14)
0577  0E000000           [67] (14)
057B  0E000000           [68] (14)
057F  11000000           [69] (17)
0583  11000000           [70] (17)
0587  12000000           [71] (18)
058B  14000000           [72] (20)
058F  14000000           [73] (20)
0593  1A000000           [74] (26)
0597  16000000           [75] (22)
059B  1C000000           [76] (28)
059F  1C000000           [77] (28)
05A3  1C000000           [78] (28)
05A7  1C000000           [79] (28)
05AB  1C000000           [80] (28)
05AF  1D000000           [81] (29)
05B3  1D000000           [82] (29)
05B7  1D000000           [83] (29)
05BB  1D000000           [84] (29)
05BF  1D000000           [85] (29)
05C3  1E000000           [86] (30)
05C7  1E000000           [87] (30)
05CB  1E000000           [88] (30)
05CF  1E000000           [89] (30)
05D3  1F000000           [90] (31)
05D7  1F000000           [91] (31)
05DB  1F000000           [92] (31)
05DF  1F000000           [93] (31)
05E3  1F000000           [94] (31)
05E7  1F000000           [95] (31)
05EB  1F000000           [96] (31)
                         * locals:
05EF  00000000           sizelocvars (0)
                         * upvalues:
05F3  00000000           sizeupvalues (0)
                         ** end of function 0 **

05F7                     ** end of chunk **
