------------------------------
function f(a, b, c)
  print(a, b, c)
end
f()              -->	nil	nil	nil
f(1, 2)          -->	1	2	nil
f(1, 2, 3, 4, 5) -->	1	2	3


function f(a, ...)
  local b, c = ...
  local t = {a, ...}
  print(a, b, c, #t, ...)
end
f()           -->	nil	nil	nil	0
f(1, 2)       -->	1	2	nil	2	2
f(1, 2, 3, 4) -->	1	2	3	4	2	3	4


function f()
  return 1, 2, 3
end
f()
a, b = f();       assert(a == 1 and b == 2)
a, b, c = f();    assert(a == 1 and b == 2 and c == 3)
a, b, c, d = f(); assert(a == 1 and b == 2 and c == 3 and d == nil)


function f()
  return 1, 2, 3
end
a, b = (f());        assert(a == 1 and b == nil)
a, b, c = 5, f(), 5; assert(a == 5 and b == 1 and c == 5)

function f()           return 3, 2, 1    end
function g()           return 4, f()     end
function h(a, b, c, d) print(a, b, c, d) end
h(4, f())                     -->	4	3	2	1
h(g())                        -->	4	3	2	1
print(table.unpack({4, f()})) -->	4	3	2	1

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.const  "f"  ; 0
.const  1  ; 1
.const  2  ; 2
.const  3  ; 3
.const  4  ; 4
.const  5  ; 5
.const  "a"  ; 6
.const  "b"  ; 7
.const  "assert"  ; 8
.const  "c"  ; 9
.const  "d"  ; 10
.const  nil  ; 11
.const  "g"  ; 12
.const  "h"  ; 13
.const  "print"  ; 14
.const  "table"  ; 15
.const  "unpack"  ; 16
[001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[002] setglobal  0   0        ; f := R0
[003] getglobal  0   0        ; R0 := f
[004] call       0   1   1    ;  := R0()
[005] getglobal  0   0        ; R0 := f
[006] loadk      1   1        ; R1 := 1
[007] loadk      2   2        ; R2 := 2
[008] call       0   3   1    ;  := R0(R1, R2)
[009] getglobal  0   0        ; R0 := f
[010] loadk      1   1        ; R1 := 1
[011] loadk      2   2        ; R2 := 2
[012] loadk      3   3        ; R3 := 3
[013] loadk      4   4        ; R4 := 4
[014] loadk      5   5        ; R5 := 5
[015] call       0   6   1    ;  := R0(R1 to R5)
[016] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[017] setglobal  0   0        ; f := R0
[018] getglobal  0   0        ; R0 := f
[019] call       0   1   1    ;  := R0()
[020] getglobal  0   0        ; R0 := f
[021] loadk      1   1        ; R1 := 1
[022] loadk      2   2        ; R2 := 2
[023] call       0   3   1    ;  := R0(R1, R2)
[024] getglobal  0   0        ; R0 := f
[025] loadk      1   1        ; R1 := 1
[026] loadk      2   2        ; R2 := 2
[027] loadk      3   3        ; R3 := 3
[028] loadk      4   4        ; R4 := 4
[029] call       0   5   1    ;  := R0(R1 to R4)
[030] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[031] setglobal  0   0        ; f := R0
[032] getglobal  0   0        ; R0 := f
[033] call       0   1   1    ;  := R0()
[034] getglobal  0   0        ; R0 := f
[035] call       0   1   3    ; R0, R1 := R0()
[036] setglobal  1   7        ; b := R1
[037] setglobal  0   6        ; a := R0
[038] getglobal  0   8        ; R0 := assert
[039] getglobal  1   6        ; R1 := a
[040] eq         0   1   257  ; R1 == 1, pc+=1 (goto [42]) if true
[041] jmp        3            ; pc+=3 (goto [45])
[042] getglobal  1   7        ; R1 := b
[043] eq         1   1   258  ; R1 == 2, pc+=1 (goto [45]) if false
[044] jmp        1            ; pc+=1 (goto [46])
[045] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [47])
[046] loadbool   1   1   0    ; R1 := true
[047] call       0   2   1    ;  := R0(R1)
[048] getglobal  0   0        ; R0 := f
[049] call       0   1   4    ; R0 to R2 := R0()
[050] setglobal  2   9        ; c := R2
[051] setglobal  1   7        ; b := R1
[052] setglobal  0   6        ; a := R0
[053] getglobal  0   8        ; R0 := assert
[054] getglobal  1   6        ; R1 := a
[055] eq         0   1   257  ; R1 == 1, pc+=1 (goto [57]) if true
[056] jmp        6            ; pc+=6 (goto [63])
[057] getglobal  1   7        ; R1 := b
[058] eq         0   1   258  ; R1 == 2, pc+=1 (goto [60]) if true
[059] jmp        3            ; pc+=3 (goto [63])
[060] getglobal  1   9        ; R1 := c
[061] eq         1   1   259  ; R1 == 3, pc+=1 (goto [63]) if false
[062] jmp        1            ; pc+=1 (goto [64])
[063] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [65])
[064] loadbool   1   1   0    ; R1 := true
[065] call       0   2   1    ;  := R0(R1)
[066] getglobal  0   0        ; R0 := f
[067] call       0   1   5    ; R0 to R3 := R0()
[068] setglobal  3   10       ; d := R3
[069] setglobal  2   9        ; c := R2
[070] setglobal  1   7        ; b := R1
[071] setglobal  0   6        ; a := R0
[072] getglobal  0   8        ; R0 := assert
[073] getglobal  1   6        ; R1 := a
[074] eq         0   1   257  ; R1 == 1, pc+=1 (goto [76]) if true
[075] jmp        9            ; pc+=9 (goto [85])
[076] getglobal  1   7        ; R1 := b
[077] eq         0   1   258  ; R1 == 2, pc+=1 (goto [79]) if true
[078] jmp        6            ; pc+=6 (goto [85])
[079] getglobal  1   9        ; R1 := c
[080] eq         0   1   259  ; R1 == 3, pc+=1 (goto [82]) if true
[081] jmp        3            ; pc+=3 (goto [85])
[082] getglobal  1   10       ; R1 := d
[083] eq         1   1   267  ; R1 == nil, pc+=1 (goto [85]) if false
[084] jmp        1            ; pc+=1 (goto [86])
[085] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [87])
[086] loadbool   1   1   0    ; R1 := true
[087] call       0   2   1    ;  := R0(R1)
[088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[089] setglobal  0   0        ; f := R0
[090] getglobal  0   0        ; R0 := f
[091] call       0   1   2    ; R0 := R0()
[092] loadnil    1   1        ; R1,  := nil
[093] setglobal  1   7        ; b := R1
[094] setglobal  0   6        ; a := R0
[095] getglobal  0   8        ; R0 := assert
[096] getglobal  1   6        ; R1 := a
[097] eq         0   1   257  ; R1 == 1, pc+=1 (goto [99]) if true
[098] jmp        3            ; pc+=3 (goto [102])
[099] getglobal  1   7        ; R1 := b
[100] eq         1   1   267  ; R1 == nil, pc+=1 (goto [102]) if false
[101] jmp        1            ; pc+=1 (goto [103])
[102] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [104])
[103] loadbool   1   1   0    ; R1 := true
[104] call       0   2   1    ;  := R0(R1)
[105] loadk      0   5        ; R0 := 5
[106] getglobal  1   0        ; R1 := f
[107] call       1   1   2    ; R1 := R1()
[108] loadk      2   5        ; R2 := 5
[109] setglobal  2   9        ; c := R2
[110] setglobal  1   7        ; b := R1
[111] setglobal  0   6        ; a := R0
[112] getglobal  0   8        ; R0 := assert
[113] getglobal  1   6        ; R1 := a
[114] eq         0   1   261  ; R1 == 5, pc+=1 (goto [116]) if true
[115] jmp        6            ; pc+=6 (goto [122])
[116] getglobal  1   7        ; R1 := b
[117] eq         0   1   257  ; R1 == 1, pc+=1 (goto [119]) if true
[118] jmp        3            ; pc+=3 (goto [122])
[119] getglobal  1   9        ; R1 := c
[120] eq         1   1   261  ; R1 == 5, pc+=1 (goto [122]) if false
[121] jmp        1            ; pc+=1 (goto [123])
[122] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [124])
[123] loadbool   1   1   0    ; R1 := true
[124] call       0   2   1    ;  := R0(R1)
[125] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[126] setglobal  0   0        ; f := R0
[127] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
[128] setglobal  0   12       ; g := R0
[129] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
[130] setglobal  0   13       ; h := R0
[131] getglobal  0   13       ; R0 := h
[132] loadk      1   4        ; R1 := 4
[133] getglobal  2   0        ; R2 := f
[134] call       2   1   0    ; R2 to top := R2()
[135] call       0   0   1    ;  := R0(R1 to top)
[136] getglobal  0   13       ; R0 := h
[137] getglobal  1   12       ; R1 := g
[138] call       1   1   0    ; R1 to top := R1()
[139] call       0   0   1    ;  := R0(R1 to top)
[140] getglobal  0   14       ; R0 := print
[141] getglobal  1   15       ; R1 := table
[142] gettable   1   1   272  ; R1 := R1["unpack"]
[143] newtable   2   1   0    ; R2 := {} , array=1, hash=0
[144] loadk      3   4        ; R3 := 4
[145] getglobal  4   0        ; R4 := f
[146] call       4   1   0    ; R4 to top := R4()
[147] setlist    2   0   1    ; R2[1 to top] := R3 to top
[148] call       1   2   0    ; R1 to top := R1(R2)
[149] call       0   0   1    ;  := R0(R1 to top)
[150] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 7 stacks
.function  0 3 0 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  "print"  ; 0
[1] getglobal  3   0        ; R3 := print
[2] move       4   0        ; R4 := R0
[3] move       5   1        ; R5 := R1
[4] move       6   2        ; R6 := R2
[5] call       3   4   1    ;  := R3(R4 to R6)
[6] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 3, 11 stacks
.function  0 1 3 11
.local  "a"  ; 0
.local  "arg"  ; 1
.local  "b"  ; 2
.local  "c"  ; 3
.local  "t"  ; 4
.const  "print"  ; 0
[01] vararg     2   3        ; R2, R3 := ...
[02] newtable   4   1   0    ; R4 := {} , array=1, hash=0
[03] move       5   0        ; R5 := R0
[04] vararg     6   0        ; R6 to top := ...
[05] setlist    4   0   1    ; R4[1 to top] := R5 to top
[06] getglobal  5   0        ; R5 := print
[07] move       6   0        ; R6 := R0
[08] move       7   2        ; R7 := R2
[09] move       8   3        ; R8 := R3
[10] len        9   4        ; R9 := #R4
[11] vararg     10  0        ; R10 to top := ...
[12] call       5   0   1    ;  := R5(R6 to top)
[13] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 3
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 3
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  3  ; 0
.const  2  ; 1
.const  1  ; 2
[1] loadk      0   0        ; R0 := 3
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 1
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  4  ; 0
.const  "f"  ; 1
[1] loadk      0   0        ; R0 := 4
[2] getglobal  1   1        ; R1 := f
[3] call       1   1   0    ; R1 to top := R1()
[4] return     0   0        ; return R0 to top
[5] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 4 params, is_vararg = 0, 9 stacks
.function  0 4 0 9
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "d"  ; 3
.const  "print"  ; 0
[1] getglobal  4   0        ; R4 := print
[2] move       5   0        ; R5 := R0
[3] move       6   1        ; R6 := R1
[4] move       7   2        ; R7 := R2
[5] move       8   3        ; R8 := R3
[6] call       4   5   1    ;  := R4(R5 to R8)
[7] return     0   1        ; return 
; end of function 0_6

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.const  "f"  ; 0
.const  1  ; 1
.const  2  ; 2
.const  3  ; 3
.const  4  ; 4
.const  5  ; 5
.const  "a"  ; 6
.const  "b"  ; 7
.const  "assert"  ; 8
.const  "c"  ; 9
.const  "d"  ; 10
.const  nil  ; 11
.const  "g"  ; 12
.const  "h"  ; 13
.const  "print"  ; 14
.const  "table"  ; 15
.const  "unpack"  ; 16
[001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[002] setglobal  0   0        ; f := R0
[003] getglobal  0   0        ; R0 := f
[004] call       0   1   1    ;  := R0()
[005] getglobal  0   0        ; R0 := f
[006] loadk      1   1        ; R1 := 1
[007] loadk      2   2        ; R2 := 2
[008] call       0   3   1    ;  := R0(R1, R2)
[009] getglobal  0   0        ; R0 := f
[010] loadk      1   1        ; R1 := 1
[011] loadk      2   2        ; R2 := 2
[012] loadk      3   3        ; R3 := 3
[013] loadk      4   4        ; R4 := 4
[014] loadk      5   5        ; R5 := 5
[015] call       0   6   1    ;  := R0(R1 to R5)
[016] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[017] setglobal  0   0        ; f := R0
[018] getglobal  0   0        ; R0 := f
[019] call       0   1   1    ;  := R0()
[020] getglobal  0   0        ; R0 := f
[021] loadk      1   1        ; R1 := 1
[022] loadk      2   2        ; R2 := 2
[023] call       0   3   1    ;  := R0(R1, R2)
[024] getglobal  0   0        ; R0 := f
[025] loadk      1   1        ; R1 := 1
[026] loadk      2   2        ; R2 := 2
[027] loadk      3   3        ; R3 := 3
[028] loadk      4   4        ; R4 := 4
[029] call       0   5   1    ;  := R0(R1 to R4)
[030] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[031] setglobal  0   0        ; f := R0
[032] getglobal  0   0        ; R0 := f
[033] call       0   1   1    ;  := R0()
[034] getglobal  0   0        ; R0 := f
[035] call       0   1   3    ; R0, R1 := R0()
[036] setglobal  1   7        ; b := R1
[037] setglobal  0   6        ; a := R0
[038] getglobal  0   8        ; R0 := assert
[039] getglobal  1   6        ; R1 := a
[040] eq         0   1   257  ; R1 == 1, pc+=1 (goto [42]) if true
[041] jmp        3            ; pc+=3 (goto [45])
[042] getglobal  1   7        ; R1 := b
[043] eq         1   1   258  ; R1 == 2, pc+=1 (goto [45]) if false
[044] jmp        1            ; pc+=1 (goto [46])
[045] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [47])
[046] loadbool   1   1   0    ; R1 := true
[047] call       0   2   1    ;  := R0(R1)
[048] getglobal  0   0        ; R0 := f
[049] call       0   1   4    ; R0 to R2 := R0()
[050] setglobal  2   9        ; c := R2
[051] setglobal  1   7        ; b := R1
[052] setglobal  0   6        ; a := R0
[053] getglobal  0   8        ; R0 := assert
[054] getglobal  1   6        ; R1 := a
[055] eq         0   1   257  ; R1 == 1, pc+=1 (goto [57]) if true
[056] jmp        6            ; pc+=6 (goto [63])
[057] getglobal  1   7        ; R1 := b
[058] eq         0   1   258  ; R1 == 2, pc+=1 (goto [60]) if true
[059] jmp        3            ; pc+=3 (goto [63])
[060] getglobal  1   9        ; R1 := c
[061] eq         1   1   259  ; R1 == 3, pc+=1 (goto [63]) if false
[062] jmp        1            ; pc+=1 (goto [64])
[063] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [65])
[064] loadbool   1   1   0    ; R1 := true
[065] call       0   2   1    ;  := R0(R1)
[066] getglobal  0   0        ; R0 := f
[067] call       0   1   5    ; R0 to R3 := R0()
[068] setglobal  3   10       ; d := R3
[069] setglobal  2   9        ; c := R2
[070] setglobal  1   7        ; b := R1
[071] setglobal  0   6        ; a := R0
[072] getglobal  0   8        ; R0 := assert
[073] getglobal  1   6        ; R1 := a
[074] eq         0   1   257  ; R1 == 1, pc+=1 (goto [76]) if true
[075] jmp        9            ; pc+=9 (goto [85])
[076] getglobal  1   7        ; R1 := b
[077] eq         0   1   258  ; R1 == 2, pc+=1 (goto [79]) if true
[078] jmp        6            ; pc+=6 (goto [85])
[079] getglobal  1   9        ; R1 := c
[080] eq         0   1   259  ; R1 == 3, pc+=1 (goto [82]) if true
[081] jmp        3            ; pc+=3 (goto [85])
[082] getglobal  1   10       ; R1 := d
[083] eq         1   1   267  ; R1 == nil, pc+=1 (goto [85]) if false
[084] jmp        1            ; pc+=1 (goto [86])
[085] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [87])
[086] loadbool   1   1   0    ; R1 := true
[087] call       0   2   1    ;  := R0(R1)
[088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[089] setglobal  0   0        ; f := R0
[090] getglobal  0   0        ; R0 := f
[091] call       0   1   2    ; R0 := R0()
[092] loadnil    1   1        ; R1,  := nil
[093] setglobal  1   7        ; b := R1
[094] setglobal  0   6        ; a := R0
[095] getglobal  0   8        ; R0 := assert
[096] getglobal  1   6        ; R1 := a
[097] eq         0   1   257  ; R1 == 1, pc+=1 (goto [99]) if true
[098] jmp        3            ; pc+=3 (goto [102])
[099] getglobal  1   7        ; R1 := b
[100] eq         1   1   267  ; R1 == nil, pc+=1 (goto [102]) if false
[101] jmp        1            ; pc+=1 (goto [103])
[102] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [104])
[103] loadbool   1   1   0    ; R1 := true
[104] call       0   2   1    ;  := R0(R1)
[105] loadk      0   5        ; R0 := 5
[106] getglobal  1   0        ; R1 := f
[107] call       1   1   2    ; R1 := R1()
[108] loadk      2   5        ; R2 := 5
[109] setglobal  2   9        ; c := R2
[110] setglobal  1   7        ; b := R1
[111] setglobal  0   6        ; a := R0
[112] getglobal  0   8        ; R0 := assert
[113] getglobal  1   6        ; R1 := a
[114] eq         0   1   261  ; R1 == 5, pc+=1 (goto [116]) if true
[115] jmp        6            ; pc+=6 (goto [122])
[116] getglobal  1   7        ; R1 := b
[117] eq         0   1   257  ; R1 == 1, pc+=1 (goto [119]) if true
[118] jmp        3            ; pc+=3 (goto [122])
[119] getglobal  1   9        ; R1 := c
[120] eq         1   1   261  ; R1 == 5, pc+=1 (goto [122]) if false
[121] jmp        1            ; pc+=1 (goto [123])
[122] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [124])
[123] loadbool   1   1   0    ; R1 := true
[124] call       0   2   1    ;  := R0(R1)
[125] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[126] setglobal  0   0        ; f := R0
[127] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
[128] setglobal  0   12       ; g := R0
[129] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
[130] setglobal  0   13       ; h := R0
[131] getglobal  0   13       ; R0 := h
[132] loadk      1   4        ; R1 := 4
[133] getglobal  2   0        ; R2 := f
[134] call       2   1   0    ; R2 to top := R2()
[135] call       0   0   1    ;  := R0(R1 to top)
[136] getglobal  0   13       ; R0 := h
[137] getglobal  1   12       ; R1 := g
[138] call       1   1   0    ; R1 to top := R1()
[139] call       0   0   1    ;  := R0(R1 to top)
[140] getglobal  0   14       ; R0 := print
[141] getglobal  1   15       ; R1 := table
[142] gettable   1   1   272  ; R1 := R1["unpack"]
[143] newtable   2   1   0    ; R2 := {} , array=1, hash=0
[144] loadk      3   4        ; R3 := 4
[145] getglobal  4   0        ; R4 := f
[146] call       4   1   0    ; R4 to top := R4()
[147] setlist    2   0   1    ; R2[1 to top] := R3 to top
[148] call       1   2   0    ; R1 to top := R1(R2)
[149] call       0   0   1    ;  := R0(R1 to top)
[150] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 7 stacks
.function  0 3 0 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  "print"  ; 0
[1] getglobal  3   0        ; R3 := print
[2] move       4   0        ; R4 := R0
[3] move       5   1        ; R5 := R1
[4] move       6   2        ; R6 := R2
[5] call       3   4   1    ;  := R3(R4 to R6)
[6] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 3, 11 stacks
.function  0 1 3 11
.local  "a"  ; 0
.local  "arg"  ; 1
.local  "b"  ; 2
.local  "c"  ; 3
.local  "t"  ; 4
.const  "print"  ; 0
[01] vararg     2   3        ; R2, R3 := ...
[02] newtable   4   1   0    ; R4 := {} , array=1, hash=0
[03] move       5   0        ; R5 := R0
[04] vararg     6   0        ; R6 to top := ...
[05] setlist    4   0   1    ; R4[1 to top] := R5 to top
[06] getglobal  5   0        ; R5 := print
[07] move       6   0        ; R6 := R0
[08] move       7   2        ; R7 := R2
[09] move       8   3        ; R8 := R3
[10] len        9   4        ; R9 := #R4
[11] vararg     10  0        ; R10 to top := ...
[12] call       5   0   1    ;  := R5(R6 to top)
[13] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 3
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  1  ; 0
.const  2  ; 1
.const  3  ; 2
[1] loadk      0   0        ; R0 := 1
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 3
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  3  ; 0
.const  2  ; 1
.const  1  ; 2
[1] loadk      0   0        ; R0 := 3
[2] loadk      1   1        ; R1 := 2
[3] loadk      2   2        ; R2 := 1
[4] return     0   4        ; return R0 to R2
[5] return     0   1        ; return 
; end of function 0_4


