------------------------------
function ipairs(t)
  local i = 0
  return function()
    i = i + 1
    if t[i] == nil then
      return nil, nil
    else
      return i, t[i]
    end
  end
end

t = {10, 20, 30}
iter = ipairs(t)
while true do
  local i, v = iter()
  if i == nil then
    break
  end
  print(i, v)
end

t = {10, 20, 30}
for i, v in ipairs(t) do
  print(i, v)
end


function pairs(t)
  local k, v
  return function ()
    k, v = next(t, k)
    return k, v
  end
end

t = {a=10, b=20, c=30}
for k, v in pairs(t) do
  print(k, v)
end


t = {a=10, b=20, c=30}
for k, v in next, t, nil do
  print(k, v)
end


function pairs(t)
  return next, t, nil
end
t = {a=10, b=20, c=30}
for k, v in pairs(t) do
  print(k, v)
end


function inext(t, i)
  local nextIdx = i + 1
  local nextVal = t[nextIdx] 
  if nextVal == nil then
    return nil
  else 
    return nextIdx, nextVal
  end
end
t = {10, 20, 30}
for i, v in inext, t, 0 do
  print(i, v)
end


--[[
function next(table, key)
  if key == nil then
    nextKey = table.firstKey()
  else
    nextKey = table.nextKey(key)
  end
  if nextKey ~= nil then
    return nextKey, table[nextKey]
  else
    return nil
  end
end
--]]

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "i"  ; 0
.local  "v"  ; 1
.local  "(for generator)"  ; 2
.local  "(for state)"  ; 3
.local  "(for control)"  ; 4
.local  "i"  ; 5
.local  "v"  ; 6
.local  "(for generator)"  ; 7
.local  "(for state)"  ; 8
.local  "(for control)"  ; 9
.local  "k"  ; 10
.local  "v"  ; 11
.local  "(for generator)"  ; 12
.local  "(for state)"  ; 13
.local  "(for control)"  ; 14
.local  "k"  ; 15
.local  "v"  ; 16
.local  "(for generator)"  ; 17
.local  "(for state)"  ; 18
.local  "(for control)"  ; 19
.local  "k"  ; 20
.local  "v"  ; 21
.local  "(for generator)"  ; 22
.local  "(for state)"  ; 23
.local  "(for control)"  ; 24
.local  "i"  ; 25
.local  "v"  ; 26
.const  "ipairs"  ; 0
.const  "t"  ; 1
.const  10  ; 2
.const  20  ; 3
.const  30  ; 4
.const  "iter"  ; 5
.const  nil  ; 6
.const  "print"  ; 7
.const  "pairs"  ; 8
.const  "a"  ; 9
.const  "b"  ; 10
.const  "c"  ; 11
.const  "next"  ; 12
.const  "inext"  ; 13
.const  0  ; 14
[001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[002] setglobal  0   0        ; ipairs := R0
[003] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[004] loadk      1   2        ; R1 := 10
[005] loadk      2   3        ; R2 := 20
[006] loadk      3   4        ; R3 := 30
[007] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[008] setglobal  0   1        ; t := R0
[009] getglobal  0   0        ; R0 := ipairs
[010] getglobal  1   1        ; R1 := t
[011] call       0   2   2    ; R0 := R0(R1)
[012] setglobal  0   5        ; iter := R0
[013] getglobal  0   5        ; R0 := iter
[014] call       0   1   3    ; R0, R1 := R0()
[015] eq         0   0   262  ; R0 == nil, pc+=1 (goto [17]) if true
[016] jmp        1            ; pc+=1 (goto [18])
[017] jmp        5            ; pc+=5 (goto [23])
[018] getglobal  2   7        ; R2 := print
[019] move       3   0        ; R3 := R0
[020] move       4   1        ; R4 := R1
[021] call       2   3   1    ;  := R2(R3, R4)
[022] jmp        -10          ; pc+=-10 (goto [13])
[023] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[024] loadk      1   2        ; R1 := 10
[025] loadk      2   3        ; R2 := 20
[026] loadk      3   4        ; R3 := 30
[027] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[028] setglobal  0   1        ; t := R0
[029] getglobal  0   0        ; R0 := ipairs
[030] getglobal  1   1        ; R1 := t
[031] call       0   2   4    ; R0 to R2 := R0(R1)
[032] jmp        4            ; pc+=4 (goto [37])
[033] getglobal  5   7        ; R5 := print
[034] move       6   3        ; R6 := R3
[035] move       7   4        ; R7 := R4
[036] call       5   3   1    ;  := R5(R6, R7)
[037] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 39
[038] jmp        -6           ; pc+=-6 (goto [33])
[039] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[040] setglobal  0   8        ; pairs := R0
[041] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[042] settable   0   265 258  ; R0["a"] := 10
[043] settable   0   266 259  ; R0["b"] := 20
[044] settable   0   267 260  ; R0["c"] := 30
[045] setglobal  0   1        ; t := R0
[046] getglobal  0   8        ; R0 := pairs
[047] getglobal  1   1        ; R1 := t
[048] call       0   2   4    ; R0 to R2 := R0(R1)
[049] jmp        4            ; pc+=4 (goto [54])
[050] getglobal  5   7        ; R5 := print
[051] move       6   3        ; R6 := R3
[052] move       7   4        ; R7 := R4
[053] call       5   3   1    ;  := R5(R6, R7)
[054] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 56
[055] jmp        -6           ; pc+=-6 (goto [50])
[056] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[057] settable   0   265 258  ; R0["a"] := 10
[058] settable   0   266 259  ; R0["b"] := 20
[059] settable   0   267 260  ; R0["c"] := 30
[060] setglobal  0   1        ; t := R0
[061] getglobal  0   12       ; R0 := next
[062] getglobal  1   1        ; R1 := t
[063] loadnil    2   2        ; R2,  := nil
[064] jmp        4            ; pc+=4 (goto [69])
[065] getglobal  5   7        ; R5 := print
[066] move       6   3        ; R6 := R3
[067] move       7   4        ; R7 := R4
[068] call       5   3   1    ;  := R5(R6, R7)
[069] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 71
[070] jmp        -6           ; pc+=-6 (goto [65])
[071] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[072] setglobal  0   8        ; pairs := R0
[073] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[074] settable   0   265 258  ; R0["a"] := 10
[075] settable   0   266 259  ; R0["b"] := 20
[076] settable   0   267 260  ; R0["c"] := 30
[077] setglobal  0   1        ; t := R0
[078] getglobal  0   8        ; R0 := pairs
[079] getglobal  1   1        ; R1 := t
[080] call       0   2   4    ; R0 to R2 := R0(R1)
[081] jmp        4            ; pc+=4 (goto [86])
[082] getglobal  5   7        ; R5 := print
[083] move       6   3        ; R6 := R3
[084] move       7   4        ; R7 := R4
[085] call       5   3   1    ;  := R5(R6, R7)
[086] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 88
[087] jmp        -6           ; pc+=-6 (goto [82])
[088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[089] setglobal  0   13       ; inext := R0
[090] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[091] loadk      1   2        ; R1 := 10
[092] loadk      2   3        ; R2 := 20
[093] loadk      3   4        ; R3 := 30
[094] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[095] setglobal  0   1        ; t := R0
[096] getglobal  0   13       ; R0 := inext
[097] getglobal  1   1        ; R1 := t
[098] loadk      2   14       ; R2 := 0
[099] jmp        4            ; pc+=4 (goto [104])
[100] getglobal  5   7        ; R5 := print
[101] move       6   3        ; R6 := R3
[102] move       7   4        ; R7 := R4
[103] call       5   3   1    ;  := R5(R6, R7)
[104] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 106
[105] jmp        -6           ; pc+=-6 (goto [100])
[106] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "t"  ; 0
.local  "i"  ; 1
.const  0  ; 0
[1] loadk      1   0        ; R1 := 0
[2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
[3] move       0   1        ; R0 := R1
[4] move       0   0        ; R0 := R0
[5] return     2   2        ; return R2
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 2 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  2 0 0 3
.upvalue  "i"  ; 0
.upvalue  "t"  ; 1
.const  1  ; 0
.const  nil  ; 1
[01] getupval   0   0        ; R0 := U0 , i
[02] add        0   0   256  ; R0 := R0 + 1
[03] setupval   0   0        ; U0 := R0 , i
[04] getupval   0   1        ; R0 := U1 , t
[05] getupval   1   0        ; R1 := U0 , i
[06] gettable   0   0   1    ; R0 := R0[R1]
[07] eq         0   0   257  ; R0 == nil, pc+=1 (goto [9]) if true
[08] jmp        3            ; pc+=3 (goto [12])
[09] loadnil    0   1        ; R0, R1,  := nil
[10] return     0   3        ; return R0, R1
[11] jmp        5            ; pc+=5 (goto [17])
[12] getupval   0   0        ; R0 := U0 , i
[13] getupval   1   1        ; R1 := U1 , t
[14] getupval   2   0        ; R2 := U0 , i
[15] gettable   1   1   2    ; R1 := R1[R2]
[16] return     0   3        ; return R0, R1
[17] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "t"  ; 0
.local  "k"  ; 1
.local  "v"  ; 2
[1] closure    3   0        ; R3 := closure(function[0]) 3 upvalues
[2] move       0   1        ; R0 := R1
[3] move       0   2        ; R0 := R2
[4] move       0   0        ; R0 := R0
[5] return     3   2        ; return R3
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 3 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  3 0 0 3
.upvalue  "k"  ; 0
.upvalue  "v"  ; 1
.upvalue  "t"  ; 2
.const  "next"  ; 0
[01] getglobal  0   0        ; R0 := next
[02] getupval   1   2        ; R1 := U2 , t
[03] getupval   2   0        ; R2 := U0 , k
[04] call       0   3   3    ; R0, R1 := R0(R1, R2)
[05] setupval   1   1        ; U1 := R1 , v
[06] setupval   0   0        ; U0 := R0 , k
[07] getupval   0   0        ; R0 := U0 , k
[08] getupval   1   1        ; R1 := U1 , v
[09] return     0   3        ; return R0, R1
[10] return     0   1        ; return 
; end of function 0_1_0

; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "t"  ; 0
.const  "next"  ; 0
[1] getglobal  1   0        ; R1 := next
[2] move       2   0        ; R2 := R0
[3] loadnil    3   3        ; R3,  := nil
[4] return     1   4        ; return R1 to R3
[5] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "t"  ; 0
.local  "i"  ; 1
.local  "nextIdx"  ; 2
.local  "nextVal"  ; 3
.const  1  ; 0
.const  nil  ; 1
[01] add        2   1   256  ; R2 := R1 + 1
[02] gettable   3   0   2    ; R3 := R0[R2]
[03] eq         0   3   257  ; R3 == nil, pc+=1 (goto [5]) if true
[04] jmp        3            ; pc+=3 (goto [8])
[05] loadnil    4   4        ; R4,  := nil
[06] return     4   2        ; return R4
[07] jmp        3            ; pc+=3 (goto [11])
[08] move       4   2        ; R4 := R2
[09] move       5   3        ; R5 := R3
[10] return     4   3        ; return R4, R5
[11] return     0   1        ; return 
; end of function 0_3

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "i"  ; 0
.local  "v"  ; 1
.local  "(for generator)"  ; 2
.local  "(for state)"  ; 3
.local  "(for control)"  ; 4
.local  "i"  ; 5
.local  "v"  ; 6
.local  "(for generator)"  ; 7
.local  "(for state)"  ; 8
.local  "(for control)"  ; 9
.local  "k"  ; 10
.local  "v"  ; 11
.local  "(for generator)"  ; 12
.local  "(for state)"  ; 13
.local  "(for control)"  ; 14
.local  "k"  ; 15
.local  "v"  ; 16
.local  "(for generator)"  ; 17
.local  "(for state)"  ; 18
.local  "(for control)"  ; 19
.local  "k"  ; 20
.local  "v"  ; 21
.local  "(for generator)"  ; 22
.local  "(for state)"  ; 23
.local  "(for control)"  ; 24
.local  "i"  ; 25
.local  "v"  ; 26
.const  "ipairs"  ; 0
.const  "t"  ; 1
.const  10  ; 2
.const  20  ; 3
.const  30  ; 4
.const  "iter"  ; 5
.const  nil  ; 6
.const  "print"  ; 7
.const  "pairs"  ; 8
.const  "a"  ; 9
.const  "b"  ; 10
.const  "c"  ; 11
.const  "next"  ; 12
.const  "inext"  ; 13
.const  0  ; 14
[001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[002] setglobal  0   0        ; ipairs := R0
[003] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[004] loadk      1   2        ; R1 := 10
[005] loadk      2   3        ; R2 := 20
[006] loadk      3   4        ; R3 := 30
[007] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[008] setglobal  0   1        ; t := R0
[009] getglobal  0   0        ; R0 := ipairs
[010] getglobal  1   1        ; R1 := t
[011] call       0   2   2    ; R0 := R0(R1)
[012] setglobal  0   5        ; iter := R0
[013] getglobal  0   5        ; R0 := iter
[014] call       0   1   3    ; R0, R1 := R0()
[015] eq         0   0   262  ; R0 == nil, pc+=1 (goto [17]) if true
[016] jmp        1            ; pc+=1 (goto [18])
[017] jmp        5            ; pc+=5 (goto [23])
[018] getglobal  2   7        ; R2 := print
[019] move       3   0        ; R3 := R0
[020] move       4   1        ; R4 := R1
[021] call       2   3   1    ;  := R2(R3, R4)
[022] jmp        -10          ; pc+=-10 (goto [13])
[023] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[024] loadk      1   2        ; R1 := 10
[025] loadk      2   3        ; R2 := 20
[026] loadk      3   4        ; R3 := 30
[027] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[028] setglobal  0   1        ; t := R0
[029] getglobal  0   0        ; R0 := ipairs
[030] getglobal  1   1        ; R1 := t
[031] call       0   2   4    ; R0 to R2 := R0(R1)
[032] jmp        4            ; pc+=4 (goto [37])
[033] getglobal  5   7        ; R5 := print
[034] move       6   3        ; R6 := R3
[035] move       7   4        ; R7 := R4
[036] call       5   3   1    ;  := R5(R6, R7)
[037] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 39
[038] jmp        -6           ; pc+=-6 (goto [33])
[039] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[040] setglobal  0   8        ; pairs := R0
[041] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[042] settable   0   265 258  ; R0["a"] := 10
[043] settable   0   266 259  ; R0["b"] := 20
[044] settable   0   267 260  ; R0["c"] := 30
[045] setglobal  0   1        ; t := R0
[046] getglobal  0   8        ; R0 := pairs
[047] getglobal  1   1        ; R1 := t
[048] call       0   2   4    ; R0 to R2 := R0(R1)
[049] jmp        4            ; pc+=4 (goto [54])
[050] getglobal  5   7        ; R5 := print
[051] move       6   3        ; R6 := R3
[052] move       7   4        ; R7 := R4
[053] call       5   3   1    ;  := R5(R6, R7)
[054] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 56
[055] jmp        -6           ; pc+=-6 (goto [50])
[056] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[057] settable   0   265 258  ; R0["a"] := 10
[058] settable   0   266 259  ; R0["b"] := 20
[059] settable   0   267 260  ; R0["c"] := 30
[060] setglobal  0   1        ; t := R0
[061] getglobal  0   12       ; R0 := next
[062] getglobal  1   1        ; R1 := t
[063] loadnil    2   2        ; R2,  := nil
[064] jmp        4            ; pc+=4 (goto [69])
[065] getglobal  5   7        ; R5 := print
[066] move       6   3        ; R6 := R3
[067] move       7   4        ; R7 := R4
[068] call       5   3   1    ;  := R5(R6, R7)
[069] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 71
[070] jmp        -6           ; pc+=-6 (goto [65])
[071] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[072] setglobal  0   8        ; pairs := R0
[073] newtable   0   0   3    ; R0 := {} , array=0, hash=3
[074] settable   0   265 258  ; R0["a"] := 10
[075] settable   0   266 259  ; R0["b"] := 20
[076] settable   0   267 260  ; R0["c"] := 30
[077] setglobal  0   1        ; t := R0
[078] getglobal  0   8        ; R0 := pairs
[079] getglobal  1   1        ; R1 := t
[080] call       0   2   4    ; R0 to R2 := R0(R1)
[081] jmp        4            ; pc+=4 (goto [86])
[082] getglobal  5   7        ; R5 := print
[083] move       6   3        ; R6 := R3
[084] move       7   4        ; R7 := R4
[085] call       5   3   1    ;  := R5(R6, R7)
[086] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 88
[087] jmp        -6           ; pc+=-6 (goto [82])
[088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[089] setglobal  0   13       ; inext := R0
[090] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[091] loadk      1   2        ; R1 := 10
[092] loadk      2   3        ; R2 := 20
[093] loadk      3   4        ; R3 := 30
[094] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[095] setglobal  0   1        ; t := R0
[096] getglobal  0   13       ; R0 := inext
[097] getglobal  1   1        ; R1 := t
[098] loadk      2   14       ; R2 := 0
[099] jmp        4            ; pc+=4 (goto [104])
[100] getglobal  5   7        ; R5 := print
[101] move       6   3        ; R6 := R3
[102] move       7   4        ; R7 := R4
[103] call       5   3   1    ;  := R5(R6, R7)
[104] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 106
[105] jmp        -6           ; pc+=-6 (goto [100])
[106] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "t"  ; 0
.local  "i"  ; 1
.const  0  ; 0
[1] loadk      1   0        ; R1 := 0
[2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
[3] move       0   1        ; R0 := R1
[4] move       0   0        ; R0 := R0
[5] return     2   2        ; return R2
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 2 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  2 0 0 3
.upvalue  "i"  ; 0
.upvalue  "t"  ; 1
.const  1  ; 0
.const  nil  ; 1
[01] getupval   0   0        ; R0 := U0 , i
[02] add        0   0   256  ; R0 := R0 + 1
[03] setupval   0   0        ; U0 := R0 , i
[04] getupval   0   1        ; R0 := U1 , t
[05] getupval   1   0        ; R1 := U0 , i
[06] gettable   0   0   1    ; R0 := R0[R1]
[07] eq         0   0   257  ; R0 == nil, pc+=1 (goto [9]) if true
[08] jmp        3            ; pc+=3 (goto [12])
[09] loadnil    0   1        ; R0, R1,  := nil
[10] return     0   3        ; return R0, R1
[11] jmp        5            ; pc+=5 (goto [17])
[12] getupval   0   0        ; R0 := U0 , i
[13] getupval   1   1        ; R1 := U1 , t
[14] getupval   2   0        ; R2 := U0 , i
[15] gettable   1   1   2    ; R1 := R1[R2]
[16] return     0   3        ; return R0, R1
[17] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "t"  ; 0
.local  "k"  ; 1
.local  "v"  ; 2
[1] closure    3   0        ; R3 := closure(function[0]) 3 upvalues
[2] move       0   1        ; R0 := R1
[3] move       0   2        ; R0 := R2
[4] move       0   0        ; R0 := R0
[5] return     3   2        ; return R3
[6] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 3 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  3 0 0 3
.upvalue  "k"  ; 0
.upvalue  "v"  ; 1
.upvalue  "t"  ; 2
.const  "next"  ; 0
[01] getglobal  0   0        ; R0 := next
[02] getupval   1   2        ; R1 := U2 , t
[03] getupval   2   0        ; R2 := U0 , k
[04] call       0   3   3    ; R0, R1 := R0(R1, R2)
[05] setupval   1   1        ; U1 := R1 , v
[06] setupval   0   0        ; U0 := R0 , k
[07] getupval   0   0        ; R0 := U0 , k
[08] getupval   1   1        ; R1 := U1 , v
[09] return     0   3        ; return R0, R1
[10] return     0   1        ; return 
; end of function 0_1_0

; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "t"  ; 0
.const  "next"  ; 0
[1] getglobal  1   0        ; R1 := next
[2] move       2   0        ; R2 := R0
[3] loadnil    3   3        ; R3,  := nil
[4] return     1   4        ; return R1 to R3
[5] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 2 params, is_vararg = 0, 6 stacks
.function  0 2 0 6
.local  "t"  ; 0
.local  "i"  ; 1
.local  "nextIdx"  ; 2
.local  "nextVal"  ; 3
.const  1  ; 0
.const  nil  ; 1
[01] add        2   1   256  ; R2 := R1 + 1
[02] gettable   3   0   2    ; R3 := R0[R2]
[03] eq         0   3   257  ; R3 == nil, pc+=1 (goto [5]) if true
[04] jmp        3            ; pc+=3 (goto [8])
[05] loadnil    4   4        ; R4,  := nil
[06] return     4   2        ; return R4
[07] jmp        3            ; pc+=3 (goto [11])
[08] move       4   2        ; R4 := R2
[09] move       5   3        ; R5 := R3
[10] return     4   3        ; return R4, R5
[11] return     0   1        ; return 
; end of function 0_3

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
002B  6A000000           sizecode (106)
002F  24000000           [001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [002] setglobal  0   0        ; ipairs := R0
0037  0A008001           [003] newtable   0   3   0    ; R0 := {} , array=3, hash=0
003B  41800000           [004] loadk      1   2        ; R1 := 10
003F  81C00000           [005] loadk      2   3        ; R2 := 20
0043  C1000100           [006] loadk      3   4        ; R3 := 30
0047  22408001           [007] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
004B  07400000           [008] setglobal  0   1        ; t := R0
004F  05000000           [009] getglobal  0   0        ; R0 := ipairs
0053  45400000           [010] getglobal  1   1        ; R1 := t
0057  1C800001           [011] call       0   2   2    ; R0 := R0(R1)
005B  07400100           [012] setglobal  0   5        ; iter := R0
005F  05400100           [013] getglobal  0   5        ; R0 := iter
0063  1CC08000           [014] call       0   1   3    ; R0, R1 := R0()
0067  17804100           [015] eq         0   0   262  ; R0 == nil, pc+=1 (goto [17]) if true
006B  16000080           [016] jmp        1            ; pc+=1 (goto [18])
006F  16000180           [017] jmp        5            ; pc+=5 (goto [23])
0073  85C00100           [018] getglobal  2   7        ; R2 := print
0077  C0000000           [019] move       3   0        ; R3 := R0
007B  00018000           [020] move       4   1        ; R4 := R1
007F  9C408001           [021] call       2   3   1    ;  := R2(R3, R4)
0083  1640FD7F           [022] jmp        -10          ; pc+=-10 (goto [13])
0087  0A008001           [023] newtable   0   3   0    ; R0 := {} , array=3, hash=0
008B  41800000           [024] loadk      1   2        ; R1 := 10
008F  81C00000           [025] loadk      2   3        ; R2 := 20
0093  C1000100           [026] loadk      3   4        ; R3 := 30
0097  22408001           [027] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
009B  07400000           [028] setglobal  0   1        ; t := R0
009F  05000000           [029] getglobal  0   0        ; R0 := ipairs
00A3  45400000           [030] getglobal  1   1        ; R1 := t
00A7  1C000101           [031] call       0   2   4    ; R0 to R2 := R0(R1)
00AB  16C00080           [032] jmp        4            ; pc+=4 (goto [37])
00AF  45C10100           [033] getglobal  5   7        ; R5 := print
00B3  80018001           [034] move       6   3        ; R6 := R3
00B7  C0010002           [035] move       7   4        ; R7 := R4
00BB  5C418001           [036] call       5   3   1    ;  := R5(R6, R7)
00BF  21800000           [037] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 39
00C3  1640FE7F           [038] jmp        -6           ; pc+=-6 (goto [33])
00C7  24400000           [039] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
00CB  07000200           [040] setglobal  0   8        ; pairs := R0
00CF  0AC00000           [041] newtable   0   0   3    ; R0 := {} , array=0, hash=3
00D3  0980C084           [042] settable   0   265 258  ; R0["a"] := 10
00D7  09C04085           [043] settable   0   266 259  ; R0["b"] := 20
00DB  0900C185           [044] settable   0   267 260  ; R0["c"] := 30
00DF  07400000           [045] setglobal  0   1        ; t := R0
00E3  05000200           [046] getglobal  0   8        ; R0 := pairs
00E7  45400000           [047] getglobal  1   1        ; R1 := t
00EB  1C000101           [048] call       0   2   4    ; R0 to R2 := R0(R1)
00EF  16C00080           [049] jmp        4            ; pc+=4 (goto [54])
00F3  45C10100           [050] getglobal  5   7        ; R5 := print
00F7  80018001           [051] move       6   3        ; R6 := R3
00FB  C0010002           [052] move       7   4        ; R7 := R4
00FF  5C418001           [053] call       5   3   1    ;  := R5(R6, R7)
0103  21800000           [054] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 56
0107  1640FE7F           [055] jmp        -6           ; pc+=-6 (goto [50])
010B  0AC00000           [056] newtable   0   0   3    ; R0 := {} , array=0, hash=3
010F  0980C084           [057] settable   0   265 258  ; R0["a"] := 10
0113  09C04085           [058] settable   0   266 259  ; R0["b"] := 20
0117  0900C185           [059] settable   0   267 260  ; R0["c"] := 30
011B  07400000           [060] setglobal  0   1        ; t := R0
011F  05000300           [061] getglobal  0   12       ; R0 := next
0123  45400000           [062] getglobal  1   1        ; R1 := t
0127  83000001           [063] loadnil    2   2        ; R2,  := nil
012B  16C00080           [064] jmp        4            ; pc+=4 (goto [69])
012F  45C10100           [065] getglobal  5   7        ; R5 := print
0133  80018001           [066] move       6   3        ; R6 := R3
0137  C0010002           [067] move       7   4        ; R7 := R4
013B  5C418001           [068] call       5   3   1    ;  := R5(R6, R7)
013F  21800000           [069] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 71
0143  1640FE7F           [070] jmp        -6           ; pc+=-6 (goto [65])
0147  24800000           [071] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
014B  07000200           [072] setglobal  0   8        ; pairs := R0
014F  0AC00000           [073] newtable   0   0   3    ; R0 := {} , array=0, hash=3
0153  0980C084           [074] settable   0   265 258  ; R0["a"] := 10
0157  09C04085           [075] settable   0   266 259  ; R0["b"] := 20
015B  0900C185           [076] settable   0   267 260  ; R0["c"] := 30
015F  07400000           [077] setglobal  0   1        ; t := R0
0163  05000200           [078] getglobal  0   8        ; R0 := pairs
0167  45400000           [079] getglobal  1   1        ; R1 := t
016B  1C000101           [080] call       0   2   4    ; R0 to R2 := R0(R1)
016F  16C00080           [081] jmp        4            ; pc+=4 (goto [86])
0173  45C10100           [082] getglobal  5   7        ; R5 := print
0177  80018001           [083] move       6   3        ; R6 := R3
017B  C0010002           [084] move       7   4        ; R7 := R4
017F  5C418001           [085] call       5   3   1    ;  := R5(R6, R7)
0183  21800000           [086] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 88
0187  1640FE7F           [087] jmp        -6           ; pc+=-6 (goto [82])
018B  24C00000           [088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
018F  07400300           [089] setglobal  0   13       ; inext := R0
0193  0A008001           [090] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0197  41800000           [091] loadk      1   2        ; R1 := 10
019B  81C00000           [092] loadk      2   3        ; R2 := 20
019F  C1000100           [093] loadk      3   4        ; R3 := 30
01A3  22408001           [094] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
01A7  07400000           [095] setglobal  0   1        ; t := R0
01AB  05400300           [096] getglobal  0   13       ; R0 := inext
01AF  45400000           [097] getglobal  1   1        ; R1 := t
01B3  81800300           [098] loadk      2   14       ; R2 := 0
01B7  16C00080           [099] jmp        4            ; pc+=4 (goto [104])
01BB  45C10100           [100] getglobal  5   7        ; R5 := print
01BF  80018001           [101] move       6   3        ; R6 := R3
01C3  C0010002           [102] move       7   4        ; R7 := R4
01C7  5C418001           [103] call       5   3   1    ;  := R5(R6, R7)
01CB  21800000           [104] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 106
01CF  1640FE7F           [105] jmp        -6           ; pc+=-6 (goto [100])
01D3  1E008000           [106] return     0   1        ; return 
                         * constants:
01D7  0F000000           sizek (15)
01DB  04                 const type 4
01DC  0700000000000000   string size (7)
01E4  69706169727300     "ipairs\0"
                         const [0]: "ipairs"
01EB  04                 const type 4
01EC  0200000000000000   string size (2)
01F4  7400               "t\0"
                         const [1]: "t"
01F6  03                 const type 3
01F7  0000000000002440   const [2]: (10)
01FF  03                 const type 3
0200  0000000000003440   const [3]: (20)
0208  03                 const type 3
0209  0000000000003E40   const [4]: (30)
0211  04                 const type 4
0212  0500000000000000   string size (5)
021A  6974657200         "iter\0"
                         const [5]: "iter"
021F  00                 const type 0
                         const [6]: nil
0220  04                 const type 4
0221  0600000000000000   string size (6)
0229  7072696E7400       "print\0"
                         const [7]: "print"
022F  04                 const type 4
0230  0600000000000000   string size (6)
0238  706169727300       "pairs\0"
                         const [8]: "pairs"
023E  04                 const type 4
023F  0200000000000000   string size (2)
0247  6100               "a\0"
                         const [9]: "a"
0249  04                 const type 4
024A  0200000000000000   string size (2)
0252  6200               "b\0"
                         const [10]: "b"
0254  04                 const type 4
0255  0200000000000000   string size (2)
025D  6300               "c\0"
                         const [11]: "c"
025F  04                 const type 4
0260  0500000000000000   string size (5)
0268  6E65787400         "next\0"
                         const [12]: "next"
026D  04                 const type 4
026E  0600000000000000   string size (6)
0276  696E65787400       "inext\0"
                         const [13]: "inext"
027C  03                 const type 3
027D  0000000000000000   const [14]: (0)
                         * functions:
0285  04000000           sizep (4)
                         
0289                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0289  0000000000000000   string size (0)
                         source name: (none)
0291  01000000           line defined (1)
0295  0B000000           last line defined (11)
0299  00                 nups (0)
029A  01                 numparams (1)
029B  00                 is_vararg (0)
029C  03                 maxstacksize (3)
                         * code:
029D  06000000           sizecode (6)
02A1  41000000           [1] loadk      1   0        ; R1 := 0
02A5  A4000000           [2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
02A9  00008000           [3] move       0   1        ; R0 := R1
02AD  00000000           [4] move       0   0        ; R0 := R0
02B1  9E000001           [5] return     2   2        ; return R2
02B5  1E008000           [6] return     0   1        ; return 
                         * constants:
02B9  01000000           sizek (1)
02BD  03                 const type 3
02BE  0000000000000000   const [0]: (0)
                         * functions:
02C6  01000000           sizep (1)
                         
02CA                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
02CA  0000000000000000   string size (0)
                         source name: (none)
02D2  03000000           line defined (3)
02D6  0A000000           last line defined (10)
02DA  02                 nups (2)
02DB  00                 numparams (0)
02DC  00                 is_vararg (0)
02DD  03                 maxstacksize (3)
                         * code:
02DE  11000000           sizecode (17)
02E2  04000000           [01] getupval   0   0        ; R0 := U0 , i
02E6  0C004000           [02] add        0   0   256  ; R0 := R0 + 1
02EA  08000000           [03] setupval   0   0        ; U0 := R0 , i
02EE  04008000           [04] getupval   0   1        ; R0 := U1 , t
02F2  44000000           [05] getupval   1   0        ; R1 := U0 , i
02F6  06400000           [06] gettable   0   0   1    ; R0 := R0[R1]
02FA  17404000           [07] eq         0   0   257  ; R0 == nil, pc+=1 (goto [9]) if true
02FE  16800080           [08] jmp        3            ; pc+=3 (goto [12])
0302  03008000           [09] loadnil    0   1        ; R0, R1,  := nil
0306  1E008001           [10] return     0   3        ; return R0, R1
030A  16000180           [11] jmp        5            ; pc+=5 (goto [17])
030E  04000000           [12] getupval   0   0        ; R0 := U0 , i
0312  44008000           [13] getupval   1   1        ; R1 := U1 , t
0316  84000000           [14] getupval   2   0        ; R2 := U0 , i
031A  46808000           [15] gettable   1   1   2    ; R1 := R1[R2]
031E  1E008001           [16] return     0   3        ; return R0, R1
0322  1E008000           [17] return     0   1        ; return 
                         * constants:
0326  02000000           sizek (2)
032A  03                 const type 3
032B  000000000000F03F   const [0]: (1)
0333  00                 const type 0
                         const [1]: nil
                         * functions:
0334  00000000           sizep (0)
                         * lines:
0338  11000000           sizelineinfo (17)
                         [pc] (line)
033C  04000000           [01] (4)
0340  04000000           [02] (4)
0344  04000000           [03] (4)
0348  05000000           [04] (5)
034C  05000000           [05] (5)
0350  05000000           [06] (5)
0354  05000000           [07] (5)
0358  05000000           [08] (5)
035C  06000000           [09] (6)
0360  06000000           [10] (6)
0364  06000000           [11] (6)
0368  08000000           [12] (8)
036C  08000000           [13] (8)
0370  08000000           [14] (8)
0374  08000000           [15] (8)
0378  08000000           [16] (8)
037C  0A000000           [17] (10)
                         * locals:
0380  00000000           sizelocvars (0)
                         * upvalues:
0384  02000000           sizeupvalues (2)
0388  0200000000000000   string size (2)
0390  6900               "i\0"
                         upvalue [0]: i
0392  0200000000000000   string size (2)
039A  7400               "t\0"
                         upvalue [1]: t
                         ** end of function 0_0_0 **

                         * lines:
039C  06000000           sizelineinfo (6)
                         [pc] (line)
03A0  02000000           [1] (2)
03A4  0A000000           [2] (10)
03A8  0A000000           [3] (10)
03AC  0A000000           [4] (10)
03B0  0A000000           [5] (10)
03B4  0B000000           [6] (11)
                         * locals:
03B8  02000000           sizelocvars (2)
03BC  0200000000000000   string size (2)
03C4  7400               "t\0"
                         local [0]: t
03C6  00000000             startpc (0)
03CA  05000000             endpc   (5)
03CE  0200000000000000   string size (2)
03D6  6900               "i\0"
                         local [1]: i
03D8  01000000             startpc (1)
03DC  05000000             endpc   (5)
                         * upvalues:
03E0  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
03E4                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
03E4  0000000000000000   string size (0)
                         source name: (none)
03EC  1D000000           line defined (29)
03F0  23000000           last line defined (35)
03F4  00                 nups (0)
03F5  01                 numparams (1)
03F6  00                 is_vararg (0)
03F7  04                 maxstacksize (4)
                         * code:
03F8  06000000           sizecode (6)
03FC  E4000000           [1] closure    3   0        ; R3 := closure(function[0]) 3 upvalues
0400  00008000           [2] move       0   1        ; R0 := R1
0404  00000001           [3] move       0   2        ; R0 := R2
0408  00000000           [4] move       0   0        ; R0 := R0
040C  DE000001           [5] return     3   2        ; return R3
0410  1E008000           [6] return     0   1        ; return 
                         * constants:
0414  00000000           sizek (0)
                         * functions:
0418  01000000           sizep (1)
                         
041C                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
041C  0000000000000000   string size (0)
                         source name: (none)
0424  1F000000           line defined (31)
0428  22000000           last line defined (34)
042C  03                 nups (3)
042D  00                 numparams (0)
042E  00                 is_vararg (0)
042F  03                 maxstacksize (3)
                         * code:
0430  0A000000           sizecode (10)
0434  05000000           [01] getglobal  0   0        ; R0 := next
0438  44000001           [02] getupval   1   2        ; R1 := U2 , t
043C  84000000           [03] getupval   2   0        ; R2 := U0 , k
0440  1CC08001           [04] call       0   3   3    ; R0, R1 := R0(R1, R2)
0444  48008000           [05] setupval   1   1        ; U1 := R1 , v
0448  08000000           [06] setupval   0   0        ; U0 := R0 , k
044C  04000000           [07] getupval   0   0        ; R0 := U0 , k
0450  44008000           [08] getupval   1   1        ; R1 := U1 , v
0454  1E008001           [09] return     0   3        ; return R0, R1
0458  1E008000           [10] return     0   1        ; return 
                         * constants:
045C  01000000           sizek (1)
0460  04                 const type 4
0461  0500000000000000   string size (5)
0469  6E65787400         "next\0"
                         const [0]: "next"
                         * functions:
046E  00000000           sizep (0)
                         * lines:
0472  0A000000           sizelineinfo (10)
                         [pc] (line)
0476  20000000           [01] (32)
047A  20000000           [02] (32)
047E  20000000           [03] (32)
0482  20000000           [04] (32)
0486  20000000           [05] (32)
048A  20000000           [06] (32)
048E  21000000           [07] (33)
0492  21000000           [08] (33)
0496  21000000           [09] (33)
049A  22000000           [10] (34)
                         * locals:
049E  00000000           sizelocvars (0)
                         * upvalues:
04A2  03000000           sizeupvalues (3)
04A6  0200000000000000   string size (2)
04AE  6B00               "k\0"
                         upvalue [0]: k
04B0  0200000000000000   string size (2)
04B8  7600               "v\0"
                         upvalue [1]: v
04BA  0200000000000000   string size (2)
04C2  7400               "t\0"
                         upvalue [2]: t
                         ** end of function 0_1_0 **

                         * lines:
04C4  06000000           sizelineinfo (6)
                         [pc] (line)
04C8  22000000           [1] (34)
04CC  22000000           [2] (34)
04D0  22000000           [3] (34)
04D4  22000000           [4] (34)
04D8  22000000           [5] (34)
04DC  23000000           [6] (35)
                         * locals:
04E0  03000000           sizelocvars (3)
04E4  0200000000000000   string size (2)
04EC  7400               "t\0"
                         local [0]: t
04EE  00000000             startpc (0)
04F2  05000000             endpc   (5)
04F6  0200000000000000   string size (2)
04FE  6B00               "k\0"
                         local [1]: k
0500  00000000             startpc (0)
0504  05000000             endpc   (5)
0508  0200000000000000   string size (2)
0510  7600               "v\0"
                         local [2]: v
0512  00000000             startpc (0)
0516  05000000             endpc   (5)
                         * upvalues:
051A  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
051E                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
051E  0000000000000000   string size (0)
                         source name: (none)
0526  31000000           line defined (49)
052A  33000000           last line defined (51)
052E  00                 nups (0)
052F  01                 numparams (1)
0530  00                 is_vararg (0)
0531  04                 maxstacksize (4)
                         * code:
0532  05000000           sizecode (5)
0536  45000000           [1] getglobal  1   0        ; R1 := next
053A  80000000           [2] move       2   0        ; R2 := R0
053E  C3008001           [3] loadnil    3   3        ; R3,  := nil
0542  5E000002           [4] return     1   4        ; return R1 to R3
0546  1E008000           [5] return     0   1        ; return 
                         * constants:
054A  01000000           sizek (1)
054E  04                 const type 4
054F  0500000000000000   string size (5)
0557  6E65787400         "next\0"
                         const [0]: "next"
                         * functions:
055C  00000000           sizep (0)
                         * lines:
0560  05000000           sizelineinfo (5)
                         [pc] (line)
0564  32000000           [1] (50)
0568  32000000           [2] (50)
056C  32000000           [3] (50)
0570  32000000           [4] (50)
0574  33000000           [5] (51)
                         * locals:
0578  01000000           sizelocvars (1)
057C  0200000000000000   string size (2)
0584  7400               "t\0"
                         local [0]: t
0586  00000000             startpc (0)
058A  04000000             endpc   (4)
                         * upvalues:
058E  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
0592                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
0592  0000000000000000   string size (0)
                         source name: (none)
059A  3A000000           line defined (58)
059E  42000000           last line defined (66)
05A2  00                 nups (0)
05A3  02                 numparams (2)
05A4  00                 is_vararg (0)
05A5  06                 maxstacksize (6)
                         * code:
05A6  0B000000           sizecode (11)
05AA  8C00C000           [01] add        2   1   256  ; R2 := R1 + 1
05AE  C6800000           [02] gettable   3   0   2    ; R3 := R0[R2]
05B2  1740C001           [03] eq         0   3   257  ; R3 == nil, pc+=1 (goto [5]) if true
05B6  16800080           [04] jmp        3            ; pc+=3 (goto [8])
05BA  03010002           [05] loadnil    4   4        ; R4,  := nil
05BE  1E010001           [06] return     4   2        ; return R4
05C2  16800080           [07] jmp        3            ; pc+=3 (goto [11])
05C6  00010001           [08] move       4   2        ; R4 := R2
05CA  40018001           [09] move       5   3        ; R5 := R3
05CE  1E018001           [10] return     4   3        ; return R4, R5
05D2  1E008000           [11] return     0   1        ; return 
                         * constants:
05D6  02000000           sizek (2)
05DA  03                 const type 3
05DB  000000000000F03F   const [0]: (1)
05E3  00                 const type 0
                         const [1]: nil
                         * functions:
05E4  00000000           sizep (0)
                         * lines:
05E8  0B000000           sizelineinfo (11)
                         [pc] (line)
05EC  3B000000           [01] (59)
05F0  3C000000           [02] (60)
05F4  3D000000           [03] (61)
05F8  3D000000           [04] (61)
05FC  3E000000           [05] (62)
0600  3E000000           [06] (62)
0604  3E000000           [07] (62)
0608  40000000           [08] (64)
060C  40000000           [09] (64)
0610  40000000           [10] (64)
0614  42000000           [11] (66)
                         * locals:
0618  04000000           sizelocvars (4)
061C  0200000000000000   string size (2)
0624  7400               "t\0"
                         local [0]: t
0626  00000000             startpc (0)
062A  0A000000             endpc   (10)
062E  0200000000000000   string size (2)
0636  6900               "i\0"
                         local [1]: i
0638  00000000             startpc (0)
063C  0A000000             endpc   (10)
0640  0800000000000000   string size (8)
0648  6E65787449647800   "nextIdx\0"
                         local [2]: nextIdx
0650  01000000             startpc (1)
0654  0A000000             endpc   (10)
0658  0800000000000000   string size (8)
0660  6E65787456616C00   "nextVal\0"
                         local [3]: nextVal
0668  02000000             startpc (2)
066C  0A000000             endpc   (10)
                         * upvalues:
0670  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
0674  6A000000           sizelineinfo (106)
                         [pc] (line)
0678  0B000000           [001] (11)
067C  01000000           [002] (1)
0680  0D000000           [003] (13)
0684  0D000000           [004] (13)
0688  0D000000           [005] (13)
068C  0D000000           [006] (13)
0690  0D000000           [007] (13)
0694  0D000000           [008] (13)
0698  0E000000           [009] (14)
069C  0E000000           [010] (14)
06A0  0E000000           [011] (14)
06A4  0E000000           [012] (14)
06A8  10000000           [013] (16)
06AC  10000000           [014] (16)
06B0  11000000           [015] (17)
06B4  11000000           [016] (17)
06B8  12000000           [017] (18)
06BC  14000000           [018] (20)
06C0  14000000           [019] (20)
06C4  14000000           [020] (20)
06C8  14000000           [021] (20)
06CC  14000000           [022] (20)
06D0  17000000           [023] (23)
06D4  17000000           [024] (23)
06D8  17000000           [025] (23)
06DC  17000000           [026] (23)
06E0  17000000           [027] (23)
06E4  17000000           [028] (23)
06E8  18000000           [029] (24)
06EC  18000000           [030] (24)
06F0  18000000           [031] (24)
06F4  18000000           [032] (24)
06F8  19000000           [033] (25)
06FC  19000000           [034] (25)
0700  19000000           [035] (25)
0704  19000000           [036] (25)
0708  18000000           [037] (24)
070C  19000000           [038] (25)
0710  23000000           [039] (35)
0714  1D000000           [040] (29)
0718  25000000           [041] (37)
071C  25000000           [042] (37)
0720  25000000           [043] (37)
0724  25000000           [044] (37)
0728  25000000           [045] (37)
072C  26000000           [046] (38)
0730  26000000           [047] (38)
0734  26000000           [048] (38)
0738  26000000           [049] (38)
073C  27000000           [050] (39)
0740  27000000           [051] (39)
0744  27000000           [052] (39)
0748  27000000           [053] (39)
074C  26000000           [054] (38)
0750  27000000           [055] (39)
0754  2B000000           [056] (43)
0758  2B000000           [057] (43)
075C  2B000000           [058] (43)
0760  2B000000           [059] (43)
0764  2B000000           [060] (43)
0768  2C000000           [061] (44)
076C  2C000000           [062] (44)
0770  2C000000           [063] (44)
0774  2C000000           [064] (44)
0778  2D000000           [065] (45)
077C  2D000000           [066] (45)
0780  2D000000           [067] (45)
0784  2D000000           [068] (45)
0788  2C000000           [069] (44)
078C  2D000000           [070] (45)
0790  33000000           [071] (51)
0794  31000000           [072] (49)
0798  34000000           [073] (52)
079C  34000000           [074] (52)
07A0  34000000           [075] (52)
07A4  34000000           [076] (52)
07A8  34000000           [077] (52)
07AC  35000000           [078] (53)
07B0  35000000           [079] (53)
07B4  35000000           [080] (53)
07B8  35000000           [081] (53)
07BC  36000000           [082] (54)
07C0  36000000           [083] (54)
07C4  36000000           [084] (54)
07C8  36000000           [085] (54)
07CC  35000000           [086] (53)
07D0  36000000           [087] (54)
07D4  42000000           [088] (66)
07D8  3A000000           [089] (58)
07DC  43000000           [090] (67)
07E0  43000000           [091] (67)
07E4  43000000           [092] (67)
07E8  43000000           [093] (67)
07EC  43000000           [094] (67)
07F0  43000000           [095] (67)
07F4  44000000           [096] (68)
07F8  44000000           [097] (68)
07FC  44000000           [098] (68)
0800  44000000           [099] (68)
0804  45000000           [100] (69)
0808  45000000           [101] (69)
080C  45000000           [102] (69)
0810  45000000           [103] (69)
0814  44000000           [104] (68)
0818  45000000           [105] (69)
081C  46000000           [106] (70)
                         * locals:
0820  1B000000           sizelocvars (27)
0824  0200000000000000   string size (2)
082C  6900               "i\0"
                         local [0]: i
082E  0E000000             startpc (14)
0832  15000000             endpc   (21)
0836  0200000000000000   string size (2)
083E  7600               "v\0"
                         local [1]: v
0840  0E000000             startpc (14)
0844  15000000             endpc   (21)
0848  1000000000000000   string size (16)
0850  28666F722067656E+  "(for gen"
0858  657261746F722900   "erator)\0"
                         local [2]: (for generator)
0860  1F000000             startpc (31)
0864  26000000             endpc   (38)
0868  0C00000000000000   string size (12)
0870  28666F7220737461+  "(for sta"
0878  74652900           "te)\0"
                         local [3]: (for state)
087C  1F000000             startpc (31)
0880  26000000             endpc   (38)
0884  0E00000000000000   string size (14)
088C  28666F7220636F6E+  "(for con"
0894  74726F6C2900       "trol)\0"
                         local [4]: (for control)
089A  1F000000             startpc (31)
089E  26000000             endpc   (38)
08A2  0200000000000000   string size (2)
08AA  6900               "i\0"
                         local [5]: i
08AC  20000000             startpc (32)
08B0  24000000             endpc   (36)
08B4  0200000000000000   string size (2)
08BC  7600               "v\0"
                         local [6]: v
08BE  20000000             startpc (32)
08C2  24000000             endpc   (36)
08C6  1000000000000000   string size (16)
08CE  28666F722067656E+  "(for gen"
08D6  657261746F722900   "erator)\0"
                         local [7]: (for generator)
08DE  30000000             startpc (48)
08E2  37000000             endpc   (55)
08E6  0C00000000000000   string size (12)
08EE  28666F7220737461+  "(for sta"
08F6  74652900           "te)\0"
                         local [8]: (for state)
08FA  30000000             startpc (48)
08FE  37000000             endpc   (55)
0902  0E00000000000000   string size (14)
090A  28666F7220636F6E+  "(for con"
0912  74726F6C2900       "trol)\0"
                         local [9]: (for control)
0918  30000000             startpc (48)
091C  37000000             endpc   (55)
0920  0200000000000000   string size (2)
0928  6B00               "k\0"
                         local [10]: k
092A  31000000             startpc (49)
092E  35000000             endpc   (53)
0932  0200000000000000   string size (2)
093A  7600               "v\0"
                         local [11]: v
093C  31000000             startpc (49)
0940  35000000             endpc   (53)
0944  1000000000000000   string size (16)
094C  28666F722067656E+  "(for gen"
0954  657261746F722900   "erator)\0"
                         local [12]: (for generator)
095C  3F000000             startpc (63)
0960  46000000             endpc   (70)
0964  0C00000000000000   string size (12)
096C  28666F7220737461+  "(for sta"
0974  74652900           "te)\0"
                         local [13]: (for state)
0978  3F000000             startpc (63)
097C  46000000             endpc   (70)
0980  0E00000000000000   string size (14)
0988  28666F7220636F6E+  "(for con"
0990  74726F6C2900       "trol)\0"
                         local [14]: (for control)
0996  3F000000             startpc (63)
099A  46000000             endpc   (70)
099E  0200000000000000   string size (2)
09A6  6B00               "k\0"
                         local [15]: k
09A8  40000000             startpc (64)
09AC  44000000             endpc   (68)
09B0  0200000000000000   string size (2)
09B8  7600               "v\0"
                         local [16]: v
09BA  40000000             startpc (64)
09BE  44000000             endpc   (68)
09C2  1000000000000000   string size (16)
09CA  28666F722067656E+  "(for gen"
09D2  657261746F722900   "erator)\0"
                         local [17]: (for generator)
09DA  50000000             startpc (80)
09DE  57000000             endpc   (87)
09E2  0C00000000000000   string size (12)
09EA  28666F7220737461+  "(for sta"
09F2  74652900           "te)\0"
                         local [18]: (for state)
09F6  50000000             startpc (80)
09FA  57000000             endpc   (87)
09FE  0E00000000000000   string size (14)
0A06  28666F7220636F6E+  "(for con"
0A0E  74726F6C2900       "trol)\0"
                         local [19]: (for control)
0A14  50000000             startpc (80)
0A18  57000000             endpc   (87)
0A1C  0200000000000000   string size (2)
0A24  6B00               "k\0"
                         local [20]: k
0A26  51000000             startpc (81)
0A2A  55000000             endpc   (85)
0A2E  0200000000000000   string size (2)
0A36  7600               "v\0"
                         local [21]: v
0A38  51000000             startpc (81)
0A3C  55000000             endpc   (85)
0A40  1000000000000000   string size (16)
0A48  28666F722067656E+  "(for gen"
0A50  657261746F722900   "erator)\0"
                         local [22]: (for generator)
0A58  62000000             startpc (98)
0A5C  69000000             endpc   (105)
0A60  0C00000000000000   string size (12)
0A68  28666F7220737461+  "(for sta"
0A70  74652900           "te)\0"
                         local [23]: (for state)
0A74  62000000             startpc (98)
0A78  69000000             endpc   (105)
0A7C  0E00000000000000   string size (14)
0A84  28666F7220636F6E+  "(for con"
0A8C  74726F6C2900       "trol)\0"
                         local [24]: (for control)
0A92  62000000             startpc (98)
0A96  69000000             endpc   (105)
0A9A  0200000000000000   string size (2)
0AA2  6900               "i\0"
                         local [25]: i
0AA4  63000000             startpc (99)
0AA8  67000000             endpc   (103)
0AAC  0200000000000000   string size (2)
0AB4  7600               "v\0"
                         local [26]: v
0AB6  63000000             startpc (99)
0ABA  67000000             endpc   (103)
                         * upvalues:
0ABE  00000000           sizeupvalues (0)
                         ** end of function 0 **

0AC2                     ** end of chunk **
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
002B  6A000000           sizecode (106)
002F  24000000           [001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [002] setglobal  0   0        ; ipairs := R0
0037  0A008001           [003] newtable   0   3   0    ; R0 := {} , array=3, hash=0
003B  41800000           [004] loadk      1   2        ; R1 := 10
003F  81C00000           [005] loadk      2   3        ; R2 := 20
0043  C1000100           [006] loadk      3   4        ; R3 := 30
0047  22408001           [007] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
004B  07400000           [008] setglobal  0   1        ; t := R0
004F  05000000           [009] getglobal  0   0        ; R0 := ipairs
0053  45400000           [010] getglobal  1   1        ; R1 := t
0057  1C800001           [011] call       0   2   2    ; R0 := R0(R1)
005B  07400100           [012] setglobal  0   5        ; iter := R0
005F  05400100           [013] getglobal  0   5        ; R0 := iter
0063  1CC08000           [014] call       0   1   3    ; R0, R1 := R0()
0067  17804100           [015] eq         0   0   262  ; R0 == nil, pc+=1 (goto [17]) if true
006B  16000080           [016] jmp        1            ; pc+=1 (goto [18])
006F  16000180           [017] jmp        5            ; pc+=5 (goto [23])
0073  85C00100           [018] getglobal  2   7        ; R2 := print
0077  C0000000           [019] move       3   0        ; R3 := R0
007B  00018000           [020] move       4   1        ; R4 := R1
007F  9C408001           [021] call       2   3   1    ;  := R2(R3, R4)
0083  1640FD7F           [022] jmp        -10          ; pc+=-10 (goto [13])
0087  0A008001           [023] newtable   0   3   0    ; R0 := {} , array=3, hash=0
008B  41800000           [024] loadk      1   2        ; R1 := 10
008F  81C00000           [025] loadk      2   3        ; R2 := 20
0093  C1000100           [026] loadk      3   4        ; R3 := 30
0097  22408001           [027] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
009B  07400000           [028] setglobal  0   1        ; t := R0
009F  05000000           [029] getglobal  0   0        ; R0 := ipairs
00A3  45400000           [030] getglobal  1   1        ; R1 := t
00A7  1C000101           [031] call       0   2   4    ; R0 to R2 := R0(R1)
00AB  16C00080           [032] jmp        4            ; pc+=4 (goto [37])
00AF  45C10100           [033] getglobal  5   7        ; R5 := print
00B3  80018001           [034] move       6   3        ; R6 := R3
00B7  C0010002           [035] move       7   4        ; R7 := R4
00BB  5C418001           [036] call       5   3   1    ;  := R5(R6, R7)
00BF  21800000           [037] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 39
00C3  1640FE7F           [038] jmp        -6           ; pc+=-6 (goto [33])
00C7  24400000           [039] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
00CB  07000200           [040] setglobal  0   8        ; pairs := R0
00CF  0AC00000           [041] newtable   0   0   3    ; R0 := {} , array=0, hash=3
00D3  0980C084           [042] settable   0   265 258  ; R0["a"] := 10
00D7  09C04085           [043] settable   0   266 259  ; R0["b"] := 20
00DB  0900C185           [044] settable   0   267 260  ; R0["c"] := 30
00DF  07400000           [045] setglobal  0   1        ; t := R0
00E3  05000200           [046] getglobal  0   8        ; R0 := pairs
00E7  45400000           [047] getglobal  1   1        ; R1 := t
00EB  1C000101           [048] call       0   2   4    ; R0 to R2 := R0(R1)
00EF  16C00080           [049] jmp        4            ; pc+=4 (goto [54])
00F3  45C10100           [050] getglobal  5   7        ; R5 := print
00F7  80018001           [051] move       6   3        ; R6 := R3
00FB  C0010002           [052] move       7   4        ; R7 := R4
00FF  5C418001           [053] call       5   3   1    ;  := R5(R6, R7)
0103  21800000           [054] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 56
0107  1640FE7F           [055] jmp        -6           ; pc+=-6 (goto [50])
010B  0AC00000           [056] newtable   0   0   3    ; R0 := {} , array=0, hash=3
010F  0980C084           [057] settable   0   265 258  ; R0["a"] := 10
0113  09C04085           [058] settable   0   266 259  ; R0["b"] := 20
0117  0900C185           [059] settable   0   267 260  ; R0["c"] := 30
011B  07400000           [060] setglobal  0   1        ; t := R0
011F  05000300           [061] getglobal  0   12       ; R0 := next
0123  45400000           [062] getglobal  1   1        ; R1 := t
0127  83000001           [063] loadnil    2   2        ; R2,  := nil
012B  16C00080           [064] jmp        4            ; pc+=4 (goto [69])
012F  45C10100           [065] getglobal  5   7        ; R5 := print
0133  80018001           [066] move       6   3        ; R6 := R3
0137  C0010002           [067] move       7   4        ; R7 := R4
013B  5C418001           [068] call       5   3   1    ;  := R5(R6, R7)
013F  21800000           [069] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 71
0143  1640FE7F           [070] jmp        -6           ; pc+=-6 (goto [65])
0147  24800000           [071] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
014B  07000200           [072] setglobal  0   8        ; pairs := R0
014F  0AC00000           [073] newtable   0   0   3    ; R0 := {} , array=0, hash=3
0153  0980C084           [074] settable   0   265 258  ; R0["a"] := 10
0157  09C04085           [075] settable   0   266 259  ; R0["b"] := 20
015B  0900C185           [076] settable   0   267 260  ; R0["c"] := 30
015F  07400000           [077] setglobal  0   1        ; t := R0
0163  05000200           [078] getglobal  0   8        ; R0 := pairs
0167  45400000           [079] getglobal  1   1        ; R1 := t
016B  1C000101           [080] call       0   2   4    ; R0 to R2 := R0(R1)
016F  16C00080           [081] jmp        4            ; pc+=4 (goto [86])
0173  45C10100           [082] getglobal  5   7        ; R5 := print
0177  80018001           [083] move       6   3        ; R6 := R3
017B  C0010002           [084] move       7   4        ; R7 := R4
017F  5C418001           [085] call       5   3   1    ;  := R5(R6, R7)
0183  21800000           [086] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 88
0187  1640FE7F           [087] jmp        -6           ; pc+=-6 (goto [82])
018B  24C00000           [088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
018F  07400300           [089] setglobal  0   13       ; inext := R0
0193  0A008001           [090] newtable   0   3   0    ; R0 := {} , array=3, hash=0
0197  41800000           [091] loadk      1   2        ; R1 := 10
019B  81C00000           [092] loadk      2   3        ; R2 := 20
019F  C1000100           [093] loadk      3   4        ; R3 := 30
01A3  22408001           [094] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
01A7  07400000           [095] setglobal  0   1        ; t := R0
01AB  05400300           [096] getglobal  0   13       ; R0 := inext
01AF  45400000           [097] getglobal  1   1        ; R1 := t
01B3  81800300           [098] loadk      2   14       ; R2 := 0
01B7  16C00080           [099] jmp        4            ; pc+=4 (goto [104])
01BB  45C10100           [100] getglobal  5   7        ; R5 := print
01BF  80018001           [101] move       6   3        ; R6 := R3
01C3  C0010002           [102] move       7   4        ; R7 := R4
01C7  5C418001           [103] call       5   3   1    ;  := R5(R6, R7)
01CB  21800000           [104] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 106
01CF  1640FE7F           [105] jmp        -6           ; pc+=-6 (goto [100])
01D3  1E008000           [106] return     0   1        ; return 
                         * constants:
01D7  0F000000           sizek (15)
01DB  04                 const type 4
01DC  0700000000000000   string size (7)
01E4  69706169727300     "ipairs\0"
                         const [0]: "ipairs"
01EB  04                 const type 4
01EC  0200000000000000   string size (2)
01F4  7400               "t\0"
                         const [1]: "t"
01F6  03                 const type 3
01F7  0000000000002440   const [2]: (10)
01FF  03                 const type 3
0200  0000000000003440   const [3]: (20)
0208  03                 const type 3
0209  0000000000003E40   const [4]: (30)
0211  04                 const type 4
0212  0500000000000000   string size (5)
021A  6974657200         "iter\0"
                         const [5]: "iter"
021F  00                 const type 0
                         const [6]: nil
0220  04                 const type 4
0221  0600000000000000   string size (6)
0229  7072696E7400       "print\0"
                         const [7]: "print"
022F  04                 const type 4
0230  0600000000000000   string size (6)
0238  706169727300       "pairs\0"
                         const [8]: "pairs"
023E  04                 const type 4
023F  0200000000000000   string size (2)
0247  6100               "a\0"
                         const [9]: "a"
0249  04                 const type 4
024A  0200000000000000   string size (2)
0252  6200               "b\0"
                         const [10]: "b"
0254  04                 const type 4
0255  0200000000000000   string size (2)
025D  6300               "c\0"
                         const [11]: "c"
025F  04                 const type 4
0260  0500000000000000   string size (5)
0268  6E65787400         "next\0"
                         const [12]: "next"
026D  04                 const type 4
026E  0600000000000000   string size (6)
0276  696E65787400       "inext\0"
                         const [13]: "inext"
027C  03                 const type 3
027D  0000000000000000   const [14]: (0)
                         * functions:
0285  04000000           sizep (4)
                         
0289                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0289  0000000000000000   string size (0)
                         source name: (none)
0291  01000000           line defined (1)
0295  0B000000           last line defined (11)
0299  00                 nups (0)
029A  01                 numparams (1)
029B  00                 is_vararg (0)
029C  03                 maxstacksize (3)
                         * code:
029D  06000000           sizecode (6)
02A1  41000000           [1] loadk      1   0        ; R1 := 0
02A5  A4000000           [2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
02A9  00008000           [3] move       0   1        ; R0 := R1
02AD  00000000           [4] move       0   0        ; R0 := R0
02B1  9E000001           [5] return     2   2        ; return R2
02B5  1E008000           [6] return     0   1        ; return 
                         * constants:
02B9  01000000           sizek (1)
02BD  03                 const type 3
02BE  0000000000000000   const [0]: (0)
                         * functions:
02C6  01000000           sizep (1)
                         
02CA                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
02CA  0000000000000000   string size (0)
                         source name: (none)
02D2  03000000           line defined (3)
02D6  0A000000           last line defined (10)
02DA  02                 nups (2)
02DB  00                 numparams (0)
02DC  00                 is_vararg (0)
02DD  03                 maxstacksize (3)
                         * code:
02DE  11000000           sizecode (17)
02E2  04000000           [01] getupval   0   0        ; R0 := U0 , i
02E6  0C004000           [02] add        0   0   256  ; R0 := R0 + 1
02EA  08000000           [03] setupval   0   0        ; U0 := R0 , i
02EE  04008000           [04] getupval   0   1        ; R0 := U1 , t
02F2  44000000           [05] getupval   1   0        ; R1 := U0 , i
02F6  06400000           [06] gettable   0   0   1    ; R0 := R0[R1]
02FA  17404000           [07] eq         0   0   257  ; R0 == nil, pc+=1 (goto [9]) if true
02FE  16800080           [08] jmp        3            ; pc+=3 (goto [12])
0302  03008000           [09] loadnil    0   1        ; R0, R1,  := nil
0306  1E008001           [10] return     0   3        ; return R0, R1
030A  16000180           [11] jmp        5            ; pc+=5 (goto [17])
030E  04000000           [12] getupval   0   0        ; R0 := U0 , i
0312  44008000           [13] getupval   1   1        ; R1 := U1 , t
0316  84000000           [14] getupval   2   0        ; R2 := U0 , i
031A  46808000           [15] gettable   1   1   2    ; R1 := R1[R2]
031E  1E008001           [16] return     0   3        ; return R0, R1
0322  1E008000           [17] return     0   1        ; return 
                         * constants:
0326  02000000           sizek (2)
032A  03                 const type 3
032B  000000000000F03F   const [0]: (1)
0333  00                 const type 0
                         const [1]: nil
                         * functions:
0334  00000000           sizep (0)
                         * lines:
0338  11000000           sizelineinfo (17)
                         [pc] (line)
033C  04000000           [01] (4)
0340  04000000           [02] (4)
0344  04000000           [03] (4)
0348  05000000           [04] (5)
034C  05000000           [05] (5)
0350  05000000           [06] (5)
0354  05000000           [07] (5)
0358  05000000           [08] (5)
035C  06000000           [09] (6)
0360  06000000           [10] (6)
0364  06000000           [11] (6)
0368  08000000           [12] (8)
036C  08000000           [13] (8)
0370  08000000           [14] (8)
0374  08000000           [15] (8)
0378  08000000           [16] (8)
037C  0A000000           [17] (10)
                         * locals:
0380  00000000           sizelocvars (0)
                         * upvalues:
0384  02000000           sizeupvalues (2)
0388  0200000000000000   string size (2)
0390  6900               "i\0"
                         upvalue [0]: i
0392  0200000000000000   string size (2)
039A  7400               "t\0"
                         upvalue [1]: t
                         ** end of function 0_0_0 **

                         * lines:
039C  06000000           sizelineinfo (6)
                         [pc] (line)
03A0  02000000           [1] (2)
03A4  0A000000           [2] (10)
03A8  0A000000           [3] (10)
03AC  0A000000           [4] (10)
03B0  0A000000           [5] (10)
03B4  0B000000           [6] (11)
                         * locals:
03B8  02000000           sizelocvars (2)
03BC  0200000000000000   string size (2)
03C4  7400               "t\0"
                         local [0]: t
03C6  00000000             startpc (0)
03CA  05000000             endpc   (5)
03CE  0200000000000000   string size (2)
03D6  6900               "i\0"
                         local [1]: i
03D8  01000000             startpc (1)
03DC  05000000             endpc   (5)
                         * upvalues:
03E0  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
03E4                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
03E4  0000000000000000   string size (0)
                         source name: (none)
03EC  1D000000           line defined (29)
03F0  23000000           last line defined (35)
03F4  00                 nups (0)
03F5  01                 numparams (1)
03F6  00                 is_vararg (0)
03F7  04                 maxstacksize (4)
                         * code:
03F8  06000000           sizecode (6)
03FC  E4000000           [1] closure    3   0        ; R3 := closure(function[0]) 3 upvalues
0400  00008000           [2] move       0   1        ; R0 := R1
0404  00000001           [3] move       0   2        ; R0 := R2
0408  00000000           [4] move       0   0        ; R0 := R0
040C  DE000001           [5] return     3   2        ; return R3
0410  1E008000           [6] return     0   1        ; return 
                         * constants:
0414  00000000           sizek (0)
                         * functions:
0418  01000000           sizep (1)
                         
041C                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
041C  0000000000000000   string size (0)
                         source name: (none)
0424  1F000000           line defined (31)
0428  22000000           last line defined (34)
042C  03                 nups (3)
042D  00                 numparams (0)
042E  00                 is_vararg (0)
042F  03                 maxstacksize (3)
                         * code:
0430  0A000000           sizecode (10)
0434  05000000           [01] getglobal  0   0        ; R0 := next
0438  44000001           [02] getupval   1   2        ; R1 := U2 , t
043C  84000000           [03] getupval   2   0        ; R2 := U0 , k
0440  1CC08001           [04] call       0   3   3    ; R0, R1 := R0(R1, R2)
0444  48008000           [05] setupval   1   1        ; U1 := R1 , v
0448  08000000           [06] setupval   0   0        ; U0 := R0 , k
044C  04000000           [07] getupval   0   0        ; R0 := U0 , k
0450  44008000           [08] getupval   1   1        ; R1 := U1 , v
0454  1E008001           [09] return     0   3        ; return R0, R1
0458  1E008000           [10] return     0   1        ; return 
                         * constants:
045C  01000000           sizek (1)
0460  04                 const type 4
0461  0500000000000000   string size (5)
0469  6E65787400         "next\0"
                         const [0]: "next"
                         * functions:
046E  00000000           sizep (0)
                         * lines:
0472  0A000000           sizelineinfo (10)
                         [pc] (line)
0476  20000000           [01] (32)
047A  20000000           [02] (32)
047E  20000000           [03] (32)
0482  20000000           [04] (32)
0486  20000000           [05] (32)
048A  20000000           [06] (32)
048E  21000000           [07] (33)
0492  21000000           [08] (33)
0496  21000000           [09] (33)
049A  22000000           [10] (34)
                         * locals:
049E  00000000           sizelocvars (0)
                         * upvalues:
04A2  03000000           sizeupvalues (3)
04A6  0200000000000000   string size (2)
04AE  6B00               "k\0"
                         upvalue [0]: k
04B0  0200000000000000   string size (2)
04B8  7600               "v\0"
                         upvalue [1]: v
04BA  0200000000000000   string size (2)
04C2  7400               "t\0"
                         upvalue [2]: t
                         ** end of function 0_1_0 **

                         * lines:
04C4  06000000           sizelineinfo (6)
                         [pc] (line)
04C8  22000000           [1] (34)
04CC  22000000           [2] (34)
04D0  22000000           [3] (34)
04D4  22000000           [4] (34)
04D8  22000000           [5] (34)
04DC  23000000           [6] (35)
                         * locals:
04E0  03000000           sizelocvars (3)
04E4  0200000000000000   string size (2)
04EC  7400               "t\0"
                         local [0]: t
04EE  00000000             startpc (0)
04F2  05000000             endpc   (5)
04F6  0200000000000000   string size (2)
04FE  6B00               "k\0"
                         local [1]: k
0500  00000000             startpc (0)
0504  05000000             endpc   (5)
0508  0200000000000000   string size (2)
0510  7600               "v\0"
                         local [2]: v
0512  00000000             startpc (0)
0516  05000000             endpc   (5)
                         * upvalues:
051A  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
051E                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
051E  0000000000000000   string size (0)
                         source name: (none)
0526  31000000           line defined (49)
052A  33000000           last line defined (51)
052E  00                 nups (0)
052F  01                 numparams (1)
0530  00                 is_vararg (0)
0531  04                 maxstacksize (4)
                         * code:
0532  05000000           sizecode (5)
0536  45000000           [1] getglobal  1   0        ; R1 := next
053A  80000000           [2] move       2   0        ; R2 := R0
053E  C3008001           [3] loadnil    3   3        ; R3,  := nil
0542  5E000002           [4] return     1   4        ; return R1 to R3
0546  1E008000           [5] return     0   1        ; return 
                         * constants:
054A  01000000           sizek (1)
054E  04                 const type 4
054F  0500000000000000   string size (5)
0557  6E65787400         "next\0"
                         const [0]: "next"
                         * functions:
055C  00000000           sizep (0)
                         * lines:
0560  05000000           sizelineinfo (5)
                         [pc] (line)
0564  32000000           [1] (50)
0568  32000000           [2] (50)
056C  32000000           [3] (50)
0570  32000000           [4] (50)
0574  33000000           [5] (51)
                         * locals:
0578  01000000           sizelocvars (1)
057C  0200000000000000   string size (2)
0584  7400               "t\0"
                         local [0]: t
0586  00000000             startpc (0)
058A  04000000             endpc   (4)
                         * upvalues:
058E  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
0592                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
0592  0000000000000000   string size (0)
                         source name: (none)
059A  3A000000           line defined (58)
059E  42000000           last line defined (66)
05A2  00                 nups (0)
05A3  02                 numparams (2)
05A4  00                 is_vararg (0)
05A5  06                 maxstacksize (6)
                         * code:
05A6  0B000000           sizecode (11)
05AA  8C00C000           [01] add        2   1   256  ; R2 := R1 + 1
05AE  C6800000           [02] gettable   3   0   2    ; R3 := R0[R2]
05B2  1740C001           [03] eq         0   3   257  ; R3 == nil, pc+=1 (goto [5]) if true
05B6  16800080           [04] jmp        3            ; pc+=3 (goto [8])
05BA  03010002           [05] loadnil    4   4        ; R4,  := nil
05BE  1E010001           [06] return     4   2        ; return R4
05C2  16800080           [07] jmp        3            ; pc+=3 (goto [11])
05C6  00010001           [08] move       4   2        ; R4 := R2
05CA  40018001           [09] move       5   3        ; R5 := R3
05CE  1E018001           [10] return     4   3        ; return R4, R5
05D2  1E008000           [11] return     0   1        ; return 
                         * constants:
05D6  02000000           sizek (2)
05DA  03                 const type 3
05DB  000000000000F03F   const [0]: (1)
05E3  00                 const type 0
                         const [1]: nil
                         * functions:
05E4  00000000           sizep (0)
                         * lines:
05E8  0B000000           sizelineinfo (11)
                         [pc] (line)
05EC  3B000000           [01] (59)
05F0  3C000000           [02] (60)
05F4  3D000000           [03] (61)
05F8  3D000000           [04] (61)
05FC  3E000000           [05] (62)
0600  3E000000           [06] (62)
0604  3E000000           [07] (62)
0608  40000000           [08] (64)
060C  40000000           [09] (64)
0610  40000000           [10] (64)
0614  42000000           [11] (66)
                         * locals:
0618  04000000           sizelocvars (4)
061C  0200000000000000   string size (2)
0624  7400               "t\0"
                         local [0]: t
0626  00000000             startpc (0)
062A  0A000000             endpc   (10)
062E  0200000000000000   string size (2)
0636  6900               "i\0"
                         local [1]: i
0638  00000000             startpc (0)
063C  0A000000             endpc   (10)
0640  0800000000000000   string size (8)
0648  6E65787449647800   "nextIdx\0"
                         local [2]: nextIdx
0650  01000000             startpc (1)
0654  0A000000             endpc   (10)
0658  0800000000000000   string size (8)
0660  6E65787456616C00   "nextVal\0"
                         local [3]: nextVal
0668  02000000             startpc (2)
066C  0A000000             endpc   (10)
                         * upvalues:
0670  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
0674  6A000000           sizelineinfo (106)
                         [pc] (line)
0678  0B000000           [001] (11)
067C  01000000           [002] (1)
0680  0D000000           [003] (13)
0684  0D000000           [004] (13)
0688  0D000000           [005] (13)
068C  0D000000           [006] (13)
0690  0D000000           [007] (13)
0694  0D000000           [008] (13)
0698  0E000000           [009] (14)
069C  0E000000           [010] (14)
06A0  0E000000           [011] (14)
06A4  0E000000           [012] (14)
06A8  10000000           [013] (16)
06AC  10000000           [014] (16)
06B0  11000000           [015] (17)
06B4  11000000           [016] (17)
06B8  12000000           [017] (18)
06BC  14000000           [018] (20)
06C0  14000000           [019] (20)
06C4  14000000           [020] (20)
06C8  14000000           [021] (20)
06CC  14000000           [022] (20)
06D0  17000000           [023] (23)
06D4  17000000           [024] (23)
06D8  17000000           [025] (23)
06DC  17000000           [026] (23)
06E0  17000000           [027] (23)
06E4  17000000           [028] (23)
06E8  18000000           [029] (24)
06EC  18000000           [030] (24)
06F0  18000000           [031] (24)
06F4  18000000           [032] (24)
06F8  19000000           [033] (25)
06FC  19000000           [034] (25)
0700  19000000           [035] (25)
0704  19000000           [036] (25)
0708  18000000           [037] (24)
070C  19000000           [038] (25)
0710  23000000           [039] (35)
0714  1D000000           [040] (29)
0718  25000000           [041] (37)
071C  25000000           [042] (37)
0720  25000000           [043] (37)
0724  25000000           [044] (37)
0728  25000000           [045] (37)
072C  26000000           [046] (38)
0730  26000000           [047] (38)
0734  26000000           [048] (38)
0738  26000000           [049] (38)
073C  27000000           [050] (39)
0740  27000000           [051] (39)
0744  27000000           [052] (39)
0748  27000000           [053] (39)
074C  26000000           [054] (38)
0750  27000000           [055] (39)
0754  2B000000           [056] (43)
0758  2B000000           [057] (43)
075C  2B000000           [058] (43)
0760  2B000000           [059] (43)
0764  2B000000           [060] (43)
0768  2C000000           [061] (44)
076C  2C000000           [062] (44)
0770  2C000000           [063] (44)
0774  2C000000           [064] (44)
0778  2D000000           [065] (45)
077C  2D000000           [066] (45)
0780  2D000000           [067] (45)
0784  2D000000           [068] (45)
0788  2C000000           [069] (44)
078C  2D000000           [070] (45)
0790  33000000           [071] (51)
0794  31000000           [072] (49)
0798  34000000           [073] (52)
079C  34000000           [074] (52)
07A0  34000000           [075] (52)
07A4  34000000           [076] (52)
07A8  34000000           [077] (52)
07AC  35000000           [078] (53)
07B0  35000000           [079] (53)
07B4  35000000           [080] (53)
07B8  35000000           [081] (53)
07BC  36000000           [082] (54)
07C0  36000000           [083] (54)
07C4  36000000           [084] (54)
07C8  36000000           [085] (54)
07CC  35000000           [086] (53)
07D0  36000000           [087] (54)
07D4  42000000           [088] (66)
07D8  3A000000           [089] (58)
07DC  43000000           [090] (67)
07E0  43000000           [091] (67)
07E4  43000000           [092] (67)
07E8  43000000           [093] (67)
07EC  43000000           [094] (67)
07F0  43000000           [095] (67)
07F4  44000000           [096] (68)
07F8  44000000           [097] (68)
07FC  44000000           [098] (68)
0800  44000000           [099] (68)
0804  45000000           [100] (69)
0808  45000000           [101] (69)
080C  45000000           [102] (69)
0810  45000000           [103] (69)
0814  44000000           [104] (68)
0818  45000000           [105] (69)
081C  46000000           [106] (70)
                         * locals:
0820  1B000000           sizelocvars (27)
0824  0200000000000000   string size (2)
082C  6900               "i\0"
                         local [0]: i
082E  0E000000             startpc (14)
0832  15000000             endpc   (21)
0836  0200000000000000   string size (2)
083E  7600               "v\0"
                         local [1]: v
0840  0E000000             startpc (14)
0844  15000000             endpc   (21)
0848  1000000000000000   string size (16)
0850  28666F722067656E+  "(for gen"
0858  657261746F722900   "erator)\0"
                         local [2]: (for generator)
0860  1F000000             startpc (31)
0864  26000000             endpc   (38)
0868  0C00000000000000   string size (12)
0870  28666F7220737461+  "(for sta"
0878  74652900           "te)\0"
                         local [3]: (for state)
087C  1F000000             startpc (31)
0880  26000000             endpc   (38)
0884  0E00000000000000   string size (14)
088C  28666F7220636F6E+  "(for con"
0894  74726F6C2900       "trol)\0"
                         local [4]: (for control)
089A  1F000000             startpc (31)
089E  26000000             endpc   (38)
08A2  0200000000000000   string size (2)
08AA  6900               "i\0"
                         local [5]: i
08AC  20000000             startpc (32)
08B0  24000000             endpc   (36)
08B4  0200000000000000   string size (2)
08BC  7600               "v\0"
                         local [6]: v
08BE  20000000             startpc (32)
08C2  24000000             endpc   (36)
08C6  1000000000000000   string size (16)
08CE  28666F722067656E+  "(for gen"
08D6  657261746F722900   "erator)\0"
                         local [7]: (for generator)
08DE  30000000             startpc (48)
08E2  37000000             endpc   (55)
08E6  0C00000000000000   string size (12)
08EE  28666F7220737461+  "(for sta"
08F6  74652900           "te)\0"
                         local [8]: (for state)
08FA  30000000             startpc (48)
08FE  37000000             endpc   (55)
0902  0E00000000000000   string size (14)
090A  28666F7220636F6E+  "(for con"
0912  74726F6C2900       "trol)\0"
                         local [9]: (for control)
0918  30000000             startpc (48)
091C  37000000             endpc   (55)
0920  0200000000000000   string size (2)
0928  6B00               "k\0"
                         local [10]: k
092A  31000000             startpc (49)
092E  35000000             endpc   (53)
0932  0200000000000000   string size (2)
093A  7600               "v\0"
                         local [11]: v
093C  31000000             startpc (49)
0940  35000000             endpc   (53)
0944  1000000000000000   string size (16)
094C  28666F722067656E+  "(for gen"
0954  657261746F722900   "erator)\0"
                         local [12]: (for generator)
095C  3F000000             startpc (63)
0960  46000000             endpc   (70)
0964  0C00000000000000   string size (12)
096C  28666F7220737461+  "(for sta"
0974  74652900           "te)\0"
                         local [13]: (for state)
0978  3F000000             startpc (63)
097C  46000000             endpc   (70)
0980  0E00000000000000   string size (14)
0988  28666F7220636F6E+  "(for con"
0990  74726F6C2900       "trol)\0"
                         local [14]: (for control)
0996  3F000000             startpc (63)
099A  46000000             endpc   (70)
099E  0200000000000000   string size (2)
09A6  6B00               "k\0"
                         local [15]: k
09A8  40000000             startpc (64)
09AC  44000000             endpc   (68)
09B0  0200000000000000   string size (2)
09B8  7600               "v\0"
                         local [16]: v
09BA  40000000             startpc (64)
09BE  44000000             endpc   (68)
09C2  1000000000000000   string size (16)
09CA  28666F722067656E+  "(for gen"
09D2  657261746F722900   "erator)\0"
                         local [17]: (for generator)
09DA  50000000             startpc (80)
09DE  57000000             endpc   (87)
09E2  0C00000000000000   string size (12)
09EA  28666F7220737461+  "(for sta"
09F2  74652900           "te)\0"
                         local [18]: (for state)
09F6  50000000             startpc (80)
09FA  57000000             endpc   (87)
09FE  0E00000000000000   string size (14)
0A06  28666F7220636F6E+  "(for con"
0A0E  74726F6C2900       "trol)\0"
                         local [19]: (for control)
0A14  50000000             startpc (80)
0A18  57000000             endpc   (87)
0A1C  0200000000000000   string size (2)
0A24  6B00               "k\0"
                         local [20]: k
0A26  51000000             startpc (81)
0A2A  55000000             endpc   (85)
0A2E  0200000000000000   string size (2)
0A36  7600               "v\0"
                         local [21]: v
0A38  51000000             startpc (81)
0A3C  55000000             endpc   (85)
0A40  1000000000000000   string size (16)
0A48  28666F722067656E+  "(for gen"
0A50  657261746F722900   "erator)\0"
                         local [22]: (for generator)
0A58  62000000             startpc (98)
0A5C  69000000             endpc   (105)
0A60  0C00000000000000   string size (12)
0A68  28666F7220737461+  "(for sta"
0A70  74652900           "te)\0"
                         local [23]: (for state)
0A74  62000000             startpc (98)
0A78  69000000             endpc   (105)
0A7C  0E00000000000000   string size (14)
0A84  28666F7220636F6E+  "(for con"
0A8C  74726F6C2900       "trol)\0"
                         local [24]: (for control)
0A92  62000000             startpc (98)
0A96  69000000             endpc   (105)
0A9A  0200000000000000   string size (2)
0AA2  6900               "i\0"
                         local [25]: i
0AA4  63000000             startpc (99)
0AA8  67000000             endpc   (103)
0AAC  0200000000000000   string size (2)
0AB4  7600               "v\0"
                         local [26]: v
0AB6  63000000             startpc (99)
0ABA  67000000             endpc   (103)
                         * upvalues:
0ABE  00000000           sizeupvalues (0)
                         ** end of function 0 **

0AC2                     ** end of chunk **
