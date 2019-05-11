------------------------------
local mt = {}

function vector(x, y)
  local v = {x = x, y = y}
  setmetatable(v, mt)
  return v
end

mt.__add = function(v1, v2)
  return vector(v1.x + v2.x, v1.y + v2.y)
end
mt.__sub = function(v1, v2)
  return vector(v1.x - v2.x, v1.y - v2.y)
end
mt.__mul = function(v1, n)
  return vector(v1.x * n, v1.y * n)
end
mt.__div = function(v1, n)
  return vector(v1.x / n, v1.y / n)
end
mt.__len = function(v)
  return (v.x * v.x + v.y * v.y) ^ 0.5
end
mt.__eq = function(v1, v2)
  return v1.x == v2.x and v1.y == v2.y
end
mt.__index = function(v, k)
  if k == "print" then
    return function()
      print("[" .. v.x .. ", " .. v.y .. "]")
    end
  end
end
mt.__call = function(v)
  print("[" .. v.x .. ", " .. v.y .. "]")
end

v1 = vector(1, 2); v1:print()
v2 = vector(3, 4); v2:print()
v3 = v1 * 2;       v3:print()
v4 = v1 + v3;      v4:print()
print(#v2)
print(v1 == v2)
print(v2 == vector(3, 4))
v4()

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "mt"  ; 0
.const  "vector"  ; 0
.const  "__add"  ; 1
.const  "__sub"  ; 2
.const  "__mul"  ; 3
.const  "__div"  ; 4
.const  "__len"  ; 5
.const  "__eq"  ; 6
.const  "__index"  ; 7
.const  "__call"  ; 8
.const  "v1"  ; 9
.const  1  ; 10
.const  2  ; 11
.const  "print"  ; 12
.const  "v2"  ; 13
.const  3  ; 14
.const  4  ; 15
.const  "v3"  ; 16
.const  "v4"  ; 17
[01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[02] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
[03] move       0   0        ; R0 := R0
[04] setglobal  1   0        ; vector := R1
[05] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[06] settable   0   257 1    ; R0["__add"] := R1
[07] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[08] settable   0   258 1    ; R0["__sub"] := R1
[09] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[10] settable   0   259 1    ; R0["__mul"] := R1
[11] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
[12] settable   0   260 1    ; R0["__div"] := R1
[13] closure    1   5        ; R1 := closure(function[5]) 0 upvalues
[14] settable   0   261 1    ; R0["__len"] := R1
[15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
[16] settable   0   262 1    ; R0["__eq"] := R1
[17] closure    1   7        ; R1 := closure(function[7]) 0 upvalues
[18] settable   0   263 1    ; R0["__index"] := R1
[19] closure    1   8        ; R1 := closure(function[8]) 0 upvalues
[20] settable   0   264 1    ; R0["__call"] := R1
[21] getglobal  1   0        ; R1 := vector
[22] loadk      2   10       ; R2 := 1
[23] loadk      3   11       ; R3 := 2
[24] call       1   3   2    ; R1 := R1(R2, R3)
[25] setglobal  1   9        ; v1 := R1
[26] getglobal  1   9        ; R1 := v1
[27] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[28] call       1   2   1    ;  := R1(R2)
[29] getglobal  1   0        ; R1 := vector
[30] loadk      2   14       ; R2 := 3
[31] loadk      3   15       ; R3 := 4
[32] call       1   3   2    ; R1 := R1(R2, R3)
[33] setglobal  1   13       ; v2 := R1
[34] getglobal  1   13       ; R1 := v2
[35] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[36] call       1   2   1    ;  := R1(R2)
[37] getglobal  1   9        ; R1 := v1
[38] mul        1   1   267  ; R1 := R1 * 2
[39] setglobal  1   16       ; v3 := R1
[40] getglobal  1   16       ; R1 := v3
[41] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[42] call       1   2   1    ;  := R1(R2)
[43] getglobal  1   9        ; R1 := v1
[44] getglobal  2   16       ; R2 := v3
[45] add        1   1   2    ; R1 := R1 + R2
[46] setglobal  1   17       ; v4 := R1
[47] getglobal  1   17       ; R1 := v4
[48] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[49] call       1   2   1    ;  := R1(R2)
[50] getglobal  1   12       ; R1 := print
[51] getglobal  2   13       ; R2 := v2
[52] len        2   2        ; R2 := #R2
[53] call       1   2   1    ;  := R1(R2)
[54] getglobal  1   12       ; R1 := print
[55] getglobal  2   9        ; R2 := v1
[56] getglobal  3   13       ; R3 := v2
[57] eq         1   2   3    ; R2 == R3, pc+=1 (goto [59]) if false
[58] jmp        1            ; pc+=1 (goto [60])
[59] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [61])
[60] loadbool   2   1   0    ; R2 := true
[61] call       1   2   1    ;  := R1(R2)
[62] getglobal  1   12       ; R1 := print
[63] getglobal  2   13       ; R2 := v2
[64] getglobal  3   0        ; R3 := vector
[65] loadk      4   14       ; R4 := 3
[66] loadk      5   15       ; R5 := 4
[67] call       3   3   2    ; R3 := R3(R4, R5)
[68] eq         1   2   3    ; R2 == R3, pc+=1 (goto [70]) if false
[69] jmp        1            ; pc+=1 (goto [71])
[70] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [72])
[71] loadbool   2   1   0    ; R2 := true
[72] call       1   2   1    ;  := R1(R2)
[73] getglobal  1   17       ; R1 := v4
[74] call       1   1   1    ;  := R1()
[75] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 1 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  1 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.local  "v"  ; 2
.upvalue  "mt"  ; 0
.const  "x"  ; 0
.const  "y"  ; 1
.const  "setmetatable"  ; 2
[1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[2] settable   2   256 0    ; R2["x"] := R0
[3] settable   2   257 1    ; R2["y"] := R1
[4] getglobal  3   2        ; R3 := setmetatable
[5] move       4   2        ; R4 := R2
[6] getupval   5   0        ; R5 := U0 , mt
[7] call       3   3   1    ;  := R3(R4, R5)
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
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
; end of function 0_1


; function [2] definition (level 2) 0_2
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
[04] sub        3   3   4    ; R3 := R3 - R4
[05] gettable   4   0   258  ; R4 := R0["y"]
[06] gettable   5   1   258  ; R5 := R1["y"]
[07] sub        4   4   5    ; R4 := R4 - R5
[08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[09] return     2   0        ; return R2 to top
[10] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "v1"  ; 0
.local  "n"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[1] getglobal  2   0        ; R2 := vector
[2] gettable   3   0   257  ; R3 := R0["x"]
[3] mul        3   3   1    ; R3 := R3 * R1
[4] gettable   4   0   258  ; R4 := R0["y"]
[5] mul        4   4   1    ; R4 := R4 * R1
[6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[7] return     2   0        ; return R2 to top
[8] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "v1"  ; 0
.local  "n"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[1] getglobal  2   0        ; R2 := vector
[2] gettable   3   0   257  ; R3 := R0["x"]
[3] div        3   3   1    ; R3 := R3 / R1
[4] gettable   4   0   258  ; R4 := R0["y"]
[5] div        4   4   1    ; R4 := R4 / R1
[6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[7] return     2   0        ; return R2 to top
[8] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "v"  ; 0
.const  "x"  ; 0
.const  "y"  ; 1
.const  0.5  ; 2
[01] gettable   1   0   256  ; R1 := R0["x"]
[02] gettable   2   0   256  ; R2 := R0["x"]
[03] mul        1   1   2    ; R1 := R1 * R2
[04] gettable   2   0   257  ; R2 := R0["y"]
[05] gettable   3   0   257  ; R3 := R0["y"]
[06] mul        2   2   3    ; R2 := R2 * R3
[07] add        1   1   2    ; R1 := R1 + R2
[08] pow        1   1   258  ; R1 := R1 ^ 0.5
[09] return     1   2        ; return R1
[10] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "v1"  ; 0
.local  "v2"  ; 1
.const  "x"  ; 0
.const  "y"  ; 1
[01] gettable   2   0   256  ; R2 := R0["x"]
[02] gettable   3   1   256  ; R3 := R1["x"]
[03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
[04] jmp        4            ; pc+=4 (goto [9])
[05] gettable   2   0   257  ; R2 := R0["y"]
[06] gettable   3   1   257  ; R3 := R1["y"]
[07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
[08] jmp        1            ; pc+=1 (goto [10])
[09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
[10] loadbool   2   1   0    ; R2 := true
[11] return     2   2        ; return R2
[12] return     0   1        ; return 
; end of function 0_6


; function [7] definition (level 2) 0_7
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "v"  ; 0
.local  "k"  ; 1
.const  "print"  ; 0
[1] eq         0   1   256  ; R1 == "print", pc+=1 (goto [3]) if true
[2] jmp        3            ; pc+=3 (goto [6])
[3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
[4] move       0   0        ; R0 := R0
[5] return     2   2        ; return R2
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_7_0
; 1 upvalues, 0 params, is_vararg = 0, 6 stacks
.function  1 0 0 6
.upvalue  "v"  ; 0
.const  "print"  ; 0
.const  "["  ; 1
.const  "x"  ; 2
.const  ", "  ; 3
.const  "y"  ; 4
.const  "]"  ; 5
[01] getglobal  0   0        ; R0 := print
[02] loadk      1   1        ; R1 := "["
[03] getupval   2   0        ; R2 := U0 , v
[04] gettable   2   2   258  ; R2 := R2["x"]
[05] loadk      3   3        ; R3 := ", "
[06] getupval   4   0        ; R4 := U0 , v
[07] gettable   4   4   260  ; R4 := R4["y"]
[08] loadk      5   5        ; R5 := "]"
[09] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
[10] call       0   2   1    ;  := R0(R1)
[11] return     0   1        ; return 
; end of function 0_7_0

; end of function 0_7


; function [8] definition (level 2) 0_8
; 0 upvalues, 1 params, is_vararg = 0, 7 stacks
.function  0 1 0 7
.local  "v"  ; 0
.const  "print"  ; 0
.const  "["  ; 1
.const  "x"  ; 2
.const  ", "  ; 3
.const  "y"  ; 4
.const  "]"  ; 5
[1] getglobal  1   0        ; R1 := print
[2] loadk      2   1        ; R2 := "["
[3] gettable   3   0   258  ; R3 := R0["x"]
[4] loadk      4   3        ; R4 := ", "
[5] gettable   5   0   260  ; R5 := R0["y"]
[6] loadk      6   5        ; R6 := "]"
[7] concat     2   2   6    ; R2 := R2..R3..R4..R5..R6
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_8

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "mt"  ; 0
.const  "vector"  ; 0
.const  "__add"  ; 1
.const  "__sub"  ; 2
.const  "__mul"  ; 3
.const  "__div"  ; 4
.const  "__len"  ; 5
.const  "__eq"  ; 6
.const  "__index"  ; 7
.const  "__call"  ; 8
.const  "v1"  ; 9
.const  1  ; 10
.const  2  ; 11
.const  "print"  ; 12
.const  "v2"  ; 13
.const  3  ; 14
.const  4  ; 15
.const  "v3"  ; 16
.const  "v4"  ; 17
[01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
[02] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
[03] move       0   0        ; R0 := R0
[04] setglobal  1   0        ; vector := R1
[05] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[06] settable   0   257 1    ; R0["__add"] := R1
[07] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[08] settable   0   258 1    ; R0["__sub"] := R1
[09] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[10] settable   0   259 1    ; R0["__mul"] := R1
[11] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
[12] settable   0   260 1    ; R0["__div"] := R1
[13] closure    1   5        ; R1 := closure(function[5]) 0 upvalues
[14] settable   0   261 1    ; R0["__len"] := R1
[15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
[16] settable   0   262 1    ; R0["__eq"] := R1
[17] closure    1   7        ; R1 := closure(function[7]) 0 upvalues
[18] settable   0   263 1    ; R0["__index"] := R1
[19] closure    1   8        ; R1 := closure(function[8]) 0 upvalues
[20] settable   0   264 1    ; R0["__call"] := R1
[21] getglobal  1   0        ; R1 := vector
[22] loadk      2   10       ; R2 := 1
[23] loadk      3   11       ; R3 := 2
[24] call       1   3   2    ; R1 := R1(R2, R3)
[25] setglobal  1   9        ; v1 := R1
[26] getglobal  1   9        ; R1 := v1
[27] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[28] call       1   2   1    ;  := R1(R2)
[29] getglobal  1   0        ; R1 := vector
[30] loadk      2   14       ; R2 := 3
[31] loadk      3   15       ; R3 := 4
[32] call       1   3   2    ; R1 := R1(R2, R3)
[33] setglobal  1   13       ; v2 := R1
[34] getglobal  1   13       ; R1 := v2
[35] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[36] call       1   2   1    ;  := R1(R2)
[37] getglobal  1   9        ; R1 := v1
[38] mul        1   1   267  ; R1 := R1 * 2
[39] setglobal  1   16       ; v3 := R1
[40] getglobal  1   16       ; R1 := v3
[41] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[42] call       1   2   1    ;  := R1(R2)
[43] getglobal  1   9        ; R1 := v1
[44] getglobal  2   16       ; R2 := v3
[45] add        1   1   2    ; R1 := R1 + R2
[46] setglobal  1   17       ; v4 := R1
[47] getglobal  1   17       ; R1 := v4
[48] self       1   1   268  ; R2 := R1; R1 := R1["print"]
[49] call       1   2   1    ;  := R1(R2)
[50] getglobal  1   12       ; R1 := print
[51] getglobal  2   13       ; R2 := v2
[52] len        2   2        ; R2 := #R2
[53] call       1   2   1    ;  := R1(R2)
[54] getglobal  1   12       ; R1 := print
[55] getglobal  2   9        ; R2 := v1
[56] getglobal  3   13       ; R3 := v2
[57] eq         1   2   3    ; R2 == R3, pc+=1 (goto [59]) if false
[58] jmp        1            ; pc+=1 (goto [60])
[59] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [61])
[60] loadbool   2   1   0    ; R2 := true
[61] call       1   2   1    ;  := R1(R2)
[62] getglobal  1   12       ; R1 := print
[63] getglobal  2   13       ; R2 := v2
[64] getglobal  3   0        ; R3 := vector
[65] loadk      4   14       ; R4 := 3
[66] loadk      5   15       ; R5 := 4
[67] call       3   3   2    ; R3 := R3(R4, R5)
[68] eq         1   2   3    ; R2 == R3, pc+=1 (goto [70]) if false
[69] jmp        1            ; pc+=1 (goto [71])
[70] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [72])
[71] loadbool   2   1   0    ; R2 := true
[72] call       1   2   1    ;  := R1(R2)
[73] getglobal  1   17       ; R1 := v4
[74] call       1   1   1    ;  := R1()
[75] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 1 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  1 2 0 6
.local  "x"  ; 0
.local  "y"  ; 1
.local  "v"  ; 2
.upvalue  "mt"  ; 0
.const  "x"  ; 0
.const  "y"  ; 1
.const  "setmetatable"  ; 2
[1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
[2] settable   2   256 0    ; R2["x"] := R0
[3] settable   2   257 1    ; R2["y"] := R1
[4] getglobal  3   2        ; R3 := setmetatable
[5] move       4   2        ; R4 := R2
[6] getupval   5   0        ; R5 := U0 , mt
[7] call       3   3   1    ;  := R3(R4, R5)
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
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
; end of function 0_1


; function [2] definition (level 2) 0_2
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
[04] sub        3   3   4    ; R3 := R3 - R4
[05] gettable   4   0   258  ; R4 := R0["y"]
[06] gettable   5   1   258  ; R5 := R1["y"]
[07] sub        4   4   5    ; R4 := R4 - R5
[08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[09] return     2   0        ; return R2 to top
[10] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "v1"  ; 0
.local  "n"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[1] getglobal  2   0        ; R2 := vector
[2] gettable   3   0   257  ; R3 := R0["x"]
[3] mul        3   3   1    ; R3 := R3 * R1
[4] gettable   4   0   258  ; R4 := R0["y"]
[5] mul        4   4   1    ; R4 := R4 * R1
[6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[7] return     2   0        ; return R2 to top
[8] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "v1"  ; 0
.local  "n"  ; 1
.const  "vector"  ; 0
.const  "x"  ; 1
.const  "y"  ; 2
[1] getglobal  2   0        ; R2 := vector
[2] gettable   3   0   257  ; R3 := R0["x"]
[3] div        3   3   1    ; R3 := R3 / R1
[4] gettable   4   0   258  ; R4 := R0["y"]
[5] div        4   4   1    ; R4 := R4 / R1
[6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[7] return     2   0        ; return R2 to top
[8] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "v"  ; 0
.const  "x"  ; 0
.const  "y"  ; 1
.const  0.5  ; 2
[01] gettable   1   0   256  ; R1 := R0["x"]
[02] gettable   2   0   256  ; R2 := R0["x"]
[03] mul        1   1   2    ; R1 := R1 * R2
[04] gettable   2   0   257  ; R2 := R0["y"]
[05] gettable   3   0   257  ; R3 := R0["y"]
[06] mul        2   2   3    ; R2 := R2 * R3
[07] add        1   1   2    ; R1 := R1 + R2
[08] pow        1   1   258  ; R1 := R1 ^ 0.5
[09] return     1   2        ; return R1
[10] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "v1"  ; 0
.local  "v2"  ; 1
.const  "x"  ; 0
.const  "y"  ; 1
[01] gettable   2   0   256  ; R2 := R0["x"]
[02] gettable   3   1   256  ; R3 := R1["x"]
[03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
[04] jmp        4            ; pc+=4 (goto [9])
[05] gettable   2   0   257  ; R2 := R0["y"]
[06] gettable   3   1   257  ; R3 := R1["y"]
[07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
[08] jmp        1            ; pc+=1 (goto [10])
[09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
[10] loadbool   2   1   0    ; R2 := true
[11] return     2   2        ; return R2
[12] return     0   1        ; return 
; end of function 0_6


; function [7] definition (level 2) 0_7
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "v"  ; 0
.local  "k"  ; 1
.const  "print"  ; 0
[1] eq         0   1   256  ; R1 == "print", pc+=1 (goto [3]) if true
[2] jmp        3            ; pc+=3 (goto [6])
[3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
[4] move       0   0        ; R0 := R0
[5] return     2   2        ; return R2
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_7_0
; 1 upvalues, 0 params, is_vararg = 0, 6 stacks
.function  1 0 0 6
.upvalue  "v"  ; 0
.const  "print"  ; 0
.const  "["  ; 1
.const  "x"  ; 2
.const  ", "  ; 3
.const  "y"  ; 4
.const  "]"  ; 5
[01] getglobal  0   0        ; R0 := print
[02] loadk      1   1        ; R1 := "["
[03] getupval   2   0        ; R2 := U0 , v
[04] gettable   2   2   258  ; R2 := R2["x"]
[05] loadk      3   3        ; R3 := ", "
[06] getupval   4   0        ; R4 := U0 , v
[07] gettable   4   4   260  ; R4 := R4["y"]
[08] loadk      5   5        ; R5 := "]"
[09] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
[10] call       0   2   1    ;  := R0(R1)
[11] return     0   1        ; return 
; end of function 0_7_0

; end of function 0_7


; function [8] definition (level 2) 0_8
; 0 upvalues, 1 params, is_vararg = 0, 7 stacks
.function  0 1 0 7
.local  "v"  ; 0
.const  "print"  ; 0
.const  "["  ; 1
.const  "x"  ; 2
.const  ", "  ; 3
.const  "y"  ; 4
.const  "]"  ; 5
[1] getglobal  1   0        ; R1 := print
[2] loadk      2   1        ; R2 := "["
[3] gettable   3   0   258  ; R3 := R0["x"]
[4] loadk      4   3        ; R4 := ", "
[5] gettable   5   0   260  ; R5 := R0["y"]
[6] loadk      6   5        ; R6 := "]"
[7] concat     2   2   6    ; R2 := R2..R3..R4..R5..R6
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_8

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
002B  4B000000           sizecode (75)
002F  0A000000           [01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [02] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
0037  00000000           [03] move       0   0        ; R0 := R0
003B  47000000           [04] setglobal  1   0        ; vector := R1
003F  64400000           [05] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
0043  09408080           [06] settable   0   257 1    ; R0["__add"] := R1
0047  64800000           [07] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
004B  09400081           [08] settable   0   258 1    ; R0["__sub"] := R1
004F  64C00000           [09] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
0053  09408081           [10] settable   0   259 1    ; R0["__mul"] := R1
0057  64000100           [11] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
005B  09400082           [12] settable   0   260 1    ; R0["__div"] := R1
005F  64400100           [13] closure    1   5        ; R1 := closure(function[5]) 0 upvalues
0063  09408082           [14] settable   0   261 1    ; R0["__len"] := R1
0067  64800100           [15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
006B  09400083           [16] settable   0   262 1    ; R0["__eq"] := R1
006F  64C00100           [17] closure    1   7        ; R1 := closure(function[7]) 0 upvalues
0073  09408083           [18] settable   0   263 1    ; R0["__index"] := R1
0077  64000200           [19] closure    1   8        ; R1 := closure(function[8]) 0 upvalues
007B  09400084           [20] settable   0   264 1    ; R0["__call"] := R1
007F  45000000           [21] getglobal  1   0        ; R1 := vector
0083  81800200           [22] loadk      2   10       ; R2 := 1
0087  C1C00200           [23] loadk      3   11       ; R3 := 2
008B  5C808001           [24] call       1   3   2    ; R1 := R1(R2, R3)
008F  47400200           [25] setglobal  1   9        ; v1 := R1
0093  45400200           [26] getglobal  1   9        ; R1 := v1
0097  4B00C300           [27] self       1   1   268  ; R2 := R1; R1 := R1["print"]
009B  5C400001           [28] call       1   2   1    ;  := R1(R2)
009F  45000000           [29] getglobal  1   0        ; R1 := vector
00A3  81800300           [30] loadk      2   14       ; R2 := 3
00A7  C1C00300           [31] loadk      3   15       ; R3 := 4
00AB  5C808001           [32] call       1   3   2    ; R1 := R1(R2, R3)
00AF  47400300           [33] setglobal  1   13       ; v2 := R1
00B3  45400300           [34] getglobal  1   13       ; R1 := v2
00B7  4B00C300           [35] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00BB  5C400001           [36] call       1   2   1    ;  := R1(R2)
00BF  45400200           [37] getglobal  1   9        ; R1 := v1
00C3  4EC0C200           [38] mul        1   1   267  ; R1 := R1 * 2
00C7  47000400           [39] setglobal  1   16       ; v3 := R1
00CB  45000400           [40] getglobal  1   16       ; R1 := v3
00CF  4B00C300           [41] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00D3  5C400001           [42] call       1   2   1    ;  := R1(R2)
00D7  45400200           [43] getglobal  1   9        ; R1 := v1
00DB  85000400           [44] getglobal  2   16       ; R2 := v3
00DF  4C808000           [45] add        1   1   2    ; R1 := R1 + R2
00E3  47400400           [46] setglobal  1   17       ; v4 := R1
00E7  45400400           [47] getglobal  1   17       ; R1 := v4
00EB  4B00C300           [48] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00EF  5C400001           [49] call       1   2   1    ;  := R1(R2)
00F3  45000300           [50] getglobal  1   12       ; R1 := print
00F7  85400300           [51] getglobal  2   13       ; R2 := v2
00FB  94000001           [52] len        2   2        ; R2 := #R2
00FF  5C400001           [53] call       1   2   1    ;  := R1(R2)
0103  45000300           [54] getglobal  1   12       ; R1 := print
0107  85400200           [55] getglobal  2   9        ; R2 := v1
010B  C5400300           [56] getglobal  3   13       ; R3 := v2
010F  57C00001           [57] eq         1   2   3    ; R2 == R3, pc+=1 (goto [59]) if false
0113  16000080           [58] jmp        1            ; pc+=1 (goto [60])
0117  82400000           [59] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [61])
011B  82008000           [60] loadbool   2   1   0    ; R2 := true
011F  5C400001           [61] call       1   2   1    ;  := R1(R2)
0123  45000300           [62] getglobal  1   12       ; R1 := print
0127  85400300           [63] getglobal  2   13       ; R2 := v2
012B  C5000000           [64] getglobal  3   0        ; R3 := vector
012F  01810300           [65] loadk      4   14       ; R4 := 3
0133  41C10300           [66] loadk      5   15       ; R5 := 4
0137  DC808001           [67] call       3   3   2    ; R3 := R3(R4, R5)
013B  57C00001           [68] eq         1   2   3    ; R2 == R3, pc+=1 (goto [70]) if false
013F  16000080           [69] jmp        1            ; pc+=1 (goto [71])
0143  82400000           [70] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [72])
0147  82008000           [71] loadbool   2   1   0    ; R2 := true
014B  5C400001           [72] call       1   2   1    ;  := R1(R2)
014F  45400400           [73] getglobal  1   17       ; R1 := v4
0153  5C408000           [74] call       1   1   1    ;  := R1()
0157  1E008000           [75] return     0   1        ; return 
                         * constants:
015B  12000000           sizek (18)
015F  04                 const type 4
0160  0700000000000000   string size (7)
0168  766563746F7200     "vector\0"
                         const [0]: "vector"
016F  04                 const type 4
0170  0600000000000000   string size (6)
0178  5F5F61646400       "__add\0"
                         const [1]: "__add"
017E  04                 const type 4
017F  0600000000000000   string size (6)
0187  5F5F73756200       "__sub\0"
                         const [2]: "__sub"
018D  04                 const type 4
018E  0600000000000000   string size (6)
0196  5F5F6D756C00       "__mul\0"
                         const [3]: "__mul"
019C  04                 const type 4
019D  0600000000000000   string size (6)
01A5  5F5F64697600       "__div\0"
                         const [4]: "__div"
01AB  04                 const type 4
01AC  0600000000000000   string size (6)
01B4  5F5F6C656E00       "__len\0"
                         const [5]: "__len"
01BA  04                 const type 4
01BB  0500000000000000   string size (5)
01C3  5F5F657100         "__eq\0"
                         const [6]: "__eq"
01C8  04                 const type 4
01C9  0800000000000000   string size (8)
01D1  5F5F696E64657800   "__index\0"
                         const [7]: "__index"
01D9  04                 const type 4
01DA  0700000000000000   string size (7)
01E2  5F5F63616C6C00     "__call\0"
                         const [8]: "__call"
01E9  04                 const type 4
01EA  0300000000000000   string size (3)
01F2  763100             "v1\0"
                         const [9]: "v1"
01F5  03                 const type 3
01F6  000000000000F03F   const [10]: (1)
01FE  03                 const type 3
01FF  0000000000000040   const [11]: (2)
0207  04                 const type 4
0208  0600000000000000   string size (6)
0210  7072696E7400       "print\0"
                         const [12]: "print"
0216  04                 const type 4
0217  0300000000000000   string size (3)
021F  763200             "v2\0"
                         const [13]: "v2"
0222  03                 const type 3
0223  0000000000000840   const [14]: (3)
022B  03                 const type 3
022C  0000000000001040   const [15]: (4)
0234  04                 const type 4
0235  0300000000000000   string size (3)
023D  763300             "v3\0"
                         const [16]: "v3"
0240  04                 const type 4
0241  0300000000000000   string size (3)
0249  763400             "v4\0"
                         const [17]: "v4"
                         * functions:
024C  09000000           sizep (9)
                         
0250                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0250  0000000000000000   string size (0)
                         source name: (none)
0258  03000000           line defined (3)
025C  07000000           last line defined (7)
0260  01                 nups (1)
0261  02                 numparams (2)
0262  00                 is_vararg (0)
0263  06                 maxstacksize (6)
                         * code:
0264  09000000           sizecode (9)
0268  8A800000           [1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
026C  89000080           [2] settable   2   256 0    ; R2["x"] := R0
0270  89408080           [3] settable   2   257 1    ; R2["y"] := R1
0274  C5800000           [4] getglobal  3   2        ; R3 := setmetatable
0278  00010001           [5] move       4   2        ; R4 := R2
027C  44010000           [6] getupval   5   0        ; R5 := U0 , mt
0280  DC408001           [7] call       3   3   1    ;  := R3(R4, R5)
0284  9E000001           [8] return     2   2        ; return R2
0288  1E008000           [9] return     0   1        ; return 
                         * constants:
028C  03000000           sizek (3)
0290  04                 const type 4
0291  0200000000000000   string size (2)
0299  7800               "x\0"
                         const [0]: "x"
029B  04                 const type 4
029C  0200000000000000   string size (2)
02A4  7900               "y\0"
                         const [1]: "y"
02A6  04                 const type 4
02A7  0D00000000000000   string size (13)
02AF  7365746D65746174+  "setmetat"
02B7  61626C6500         "able\0"
                         const [2]: "setmetatable"
                         * functions:
02BC  00000000           sizep (0)
                         * lines:
02C0  09000000           sizelineinfo (9)
                         [pc] (line)
02C4  04000000           [1] (4)
02C8  04000000           [2] (4)
02CC  04000000           [3] (4)
02D0  05000000           [4] (5)
02D4  05000000           [5] (5)
02D8  05000000           [6] (5)
02DC  05000000           [7] (5)
02E0  06000000           [8] (6)
02E4  07000000           [9] (7)
                         * locals:
02E8  03000000           sizelocvars (3)
02EC  0200000000000000   string size (2)
02F4  7800               "x\0"
                         local [0]: x
02F6  00000000             startpc (0)
02FA  08000000             endpc   (8)
02FE  0200000000000000   string size (2)
0306  7900               "y\0"
                         local [1]: y
0308  00000000             startpc (0)
030C  08000000             endpc   (8)
0310  0200000000000000   string size (2)
0318  7600               "v\0"
                         local [2]: v
031A  03000000             startpc (3)
031E  08000000             endpc   (8)
                         * upvalues:
0322  01000000           sizeupvalues (1)
0326  0300000000000000   string size (3)
032E  6D7400             "mt\0"
                         upvalue [0]: mt
                         ** end of function 0_0 **

                         
0331                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0331  0000000000000000   string size (0)
                         source name: (none)
0339  09000000           line defined (9)
033D  0B000000           last line defined (11)
0341  00                 nups (0)
0342  02                 numparams (2)
0343  00                 is_vararg (0)
0344  06                 maxstacksize (6)
                         * code:
0345  0A000000           sizecode (10)
0349  85000000           [01] getglobal  2   0        ; R2 := vector
034D  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
0351  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
0355  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
0359  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
035D  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
0361  0C410102           [07] add        4   4   5    ; R4 := R4 + R5
0365  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
0369  9E000000           [09] return     2   0        ; return R2 to top
036D  1E008000           [10] return     0   1        ; return 
                         * constants:
0371  03000000           sizek (3)
0375  04                 const type 4
0376  0700000000000000   string size (7)
037E  766563746F7200     "vector\0"
                         const [0]: "vector"
0385  04                 const type 4
0386  0200000000000000   string size (2)
038E  7800               "x\0"
                         const [1]: "x"
0390  04                 const type 4
0391  0200000000000000   string size (2)
0399  7900               "y\0"
                         const [2]: "y"
                         * functions:
039B  00000000           sizep (0)
                         * lines:
039F  0A000000           sizelineinfo (10)
                         [pc] (line)
03A3  0A000000           [01] (10)
03A7  0A000000           [02] (10)
03AB  0A000000           [03] (10)
03AF  0A000000           [04] (10)
03B3  0A000000           [05] (10)
03B7  0A000000           [06] (10)
03BB  0A000000           [07] (10)
03BF  0A000000           [08] (10)
03C3  0A000000           [09] (10)
03C7  0B000000           [10] (11)
                         * locals:
03CB  02000000           sizelocvars (2)
03CF  0300000000000000   string size (3)
03D7  763100             "v1\0"
                         local [0]: v1
03DA  00000000             startpc (0)
03DE  09000000             endpc   (9)
03E2  0300000000000000   string size (3)
03EA  763200             "v2\0"
                         local [1]: v2
03ED  00000000             startpc (0)
03F1  09000000             endpc   (9)
                         * upvalues:
03F5  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
03F9                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
03F9  0000000000000000   string size (0)
                         source name: (none)
0401  0C000000           line defined (12)
0405  0E000000           last line defined (14)
0409  00                 nups (0)
040A  02                 numparams (2)
040B  00                 is_vararg (0)
040C  06                 maxstacksize (6)
                         * code:
040D  0A000000           sizecode (10)
0411  85000000           [01] getglobal  2   0        ; R2 := vector
0415  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
0419  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
041D  CD008101           [04] sub        3   3   4    ; R3 := R3 - R4
0421  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
0425  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
0429  0D410102           [07] sub        4   4   5    ; R4 := R4 - R5
042D  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
0431  9E000000           [09] return     2   0        ; return R2 to top
0435  1E008000           [10] return     0   1        ; return 
                         * constants:
0439  03000000           sizek (3)
043D  04                 const type 4
043E  0700000000000000   string size (7)
0446  766563746F7200     "vector\0"
                         const [0]: "vector"
044D  04                 const type 4
044E  0200000000000000   string size (2)
0456  7800               "x\0"
                         const [1]: "x"
0458  04                 const type 4
0459  0200000000000000   string size (2)
0461  7900               "y\0"
                         const [2]: "y"
                         * functions:
0463  00000000           sizep (0)
                         * lines:
0467  0A000000           sizelineinfo (10)
                         [pc] (line)
046B  0D000000           [01] (13)
046F  0D000000           [02] (13)
0473  0D000000           [03] (13)
0477  0D000000           [04] (13)
047B  0D000000           [05] (13)
047F  0D000000           [06] (13)
0483  0D000000           [07] (13)
0487  0D000000           [08] (13)
048B  0D000000           [09] (13)
048F  0E000000           [10] (14)
                         * locals:
0493  02000000           sizelocvars (2)
0497  0300000000000000   string size (3)
049F  763100             "v1\0"
                         local [0]: v1
04A2  00000000             startpc (0)
04A6  09000000             endpc   (9)
04AA  0300000000000000   string size (3)
04B2  763200             "v2\0"
                         local [1]: v2
04B5  00000000             startpc (0)
04B9  09000000             endpc   (9)
                         * upvalues:
04BD  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
04C1                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
04C1  0000000000000000   string size (0)
                         source name: (none)
04C9  0F000000           line defined (15)
04CD  11000000           last line defined (17)
04D1  00                 nups (0)
04D2  02                 numparams (2)
04D3  00                 is_vararg (0)
04D4  05                 maxstacksize (5)
                         * code:
04D5  08000000           sizecode (8)
04D9  85000000           [1] getglobal  2   0        ; R2 := vector
04DD  C6404000           [2] gettable   3   0   257  ; R3 := R0["x"]
04E1  CE408001           [3] mul        3   3   1    ; R3 := R3 * R1
04E5  06814000           [4] gettable   4   0   258  ; R4 := R0["y"]
04E9  0E410002           [5] mul        4   4   1    ; R4 := R4 * R1
04ED  9D008001           [6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
04F1  9E000000           [7] return     2   0        ; return R2 to top
04F5  1E008000           [8] return     0   1        ; return 
                         * constants:
04F9  03000000           sizek (3)
04FD  04                 const type 4
04FE  0700000000000000   string size (7)
0506  766563746F7200     "vector\0"
                         const [0]: "vector"
050D  04                 const type 4
050E  0200000000000000   string size (2)
0516  7800               "x\0"
                         const [1]: "x"
0518  04                 const type 4
0519  0200000000000000   string size (2)
0521  7900               "y\0"
                         const [2]: "y"
                         * functions:
0523  00000000           sizep (0)
                         * lines:
0527  08000000           sizelineinfo (8)
                         [pc] (line)
052B  10000000           [1] (16)
052F  10000000           [2] (16)
0533  10000000           [3] (16)
0537  10000000           [4] (16)
053B  10000000           [5] (16)
053F  10000000           [6] (16)
0543  10000000           [7] (16)
0547  11000000           [8] (17)
                         * locals:
054B  02000000           sizelocvars (2)
054F  0300000000000000   string size (3)
0557  763100             "v1\0"
                         local [0]: v1
055A  00000000             startpc (0)
055E  07000000             endpc   (7)
0562  0200000000000000   string size (2)
056A  6E00               "n\0"
                         local [1]: n
056C  00000000             startpc (0)
0570  07000000             endpc   (7)
                         * upvalues:
0574  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0578                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0578  0000000000000000   string size (0)
                         source name: (none)
0580  12000000           line defined (18)
0584  14000000           last line defined (20)
0588  00                 nups (0)
0589  02                 numparams (2)
058A  00                 is_vararg (0)
058B  05                 maxstacksize (5)
                         * code:
058C  08000000           sizecode (8)
0590  85000000           [1] getglobal  2   0        ; R2 := vector
0594  C6404000           [2] gettable   3   0   257  ; R3 := R0["x"]
0598  CF408001           [3] div        3   3   1    ; R3 := R3 / R1
059C  06814000           [4] gettable   4   0   258  ; R4 := R0["y"]
05A0  0F410002           [5] div        4   4   1    ; R4 := R4 / R1
05A4  9D008001           [6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
05A8  9E000000           [7] return     2   0        ; return R2 to top
05AC  1E008000           [8] return     0   1        ; return 
                         * constants:
05B0  03000000           sizek (3)
05B4  04                 const type 4
05B5  0700000000000000   string size (7)
05BD  766563746F7200     "vector\0"
                         const [0]: "vector"
05C4  04                 const type 4
05C5  0200000000000000   string size (2)
05CD  7800               "x\0"
                         const [1]: "x"
05CF  04                 const type 4
05D0  0200000000000000   string size (2)
05D8  7900               "y\0"
                         const [2]: "y"
                         * functions:
05DA  00000000           sizep (0)
                         * lines:
05DE  08000000           sizelineinfo (8)
                         [pc] (line)
05E2  13000000           [1] (19)
05E6  13000000           [2] (19)
05EA  13000000           [3] (19)
05EE  13000000           [4] (19)
05F2  13000000           [5] (19)
05F6  13000000           [6] (19)
05FA  13000000           [7] (19)
05FE  14000000           [8] (20)
                         * locals:
0602  02000000           sizelocvars (2)
0606  0300000000000000   string size (3)
060E  763100             "v1\0"
                         local [0]: v1
0611  00000000             startpc (0)
0615  07000000             endpc   (7)
0619  0200000000000000   string size (2)
0621  6E00               "n\0"
                         local [1]: n
0623  00000000             startpc (0)
0627  07000000             endpc   (7)
                         * upvalues:
062B  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
062F                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
062F  0000000000000000   string size (0)
                         source name: (none)
0637  15000000           line defined (21)
063B  17000000           last line defined (23)
063F  00                 nups (0)
0640  01                 numparams (1)
0641  00                 is_vararg (0)
0642  04                 maxstacksize (4)
                         * code:
0643  0A000000           sizecode (10)
0647  46004000           [01] gettable   1   0   256  ; R1 := R0["x"]
064B  86004000           [02] gettable   2   0   256  ; R2 := R0["x"]
064F  4E808000           [03] mul        1   1   2    ; R1 := R1 * R2
0653  86404000           [04] gettable   2   0   257  ; R2 := R0["y"]
0657  C6404000           [05] gettable   3   0   257  ; R3 := R0["y"]
065B  8EC00001           [06] mul        2   2   3    ; R2 := R2 * R3
065F  4C808000           [07] add        1   1   2    ; R1 := R1 + R2
0663  5180C000           [08] pow        1   1   258  ; R1 := R1 ^ 0.5
0667  5E000001           [09] return     1   2        ; return R1
066B  1E008000           [10] return     0   1        ; return 
                         * constants:
066F  03000000           sizek (3)
0673  04                 const type 4
0674  0200000000000000   string size (2)
067C  7800               "x\0"
                         const [0]: "x"
067E  04                 const type 4
067F  0200000000000000   string size (2)
0687  7900               "y\0"
                         const [1]: "y"
0689  03                 const type 3
068A  000000000000E03F   const [2]: (0.5)
                         * functions:
0692  00000000           sizep (0)
                         * lines:
0696  0A000000           sizelineinfo (10)
                         [pc] (line)
069A  16000000           [01] (22)
069E  16000000           [02] (22)
06A2  16000000           [03] (22)
06A6  16000000           [04] (22)
06AA  16000000           [05] (22)
06AE  16000000           [06] (22)
06B2  16000000           [07] (22)
06B6  16000000           [08] (22)
06BA  16000000           [09] (22)
06BE  17000000           [10] (23)
                         * locals:
06C2  01000000           sizelocvars (1)
06C6  0200000000000000   string size (2)
06CE  7600               "v\0"
                         local [0]: v
06D0  00000000             startpc (0)
06D4  09000000             endpc   (9)
                         * upvalues:
06D8  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
06DC                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
06DC  0000000000000000   string size (0)
                         source name: (none)
06E4  18000000           line defined (24)
06E8  1A000000           last line defined (26)
06EC  00                 nups (0)
06ED  02                 numparams (2)
06EE  00                 is_vararg (0)
06EF  04                 maxstacksize (4)
                         * code:
06F0  0C000000           sizecode (12)
06F4  86004000           [01] gettable   2   0   256  ; R2 := R0["x"]
06F8  C600C000           [02] gettable   3   1   256  ; R3 := R1["x"]
06FC  17C00001           [03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
0700  16C00080           [04] jmp        4            ; pc+=4 (goto [9])
0704  86404000           [05] gettable   2   0   257  ; R2 := R0["y"]
0708  C640C000           [06] gettable   3   1   257  ; R3 := R1["y"]
070C  57C00001           [07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
0710  16000080           [08] jmp        1            ; pc+=1 (goto [10])
0714  82400000           [09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
0718  82008000           [10] loadbool   2   1   0    ; R2 := true
071C  9E000001           [11] return     2   2        ; return R2
0720  1E008000           [12] return     0   1        ; return 
                         * constants:
0724  02000000           sizek (2)
0728  04                 const type 4
0729  0200000000000000   string size (2)
0731  7800               "x\0"
                         const [0]: "x"
0733  04                 const type 4
0734  0200000000000000   string size (2)
073C  7900               "y\0"
                         const [1]: "y"
                         * functions:
073E  00000000           sizep (0)
                         * lines:
0742  0C000000           sizelineinfo (12)
                         [pc] (line)
0746  19000000           [01] (25)
074A  19000000           [02] (25)
074E  19000000           [03] (25)
0752  19000000           [04] (25)
0756  19000000           [05] (25)
075A  19000000           [06] (25)
075E  19000000           [07] (25)
0762  19000000           [08] (25)
0766  19000000           [09] (25)
076A  19000000           [10] (25)
076E  19000000           [11] (25)
0772  1A000000           [12] (26)
                         * locals:
0776  02000000           sizelocvars (2)
077A  0300000000000000   string size (3)
0782  763100             "v1\0"
                         local [0]: v1
0785  00000000             startpc (0)
0789  0B000000             endpc   (11)
078D  0300000000000000   string size (3)
0795  763200             "v2\0"
                         local [1]: v2
0798  00000000             startpc (0)
079C  0B000000             endpc   (11)
                         * upvalues:
07A0  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         
07A4                     ** function [7] definition (level 2) 0_7
                         ** start of function 0_7 **
07A4  0000000000000000   string size (0)
                         source name: (none)
07AC  1B000000           line defined (27)
07B0  21000000           last line defined (33)
07B4  00                 nups (0)
07B5  02                 numparams (2)
07B6  00                 is_vararg (0)
07B7  03                 maxstacksize (3)
                         * code:
07B8  06000000           sizecode (6)
07BC  1700C000           [1] eq         0   1   256  ; R1 == "print", pc+=1 (goto [3]) if true
07C0  16800080           [2] jmp        3            ; pc+=3 (goto [6])
07C4  A4000000           [3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
07C8  00000000           [4] move       0   0        ; R0 := R0
07CC  9E000001           [5] return     2   2        ; return R2
07D0  1E008000           [6] return     0   1        ; return 
                         * constants:
07D4  01000000           sizek (1)
07D8  04                 const type 4
07D9  0600000000000000   string size (6)
07E1  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
07E7  01000000           sizep (1)
                         
07EB                     ** function [0] definition (level 3) 0_7_0
                         ** start of function 0_7_0 **
07EB  0000000000000000   string size (0)
                         source name: (none)
07F3  1D000000           line defined (29)
07F7  1F000000           last line defined (31)
07FB  01                 nups (1)
07FC  00                 numparams (0)
07FD  00                 is_vararg (0)
07FE  06                 maxstacksize (6)
                         * code:
07FF  0B000000           sizecode (11)
0803  05000000           [01] getglobal  0   0        ; R0 := print
0807  41400000           [02] loadk      1   1        ; R1 := "["
080B  84000000           [03] getupval   2   0        ; R2 := U0 , v
080F  86804001           [04] gettable   2   2   258  ; R2 := R2["x"]
0813  C1C00000           [05] loadk      3   3        ; R3 := ", "
0817  04010000           [06] getupval   4   0        ; R4 := U0 , v
081B  06014102           [07] gettable   4   4   260  ; R4 := R4["y"]
081F  41410100           [08] loadk      5   5        ; R5 := "]"
0823  55408100           [09] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
0827  1C400001           [10] call       0   2   1    ;  := R0(R1)
082B  1E008000           [11] return     0   1        ; return 
                         * constants:
082F  06000000           sizek (6)
0833  04                 const type 4
0834  0600000000000000   string size (6)
083C  7072696E7400       "print\0"
                         const [0]: "print"
0842  04                 const type 4
0843  0200000000000000   string size (2)
084B  5B00               "[\0"
                         const [1]: "["
084D  04                 const type 4
084E  0200000000000000   string size (2)
0856  7800               "x\0"
                         const [2]: "x"
0858  04                 const type 4
0859  0300000000000000   string size (3)
0861  2C2000             ", \0"
                         const [3]: ", "
0864  04                 const type 4
0865  0200000000000000   string size (2)
086D  7900               "y\0"
                         const [4]: "y"
086F  04                 const type 4
0870  0200000000000000   string size (2)
0878  5D00               "]\0"
                         const [5]: "]"
                         * functions:
087A  00000000           sizep (0)
                         * lines:
087E  0B000000           sizelineinfo (11)
                         [pc] (line)
0882  1E000000           [01] (30)
0886  1E000000           [02] (30)
088A  1E000000           [03] (30)
088E  1E000000           [04] (30)
0892  1E000000           [05] (30)
0896  1E000000           [06] (30)
089A  1E000000           [07] (30)
089E  1E000000           [08] (30)
08A2  1E000000           [09] (30)
08A6  1E000000           [10] (30)
08AA  1F000000           [11] (31)
                         * locals:
08AE  00000000           sizelocvars (0)
                         * upvalues:
08B2  01000000           sizeupvalues (1)
08B6  0200000000000000   string size (2)
08BE  7600               "v\0"
                         upvalue [0]: v
                         ** end of function 0_7_0 **

                         * lines:
08C0  06000000           sizelineinfo (6)
                         [pc] (line)
08C4  1C000000           [1] (28)
08C8  1C000000           [2] (28)
08CC  1F000000           [3] (31)
08D0  1F000000           [4] (31)
08D4  1F000000           [5] (31)
08D8  21000000           [6] (33)
                         * locals:
08DC  02000000           sizelocvars (2)
08E0  0200000000000000   string size (2)
08E8  7600               "v\0"
                         local [0]: v
08EA  00000000             startpc (0)
08EE  05000000             endpc   (5)
08F2  0200000000000000   string size (2)
08FA  6B00               "k\0"
                         local [1]: k
08FC  00000000             startpc (0)
0900  05000000             endpc   (5)
                         * upvalues:
0904  00000000           sizeupvalues (0)
                         ** end of function 0_7 **

                         
0908                     ** function [8] definition (level 2) 0_8
                         ** start of function 0_8 **
0908  0000000000000000   string size (0)
                         source name: (none)
0910  22000000           line defined (34)
0914  24000000           last line defined (36)
0918  00                 nups (0)
0919  01                 numparams (1)
091A  00                 is_vararg (0)
091B  07                 maxstacksize (7)
                         * code:
091C  09000000           sizecode (9)
0920  45000000           [1] getglobal  1   0        ; R1 := print
0924  81400000           [2] loadk      2   1        ; R2 := "["
0928  C6804000           [3] gettable   3   0   258  ; R3 := R0["x"]
092C  01C10000           [4] loadk      4   3        ; R4 := ", "
0930  46014100           [5] gettable   5   0   260  ; R5 := R0["y"]
0934  81410100           [6] loadk      6   5        ; R6 := "]"
0938  95800101           [7] concat     2   2   6    ; R2 := R2..R3..R4..R5..R6
093C  5C400001           [8] call       1   2   1    ;  := R1(R2)
0940  1E008000           [9] return     0   1        ; return 
                         * constants:
0944  06000000           sizek (6)
0948  04                 const type 4
0949  0600000000000000   string size (6)
0951  7072696E7400       "print\0"
                         const [0]: "print"
0957  04                 const type 4
0958  0200000000000000   string size (2)
0960  5B00               "[\0"
                         const [1]: "["
0962  04                 const type 4
0963  0200000000000000   string size (2)
096B  7800               "x\0"
                         const [2]: "x"
096D  04                 const type 4
096E  0300000000000000   string size (3)
0976  2C2000             ", \0"
                         const [3]: ", "
0979  04                 const type 4
097A  0200000000000000   string size (2)
0982  7900               "y\0"
                         const [4]: "y"
0984  04                 const type 4
0985  0200000000000000   string size (2)
098D  5D00               "]\0"
                         const [5]: "]"
                         * functions:
098F  00000000           sizep (0)
                         * lines:
0993  09000000           sizelineinfo (9)
                         [pc] (line)
0997  23000000           [1] (35)
099B  23000000           [2] (35)
099F  23000000           [3] (35)
09A3  23000000           [4] (35)
09A7  23000000           [5] (35)
09AB  23000000           [6] (35)
09AF  23000000           [7] (35)
09B3  23000000           [8] (35)
09B7  24000000           [9] (36)
                         * locals:
09BB  01000000           sizelocvars (1)
09BF  0200000000000000   string size (2)
09C7  7600               "v\0"
                         local [0]: v
09C9  00000000             startpc (0)
09CD  08000000             endpc   (8)
                         * upvalues:
09D1  00000000           sizeupvalues (0)
                         ** end of function 0_8 **

                         * lines:
09D5  4B000000           sizelineinfo (75)
                         [pc] (line)
09D9  01000000           [01] (1)
09DD  07000000           [02] (7)
09E1  07000000           [03] (7)
09E5  03000000           [04] (3)
09E9  0B000000           [05] (11)
09ED  0B000000           [06] (11)
09F1  0E000000           [07] (14)
09F5  0E000000           [08] (14)
09F9  11000000           [09] (17)
09FD  11000000           [10] (17)
0A01  14000000           [11] (20)
0A05  14000000           [12] (20)
0A09  17000000           [13] (23)
0A0D  17000000           [14] (23)
0A11  1A000000           [15] (26)
0A15  1A000000           [16] (26)
0A19  21000000           [17] (33)
0A1D  21000000           [18] (33)
0A21  24000000           [19] (36)
0A25  24000000           [20] (36)
0A29  26000000           [21] (38)
0A2D  26000000           [22] (38)
0A31  26000000           [23] (38)
0A35  26000000           [24] (38)
0A39  26000000           [25] (38)
0A3D  26000000           [26] (38)
0A41  26000000           [27] (38)
0A45  26000000           [28] (38)
0A49  27000000           [29] (39)
0A4D  27000000           [30] (39)
0A51  27000000           [31] (39)
0A55  27000000           [32] (39)
0A59  27000000           [33] (39)
0A5D  27000000           [34] (39)
0A61  27000000           [35] (39)
0A65  27000000           [36] (39)
0A69  28000000           [37] (40)
0A6D  28000000           [38] (40)
0A71  28000000           [39] (40)
0A75  28000000           [40] (40)
0A79  28000000           [41] (40)
0A7D  28000000           [42] (40)
0A81  29000000           [43] (41)
0A85  29000000           [44] (41)
0A89  29000000           [45] (41)
0A8D  29000000           [46] (41)
0A91  29000000           [47] (41)
0A95  29000000           [48] (41)
0A99  29000000           [49] (41)
0A9D  2A000000           [50] (42)
0AA1  2A000000           [51] (42)
0AA5  2A000000           [52] (42)
0AA9  2A000000           [53] (42)
0AAD  2B000000           [54] (43)
0AB1  2B000000           [55] (43)
0AB5  2B000000           [56] (43)
0AB9  2B000000           [57] (43)
0ABD  2B000000           [58] (43)
0AC1  2B000000           [59] (43)
0AC5  2B000000           [60] (43)
0AC9  2B000000           [61] (43)
0ACD  2C000000           [62] (44)
0AD1  2C000000           [63] (44)
0AD5  2C000000           [64] (44)
0AD9  2C000000           [65] (44)
0ADD  2C000000           [66] (44)
0AE1  2C000000           [67] (44)
0AE5  2C000000           [68] (44)
0AE9  2C000000           [69] (44)
0AED  2C000000           [70] (44)
0AF1  2C000000           [71] (44)
0AF5  2C000000           [72] (44)
0AF9  2D000000           [73] (45)
0AFD  2D000000           [74] (45)
0B01  2D000000           [75] (45)
                         * locals:
0B05  01000000           sizelocvars (1)
0B09  0300000000000000   string size (3)
0B11  6D7400             "mt\0"
                         local [0]: mt
0B14  01000000             startpc (1)
0B18  4A000000             endpc   (74)
                         * upvalues:
0B1C  00000000           sizeupvalues (0)
                         ** end of function 0 **

0B20                     ** end of chunk **
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
002B  4B000000           sizecode (75)
002F  0A000000           [01] newtable   0   0   0    ; R0 := {} , array=0, hash=0
0033  64000000           [02] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
0037  00000000           [03] move       0   0        ; R0 := R0
003B  47000000           [04] setglobal  1   0        ; vector := R1
003F  64400000           [05] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
0043  09408080           [06] settable   0   257 1    ; R0["__add"] := R1
0047  64800000           [07] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
004B  09400081           [08] settable   0   258 1    ; R0["__sub"] := R1
004F  64C00000           [09] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
0053  09408081           [10] settable   0   259 1    ; R0["__mul"] := R1
0057  64000100           [11] closure    1   4        ; R1 := closure(function[4]) 0 upvalues
005B  09400082           [12] settable   0   260 1    ; R0["__div"] := R1
005F  64400100           [13] closure    1   5        ; R1 := closure(function[5]) 0 upvalues
0063  09408082           [14] settable   0   261 1    ; R0["__len"] := R1
0067  64800100           [15] closure    1   6        ; R1 := closure(function[6]) 0 upvalues
006B  09400083           [16] settable   0   262 1    ; R0["__eq"] := R1
006F  64C00100           [17] closure    1   7        ; R1 := closure(function[7]) 0 upvalues
0073  09408083           [18] settable   0   263 1    ; R0["__index"] := R1
0077  64000200           [19] closure    1   8        ; R1 := closure(function[8]) 0 upvalues
007B  09400084           [20] settable   0   264 1    ; R0["__call"] := R1
007F  45000000           [21] getglobal  1   0        ; R1 := vector
0083  81800200           [22] loadk      2   10       ; R2 := 1
0087  C1C00200           [23] loadk      3   11       ; R3 := 2
008B  5C808001           [24] call       1   3   2    ; R1 := R1(R2, R3)
008F  47400200           [25] setglobal  1   9        ; v1 := R1
0093  45400200           [26] getglobal  1   9        ; R1 := v1
0097  4B00C300           [27] self       1   1   268  ; R2 := R1; R1 := R1["print"]
009B  5C400001           [28] call       1   2   1    ;  := R1(R2)
009F  45000000           [29] getglobal  1   0        ; R1 := vector
00A3  81800300           [30] loadk      2   14       ; R2 := 3
00A7  C1C00300           [31] loadk      3   15       ; R3 := 4
00AB  5C808001           [32] call       1   3   2    ; R1 := R1(R2, R3)
00AF  47400300           [33] setglobal  1   13       ; v2 := R1
00B3  45400300           [34] getglobal  1   13       ; R1 := v2
00B7  4B00C300           [35] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00BB  5C400001           [36] call       1   2   1    ;  := R1(R2)
00BF  45400200           [37] getglobal  1   9        ; R1 := v1
00C3  4EC0C200           [38] mul        1   1   267  ; R1 := R1 * 2
00C7  47000400           [39] setglobal  1   16       ; v3 := R1
00CB  45000400           [40] getglobal  1   16       ; R1 := v3
00CF  4B00C300           [41] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00D3  5C400001           [42] call       1   2   1    ;  := R1(R2)
00D7  45400200           [43] getglobal  1   9        ; R1 := v1
00DB  85000400           [44] getglobal  2   16       ; R2 := v3
00DF  4C808000           [45] add        1   1   2    ; R1 := R1 + R2
00E3  47400400           [46] setglobal  1   17       ; v4 := R1
00E7  45400400           [47] getglobal  1   17       ; R1 := v4
00EB  4B00C300           [48] self       1   1   268  ; R2 := R1; R1 := R1["print"]
00EF  5C400001           [49] call       1   2   1    ;  := R1(R2)
00F3  45000300           [50] getglobal  1   12       ; R1 := print
00F7  85400300           [51] getglobal  2   13       ; R2 := v2
00FB  94000001           [52] len        2   2        ; R2 := #R2
00FF  5C400001           [53] call       1   2   1    ;  := R1(R2)
0103  45000300           [54] getglobal  1   12       ; R1 := print
0107  85400200           [55] getglobal  2   9        ; R2 := v1
010B  C5400300           [56] getglobal  3   13       ; R3 := v2
010F  57C00001           [57] eq         1   2   3    ; R2 == R3, pc+=1 (goto [59]) if false
0113  16000080           [58] jmp        1            ; pc+=1 (goto [60])
0117  82400000           [59] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [61])
011B  82008000           [60] loadbool   2   1   0    ; R2 := true
011F  5C400001           [61] call       1   2   1    ;  := R1(R2)
0123  45000300           [62] getglobal  1   12       ; R1 := print
0127  85400300           [63] getglobal  2   13       ; R2 := v2
012B  C5000000           [64] getglobal  3   0        ; R3 := vector
012F  01810300           [65] loadk      4   14       ; R4 := 3
0133  41C10300           [66] loadk      5   15       ; R5 := 4
0137  DC808001           [67] call       3   3   2    ; R3 := R3(R4, R5)
013B  57C00001           [68] eq         1   2   3    ; R2 == R3, pc+=1 (goto [70]) if false
013F  16000080           [69] jmp        1            ; pc+=1 (goto [71])
0143  82400000           [70] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [72])
0147  82008000           [71] loadbool   2   1   0    ; R2 := true
014B  5C400001           [72] call       1   2   1    ;  := R1(R2)
014F  45400400           [73] getglobal  1   17       ; R1 := v4
0153  5C408000           [74] call       1   1   1    ;  := R1()
0157  1E008000           [75] return     0   1        ; return 
                         * constants:
015B  12000000           sizek (18)
015F  04                 const type 4
0160  0700000000000000   string size (7)
0168  766563746F7200     "vector\0"
                         const [0]: "vector"
016F  04                 const type 4
0170  0600000000000000   string size (6)
0178  5F5F61646400       "__add\0"
                         const [1]: "__add"
017E  04                 const type 4
017F  0600000000000000   string size (6)
0187  5F5F73756200       "__sub\0"
                         const [2]: "__sub"
018D  04                 const type 4
018E  0600000000000000   string size (6)
0196  5F5F6D756C00       "__mul\0"
                         const [3]: "__mul"
019C  04                 const type 4
019D  0600000000000000   string size (6)
01A5  5F5F64697600       "__div\0"
                         const [4]: "__div"
01AB  04                 const type 4
01AC  0600000000000000   string size (6)
01B4  5F5F6C656E00       "__len\0"
                         const [5]: "__len"
01BA  04                 const type 4
01BB  0500000000000000   string size (5)
01C3  5F5F657100         "__eq\0"
                         const [6]: "__eq"
01C8  04                 const type 4
01C9  0800000000000000   string size (8)
01D1  5F5F696E64657800   "__index\0"
                         const [7]: "__index"
01D9  04                 const type 4
01DA  0700000000000000   string size (7)
01E2  5F5F63616C6C00     "__call\0"
                         const [8]: "__call"
01E9  04                 const type 4
01EA  0300000000000000   string size (3)
01F2  763100             "v1\0"
                         const [9]: "v1"
01F5  03                 const type 3
01F6  000000000000F03F   const [10]: (1)
01FE  03                 const type 3
01FF  0000000000000040   const [11]: (2)
0207  04                 const type 4
0208  0600000000000000   string size (6)
0210  7072696E7400       "print\0"
                         const [12]: "print"
0216  04                 const type 4
0217  0300000000000000   string size (3)
021F  763200             "v2\0"
                         const [13]: "v2"
0222  03                 const type 3
0223  0000000000000840   const [14]: (3)
022B  03                 const type 3
022C  0000000000001040   const [15]: (4)
0234  04                 const type 4
0235  0300000000000000   string size (3)
023D  763300             "v3\0"
                         const [16]: "v3"
0240  04                 const type 4
0241  0300000000000000   string size (3)
0249  763400             "v4\0"
                         const [17]: "v4"
                         * functions:
024C  09000000           sizep (9)
                         
0250                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0250  0000000000000000   string size (0)
                         source name: (none)
0258  03000000           line defined (3)
025C  07000000           last line defined (7)
0260  01                 nups (1)
0261  02                 numparams (2)
0262  00                 is_vararg (0)
0263  06                 maxstacksize (6)
                         * code:
0264  09000000           sizecode (9)
0268  8A800000           [1] newtable   2   0   2    ; R2 := {} , array=0, hash=2
026C  89000080           [2] settable   2   256 0    ; R2["x"] := R0
0270  89408080           [3] settable   2   257 1    ; R2["y"] := R1
0274  C5800000           [4] getglobal  3   2        ; R3 := setmetatable
0278  00010001           [5] move       4   2        ; R4 := R2
027C  44010000           [6] getupval   5   0        ; R5 := U0 , mt
0280  DC408001           [7] call       3   3   1    ;  := R3(R4, R5)
0284  9E000001           [8] return     2   2        ; return R2
0288  1E008000           [9] return     0   1        ; return 
                         * constants:
028C  03000000           sizek (3)
0290  04                 const type 4
0291  0200000000000000   string size (2)
0299  7800               "x\0"
                         const [0]: "x"
029B  04                 const type 4
029C  0200000000000000   string size (2)
02A4  7900               "y\0"
                         const [1]: "y"
02A6  04                 const type 4
02A7  0D00000000000000   string size (13)
02AF  7365746D65746174+  "setmetat"
02B7  61626C6500         "able\0"
                         const [2]: "setmetatable"
                         * functions:
02BC  00000000           sizep (0)
                         * lines:
02C0  09000000           sizelineinfo (9)
                         [pc] (line)
02C4  04000000           [1] (4)
02C8  04000000           [2] (4)
02CC  04000000           [3] (4)
02D0  05000000           [4] (5)
02D4  05000000           [5] (5)
02D8  05000000           [6] (5)
02DC  05000000           [7] (5)
02E0  06000000           [8] (6)
02E4  07000000           [9] (7)
                         * locals:
02E8  03000000           sizelocvars (3)
02EC  0200000000000000   string size (2)
02F4  7800               "x\0"
                         local [0]: x
02F6  00000000             startpc (0)
02FA  08000000             endpc   (8)
02FE  0200000000000000   string size (2)
0306  7900               "y\0"
                         local [1]: y
0308  00000000             startpc (0)
030C  08000000             endpc   (8)
0310  0200000000000000   string size (2)
0318  7600               "v\0"
                         local [2]: v
031A  03000000             startpc (3)
031E  08000000             endpc   (8)
                         * upvalues:
0322  01000000           sizeupvalues (1)
0326  0300000000000000   string size (3)
032E  6D7400             "mt\0"
                         upvalue [0]: mt
                         ** end of function 0_0 **

                         
0331                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0331  0000000000000000   string size (0)
                         source name: (none)
0339  09000000           line defined (9)
033D  0B000000           last line defined (11)
0341  00                 nups (0)
0342  02                 numparams (2)
0343  00                 is_vararg (0)
0344  06                 maxstacksize (6)
                         * code:
0345  0A000000           sizecode (10)
0349  85000000           [01] getglobal  2   0        ; R2 := vector
034D  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
0351  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
0355  CC008101           [04] add        3   3   4    ; R3 := R3 + R4
0359  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
035D  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
0361  0C410102           [07] add        4   4   5    ; R4 := R4 + R5
0365  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
0369  9E000000           [09] return     2   0        ; return R2 to top
036D  1E008000           [10] return     0   1        ; return 
                         * constants:
0371  03000000           sizek (3)
0375  04                 const type 4
0376  0700000000000000   string size (7)
037E  766563746F7200     "vector\0"
                         const [0]: "vector"
0385  04                 const type 4
0386  0200000000000000   string size (2)
038E  7800               "x\0"
                         const [1]: "x"
0390  04                 const type 4
0391  0200000000000000   string size (2)
0399  7900               "y\0"
                         const [2]: "y"
                         * functions:
039B  00000000           sizep (0)
                         * lines:
039F  0A000000           sizelineinfo (10)
                         [pc] (line)
03A3  0A000000           [01] (10)
03A7  0A000000           [02] (10)
03AB  0A000000           [03] (10)
03AF  0A000000           [04] (10)
03B3  0A000000           [05] (10)
03B7  0A000000           [06] (10)
03BB  0A000000           [07] (10)
03BF  0A000000           [08] (10)
03C3  0A000000           [09] (10)
03C7  0B000000           [10] (11)
                         * locals:
03CB  02000000           sizelocvars (2)
03CF  0300000000000000   string size (3)
03D7  763100             "v1\0"
                         local [0]: v1
03DA  00000000             startpc (0)
03DE  09000000             endpc   (9)
03E2  0300000000000000   string size (3)
03EA  763200             "v2\0"
                         local [1]: v2
03ED  00000000             startpc (0)
03F1  09000000             endpc   (9)
                         * upvalues:
03F5  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
03F9                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
03F9  0000000000000000   string size (0)
                         source name: (none)
0401  0C000000           line defined (12)
0405  0E000000           last line defined (14)
0409  00                 nups (0)
040A  02                 numparams (2)
040B  00                 is_vararg (0)
040C  06                 maxstacksize (6)
                         * code:
040D  0A000000           sizecode (10)
0411  85000000           [01] getglobal  2   0        ; R2 := vector
0415  C6404000           [02] gettable   3   0   257  ; R3 := R0["x"]
0419  0641C000           [03] gettable   4   1   257  ; R4 := R1["x"]
041D  CD008101           [04] sub        3   3   4    ; R3 := R3 - R4
0421  06814000           [05] gettable   4   0   258  ; R4 := R0["y"]
0425  4681C000           [06] gettable   5   1   258  ; R5 := R1["y"]
0429  0D410102           [07] sub        4   4   5    ; R4 := R4 - R5
042D  9D008001           [08] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
0431  9E000000           [09] return     2   0        ; return R2 to top
0435  1E008000           [10] return     0   1        ; return 
                         * constants:
0439  03000000           sizek (3)
043D  04                 const type 4
043E  0700000000000000   string size (7)
0446  766563746F7200     "vector\0"
                         const [0]: "vector"
044D  04                 const type 4
044E  0200000000000000   string size (2)
0456  7800               "x\0"
                         const [1]: "x"
0458  04                 const type 4
0459  0200000000000000   string size (2)
0461  7900               "y\0"
                         const [2]: "y"
                         * functions:
0463  00000000           sizep (0)
                         * lines:
0467  0A000000           sizelineinfo (10)
                         [pc] (line)
046B  0D000000           [01] (13)
046F  0D000000           [02] (13)
0473  0D000000           [03] (13)
0477  0D000000           [04] (13)
047B  0D000000           [05] (13)
047F  0D000000           [06] (13)
0483  0D000000           [07] (13)
0487  0D000000           [08] (13)
048B  0D000000           [09] (13)
048F  0E000000           [10] (14)
                         * locals:
0493  02000000           sizelocvars (2)
0497  0300000000000000   string size (3)
049F  763100             "v1\0"
                         local [0]: v1
04A2  00000000             startpc (0)
04A6  09000000             endpc   (9)
04AA  0300000000000000   string size (3)
04B2  763200             "v2\0"
                         local [1]: v2
04B5  00000000             startpc (0)
04B9  09000000             endpc   (9)
                         * upvalues:
04BD  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
04C1                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
04C1  0000000000000000   string size (0)
                         source name: (none)
04C9  0F000000           line defined (15)
04CD  11000000           last line defined (17)
04D1  00                 nups (0)
04D2  02                 numparams (2)
04D3  00                 is_vararg (0)
04D4  05                 maxstacksize (5)
                         * code:
04D5  08000000           sizecode (8)
04D9  85000000           [1] getglobal  2   0        ; R2 := vector
04DD  C6404000           [2] gettable   3   0   257  ; R3 := R0["x"]
04E1  CE408001           [3] mul        3   3   1    ; R3 := R3 * R1
04E5  06814000           [4] gettable   4   0   258  ; R4 := R0["y"]
04E9  0E410002           [5] mul        4   4   1    ; R4 := R4 * R1
04ED  9D008001           [6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
04F1  9E000000           [7] return     2   0        ; return R2 to top
04F5  1E008000           [8] return     0   1        ; return 
                         * constants:
04F9  03000000           sizek (3)
04FD  04                 const type 4
04FE  0700000000000000   string size (7)
0506  766563746F7200     "vector\0"
                         const [0]: "vector"
050D  04                 const type 4
050E  0200000000000000   string size (2)
0516  7800               "x\0"
                         const [1]: "x"
0518  04                 const type 4
0519  0200000000000000   string size (2)
0521  7900               "y\0"
                         const [2]: "y"
                         * functions:
0523  00000000           sizep (0)
                         * lines:
0527  08000000           sizelineinfo (8)
                         [pc] (line)
052B  10000000           [1] (16)
052F  10000000           [2] (16)
0533  10000000           [3] (16)
0537  10000000           [4] (16)
053B  10000000           [5] (16)
053F  10000000           [6] (16)
0543  10000000           [7] (16)
0547  11000000           [8] (17)
                         * locals:
054B  02000000           sizelocvars (2)
054F  0300000000000000   string size (3)
0557  763100             "v1\0"
                         local [0]: v1
055A  00000000             startpc (0)
055E  07000000             endpc   (7)
0562  0200000000000000   string size (2)
056A  6E00               "n\0"
                         local [1]: n
056C  00000000             startpc (0)
0570  07000000             endpc   (7)
                         * upvalues:
0574  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
0578                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
0578  0000000000000000   string size (0)
                         source name: (none)
0580  12000000           line defined (18)
0584  14000000           last line defined (20)
0588  00                 nups (0)
0589  02                 numparams (2)
058A  00                 is_vararg (0)
058B  05                 maxstacksize (5)
                         * code:
058C  08000000           sizecode (8)
0590  85000000           [1] getglobal  2   0        ; R2 := vector
0594  C6404000           [2] gettable   3   0   257  ; R3 := R0["x"]
0598  CF408001           [3] div        3   3   1    ; R3 := R3 / R1
059C  06814000           [4] gettable   4   0   258  ; R4 := R0["y"]
05A0  0F410002           [5] div        4   4   1    ; R4 := R4 / R1
05A4  9D008001           [6] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
05A8  9E000000           [7] return     2   0        ; return R2 to top
05AC  1E008000           [8] return     0   1        ; return 
                         * constants:
05B0  03000000           sizek (3)
05B4  04                 const type 4
05B5  0700000000000000   string size (7)
05BD  766563746F7200     "vector\0"
                         const [0]: "vector"
05C4  04                 const type 4
05C5  0200000000000000   string size (2)
05CD  7800               "x\0"
                         const [1]: "x"
05CF  04                 const type 4
05D0  0200000000000000   string size (2)
05D8  7900               "y\0"
                         const [2]: "y"
                         * functions:
05DA  00000000           sizep (0)
                         * lines:
05DE  08000000           sizelineinfo (8)
                         [pc] (line)
05E2  13000000           [1] (19)
05E6  13000000           [2] (19)
05EA  13000000           [3] (19)
05EE  13000000           [4] (19)
05F2  13000000           [5] (19)
05F6  13000000           [6] (19)
05FA  13000000           [7] (19)
05FE  14000000           [8] (20)
                         * locals:
0602  02000000           sizelocvars (2)
0606  0300000000000000   string size (3)
060E  763100             "v1\0"
                         local [0]: v1
0611  00000000             startpc (0)
0615  07000000             endpc   (7)
0619  0200000000000000   string size (2)
0621  6E00               "n\0"
                         local [1]: n
0623  00000000             startpc (0)
0627  07000000             endpc   (7)
                         * upvalues:
062B  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
062F                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
062F  0000000000000000   string size (0)
                         source name: (none)
0637  15000000           line defined (21)
063B  17000000           last line defined (23)
063F  00                 nups (0)
0640  01                 numparams (1)
0641  00                 is_vararg (0)
0642  04                 maxstacksize (4)
                         * code:
0643  0A000000           sizecode (10)
0647  46004000           [01] gettable   1   0   256  ; R1 := R0["x"]
064B  86004000           [02] gettable   2   0   256  ; R2 := R0["x"]
064F  4E808000           [03] mul        1   1   2    ; R1 := R1 * R2
0653  86404000           [04] gettable   2   0   257  ; R2 := R0["y"]
0657  C6404000           [05] gettable   3   0   257  ; R3 := R0["y"]
065B  8EC00001           [06] mul        2   2   3    ; R2 := R2 * R3
065F  4C808000           [07] add        1   1   2    ; R1 := R1 + R2
0663  5180C000           [08] pow        1   1   258  ; R1 := R1 ^ 0.5
0667  5E000001           [09] return     1   2        ; return R1
066B  1E008000           [10] return     0   1        ; return 
                         * constants:
066F  03000000           sizek (3)
0673  04                 const type 4
0674  0200000000000000   string size (2)
067C  7800               "x\0"
                         const [0]: "x"
067E  04                 const type 4
067F  0200000000000000   string size (2)
0687  7900               "y\0"
                         const [1]: "y"
0689  03                 const type 3
068A  000000000000E03F   const [2]: (0.5)
                         * functions:
0692  00000000           sizep (0)
                         * lines:
0696  0A000000           sizelineinfo (10)
                         [pc] (line)
069A  16000000           [01] (22)
069E  16000000           [02] (22)
06A2  16000000           [03] (22)
06A6  16000000           [04] (22)
06AA  16000000           [05] (22)
06AE  16000000           [06] (22)
06B2  16000000           [07] (22)
06B6  16000000           [08] (22)
06BA  16000000           [09] (22)
06BE  17000000           [10] (23)
                         * locals:
06C2  01000000           sizelocvars (1)
06C6  0200000000000000   string size (2)
06CE  7600               "v\0"
                         local [0]: v
06D0  00000000             startpc (0)
06D4  09000000             endpc   (9)
                         * upvalues:
06D8  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
06DC                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
06DC  0000000000000000   string size (0)
                         source name: (none)
06E4  18000000           line defined (24)
06E8  1A000000           last line defined (26)
06EC  00                 nups (0)
06ED  02                 numparams (2)
06EE  00                 is_vararg (0)
06EF  04                 maxstacksize (4)
                         * code:
06F0  0C000000           sizecode (12)
06F4  86004000           [01] gettable   2   0   256  ; R2 := R0["x"]
06F8  C600C000           [02] gettable   3   1   256  ; R3 := R1["x"]
06FC  17C00001           [03] eq         0   2   3    ; R2 == R3, pc+=1 (goto [5]) if true
0700  16C00080           [04] jmp        4            ; pc+=4 (goto [9])
0704  86404000           [05] gettable   2   0   257  ; R2 := R0["y"]
0708  C640C000           [06] gettable   3   1   257  ; R3 := R1["y"]
070C  57C00001           [07] eq         1   2   3    ; R2 == R3, pc+=1 (goto [9]) if false
0710  16000080           [08] jmp        1            ; pc+=1 (goto [10])
0714  82400000           [09] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [11])
0718  82008000           [10] loadbool   2   1   0    ; R2 := true
071C  9E000001           [11] return     2   2        ; return R2
0720  1E008000           [12] return     0   1        ; return 
                         * constants:
0724  02000000           sizek (2)
0728  04                 const type 4
0729  0200000000000000   string size (2)
0731  7800               "x\0"
                         const [0]: "x"
0733  04                 const type 4
0734  0200000000000000   string size (2)
073C  7900               "y\0"
                         const [1]: "y"
                         * functions:
073E  00000000           sizep (0)
                         * lines:
0742  0C000000           sizelineinfo (12)
                         [pc] (line)
0746  19000000           [01] (25)
074A  19000000           [02] (25)
074E  19000000           [03] (25)
0752  19000000           [04] (25)
0756  19000000           [05] (25)
075A  19000000           [06] (25)
075E  19000000           [07] (25)
0762  19000000           [08] (25)
0766  19000000           [09] (25)
076A  19000000           [10] (25)
076E  19000000           [11] (25)
0772  1A000000           [12] (26)
                         * locals:
0776  02000000           sizelocvars (2)
077A  0300000000000000   string size (3)
0782  763100             "v1\0"
                         local [0]: v1
0785  00000000             startpc (0)
0789  0B000000             endpc   (11)
078D  0300000000000000   string size (3)
0795  763200             "v2\0"
                         local [1]: v2
0798  00000000             startpc (0)
079C  0B000000             endpc   (11)
                         * upvalues:
07A0  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         
07A4                     ** function [7] definition (level 2) 0_7
                         ** start of function 0_7 **
07A4  0000000000000000   string size (0)
                         source name: (none)
07AC  1B000000           line defined (27)
07B0  21000000           last line defined (33)
07B4  00                 nups (0)
07B5  02                 numparams (2)
07B6  00                 is_vararg (0)
07B7  03                 maxstacksize (3)
                         * code:
07B8  06000000           sizecode (6)
07BC  1700C000           [1] eq         0   1   256  ; R1 == "print", pc+=1 (goto [3]) if true
07C0  16800080           [2] jmp        3            ; pc+=3 (goto [6])
07C4  A4000000           [3] closure    2   0        ; R2 := closure(function[0]) 1 upvalues
07C8  00000000           [4] move       0   0        ; R0 := R0
07CC  9E000001           [5] return     2   2        ; return R2
07D0  1E008000           [6] return     0   1        ; return 
                         * constants:
07D4  01000000           sizek (1)
07D8  04                 const type 4
07D9  0600000000000000   string size (6)
07E1  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
07E7  01000000           sizep (1)
                         
07EB                     ** function [0] definition (level 3) 0_7_0
                         ** start of function 0_7_0 **
07EB  0000000000000000   string size (0)
                         source name: (none)
07F3  1D000000           line defined (29)
07F7  1F000000           last line defined (31)
07FB  01                 nups (1)
07FC  00                 numparams (0)
07FD  00                 is_vararg (0)
07FE  06                 maxstacksize (6)
                         * code:
07FF  0B000000           sizecode (11)
0803  05000000           [01] getglobal  0   0        ; R0 := print
0807  41400000           [02] loadk      1   1        ; R1 := "["
080B  84000000           [03] getupval   2   0        ; R2 := U0 , v
080F  86804001           [04] gettable   2   2   258  ; R2 := R2["x"]
0813  C1C00000           [05] loadk      3   3        ; R3 := ", "
0817  04010000           [06] getupval   4   0        ; R4 := U0 , v
081B  06014102           [07] gettable   4   4   260  ; R4 := R4["y"]
081F  41410100           [08] loadk      5   5        ; R5 := "]"
0823  55408100           [09] concat     1   1   5    ; R1 := R1..R2..R3..R4..R5
0827  1C400001           [10] call       0   2   1    ;  := R0(R1)
082B  1E008000           [11] return     0   1        ; return 
                         * constants:
082F  06000000           sizek (6)
0833  04                 const type 4
0834  0600000000000000   string size (6)
083C  7072696E7400       "print\0"
                         const [0]: "print"
0842  04                 const type 4
0843  0200000000000000   string size (2)
084B  5B00               "[\0"
                         const [1]: "["
084D  04                 const type 4
084E  0200000000000000   string size (2)
0856  7800               "x\0"
                         const [2]: "x"
0858  04                 const type 4
0859  0300000000000000   string size (3)
0861  2C2000             ", \0"
                         const [3]: ", "
0864  04                 const type 4
0865  0200000000000000   string size (2)
086D  7900               "y\0"
                         const [4]: "y"
086F  04                 const type 4
0870  0200000000000000   string size (2)
0878  5D00               "]\0"
                         const [5]: "]"
                         * functions:
087A  00000000           sizep (0)
                         * lines:
087E  0B000000           sizelineinfo (11)
                         [pc] (line)
0882  1E000000           [01] (30)
0886  1E000000           [02] (30)
088A  1E000000           [03] (30)
088E  1E000000           [04] (30)
0892  1E000000           [05] (30)
0896  1E000000           [06] (30)
089A  1E000000           [07] (30)
089E  1E000000           [08] (30)
08A2  1E000000           [09] (30)
08A6  1E000000           [10] (30)
08AA  1F000000           [11] (31)
                         * locals:
08AE  00000000           sizelocvars (0)
                         * upvalues:
08B2  01000000           sizeupvalues (1)
08B6  0200000000000000   string size (2)
08BE  7600               "v\0"
                         upvalue [0]: v
                         ** end of function 0_7_0 **

                         * lines:
08C0  06000000           sizelineinfo (6)
                         [pc] (line)
08C4  1C000000           [1] (28)
08C8  1C000000           [2] (28)
08CC  1F000000           [3] (31)
08D0  1F000000           [4] (31)
08D4  1F000000           [5] (31)
08D8  21000000           [6] (33)
                         * locals:
08DC  02000000           sizelocvars (2)
08E0  0200000000000000   string size (2)
08E8  7600               "v\0"
                         local [0]: v
08EA  00000000             startpc (0)
08EE  05000000             endpc   (5)
08F2  0200000000000000   string size (2)
08FA  6B00               "k\0"
                         local [1]: k
08FC  00000000             startpc (0)
0900  05000000             endpc   (5)
                         * upvalues:
0904  00000000           sizeupvalues (0)
                         ** end of function 0_7 **

                         
0908                     ** function [8] definition (level 2) 0_8
                         ** start of function 0_8 **
0908  0000000000000000   string size (0)
                         source name: (none)
0910  22000000           line defined (34)
0914  24000000           last line defined (36)
0918  00                 nups (0)
0919  01                 numparams (1)
091A  00                 is_vararg (0)
091B  07                 maxstacksize (7)
                         * code:
091C  09000000           sizecode (9)
0920  45000000           [1] getglobal  1   0        ; R1 := print
0924  81400000           [2] loadk      2   1        ; R2 := "["
0928  C6804000           [3] gettable   3   0   258  ; R3 := R0["x"]
092C  01C10000           [4] loadk      4   3        ; R4 := ", "
0930  46014100           [5] gettable   5   0   260  ; R5 := R0["y"]
0934  81410100           [6] loadk      6   5        ; R6 := "]"
0938  95800101           [7] concat     2   2   6    ; R2 := R2..R3..R4..R5..R6
093C  5C400001           [8] call       1   2   1    ;  := R1(R2)
0940  1E008000           [9] return     0   1        ; return 
                         * constants:
0944  06000000           sizek (6)
0948  04                 const type 4
0949  0600000000000000   string size (6)
0951  7072696E7400       "print\0"
                         const [0]: "print"
0957  04                 const type 4
0958  0200000000000000   string size (2)
0960  5B00               "[\0"
                         const [1]: "["
0962  04                 const type 4
0963  0200000000000000   string size (2)
096B  7800               "x\0"
                         const [2]: "x"
096D  04                 const type 4
096E  0300000000000000   string size (3)
0976  2C2000             ", \0"
                         const [3]: ", "
0979  04                 const type 4
097A  0200000000000000   string size (2)
0982  7900               "y\0"
                         const [4]: "y"
0984  04                 const type 4
0985  0200000000000000   string size (2)
098D  5D00               "]\0"
                         const [5]: "]"
                         * functions:
098F  00000000           sizep (0)
                         * lines:
0993  09000000           sizelineinfo (9)
                         [pc] (line)
0997  23000000           [1] (35)
099B  23000000           [2] (35)
099F  23000000           [3] (35)
09A3  23000000           [4] (35)
09A7  23000000           [5] (35)
09AB  23000000           [6] (35)
09AF  23000000           [7] (35)
09B3  23000000           [8] (35)
09B7  24000000           [9] (36)
                         * locals:
09BB  01000000           sizelocvars (1)
09BF  0200000000000000   string size (2)
09C7  7600               "v\0"
                         local [0]: v
09C9  00000000             startpc (0)
09CD  08000000             endpc   (8)
                         * upvalues:
09D1  00000000           sizeupvalues (0)
                         ** end of function 0_8 **

                         * lines:
09D5  4B000000           sizelineinfo (75)
                         [pc] (line)
09D9  01000000           [01] (1)
09DD  07000000           [02] (7)
09E1  07000000           [03] (7)
09E5  03000000           [04] (3)
09E9  0B000000           [05] (11)
09ED  0B000000           [06] (11)
09F1  0E000000           [07] (14)
09F5  0E000000           [08] (14)
09F9  11000000           [09] (17)
09FD  11000000           [10] (17)
0A01  14000000           [11] (20)
0A05  14000000           [12] (20)
0A09  17000000           [13] (23)
0A0D  17000000           [14] (23)
0A11  1A000000           [15] (26)
0A15  1A000000           [16] (26)
0A19  21000000           [17] (33)
0A1D  21000000           [18] (33)
0A21  24000000           [19] (36)
0A25  24000000           [20] (36)
0A29  26000000           [21] (38)
0A2D  26000000           [22] (38)
0A31  26000000           [23] (38)
0A35  26000000           [24] (38)
0A39  26000000           [25] (38)
0A3D  26000000           [26] (38)
0A41  26000000           [27] (38)
0A45  26000000           [28] (38)
0A49  27000000           [29] (39)
0A4D  27000000           [30] (39)
0A51  27000000           [31] (39)
0A55  27000000           [32] (39)
0A59  27000000           [33] (39)
0A5D  27000000           [34] (39)
0A61  27000000           [35] (39)
0A65  27000000           [36] (39)
0A69  28000000           [37] (40)
0A6D  28000000           [38] (40)
0A71  28000000           [39] (40)
0A75  28000000           [40] (40)
0A79  28000000           [41] (40)
0A7D  28000000           [42] (40)
0A81  29000000           [43] (41)
0A85  29000000           [44] (41)
0A89  29000000           [45] (41)
0A8D  29000000           [46] (41)
0A91  29000000           [47] (41)
0A95  29000000           [48] (41)
0A99  29000000           [49] (41)
0A9D  2A000000           [50] (42)
0AA1  2A000000           [51] (42)
0AA5  2A000000           [52] (42)
0AA9  2A000000           [53] (42)
0AAD  2B000000           [54] (43)
0AB1  2B000000           [55] (43)
0AB5  2B000000           [56] (43)
0AB9  2B000000           [57] (43)
0ABD  2B000000           [58] (43)
0AC1  2B000000           [59] (43)
0AC5  2B000000           [60] (43)
0AC9  2B000000           [61] (43)
0ACD  2C000000           [62] (44)
0AD1  2C000000           [63] (44)
0AD5  2C000000           [64] (44)
0AD9  2C000000           [65] (44)
0ADD  2C000000           [66] (44)
0AE1  2C000000           [67] (44)
0AE5  2C000000           [68] (44)
0AE9  2C000000           [69] (44)
0AED  2C000000           [70] (44)
0AF1  2C000000           [71] (44)
0AF5  2C000000           [72] (44)
0AF9  2D000000           [73] (45)
0AFD  2D000000           [74] (45)
0B01  2D000000           [75] (45)
                         * locals:
0B05  01000000           sizelocvars (1)
0B09  0300000000000000   string size (3)
0B11  6D7400             "mt\0"
                         local [0]: mt
0B14  01000000             startpc (1)
0B18  4A000000             endpc   (74)
                         * upvalues:
0B1C  00000000           sizeupvalues (0)
                         ** end of function 0 **

0B20                     ** end of chunk **