; function [5] definition (level 2) 0_5
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  4  ; 0
.const  "f"  ; 1
[1] loadk      0   0        ; R0 := 4
[2] getglobal  1   1        ; R1 := f
[3] call       1   1   0    ; R1 to top := R1()
[4] return     0   0        ; return R0 to top
[5] return     0   1        ; return 
; end of function 0_5


; function [6] definition (level 2) 0_6
; 0 upvalues, 4 params, is_vararg = 0, 9 stacks
.function  0 4 0 9
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.local  "d"  ; 3
.const  "print"  ; 0
[1] getglobal  4   0        ; R4 := print
[2] move       5   0        ; R5 := R0
[3] move       6   1        ; R6 := R1
[4] move       7   2        ; R7 := R2
[5] move       8   3        ; R8 := R3
[6] call       4   5   1    ;  := R4(R5 to R8)
[7] return     0   1        ; return 
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
002A  06                 maxstacksize (6)
                         * code:
002B  96000000           sizecode (150)
002F  24000000           [001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [002] setglobal  0   0        ; f := R0
0037  05000000           [003] getglobal  0   0        ; R0 := f
003B  1C408000           [004] call       0   1   1    ;  := R0()
003F  05000000           [005] getglobal  0   0        ; R0 := f
0043  41400000           [006] loadk      1   1        ; R1 := 1
0047  81800000           [007] loadk      2   2        ; R2 := 2
004B  1C408001           [008] call       0   3   1    ;  := R0(R1, R2)
004F  05000000           [009] getglobal  0   0        ; R0 := f
0053  41400000           [010] loadk      1   1        ; R1 := 1
0057  81800000           [011] loadk      2   2        ; R2 := 2
005B  C1C00000           [012] loadk      3   3        ; R3 := 3
005F  01010100           [013] loadk      4   4        ; R4 := 4
0063  41410100           [014] loadk      5   5        ; R5 := 5
0067  1C400003           [015] call       0   6   1    ;  := R0(R1 to R5)
006B  24400000           [016] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
006F  07000000           [017] setglobal  0   0        ; f := R0
0073  05000000           [018] getglobal  0   0        ; R0 := f
0077  1C408000           [019] call       0   1   1    ;  := R0()
007B  05000000           [020] getglobal  0   0        ; R0 := f
007F  41400000           [021] loadk      1   1        ; R1 := 1
0083  81800000           [022] loadk      2   2        ; R2 := 2
0087  1C408001           [023] call       0   3   1    ;  := R0(R1, R2)
008B  05000000           [024] getglobal  0   0        ; R0 := f
008F  41400000           [025] loadk      1   1        ; R1 := 1
0093  81800000           [026] loadk      2   2        ; R2 := 2
0097  C1C00000           [027] loadk      3   3        ; R3 := 3
009B  01010100           [028] loadk      4   4        ; R4 := 4
009F  1C408002           [029] call       0   5   1    ;  := R0(R1 to R4)
00A3  24800000           [030] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
00A7  07000000           [031] setglobal  0   0        ; f := R0
00AB  05000000           [032] getglobal  0   0        ; R0 := f
00AF  1C408000           [033] call       0   1   1    ;  := R0()
00B3  05000000           [034] getglobal  0   0        ; R0 := f
00B7  1CC08000           [035] call       0   1   3    ; R0, R1 := R0()
00BB  47C00100           [036] setglobal  1   7        ; b := R1
00BF  07800100           [037] setglobal  0   6        ; a := R0
00C3  05000200           [038] getglobal  0   8        ; R0 := assert
00C7  45800100           [039] getglobal  1   6        ; R1 := a
00CB  1740C000           [040] eq         0   1   257  ; R1 == 1, pc+=1 (goto [42]) if true
00CF  16800080           [041] jmp        3            ; pc+=3 (goto [45])
00D3  45C00100           [042] getglobal  1   7        ; R1 := b
00D7  5780C000           [043] eq         1   1   258  ; R1 == 2, pc+=1 (goto [45]) if false
00DB  16000080           [044] jmp        1            ; pc+=1 (goto [46])
00DF  42400000           [045] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [47])
00E3  42008000           [046] loadbool   1   1   0    ; R1 := true
00E7  1C400001           [047] call       0   2   1    ;  := R0(R1)
00EB  05000000           [048] getglobal  0   0        ; R0 := f
00EF  1C008100           [049] call       0   1   4    ; R0 to R2 := R0()
00F3  87400200           [050] setglobal  2   9        ; c := R2
00F7  47C00100           [051] setglobal  1   7        ; b := R1
00FB  07800100           [052] setglobal  0   6        ; a := R0
00FF  05000200           [053] getglobal  0   8        ; R0 := assert
0103  45800100           [054] getglobal  1   6        ; R1 := a
0107  1740C000           [055] eq         0   1   257  ; R1 == 1, pc+=1 (goto [57]) if true
010B  16400180           [056] jmp        6            ; pc+=6 (goto [63])
010F  45C00100           [057] getglobal  1   7        ; R1 := b
0113  1780C000           [058] eq         0   1   258  ; R1 == 2, pc+=1 (goto [60]) if true
0117  16800080           [059] jmp        3            ; pc+=3 (goto [63])
011B  45400200           [060] getglobal  1   9        ; R1 := c
011F  57C0C000           [061] eq         1   1   259  ; R1 == 3, pc+=1 (goto [63]) if false
0123  16000080           [062] jmp        1            ; pc+=1 (goto [64])
0127  42400000           [063] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [65])
012B  42008000           [064] loadbool   1   1   0    ; R1 := true
012F  1C400001           [065] call       0   2   1    ;  := R0(R1)
0133  05000000           [066] getglobal  0   0        ; R0 := f
0137  1C408100           [067] call       0   1   5    ; R0 to R3 := R0()
013B  C7800200           [068] setglobal  3   10       ; d := R3
013F  87400200           [069] setglobal  2   9        ; c := R2
0143  47C00100           [070] setglobal  1   7        ; b := R1
0147  07800100           [071] setglobal  0   6        ; a := R0
014B  05000200           [072] getglobal  0   8        ; R0 := assert
014F  45800100           [073] getglobal  1   6        ; R1 := a
0153  1740C000           [074] eq         0   1   257  ; R1 == 1, pc+=1 (goto [76]) if true
0157  16000280           [075] jmp        9            ; pc+=9 (goto [85])
015B  45C00100           [076] getglobal  1   7        ; R1 := b
015F  1780C000           [077] eq         0   1   258  ; R1 == 2, pc+=1 (goto [79]) if true
0163  16400180           [078] jmp        6            ; pc+=6 (goto [85])
0167  45400200           [079] getglobal  1   9        ; R1 := c
016B  17C0C000           [080] eq         0   1   259  ; R1 == 3, pc+=1 (goto [82]) if true
016F  16800080           [081] jmp        3            ; pc+=3 (goto [85])
0173  45800200           [082] getglobal  1   10       ; R1 := d
0177  57C0C200           [083] eq         1   1   267  ; R1 == nil, pc+=1 (goto [85]) if false
017B  16000080           [084] jmp        1            ; pc+=1 (goto [86])
017F  42400000           [085] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [87])
0183  42008000           [086] loadbool   1   1   0    ; R1 := true
0187  1C400001           [087] call       0   2   1    ;  := R0(R1)
018B  24C00000           [088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
018F  07000000           [089] setglobal  0   0        ; f := R0
0193  05000000           [090] getglobal  0   0        ; R0 := f
0197  1C808000           [091] call       0   1   2    ; R0 := R0()
019B  43008000           [092] loadnil    1   1        ; R1,  := nil
019F  47C00100           [093] setglobal  1   7        ; b := R1
01A3  07800100           [094] setglobal  0   6        ; a := R0
01A7  05000200           [095] getglobal  0   8        ; R0 := assert
01AB  45800100           [096] getglobal  1   6        ; R1 := a
01AF  1740C000           [097] eq         0   1   257  ; R1 == 1, pc+=1 (goto [99]) if true
01B3  16800080           [098] jmp        3            ; pc+=3 (goto [102])
01B7  45C00100           [099] getglobal  1   7        ; R1 := b
01BB  57C0C200           [100] eq         1   1   267  ; R1 == nil, pc+=1 (goto [102]) if false
01BF  16000080           [101] jmp        1            ; pc+=1 (goto [103])
01C3  42400000           [102] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [104])
01C7  42008000           [103] loadbool   1   1   0    ; R1 := true
01CB  1C400001           [104] call       0   2   1    ;  := R0(R1)
01CF  01400100           [105] loadk      0   5        ; R0 := 5
01D3  45000000           [106] getglobal  1   0        ; R1 := f
01D7  5C808000           [107] call       1   1   2    ; R1 := R1()
01DB  81400100           [108] loadk      2   5        ; R2 := 5
01DF  87400200           [109] setglobal  2   9        ; c := R2
01E3  47C00100           [110] setglobal  1   7        ; b := R1
01E7  07800100           [111] setglobal  0   6        ; a := R0
01EB  05000200           [112] getglobal  0   8        ; R0 := assert
01EF  45800100           [113] getglobal  1   6        ; R1 := a
01F3  1740C100           [114] eq         0   1   261  ; R1 == 5, pc+=1 (goto [116]) if true
01F7  16400180           [115] jmp        6            ; pc+=6 (goto [122])
01FB  45C00100           [116] getglobal  1   7        ; R1 := b
01FF  1740C000           [117] eq         0   1   257  ; R1 == 1, pc+=1 (goto [119]) if true
0203  16800080           [118] jmp        3            ; pc+=3 (goto [122])
0207  45400200           [119] getglobal  1   9        ; R1 := c
020B  5740C100           [120] eq         1   1   261  ; R1 == 5, pc+=1 (goto [122]) if false
020F  16000080           [121] jmp        1            ; pc+=1 (goto [123])
0213  42400000           [122] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [124])
0217  42008000           [123] loadbool   1   1   0    ; R1 := true
021B  1C400001           [124] call       0   2   1    ;  := R0(R1)
021F  24000100           [125] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0223  07000000           [126] setglobal  0   0        ; f := R0
0227  24400100           [127] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
022B  07000300           [128] setglobal  0   12       ; g := R0
022F  24800100           [129] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
0233  07400300           [130] setglobal  0   13       ; h := R0
0237  05400300           [131] getglobal  0   13       ; R0 := h
023B  41000100           [132] loadk      1   4        ; R1 := 4
023F  85000000           [133] getglobal  2   0        ; R2 := f
0243  9C008000           [134] call       2   1   0    ; R2 to top := R2()
0247  1C400000           [135] call       0   0   1    ;  := R0(R1 to top)
024B  05400300           [136] getglobal  0   13       ; R0 := h
024F  45000300           [137] getglobal  1   12       ; R1 := g
0253  5C008000           [138] call       1   1   0    ; R1 to top := R1()
0257  1C400000           [139] call       0   0   1    ;  := R0(R1 to top)
025B  05800300           [140] getglobal  0   14       ; R0 := print
025F  45C00300           [141] getglobal  1   15       ; R1 := table
0263  4600C400           [142] gettable   1   1   272  ; R1 := R1["unpack"]
0267  8A008000           [143] newtable   2   1   0    ; R2 := {} , array=1, hash=0
026B  C1000100           [144] loadk      3   4        ; R3 := 4
026F  05010000           [145] getglobal  4   0        ; R4 := f
0273  1C018000           [146] call       4   1   0    ; R4 to top := R4()
0277  A2400000           [147] setlist    2   0   1    ; R2[1 to top] := R3 to top
027B  5C000001           [148] call       1   2   0    ; R1 to top := R1(R2)
027F  1C400000           [149] call       0   0   1    ;  := R0(R1 to top)
0283  1E008000           [150] return     0   1        ; return 
                         * constants:
