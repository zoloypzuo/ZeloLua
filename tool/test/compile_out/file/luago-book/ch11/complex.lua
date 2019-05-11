------------------------------
local mt = {} -- metatable for complex numbers
mt.__add = function(x, y)
  return {
    a = x.a + y.a, 
    b = x.b + y.b
  }
end
mt.__sub = function(x, y)
  return {
    a = x.a - y.a, 
    b = x.b - y.b
  }
end
mt.__mul = function(x, y)
  return {
    a = x.a * y.a - x.b * y.b,
    b = x.b * y.a + x.a * y.b
  }
end
mt.__eq = function(x, y)
  return x.a == y.a and x.b == y.b
end
mt.__tostring = function(x)
  return "(" .. x.a .. " + " .. x.b + "i)" 
end

function newComplex(a, b)
  t = {a = a, b = b}
  setmetatable(t, mt)
  return t
end

local function assert(arg)
  if not arg then fail() end
end

local c1 = newComplex(3, 5)
local c2 = newComplex(3, 5)
local c3 = newComplex(4, 1)
local c4 = c2 + c3
assert(c1 == c2 and c2 ~= c3)
assert(c4.a == 7 and c4.b == 6)

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "mt"  ; 0
.local  "assert"  ; 1
.local  "c1"  ; 2
.local  "c2"  ; 3
.local  "c3"  ; 4
.local  "c4"  ; 5
.const  "__add"  ; 0
.const  "__sub"  ; 1
.const  "__mul"  ; 2
.const  "__eq"  ; 3
.const  "__tostring"  ; 4
.const  "newComplex"  ; 5
.const  3  ; 6
.const  5  ; 7
.const  4  ; 8
.const  1  ; 9
.const  "a"  ; 10
.const  7  ; 11
.const  "b"  ; 12
.const  6  ; 13
[01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[02] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[03] settable   0   256 1    ; R0["__add"] := R1
[04] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[05] settable   0   257 1    ; R0["__sub"] := R1
[06] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[07] settable   0   258 1    ; R0["__mul"] := R1
[08] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[09] settable   0   259 1    ; R0["__eq"] := R1
[10] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
[11] settable   0   260 1    ; R0["__tostring"] := R1
[12] closure    1   5        ; R1 := closure(function[5]) 1 upvalues
[13] move       0   0        ; R0 := R0
[14] setglobal  1   5        ; newComplex := R1
[15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
[16] getglobal  2   5        ; R2 := newComplex
[17] loadk      3   6        ; R3 := 3
[18] loadk      4   7        ; R4 := 5
[19] call       2   3   2    ; R2 := R2(R3, R4)
[20] getglobal  3   5        ; R3 := newComplex
[21] loadk      4   6        ; R4 := 3
[22] loadk      5   7        ; R5 := 5
[23] call       3   3   2    ; R3 := R3(R4, R5)
[24] getglobal  4   5        ; R4 := newComplex
[25] loadk      5   8        ; R5 := 4
[26] loadk      6   9        ; R6 := 1
[27] call       4   3   2    ; R4 := R4(R5, R6)
[28] add        5   3   4    ; R5 := R3 + R4
[29] move       6   1        ; R6 := R1
[30] eq         0   2   3    ; R2 == R3, pc+=1 (goto [32]) if true
[31] jmp        2            ; pc+=2 (goto [34])
[32] eq         0   3   4    ; R3 == R4, pc+=1 (goto [34]) if true
[33] jmp        1            ; pc+=1 (goto [35])
[34] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [36])
[35] loadbool   7   1   0    ; R7 := true
[36] call       6   2   1    ;  := R6(R7)
[37] move       6   1        ; R6 := R1
[38] gettable   7   5   266  ; R7 := R5["a"]
[39] eq         0   7   267  ; R7 == 7, pc+=1 (goto [41]) if true
[40] jmp        3            ; pc+=3 (goto [44])
[41] gettable   7   5   268  ; R7 := R5["b"]
[42] eq         1   7   269  ; R7 == 6, pc+=1 (goto [44]) if false
[43] jmp        1            ; pc+=1 (goto [45])
[44] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [46])
[45] loadbool   7   1   0    ; R7 := true
[46] call       6   2   1    ;  := R6(R7)
[47] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] add        3   3   4    ; R3 := R3 + R4
[05] settable   2   256 3    ; R2["a"] := R3
[06] gettable   3   0   257  ; R3 := R0["b"]
[07] gettable   4   1   257  ; R4 := R1["b"]
[08] add        3   3   4    ; R3 := R3 + R4
[09] settable   2   257 3    ; R2["b"] := R3
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] sub        3   3   4    ; R3 := R3 - R4
[05] settable   2   256 3    ; R2["a"] := R3
[06] gettable   3   0   257  ; R3 := R0["b"]
[07] gettable   4   1   257  ; R4 := R1["b"]
[08] sub        3   3   4    ; R3 := R3 - R4
[09] settable   2   257 3    ; R2["b"] := R3
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] mul        3   3   4    ; R3 := R3 * R4
[05] gettable   4   0   257  ; R4 := R0["b"]
[06] gettable   5   1   257  ; R5 := R1["b"]
[07] mul        4   4   5    ; R4 := R4 * R5
[08] sub        3   3   4    ; R3 := R3 - R4
[09] settable   2   256 3    ; R2["a"] := R3
[10] gettable   3   0   257  ; R3 := R0["b"]
[11] gettable   4   1   256  ; R4 := R1["a"]
[12] mul        3   3   4    ; R3 := R3 * R4
[13] gettable   4   0   256  ; R4 := R0["a"]
[14] gettable   5   1   257  ; R5 := R1["b"]
[15] mul        4   4   5    ; R4 := R4 * R5
[16] add        3   3   4    ; R3 := R3 + R4
[17] settable   2   257 3    ; R2["b"] := R3
[18] return     2   2        ; return R2
[19] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] gettable   2   0   256  ; R2 := R0["a"]
[02] gettable   3   1   256  ; R3 := R1["a"]
[03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
[04] jmp        4            ; pc+=4 (goto [9])
[05] gettable   2   0   257  ; R2 := R0["b"]
[06] gettable   3   1   257  ; R3 := R1["b"]
[07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
[08] jmp        1            ; pc+=1 (goto [10])
[09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
[10] loadbool   2   1   0    ; R2 := true
[11] return     2   2        ; return R2
[12] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 1 params, is_vararg = 0, 5 stacks
.function  0 1 0 5
.local  "x"  ; 0
.const  "("  ; 0
.const  "a"  ; 1
.const  " + "  ; 2
.const  "b"  ; 3
.const  "i)"  ; 4
[1] loadk      1   0        ; R1 := "("
[2] gettable   2   0   257  ; R2 := R0["a"]
[3] loadk      3   2        ; R3 := " + "
[4] gettable   4   0   259  ; R4 := R0["b"]
[5] add        4   4   260  ; R4 := R4 + "i)"
[6] concat     1   1   4    ; R1 := R1..R2..R3..R4
[7] return     1   2        ; return R1
[8] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 1 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  1 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.upvalue  "mt"  ; 0
.const  "t"  ; 0
.const  "a"  ; 1
.const  "b"  ; 2
.const  "setmetatable"  ; 3
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] settable   2   257 0    ; R2["a"] := R0
[03] settable   2   258 1    ; R2["b"] := R1
[04] setglobal  2   0        ; t := R2
[05] getglobal  2   3        ; R2 := setmetatable
[06] getglobal  3   0        ; R3 := t
[07] getupval   4   0        ; R4 := U0 , mt
[08] call       2   3   1    ;  := R2(R3, R4)
[09] getglobal  2   0        ; R2 := t
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "arg"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
; end of function 0_6

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "mt"  ; 0
.local  "assert"  ; 1
.local  "c1"  ; 2
.local  "c2"  ; 3
.local  "c3"  ; 4
.local  "c4"  ; 5
.const  "__add"  ; 0
.const  "__sub"  ; 1
.const  "__mul"  ; 2
.const  "__eq"  ; 3
.const  "__tostring"  ; 4
.const  "newComplex"  ; 5
.const  3  ; 6
.const  5  ; 7
.const  4  ; 8
.const  1  ; 9
.const  "a"  ; 10
.const  7  ; 11
.const  "b"  ; 12
.const  6  ; 13
[01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[02] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[03] settable   0   256 1    ; R0["__add"] := R1
[04] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[05] settable   0   257 1    ; R0["__sub"] := R1
[06] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[07] settable   0   258 1    ; R0["__mul"] := R1
[08] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[09] settable   0   259 1    ; R0["__eq"] := R1
[10] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
[11] settable   0   260 1    ; R0["__tostring"] := R1
[12] closure    1   5        ; R1 := closure(function[5]) 1 upvalues
[13] move       0   0        ; R0 := R0
[14] setglobal  1   5        ; newComplex := R1
[15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
[16] getglobal  2   5        ; R2 := newComplex
[17] loadk      3   6        ; R3 := 3
[18] loadk      4   7        ; R4 := 5
[19] call       2   3   2    ; R2 := R2(R3, R4)
[20] getglobal  3   5        ; R3 := newComplex
[21] loadk      4   6        ; R4 := 3
[22] loadk      5   7        ; R5 := 5
[23] call       3   3   2    ; R3 := R3(R4, R5)
[24] getglobal  4   5        ; R4 := newComplex
[25] loadk      5   8        ; R5 := 4
[26] loadk      6   9        ; R6 := 1
[27] call       4   3   2    ; R4 := R4(R5, R6)
[28] add        5   3   4    ; R5 := R3 + R4
[29] move       6   1        ; R6 := R1
[30] eq         0   2   3    ; R2 == R3, pc+=1 (goto [32]) if true
[31] jmp        2            ; pc+=2 (goto [34])
[32] eq         0   3   4    ; R3 == R4, pc+=1 (goto [34]) if true
[33] jmp        1            ; pc+=1 (goto [35])
[34] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [36])
[35] loadbool   7   1   0    ; R7 := true
[36] call       6   2   1    ;  := R6(R7)
[37] move       6   1        ; R6 := R1
[38] gettable   7   5   266  ; R7 := R5["a"]
[39] eq         0   7   267  ; R7 == 7, pc+=1 (goto [41]) if true
[40] jmp        3            ; pc+=3 (goto [44])
[41] gettable   7   5   268  ; R7 := R5["b"]
[42] eq         1   7   269  ; R7 == 6, pc+=1 (goto [44]) if false
[43] jmp        1            ; pc+=1 (goto [45])
[44] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [46])
[45] loadbool   7   1   0    ; R7 := true
[46] call       6   2   1    ;  := R6(R7)
[47] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] add        3   3   4    ; R3 := R3 + R4
[05] settable   2   256 3    ; R2["a"] := R3
[06] gettable   3   0   257  ; R3 := R0["b"]
[07] gettable   4   1   257  ; R4 := R1["b"]
[08] add        3   3   4    ; R3 := R3 + R4
[09] settable   2   257 3    ; R2["b"] := R3
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] sub        3   3   4    ; R3 := R3 - R4
[05] settable   2   256 3    ; R2["a"] := R3
[06] gettable   3   0   257  ; R3 := R0["b"]
[07] gettable   4   1   257  ; R4 := R1["b"]
[08] sub        3   3   4    ; R3 := R3 - R4
[09] settable   2   257 3    ; R2["b"] := R3
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] gettable   3   0   256  ; R3 := R0["a"]
[03] gettable   4   1   256  ; R4 := R1["a"]
[04] mul        3   3   4    ; R3 := R3 * R4
[05] gettable   4   0   257  ; R4 := R0["b"]
[06] gettable   5   1   257  ; R5 := R1["b"]
[07] mul        4   4   5    ; R4 := R4 * R5
[08] sub        3   3   4    ; R3 := R3 - R4
[09] settable   2   256 3    ; R2["a"] := R3
[10] gettable   3   0   257  ; R3 := R0["b"]
[11] gettable   4   1   256  ; R4 := R1["a"]
[12] mul        3   3   4    ; R3 := R3 * R4
[13] gettable   4   0   256  ; R4 := R0["a"]
[14] gettable   5   1   257  ; R5 := R1["b"]
[15] mul        4   4   5    ; R4 := R4 * R5
[16] add        3   3   4    ; R3 := R3 + R4
[17] settable   2   257 3    ; R2["b"] := R3
[18] return     2   2        ; return R2
[19] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "x"  ; 0
.local  "y"  ; 1
.const  "a"  ; 0
.const  "b"  ; 1
[01] gettable   2   0   256  ; R2 := R0["a"]
[02] gettable   3   1   256  ; R3 := R1["a"]
[03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
[04] jmp        4            ; pc+=4 (goto [9])
[05] gettable   2   0   257  ; R2 := R0["b"]
[06] gettable   3   1   257  ; R3 := R1["b"]
[07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
[08] jmp        1            ; pc+=1 (goto [10])
[09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
[10] loadbool   2   1   0    ; R2 := true
[11] return     2   2        ; return R2
[12] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 1 params, is_vararg = 0, 5 stacks
.function  0 1 0 5
.local  "x"  ; 0
.const  "("  ; 0
.const  "a"  ; 1
.const  " + "  ; 2
.const  "b"  ; 3
.const  "i)"  ; 4
[1] loadk      1   0        ; R1 := "("
[2] gettable   2   0   257  ; R2 := R0["a"]
[3] loadk      3   2        ; R3 := " + "
[4] gettable   4   0   259  ; R4 := R0["b"]
[5] add        4   4   260  ; R4 := R4 + "i)"
[6] concat     1   1   4    ; R1 := R1..R2..R3..R4
[7] return     1   2        ; return R1
[8] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 1 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  1 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.upvalue  "mt"  ; 0
.const  "t"  ; 0
.const  "a"  ; 1
.const  "b"  ; 2
.const  "setmetatable"  ; 3
[01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[02] settable   2   257 0    ; R2["a"] := R0
[03] settable   2   258 1    ; R2["b"] := R1
[04] setglobal  2   0        ; t := R2
[05] getglobal  2   3        ; R2 := setmetatable
[06] getglobal  3   0        ; R3 := t
[07] getupval   4   0        ; R4 := U0 , mt
[08] call       2   3   1    ;  := R2(R3, R4)
[09] getglobal  2   0        ; R2 := t
[10] return     2   2        ; return R2
[11] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "arg"  ; 0
.const  "fail"  ; 0
[1] test       0       1    ; if not R0 then pc+=1 (goto [3])
[2] jmp        2            ; pc+=2 (goto [5])
[3] getglobal  1   0        ; R1 := fail
[4] call       1   1   1    ;  := R1()
[5] return     0   1        ; return 
; end of function 0_6

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
002B  2F000000           sizecode (47)
002F  0A000000           [01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [02] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09400080           [03] settable   0   256 1    ; R0["__add"] := R1
003B  64400000           [04] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
003F  09408080           [05] settable   0   257 1    ; R0["__sub"] := R1
0043  64800000           [06] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
0047  09400081           [07] settable   0   258 1    ; R0["__mul"] := R1
004B  64C00000           [08] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
004F  09408081           [09] settable   0   259 1    ; R0["__eq"] := R1
0053  64000100           [10] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
0057  09400082           [11] settable   0   260 1    ; R0["__tostring"] := R1
005B  64400100           [12] closure    1   5        ; R1 := closure(function[5]) 1 upvalues
005F  00000000           [13] move       0   0        ; R0 := R0
0063  47400100           [14] setglobal  1   5        ; newComplex := R1
0067  64800100           [15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
006B  85400100           [16] getglobal  2   5        ; R2 := newComplex
006F  C1800100           [17] loadk      3   6        ; R3 := 3
0073  01C10100           [18] loadk      4   7        ; R4 := 5
0077  9C808001           [19] call       2   3   2    ; R2 := R2(R3, R4)
007B  C5400100           [20] getglobal  3   5        ; R3 := newComplex
007F  01810100           [21] loadk      4   6        ; R4 := 3
0083  41C10100           [22] loadk      5   7        ; R5 := 5
0087  DC808001           [23] call       3   3   2    ; R3 := R3(R4, R5)
008B  05410100           [24] getglobal  4   5        ; R4 := newComplex
008F  41010200           [25] loadk      5   8        ; R5 := 4
0093  81410200           [26] loadk      6   9        ; R6 := 1
0097  1C818001           [27] call       4   3   2    ; R4 := R4(R5, R6)
009B  4C018101           [28] add        5   3   4    ; R5 := R3 + R4
009F  80018000           [29] move       6   1        ; R6 := R1
00A3  17C00001           [30] eq         0   2   3    ; R2 == R3, pc+=1 (goto [32]) if true
00A7  16400080           [31] jmp        2            ; pc+=2 (goto [34])
00AB  17008101           [32] eq         0   3   4    ; R3 == R4, pc+=1 (goto [34]) if true
00AF  16000080           [33] jmp        1            ; pc+=1 (goto [35])
00B3  C2410000           [34] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [36])
00B7  C2018000           [35] loadbool   7   1   0    ; R7 := true
00BB  9C410001           [36] call       6   2   1    ;  := R6(R7)
00BF  80018000           [37] move       6   1        ; R6 := R1
00C3  C681C202           [38] gettable   7   5   266  ; R7 := R5["a"]
00C7  17C0C203           [39] eq         0   7   267  ; R7 == 7, pc+=1 (goto [41]) if true
00CB  16800080           [40] jmp        3            ; pc+=3 (goto [44])
00CF  C601C302           [41] gettable   7   5   268  ; R7 := R5["b"]
00D3  5740C303           [42] eq         1   7   269  ; R7 == 6, pc+=1 (goto [44]) if false
00D7  16000080           [43] jmp        1            ; pc+=1 (goto [45])
00DB  C2410000           [44] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [46])
00DF  C2018000           [45] loadbool   7   1   0    ; R7 := true
00E3  9C410001           [46] call       6   2   1    ;  := R6(R7)
00E7  1E008000           [47] return     0   1        ; return 
                         * constants:
00EB  0E000000           sizek (14)
00EF  04                 const type 4
00F0  0600000000000000   string size (6)
00F8  5F5F61646400       "__add\0"
                         const [0]: "__add"
00FE  04                 const type 4
00FF  0600000000000000   string size (6)
0107  5F5F73756200       "__sub\0"
                         const [1]: "__sub"
010D  04                 const type 4
010E  0600000000000000   string size (6)
0116  5F5F6D756C00       "__mul\0"
                         const [2]: "__mul"
011C  04                 const type 4
011D  0500000000000000   string size (5)
0125  5F5F657100         "__eq\0"
                         const [3]: "__eq"
012A  04                 const type 4
012B  0B00000000000000   string size (11)
0133  5F5F746F73747269+  "__tostri"
013B  6E6700             "ng\0"
                         const [4]: "__tostring"
013E  04                 const type 4
013F  0B00000000000000   string size (11)
0147  6E6577436F6D706C+  "newCompl"
014F  657800             "ex\0"
                         const [5]: "newComplex"
0152  03                 const type 3
0153  0000000000000840   const [6]: (3)
015B  03                 const type 3
015C  0000000000001440   const [7]: (5)
0164  03                 const type 3
0165  0000000000001040   const [8]: (4)
016D  03                 const type 3
016E  000000000000F03F   const [9]: (1)
0176  04                 const type 4
0177  0200000000000000   string size (2)
017F  6100               "a\0"
                         const [10]: "a"
0181  03                 const type 3
0182  0000000000001C40   const [11]: (7)
018A  04                 const type 4
018B  0200000000000000   string size (2)
0193  6200               "b\0"
                         const [12]: "b"
0195  03                 const type 3
0196  0000000000001840   const [13]: (6)
                         * functions:
019E  07000000           sizep (7)
                         
01A2                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
01A2  0000000000000000   string size (0)
                         source name: (none)
01AA  02000000           line defined (2)
01AE  07000000           last line defined (7)
01B2  00                 nups (0)
01B3  02                 numparams (2)
01B4  00                 is_vararg (0)
01B5  05                 maxstacksize (5)
                         * code:
01B6  0B000000           sizecode (11)
01BA  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
01BE  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
01C2  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
01C6  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
01CA  89C00080           [05] settable   2   256 3    ; R2["a"] := R3
01CE  C6404000           [06] gettable   3   0   257  ; R3 := R0["b"]
01D2  0641C000           [07] gettable   4   1   257  ; R4 := R1["b"]
01D6  CC008101           [08] add        3   3   4    ; R3 := R3 + R4
01DA  89C08080           [09] settable   2   257 3    ; R2["b"] := R3
01DE  9E000001           [10] return     2   2        ; return R2
01E2  1E008000           [11] return     0   1        ; return 
                         * constants:
01E6  02000000           sizek (2)
01EA  04                 const type 4
01EB  0200000000000000   string size (2)
01F3  6100               "a\0"
                         const [0]: "a"
01F5  04                 const type 4
01F6  0200000000000000   string size (2)
01FE  6200               "b\0"
                         const [1]: "b"
                         * functions:
0200  00000000           sizep (0)
                         * lines:
0204  0B000000           sizelineinfo (11)
                         [pc] (line)
0208  03000000           [01] (3)
020C  04000000           [02] (4)
0210  04000000           [03] (4)
0214  04000000           [04] (4)
0218  04000000           [05] (4)
021C  05000000           [06] (5)
0220  05000000           [07] (5)
0224  05000000           [08] (5)
0228  05000000           [09] (5)
022C  06000000           [10] (6)
0230  07000000           [11] (7)
                         * locals:
0234  02000000           sizelocvars (2)
0238  0200000000000000   string size (2)
0240  7800               "x\0"
                         local [0]: x
0242  00000000             startpc (0)
0246  0A000000             endpc   (10)
024A  0200000000000000   string size (2)
0252  7900               "y\0"
                         local [1]: y
0254  00000000             startpc (0)
0258  0A000000             endpc   (10)
                         * upvalues:
025C  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0260                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0260  0000000000000000   string size (0)
                         source name: (none)
0268  08000000           line defined (8)
026C  0D000000           last line defined (13)
0270  00                 nups (0)
0271  02                 numparams (2)
0272  00                 is_vararg (0)
0273  05                 maxstacksize (5)
                         * code:
0274  0B000000           sizecode (11)
0278  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
027C  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
0280  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
0284  CD008101           [04] sub        3   3   4    ; R3 := R3 - R4
0288  89C00080           [05] settable   2   256 3    ; R2["a"] := R3
028C  C6404000           [06] gettable   3   0   257  ; R3 := R0["b"]
0290  0641C000           [07] gettable   4   1   257  ; R4 := R1["b"]
0294  CD008101           [08] sub        3   3   4    ; R3 := R3 - R4
0298  89C08080           [09] settable   2   257 3    ; R2["b"] := R3
029C  9E000001           [10] return     2   2        ; return R2
02A0  1E008000           [11] return     0   1        ; return 
                         * constants:
02A4  02000000           sizek (2)
02A8  04                 const type 4
02A9  0200000000000000   string size (2)
02B1  6100               "a\0"
                         const [0]: "a"
02B3  04                 const type 4
02B4  0200000000000000   string size (2)
02BC  6200               "b\0"
                         const [1]: "b"
                         * functions:
02BE  00000000           sizep (0)
                         * lines:
02C2  0B000000           sizelineinfo (11)
                         [pc] (line)
02C6  09000000           [01] (9)
02CA  0A000000           [02] (10)
02CE  0A000000           [03] (10)
02D2  0A000000           [04] (10)
02D6  0A000000           [05] (10)
02DA  0B000000           [06] (11)
02DE  0B000000           [07] (11)
02E2  0B000000           [08] (11)
02E6  0B000000           [09] (11)
02EA  0C000000           [10] (12)
02EE  0D000000           [11] (13)
                         * locals:
02F2  02000000           sizelocvars (2)
02F6  0200000000000000   string size (2)
02FE  7800               "x\0"
                         local [0]: x
0300  00000000             startpc (0)
0304  0A000000             endpc   (10)
0308  0200000000000000   string size (2)
0310  7900               "y\0"
                         local [1]: y
0312  00000000             startpc (0)
0316  0A000000             endpc   (10)
                         * upvalues:
031A  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
031E                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
031E  0000000000000000   string size (0)
                         source name: (none)
0326  0E000000           line defined (14)
032A  13000000           last line defined (19)
032E  00                 nups (0)
032F  02                 numparams (2)
0330  00                 is_vararg (0)
0331  06                 maxstacksize (6)
                         * code:
0332  13000000           sizecode (19)
0336  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
033A  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
033E  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
0342  CE008101           [04] mul        3   3   4    ; R3 := R3 * R4
0346  06414000           [05] gettable   4   0   257  ; R4 := R0["b"]
034A  4641C000           [06] gettable   5   1   257  ; R5 := R1["b"]
034E  0E410102           [07] mul        4   4   5    ; R4 := R4 * R5
0352  CD008101           [08] sub        3   3   4    ; R3 := R3 - R4
0356  89C00080           [09] settable   2   256 3    ; R2["a"] := R3
035A  C6404000           [10] gettable   3   0   257  ; R3 := R0["b"]
035E  0601C000           [11] gettable   4   1   256  ; R4 := R1["a"]
0362  CE008101           [12] mul        3   3   4    ; R3 := R3 * R4
0366  06014000           [13] gettable   4   0   256  ; R4 := R0["a"]
036A  4641C000           [14] gettable   5   1   257  ; R5 := R1["b"]
036E  0E410102           [15] mul        4   4   5    ; R4 := R4 * R5
0372  CC008101           [16] add        3   3   4    ; R3 := R3 + R4
0376  89C08080           [17] settable   2   257 3    ; R2["b"] := R3
037A  9E000001           [18] return     2   2        ; return R2
037E  1E008000           [19] return     0   1        ; return 
                         * constants:
0382  02000000           sizek (2)
0386  04                 const type 4
0387  0200000000000000   string size (2)
038F  6100               "a\0"
                         const [0]: "a"
0391  04                 const type 4
0392  0200000000000000   string size (2)
039A  6200               "b\0"
                         const [1]: "b"
                         * functions:
039C  00000000           sizep (0)
                         * lines:
03A0  13000000           sizelineinfo (19)
                         [pc] (line)
03A4  0F000000           [01] (15)
03A8  10000000           [02] (16)
03AC  10000000           [03] (16)
03B0  10000000           [04] (16)
03B4  10000000           [05] (16)
03B8  10000000           [06] (16)
03BC  10000000           [07] (16)
03C0  10000000           [08] (16)
03C4  10000000           [09] (16)
03C8  11000000           [10] (17)
03CC  11000000           [11] (17)
03D0  11000000           [12] (17)
03D4  11000000           [13] (17)
03D8  11000000           [14] (17)
03DC  11000000           [15] (17)
03E0  11000000           [16] (17)
03E4  11000000           [17] (17)
03E8  12000000           [18] (18)
03EC  13000000           [19] (19)
                         * locals:
03F0  02000000           sizelocvars (2)
03F4  0200000000000000   string size (2)
03FC  7800               "x\0"
                         local [0]: x
03FE  00000000             startpc (0)
0402  12000000             endpc   (18)
0406  0200000000000000   string size (2)
040E  7900               "y\0"
                         local [1]: y
0410  00000000             startpc (0)
0414  12000000             endpc   (18)
                         * upvalues:
0418  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
041C                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
041C  0000000000000000   string size (0)
                         source name: (none)
0424  14000000           line defined (20)
0428  16000000           last line defined (22)
042C  00                 nups (0)
042D  02                 numparams (2)
042E  00                 is_vararg (0)
042F  04                 maxstacksize (4)
                         * code:
0430  0C000000           sizecode (12)
0434  86004000           [01] gettable   2   0   256  ; R2 := R0["a"]
0438  C600C000           [02] gettable   3   1   256  ; R3 := R1["a"]
043C  17C00001           [03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
0440  16C00080           [04] jmp        4            ; pc+=4 (goto [9])
0444  86404000           [05] gettable   2   0   257  ; R2 := R0["b"]
0448  C640C000           [06] gettable   3   1   257  ; R3 := R1["b"]
044C  57C00001           [07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
0450  16000080           [08] jmp        1            ; pc+=1 (goto [10])
0454  82400000           [09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
0458  82008000           [10] loadbool   2   1   0    ; R2 := true
045C  9E000001           [11] return     2   2        ; return R2
0460  1E008000           [12] return     0   1        ; return 
                         * constants:
0464  02000000           sizek (2)
0468  04                 const type 4
0469  0200000000000000   string size (2)
0471  6100               "a\0"
                         const [0]: "a"
0473  04                 const type 4
0474  0200000000000000   string size (2)
047C  6200               "b\0"
                         const [1]: "b"
                         * functions:
047E  00000000           sizep (0)
                         * lines:
0482  0C000000           sizelineinfo (12)
                         [pc] (line)
0486  15000000           [01] (21)
048A  15000000           [02] (21)
048E  15000000           [03] (21)
0492  15000000           [04] (21)
0496  15000000           [05] (21)
049A  15000000           [06] (21)
049E  15000000           [07] (21)
04A2  15000000           [08] (21)
04A6  15000000           [09] (21)
04AA  15000000           [10] (21)
04AE  15000000           [11] (21)
04B2  16000000           [12] (22)
                         * locals:
04B6  02000000           sizelocvars (2)
04BA  0200000000000000   string size (2)
04C2  7800               "x\0"
                         local [0]: x
04C4  00000000             startpc (0)
04C8  0B000000             endpc   (11)
04CC  0200000000000000   string size (2)
04D4  7900               "y\0"
                         local [1]: y
04D6  00000000             startpc (0)
04DA  0B000000             endpc   (11)
                         * upvalues:
04DE  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
04E2                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
04E2  0000000000000000   string size (0)
                         source name: (none)
04EA  17000000           line defined (23)
04EE  19000000           last line defined (25)
04F2  00                 nups (0)
04F3  01                 numparams (1)
04F4  00                 is_vararg (0)
04F5  05                 maxstacksize (5)
                         * code:
04F6  08000000           sizecode (8)
04FA  41000000           [1] loadk      1   0        ; R1 := "("
04FE  86404000           [2] gettable   2   0   257  ; R2 := R0["a"]
0502  C1800000           [3] loadk      3   2        ; R3 := " + "
0506  06C14000           [4] gettable   4   0   259  ; R4 := R0["b"]
050A  0C014102           [5] add        4   4   260  ; R4 := R4 + "i)"
050E  55008100           [6] concat     1   1   4    ; R1 := R1..R2..R3..R4
0512  5E000001           [7] return     1   2        ; return R1
0516  1E008000           [8] return     0   1        ; return 
                         * constants:
051A  05000000           sizek (5)
051E  04                 const type 4
051F  0200000000000000   string size (2)
0527  2800               "(\0"
                         const [0]: "("
0529  04                 const type 4
052A  0200000000000000   string size (2)
0532  6100               "a\0"
                         const [1]: "a"
0534  04                 const type 4
0535  0400000000000000   string size (4)
053D  202B2000           " + \0"
                         const [2]: " + "
0541  04                 const type 4
0542  0200000000000000   string size (2)
054A  6200               "b\0"
                         const [3]: "b"
054C  04                 const type 4
054D  0300000000000000   string size (3)
0555  692900             "i)\0"
                         const [4]: "i)"
                         * functions:
0558  00000000           sizep (0)
                         * lines:
055C  08000000           sizelineinfo (8)
                         [pc] (line)
0560  18000000           [1] (24)
0564  18000000           [2] (24)
0568  18000000           [3] (24)
056C  18000000           [4] (24)
0570  18000000           [5] (24)
0574  18000000           [6] (24)
0578  18000000           [7] (24)
057C  19000000           [8] (25)
                         * locals:
0580  01000000           sizelocvars (1)
0584  0200000000000000   string size (2)
058C  7800               "x\0"
                         local [0]: x
058E  00000000             startpc (0)
0592  07000000             endpc   (7)
                         * upvalues:
0596  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
059A                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
059A  0000000000000000   string size (0)
                         source name: (none)
05A2  1B000000           line defined (27)
05A6  1F000000           last line defined (31)
05AA  01                 nups (1)
05AB  02                 numparams (2)
05AC  00                 is_vararg (0)
05AD  05                 maxstacksize (5)
                         * code:
05AE  0B000000           sizecode (11)
05B2  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
05B6  89008080           [02] settable   2   257 0    ; R2["a"] := R0
05BA  89400081           [03] settable   2   258 1    ; R2["b"] := R1
05BE  87000000           [04] setglobal  2   0        ; t := R2
05C2  85C00000           [05] getglobal  2   3        ; R2 := setmetatable
05C6  C5000000           [06] getglobal  3   0        ; R3 := t
05CA  04010000           [07] getupval   4   0        ; R4 := U0 , mt
05CE  9C408001           [08] call       2   3   1    ;  := R2(R3, R4)
05D2  85000000           [09] getglobal  2   0        ; R2 := t
05D6  9E000001           [10] return     2   2        ; return R2
05DA  1E008000           [11] return     0   1        ; return 
                         * constants:
05DE  04000000           sizek (4)
05E2  04                 const type 4
05E3  0200000000000000   string size (2)
05EB  7400               "t\0"
                         const [0]: "t"
05ED  04                 const type 4
05EE  0200000000000000   string size (2)
05F6  6100               "a\0"
                         const [1]: "a"
05F8  04                 const type 4
05F9  0200000000000000   string size (2)
0601  6200               "b\0"
                         const [2]: "b"
0603  04                 const type 4
0604  0D00000000000000   string size (13)
060C  7365746D65746174+  "setmetat"
0614  61626C6500         "able\0"
                         const [3]: "setmetatable"
                         * functions:
0619  00000000           sizep (0)
                         * lines:
061D  0B000000           sizelineinfo (11)
                         [pc] (line)
0621  1C000000           [01] (28)
0625  1C000000           [02] (28)
0629  1C000000           [03] (28)
062D  1C000000           [04] (28)
0631  1D000000           [05] (29)
0635  1D000000           [06] (29)
0639  1D000000           [07] (29)
063D  1D000000           [08] (29)
0641  1E000000           [09] (30)
0645  1E000000           [10] (30)
0649  1F000000           [11] (31)
                         * locals:
064D  02000000           sizelocvars (2)
0651  0200000000000000   string size (2)
0659  6100               "a\0"
                         local [0]: a
065B  00000000             startpc (0)
065F  0A000000             endpc   (10)
0663  0200000000000000   string size (2)
066B  6200               "b\0"
                         local [1]: b
066D  00000000             startpc (0)
0671  0A000000             endpc   (10)
                         * upvalues:
0675  01000000           sizeupvalues (1)
0679  0300000000000000   string size (3)
0681  6D7400             "mt\0"
                         upvalue [0]: mt
                         ** end of function 0_5 **

                         
0684                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
0684  0000000000000000   string size (0)
                         source name: (none)
068C  21000000           line defined (33)
0690  23000000           last line defined (35)
0694  00                 nups (0)
0695  01                 numparams (1)
0696  00                 is_vararg (0)
0697  02                 maxstacksize (2)
                         * code:
0698  05000000           sizecode (5)
069C  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
06A0  16400080           [2] jmp        2            ; pc+=2 (goto [5])
06A4  45000000           [3] getglobal  1   0        ; R1 := fail
06A8  5C408000           [4] call       1   1   1    ;  := R1()
06AC  1E008000           [5] return     0   1        ; return 
                         * constants:
06B0  01000000           sizek (1)
06B4  04                 const type 4
06B5  0500000000000000   string size (5)
06BD  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
06C2  00000000           sizep (0)
                         * lines:
06C6  05000000           sizelineinfo (5)
                         [pc] (line)
06CA  22000000           [1] (34)
06CE  22000000           [2] (34)
06D2  22000000           [3] (34)
06D6  22000000           [4] (34)
06DA  23000000           [5] (35)
                         * locals:
06DE  01000000           sizelocvars (1)
06E2  0400000000000000   string size (4)
06EA  61726700           "arg\0"
                         local [0]: arg
06EE  00000000             startpc (0)
06F2  04000000             endpc   (4)
                         * upvalues:
06F6  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         * lines:
06FA  2F000000           sizelineinfo (47)
                         [pc] (line)
06FE  01000000           [01] (1)
0702  07000000           [02] (7)
0706  07000000           [03] (7)
070A  0D000000           [04] (13)
070E  0D000000           [05] (13)
0712  13000000           [06] (19)
0716  13000000           [07] (19)
071A  16000000           [08] (22)
071E  16000000           [09] (22)
0722  19000000           [10] (25)
0726  19000000           [11] (25)
072A  1F000000           [12] (31)
072E  1F000000           [13] (31)
0732  1B000000           [14] (27)
0736  23000000           [15] (35)
073A  25000000           [16] (37)
073E  25000000           [17] (37)
0742  25000000           [18] (37)
0746  25000000           [19] (37)
074A  26000000           [20] (38)
074E  26000000           [21] (38)
0752  26000000           [22] (38)
0756  26000000           [23] (38)
075A  27000000           [24] (39)
075E  27000000           [25] (39)
0762  27000000           [26] (39)
0766  27000000           [27] (39)
076A  28000000           [28] (40)
076E  29000000           [29] (41)
0772  29000000           [30] (41)
0776  29000000           [31] (41)
077A  29000000           [32] (41)
077E  29000000           [33] (41)
0782  29000000           [34] (41)
0786  29000000           [35] (41)
078A  29000000           [36] (41)
078E  2A000000           [37] (42)
0792  2A000000           [38] (42)
0796  2A000000           [39] (42)
079A  2A000000           [40] (42)
079E  2A000000           [41] (42)
07A2  2A000000           [42] (42)
07A6  2A000000           [43] (42)
07AA  2A000000           [44] (42)
07AE  2A000000           [45] (42)
07B2  2A000000           [46] (42)
07B6  2A000000           [47] (42)
                         * locals:
07BA  06000000           sizelocvars (6)
07BE  0300000000000000   string size (3)
07C6  6D7400             "mt\0"
                         local [0]: mt
07C9  01000000             startpc (1)
07CD  2E000000             endpc   (46)
07D1  0700000000000000   string size (7)
07D9  61737365727400     "assert\0"
                         local [1]: assert
07E0  0F000000             startpc (15)
07E4  2E000000             endpc   (46)
07E8  0300000000000000   string size (3)
07F0  633100             "c1\0"
                         local [2]: c1
07F3  13000000             startpc (19)
07F7  2E000000             endpc   (46)
07FB  0300000000000000   string size (3)
0803  633200             "c2\0"
                         local [3]: c2
0806  17000000             startpc (23)
080A  2E000000             endpc   (46)
080E  0300000000000000   string size (3)
0816  633300             "c3\0"
                         local [4]: c3
0819  1B000000             startpc (27)
081D  2E000000             endpc   (46)
0821  0300000000000000   string size (3)
0829  633400             "c4\0"
                         local [5]: c4
082C  1C000000             startpc (28)
0830  2E000000             endpc   (46)
                         * upvalues:
0834  00000000           sizeupvalues (0)
                         ** end of function 0 **

0838                     ** end of chunk **
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
002B  2F000000           sizecode (47)
002F  0A000000           [01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [02] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0037  09400080           [03] settable   0   256 1    ; R0["__add"] := R1
003B  64400000           [04] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
003F  09408080           [05] settable   0   257 1    ; R0["__sub"] := R1
0043  64800000           [06] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
0047  09400081           [07] settable   0   258 1    ; R0["__mul"] := R1
004B  64C00000           [08] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
004F  09408081           [09] settable   0   259 1    ; R0["__eq"] := R1
0053  64000100           [10] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
0057  09400082           [11] settable   0   260 1    ; R0["__tostring"] := R1
005B  64400100           [12] closure    1   5        ; R1 := closure(function[5]) 1 upvalues
005F  00000000           [13] move       0   0        ; R0 := R0
0063  47400100           [14] setglobal  1   5        ; newComplex := R1
0067  64800100           [15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
006B  85400100           [16] getglobal  2   5        ; R2 := newComplex
006F  C1800100           [17] loadk      3   6        ; R3 := 3
0073  01C10100           [18] loadk      4   7        ; R4 := 5
0077  9C808001           [19] call       2   3   2    ; R2 := R2(R3, R4)
007B  C5400100           [20] getglobal  3   5        ; R3 := newComplex
007F  01810100           [21] loadk      4   6        ; R4 := 3
0083  41C10100           [22] loadk      5   7        ; R5 := 5
0087  DC808001           [23] call       3   3   2    ; R3 := R3(R4, R5)
008B  05410100           [24] getglobal  4   5        ; R4 := newComplex
008F  41010200           [25] loadk      5   8        ; R5 := 4
0093  81410200           [26] loadk      6   9        ; R6 := 1
0097  1C818001           [27] call       4   3   2    ; R4 := R4(R5, R6)
009B  4C018101           [28] add        5   3   4    ; R5 := R3 + R4
009F  80018000           [29] move       6   1        ; R6 := R1
00A3  17C00001           [30] eq         0   2   3    ; R2 == R3, pc+=1 (goto [32]) if true
00A7  16400080           [31] jmp        2            ; pc+=2 (goto [34])
00AB  17008101           [32] eq         0   3   4    ; R3 == R4, pc+=1 (goto [34]) if true
00AF  16000080           [33] jmp        1            ; pc+=1 (goto [35])
00B3  C2410000           [34] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [36])
00B7  C2018000           [35] loadbool   7   1   0    ; R7 := true
00BB  9C410001           [36] call       6   2   1    ;  := R6(R7)
00BF  80018000           [37] move       6   1        ; R6 := R1
00C3  C681C202           [38] gettable   7   5   266  ; R7 := R5["a"]
00C7  17C0C203           [39] eq         0   7   267  ; R7 == 7, pc+=1 (goto [41]) if true
00CB  16800080           [40] jmp        3            ; pc+=3 (goto [44])
00CF  C601C302           [41] gettable   7   5   268  ; R7 := R5["b"]
00D3  5740C303           [42] eq         1   7   269  ; R7 == 6, pc+=1 (goto [44]) if false
00D7  16000080           [43] jmp        1            ; pc+=1 (goto [45])
00DB  C2410000           [44] loadbool   7   0   1    ; R7 := false; PC := pc+=1 (goto [46])
00DF  C2018000           [45] loadbool   7   1   0    ; R7 := true
00E3  9C410001           [46] call       6   2   1    ;  := R6(R7)
00E7  1E008000           [47] return     0   1        ; return 
                         * constants:
00EB  0E000000           sizek (14)
00EF  04                 const type 4
00F0  0600000000000000   string size (6)
00F8  5F5F61646400       "__add\0"
                         const [0]: "__add"
00FE  04                 const type 4
00FF  0600000000000000   string size (6)
0107  5F5F73756200       "__sub\0"
                         const [1]: "__sub"
010D  04                 const type 4
010E  0600000000000000   string size (6)
0116  5F5F6D756C00       "__mul\0"
                         const [2]: "__mul"
011C  04                 const type 4
011D  0500000000000000   string size (5)
0125  5F5F657100         "__eq\0"
                         const [3]: "__eq"
012A  04                 const type 4
012B  0B00000000000000   string size (11)
0133  5F5F746F73747269+  "__tostri"
013B  6E6700             "ng\0"
                         const [4]: "__tostring"
013E  04                 const type 4
013F  0B00000000000000   string size (11)
0147  6E6577436F6D706C+  "newCompl"
014F  657800             "ex\0"
                         const [5]: "newComplex"
0152  03                 const type 3
0153  0000000000000840   const [6]: (3)
015B  03                 const type 3
015C  0000000000001440   const [7]: (5)
0164  03                 const type 3
0165  0000000000001040   const [8]: (4)
016D  03                 const type 3
016E  000000000000F03F   const [9]: (1)
0176  04                 const type 4
0177  0200000000000000   string size (2)
017F  6100               "a\0"
                         const [10]: "a"
0181  03                 const type 3
0182  0000000000001C40   const [11]: (7)
018A  04                 const type 4
018B  0200000000000000   string size (2)
0193  6200               "b\0"
                         const [12]: "b"
0195  03                 const type 3
0196  0000000000001840   const [13]: (6)
                         * functions:
019E  07000000           sizep (7)
                         
01A2                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
01A2  0000000000000000   string size (0)
                         source name: (none)
01AA  02000000           line defined (2)
01AE  07000000           last line defined (7)
01B2  00                 nups (0)
01B3  02                 numparams (2)
01B4  00                 is_vararg (0)
01B5  05                 maxstacksize (5)
                         * code:
01B6  0B000000           sizecode (11)
01BA  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
01BE  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
01C2  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
01C6  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
01CA  89C00080           [05] settable   2   256 3    ; R2["a"] := R3
01CE  C6404000           [06] gettable   3   0   257  ; R3 := R0["b"]
01D2  0641C000           [07] gettable   4   1   257  ; R4 := R1["b"]
01D6  CC008101           [08] add        3   3   4    ; R3 := R3 + R4
01DA  89C08080           [09] settable   2   257 3    ; R2["b"] := R3
01DE  9E000001           [10] return     2   2        ; return R2
01E2  1E008000           [11] return     0   1        ; return 
                         * constants:
01E6  02000000           sizek (2)
01EA  04                 const type 4
01EB  0200000000000000   string size (2)
01F3  6100               "a\0"
                         const [0]: "a"
01F5  04                 const type 4
01F6  0200000000000000   string size (2)
01FE  6200               "b\0"
                         const [1]: "b"
                         * functions:
0200  00000000           sizep (0)
                         * lines:
0204  0B000000           sizelineinfo (11)
                         [pc] (line)
0208  03000000           [01] (3)
020C  04000000           [02] (4)
0210  04000000           [03] (4)
0214  04000000           [04] (4)
0218  04000000           [05] (4)
021C  05000000           [06] (5)
0220  05000000           [07] (5)
0224  05000000           [08] (5)
0228  05000000           [09] (5)
022C  06000000           [10] (6)
0230  07000000           [11] (7)
                         * locals:
0234  02000000           sizelocvars (2)
0238  0200000000000000   string size (2)
0240  7800               "x\0"
                         local [0]: x
0242  00000000             startpc (0)
0246  0A000000             endpc   (10)
024A  0200000000000000   string size (2)
0252  7900               "y\0"
                         local [1]: y
0254  00000000             startpc (0)
0258  0A000000             endpc   (10)
                         * upvalues:
025C  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0260                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0260  0000000000000000   string size (0)
                         source name: (none)
0268  08000000           line defined (8)
026C  0D000000           last line defined (13)
0270  00                 nups (0)
0271  02                 numparams (2)
0272  00                 is_vararg (0)
0273  05                 maxstacksize (5)
                         * code:
0274  0B000000           sizecode (11)
0278  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
027C  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
0280  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
0284  CD008101           [04] sub        3   3   4    ; R3 := R3 - R4
0288  89C00080           [05] settable   2   256 3    ; R2["a"] := R3
028C  C6404000           [06] gettable   3   0   257  ; R3 := R0["b"]
0290  0641C000           [07] gettable   4   1   257  ; R4 := R1["b"]
0294  CD008101           [08] sub        3   3   4    ; R3 := R3 - R4
0298  89C08080           [09] settable   2   257 3    ; R2["b"] := R3
029C  9E000001           [10] return     2   2        ; return R2
02A0  1E008000           [11] return     0   1        ; return 
                         * constants:
02A4  02000000           sizek (2)
02A8  04                 const type 4
02A9  0200000000000000   string size (2)
02B1  6100               "a\0"
                         const [0]: "a"
02B3  04                 const type 4
02B4  0200000000000000   string size (2)
02BC  6200               "b\0"
                         const [1]: "b"
                         * functions:
02BE  00000000           sizep (0)
                         * lines:
02C2  0B000000           sizelineinfo (11)
                         [pc] (line)
02C6  09000000           [01] (9)
02CA  0A000000           [02] (10)
02CE  0A000000           [03] (10)
02D2  0A000000           [04] (10)
02D6  0A000000           [05] (10)
02DA  0B000000           [06] (11)
02DE  0B000000           [07] (11)
02E2  0B000000           [08] (11)
02E6  0B000000           [09] (11)
02EA  0C000000           [10] (12)
02EE  0D000000           [11] (13)
                         * locals:
02F2  02000000           sizelocvars (2)
02F6  0200000000000000   string size (2)
02FE  7800               "x\0"
                         local [0]: x
0300  00000000             startpc (0)
0304  0A000000             endpc   (10)
0308  0200000000000000   string size (2)
0310  7900               "y\0"
                         local [1]: y
0312  00000000             startpc (0)
0316  0A000000             endpc   (10)
                         * upvalues:
031A  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
031E                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
031E  0000000000000000   string size (0)
                         source name: (none)
0326  0E000000           line defined (14)
032A  13000000           last line defined (19)
032E  00                 nups (0)
032F  02                 numparams (2)
0330  00                 is_vararg (0)
0331  06                 maxstacksize (6)
                         * code:
0332  13000000           sizecode (19)
0336  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
033A  C6004000           [02] gettable   3   0   256  ; R3 := R0["a"]
033E  0601C000           [03] gettable   4   1   256  ; R4 := R1["a"]
0342  CE008101           [04] mul        3   3   4    ; R3 := R3 * R4
0346  06414000           [05] gettable   4   0   257  ; R4 := R0["b"]
034A  4641C000           [06] gettable   5   1   257  ; R5 := R1["b"]
034E  0E410102           [07] mul        4   4   5    ; R4 := R4 * R5
0352  CD008101           [08] sub        3   3   4    ; R3 := R3 - R4
0356  89C00080           [09] settable   2   256 3    ; R2["a"] := R3
035A  C6404000           [10] gettable   3   0   257  ; R3 := R0["b"]
035E  0601C000           [11] gettable   4   1   256  ; R4 := R1["a"]
0362  CE008101           [12] mul        3   3   4    ; R3 := R3 * R4
0366  06014000           [13] gettable   4   0   256  ; R4 := R0["a"]
036A  4641C000           [14] gettable   5   1   257  ; R5 := R1["b"]
036E  0E410102           [15] mul        4   4   5    ; R4 := R4 * R5
0372  CC008101           [16] add        3   3   4    ; R3 := R3 + R4
0376  89C08080           [17] settable   2   257 3    ; R2["b"] := R3
037A  9E000001           [18] return     2   2        ; return R2
037E  1E008000           [19] return     0   1        ; return 
                         * constants:
0382  02000000           sizek (2)
0386  04                 const type 4
0387  0200000000000000   string size (2)
038F  6100               "a\0"
                         const [0]: "a"
0391  04                 const type 4
0392  0200000000000000   string size (2)
039A  6200               "b\0"
                         const [1]: "b"
                         * functions:
039C  00000000           sizep (0)
                         * lines:
03A0  13000000           sizelineinfo (19)
                         [pc] (line)
03A4  0F000000           [01] (15)
03A8  10000000           [02] (16)
03AC  10000000           [03] (16)
03B0  10000000           [04] (16)
03B4  10000000           [05] (16)
03B8  10000000           [06] (16)
03BC  10000000           [07] (16)
03C0  10000000           [08] (16)
03C4  10000000           [09] (16)
03C8  11000000           [10] (17)
03CC  11000000           [11] (17)
03D0  11000000           [12] (17)
03D4  11000000           [13] (17)
03D8  11000000           [14] (17)
03DC  11000000           [15] (17)
03E0  11000000           [16] (17)
03E4  11000000           [17] (17)
03E8  12000000           [18] (18)
03EC  13000000           [19] (19)
                         * locals:
03F0  02000000           sizelocvars (2)
03F4  0200000000000000   string size (2)
03FC  7800               "x\0"
                         local [0]: x
03FE  00000000             startpc (0)
0402  12000000             endpc   (18)
0406  0200000000000000   string size (2)
040E  7900               "y\0"
                         local [1]: y
0410  00000000             startpc (0)
0414  12000000             endpc   (18)
                         * upvalues:
0418  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
041C                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
041C  0000000000000000   string size (0)
                         source name: (none)
0424  14000000           line defined (20)
0428  16000000           last line defined (22)
042C  00                 nups (0)
042D  02                 numparams (2)
042E  00                 is_vararg (0)
042F  04                 maxstacksize (4)
                         * code:
0430  0C000000           sizecode (12)
0434  86004000           [01] gettable   2   0   256  ; R2 := R0["a"]
0438  C600C000           [02] gettable   3   1   256  ; R3 := R1["a"]
043C  17C00001           [03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
0440  16C00080           [04] jmp        4            ; pc+=4 (goto [9])
0444  86404000           [05] gettable   2   0   257  ; R2 := R0["b"]
0448  C640C000           [06] gettable   3   1   257  ; R3 := R1["b"]
044C  57C00001           [07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
0450  16000080           [08] jmp        1            ; pc+=1 (goto [10])
0454  82400000           [09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
0458  82008000           [10] loadbool   2   1   0    ; R2 := true
045C  9E000001           [11] return     2   2        ; return R2
0460  1E008000           [12] return     0   1        ; return 
                         * constants:
0464  02000000           sizek (2)
0468  04                 const type 4
0469  0200000000000000   string size (2)
0471  6100               "a\0"
                         const [0]: "a"
0473  04                 const type 4
0474  0200000000000000   string size (2)
047C  6200               "b\0"
                         const [1]: "b"
                         * functions:
047E  00000000           sizep (0)
                         * lines:
0482  0C000000           sizelineinfo (12)
                         [pc] (line)
0486  15000000           [01] (21)
048A  15000000           [02] (21)
048E  15000000           [03] (21)
0492  15000000           [04] (21)
0496  15000000           [05] (21)
049A  15000000           [06] (21)
049E  15000000           [07] (21)
04A2  15000000           [08] (21)
04A6  15000000           [09] (21)
04AA  15000000           [10] (21)
04AE  15000000           [11] (21)
04B2  16000000           [12] (22)
                         * locals:
04B6  02000000           sizelocvars (2)
04BA  0200000000000000   string size (2)
04C2  7800               "x\0"
                         local [0]: x
04C4  00000000             startpc (0)
04C8  0B000000             endpc   (11)
04CC  0200000000000000   string size (2)
04D4  7900               "y\0"
                         local [1]: y
04D6  00000000             startpc (0)
04DA  0B000000             endpc   (11)
                         * upvalues:
04DE  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
04E2                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
04E2  0000000000000000   string size (0)
                         source name: (none)
04EA  17000000           line defined (23)
04EE  19000000           last line defined (25)
04F2  00                 nups (0)
04F3  01                 numparams (1)
04F4  00                 is_vararg (0)
04F5  05                 maxstacksize (5)
                         * code:
04F6  08000000           sizecode (8)
04FA  41000000           [1] loadk      1   0        ; R1 := "("
04FE  86404000           [2] gettable   2   0   257  ; R2 := R0["a"]
0502  C1800000           [3] loadk      3   2        ; R3 := " + "
0506  06C14000           [4] gettable   4   0   259  ; R4 := R0["b"]
050A  0C014102           [5] add        4   4   260  ; R4 := R4 + "i)"
050E  55008100           [6] concat     1   1   4    ; R1 := R1..R2..R3..R4
0512  5E000001           [7] return     1   2        ; return R1
0516  1E008000           [8] return     0   1        ; return 
                         * constants:
051A  05000000           sizek (5)
051E  04                 const type 4
051F  0200000000000000   string size (2)
0527  2800               "(\0"
                         const [0]: "("
0529  04                 const type 4
052A  0200000000000000   string size (2)
0532  6100               "a\0"
                         const [1]: "a"
0534  04                 const type 4
0535  0400000000000000   string size (4)
053D  202B2000           " + \0"
                         const [2]: " + "
0541  04                 const type 4
0542  0200000000000000   string size (2)
054A  6200               "b\0"
                         const [3]: "b"
054C  04                 const type 4
054D  0300000000000000   string size (3)
0555  692900             "i)\0"
                         const [4]: "i)"
                         * functions:
0558  00000000           sizep (0)
                         * lines:
055C  08000000           sizelineinfo (8)
                         [pc] (line)
0560  18000000           [1] (24)
0564  18000000           [2] (24)
0568  18000000           [3] (24)
056C  18000000           [4] (24)
0570  18000000           [5] (24)
0574  18000000           [6] (24)
0578  18000000           [7] (24)
057C  19000000           [8] (25)
                         * locals:
0580  01000000           sizelocvars (1)
0584  0200000000000000   string size (2)
058C  7800               "x\0"
                         local [0]: x
058E  00000000             startpc (0)
0592  07000000             endpc   (7)
                         * upvalues:
0596  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
059A                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
059A  0000000000000000   string size (0)
                         source name: (none)
05A2  1B000000           line defined (27)
05A6  1F000000           last line defined (31)
05AA  01                 nups (1)
05AB  02                 numparams (2)
05AC  00                 is_vararg (0)
05AD  05                 maxstacksize (5)
                         * code:
05AE  0B000000           sizecode (11)
05B2  8A800000           [01] newtable   2   0   2    ; R2 := {} , array=0, hash=2
05B6  89008080           [02] settable   2   257 0    ; R2["a"] := R0
05BA  89400081           [03] settable   2   258 1    ; R2["b"] := R1
05BE  87000000           [04] setglobal  2   0        ; t := R2
05C2  85C00000           [05] getglobal  2   3        ; R2 := setmetatable
05C6  C5000000           [06] getglobal  3   0        ; R3 := t
05CA  04010000           [07] getupval   4   0        ; R4 := U0 , mt
05CE  9C408001           [08] call       2   3   1    ;  := R2(R3, R4)
05D2  85000000           [09] getglobal  2   0        ; R2 := t
05D6  9E000001           [10] return     2   2        ; return R2
05DA  1E008000           [11] return     0   1        ; return 
                         * constants:
05DE  04000000           sizek (4)
05E2  04                 const type 4
05E3  0200000000000000   string size (2)
05EB  7400               "t\0"
                         const [0]: "t"
05ED  04                 const type 4
05EE  0200000000000000   string size (2)
05F6  6100               "a\0"
                         const [1]: "a"
05F8  04                 const type 4
05F9  0200000000000000   string size (2)
0601  6200               "b\0"
                         const [2]: "b"
0603  04                 const type 4
0604  0D00000000000000   string size (13)
060C  7365746D65746174+  "setmetat"
0614  61626C6500         "able\0"
                         const [3]: "setmetatable"
                         * functions:
0619  00000000           sizep (0)
                         * lines:
061D  0B000000           sizelineinfo (11)
                         [pc] (line)
0621  1C000000           [01] (28)
0625  1C000000           [02] (28)
0629  1C000000           [03] (28)
062D  1C000000           [04] (28)
0631  1D000000           [05] (29)
0635  1D000000           [06] (29)
0639  1D000000           [07] (29)
063D  1D000000           [08] (29)
0641  1E000000           [09] (30)
0645  1E000000           [10] (30)
0649  1F000000           [11] (31)
                         * locals:
064D  02000000           sizelocvars (2)
0651  0200000000000000   string size (2)
0659  6100               "a\0"
                         local [0]: a
065B  00000000             startpc (0)
065F  0A000000             endpc   (10)
0663  0200000000000000   string size (2)
066B  6200               "b\0"
                         local [1]: b
066D  00000000             startpc (0)
0671  0A000000             endpc   (10)
                         * upvalues:
0675  01000000           sizeupvalues (1)
0679  0300000000000000   string size (3)
0681  6D7400             "mt\0"
                         upvalue [0]: mt
                         ** end of function 0_5 **

                         
0684                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
0684  0000000000000000   string size (0)
                         source name: (none)
068C  21000000           line defined (33)
0690  23000000           last line defined (35)
0694  00                 nups (0)
0695  01                 numparams (1)
0696  00                 is_vararg (0)
0697  02                 maxstacksize (2)
                         * code:
0698  05000000           sizecode (5)
069C  1A400000           [1] test       0       1    ; if not R0 then pc+=1 (goto [3])
06A0  16400080           [2] jmp        2            ; pc+=2 (goto [5])
06A4  45000000           [3] getglobal  1   0        ; R1 := fail
06A8  5C408000           [4] call       1   1   1    ;  := R1()
06AC  1E008000           [5] return     0   1        ; return 
                         * constants:
06B0  01000000           sizek (1)
06B4  04                 const type 4
06B5  0500000000000000   string size (5)
06BD  6661696C00         "fail\0"
                         const [0]: "fail"
                         * functions:
06C2  00000000           sizep (0)
                         * lines:
06C6  05000000           sizelineinfo (5)
                         [pc] (line)
06CA  22000000           [1] (34)
06CE  22000000           [2] (34)
06D2  22000000           [3] (34)
06D6  22000000           [4] (34)
06DA  23000000           [5] (35)
                         * locals:
06DE  01000000           sizelocvars (1)
06E2  0400000000000000   string size (4)
06EA  61726700           "arg\0"
                         local [0]: arg
06EE  00000000             startpc (0)
06F2  04000000             endpc   (4)
                         * upvalues:
06F6  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         * lines:
06FA  2F000000           sizelineinfo (47)
                         [pc] (line)
06FE  01000000           [01] (1)
0702  07000000           [02] (7)
0706  07000000           [03] (7)
070A  0D000000           [04] (13)
070E  0D000000           [05] (13)
0712  13000000           [06] (19)
0716  13000000           [07] (19)
071A  16000000           [08] (22)
071E  16000000           [09] (22)
0722  19000000           [10] (25)
0726  19000000           [11] (25)
072A  1F000000           [12] (31)
072E  1F000000           [13] (31)
0732  1B000000           [14] (27)
0736  23000000           [15] (35)
073A  25000000           [16] (37)
073E  25000000           [17] (37)
0742  25000000           [18] (37)
0746  25000000           [19] (37)
074A  26000000           [20] (38)
074E  26000000           [21] (38)
0752  26000000           [22] (38)
0756  26000000           [23] (38)
075A  27000000           [24] (39)
075E  27000000           [25] (39)
0762  27000000           [26] (39)
0766  27000000           [27] (39)
076A  28000000           [28] (40)
076E  29000000           [29] (41)
0772  29000000           [30] (41)
0776  29000000           [31] (41)
077A  29000000           [32] (41)
077E  29000000           [33] (41)
0782  29000000           [34] (41)
0786  29000000           [35] (41)
078A  29000000           [36] (41)
078E  2A000000           [37] (42)
0792  2A000000           [38] (42)
0796  2A000000           [39] (42)
079A  2A000000           [40] (42)
079E  2A000000           [41] (42)
07A2  2A000000           [42] (42)
07A6  2A000000           [43] (42)
07AA  2A000000           [44] (42)
07AE  2A000000           [45] (42)
07B2  2A000000           [46] (42)
07B6  2A000000           [47] (42)
                         * locals:
07BA  06000000           sizelocvars (6)
07BE  0300000000000000   string size (3)
07C6  6D7400             "mt\0"
                         local [0]: mt
07C9  01000000             startpc (1)
07CD  2E000000             endpc   (46)
07D1  0700000000000000   string size (7)
07D9  61737365727400     "assert\0"
                         local [1]: assert
07E0  0F000000             startpc (15)
07E4  2E000000             endpc   (46)
07E8  0300000000000000   string size (3)
07F0  633100             "c1\0"
                         local [2]: c1
07F3  13000000             startpc (19)
07F7  2E000000             endpc   (46)
07FB  0300000000000000   string size (3)
0803  633200             "c2\0"
                         local [3]: c2
0806  17000000             startpc (23)
080A  2E000000             endpc   (46)
080E  0300000000000000   string size (3)
0816  633300             "c3\0"
                         local [4]: c3
0819  1B000000             startpc (27)
081D  2E000000             endpc   (46)
0821  0300000000000000   string size (3)
0829  633400             "c4\0"
                         local [5]: c4
082C  1C000000             startpc (28)
0830  2E000000             endpc   (46)
                         * upvalues:
0834  00000000           sizeupvalues (0)
                         ** end of function 0 **

0838                     ** end of chunk **
