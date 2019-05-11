------------------------------
co = coroutine.create(function() print("hello") end)
print(type(co)) --> thread


main = coroutine.running()
print(type(main))             --> thread
print(coroutine.status(main)) --> running


co = coroutine.create(function()
  print(coroutine.status(co)) --> running
  coroutine.resume(coroutine.create(function()
    print(coroutine.status(co)) --> normal
  end))
end)
print(coroutine.status(co)) --> suspended
coroutine.resume(co)
print(coroutine.status(co)) --> dead


co = coroutine.create(function(a, b, c)
  print(a, b, c)
  while true do 
    print(coroutine.yield())
  end
end)
coroutine.resume(co, 1, 2, 3) --> 1 2 3
coroutine.resume(co, 4, 5, 6) --> 4 5 6
coroutine.resume(co, 7, 8, 9) --> 7 8 9


co = coroutine.create(function()
  for k, v in pairs({"a", "b", "c"}) do
    coroutine.yield(k, v)
  end
  return "d", 4
end)
print(coroutine.resume(co)) --> true  1  a
print(coroutine.resume(co)) --> true  2  b
print(coroutine.resume(co)) --> true  3  c
print(coroutine.resume(co)) --> true  d  4
print(coroutine.resume(co)) --> false cannot resume dead coroutin

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.const  "co"  ; 0
.const  "coroutine"  ; 1
.const  "create"  ; 2
.const  "print"  ; 3
.const  "type"  ; 4
.const  "main"  ; 5
.const  "running"  ; 6
.const  "status"  ; 7
.const  "resume"  ; 8
.const  1  ; 9
.const  2  ; 10
.const  3  ; 11
.const  4  ; 12
.const  5  ; 13
.const  6  ; 14
.const  7  ; 15
.const  8  ; 16
.const  9  ; 17
[001] getglobal  0   1        ; R0 := coroutine
[002] gettable   0   0   258  ; R0 := R0["create"]
[003] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[004] call       0   2   2    ; R0 := R0(R1)
[005] setglobal  0   0        ; co := R0
[006] getglobal  0   3        ; R0 := print
[007] getglobal  1   4        ; R1 := type
[008] getglobal  2   0        ; R2 := co
[009] call       1   2   0    ; R1 to top := R1(R2)
[010] call       0   0   1    ;  := R0(R1 to top)
[011] getglobal  0   1        ; R0 := coroutine
[012] gettable   0   0   262  ; R0 := R0["running"]
[013] call       0   1   2    ; R0 := R0()
[014] setglobal  0   5        ; main := R0
[015] getglobal  0   3        ; R0 := print
[016] getglobal  1   4        ; R1 := type
[017] getglobal  2   5        ; R2 := main
[018] call       1   2   0    ; R1 to top := R1(R2)
[019] call       0   0   1    ;  := R0(R1 to top)
[020] getglobal  0   3        ; R0 := print
[021] getglobal  1   1        ; R1 := coroutine
[022] gettable   1   1   263  ; R1 := R1["status"]
[023] getglobal  2   5        ; R2 := main
[024] call       1   2   0    ; R1 to top := R1(R2)
[025] call       0   0   1    ;  := R0(R1 to top)
[026] getglobal  0   1        ; R0 := coroutine
[027] gettable   0   0   258  ; R0 := R0["create"]
[028] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[029] call       0   2   2    ; R0 := R0(R1)
[030] setglobal  0   0        ; co := R0
[031] getglobal  0   3        ; R0 := print
[032] getglobal  1   1        ; R1 := coroutine
[033] gettable   1   1   263  ; R1 := R1["status"]
[034] getglobal  2   0        ; R2 := co
[035] call       1   2   0    ; R1 to top := R1(R2)
[036] call       0   0   1    ;  := R0(R1 to top)
[037] getglobal  0   1        ; R0 := coroutine
[038] gettable   0   0   264  ; R0 := R0["resume"]
[039] getglobal  1   0        ; R1 := co
[040] call       0   2   1    ;  := R0(R1)
[041] getglobal  0   3        ; R0 := print
[042] getglobal  1   1        ; R1 := coroutine
[043] gettable   1   1   263  ; R1 := R1["status"]
[044] getglobal  2   0        ; R2 := co
[045] call       1   2   0    ; R1 to top := R1(R2)
[046] call       0   0   1    ;  := R0(R1 to top)
[047] getglobal  0   1        ; R0 := coroutine
[048] gettable   0   0   258  ; R0 := R0["create"]
[049] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[050] call       0   2   2    ; R0 := R0(R1)
[051] setglobal  0   0        ; co := R0
[052] getglobal  0   1        ; R0 := coroutine
[053] gettable   0   0   264  ; R0 := R0["resume"]
[054] getglobal  1   0        ; R1 := co
[055] loadk      2   9        ; R2 := 1
[056] loadk      3   10       ; R3 := 2
[057] loadk      4   11       ; R4 := 3
[058] call       0   5   1    ;  := R0(R1 to R4)
[059] getglobal  0   1        ; R0 := coroutine
[060] gettable   0   0   264  ; R0 := R0["resume"]
[061] getglobal  1   0        ; R1 := co
[062] loadk      2   12       ; R2 := 4
[063] loadk      3   13       ; R3 := 5
[064] loadk      4   14       ; R4 := 6
[065] call       0   5   1    ;  := R0(R1 to R4)
[066] getglobal  0   1        ; R0 := coroutine
[067] gettable   0   0   264  ; R0 := R0["resume"]
[068] getglobal  1   0        ; R1 := co
[069] loadk      2   15       ; R2 := 7
[070] loadk      3   16       ; R3 := 8
[071] loadk      4   17       ; R4 := 9
[072] call       0   5   1    ;  := R0(R1 to R4)
[073] getglobal  0   1        ; R0 := coroutine
[074] gettable   0   0   258  ; R0 := R0["create"]
[075] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[076] call       0   2   2    ; R0 := R0(R1)
[077] setglobal  0   0        ; co := R0
[078] getglobal  0   3        ; R0 := print
[079] getglobal  1   1        ; R1 := coroutine
[080] gettable   1   1   264  ; R1 := R1["resume"]
[081] getglobal  2   0        ; R2 := co
[082] call       1   2   0    ; R1 to top := R1(R2)
[083] call       0   0   1    ;  := R0(R1 to top)
[084] getglobal  0   3        ; R0 := print
[085] getglobal  1   1        ; R1 := coroutine
[086] gettable   1   1   264  ; R1 := R1["resume"]
[087] getglobal  2   0        ; R2 := co
[088] call       1   2   0    ; R1 to top := R1(R2)
[089] call       0   0   1    ;  := R0(R1 to top)
[090] getglobal  0   3        ; R0 := print
[091] getglobal  1   1        ; R1 := coroutine
[092] gettable   1   1   264  ; R1 := R1["resume"]
[093] getglobal  2   0        ; R2 := co
[094] call       1   2   0    ; R1 to top := R1(R2)
[095] call       0   0   1    ;  := R0(R1 to top)
[096] getglobal  0   3        ; R0 := print
[097] getglobal  1   1        ; R1 := coroutine
[098] gettable   1   1   264  ; R1 := R1["resume"]
[099] getglobal  2   0        ; R2 := co
[100] call       1   2   0    ; R1 to top := R1(R2)
[101] call       0   0   1    ;  := R0(R1 to top)
[102] getglobal  0   3        ; R0 := print
[103] getglobal  1   1        ; R1 := coroutine
[104] gettable   1   1   264  ; R1 := R1["resume"]
[105] getglobal  2   0        ; R2 := co
[106] call       1   2   0    ; R1 to top := R1(R2)
[107] call       0   0   1    ;  := R0(R1 to top)
[108] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "hello"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "hello"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "status"  ; 2
.const  "co"  ; 3
.const  "resume"  ; 4
.const  "create"  ; 5
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := coroutine
[03] gettable   1   1   258  ; R1 := R1["status"]
[04] getglobal  2   3        ; R2 := co
[05] call       1   2   0    ; R1 to top := R1(R2)
[06] call       0   0   1    ;  := R0(R1 to top)
[07] getglobal  0   1        ; R0 := coroutine
[08] gettable   0   0   260  ; R0 := R0["resume"]
[09] getglobal  1   1        ; R1 := coroutine
[10] gettable   1   1   261  ; R1 := R1["create"]
[11] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
[12] call       1   2   0    ; R1 to top := R1(R2)
[13] call       0   0   1    ;  := R0(R1 to top)
[14] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "status"  ; 2
.const  "co"  ; 3
[1] getglobal  0   0        ; R0 := print
[2] getglobal  1   1        ; R1 := coroutine
[3] gettable   1   1   258  ; R1 := R1["status"]
[4] getglobal  2   3        ; R2 := co
[5] call       1   2   0    ; R1 to top := R1(R2)
[6] call       0   0   1    ;  := R0(R1 to top)
[7] return     0   1        ; return 
; end of function 0_1_0

; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 3 params, is_vararg = 0, 7 stacks
.function  0 3 0 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "yield"  ; 2
[01] getglobal  3   0        ; R3 := print
[02] move       4   0        ; R4 := R0
[03] move       5   1        ; R5 := R1
[04] move       6   2        ; R6 := R2
[05] call       3   4   1    ;  := R3(R4 to R6)
[06] getglobal  3   0        ; R3 := print
[07] getglobal  4   1        ; R4 := coroutine
[08] gettable   4   4   258  ; R4 := R4["yield"]
[09] call       4   1   0    ; R4 to top := R4()
[10] call       3   0   1    ;  := R3(R4 to top)
[11] jmp        -6           ; pc+=-6 (goto [6])
[12] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 8 stacks
.function  0 0 0 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "k"  ; 3
.local  "v"  ; 4
.const  "pairs"  ; 0
.const  "a"  ; 1
.const  "b"  ; 2
.const  "c"  ; 3
.const  "coroutine"  ; 4
.const  "yield"  ; 5
.const  "d"  ; 6
.const  4  ; 7
[01] getglobal  0   0        ; R0 := pairs
[02] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[03] loadk      2   1        ; R2 := "a"
[04] loadk      3   2        ; R3 := "b"
[05] loadk      4   3        ; R4 := "c"
[06] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[07] call       0   2   4    ; R0 to R2 := R0(R1)
[08] jmp        5            ; pc+=5 (goto [14])
[09] getglobal  5   4        ; R5 := coroutine
[10] gettable   5   5   261  ; R5 := R5["yield"]
[11] move       6   3        ; R6 := R3
[12] move       7   4        ; R7 := R4
[13] call       5   3   1    ;  := R5(R6, R7)
[14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
[15] jmp        -7           ; pc+=-7 (goto [9])
[16] loadk      0   6        ; R0 := "d"
[17] loadk      1   7        ; R1 := 4
[18] return     0   3        ; return R0, R1
[19] return     0   1        ; return 
; end of function 0_3

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 5 stacks
.function  0 0 2 5
.const  "co"  ; 0
.const  "coroutine"  ; 1
.const  "create"  ; 2
.const  "print"  ; 3
.const  "type"  ; 4
.const  "main"  ; 5
.const  "running"  ; 6
.const  "status"  ; 7
.const  "resume"  ; 8
.const  1  ; 9
.const  2  ; 10
.const  3  ; 11
.const  4  ; 12
.const  5  ; 13
.const  6  ; 14
.const  7  ; 15
.const  8  ; 16
.const  9  ; 17
[001] getglobal  0   1        ; R0 := coroutine
[002] gettable   0   0   258  ; R0 := R0["create"]
[003] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[004] call       0   2   2    ; R0 := R0(R1)
[005] setglobal  0   0        ; co := R0
[006] getglobal  0   3        ; R0 := print
[007] getglobal  1   4        ; R1 := type
[008] getglobal  2   0        ; R2 := co
[009] call       1   2   0    ; R1 to top := R1(R2)
[010] call       0   0   1    ;  := R0(R1 to top)
[011] getglobal  0   1        ; R0 := coroutine
[012] gettable   0   0   262  ; R0 := R0["running"]
[013] call       0   1   2    ; R0 := R0()
[014] setglobal  0   5        ; main := R0
[015] getglobal  0   3        ; R0 := print
[016] getglobal  1   4        ; R1 := type
[017] getglobal  2   5        ; R2 := main
[018] call       1   2   0    ; R1 to top := R1(R2)
[019] call       0   0   1    ;  := R0(R1 to top)
[020] getglobal  0   3        ; R0 := print
[021] getglobal  1   1        ; R1 := coroutine
[022] gettable   1   1   263  ; R1 := R1["status"]
[023] getglobal  2   5        ; R2 := main
[024] call       1   2   0    ; R1 to top := R1(R2)
[025] call       0   0   1    ;  := R0(R1 to top)
[026] getglobal  0   1        ; R0 := coroutine
[027] gettable   0   0   258  ; R0 := R0["create"]
[028] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[029] call       0   2   2    ; R0 := R0(R1)
[030] setglobal  0   0        ; co := R0
[031] getglobal  0   3        ; R0 := print
[032] getglobal  1   1        ; R1 := coroutine
[033] gettable   1   1   263  ; R1 := R1["status"]
[034] getglobal  2   0        ; R2 := co
[035] call       1   2   0    ; R1 to top := R1(R2)
[036] call       0   0   1    ;  := R0(R1 to top)
[037] getglobal  0   1        ; R0 := coroutine
[038] gettable   0   0   264  ; R0 := R0["resume"]
[039] getglobal  1   0        ; R1 := co
[040] call       0   2   1    ;  := R0(R1)
[041] getglobal  0   3        ; R0 := print
[042] getglobal  1   1        ; R1 := coroutine
[043] gettable   1   1   263  ; R1 := R1["status"]
[044] getglobal  2   0        ; R2 := co
[045] call       1   2   0    ; R1 to top := R1(R2)
[046] call       0   0   1    ;  := R0(R1 to top)
[047] getglobal  0   1        ; R0 := coroutine
[048] gettable   0   0   258  ; R0 := R0["create"]
[049] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
[050] call       0   2   2    ; R0 := R0(R1)
[051] setglobal  0   0        ; co := R0
[052] getglobal  0   1        ; R0 := coroutine
[053] gettable   0   0   264  ; R0 := R0["resume"]
[054] getglobal  1   0        ; R1 := co
[055] loadk      2   9        ; R2 := 1
[056] loadk      3   10       ; R3 := 2
[057] loadk      4   11       ; R4 := 3
[058] call       0   5   1    ;  := R0(R1 to R4)
[059] getglobal  0   1        ; R0 := coroutine
[060] gettable   0   0   264  ; R0 := R0["resume"]
[061] getglobal  1   0        ; R1 := co
[062] loadk      2   12       ; R2 := 4
[063] loadk      3   13       ; R3 := 5
[064] loadk      4   14       ; R4 := 6
[065] call       0   5   1    ;  := R0(R1 to R4)
[066] getglobal  0   1        ; R0 := coroutine
[067] gettable   0   0   264  ; R0 := R0["resume"]
[068] getglobal  1   0        ; R1 := co
[069] loadk      2   15       ; R2 := 7
[070] loadk      3   16       ; R3 := 8
[071] loadk      4   17       ; R4 := 9
[072] call       0   5   1    ;  := R0(R1 to R4)
[073] getglobal  0   1        ; R0 := coroutine
[074] gettable   0   0   258  ; R0 := R0["create"]
[075] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
[076] call       0   2   2    ; R0 := R0(R1)
[077] setglobal  0   0        ; co := R0
[078] getglobal  0   3        ; R0 := print
[079] getglobal  1   1        ; R1 := coroutine
[080] gettable   1   1   264  ; R1 := R1["resume"]
[081] getglobal  2   0        ; R2 := co
[082] call       1   2   0    ; R1 to top := R1(R2)
[083] call       0   0   1    ;  := R0(R1 to top)
[084] getglobal  0   3        ; R0 := print
[085] getglobal  1   1        ; R1 := coroutine
[086] gettable   1   1   264  ; R1 := R1["resume"]
[087] getglobal  2   0        ; R2 := co
[088] call       1   2   0    ; R1 to top := R1(R2)
[089] call       0   0   1    ;  := R0(R1 to top)
[090] getglobal  0   3        ; R0 := print
[091] getglobal  1   1        ; R1 := coroutine
[092] gettable   1   1   264  ; R1 := R1["resume"]
[093] getglobal  2   0        ; R2 := co
[094] call       1   2   0    ; R1 to top := R1(R2)
[095] call       0   0   1    ;  := R0(R1 to top)
[096] getglobal  0   3        ; R0 := print
[097] getglobal  1   1        ; R1 := coroutine
[098] gettable   1   1   264  ; R1 := R1["resume"]
[099] getglobal  2   0        ; R2 := co
[100] call       1   2   0    ; R1 to top := R1(R2)
[101] call       0   0   1    ;  := R0(R1 to top)
[102] getglobal  0   3        ; R0 := print
[103] getglobal  1   1        ; R1 := coroutine
[104] gettable   1   1   264  ; R1 := R1["resume"]
[105] getglobal  2   0        ; R2 := co
[106] call       1   2   0    ; R1 to top := R1(R2)
[107] call       0   0   1    ;  := R0(R1 to top)
[108] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "print"  ; 0
.const  "hello"  ; 1
[1] getglobal  0   0        ; R0 := print
[2] loadk      1   1        ; R1 := "hello"
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "status"  ; 2
.const  "co"  ; 3
.const  "resume"  ; 4
.const  "create"  ; 5
[01] getglobal  0   0        ; R0 := print
[02] getglobal  1   1        ; R1 := coroutine
[03] gettable   1   1   258  ; R1 := R1["status"]
[04] getglobal  2   3        ; R2 := co
[05] call       1   2   0    ; R1 to top := R1(R2)
[06] call       0   0   1    ;  := R0(R1 to top)
[07] getglobal  0   1        ; R0 := coroutine
[08] gettable   0   0   260  ; R0 := R0["resume"]
[09] getglobal  1   1        ; R1 := coroutine
[10] gettable   1   1   261  ; R1 := R1["create"]
[11] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
[12] call       1   2   0    ; R1 to top := R1(R2)
[13] call       0   0   1    ;  := R0(R1 to top)
[14] return     0   1        ; return 

; function [0] definition (level 3) 0_1_0
; 0 upvalues, 0 params, is_vararg = 0, 3 stacks
.function  0 0 0 3
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "status"  ; 2
.const  "co"  ; 3
[1] getglobal  0   0        ; R0 := print
[2] getglobal  1   1        ; R1 := coroutine
[3] gettable   1   1   258  ; R1 := R1["status"]
[4] getglobal  2   3        ; R2 := co
[5] call       1   2   0    ; R1 to top := R1(R2)
[6] call       0   0   1    ;  := R0(R1 to top)
[7] return     0   1        ; return 
; end of function 0_1_0

; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 3 params, is_vararg = 0, 7 stacks
.function  0 3 0 7
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
.const  "print"  ; 0
.const  "coroutine"  ; 1
.const  "yield"  ; 2
[01] getglobal  3   0        ; R3 := print
[02] move       4   0        ; R4 := R0
[03] move       5   1        ; R5 := R1
[04] move       6   2        ; R6 := R2
[05] call       3   4   1    ;  := R3(R4 to R6)
[06] getglobal  3   0        ; R3 := print
[07] getglobal  4   1        ; R4 := coroutine
[08] gettable   4   4   258  ; R4 := R4["yield"]
[09] call       4   1   0    ; R4 to top := R4()
[10] call       3   0   1    ;  := R3(R4 to top)
[11] jmp        -6           ; pc+=-6 (goto [6])
[12] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 0 params, is_vararg = 0, 8 stacks
.function  0 0 0 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "k"  ; 3
.local  "v"  ; 4
.const  "pairs"  ; 0
.const  "a"  ; 1
.const  "b"  ; 2
.const  "c"  ; 3
.const  "coroutine"  ; 4
.const  "yield"  ; 5
.const  "d"  ; 6
.const  4  ; 7
[01] getglobal  0   0        ; R0 := pairs
[02] newtable   1   3   0    ; R1 := {} , array=3, hash=0
[03] loadk      2   1        ; R2 := "a"
[04] loadk      3   2        ; R3 := "b"
[05] loadk      4   3        ; R4 := "c"
[06] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
[07] call       0   2   4    ; R0 to R2 := R0(R1)
[08] jmp        5            ; pc+=5 (goto [14])
[09] getglobal  5   4        ; R5 := coroutine
[10] gettable   5   5   261  ; R5 := R5["yield"]
[11] move       6   3        ; R6 := R3
[12] move       7   4        ; R7 := R4
[13] call       5   3   1    ;  := R5(R6, R7)
[14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
[15] jmp        -7           ; pc+=-7 (goto [9])
[16] loadk      0   6        ; R0 := "d"
[17] loadk      1   7        ; R1 := 4
[18] return     0   3        ; return R0, R1
[19] return     0   1        ; return 
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
002A  05                 maxstacksize (5)
                         * code:
002B  6C000000           sizecode (108)
002F  05400000           [001] getglobal  0   1        ; R0 := coroutine
0033  06804000           [002] gettable   0   0   258  ; R0 := R0["create"]
0037  64000000           [003] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
003B  1C800001           [004] call       0   2   2    ; R0 := R0(R1)
003F  07000000           [005] setglobal  0   0        ; co := R0
0043  05C00000           [006] getglobal  0   3        ; R0 := print
0047  45000100           [007] getglobal  1   4        ; R1 := type
004B  85000000           [008] getglobal  2   0        ; R2 := co
004F  5C000001           [009] call       1   2   0    ; R1 to top := R1(R2)
0053  1C400000           [010] call       0   0   1    ;  := R0(R1 to top)
0057  05400000           [011] getglobal  0   1        ; R0 := coroutine
005B  06804100           [012] gettable   0   0   262  ; R0 := R0["running"]
005F  1C808000           [013] call       0   1   2    ; R0 := R0()
0063  07400100           [014] setglobal  0   5        ; main := R0
0067  05C00000           [015] getglobal  0   3        ; R0 := print
006B  45000100           [016] getglobal  1   4        ; R1 := type
006F  85400100           [017] getglobal  2   5        ; R2 := main
0073  5C000001           [018] call       1   2   0    ; R1 to top := R1(R2)
0077  1C400000           [019] call       0   0   1    ;  := R0(R1 to top)
007B  05C00000           [020] getglobal  0   3        ; R0 := print
007F  45400000           [021] getglobal  1   1        ; R1 := coroutine
0083  46C0C100           [022] gettable   1   1   263  ; R1 := R1["status"]
0087  85400100           [023] getglobal  2   5        ; R2 := main
008B  5C000001           [024] call       1   2   0    ; R1 to top := R1(R2)
008F  1C400000           [025] call       0   0   1    ;  := R0(R1 to top)
0093  05400000           [026] getglobal  0   1        ; R0 := coroutine
0097  06804000           [027] gettable   0   0   258  ; R0 := R0["create"]
009B  64400000           [028] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
009F  1C800001           [029] call       0   2   2    ; R0 := R0(R1)
00A3  07000000           [030] setglobal  0   0        ; co := R0
00A7  05C00000           [031] getglobal  0   3        ; R0 := print
00AB  45400000           [032] getglobal  1   1        ; R1 := coroutine
00AF  46C0C100           [033] gettable   1   1   263  ; R1 := R1["status"]
00B3  85000000           [034] getglobal  2   0        ; R2 := co
00B7  5C000001           [035] call       1   2   0    ; R1 to top := R1(R2)
00BB  1C400000           [036] call       0   0   1    ;  := R0(R1 to top)
00BF  05400000           [037] getglobal  0   1        ; R0 := coroutine
00C3  06004200           [038] gettable   0   0   264  ; R0 := R0["resume"]
00C7  45000000           [039] getglobal  1   0        ; R1 := co
00CB  1C400001           [040] call       0   2   1    ;  := R0(R1)
00CF  05C00000           [041] getglobal  0   3        ; R0 := print
00D3  45400000           [042] getglobal  1   1        ; R1 := coroutine
00D7  46C0C100           [043] gettable   1   1   263  ; R1 := R1["status"]
00DB  85000000           [044] getglobal  2   0        ; R2 := co
00DF  5C000001           [045] call       1   2   0    ; R1 to top := R1(R2)
00E3  1C400000           [046] call       0   0   1    ;  := R0(R1 to top)
00E7  05400000           [047] getglobal  0   1        ; R0 := coroutine
00EB  06804000           [048] gettable   0   0   258  ; R0 := R0["create"]
00EF  64800000           [049] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
00F3  1C800001           [050] call       0   2   2    ; R0 := R0(R1)
00F7  07000000           [051] setglobal  0   0        ; co := R0
00FB  05400000           [052] getglobal  0   1        ; R0 := coroutine
00FF  06004200           [053] gettable   0   0   264  ; R0 := R0["resume"]
0103  45000000           [054] getglobal  1   0        ; R1 := co
0107  81400200           [055] loadk      2   9        ; R2 := 1
010B  C1800200           [056] loadk      3   10       ; R3 := 2
010F  01C10200           [057] loadk      4   11       ; R4 := 3
0113  1C408002           [058] call       0   5   1    ;  := R0(R1 to R4)
0117  05400000           [059] getglobal  0   1        ; R0 := coroutine
011B  06004200           [060] gettable   0   0   264  ; R0 := R0["resume"]
011F  45000000           [061] getglobal  1   0        ; R1 := co
0123  81000300           [062] loadk      2   12       ; R2 := 4
0127  C1400300           [063] loadk      3   13       ; R3 := 5
012B  01810300           [064] loadk      4   14       ; R4 := 6
012F  1C408002           [065] call       0   5   1    ;  := R0(R1 to R4)
0133  05400000           [066] getglobal  0   1        ; R0 := coroutine
0137  06004200           [067] gettable   0   0   264  ; R0 := R0["resume"]
013B  45000000           [068] getglobal  1   0        ; R1 := co
013F  81C00300           [069] loadk      2   15       ; R2 := 7
0143  C1000400           [070] loadk      3   16       ; R3 := 8
0147  01410400           [071] loadk      4   17       ; R4 := 9
014B  1C408002           [072] call       0   5   1    ;  := R0(R1 to R4)
014F  05400000           [073] getglobal  0   1        ; R0 := coroutine
0153  06804000           [074] gettable   0   0   258  ; R0 := R0["create"]
0157  64C00000           [075] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
015B  1C800001           [076] call       0   2   2    ; R0 := R0(R1)
015F  07000000           [077] setglobal  0   0        ; co := R0
0163  05C00000           [078] getglobal  0   3        ; R0 := print
0167  45400000           [079] getglobal  1   1        ; R1 := coroutine
016B  4600C200           [080] gettable   1   1   264  ; R1 := R1["resume"]
016F  85000000           [081] getglobal  2   0        ; R2 := co
0173  5C000001           [082] call       1   2   0    ; R1 to top := R1(R2)
0177  1C400000           [083] call       0   0   1    ;  := R0(R1 to top)
017B  05C00000           [084] getglobal  0   3        ; R0 := print
017F  45400000           [085] getglobal  1   1        ; R1 := coroutine
0183  4600C200           [086] gettable   1   1   264  ; R1 := R1["resume"]
0187  85000000           [087] getglobal  2   0        ; R2 := co
018B  5C000001           [088] call       1   2   0    ; R1 to top := R1(R2)
018F  1C400000           [089] call       0   0   1    ;  := R0(R1 to top)
0193  05C00000           [090] getglobal  0   3        ; R0 := print
0197  45400000           [091] getglobal  1   1        ; R1 := coroutine
019B  4600C200           [092] gettable   1   1   264  ; R1 := R1["resume"]
019F  85000000           [093] getglobal  2   0        ; R2 := co
01A3  5C000001           [094] call       1   2   0    ; R1 to top := R1(R2)
01A7  1C400000           [095] call       0   0   1    ;  := R0(R1 to top)
01AB  05C00000           [096] getglobal  0   3        ; R0 := print
01AF  45400000           [097] getglobal  1   1        ; R1 := coroutine
01B3  4600C200           [098] gettable   1   1   264  ; R1 := R1["resume"]
01B7  85000000           [099] getglobal  2   0        ; R2 := co
01BB  5C000001           [100] call       1   2   0    ; R1 to top := R1(R2)
01BF  1C400000           [101] call       0   0   1    ;  := R0(R1 to top)
01C3  05C00000           [102] getglobal  0   3        ; R0 := print
01C7  45400000           [103] getglobal  1   1        ; R1 := coroutine
01CB  4600C200           [104] gettable   1   1   264  ; R1 := R1["resume"]
01CF  85000000           [105] getglobal  2   0        ; R2 := co
01D3  5C000001           [106] call       1   2   0    ; R1 to top := R1(R2)
01D7  1C400000           [107] call       0   0   1    ;  := R0(R1 to top)
01DB  1E008000           [108] return     0   1        ; return 
                         * constants:
01DF  12000000           sizek (18)
01E3  04                 const type 4
01E4  0300000000000000   string size (3)
01EC  636F00             "co\0"
                         const [0]: "co"
01EF  04                 const type 4
01F0  0A00000000000000   string size (10)
01F8  636F726F7574696E+  "coroutin"
0200  6500               "e\0"
                         const [1]: "coroutine"
0202  04                 const type 4
0203  0700000000000000   string size (7)
020B  63726561746500     "create\0"
                         const [2]: "create"
0212  04                 const type 4
0213  0600000000000000   string size (6)
021B  7072696E7400       "print\0"
                         const [3]: "print"
0221  04                 const type 4
0222  0500000000000000   string size (5)
022A  7479706500         "type\0"
                         const [4]: "type"
022F  04                 const type 4
0230  0500000000000000   string size (5)
0238  6D61696E00         "main\0"
                         const [5]: "main"
023D  04                 const type 4
023E  0800000000000000   string size (8)
0246  72756E6E696E6700   "running\0"
                         const [6]: "running"
024E  04                 const type 4
024F  0700000000000000   string size (7)
0257  73746174757300     "status\0"
                         const [7]: "status"
025E  04                 const type 4
025F  0700000000000000   string size (7)
0267  726573756D6500     "resume\0"
                         const [8]: "resume"
026E  03                 const type 3
026F  000000000000F03F   const [9]: (1)
0277  03                 const type 3
0278  0000000000000040   const [10]: (2)
0280  03                 const type 3
0281  0000000000000840   const [11]: (3)
0289  03                 const type 3
028A  0000000000001040   const [12]: (4)
0292  03                 const type 3
0293  0000000000001440   const [13]: (5)
029B  03                 const type 3
029C  0000000000001840   const [14]: (6)
02A4  03                 const type 3
02A5  0000000000001C40   const [15]: (7)
02AD  03                 const type 3
02AE  0000000000002040   const [16]: (8)
02B6  03                 const type 3
02B7  0000000000002240   const [17]: (9)
                         * functions:
02BF  04000000           sizep (4)
                         
02C3                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
02C3  0000000000000000   string size (0)
                         source name: (none)
02CB  01000000           line defined (1)
02CF  01000000           last line defined (1)
02D3  00                 nups (0)
02D4  00                 numparams (0)
02D5  00                 is_vararg (0)
02D6  02                 maxstacksize (2)
                         * code:
02D7  04000000           sizecode (4)
02DB  05000000           [1] getglobal  0   0        ; R0 := print
02DF  41400000           [2] loadk      1   1        ; R1 := "hello"
02E3  1C400001           [3] call       0   2   1    ;  := R0(R1)
02E7  1E008000           [4] return     0   1        ; return 
                         * constants:
02EB  02000000           sizek (2)
02EF  04                 const type 4
02F0  0600000000000000   string size (6)
02F8  7072696E7400       "print\0"
                         const [0]: "print"
02FE  04                 const type 4
02FF  0600000000000000   string size (6)
0307  68656C6C6F00       "hello\0"
                         const [1]: "hello"
                         * functions:
030D  00000000           sizep (0)
                         * lines:
0311  04000000           sizelineinfo (4)
                         [pc] (line)
0315  01000000           [1] (1)
0319  01000000           [2] (1)
031D  01000000           [3] (1)
0321  01000000           [4] (1)
                         * locals:
0325  00000000           sizelocvars (0)
                         * upvalues:
0329  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
032D                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
032D  0000000000000000   string size (0)
                         source name: (none)
0335  0A000000           line defined (10)
0339  0F000000           last line defined (15)
033D  00                 nups (0)
033E  00                 numparams (0)
033F  00                 is_vararg (0)
0340  03                 maxstacksize (3)
                         * code:
0341  0E000000           sizecode (14)
0345  05000000           [01] getglobal  0   0        ; R0 := print
0349  45400000           [02] getglobal  1   1        ; R1 := coroutine
034D  4680C000           [03] gettable   1   1   258  ; R1 := R1["status"]
0351  85C00000           [04] getglobal  2   3        ; R2 := co
0355  5C000001           [05] call       1   2   0    ; R1 to top := R1(R2)
0359  1C400000           [06] call       0   0   1    ;  := R0(R1 to top)
035D  05400000           [07] getglobal  0   1        ; R0 := coroutine
0361  06004100           [08] gettable   0   0   260  ; R0 := R0["resume"]
0365  45400000           [09] getglobal  1   1        ; R1 := coroutine
0369  4640C100           [10] gettable   1   1   261  ; R1 := R1["create"]
036D  A4000000           [11] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
0371  5C000001           [12] call       1   2   0    ; R1 to top := R1(R2)
0375  1C400000           [13] call       0   0   1    ;  := R0(R1 to top)
0379  1E008000           [14] return     0   1        ; return 
                         * constants:
037D  06000000           sizek (6)
0381  04                 const type 4
0382  0600000000000000   string size (6)
038A  7072696E7400       "print\0"
                         const [0]: "print"
0390  04                 const type 4
0391  0A00000000000000   string size (10)
0399  636F726F7574696E+  "coroutin"
03A1  6500               "e\0"
                         const [1]: "coroutine"
03A3  04                 const type 4
03A4  0700000000000000   string size (7)
03AC  73746174757300     "status\0"
                         const [2]: "status"
03B3  04                 const type 4
03B4  0300000000000000   string size (3)
03BC  636F00             "co\0"
                         const [3]: "co"
03BF  04                 const type 4
03C0  0700000000000000   string size (7)
03C8  726573756D6500     "resume\0"
                         const [4]: "resume"
03CF  04                 const type 4
03D0  0700000000000000   string size (7)
03D8  63726561746500     "create\0"
                         const [5]: "create"
                         * functions:
03DF  01000000           sizep (1)
                         
03E3                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
03E3  0000000000000000   string size (0)
                         source name: (none)
03EB  0C000000           line defined (12)
03EF  0E000000           last line defined (14)
03F3  00                 nups (0)
03F4  00                 numparams (0)
03F5  00                 is_vararg (0)
03F6  03                 maxstacksize (3)
                         * code:
03F7  07000000           sizecode (7)
03FB  05000000           [1] getglobal  0   0        ; R0 := print
03FF  45400000           [2] getglobal  1   1        ; R1 := coroutine
0403  4680C000           [3] gettable   1   1   258  ; R1 := R1["status"]
0407  85C00000           [4] getglobal  2   3        ; R2 := co
040B  5C000001           [5] call       1   2   0    ; R1 to top := R1(R2)
040F  1C400000           [6] call       0   0   1    ;  := R0(R1 to top)
0413  1E008000           [7] return     0   1        ; return 
                         * constants:
0417  04000000           sizek (4)
041B  04                 const type 4
041C  0600000000000000   string size (6)
0424  7072696E7400       "print\0"
                         const [0]: "print"
042A  04                 const type 4
042B  0A00000000000000   string size (10)
0433  636F726F7574696E+  "coroutin"
043B  6500               "e\0"
                         const [1]: "coroutine"
043D  04                 const type 4
043E  0700000000000000   string size (7)
0446  73746174757300     "status\0"
                         const [2]: "status"
044D  04                 const type 4
044E  0300000000000000   string size (3)
0456  636F00             "co\0"
                         const [3]: "co"
                         * functions:
0459  00000000           sizep (0)
                         * lines:
045D  07000000           sizelineinfo (7)
                         [pc] (line)
0461  0D000000           [1] (13)
0465  0D000000           [2] (13)
0469  0D000000           [3] (13)
046D  0D000000           [4] (13)
0471  0D000000           [5] (13)
0475  0D000000           [6] (13)
0479  0E000000           [7] (14)
                         * locals:
047D  00000000           sizelocvars (0)
                         * upvalues:
0481  00000000           sizeupvalues (0)
                         ** end of function 0_1_0 **

                         * lines:
0485  0E000000           sizelineinfo (14)
                         [pc] (line)
0489  0B000000           [01] (11)
048D  0B000000           [02] (11)
0491  0B000000           [03] (11)
0495  0B000000           [04] (11)
0499  0B000000           [05] (11)
049D  0B000000           [06] (11)
04A1  0C000000           [07] (12)
04A5  0C000000           [08] (12)
04A9  0C000000           [09] (12)
04AD  0C000000           [10] (12)
04B1  0E000000           [11] (14)
04B5  0C000000           [12] (12)
04B9  0C000000           [13] (12)
04BD  0F000000           [14] (15)
                         * locals:
04C1  00000000           sizelocvars (0)
                         * upvalues:
04C5  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
04C9                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
04C9  0000000000000000   string size (0)
                         source name: (none)
04D1  15000000           line defined (21)
04D5  1A000000           last line defined (26)
04D9  00                 nups (0)
04DA  03                 numparams (3)
04DB  00                 is_vararg (0)
04DC  07                 maxstacksize (7)
                         * code:
04DD  0C000000           sizecode (12)
04E1  C5000000           [01] getglobal  3   0        ; R3 := print
04E5  00010000           [02] move       4   0        ; R4 := R0
04E9  40018000           [03] move       5   1        ; R5 := R1
04ED  80010001           [04] move       6   2        ; R6 := R2
04F1  DC400002           [05] call       3   4   1    ;  := R3(R4 to R6)
04F5  C5000000           [06] getglobal  3   0        ; R3 := print
04F9  05410000           [07] getglobal  4   1        ; R4 := coroutine
04FD  06814002           [08] gettable   4   4   258  ; R4 := R4["yield"]
0501  1C018000           [09] call       4   1   0    ; R4 to top := R4()
0505  DC400000           [10] call       3   0   1    ;  := R3(R4 to top)
0509  1640FE7F           [11] jmp        -6           ; pc+=-6 (goto [6])
050D  1E008000           [12] return     0   1        ; return 
                         * constants:
0511  03000000           sizek (3)
0515  04                 const type 4
0516  0600000000000000   string size (6)
051E  7072696E7400       "print\0"
                         const [0]: "print"
0524  04                 const type 4
0525  0A00000000000000   string size (10)
052D  636F726F7574696E+  "coroutin"
0535  6500               "e\0"
                         const [1]: "coroutine"
0537  04                 const type 4
0538  0600000000000000   string size (6)
0540  7969656C6400       "yield\0"
                         const [2]: "yield"
                         * functions:
0546  00000000           sizep (0)
                         * lines:
054A  0C000000           sizelineinfo (12)
                         [pc] (line)
054E  16000000           [01] (22)
0552  16000000           [02] (22)
0556  16000000           [03] (22)
055A  16000000           [04] (22)
055E  16000000           [05] (22)
0562  18000000           [06] (24)
0566  18000000           [07] (24)
056A  18000000           [08] (24)
056E  18000000           [09] (24)
0572  18000000           [10] (24)
0576  18000000           [11] (24)
057A  1A000000           [12] (26)
                         * locals:
057E  03000000           sizelocvars (3)
0582  0200000000000000   string size (2)
058A  6100               "a\0"
                         local [0]: a
058C  00000000             startpc (0)
0590  0B000000             endpc   (11)
0594  0200000000000000   string size (2)
059C  6200               "b\0"
                         local [1]: b
059E  00000000             startpc (0)
05A2  0B000000             endpc   (11)
05A6  0200000000000000   string size (2)
05AE  6300               "c\0"
                         local [2]: c
05B0  00000000             startpc (0)
05B4  0B000000             endpc   (11)
                         * upvalues:
05B8  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
05BC                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
05BC  0000000000000000   string size (0)
                         source name: (none)
05C4  20000000           line defined (32)
05C8  25000000           last line defined (37)
05CC  00                 nups (0)
05CD  00                 numparams (0)
05CE  00                 is_vararg (0)
05CF  08                 maxstacksize (8)
                         * code:
05D0  13000000           sizecode (19)
05D4  05000000           [01] getglobal  0   0        ; R0 := pairs
05D8  4A008001           [02] newtable   1   3   0    ; R1 := {} , array=3, hash=0
05DC  81400000           [03] loadk      2   1        ; R2 := "a"
05E0  C1800000           [04] loadk      3   2        ; R3 := "b"
05E4  01C10000           [05] loadk      4   3        ; R4 := "c"
05E8  62408001           [06] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
05EC  1C000101           [07] call       0   2   4    ; R0 to R2 := R0(R1)
05F0  16000180           [08] jmp        5            ; pc+=5 (goto [14])
05F4  45010100           [09] getglobal  5   4        ; R5 := coroutine
05F8  4641C102           [10] gettable   5   5   261  ; R5 := R5["yield"]
05FC  80018001           [11] move       6   3        ; R6 := R3
0600  C0010002           [12] move       7   4        ; R7 := R4
0604  5C418001           [13] call       5   3   1    ;  := R5(R6, R7)
0608  21800000           [14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
060C  1600FE7F           [15] jmp        -7           ; pc+=-7 (goto [9])
0610  01800100           [16] loadk      0   6        ; R0 := "d"
0614  41C00100           [17] loadk      1   7        ; R1 := 4
0618  1E008001           [18] return     0   3        ; return R0, R1
061C  1E008000           [19] return     0   1        ; return 
                         * constants:
0620  08000000           sizek (8)
0624  04                 const type 4
0625  0600000000000000   string size (6)
062D  706169727300       "pairs\0"
                         const [0]: "pairs"
0633  04                 const type 4
0634  0200000000000000   string size (2)
063C  6100               "a\0"
                         const [1]: "a"
063E  04                 const type 4
063F  0200000000000000   string size (2)
0647  6200               "b\0"
                         const [2]: "b"
0649  04                 const type 4
064A  0200000000000000   string size (2)
0652  6300               "c\0"
                         const [3]: "c"
0654  04                 const type 4
0655  0A00000000000000   string size (10)
065D  636F726F7574696E+  "coroutin"
0665  6500               "e\0"
                         const [4]: "coroutine"
0667  04                 const type 4
0668  0600000000000000   string size (6)
0670  7969656C6400       "yield\0"
                         const [5]: "yield"
0676  04                 const type 4
0677  0200000000000000   string size (2)
067F  6400               "d\0"
                         const [6]: "d"
0681  03                 const type 3
0682  0000000000001040   const [7]: (4)
                         * functions:
068A  00000000           sizep (0)
                         * lines:
068E  13000000           sizelineinfo (19)
                         [pc] (line)
0692  21000000           [01] (33)
0696  21000000           [02] (33)
069A  21000000           [03] (33)
069E  21000000           [04] (33)
06A2  21000000           [05] (33)
06A6  21000000           [06] (33)
06AA  21000000           [07] (33)
06AE  21000000           [08] (33)
06B2  22000000           [09] (34)
06B6  22000000           [10] (34)
06BA  22000000           [11] (34)
06BE  22000000           [12] (34)
06C2  22000000           [13] (34)
06C6  21000000           [14] (33)
06CA  22000000           [15] (34)
06CE  24000000           [16] (36)
06D2  24000000           [17] (36)
06D6  24000000           [18] (36)
06DA  25000000           [19] (37)
                         * locals:
06DE  05000000           sizelocvars (5)
06E2  1000000000000000   string size (16)
06EA  28666F722067656E+  "(for gen"
06F2  657261746F722900   "erator)\0"
                         local [0]: (for generator)
06FA  07000000             startpc (7)
06FE  0F000000             endpc   (15)
0702  0C00000000000000   string size (12)
070A  28666F7220737461+  "(for sta"
0712  74652900           "te)\0"
                         local [1]: (for state)
0716  07000000             startpc (7)
071A  0F000000             endpc   (15)
071E  0E00000000000000   string size (14)
0726  28666F7220636F6E+  "(for con"
072E  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0734  07000000             startpc (7)
0738  0F000000             endpc   (15)
073C  0200000000000000   string size (2)
0744  6B00               "k\0"
                         local [3]: k
0746  08000000             startpc (8)
074A  0D000000             endpc   (13)
074E  0200000000000000   string size (2)
0756  7600               "v\0"
                         local [4]: v
0758  08000000             startpc (8)
075C  0D000000             endpc   (13)
                         * upvalues:
0760  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
0764  6C000000           sizelineinfo (108)
                         [pc] (line)
0768  01000000           [001] (1)
076C  01000000           [002] (1)
0770  01000000           [003] (1)
0774  01000000           [004] (1)
0778  01000000           [005] (1)
077C  02000000           [006] (2)
0780  02000000           [007] (2)
0784  02000000           [008] (2)
0788  02000000           [009] (2)
078C  02000000           [010] (2)
0790  05000000           [011] (5)
0794  05000000           [012] (5)
0798  05000000           [013] (5)
079C  05000000           [014] (5)
07A0  06000000           [015] (6)
07A4  06000000           [016] (6)
07A8  06000000           [017] (6)
07AC  06000000           [018] (6)
07B0  06000000           [019] (6)
07B4  07000000           [020] (7)
07B8  07000000           [021] (7)
07BC  07000000           [022] (7)
07C0  07000000           [023] (7)
07C4  07000000           [024] (7)
07C8  07000000           [025] (7)
07CC  0A000000           [026] (10)
07D0  0A000000           [027] (10)
07D4  0F000000           [028] (15)
07D8  0A000000           [029] (10)
07DC  0F000000           [030] (15)
07E0  10000000           [031] (16)
07E4  10000000           [032] (16)
07E8  10000000           [033] (16)
07EC  10000000           [034] (16)
07F0  10000000           [035] (16)
07F4  10000000           [036] (16)
07F8  11000000           [037] (17)
07FC  11000000           [038] (17)
0800  11000000           [039] (17)
0804  11000000           [040] (17)
0808  12000000           [041] (18)
080C  12000000           [042] (18)
0810  12000000           [043] (18)
0814  12000000           [044] (18)
0818  12000000           [045] (18)
081C  12000000           [046] (18)
0820  15000000           [047] (21)
0824  15000000           [048] (21)
0828  1A000000           [049] (26)
082C  15000000           [050] (21)
0830  1A000000           [051] (26)
0834  1B000000           [052] (27)
0838  1B000000           [053] (27)
083C  1B000000           [054] (27)
0840  1B000000           [055] (27)
0844  1B000000           [056] (27)
0848  1B000000           [057] (27)
084C  1B000000           [058] (27)
0850  1C000000           [059] (28)
0854  1C000000           [060] (28)
0858  1C000000           [061] (28)
085C  1C000000           [062] (28)
0860  1C000000           [063] (28)
0864  1C000000           [064] (28)
0868  1C000000           [065] (28)
086C  1D000000           [066] (29)
0870  1D000000           [067] (29)
0874  1D000000           [068] (29)
0878  1D000000           [069] (29)
087C  1D000000           [070] (29)
0880  1D000000           [071] (29)
0884  1D000000           [072] (29)
0888  20000000           [073] (32)
088C  20000000           [074] (32)
0890  25000000           [075] (37)
0894  20000000           [076] (32)
0898  25000000           [077] (37)
089C  26000000           [078] (38)
08A0  26000000           [079] (38)
08A4  26000000           [080] (38)
08A8  26000000           [081] (38)
08AC  26000000           [082] (38)
08B0  26000000           [083] (38)
08B4  27000000           [084] (39)
08B8  27000000           [085] (39)
08BC  27000000           [086] (39)
08C0  27000000           [087] (39)
08C4  27000000           [088] (39)
08C8  27000000           [089] (39)
08CC  28000000           [090] (40)
08D0  28000000           [091] (40)
08D4  28000000           [092] (40)
08D8  28000000           [093] (40)
08DC  28000000           [094] (40)
08E0  28000000           [095] (40)
08E4  29000000           [096] (41)
08E8  29000000           [097] (41)
08EC  29000000           [098] (41)
08F0  29000000           [099] (41)
08F4  29000000           [100] (41)
08F8  29000000           [101] (41)
08FC  2A000000           [102] (42)
0900  2A000000           [103] (42)
0904  2A000000           [104] (42)
0908  2A000000           [105] (42)
090C  2A000000           [106] (42)
0910  2A000000           [107] (42)
0914  2A000000           [108] (42)
                         * locals:
0918  00000000           sizelocvars (0)
                         * upvalues:
091C  00000000           sizeupvalues (0)
                         ** end of function 0 **

0920                     ** end of chunk **
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
002A  05                 maxstacksize (5)
                         * code:
002B  6C000000           sizecode (108)
002F  05400000           [001] getglobal  0   1        ; R0 := coroutine
0033  06804000           [002] gettable   0   0   258  ; R0 := R0["create"]
0037  64000000           [003] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
003B  1C800001           [004] call       0   2   2    ; R0 := R0(R1)
003F  07000000           [005] setglobal  0   0        ; co := R0
0043  05C00000           [006] getglobal  0   3        ; R0 := print
0047  45000100           [007] getglobal  1   4        ; R1 := type
004B  85000000           [008] getglobal  2   0        ; R2 := co
004F  5C000001           [009] call       1   2   0    ; R1 to top := R1(R2)
0053  1C400000           [010] call       0   0   1    ;  := R0(R1 to top)
0057  05400000           [011] getglobal  0   1        ; R0 := coroutine
005B  06804100           [012] gettable   0   0   262  ; R0 := R0["running"]
005F  1C808000           [013] call       0   1   2    ; R0 := R0()
0063  07400100           [014] setglobal  0   5        ; main := R0
0067  05C00000           [015] getglobal  0   3        ; R0 := print
006B  45000100           [016] getglobal  1   4        ; R1 := type
006F  85400100           [017] getglobal  2   5        ; R2 := main
0073  5C000001           [018] call       1   2   0    ; R1 to top := R1(R2)
0077  1C400000           [019] call       0   0   1    ;  := R0(R1 to top)
007B  05C00000           [020] getglobal  0   3        ; R0 := print
007F  45400000           [021] getglobal  1   1        ; R1 := coroutine
0083  46C0C100           [022] gettable   1   1   263  ; R1 := R1["status"]
0087  85400100           [023] getglobal  2   5        ; R2 := main
008B  5C000001           [024] call       1   2   0    ; R1 to top := R1(R2)
008F  1C400000           [025] call       0   0   1    ;  := R0(R1 to top)
0093  05400000           [026] getglobal  0   1        ; R0 := coroutine
0097  06804000           [027] gettable   0   0   258  ; R0 := R0["create"]
009B  64400000           [028] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
009F  1C800001           [029] call       0   2   2    ; R0 := R0(R1)
00A3  07000000           [030] setglobal  0   0        ; co := R0
00A7  05C00000           [031] getglobal  0   3        ; R0 := print
00AB  45400000           [032] getglobal  1   1        ; R1 := coroutine
00AF  46C0C100           [033] gettable   1   1   263  ; R1 := R1["status"]
00B3  85000000           [034] getglobal  2   0        ; R2 := co
00B7  5C000001           [035] call       1   2   0    ; R1 to top := R1(R2)
00BB  1C400000           [036] call       0   0   1    ;  := R0(R1 to top)
00BF  05400000           [037] getglobal  0   1        ; R0 := coroutine
00C3  06004200           [038] gettable   0   0   264  ; R0 := R0["resume"]
00C7  45000000           [039] getglobal  1   0        ; R1 := co
00CB  1C400001           [040] call       0   2   1    ;  := R0(R1)
00CF  05C00000           [041] getglobal  0   3        ; R0 := print
00D3  45400000           [042] getglobal  1   1        ; R1 := coroutine
00D7  46C0C100           [043] gettable   1   1   263  ; R1 := R1["status"]
00DB  85000000           [044] getglobal  2   0        ; R2 := co
00DF  5C000001           [045] call       1   2   0    ; R1 to top := R1(R2)
00E3  1C400000           [046] call       0   0   1    ;  := R0(R1 to top)
00E7  05400000           [047] getglobal  0   1        ; R0 := coroutine
00EB  06804000           [048] gettable   0   0   258  ; R0 := R0["create"]
00EF  64800000           [049] closure    1   2        ; R1 := closure(function[2]) 0 upvalues
00F3  1C800001           [050] call       0   2   2    ; R0 := R0(R1)
00F7  07000000           [051] setglobal  0   0        ; co := R0
00FB  05400000           [052] getglobal  0   1        ; R0 := coroutine
00FF  06004200           [053] gettable   0   0   264  ; R0 := R0["resume"]
0103  45000000           [054] getglobal  1   0        ; R1 := co
0107  81400200           [055] loadk      2   9        ; R2 := 1
010B  C1800200           [056] loadk      3   10       ; R3 := 2
010F  01C10200           [057] loadk      4   11       ; R4 := 3
0113  1C408002           [058] call       0   5   1    ;  := R0(R1 to R4)
0117  05400000           [059] getglobal  0   1        ; R0 := coroutine
011B  06004200           [060] gettable   0   0   264  ; R0 := R0["resume"]
011F  45000000           [061] getglobal  1   0        ; R1 := co
0123  81000300           [062] loadk      2   12       ; R2 := 4
0127  C1400300           [063] loadk      3   13       ; R3 := 5
012B  01810300           [064] loadk      4   14       ; R4 := 6
012F  1C408002           [065] call       0   5   1    ;  := R0(R1 to R4)
0133  05400000           [066] getglobal  0   1        ; R0 := coroutine
0137  06004200           [067] gettable   0   0   264  ; R0 := R0["resume"]
013B  45000000           [068] getglobal  1   0        ; R1 := co
013F  81C00300           [069] loadk      2   15       ; R2 := 7
0143  C1000400           [070] loadk      3   16       ; R3 := 8
0147  01410400           [071] loadk      4   17       ; R4 := 9
014B  1C408002           [072] call       0   5   1    ;  := R0(R1 to R4)
014F  05400000           [073] getglobal  0   1        ; R0 := coroutine
0153  06804000           [074] gettable   0   0   258  ; R0 := R0["create"]
0157  64C00000           [075] closure    1   3        ; R1 := closure(function[3]) 0 upvalues
015B  1C800001           [076] call       0   2   2    ; R0 := R0(R1)
015F  07000000           [077] setglobal  0   0        ; co := R0
0163  05C00000           [078] getglobal  0   3        ; R0 := print
0167  45400000           [079] getglobal  1   1        ; R1 := coroutine
016B  4600C200           [080] gettable   1   1   264  ; R1 := R1["resume"]
016F  85000000           [081] getglobal  2   0        ; R2 := co
0173  5C000001           [082] call       1   2   0    ; R1 to top := R1(R2)
0177  1C400000           [083] call       0   0   1    ;  := R0(R1 to top)
017B  05C00000           [084] getglobal  0   3        ; R0 := print
017F  45400000           [085] getglobal  1   1        ; R1 := coroutine
0183  4600C200           [086] gettable   1   1   264  ; R1 := R1["resume"]
0187  85000000           [087] getglobal  2   0        ; R2 := co
018B  5C000001           [088] call       1   2   0    ; R1 to top := R1(R2)
018F  1C400000           [089] call       0   0   1    ;  := R0(R1 to top)
0193  05C00000           [090] getglobal  0   3        ; R0 := print
0197  45400000           [091] getglobal  1   1        ; R1 := coroutine
019B  4600C200           [092] gettable   1   1   264  ; R1 := R1["resume"]
019F  85000000           [093] getglobal  2   0        ; R2 := co
01A3  5C000001           [094] call       1   2   0    ; R1 to top := R1(R2)
01A7  1C400000           [095] call       0   0   1    ;  := R0(R1 to top)
01AB  05C00000           [096] getglobal  0   3        ; R0 := print
01AF  45400000           [097] getglobal  1   1        ; R1 := coroutine
01B3  4600C200           [098] gettable   1   1   264  ; R1 := R1["resume"]
01B7  85000000           [099] getglobal  2   0        ; R2 := co
01BB  5C000001           [100] call       1   2   0    ; R1 to top := R1(R2)
01BF  1C400000           [101] call       0   0   1    ;  := R0(R1 to top)
01C3  05C00000           [102] getglobal  0   3        ; R0 := print
01C7  45400000           [103] getglobal  1   1        ; R1 := coroutine
01CB  4600C200           [104] gettable   1   1   264  ; R1 := R1["resume"]
01CF  85000000           [105] getglobal  2   0        ; R2 := co
01D3  5C000001           [106] call       1   2   0    ; R1 to top := R1(R2)
01D7  1C400000           [107] call       0   0   1    ;  := R0(R1 to top)
01DB  1E008000           [108] return     0   1        ; return 
                         * constants:
01DF  12000000           sizek (18)
01E3  04                 const type 4
01E4  0300000000000000   string size (3)
01EC  636F00             "co\0"
                         const [0]: "co"
01EF  04                 const type 4
01F0  0A00000000000000   string size (10)
01F8  636F726F7574696E+  "coroutin"
0200  6500               "e\0"
                         const [1]: "coroutine"
0202  04                 const type 4
0203  0700000000000000   string size (7)
020B  63726561746500     "create\0"
                         const [2]: "create"
0212  04                 const type 4
0213  0600000000000000   string size (6)
021B  7072696E7400       "print\0"
                         const [3]: "print"
0221  04                 const type 4
0222  0500000000000000   string size (5)
022A  7479706500         "type\0"
                         const [4]: "type"
022F  04                 const type 4
0230  0500000000000000   string size (5)
0238  6D61696E00         "main\0"
                         const [5]: "main"
023D  04                 const type 4
023E  0800000000000000   string size (8)
0246  72756E6E696E6700   "running\0"
                         const [6]: "running"
024E  04                 const type 4
024F  0700000000000000   string size (7)
0257  73746174757300     "status\0"
                         const [7]: "status"
025E  04                 const type 4
025F  0700000000000000   string size (7)
0267  726573756D6500     "resume\0"
                         const [8]: "resume"
026E  03                 const type 3
026F  000000000000F03F   const [9]: (1)
0277  03                 const type 3
0278  0000000000000040   const [10]: (2)
0280  03                 const type 3
0281  0000000000000840   const [11]: (3)
0289  03                 const type 3
028A  0000000000001040   const [12]: (4)
0292  03                 const type 3
0293  0000000000001440   const [13]: (5)
029B  03                 const type 3
029C  0000000000001840   const [14]: (6)
02A4  03                 const type 3
02A5  0000000000001C40   const [15]: (7)
02AD  03                 const type 3
02AE  0000000000002040   const [16]: (8)
02B6  03                 const type 3
02B7  0000000000002240   const [17]: (9)
                         * functions:
02BF  04000000           sizep (4)
                         
02C3                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
02C3  0000000000000000   string size (0)
                         source name: (none)
02CB  01000000           line defined (1)
02CF  01000000           last line defined (1)
02D3  00                 nups (0)
02D4  00                 numparams (0)
02D5  00                 is_vararg (0)
02D6  02                 maxstacksize (2)
                         * code:
02D7  04000000           sizecode (4)
02DB  05000000           [1] getglobal  0   0        ; R0 := print
02DF  41400000           [2] loadk      1   1        ; R1 := "hello"
02E3  1C400001           [3] call       0   2   1    ;  := R0(R1)
02E7  1E008000           [4] return     0   1        ; return 
                         * constants:
02EB  02000000           sizek (2)
02EF  04                 const type 4
02F0  0600000000000000   string size (6)
02F8  7072696E7400       "print\0"
                         const [0]: "print"
02FE  04                 const type 4
02FF  0600000000000000   string size (6)
0307  68656C6C6F00       "hello\0"
                         const [1]: "hello"
                         * functions:
030D  00000000           sizep (0)
                         * lines:
0311  04000000           sizelineinfo (4)
                         [pc] (line)
0315  01000000           [1] (1)
0319  01000000           [2] (1)
031D  01000000           [3] (1)
0321  01000000           [4] (1)
                         * locals:
0325  00000000           sizelocvars (0)
                         * upvalues:
0329  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
032D                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
032D  0000000000000000   string size (0)
                         source name: (none)
0335  0A000000           line defined (10)
0339  0F000000           last line defined (15)
033D  00                 nups (0)
033E  00                 numparams (0)
033F  00                 is_vararg (0)
0340  03                 maxstacksize (3)
                         * code:
0341  0E000000           sizecode (14)
0345  05000000           [01] getglobal  0   0        ; R0 := print
0349  45400000           [02] getglobal  1   1        ; R1 := coroutine
034D  4680C000           [03] gettable   1   1   258  ; R1 := R1["status"]
0351  85C00000           [04] getglobal  2   3        ; R2 := co
0355  5C000001           [05] call       1   2   0    ; R1 to top := R1(R2)
0359  1C400000           [06] call       0   0   1    ;  := R0(R1 to top)
035D  05400000           [07] getglobal  0   1        ; R0 := coroutine
0361  06004100           [08] gettable   0   0   260  ; R0 := R0["resume"]
0365  45400000           [09] getglobal  1   1        ; R1 := coroutine
0369  4640C100           [10] gettable   1   1   261  ; R1 := R1["create"]
036D  A4000000           [11] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
0371  5C000001           [12] call       1   2   0    ; R1 to top := R1(R2)
0375  1C400000           [13] call       0   0   1    ;  := R0(R1 to top)
0379  1E008000           [14] return     0   1        ; return 
                         * constants:
037D  06000000           sizek (6)
0381  04                 const type 4
0382  0600000000000000   string size (6)
038A  7072696E7400       "print\0"
                         const [0]: "print"
0390  04                 const type 4
0391  0A00000000000000   string size (10)
0399  636F726F7574696E+  "coroutin"
03A1  6500               "e\0"
                         const [1]: "coroutine"
03A3  04                 const type 4
03A4  0700000000000000   string size (7)
03AC  73746174757300     "status\0"
                         const [2]: "status"
03B3  04                 const type 4
03B4  0300000000000000   string size (3)
03BC  636F00             "co\0"
                         const [3]: "co"
03BF  04                 const type 4
03C0  0700000000000000   string size (7)
03C8  726573756D6500     "resume\0"
                         const [4]: "resume"
03CF  04                 const type 4
03D0  0700000000000000   string size (7)
03D8  63726561746500     "create\0"
                         const [5]: "create"
                         * functions:
03DF  01000000           sizep (1)
                         
03E3                     ** function [0] definition (level 3) 0_1_0
                         ** start of function 0_1_0 **
03E3  0000000000000000   string size (0)
                         source name: (none)
03EB  0C000000           line defined (12)
03EF  0E000000           last line defined (14)
03F3  00                 nups (0)
03F4  00                 numparams (0)
03F5  00                 is_vararg (0)
03F6  03                 maxstacksize (3)
                         * code:
03F7  07000000           sizecode (7)
03FB  05000000           [1] getglobal  0   0        ; R0 := print
03FF  45400000           [2] getglobal  1   1        ; R1 := coroutine
0403  4680C000           [3] gettable   1   1   258  ; R1 := R1["status"]
0407  85C00000           [4] getglobal  2   3        ; R2 := co
040B  5C000001           [5] call       1   2   0    ; R1 to top := R1(R2)
040F  1C400000           [6] call       0   0   1    ;  := R0(R1 to top)
0413  1E008000           [7] return     0   1        ; return 
                         * constants:
0417  04000000           sizek (4)
041B  04                 const type 4
041C  0600000000000000   string size (6)
0424  7072696E7400       "print\0"
                         const [0]: "print"
042A  04                 const type 4
042B  0A00000000000000   string size (10)
0433  636F726F7574696E+  "coroutin"
043B  6500               "e\0"
                         const [1]: "coroutine"
043D  04                 const type 4
043E  0700000000000000   string size (7)
0446  73746174757300     "status\0"
                         const [2]: "status"
044D  04                 const type 4
044E  0300000000000000   string size (3)
0456  636F00             "co\0"
                         const [3]: "co"
                         * functions:
0459  00000000           sizep (0)
                         * lines:
045D  07000000           sizelineinfo (7)
                         [pc] (line)
0461  0D000000           [1] (13)
0465  0D000000           [2] (13)
0469  0D000000           [3] (13)
046D  0D000000           [4] (13)
0471  0D000000           [5] (13)
0475  0D000000           [6] (13)
0479  0E000000           [7] (14)
                         * locals:
047D  00000000           sizelocvars (0)
                         * upvalues:
0481  00000000           sizeupvalues (0)
                         ** end of function 0_1_0 **

                         * lines:
0485  0E000000           sizelineinfo (14)
                         [pc] (line)
0489  0B000000           [01] (11)
048D  0B000000           [02] (11)
0491  0B000000           [03] (11)
0495  0B000000           [04] (11)
0499  0B000000           [05] (11)
049D  0B000000           [06] (11)
04A1  0C000000           [07] (12)
04A5  0C000000           [08] (12)
04A9  0C000000           [09] (12)
04AD  0C000000           [10] (12)
04B1  0E000000           [11] (14)
04B5  0C000000           [12] (12)
04B9  0C000000           [13] (12)
04BD  0F000000           [14] (15)
                         * locals:
04C1  00000000           sizelocvars (0)
                         * upvalues:
04C5  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
04C9                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
04C9  0000000000000000   string size (0)
                         source name: (none)
04D1  15000000           line defined (21)
04D5  1A000000           last line defined (26)
04D9  00                 nups (0)
04DA  03                 numparams (3)
04DB  00                 is_vararg (0)
04DC  07                 maxstacksize (7)
                         * code:
04DD  0C000000           sizecode (12)
04E1  C5000000           [01] getglobal  3   0        ; R3 := print
04E5  00010000           [02] move       4   0        ; R4 := R0
04E9  40018000           [03] move       5   1        ; R5 := R1
04ED  80010001           [04] move       6   2        ; R6 := R2
04F1  DC400002           [05] call       3   4   1    ;  := R3(R4 to R6)
04F5  C5000000           [06] getglobal  3   0        ; R3 := print
04F9  05410000           [07] getglobal  4   1        ; R4 := coroutine
04FD  06814002           [08] gettable   4   4   258  ; R4 := R4["yield"]
0501  1C018000           [09] call       4   1   0    ; R4 to top := R4()
0505  DC400000           [10] call       3   0   1    ;  := R3(R4 to top)
0509  1640FE7F           [11] jmp        -6           ; pc+=-6 (goto [6])
050D  1E008000           [12] return     0   1        ; return 
                         * constants:
0511  03000000           sizek (3)
0515  04                 const type 4
0516  0600000000000000   string size (6)
051E  7072696E7400       "print\0"
                         const [0]: "print"
0524  04                 const type 4
0525  0A00000000000000   string size (10)
052D  636F726F7574696E+  "coroutin"
0535  6500               "e\0"
                         const [1]: "coroutine"
0537  04                 const type 4
0538  0600000000000000   string size (6)
0540  7969656C6400       "yield\0"
                         const [2]: "yield"
                         * functions:
0546  00000000           sizep (0)
                         * lines:
054A  0C000000           sizelineinfo (12)
                         [pc] (line)
054E  16000000           [01] (22)
0552  16000000           [02] (22)
0556  16000000           [03] (22)
055A  16000000           [04] (22)
055E  16000000           [05] (22)
0562  18000000           [06] (24)
0566  18000000           [07] (24)
056A  18000000           [08] (24)
056E  18000000           [09] (24)
0572  18000000           [10] (24)
0576  18000000           [11] (24)
057A  1A000000           [12] (26)
                         * locals:
057E  03000000           sizelocvars (3)
0582  0200000000000000   string size (2)
058A  6100               "a\0"
                         local [0]: a
058C  00000000             startpc (0)
0590  0B000000             endpc   (11)
0594  0200000000000000   string size (2)
059C  6200               "b\0"
                         local [1]: b
059E  00000000             startpc (0)
05A2  0B000000             endpc   (11)
05A6  0200000000000000   string size (2)
05AE  6300               "c\0"
                         local [2]: c
05B0  00000000             startpc (0)
05B4  0B000000             endpc   (11)
                         * upvalues:
05B8  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
05BC                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
05BC  0000000000000000   string size (0)
                         source name: (none)
05C4  20000000           line defined (32)
05C8  25000000           last line defined (37)
05CC  00                 nups (0)
05CD  00                 numparams (0)
05CE  00                 is_vararg (0)
05CF  08                 maxstacksize (8)
                         * code:
05D0  13000000           sizecode (19)
05D4  05000000           [01] getglobal  0   0        ; R0 := pairs
05D8  4A008001           [02] newtable   1   3   0    ; R1 := {} , array=3, hash=0
05DC  81400000           [03] loadk      2   1        ; R2 := "a"
05E0  C1800000           [04] loadk      3   2        ; R3 := "b"
05E4  01C10000           [05] loadk      4   3        ; R4 := "c"
05E8  62408001           [06] setlist    1   3   1    ; R1[1 to 3] := R2 to R4
05EC  1C000101           [07] call       0   2   4    ; R0 to R2 := R0(R1)
05F0  16000180           [08] jmp        5            ; pc+=5 (goto [14])
05F4  45010100           [09] getglobal  5   4        ; R5 := coroutine
05F8  4641C102           [10] gettable   5   5   261  ; R5 := R5["yield"]
05FC  80018001           [11] move       6   3        ; R6 := R3
0600  C0010002           [12] move       7   4        ; R7 := R4
0604  5C418001           [13] call       5   3   1    ;  := R5(R6, R7)
0608  21800000           [14] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 16
060C  1600FE7F           [15] jmp        -7           ; pc+=-7 (goto [9])
0610  01800100           [16] loadk      0   6        ; R0 := "d"
0614  41C00100           [17] loadk      1   7        ; R1 := 4
0618  1E008001           [18] return     0   3        ; return R0, R1
061C  1E008000           [19] return     0   1        ; return 
                         * constants:
0620  08000000           sizek (8)
0624  04                 const type 4
0625  0600000000000000   string size (6)
062D  706169727300       "pairs\0"
                         const [0]: "pairs"
0633  04                 const type 4
0634  0200000000000000   string size (2)
063C  6100               "a\0"
                         const [1]: "a"
063E  04                 const type 4
063F  0200000000000000   string size (2)
0647  6200               "b\0"
                         const [2]: "b"
0649  04                 const type 4
064A  0200000000000000   string size (2)
0652  6300               "c\0"
                         const [3]: "c"
0654  04                 const type 4
0655  0A00000000000000   string size (10)
065D  636F726F7574696E+  "coroutin"
0665  6500               "e\0"
                         const [4]: "coroutine"
0667  04                 const type 4
0668  0600000000000000   string size (6)
0670  7969656C6400       "yield\0"
                         const [5]: "yield"
0676  04                 const type 4
0677  0200000000000000   string size (2)
067F  6400               "d\0"
                         const [6]: "d"
0681  03                 const type 3
0682  0000000000001040   const [7]: (4)
                         * functions:
068A  00000000           sizep (0)
                         * lines:
068E  13000000           sizelineinfo (19)
                         [pc] (line)
0692  21000000           [01] (33)
0696  21000000           [02] (33)
069A  21000000           [03] (33)
069E  21000000           [04] (33)
06A2  21000000           [05] (33)
06A6  21000000           [06] (33)
06AA  21000000           [07] (33)
06AE  21000000           [08] (33)
06B2  22000000           [09] (34)
06B6  22000000           [10] (34)
06BA  22000000           [11] (34)
06BE  22000000           [12] (34)
06C2  22000000           [13] (34)
06C6  21000000           [14] (33)
06CA  22000000           [15] (34)
06CE  24000000           [16] (36)
06D2  24000000           [17] (36)
06D6  24000000           [18] (36)
06DA  25000000           [19] (37)
                         * locals:
06DE  05000000           sizelocvars (5)
06E2  1000000000000000   string size (16)
06EA  28666F722067656E+  "(for gen"
06F2  657261746F722900   "erator)\0"
                         local [0]: (for generator)
06FA  07000000             startpc (7)
06FE  0F000000             endpc   (15)
0702  0C00000000000000   string size (12)
070A  28666F7220737461+  "(for sta"
0712  74652900           "te)\0"
                         local [1]: (for state)
0716  07000000             startpc (7)
071A  0F000000             endpc   (15)
071E  0E00000000000000   string size (14)
0726  28666F7220636F6E+  "(for con"
072E  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0734  07000000             startpc (7)
0738  0F000000             endpc   (15)
073C  0200000000000000   string size (2)
0744  6B00               "k\0"
                         local [3]: k
0746  08000000             startpc (8)
074A  0D000000             endpc   (13)
074E  0200000000000000   string size (2)
0756  7600               "v\0"
                         local [4]: v
0758  08000000             startpc (8)
075C  0D000000             endpc   (13)
                         * upvalues:
0760  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
0764  6C000000           sizelineinfo (108)
                         [pc] (line)
0768  01000000           [001] (1)
076C  01000000           [002] (1)
0770  01000000           [003] (1)
0774  01000000           [004] (1)
0778  01000000           [005] (1)
077C  02000000           [006] (2)
0780  02000000           [007] (2)
0784  02000000           [008] (2)
0788  02000000           [009] (2)
078C  02000000           [010] (2)
0790  05000000           [011] (5)
0794  05000000           [012] (5)
0798  05000000           [013] (5)
079C  05000000           [014] (5)
07A0  06000000           [015] (6)
07A4  06000000           [016] (6)
07A8  06000000           [017] (6)
07AC  06000000           [018] (6)
07B0  06000000           [019] (6)
07B4  07000000           [020] (7)
07B8  07000000           [021] (7)
07BC  07000000           [022] (7)
07C0  07000000           [023] (7)
07C4  07000000           [024] (7)
07C8  07000000           [025] (7)
07CC  0A000000           [026] (10)
07D0  0A000000           [027] (10)
07D4  0F000000           [028] (15)
07D8  0A000000           [029] (10)
07DC  0F000000           [030] (15)
07E0  10000000           [031] (16)
07E4  10000000           [032] (16)
07E8  10000000           [033] (16)
07EC  10000000           [034] (16)
07F0  10000000           [035] (16)
07F4  10000000           [036] (16)
07F8  11000000           [037] (17)
07FC  11000000           [038] (17)
0800  11000000           [039] (17)
0804  11000000           [040] (17)
0808  12000000           [041] (18)
080C  12000000           [042] (18)
0810  12000000           [043] (18)
0814  12000000           [044] (18)
0818  12000000           [045] (18)
081C  12000000           [046] (18)
0820  15000000           [047] (21)
0824  15000000           [048] (21)
0828  1A000000           [049] (26)
082C  15000000           [050] (21)
0830  1A000000           [051] (26)
0834  1B000000           [052] (27)
0838  1B000000           [053] (27)
083C  1B000000           [054] (27)
0840  1B000000           [055] (27)
0844  1B000000           [056] (27)
0848  1B000000           [057] (27)
084C  1B000000           [058] (27)
0850  1C000000           [059] (28)
0854  1C000000           [060] (28)
0858  1C000000           [061] (28)
085C  1C000000           [062] (28)
0860  1C000000           [063] (28)
0864  1C000000           [064] (28)
0868  1C000000           [065] (28)
086C  1D000000           [066] (29)
0870  1D000000           [067] (29)
0874  1D000000           [068] (29)
0878  1D000000           [069] (29)
087C  1D000000           [070] (29)
0880  1D000000           [071] (29)
0884  1D000000           [072] (29)
0888  20000000           [073] (32)
088C  20000000           [074] (32)
0890  25000000           [075] (37)
0894  20000000           [076] (32)
0898  25000000           [077] (37)
089C  26000000           [078] (38)
08A0  26000000           [079] (38)
08A4  26000000           [080] (38)
08A8  26000000           [081] (38)
08AC  26000000           [082] (38)
08B0  26000000           [083] (38)
08B4  27000000           [084] (39)
08B8  27000000           [085] (39)
08BC  27000000           [086] (39)
08C0  27000000           [087] (39)
08C4  27000000           [088] (39)
08C8  27000000           [089] (39)
08CC  28000000           [090] (40)
08D0  28000000           [091] (40)
08D4  28000000           [092] (40)
08D8  28000000           [093] (40)
08DC  28000000           [094] (40)
08E0  28000000           [095] (40)
08E4  29000000           [096] (41)
08E8  29000000           [097] (41)
08EC  29000000           [098] (41)
08F0  29000000           [099] (41)
08F4  29000000           [100] (41)
08F8  29000000           [101] (41)
08FC  2A000000           [102] (42)
0900  2A000000           [103] (42)
0904  2A000000           [104] (42)
0908  2A000000           [105] (42)
090C  2A000000           [106] (42)
0910  2A000000           [107] (42)
0914  2A000000           [108] (42)
                         * locals:
0918  00000000           sizelocvars (0)
                         * upvalues:
091C  00000000           sizeupvalues (0)
                         ** end of function 0 **

0920                     ** end of chunk **