0287  11000000           sizek (17)
028B  04                 const type 4
028C  0200000000000000   string size (2)
0294  6600               "f\0"
                         const [0]: "f"
0296  03                 const type 3
0297  000000000000F03F   const [1]: (1)
029F  03                 const type 3
02A0  0000000000000040   const [2]: (2)
02A8  03                 const type 3
02A9  0000000000000840   const [3]: (3)
02B1  03                 const type 3
02B2  0000000000001040   const [4]: (4)
02BA  03                 const type 3
02BB  0000000000001440   const [5]: (5)
02C3  04                 const type 4
02C4  0200000000000000   string size (2)
02CC  6100               "a\0"
                         const [6]: "a"
02CE  04                 const type 4
02CF  0200000000000000   string size (2)
02D7  6200               "b\0"
                         const [7]: "b"
02D9  04                 const type 4
02DA  0700000000000000   string size (7)
02E2  61737365727400     "assert\0"
                         const [8]: "assert"
02E9  04                 const type 4
02EA  0200000000000000   string size (2)
02F2  6300               "c\0"
                         const [9]: "c"
02F4  04                 const type 4
02F5  0200000000000000   string size (2)
02FD  6400               "d\0"
                         const [10]: "d"
02FF  00                 const type 0
                         const [11]: nil
0300  04                 const type 4
0301  0200000000000000   string size (2)
0309  6700               "g\0"
                         const [12]: "g"
030B  04                 const type 4
030C  0200000000000000   string size (2)
0314  6800               "h\0"
                         const [13]: "h"
0316  04                 const type 4
0317  0600000000000000   string size (6)
031F  7072696E7400       "print\0"
                         const [14]: "print"
0325  04                 const type 4
0326  0600000000000000   string size (6)
032E  7461626C6500       "table\0"
                         const [15]: "table"
0334  04                 const type 4
0335  0700000000000000   string size (7)
033D  756E7061636B00     "unpack\0"
                         const [16]: "unpack"
                         * functions:
0344  07000000           sizep (7)
                         
0348                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0348  0000000000000000   string size (0)
                         source name: (none)
0350  01000000           line defined (1)
0354  03000000           last line defined (3)
0358  00                 nups (0)
0359  03                 numparams (3)
035A  00                 is_vararg (0)
035B  07                 maxstacksize (7)
                         * code:
035C  06000000           sizecode (6)
0360  C5000000           [1] getglobal  3   0        ; R3 := print
0364  00010000           [2] move       4   0        ; R4 := R0
0368  40018000           [3] move       5   1        ; R5 := R1
036C  80010001           [4] move       6   2        ; R6 := R2
0370  DC400002           [5] call       3   4   1    ;  := R3(R4 to R6)
0374  1E008000           [6] return     0   1        ; return 
                         * constants:
0378  01000000           sizek (1)
037C  04                 const type 4
037D  0600000000000000   string size (6)
0385  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
038B  00000000           sizep (0)
                         * lines:
038F  06000000           sizelineinfo (6)
                         [pc] (line)
0393  02000000           [1] (2)
0397  02000000           [2] (2)
039B  02000000           [3] (2)
039F  02000000           [4] (2)
03A3  02000000           [5] (2)
03A7  03000000           [6] (3)
                         * locals:
03AB  03000000           sizelocvars (3)
03AF  0200000000000000   string size (2)
03B7  6100               "a\0"
                         local [0]: a
03B9  00000000             startpc (0)
03BD  05000000             endpc   (5)
03C1  0200000000000000   string size (2)
03C9  6200               "b\0"
                         local [1]: b
03CB  00000000             startpc (0)
03CF  05000000             endpc   (5)
03D3  0200000000000000   string size (2)
03DB  6300               "c\0"
                         local [2]: c
03DD  00000000             startpc (0)
03E1  05000000             endpc   (5)
                         * upvalues:
03E5  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
03E9                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
03E9  0000000000000000   string size (0)
                         source name: (none)
03F1  09000000           line defined (9)
03F5  0D000000           last line defined (13)
03F9  00                 nups (0)
03FA  01                 numparams (1)
03FB  03                 is_vararg (3)
03FC  0B                 maxstacksize (11)
                         * code:
03FD  0D000000           sizecode (13)
0401  A5008001           [01] vararg     2   3        ; R2, R3 := ...
0405  0A018000           [02] newtable   4   1   0    ; R4 := {} , array=1, hash=0
0409  40010000           [03] move       5   0        ; R5 := R0
040D  A5010000           [04] vararg     6   0        ; R6 to top := ...
0411  22410000           [05] setlist    4   0   1    ; R4[1 to top] := R5 to top
0415  45010000           [06] getglobal  5   0        ; R5 := print
0419  80010000           [07] move       6   0        ; R6 := R0
041D  C0010001           [08] move       7   2        ; R7 := R2
0421  00028001           [09] move       8   3        ; R8 := R3
0425  54020002           [10] len        9   4        ; R9 := #R4
0429  A5020000           [11] vararg     10  0        ; R10 to top := ...
042D  5C410000           [12] call       5   0   1    ;  := R5(R6 to top)
0431  1E008000           [13] return     0   1        ; return 
                         * constants:
0435  01000000           sizek (1)
0439  04                 const type 4
043A  0600000000000000   string size (6)
0442  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
0448  00000000           sizep (0)
                         * lines:
044C  0D000000           sizelineinfo (13)
                         [pc] (line)
0450  0A000000           [01] (10)
0454  0B000000           [02] (11)
0458  0B000000           [03] (11)
045C  0B000000           [04] (11)
0460  0B000000           [05] (11)
0464  0C000000           [06] (12)
0468  0C000000           [07] (12)
046C  0C000000           [08] (12)
0470  0C000000           [09] (12)
0474  0C000000           [10] (12)
0478  0C000000           [11] (12)
047C  0C000000           [12] (12)
0480  0D000000           [13] (13)
                         * locals:
0484  05000000           sizelocvars (5)
0488  0200000000000000   string size (2)
0490  6100               "a\0"
                         local [0]: a
0492  00000000             startpc (0)
0496  0C000000             endpc   (12)
049A  0400000000000000   string size (4)
04A2  61726700           "arg\0"
                         local [1]: arg
04A6  00000000             startpc (0)
04AA  0C000000             endpc   (12)
04AE  0200000000000000   string size (2)
04B6  6200               "b\0"
                         local [2]: b
04B8  01000000             startpc (1)
04BC  0C000000             endpc   (12)
04C0  0200000000000000   string size (2)
04C8  6300               "c\0"
                         local [3]: c
04CA  01000000             startpc (1)
04CE  0C000000             endpc   (12)
04D2  0200000000000000   string size (2)
04DA  7400               "t\0"
                         local [4]: t
04DC  05000000             startpc (5)
04E0  0C000000             endpc   (12)
                         * upvalues:
04E4  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
04E8                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
04E8  0000000000000000   string size (0)
                         source name: (none)
04F0  13000000           line defined (19)
04F4  15000000           last line defined (21)
04F8  00                 nups (0)
04F9  00                 numparams (0)
04FA  00                 is_vararg (0)
04FB  03                 maxstacksize (3)
                         * code:
04FC  05000000           sizecode (5)
0500  01000000           [1] loadk      0   0        ; R0 := 1
0504  41400000           [2] loadk      1   1        ; R1 := 2
0508  81800000           [3] loadk      2   2        ; R2 := 3
050C  1E000002           [4] return     0   4        ; return R0 to R2
0510  1E008000           [5] return     0   1        ; return 
                         * constants:
0514  03000000           sizek (3)
0518  03                 const type 3
0519  000000000000F03F   const [0]: (1)
0521  03                 const type 3
0522  0000000000000040   const [1]: (2)
052A  03                 const type 3
052B  0000000000000840   const [2]: (3)
                         * functions:
0533  00000000           sizep (0)
                         * lines:
0537  05000000           sizelineinfo (5)
                         [pc] (line)
053B  14000000           [1] (20)
053F  14000000           [2] (20)
0543  14000000           [3] (20)
0547  14000000           [4] (20)
054B  15000000           [5] (21)
                         * locals:
054F  00000000           sizelocvars (0)
                         * upvalues:
0553  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
0557                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
0557  0000000000000000   string size (0)
                         source name: (none)
055F  1C000000           line defined (28)
0563  1E000000           last line defined (30)
0567  00                 nups (0)
0568  00                 numparams (0)
0569  00                 is_vararg (0)
056A  03                 maxstacksize (3)
                         * code:
056B  05000000           sizecode (5)
056F  01000000           [1] loadk      0   0        ; R0 := 1
0573  41400000           [2] loadk      1   1        ; R1 := 2
0577  81800000           [3] loadk      2   2        ; R2 := 3
057B  1E000002           [4] return     0   4        ; return R0 to R2
057F  1E008000           [5] return     0   1        ; return 
                         * constants:
0583  03000000           sizek (3)
0587  03                 const type 3
0588  000000000000F03F   const [0]: (1)
0590  03                 const type 3
0591  0000000000000040   const [1]: (2)
0599  03                 const type 3
059A  0000000000000840   const [2]: (3)
                         * functions:
05A2  00000000           sizep (0)
                         * lines:
05A6  05000000           sizelineinfo (5)
                         [pc] (line)
05AA  1D000000           [1] (29)
05AE  1D000000           [2] (29)
05B2  1D000000           [3] (29)
05B6  1D000000           [4] (29)
05BA  1E000000           [5] (30)
                         * locals:
05BE  00000000           sizelocvars (0)
                         * upvalues:
05C2  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
05C6                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
05C6  0000000000000000   string size (0)
                         source name: (none)
05CE  22000000           line defined (34)
05D2  22000000           last line defined (34)
05D6  00                 nups (0)
05D7  00                 numparams (0)
05D8  00                 is_vararg (0)
05D9  03                 maxstacksize (3)
                         * code:
05DA  05000000           sizecode (5)
05DE  01000000           [1] loadk      0   0        ; R0 := 3
05E2  41400000           [2] loadk      1   1        ; R1 := 2
05E6  81800000           [3] loadk      2   2        ; R2 := 1
05EA  1E000002           [4] return     0   4        ; return R0 to R2
05EE  1E008000           [5] return     0   1        ; return 
                         * constants:
05F2  03000000           sizek (3)
05F6  03                 const type 3
05F7  0000000000000840   const [0]: (3)
05FF  03                 const type 3
0600  0000000000000040   const [1]: (2)
0608  03                 const type 3
0609  000000000000F03F   const [2]: (1)
                         * functions:
0611  00000000           sizep (0)
                         * lines:
0615  05000000           sizelineinfo (5)
                         [pc] (line)
0619  22000000           [1] (34)
061D  22000000           [2] (34)
0621  22000000           [3] (34)
0625  22000000           [4] (34)
0629  22000000           [5] (34)
                         * locals:
062D  00000000           sizelocvars (0)
                         * upvalues:
0631  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
0635                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
0635  0000000000000000   string size (0)
                         source name: (none)
063D  23000000           line defined (35)
0641  23000000           last line defined (35)
0645  00                 nups (0)
0646  00                 numparams (0)
0647  00                 is_vararg (0)
0648  02                 maxstacksize (2)
                         * code:
0649  05000000           sizecode (5)
064D  01000000           [1] loadk      0   0        ; R0 := 4
0651  45400000           [2] getglobal  1   1        ; R1 := f
0655  5C008000           [3] call       1   1   0    ; R1 to top := R1()
0659  1E000000           [4] return     0   0        ; return R0 to top
065D  1E008000           [5] return     0   1        ; return 
                         * constants:
0661  02000000           sizek (2)
0665  03                 const type 3
0666  0000000000001040   const [0]: (4)
066E  04                 const type 4
066F  0200000000000000   string size (2)
0677  6600               "f\0"
                         const [1]: "f"
                         * functions:
0679  00000000           sizep (0)
                         * lines:
067D  05000000           sizelineinfo (5)
                         [pc] (line)
0681  23000000           [1] (35)
0685  23000000           [2] (35)
0689  23000000           [3] (35)
068D  23000000           [4] (35)
0691  23000000           [5] (35)
                         * locals:
0695  00000000           sizelocvars (0)
                         * upvalues:
0699  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
069D                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
069D  0000000000000000   string size (0)
                         source name: (none)
06A5  24000000           line defined (36)
06A9  24000000           last line defined (36)
06AD  00                 nups (0)
06AE  04                 numparams (4)
06AF  00                 is_vararg (0)
06B0  09                 maxstacksize (9)
                         * code:
06B1  07000000           sizecode (7)
06B5  05010000           [1] getglobal  4   0        ; R4 := print
06B9  40010000           [2] move       5   0        ; R5 := R0
06BD  80018000           [3] move       6   1        ; R6 := R1
06C1  C0010001           [4] move       7   2        ; R7 := R2
06C5  00028001           [5] move       8   3        ; R8 := R3
06C9  1C418002           [6] call       4   5   1    ;  := R4(R5 to R8)
06CD  1E008000           [7] return     0   1        ; return 
                         * constants:
06D1  01000000           sizek (1)
06D5  04                 const type 4
06D6  0600000000000000   string size (6)
06DE  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
06E4  00000000           sizep (0)
                         * lines:
06E8  07000000           sizelineinfo (7)
                         [pc] (line)
06EC  24000000           [1] (36)
06F0  24000000           [2] (36)
06F4  24000000           [3] (36)
06F8  24000000           [4] (36)
06FC  24000000           [5] (36)
0700  24000000           [6] (36)
0704  24000000           [7] (36)
                         * locals:
0708  04000000           sizelocvars (4)
070C  0200000000000000   string size (2)
0714  6100               "a\0"
                         local [0]: a
0716  00000000             startpc (0)
071A  06000000             endpc   (6)
071E  0200000000000000   string size (2)
0726  6200               "b\0"
                         local [1]: b
0728  00000000             startpc (0)
072C  06000000             endpc   (6)
0730  0200000000000000   string size (2)
0738  6300               "c\0"
                         local [2]: c
073A  00000000             startpc (0)
073E  06000000             endpc   (6)
0742  0200000000000000   string size (2)
074A  6400               "d\0"
                         local [3]: d
074C  00000000             startpc (0)
0750  06000000             endpc   (6)
                         * upvalues:
0754  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         * lines:
0758  96000000           sizelineinfo (150)
                         [pc] (line)
075C  03000000           [001] (3)
0760  01000000           [002] (1)
0764  04000000           [003] (4)
0768  04000000           [004] (4)
076C  05000000           [005] (5)
0770  05000000           [006] (5)
0774  05000000           [007] (5)
0778  05000000           [008] (5)
077C  06000000           [009] (6)
0780  06000000           [010] (6)
0784  06000000           [011] (6)
0788  06000000           [012] (6)
078C  06000000           [013] (6)
0790  06000000           [014] (6)
0794  06000000           [015] (6)
0798  0D000000           [016] (13)
079C  09000000           [017] (9)
07A0  0E000000           [018] (14)
07A4  0E000000           [019] (14)
07A8  0F000000           [020] (15)
07AC  0F000000           [021] (15)
07B0  0F000000           [022] (15)
07B4  0F000000           [023] (15)
07B8  10000000           [024] (16)
07BC  10000000           [025] (16)
07C0  10000000           [026] (16)
07C4  10000000           [027] (16)
07C8  10000000           [028] (16)
07CC  10000000           [029] (16)
07D0  15000000           [030] (21)
07D4  13000000           [031] (19)
07D8  16000000           [032] (22)
07DC  16000000           [033] (22)
07E0  17000000           [034] (23)
07E4  17000000           [035] (23)
07E8  17000000           [036] (23)
07EC  17000000           [037] (23)
07F0  17000000           [038] (23)
07F4  17000000           [039] (23)
07F8  17000000           [040] (23)
07FC  17000000           [041] (23)
0800  17000000           [042] (23)
0804  17000000           [043] (23)
0808  17000000           [044] (23)
080C  17000000           [045] (23)
0810  17000000           [046] (23)
0814  17000000           [047] (23)
0818  18000000           [048] (24)
081C  18000000           [049] (24)
0820  18000000           [050] (24)
0824  18000000           [051] (24)
0828  18000000           [052] (24)
082C  18000000           [053] (24)
0830  18000000           [054] (24)
0834  18000000           [055] (24)
0838  18000000           [056] (24)
083C  18000000           [057] (24)
0840  18000000           [058] (24)
0844  18000000           [059] (24)
0848  18000000           [060] (24)
084C  18000000           [061] (24)
0850  18000000           [062] (24)
0854  18000000           [063] (24)
0858  18000000           [064] (24)
085C  18000000           [065] (24)
0860  19000000           [066] (25)
0864  19000000           [067] (25)
0868  19000000           [068] (25)
086C  19000000           [069] (25)
0870  19000000           [070] (25)
0874  19000000           [071] (25)
0878  19000000           [072] (25)
087C  19000000           [073] (25)
0880  19000000           [074] (25)
0884  19000000           [075] (25)
0888  19000000           [076] (25)
088C  19000000           [077] (25)
0890  19000000           [078] (25)
0894  19000000           [079] (25)
0898  19000000           [080] (25)
089C  19000000           [081] (25)
08A0  19000000           [082] (25)
08A4  19000000           [083] (25)
08A8  19000000           [084] (25)
08AC  19000000           [085] (25)
08B0  19000000           [086] (25)
08B4  19000000           [087] (25)
08B8  1E000000           [088] (30)
08BC  1C000000           [089] (28)
08C0  1F000000           [090] (31)
08C4  1F000000           [091] (31)
08C8  1F000000           [092] (31)
08CC  1F000000           [093] (31)
08D0  1F000000           [094] (31)
08D4  1F000000           [095] (31)
08D8  1F000000           [096] (31)
08DC  1F000000           [097] (31)
08E0  1F000000           [098] (31)
08E4  1F000000           [099] (31)
08E8  1F000000           [100] (31)
08EC  1F000000           [101] (31)
08F0  1F000000           [102] (31)
08F4  1F000000           [103] (31)
08F8  1F000000           [104] (31)
08FC  20000000           [105] (32)
0900  20000000           [106] (32)
0904  20000000           [107] (32)
0908  20000000           [108] (32)
090C  20000000           [109] (32)
0910  20000000           [110] (32)
0914  20000000           [111] (32)
0918  20000000           [112] (32)
091C  20000000           [113] (32)
0920  20000000           [114] (32)
0924  20000000           [115] (32)
0928  20000000           [116] (32)
092C  20000000           [117] (32)
0930  20000000           [118] (32)
0934  20000000           [119] (32)
0938  20000000           [120] (32)
093C  20000000           [121] (32)
0940  20000000           [122] (32)
0944  20000000           [123] (32)
0948  20000000           [124] (32)
094C  22000000           [125] (34)
0950  22000000           [126] (34)
0954  23000000           [127] (35)
0958  23000000           [128] (35)
095C  24000000           [129] (36)
0960  24000000           [130] (36)
0964  25000000           [131] (37)
0968  25000000           [132] (37)
096C  25000000           [133] (37)
0970  25000000           [134] (37)
0974  25000000           [135] (37)
0978  26000000           [136] (38)
097C  26000000           [137] (38)
0980  26000000           [138] (38)
0984  26000000           [139] (38)
0988  27000000           [140] (39)
098C  27000000           [141] (39)
0990  27000000           [142] (39)
0994  27000000           [143] (39)
0998  27000000           [144] (39)
099C  27000000           [145] (39)
09A0  27000000           [146] (39)
09A4  27000000           [147] (39)
09A8  27000000           [148] (39)
09AC  27000000           [149] (39)
09B0  27000000           [150] (39)
                         * locals:
09B4  00000000           sizelocvars (0)
                         * upvalues:
09B8  00000000           sizeupvalues (0)
                         ** end of function 0 **

09BC                     ** end of chunk **
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
002B  96000000           sizecode (150)
002F  24000000           [001] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [002] setglobal  0   0        ; f := R0
0037  05000000           [003] getglobal  0   0        ; R0 := f
003B  1C408000           [004] call       0   1   1    ;  := R0()
003F  05000000           [005] getglobal  0   0        ; R0 := f
0043  41400000           [006] loadk      1   1        ; R1 := 1
0047  81800000           [007] loadk      2   2        ; R2 := 2
004B  1C408001           [008] call       0   3   1    ;  := R0(R1, R2)
004F  05000000           [009] getglobal  0   0        ; R0 := f
0053  41400000           [010] loadk      1   1        ; R1 := 1
0057  81800000           [011] loadk      2   2        ; R2 := 2
005B  C1C00000           [012] loadk      3   3        ; R3 := 3
005F  01010100           [013] loadk      4   4        ; R4 := 4
0063  41410100           [014] loadk      5   5        ; R5 := 5
0067  1C400003           [015] call       0   6   1    ;  := R0(R1 to R5)
006B  24400000           [016] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
006F  07000000           [017] setglobal  0   0        ; f := R0
0073  05000000           [018] getglobal  0   0        ; R0 := f
0077  1C408000           [019] call       0   1   1    ;  := R0()
007B  05000000           [020] getglobal  0   0        ; R0 := f
007F  41400000           [021] loadk      1   1        ; R1 := 1
0083  81800000           [022] loadk      2   2        ; R2 := 2
0087  1C408001           [023] call       0   3   1    ;  := R0(R1, R2)
008B  05000000           [024] getglobal  0   0        ; R0 := f
008F  41400000           [025] loadk      1   1        ; R1 := 1
0093  81800000           [026] loadk      2   2        ; R2 := 2
0097  C1C00000           [027] loadk      3   3        ; R3 := 3
009B  01010100           [028] loadk      4   4        ; R4 := 4
009F  1C408002           [029] call       0   5   1    ;  := R0(R1 to R4)
00A3  24800000           [030] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
00A7  07000000           [031] setglobal  0   0        ; f := R0
00AB  05000000           [032] getglobal  0   0        ; R0 := f
00AF  1C408000           [033] call       0   1   1    ;  := R0()
00B3  05000000           [034] getglobal  0   0        ; R0 := f
00B7  1CC08000           [035] call       0   1   3    ; R0, R1 := R0()
00BB  47C00100           [036] setglobal  1   7        ; b := R1
00BF  07800100           [037] setglobal  0   6        ; a := R0
00C3  05000200           [038] getglobal  0   8        ; R0 := assert
00C7  45800100           [039] getglobal  1   6        ; R1 := a
00CB  1740C000           [040] eq         0   1   257  ; R1 == 1, pc+=1 (goto [42]) if true
00CF  16800080           [041] jmp        3            ; pc+=3 (goto [45])
00D3  45C00100           [042] getglobal  1   7        ; R1 := b
00D7  5780C000           [043] eq         1   1   258  ; R1 == 2, pc+=1 (goto [45]) if false
00DB  16000080           [044] jmp        1            ; pc+=1 (goto [46])
00DF  42400000           [045] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [47])
00E3  42008000           [046] loadbool   1   1   0    ; R1 := true
00E7  1C400001           [047] call       0   2   1    ;  := R0(R1)
00EB  05000000           [048] getglobal  0   0        ; R0 := f
00EF  1C008100           [049] call       0   1   4    ; R0 to R2 := R0()
00F3  87400200           [050] setglobal  2   9        ; c := R2
00F7  47C00100           [051] setglobal  1   7        ; b := R1
00FB  07800100           [052] setglobal  0   6        ; a := R0
00FF  05000200           [053] getglobal  0   8        ; R0 := assert
0103  45800100           [054] getglobal  1   6        ; R1 := a
0107  1740C000           [055] eq         0   1   257  ; R1 == 1, pc+=1 (goto [57]) if true
010B  16400180           [056] jmp        6            ; pc+=6 (goto [63])
010F  45C00100           [057] getglobal  1   7        ; R1 := b
0113  1780C000           [058] eq         0   1   258  ; R1 == 2, pc+=1 (goto [60]) if true
0117  16800080           [059] jmp        3            ; pc+=3 (goto [63])
011B  45400200           [060] getglobal  1   9        ; R1 := c
011F  57C0C000           [061] eq         1   1   259  ; R1 == 3, pc+=1 (goto [63]) if false
0123  16000080           [062] jmp        1            ; pc+=1 (goto [64])
0127  42400000           [063] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [65])
012B  42008000           [064] loadbool   1   1   0    ; R1 := true
012F  1C400001           [065] call       0   2   1    ;  := R0(R1)
0133  05000000           [066] getglobal  0   0        ; R0 := f
0137  1C408100           [067] call       0   1   5    ; R0 to R3 := R0()
013B  C7800200           [068] setglobal  3   10       ; d := R3
013F  87400200           [069] setglobal  2   9        ; c := R2
0143  47C00100           [070] setglobal  1   7        ; b := R1
0147  07800100           [071] setglobal  0   6        ; a := R0
014B  05000200           [072] getglobal  0   8        ; R0 := assert
014F  45800100           [073] getglobal  1   6        ; R1 := a
0153  1740C000           [074] eq         0   1   257  ; R1 == 1, pc+=1 (goto [76]) if true
0157  16000280           [075] jmp        9            ; pc+=9 (goto [85])
015B  45C00100           [076] getglobal  1   7        ; R1 := b
015F  1780C000           [077] eq         0   1   258  ; R1 == 2, pc+=1 (goto [79]) if true
0163  16400180           [078] jmp        6            ; pc+=6 (goto [85])
0167  45400200           [079] getglobal  1   9        ; R1 := c
016B  17C0C000           [080] eq         0   1   259  ; R1 == 3, pc+=1 (goto [82]) if true
016F  16800080           [081] jmp        3            ; pc+=3 (goto [85])
0173  45800200           [082] getglobal  1   10       ; R1 := d
0177  57C0C200           [083] eq         1   1   267  ; R1 == nil, pc+=1 (goto [85]) if false
017B  16000080           [084] jmp        1            ; pc+=1 (goto [86])
017F  42400000           [085] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [87])
0183  42008000           [086] loadbool   1   1   0    ; R1 := true
0187  1C400001           [087] call       0   2   1    ;  := R0(R1)
018B  24C00000           [088] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
018F  07000000           [089] setglobal  0   0        ; f := R0
0193  05000000           [090] getglobal  0   0        ; R0 := f
0197  1C808000           [091] call       0   1   2    ; R0 := R0()
019B  43008000           [092] loadnil    1   1        ; R1,  := nil
019F  47C00100           [093] setglobal  1   7        ; b := R1
01A3  07800100           [094] setglobal  0   6        ; a := R0
01A7  05000200           [095] getglobal  0   8        ; R0 := assert
01AB  45800100           [096] getglobal  1   6        ; R1 := a
01AF  1740C000           [097] eq         0   1   257  ; R1 == 1, pc+=1 (goto [99]) if true
01B3  16800080           [098] jmp        3            ; pc+=3 (goto [102])
01B7  45C00100           [099] getglobal  1   7        ; R1 := b
01BB  57C0C200           [100] eq         1   1   267  ; R1 == nil, pc+=1 (goto [102]) if false
01BF  16000080           [101] jmp        1            ; pc+=1 (goto [103])
01C3  42400000           [102] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [104])
01C7  42008000           [103] loadbool   1   1   0    ; R1 := true
01CB  1C400001           [104] call       0   2   1    ;  := R0(R1)
01CF  01400100           [105] loadk      0   5        ; R0 := 5
01D3  45000000           [106] getglobal  1   0        ; R1 := f
01D7  5C808000           [107] call       1   1   2    ; R1 := R1()
01DB  81400100           [108] loadk      2   5        ; R2 := 5
01DF  87400200           [109] setglobal  2   9        ; c := R2
01E3  47C00100           [110] setglobal  1   7        ; b := R1
01E7  07800100           [111] setglobal  0   6        ; a := R0
01EB  05000200           [112] getglobal  0   8        ; R0 := assert
01EF  45800100           [113] getglobal  1   6        ; R1 := a
01F3  1740C100           [114] eq         0   1   261  ; R1 == 5, pc+=1 (goto [116]) if true
01F7  16400180           [115] jmp        6            ; pc+=6 (goto [122])
01FB  45C00100           [116] getglobal  1   7        ; R1 := b
01FF  1740C000           [117] eq         0   1   257  ; R1 == 1, pc+=1 (goto [119]) if true
0203  16800080           [118] jmp        3            ; pc+=3 (goto [122])
0207  45400200           [119] getglobal  1   9        ; R1 := c
020B  5740C100           [120] eq         1   1   261  ; R1 == 5, pc+=1 (goto [122]) if false
020F  16000080           [121] jmp        1            ; pc+=1 (goto [123])
0213  42400000           [122] loadbool   1   0   1    ; R1 := false; PC := pc+=1 (goto [124])
0217  42008000           [123] loadbool   1   1   0    ; R1 := true
021B  1C400001           [124] call       0   2   1    ;  := R0(R1)
021F  24000100           [125] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0223  07000000           [126] setglobal  0   0        ; f := R0
0227  24400100           [127] closure    0   5        ; R0 := closure(function[5]) 0 upvalues
022B  07000300           [128] setglobal  0   12       ; g := R0
022F  24800100           [129] closure    0   6        ; R0 := closure(function[6]) 0 upvalues
0233  07400300           [130] setglobal  0   13       ; h := R0
0237  05400300           [131] getglobal  0   13       ; R0 := h
023B  41000100           [132] loadk      1   4        ; R1 := 4
023F  85000000           [133] getglobal  2   0        ; R2 := f
0243  9C008000           [134] call       2   1   0    ; R2 to top := R2()
0247  1C400000           [135] call       0   0   1    ;  := R0(R1 to top)
024B  05400300           [136] getglobal  0   13       ; R0 := h
024F  45000300           [137] getglobal  1   12       ; R1 := g
0253  5C008000           [138] call       1   1   0    ; R1 to top := R1()
0257  1C400000           [139] call       0   0   1    ;  := R0(R1 to top)
025B  05800300           [140] getglobal  0   14       ; R0 := print
025F  45C00300           [141] getglobal  1   15       ; R1 := table
0263  4600C400           [142] gettable   1   1   272  ; R1 := R1["unpack"]
0267  8A008000           [143] newtable   2   1   0    ; R2 := {} , array=1, hash=0
026B  C1000100           [144] loadk      3   4        ; R3 := 4
026F  05010000           [145] getglobal  4   0        ; R4 := f
0273  1C018000           [146] call       4   1   0    ; R4 to top := R4()
0277  A2400000           [147] setlist    2   0   1    ; R2[1 to top] := R3 to top
027B  5C000001           [148] call       1   2   0    ; R1 to top := R1(R2)
027F  1C400000           [149] call       0   0   1    ;  := R0(R1 to top)
0283  1E008000           [150] return     0   1        ; return 
                         * constants:
0287  11000000           sizek (17)
028B  04                 const type 4
028C  0200000000000000   string size (2)
0294  6600               "f\0"
                         const [0]: "f"
0296  03                 const type 3
0297  000000000000F03F   const [1]: (1)
029F  03                 const type 3
02A0  0000000000000040   const [2]: (2)
02A8  03                 const type 3
02A9  0000000000000840   const [3]: (3)
02B1  03                 const type 3
02B2  0000000000001040   const [4]: (4)
02BA  03                 const type 3
02BB  0000000000001440   const [5]: (5)
02C3  04                 const type 4
02C4  0200000000000000   string size (2)
02CC  6100               "a\0"
                         const [6]: "a"
02CE  04                 const type 4
02CF  0200000000000000   string size (2)
02D7  6200               "b\0"
                         const [7]: "b"
02D9  04                 const type 4
02DA  0700000000000000   string size (7)
02E2  61737365727400     "assert\0"
                         const [8]: "assert"
02E9  04                 const type 4
02EA  0200000000000000   string size (2)
02F2  6300               "c\0"
                         const [9]: "c"
02F4  04                 const type 4
02F5  0200000000000000   string size (2)
02FD  6400               "d\0"
                         const [10]: "d"
02FF  00                 const type 0
                         const [11]: nil
0300  04                 const type 4
0301  0200000000000000   string size (2)
0309  6700               "g\0"
                         const [12]: "g"
030B  04                 const type 4
030C  0200000000000000   string size (2)
0314  6800               "h\0"
                         const [13]: "h"
0316  04                 const type 4
0317  0600000000000000   string size (6)
031F  7072696E7400       "print\0"
                         const [14]: "print"
0325  04                 const type 4
0326  0600000000000000   string size (6)
032E  7461626C6500       "table\0"
                         const [15]: "table"
0334  04                 const type 4
0335  0700000000000000   string size (7)
033D  756E7061636B00     "unpack\0"
                         const [16]: "unpack"
                         * functions:
0344  07000000           sizep (7)
                         
0348                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0348  0000000000000000   string size (0)
                         source name: (none)
0350  01000000           line defined (1)
0354  03000000           last line defined (3)
0358  00                 nups (0)
0359  03                 numparams (3)
035A  00                 is_vararg (0)
035B  07                 maxstacksize (7)
                         * code:
035C  06000000           sizecode (6)
0360  C5000000           [1] getglobal  3   0        ; R3 := print
0364  00010000           [2] move       4   0        ; R4 := R0
0368  40018000           [3] move       5   1        ; R5 := R1
036C  80010001           [4] move       6   2        ; R6 := R2
0370  DC400002           [5] call       3   4   1    ;  := R3(R4 to R6)
0374  1E008000           [6] return     0   1        ; return 
                         * constants:
0378  01000000           sizek (1)
037C  04                 const type 4
037D  0600000000000000   string size (6)
0385  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
038B  00000000           sizep (0)
                         * lines:
038F  06000000           sizelineinfo (6)
                         [pc] (line)
0393  02000000           [1] (2)
0397  02000000           [2] (2)
039B  02000000           [3] (2)
039F  02000000           [4] (2)
03A3  02000000           [5] (2)
03A7  03000000           [6] (3)
                         * locals:
03AB  03000000           sizelocvars (3)
03AF  0200000000000000   string size (2)
03B7  6100               "a\0"
                         local [0]: a
03B9  00000000             startpc (0)
03BD  05000000             endpc   (5)
03C1  0200000000000000   string size (2)
03C9  6200               "b\0"
                         local [1]: b
03CB  00000000             startpc (0)
03CF  05000000             endpc   (5)
03D3  0200000000000000   string size (2)
03DB  6300               "c\0"
                         local [2]: c
03DD  00000000             startpc (0)
03E1  05000000             endpc   (5)
                         * upvalues:
03E5  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
03E9                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
03E9  0000000000000000   string size (0)
                         source name: (none)
03F1  09000000           line defined (9)
03F5  0D000000           last line defined (13)
03F9  00                 nups (0)
03FA  01                 numparams (1)
03FB  03                 is_vararg (3)
03FC  0B                 maxstacksize (11)
                         * code:
03FD  0D000000           sizecode (13)
0401  A5008001           [01] vararg     2   3        ; R2, R3 := ...
0405  0A018000           [02] newtable   4   1   0    ; R4 := {} , array=1, hash=0
0409  40010000           [03] move       5   0        ; R5 := R0
040D  A5010000           [04] vararg     6   0        ; R6 to top := ...
0411  22410000           [05] setlist    4   0   1    ; R4[1 to top] := R5 to top
0415  45010000           [06] getglobal  5   0        ; R5 := print
0419  80010000           [07] move       6   0        ; R6 := R0
041D  C0010001           [08] move       7   2        ; R7 := R2
0421  00028001           [09] move       8   3        ; R8 := R3
0425  54020002           [10] len        9   4        ; R9 := #R4
0429  A5020000           [11] vararg     10  0        ; R10 to top := ...
042D  5C410000           [12] call       5   0   1    ;  := R5(R6 to top)
0431  1E008000           [13] return     0   1        ; return 
                         * constants:
0435  01000000           sizek (1)
0439  04                 const type 4
043A  0600000000000000   string size (6)
0442  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
0448  00000000           sizep (0)
                         * lines:
044C  0D000000           sizelineinfo (13)
                         [pc] (line)
0450  0A000000           [01] (10)
0454  0B000000           [02] (11)
0458  0B000000           [03] (11)
045C  0B000000           [04] (11)
0460  0B000000           [05] (11)
0464  0C000000           [06] (12)
0468  0C000000           [07] (12)
046C  0C000000           [08] (12)
0470  0C000000           [09] (12)
0474  0C000000           [10] (12)
0478  0C000000           [11] (12)
047C  0C000000           [12] (12)
0480  0D000000           [13] (13)
                         * locals:
0484  05000000           sizelocvars (5)
0488  0200000000000000   string size (2)
0490  6100               "a\0"
                         local [0]: a
0492  00000000             startpc (0)
0496  0C000000             endpc   (12)
049A  0400000000000000   string size (4)
04A2  61726700           "arg\0"
                         local [1]: arg
04A6  00000000             startpc (0)
04AA  0C000000             endpc   (12)
04AE  0200000000000000   string size (2)
04B6  6200               "b\0"
                         local [2]: b
04B8  01000000             startpc (1)
04BC  0C000000             endpc   (12)
04C0  0200000000000000   string size (2)
04C8  6300               "c\0"
                         local [3]: c
04CA  01000000             startpc (1)
04CE  0C000000             endpc   (12)
04D2  0200000000000000   string size (2)
04DA  7400               "t\0"
                         local [4]: t
04DC  05000000             startpc (5)
04E0  0C000000             endpc   (12)
                         * upvalues:
04E4  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
04E8                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
04E8  0000000000000000   string size (0)
                         source name: (none)
04F0  13000000           line defined (19)
04F4  15000000           last line defined (21)
04F8  00                 nups (0)
04F9  00                 numparams (0)
04FA  00                 is_vararg (0)
04FB  03                 maxstacksize (3)
                         * code:
04FC  05000000           sizecode (5)
0500  01000000           [1] loadk      0   0        ; R0 := 1
0504  41400000           [2] loadk      1   1        ; R1 := 2
0508  81800000           [3] loadk      2   2        ; R2 := 3
050C  1E000002           [4] return     0   4        ; return R0 to R2
0510  1E008000           [5] return     0   1        ; return 
                         * constants:
0514  03000000           sizek (3)
0518  03                 const type 3
0519  000000000000F03F   const [0]: (1)
0521  03                 const type 3
0522  0000000000000040   const [1]: (2)
052A  03                 const type 3
052B  0000000000000840   const [2]: (3)
                         * functions:
0533  00000000           sizep (0)
                         * lines:
0537  05000000           sizelineinfo (5)
                         [pc] (line)
053B  14000000           [1] (20)
053F  14000000           [2] (20)
0543  14000000           [3] (20)
0547  14000000           [4] (20)
054B  15000000           [5] (21)
                         * locals:
054F  00000000           sizelocvars (0)
                         * upvalues:
0553  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
0557                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
0557  0000000000000000   string size (0)
                         source name: (none)
055F  1C000000           line defined (28)
0563  1E000000           last line defined (30)
0567  00                 nups (0)
0568  00                 numparams (0)
0569  00                 is_vararg (0)
056A  03                 maxstacksize (3)
                         * code:
056B  05000000           sizecode (5)
056F  01000000           [1] loadk      0   0        ; R0 := 1
0573  41400000           [2] loadk      1   1        ; R1 := 2
0577  81800000           [3] loadk      2   2        ; R2 := 3
057B  1E000002           [4] return     0   4        ; return R0 to R2
057F  1E008000           [5] return     0   1        ; return 
                         * constants:
0583  03000000           sizek (3)
0587  03                 const type 3
0588  000000000000F03F   const [0]: (1)
0590  03                 const type 3
0591  0000000000000040   const [1]: (2)
0599  03                 const type 3
059A  0000000000000840   const [2]: (3)
                         * functions:
05A2  00000000           sizep (0)
                         * lines:
05A6  05000000           sizelineinfo (5)
                         [pc] (line)
05AA  1D000000           [1] (29)
05AE  1D000000           [2] (29)
05B2  1D000000           [3] (29)
05B6  1D000000           [4] (29)
05BA  1E000000           [5] (30)
                         * locals:
05BE  00000000           sizelocvars (0)
                         * upvalues:
05C2  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
05C6                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
05C6  0000000000000000   string size (0)
                         source name: (none)
05CE  22000000           line defined (34)
05D2  22000000           last line defined (34)
05D6  00                 nups (0)
05D7  00                 numparams (0)
05D8  00                 is_vararg (0)
05D9  03                 maxstacksize (3)
                         * code:
05DA  05000000           sizecode (5)
05DE  01000000           [1] loadk      0   0        ; R0 := 3
05E2  41400000           [2] loadk      1   1        ; R1 := 2
05E6  81800000           [3] loadk      2   2        ; R2 := 1
05EA  1E000002           [4] return     0   4        ; return R0 to R2
05EE  1E008000           [5] return     0   1        ; return 
                         * constants:
05F2  03000000           sizek (3)
05F6  03                 const type 3
05F7  0000000000000840   const [0]: (3)
05FF  03                 const type 3
0600  0000000000000040   const [1]: (2)
0608  03                 const type 3
0609  000000000000F03F   const [2]: (1)
                         * functions:
0611  00000000           sizep (0)
                         * lines:
0615  05000000           sizelineinfo (5)
                         [pc] (line)
0619  22000000           [1] (34)
061D  22000000           [2] (34)
0621  22000000           [3] (34)
0625  22000000           [4] (34)
0629  22000000           [5] (34)
                         * locals:
062D  00000000           sizelocvars (0)
                         * upvalues:
0631  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         
0635                     ** function [5] definition (level 2) 0_5
                         ** start of function 0_5 **
0635  0000000000000000   string size (0)
                         source name: (none)
063D  23000000           line defined (35)
0641  23000000           last line defined (35)
0645  00                 nups (0)
0646  00                 numparams (0)
0647  00                 is_vararg (0)
0648  02                 maxstacksize (2)
                         * code:
0649  05000000           sizecode (5)
064D  01000000           [1] loadk      0   0        ; R0 := 4
0651  45400000           [2] getglobal  1   1        ; R1 := f
0655  5C008000           [3] call       1   1   0    ; R1 to top := R1()
0659  1E000000           [4] return     0   0        ; return R0 to top
065D  1E008000           [5] return     0   1        ; return 
                         * constants:
0661  02000000           sizek (2)
0665  03                 const type 3
0666  0000000000001040   const [0]: (4)
066E  04                 const type 4
066F  0200000000000000   string size (2)
0677  6600               "f\0"
                         const [1]: "f"
                         * functions:
0679  00000000           sizep (0)
                         * lines:
067D  05000000           sizelineinfo (5)
                         [pc] (line)
0681  23000000           [1] (35)
0685  23000000           [2] (35)
0689  23000000           [3] (35)
068D  23000000           [4] (35)
0691  23000000           [5] (35)
                         * locals:
0695  00000000           sizelocvars (0)
                         * upvalues:
0699  00000000           sizeupvalues (0)
                         ** end of function 0_5 **

                         
069D                     ** function [6] definition (level 2) 0_6
                         ** start of function 0_6 **
069D  0000000000000000   string size (0)
                         source name: (none)
06A5  24000000           line defined (36)
06A9  24000000           last line defined (36)
06AD  00                 nups (0)
06AE  04                 numparams (4)
06AF  00                 is_vararg (0)
06B0  09                 maxstacksize (9)
                         * code:
06B1  07000000           sizecode (7)
06B5  05010000           [1] getglobal  4   0        ; R4 := print
06B9  40010000           [2] move       5   0        ; R5 := R0
06BD  80018000           [3] move       6   1        ; R6 := R1
06C1  C0010001           [4] move       7   2        ; R7 := R2
06C5  00028001           [5] move       8   3        ; R8 := R3
06C9  1C418002           [6] call       4   5   1    ;  := R4(R5 to R8)
06CD  1E008000           [7] return     0   1        ; return 
                         * constants:
06D1  01000000           sizek (1)
06D5  04                 const type 4
06D6  0600000000000000   string size (6)
06DE  7072696E7400       "print\0"
                         const [0]: "print"
                         * functions:
06E4  00000000           sizep (0)
                         * lines:
06E8  07000000           sizelineinfo (7)
                         [pc] (line)
06EC  24000000           [1] (36)
06F0  24000000           [2] (36)
06F4  24000000           [3] (36)
06F8  24000000           [4] (36)
06FC  24000000           [5] (36)
0700  24000000           [6] (36)
0704  24000000           [7] (36)
                         * locals:
0708  04000000           sizelocvars (4)
070C  0200000000000000   string size (2)
0714  6100               "a\0"
                         local [0]: a
0716  00000000             startpc (0)
071A  06000000             endpc   (6)
071E  0200000000000000   string size (2)
0726  6200               "b\0"
                         local [1]: b
0728  00000000             startpc (0)
072C  06000000             endpc   (6)
0730  0200000000000000   string size (2)
0738  6300               "c\0"
                         local [2]: c
073A  00000000             startpc (0)
073E  06000000             endpc   (6)
0742  0200000000000000   string size (2)
074A  6400               "d\0"
                         local [3]: d
074C  00000000             startpc (0)
0750  06000000             endpc   (6)
                         * upvalues:
0754  00000000           sizeupvalues (0)
                         ** end of function 0_6 **

                         * lines:
0758  96000000           sizelineinfo (150)
                         [pc] (line)
075C  03000000           [001] (3)
0760  01000000           [002] (1)
0764  04000000           [003] (4)
0768  04000000           [004] (4)
076C  05000000           [005] (5)
0770  05000000           [006] (5)
0774  05000000           [007] (5)
0778  05000000           [008] (5)
077C  06000000           [009] (6)
0780  06000000           [010] (6)
0784  06000000           [011] (6)
0788  06000000           [012] (6)
078C  06000000           [013] (6)
0790  06000000           [014] (6)
0794  06000000           [015] (6)
0798  0D000000           [016] (13)
079C  09000000           [017] (9)
07A0  0E000000           [018] (14)
07A4  0E000000           [019] (14)
07A8  0F000000           [020] (15)
07AC  0F000000           [021] (15)
07B0  0F000000           [022] (15)
07B4  0F000000           [023] (15)
07B8  10000000           [024] (16)
07BC  10000000           [025] (16)
07C0  10000000           [026] (16)
07C4  10000000           [027] (16)
07C8  10000000           [028] (16)
07CC  10000000           [029] (16)
07D0  15000000           [030] (21)
07D4  13000000           [031] (19)
07D8  16000000           [032] (22)
07DC  16000000           [033] (22)
07E0  17000000           [034] (23)
07E4  17000000           [035] (23)
07E8  17000000           [036] (23)
07EC  17000000           [037] (23)
07F0  17000000           [038] (23)
07F4  17000000           [039] (23)
07F8  17000000           [040] (23)
07FC  17000000           [041] (23)
0800  17000000           [042] (23)
0804  17000000           [043] (23)
0808  17000000           [044] (23)
080C  17000000           [045] (23)
0810  17000000           [046] (23)
0814  17000000           [047] (23)
0818  18000000           [048] (24)
081C  18000000           [049] (24)
0820  18000000           [050] (24)
0824  18000000           [051] (24)
0828  18000000           [052] (24)
082C  18000000           [053] (24)
0830  18000000           [054] (24)
0834  18000000           [055] (24)
0838  18000000           [056] (24)
083C  18000000           [057] (24)
0840  18000000           [058] (24)
0844  18000000           [059] (24)
0848  18000000           [060] (24)
084C  18000000           [061] (24)
0850  18000000           [062] (24)
0854  18000000           [063] (24)
0858  18000000           [064] (24)
085C  18000000           [065] (24)
0860  19000000           [066] (25)
0864  19000000           [067] (25)
0868  19000000           [068] (25)
086C  19000000           [069] (25)
0870  19000000           [070] (25)
0874  19000000           [071] (25)
0878  19000000           [072] (25)
087C  19000000           [073] (25)
0880  19000000           [074] (25)
0884  19000000           [075] (25)
0888  19000000           [076] (25)
088C  19000000           [077] (25)
0890  19000000           [078] (25)
0894  19000000           [079] (25)
0898  19000000           [080] (25)
089C  19000000           [081] (25)
08A0  19000000           [082] (25)
08A4  19000000           [083] (25)
08A8  19000000           [084] (25)
08AC  19000000           [085] (25)
08B0  19000000           [086] (25)
08B4  19000000           [087] (25)
08B8  1E000000           [088] (30)
08BC  1C000000           [089] (28)
08C0  1F000000           [090] (31)
08C4  1F000000           [091] (31)
08C8  1F000000           [092] (31)
08CC  1F000000           [093] (31)
08D0  1F000000           [094] (31)
08D4  1F000000           [095] (31)
08D8  1F000000           [096] (31)
08DC  1F000000           [097] (31)
08E0  1F000000           [098] (31)
08E4  1F000000           [099] (31)
08E8  1F000000           [100] (31)
08EC  1F000000           [101] (31)
08F0  1F000000           [102] (31)
08F4  1F000000           [103] (31)
08F8  1F000000           [104] (31)
08FC  20000000           [105] (32)
0900  20000000           [106] (32)
0904  20000000           [107] (32)
0908  20000000           [108] (32)
090C  20000000           [109] (32)
0910  20000000           [110] (32)
0914  20000000           [111] (32)
0918  20000000           [112] (32)
091C  20000000           [113] (32)
0920  20000000           [114] (32)
0924  20000000           [115] (32)
0928  20000000           [116] (32)
092C  20000000           [117] (32)
0930  20000000           [118] (32)
0934  20000000           [119] (32)
0938  20000000           [120] (32)
093C  20000000           [121] (32)
0940  20000000           [122] (32)
0944  20000000           [123] (32)
0948  20000000           [124] (32)
094C  22000000           [125] (34)
0950  22000000           [126] (34)
0954  23000000           [127] (35)
0958  23000000           [128] (35)
095C  24000000           [129] (36)
0960  24000000           [130] (36)
0964  25000000           [131] (37)
0968  25000000           [132] (37)
096C  25000000           [133] (37)
0970  25000000           [134] (37)
0974  25000000           [135] (37)
0978  26000000           [136] (38)
097C  26000000           [137] (38)
0980  26000000           [138] (38)
0984  26000000           [139] (38)
0988  27000000           [140] (39)
098C  27000000           [141] (39)
0990  27000000           [142] (39)
0994  27000000           [143] (39)
0998  27000000           [144] (39)
099C  27000000           [145] (39)
09A0  27000000           [146] (39)
09A4  27000000           [147] (39)
09A8  27000000           [148] (39)
09AC  27000000           [149] (39)
09B0  27000000           [150] (39)
                         * locals:
09B4  00000000           sizelocvars (0)
                         * upvalues:
09B8  00000000           sizeupvalues (0)
                         ** end of function 0 **

09BC                     ** end of chunk **
