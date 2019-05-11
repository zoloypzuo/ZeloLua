------------------------------
print(math.type(100))          --> integer
print(math.type(3.14))         --> float
print(math.type("100"))        --> nil
print(math.tointeger(100.0))   --> 100
print(math.tointeger("100.0")) --> 100
print(math.tointeger(3.14))    --> nil


t = table.pack(1, 2, 3, 4, 5); print(table.unpack(t)) --> 1 2 3 4 5
table.move(t, 4, 5, 1);        print(table.unpack(t)) --> 4 5 3 4 5
table.insert(t, 3, 2);         print(table.unpack(t)) --> 4 5 2 3 4 5
table.remove(t, 2);            print(table.unpack(t)) --> 4 2 3 4 5
table.sort(t);                 print(table.unpack(t)) --> 2 3 4 4 5
print(table.concat(t, ","))                           --> 2,3,4,4,5


print(string.len("abc"))            --> 3
print(string.rep("a", 3, ","))      --> a,a,a
print(string.reverse("abc"))        --> cba
print(string.lower("ABC"))          --> abc
print(string.upper("abc"))          --> ABC
print(string.sub("abcdefg", 3, 5))  --> cde
print(string.byte("abcdefg", 3, 5)) --> 99 100 101
print(string.char(99, 100, 101))    --> cde

s = "aBc"
print(s:len())       --> 2
print(s:rep(3, ",")) --> aBc,aBc,aBc
print(s:reverse())   --> cBa
print(s:upper())     --> ABC
print(s:lower())     --> abc
print(s:sub(1, 2))   --> aB
print(s:byte(1, 2))  --> 97 66

print(string.len("你好，世界！"))			--> 18
print(utf8.len("你好，世界！"))			--> 6
print(utf8.char(0x4f60, 0x597d))		--> 你好
print("\u{4f60}\u{597d}")				--> 你好
print(utf8.offset("你好，世界！", 2))		--> 4
print(utf8.offset("你好，世界！", 5))		--> 13
print(utf8.codepoint("你好，世界！", 4))	--> 22909
print(utf8.codepoint("你好，世界！", 13))	--> 30028
for p, c in utf8.codes("你好，世界！") do
  print(p, c)
end

print(os.time()) --> 1518320879
print(os.time{year=2018, month=2, day=14,
  hour=12, min=30, sec=30}) --> 1518582630

print(os.date()) --> Sun Feb 11 11:49:28 2018
t = os.date("*t", 1518582630)
print(t.year)  --> 2018
print(t.month) --> 02
print(t.day)   --> 14
print(t.hour)  --> 12
print(t.min)   --> 30
print(t.sec)   --> 30

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "p"  ; 3
.local  "c"  ; 4
.const  "print"  ; 0
.const  "math"  ; 1
.const  "type"  ; 2
.const  100  ; 3
.const  3.14  ; 4
.const  "100"  ; 5
.const  "tointeger"  ; 6
.const  "100.0"  ; 7
.const  "t"  ; 8
.const  "table"  ; 9
.const  "pack"  ; 10
.const  1  ; 11
.const  2  ; 12
.const  3  ; 13
.const  4  ; 14
.const  5  ; 15
.const  "unpack"  ; 16
.const  "move"  ; 17
.const  "insert"  ; 18
.const  "remove"  ; 19
.const  "sort"  ; 20
.const  "concat"  ; 21
.const  ","  ; 22
.const  "string"  ; 23
.const  "len"  ; 24
.const  "abc"  ; 25
.const  "rep"  ; 26
.const  "a"  ; 27
.const  "reverse"  ; 28
.const  "lower"  ; 29
.const  "ABC"  ; 30
.const  "upper"  ; 31
.const  "sub"  ; 32
.const  "abcdefg"  ; 33
.const  "byte"  ; 34
.const  "char"  ; 35
.const  99  ; 36
.const  101  ; 37
.const  "s"  ; 38
.const  "aBc"  ; 39
.const  "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"  ; 40
.const  "utf8"  ; 41
.const  20320  ; 42
.const  22909  ; 43
.const  "u{4f60}u{597d}"  ; 44
.const  "offset"  ; 45
.const  "codepoint"  ; 46
.const  13  ; 47
.const  "codes"  ; 48
.const  "os"  ; 49
.const  "time"  ; 50
.const  "year"  ; 51
.const  2018  ; 52
.const  "month"  ; 53
.const  "day"  ; 54
.const  14  ; 55
.const  "hour"  ; 56
.const  12  ; 57
.const  "min"  ; 58
.const  30  ; 59
.const  "sec"  ; 60
.const  "date"  ; 61
.const  "*t"  ; 62
.const  1518582630  ; 63
[001] getglobal  0   0        ; R0 := print
[002] getglobal  1   1        ; R1 := math
[003] gettable   1   1   258  ; R1 := R1["type"]
[004] loadk      2   3        ; R2 := 100
[005] call       1   2   0    ; R1 to top := R1(R2)
[006] call       0   0   1    ;  := R0(R1 to top)
[007] getglobal  0   0        ; R0 := print
[008] getglobal  1   1        ; R1 := math
[009] gettable   1   1   258  ; R1 := R1["type"]
[010] loadk      2   4        ; R2 := 3.14
[011] call       1   2   0    ; R1 to top := R1(R2)
[012] call       0   0   1    ;  := R0(R1 to top)
[013] getglobal  0   0        ; R0 := print
[014] getglobal  1   1        ; R1 := math
[015] gettable   1   1   258  ; R1 := R1["type"]
[016] loadk      2   5        ; R2 := "100"
[017] call       1   2   0    ; R1 to top := R1(R2)
[018] call       0   0   1    ;  := R0(R1 to top)
[019] getglobal  0   0        ; R0 := print
[020] getglobal  1   1        ; R1 := math
[021] gettable   1   1   262  ; R1 := R1["tointeger"]
[022] loadk      2   3        ; R2 := 100
[023] call       1   2   0    ; R1 to top := R1(R2)
[024] call       0   0   1    ;  := R0(R1 to top)
[025] getglobal  0   0        ; R0 := print
[026] getglobal  1   1        ; R1 := math
[027] gettable   1   1   262  ; R1 := R1["tointeger"]
[028] loadk      2   7        ; R2 := "100.0"
[029] call       1   2   0    ; R1 to top := R1(R2)
[030] call       0   0   1    ;  := R0(R1 to top)
[031] getglobal  0   0        ; R0 := print
[032] getglobal  1   1        ; R1 := math
[033] gettable   1   1   262  ; R1 := R1["tointeger"]
[034] loadk      2   4        ; R2 := 3.14
[035] call       1   2   0    ; R1 to top := R1(R2)
[036] call       0   0   1    ;  := R0(R1 to top)
[037] getglobal  0   9        ; R0 := table
[038] gettable   0   0   266  ; R0 := R0["pack"]
[039] loadk      1   11       ; R1 := 1
[040] loadk      2   12       ; R2 := 2
[041] loadk      3   13       ; R3 := 3
[042] loadk      4   14       ; R4 := 4
[043] loadk      5   15       ; R5 := 5
[044] call       0   6   2    ; R0 := R0(R1 to R5)
[045] setglobal  0   8        ; t := R0
[046] getglobal  0   0        ; R0 := print
[047] getglobal  1   9        ; R1 := table
[048] gettable   1   1   272  ; R1 := R1["unpack"]
[049] getglobal  2   8        ; R2 := t
[050] call       1   2   0    ; R1 to top := R1(R2)
[051] call       0   0   1    ;  := R0(R1 to top)
[052] getglobal  0   9        ; R0 := table
[053] gettable   0   0   273  ; R0 := R0["move"]
[054] getglobal  1   8        ; R1 := t
[055] loadk      2   14       ; R2 := 4
[056] loadk      3   15       ; R3 := 5
[057] loadk      4   11       ; R4 := 1
[058] call       0   5   1    ;  := R0(R1 to R4)
[059] getglobal  0   0        ; R0 := print
[060] getglobal  1   9        ; R1 := table
[061] gettable   1   1   272  ; R1 := R1["unpack"]
[062] getglobal  2   8        ; R2 := t
[063] call       1   2   0    ; R1 to top := R1(R2)
[064] call       0   0   1    ;  := R0(R1 to top)
[065] getglobal  0   9        ; R0 := table
[066] gettable   0   0   274  ; R0 := R0["insert"]
[067] getglobal  1   8        ; R1 := t
[068] loadk      2   13       ; R2 := 3
[069] loadk      3   12       ; R3 := 2
[070] call       0   4   1    ;  := R0(R1 to R3)
[071] getglobal  0   0        ; R0 := print
[072] getglobal  1   9        ; R1 := table
[073] gettable   1   1   272  ; R1 := R1["unpack"]
[074] getglobal  2   8        ; R2 := t
[075] call       1   2   0    ; R1 to top := R1(R2)
[076] call       0   0   1    ;  := R0(R1 to top)
[077] getglobal  0   9        ; R0 := table
[078] gettable   0   0   275  ; R0 := R0["remove"]
[079] getglobal  1   8        ; R1 := t
[080] loadk      2   12       ; R2 := 2
[081] call       0   3   1    ;  := R0(R1, R2)
[082] getglobal  0   0        ; R0 := print
[083] getglobal  1   9        ; R1 := table
[084] gettable   1   1   272  ; R1 := R1["unpack"]
[085] getglobal  2   8        ; R2 := t
[086] call       1   2   0    ; R1 to top := R1(R2)
[087] call       0   0   1    ;  := R0(R1 to top)
[088] getglobal  0   9        ; R0 := table
[089] gettable   0   0   276  ; R0 := R0["sort"]
[090] getglobal  1   8        ; R1 := t
[091] call       0   2   1    ;  := R0(R1)
[092] getglobal  0   0        ; R0 := print
[093] getglobal  1   9        ; R1 := table
[094] gettable   1   1   272  ; R1 := R1["unpack"]
[095] getglobal  2   8        ; R2 := t
[096] call       1   2   0    ; R1 to top := R1(R2)
[097] call       0   0   1    ;  := R0(R1 to top)
[098] getglobal  0   0        ; R0 := print
[099] getglobal  1   9        ; R1 := table
[100] gettable   1   1   277  ; R1 := R1["concat"]
[101] getglobal  2   8        ; R2 := t
[102] loadk      3   22       ; R3 := ","
[103] call       1   3   0    ; R1 to top := R1(R2, R3)
[104] call       0   0   1    ;  := R0(R1 to top)
[105] getglobal  0   0        ; R0 := print
[106] getglobal  1   23       ; R1 := string
[107] gettable   1   1   280  ; R1 := R1["len"]
[108] loadk      2   25       ; R2 := "abc"
[109] call       1   2   0    ; R1 to top := R1(R2)
[110] call       0   0   1    ;  := R0(R1 to top)
[111] getglobal  0   0        ; R0 := print
[112] getglobal  1   23       ; R1 := string
[113] gettable   1   1   282  ; R1 := R1["rep"]
[114] loadk      2   27       ; R2 := "a"
[115] loadk      3   13       ; R3 := 3
[116] loadk      4   22       ; R4 := ","
[117] call       1   4   0    ; R1 to top := R1(R2 to R4)
[118] call       0   0   1    ;  := R0(R1 to top)
[119] getglobal  0   0        ; R0 := print
[120] getglobal  1   23       ; R1 := string
[121] gettable   1   1   284  ; R1 := R1["reverse"]
[122] loadk      2   25       ; R2 := "abc"
[123] call       1   2   0    ; R1 to top := R1(R2)
[124] call       0   0   1    ;  := R0(R1 to top)
[125] getglobal  0   0        ; R0 := print
[126] getglobal  1   23       ; R1 := string
[127] gettable   1   1   285  ; R1 := R1["lower"]
[128] loadk      2   30       ; R2 := "ABC"
[129] call       1   2   0    ; R1 to top := R1(R2)
[130] call       0   0   1    ;  := R0(R1 to top)
[131] getglobal  0   0        ; R0 := print
[132] getglobal  1   23       ; R1 := string
[133] gettable   1   1   287  ; R1 := R1["upper"]
[134] loadk      2   25       ; R2 := "abc"
[135] call       1   2   0    ; R1 to top := R1(R2)
[136] call       0   0   1    ;  := R0(R1 to top)
[137] getglobal  0   0        ; R0 := print
[138] getglobal  1   23       ; R1 := string
[139] gettable   1   1   288  ; R1 := R1["sub"]
[140] loadk      2   33       ; R2 := "abcdefg"
[141] loadk      3   13       ; R3 := 3
[142] loadk      4   15       ; R4 := 5
[143] call       1   4   0    ; R1 to top := R1(R2 to R4)
[144] call       0   0   1    ;  := R0(R1 to top)
[145] getglobal  0   0        ; R0 := print
[146] getglobal  1   23       ; R1 := string
[147] gettable   1   1   290  ; R1 := R1["byte"]
[148] loadk      2   33       ; R2 := "abcdefg"
[149] loadk      3   13       ; R3 := 3
[150] loadk      4   15       ; R4 := 5
[151] call       1   4   0    ; R1 to top := R1(R2 to R4)
[152] call       0   0   1    ;  := R0(R1 to top)
[153] getglobal  0   0        ; R0 := print
[154] getglobal  1   23       ; R1 := string
[155] gettable   1   1   291  ; R1 := R1["char"]
[156] loadk      2   36       ; R2 := 99
[157] loadk      3   3        ; R3 := 100
[158] loadk      4   37       ; R4 := 101
[159] call       1   4   0    ; R1 to top := R1(R2 to R4)
[160] call       0   0   1    ;  := R0(R1 to top)
[161] loadk      0   39       ; R0 := "aBc"
[162] setglobal  0   38       ; s := R0
[163] getglobal  0   0        ; R0 := print
[164] getglobal  1   38       ; R1 := s
[165] self       1   1   280  ; R2 := R1; R1 := R1["len"]
[166] call       1   2   0    ; R1 to top := R1(R2)
[167] call       0   0   1    ;  := R0(R1 to top)
[168] getglobal  0   0        ; R0 := print
[169] getglobal  1   38       ; R1 := s
[170] self       1   1   282  ; R2 := R1; R1 := R1["rep"]
[171] loadk      3   13       ; R3 := 3
[172] loadk      4   22       ; R4 := ","
[173] call       1   4   0    ; R1 to top := R1(R2 to R4)
[174] call       0   0   1    ;  := R0(R1 to top)
[175] getglobal  0   0        ; R0 := print
[176] getglobal  1   38       ; R1 := s
[177] self       1   1   284  ; R2 := R1; R1 := R1["reverse"]
[178] call       1   2   0    ; R1 to top := R1(R2)
[179] call       0   0   1    ;  := R0(R1 to top)
[180] getglobal  0   0        ; R0 := print
[181] getglobal  1   38       ; R1 := s
[182] self       1   1   287  ; R2 := R1; R1 := R1["upper"]
[183] call       1   2   0    ; R1 to top := R1(R2)
[184] call       0   0   1    ;  := R0(R1 to top)
[185] getglobal  0   0        ; R0 := print
[186] getglobal  1   38       ; R1 := s
[187] self       1   1   285  ; R2 := R1; R1 := R1["lower"]
[188] call       1   2   0    ; R1 to top := R1(R2)
[189] call       0   0   1    ;  := R0(R1 to top)
[190] getglobal  0   0        ; R0 := print
[191] getglobal  1   38       ; R1 := s
[192] self       1   1   288  ; R2 := R1; R1 := R1["sub"]
[193] loadk      3   11       ; R3 := 1
[194] loadk      4   12       ; R4 := 2
[195] call       1   4   0    ; R1 to top := R1(R2 to R4)
[196] call       0   0   1    ;  := R0(R1 to top)
[197] getglobal  0   0        ; R0 := print
[198] getglobal  1   38       ; R1 := s
[199] self       1   1   290  ; R2 := R1; R1 := R1["byte"]
[200] loadk      3   11       ; R3 := 1
[201] loadk      4   12       ; R4 := 2
[202] call       1   4   0    ; R1 to top := R1(R2 to R4)
[203] call       0   0   1    ;  := R0(R1 to top)
[204] getglobal  0   0        ; R0 := print
[205] getglobal  1   23       ; R1 := string
[206] gettable   1   1   280  ; R1 := R1["len"]
[207] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[208] call       1   2   0    ; R1 to top := R1(R2)
[209] call       0   0   1    ;  := R0(R1 to top)
[210] getglobal  0   0        ; R0 := print
[211] getglobal  1   41       ; R1 := utf8
[212] gettable   1   1   280  ; R1 := R1["len"]
[213] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[214] call       1   2   0    ; R1 to top := R1(R2)
[215] call       0   0   1    ;  := R0(R1 to top)
[216] getglobal  0   0        ; R0 := print
[217] getglobal  1   41       ; R1 := utf8
[218] gettable   1   1   291  ; R1 := R1["char"]
[219] loadk      2   42       ; R2 := 20320
[220] loadk      3   43       ; R3 := 22909
[221] call       1   3   0    ; R1 to top := R1(R2, R3)
[222] call       0   0   1    ;  := R0(R1 to top)
[223] getglobal  0   0        ; R0 := print
[224] loadk      1   44       ; R1 := "u{4f60}u{597d}"
[225] call       0   2   1    ;  := R0(R1)
[226] getglobal  0   0        ; R0 := print
[227] getglobal  1   41       ; R1 := utf8
[228] gettable   1   1   301  ; R1 := R1["offset"]
[229] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[230] loadk      3   12       ; R3 := 2
[231] call       1   3   0    ; R1 to top := R1(R2, R3)
[232] call       0   0   1    ;  := R0(R1 to top)
[233] getglobal  0   0        ; R0 := print
[234] getglobal  1   41       ; R1 := utf8
[235] gettable   1   1   301  ; R1 := R1["offset"]
[236] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[237] loadk      3   15       ; R3 := 5
[238] call       1   3   0    ; R1 to top := R1(R2, R3)
[239] call       0   0   1    ;  := R0(R1 to top)
[240] getglobal  0   0        ; R0 := print
[241] getglobal  1   41       ; R1 := utf8
[242] gettable   1   1   302  ; R1 := R1["codepoint"]
[243] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[244] loadk      3   14       ; R3 := 4
[245] call       1   3   0    ; R1 to top := R1(R2, R3)
[246] call       0   0   1    ;  := R0(R1 to top)
[247] getglobal  0   0        ; R0 := print
[248] getglobal  1   41       ; R1 := utf8
[249] gettable   1   1   302  ; R1 := R1["codepoint"]
[250] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[251] loadk      3   47       ; R3 := 13
[252] call       1   3   0    ; R1 to top := R1(R2, R3)
[253] call       0   0   1    ;  := R0(R1 to top)
[254] getglobal  0   41       ; R0 := utf8
[255] gettable   0   0   304  ; R0 := R0["codes"]
[256] loadk      1   40       ; R1 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[257] call       0   2   4    ; R0 to R2 := R0(R1)
[258] jmp        4            ; pc+=4 (goto [263])
[259] getglobal  5   0        ; R5 := print
[260] move       6   3        ; R6 := R3
[261] move       7   4        ; R7 := R4
[262] call       5   3   1    ;  := R5(R6, R7)
[263] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 265
[264] jmp        -6           ; pc+=-6 (goto [259])
[265] getglobal  0   0        ; R0 := print
[266] getglobal  1   49       ; R1 := os
[267] gettable   1   1   306  ; R1 := R1["time"]
[268] call       1   1   0    ; R1 to top := R1()
[269] call       0   0   1    ;  := R0(R1 to top)
[270] getglobal  0   0        ; R0 := print
[271] getglobal  1   49       ; R1 := os
[272] gettable   1   1   306  ; R1 := R1["time"]
[273] newtable   2   0   6    ; R2 := {} , array=0, hash=6
[274] settable   2   307 308  ; R2["year"] := 2018
[275] settable   2   309 268  ; R2["month"] := 2
[276] settable   2   310 311  ; R2["day"] := 14
[277] settable   2   312 313  ; R2["hour"] := 12
[278] settable   2   314 315  ; R2["min"] := 30
[279] settable   2   316 315  ; R2["sec"] := 30
[280] call       1   2   0    ; R1 to top := R1(R2)
[281] call       0   0   1    ;  := R0(R1 to top)
[282] getglobal  0   0        ; R0 := print
[283] getglobal  1   49       ; R1 := os
[284] gettable   1   1   317  ; R1 := R1["date"]
[285] call       1   1   0    ; R1 to top := R1()
[286] call       0   0   1    ;  := R0(R1 to top)
[287] getglobal  0   49       ; R0 := os
[288] gettable   0   0   317  ; R0 := R0["date"]
[289] loadk      1   62       ; R1 := "*t"
[290] loadk      2   63       ; R2 := 1518582630
[291] call       0   3   2    ; R0 := R0(R1, R2)
[292] setglobal  0   8        ; t := R0
[293] getglobal  0   0        ; R0 := print
[294] getglobal  1   8        ; R1 := t
[295] gettable   1   1   307  ; R1 := R1["year"]
[296] call       0   2   1    ;  := R0(R1)
[297] getglobal  0   0        ; R0 := print
[298] getglobal  1   8        ; R1 := t
[299] gettable   1   1   309  ; R1 := R1["month"]
[300] call       0   2   1    ;  := R0(R1)
[301] getglobal  0   0        ; R0 := print
[302] getglobal  1   8        ; R1 := t
[303] gettable   1   1   310  ; R1 := R1["day"]
[304] call       0   2   1    ;  := R0(R1)
[305] getglobal  0   0        ; R0 := print
[306] getglobal  1   8        ; R1 := t
[307] gettable   1   1   312  ; R1 := R1["hour"]
[308] call       0   2   1    ;  := R0(R1)
[309] getglobal  0   0        ; R0 := print
[310] getglobal  1   8        ; R1 := t
[311] gettable   1   1   314  ; R1 := R1["min"]
[312] call       0   2   1    ;  := R0(R1)
[313] getglobal  0   0        ; R0 := print
[314] getglobal  1   8        ; R1 := t
[315] gettable   1   1   316  ; R1 := R1["sec"]
[316] call       0   2   1    ;  := R0(R1)
[317] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 8 stacks
.function  0 0 2 8
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "p"  ; 3
.local  "c"  ; 4
.const  "print"  ; 0
.const  "math"  ; 1
.const  "type"  ; 2
.const  100  ; 3
.const  3.14  ; 4
.const  "100"  ; 5
.const  "tointeger"  ; 6
.const  "100.0"  ; 7
.const  "t"  ; 8
.const  "table"  ; 9
.const  "pack"  ; 10
.const  1  ; 11
.const  2  ; 12
.const  3  ; 13
.const  4  ; 14
.const  5  ; 15
.const  "unpack"  ; 16
.const  "move"  ; 17
.const  "insert"  ; 18
.const  "remove"  ; 19
.const  "sort"  ; 20
.const  "concat"  ; 21
.const  ","  ; 22
.const  "string"  ; 23
.const  "len"  ; 24
.const  "abc"  ; 25
.const  "rep"  ; 26
.const  "a"  ; 27
.const  "reverse"  ; 28
.const  "lower"  ; 29
.const  "ABC"  ; 30
.const  "upper"  ; 31
.const  "sub"  ; 32
.const  "abcdefg"  ; 33
.const  "byte"  ; 34
.const  "char"  ; 35
.const  99  ; 36
.const  101  ; 37
.const  "s"  ; 38
.const  "aBc"  ; 39
.const  "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"  ; 40
.const  "utf8"  ; 41
.const  20320  ; 42
.const  22909  ; 43
.const  "u{4f60}u{597d}"  ; 44
.const  "offset"  ; 45
.const  "codepoint"  ; 46
.const  13  ; 47
.const  "codes"  ; 48
.const  "os"  ; 49
.const  "time"  ; 50
.const  "year"  ; 51
.const  2018  ; 52
.const  "month"  ; 53
.const  "day"  ; 54
.const  14  ; 55
.const  "hour"  ; 56
.const  12  ; 57
.const  "min"  ; 58
.const  30  ; 59
.const  "sec"  ; 60
.const  "date"  ; 61
.const  "*t"  ; 62
.const  1518582630  ; 63
[001] getglobal  0   0        ; R0 := print
[002] getglobal  1   1        ; R1 := math
[003] gettable   1   1   258  ; R1 := R1["type"]
[004] loadk      2   3        ; R2 := 100
[005] call       1   2   0    ; R1 to top := R1(R2)
[006] call       0   0   1    ;  := R0(R1 to top)
[007] getglobal  0   0        ; R0 := print
[008] getglobal  1   1        ; R1 := math
[009] gettable   1   1   258  ; R1 := R1["type"]
[010] loadk      2   4        ; R2 := 3.14
[011] call       1   2   0    ; R1 to top := R1(R2)
[012] call       0   0   1    ;  := R0(R1 to top)
[013] getglobal  0   0        ; R0 := print
[014] getglobal  1   1        ; R1 := math
[015] gettable   1   1   258  ; R1 := R1["type"]
[016] loadk      2   5        ; R2 := "100"
[017] call       1   2   0    ; R1 to top := R1(R2)
[018] call       0   0   1    ;  := R0(R1 to top)
[019] getglobal  0   0        ; R0 := print
[020] getglobal  1   1        ; R1 := math
[021] gettable   1   1   262  ; R1 := R1["tointeger"]
[022] loadk      2   3        ; R2 := 100
[023] call       1   2   0    ; R1 to top := R1(R2)
[024] call       0   0   1    ;  := R0(R1 to top)
[025] getglobal  0   0        ; R0 := print
[026] getglobal  1   1        ; R1 := math
[027] gettable   1   1   262  ; R1 := R1["tointeger"]
[028] loadk      2   7        ; R2 := "100.0"
[029] call       1   2   0    ; R1 to top := R1(R2)
[030] call       0   0   1    ;  := R0(R1 to top)
[031] getglobal  0   0        ; R0 := print
[032] getglobal  1   1        ; R1 := math
[033] gettable   1   1   262  ; R1 := R1["tointeger"]
[034] loadk      2   4        ; R2 := 3.14
[035] call       1   2   0    ; R1 to top := R1(R2)
[036] call       0   0   1    ;  := R0(R1 to top)
[037] getglobal  0   9        ; R0 := table
[038] gettable   0   0   266  ; R0 := R0["pack"]
[039] loadk      1   11       ; R1 := 1
[040] loadk      2   12       ; R2 := 2
[041] loadk      3   13       ; R3 := 3
[042] loadk      4   14       ; R4 := 4
[043] loadk      5   15       ; R5 := 5
[044] call       0   6   2    ; R0 := R0(R1 to R5)
[045] setglobal  0   8        ; t := R0
[046] getglobal  0   0        ; R0 := print
[047] getglobal  1   9        ; R1 := table
[048] gettable   1   1   272  ; R1 := R1["unpack"]
[049] getglobal  2   8        ; R2 := t
[050] call       1   2   0    ; R1 to top := R1(R2)
[051] call       0   0   1    ;  := R0(R1 to top)
[052] getglobal  0   9        ; R0 := table
[053] gettable   0   0   273  ; R0 := R0["move"]
[054] getglobal  1   8        ; R1 := t
[055] loadk      2   14       ; R2 := 4
[056] loadk      3   15       ; R3 := 5
[057] loadk      4   11       ; R4 := 1
[058] call       0   5   1    ;  := R0(R1 to R4)
[059] getglobal  0   0        ; R0 := print
[060] getglobal  1   9        ; R1 := table
[061] gettable   1   1   272  ; R1 := R1["unpack"]
[062] getglobal  2   8        ; R2 := t
[063] call       1   2   0    ; R1 to top := R1(R2)
[064] call       0   0   1    ;  := R0(R1 to top)
[065] getglobal  0   9        ; R0 := table
[066] gettable   0   0   274  ; R0 := R0["insert"]
[067] getglobal  1   8        ; R1 := t
[068] loadk      2   13       ; R2 := 3
[069] loadk      3   12       ; R3 := 2
[070] call       0   4   1    ;  := R0(R1 to R3)
[071] getglobal  0   0        ; R0 := print
[072] getglobal  1   9        ; R1 := table
[073] gettable   1   1   272  ; R1 := R1["unpack"]
[074] getglobal  2   8        ; R2 := t
[075] call       1   2   0    ; R1 to top := R1(R2)
[076] call       0   0   1    ;  := R0(R1 to top)
[077] getglobal  0   9        ; R0 := table
[078] gettable   0   0   275  ; R0 := R0["remove"]
[079] getglobal  1   8        ; R1 := t
[080] loadk      2   12       ; R2 := 2
[081] call       0   3   1    ;  := R0(R1, R2)
[082] getglobal  0   0        ; R0 := print
[083] getglobal  1   9        ; R1 := table
[084] gettable   1   1   272  ; R1 := R1["unpack"]
[085] getglobal  2   8        ; R2 := t
[086] call       1   2   0    ; R1 to top := R1(R2)
[087] call       0   0   1    ;  := R0(R1 to top)
[088] getglobal  0   9        ; R0 := table
[089] gettable   0   0   276  ; R0 := R0["sort"]
[090] getglobal  1   8        ; R1 := t
[091] call       0   2   1    ;  := R0(R1)
[092] getglobal  0   0        ; R0 := print
[093] getglobal  1   9        ; R1 := table
[094] gettable   1   1   272  ; R1 := R1["unpack"]
[095] getglobal  2   8        ; R2 := t
[096] call       1   2   0    ; R1 to top := R1(R2)
[097] call       0   0   1    ;  := R0(R1 to top)
[098] getglobal  0   0        ; R0 := print
[099] getglobal  1   9        ; R1 := table
[100] gettable   1   1   277  ; R1 := R1["concat"]
[101] getglobal  2   8        ; R2 := t
[102] loadk      3   22       ; R3 := ","
[103] call       1   3   0    ; R1 to top := R1(R2, R3)
[104] call       0   0   1    ;  := R0(R1 to top)
[105] getglobal  0   0        ; R0 := print
[106] getglobal  1   23       ; R1 := string
[107] gettable   1   1   280  ; R1 := R1["len"]
[108] loadk      2   25       ; R2 := "abc"
[109] call       1   2   0    ; R1 to top := R1(R2)
[110] call       0   0   1    ;  := R0(R1 to top)
[111] getglobal  0   0        ; R0 := print
[112] getglobal  1   23       ; R1 := string
[113] gettable   1   1   282  ; R1 := R1["rep"]
[114] loadk      2   27       ; R2 := "a"
[115] loadk      3   13       ; R3 := 3
[116] loadk      4   22       ; R4 := ","
[117] call       1   4   0    ; R1 to top := R1(R2 to R4)
[118] call       0   0   1    ;  := R0(R1 to top)
[119] getglobal  0   0        ; R0 := print
[120] getglobal  1   23       ; R1 := string
[121] gettable   1   1   284  ; R1 := R1["reverse"]
[122] loadk      2   25       ; R2 := "abc"
[123] call       1   2   0    ; R1 to top := R1(R2)
[124] call       0   0   1    ;  := R0(R1 to top)
[125] getglobal  0   0        ; R0 := print
[126] getglobal  1   23       ; R1 := string
[127] gettable   1   1   285  ; R1 := R1["lower"]
[128] loadk      2   30       ; R2 := "ABC"
[129] call       1   2   0    ; R1 to top := R1(R2)
[130] call       0   0   1    ;  := R0(R1 to top)
[131] getglobal  0   0        ; R0 := print
[132] getglobal  1   23       ; R1 := string
[133] gettable   1   1   287  ; R1 := R1["upper"]
[134] loadk      2   25       ; R2 := "abc"
[135] call       1   2   0    ; R1 to top := R1(R2)
[136] call       0   0   1    ;  := R0(R1 to top)
[137] getglobal  0   0        ; R0 := print
[138] getglobal  1   23       ; R1 := string
[139] gettable   1   1   288  ; R1 := R1["sub"]
[140] loadk      2   33       ; R2 := "abcdefg"
[141] loadk      3   13       ; R3 := 3
[142] loadk      4   15       ; R4 := 5
[143] call       1   4   0    ; R1 to top := R1(R2 to R4)
[144] call       0   0   1    ;  := R0(R1 to top)
[145] getglobal  0   0        ; R0 := print
[146] getglobal  1   23       ; R1 := string
[147] gettable   1   1   290  ; R1 := R1["byte"]
[148] loadk      2   33       ; R2 := "abcdefg"
[149] loadk      3   13       ; R3 := 3
[150] loadk      4   15       ; R4 := 5
[151] call       1   4   0    ; R1 to top := R1(R2 to R4)
[152] call       0   0   1    ;  := R0(R1 to top)
[153] getglobal  0   0        ; R0 := print
[154] getglobal  1   23       ; R1 := string
[155] gettable   1   1   291  ; R1 := R1["char"]
[156] loadk      2   36       ; R2 := 99
[157] loadk      3   3        ; R3 := 100
[158] loadk      4   37       ; R4 := 101
[159] call       1   4   0    ; R1 to top := R1(R2 to R4)
[160] call       0   0   1    ;  := R0(R1 to top)
[161] loadk      0   39       ; R0 := "aBc"
[162] setglobal  0   38       ; s := R0
[163] getglobal  0   0        ; R0 := print
[164] getglobal  1   38       ; R1 := s
[165] self       1   1   280  ; R2 := R1; R1 := R1["len"]
[166] call       1   2   0    ; R1 to top := R1(R2)
[167] call       0   0   1    ;  := R0(R1 to top)
[168] getglobal  0   0        ; R0 := print
[169] getglobal  1   38       ; R1 := s
[170] self       1   1   282  ; R2 := R1; R1 := R1["rep"]
[171] loadk      3   13       ; R3 := 3
[172] loadk      4   22       ; R4 := ","
[173] call       1   4   0    ; R1 to top := R1(R2 to R4)
[174] call       0   0   1    ;  := R0(R1 to top)
[175] getglobal  0   0        ; R0 := print
[176] getglobal  1   38       ; R1 := s
[177] self       1   1   284  ; R2 := R1; R1 := R1["reverse"]
[178] call       1   2   0    ; R1 to top := R1(R2)
[179] call       0   0   1    ;  := R0(R1 to top)
[180] getglobal  0   0        ; R0 := print
[181] getglobal  1   38       ; R1 := s
[182] self       1   1   287  ; R2 := R1; R1 := R1["upper"]
[183] call       1   2   0    ; R1 to top := R1(R2)
[184] call       0   0   1    ;  := R0(R1 to top)
[185] getglobal  0   0        ; R0 := print
[186] getglobal  1   38       ; R1 := s
[187] self       1   1   285  ; R2 := R1; R1 := R1["lower"]
[188] call       1   2   0    ; R1 to top := R1(R2)
[189] call       0   0   1    ;  := R0(R1 to top)
[190] getglobal  0   0        ; R0 := print
[191] getglobal  1   38       ; R1 := s
[192] self       1   1   288  ; R2 := R1; R1 := R1["sub"]
[193] loadk      3   11       ; R3 := 1
[194] loadk      4   12       ; R4 := 2
[195] call       1   4   0    ; R1 to top := R1(R2 to R4)
[196] call       0   0   1    ;  := R0(R1 to top)
[197] getglobal  0   0        ; R0 := print
[198] getglobal  1   38       ; R1 := s
[199] self       1   1   290  ; R2 := R1; R1 := R1["byte"]
[200] loadk      3   11       ; R3 := 1
[201] loadk      4   12       ; R4 := 2
[202] call       1   4   0    ; R1 to top := R1(R2 to R4)
[203] call       0   0   1    ;  := R0(R1 to top)
[204] getglobal  0   0        ; R0 := print
[205] getglobal  1   23       ; R1 := string
[206] gettable   1   1   280  ; R1 := R1["len"]
[207] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[208] call       1   2   0    ; R1 to top := R1(R2)
[209] call       0   0   1    ;  := R0(R1 to top)
[210] getglobal  0   0        ; R0 := print
[211] getglobal  1   41       ; R1 := utf8
[212] gettable   1   1   280  ; R1 := R1["len"]
[213] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[214] call       1   2   0    ; R1 to top := R1(R2)
[215] call       0   0   1    ;  := R0(R1 to top)
[216] getglobal  0   0        ; R0 := print
[217] getglobal  1   41       ; R1 := utf8
[218] gettable   1   1   291  ; R1 := R1["char"]
[219] loadk      2   42       ; R2 := 20320
[220] loadk      3   43       ; R3 := 22909
[221] call       1   3   0    ; R1 to top := R1(R2, R3)
[222] call       0   0   1    ;  := R0(R1 to top)
[223] getglobal  0   0        ; R0 := print
[224] loadk      1   44       ; R1 := "u{4f60}u{597d}"
[225] call       0   2   1    ;  := R0(R1)
[226] getglobal  0   0        ; R0 := print
[227] getglobal  1   41       ; R1 := utf8
[228] gettable   1   1   301  ; R1 := R1["offset"]
[229] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[230] loadk      3   12       ; R3 := 2
[231] call       1   3   0    ; R1 to top := R1(R2, R3)
[232] call       0   0   1    ;  := R0(R1 to top)
[233] getglobal  0   0        ; R0 := print
[234] getglobal  1   41       ; R1 := utf8
[235] gettable   1   1   301  ; R1 := R1["offset"]
[236] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[237] loadk      3   15       ; R3 := 5
[238] call       1   3   0    ; R1 to top := R1(R2, R3)
[239] call       0   0   1    ;  := R0(R1 to top)
[240] getglobal  0   0        ; R0 := print
[241] getglobal  1   41       ; R1 := utf8
[242] gettable   1   1   302  ; R1 := R1["codepoint"]
[243] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[244] loadk      3   14       ; R3 := 4
[245] call       1   3   0    ; R1 to top := R1(R2, R3)
[246] call       0   0   1    ;  := R0(R1 to top)
[247] getglobal  0   0        ; R0 := print
[248] getglobal  1   41       ; R1 := utf8
[249] gettable   1   1   302  ; R1 := R1["codepoint"]
[250] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[251] loadk      3   47       ; R3 := 13
[252] call       1   3   0    ; R1 to top := R1(R2, R3)
[253] call       0   0   1    ;  := R0(R1 to top)
[254] getglobal  0   41       ; R0 := utf8
[255] gettable   0   0   304  ; R0 := R0["codes"]
[256] loadk      1   40       ; R1 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
[257] call       0   2   4    ; R0 to R2 := R0(R1)
[258] jmp        4            ; pc+=4 (goto [263])
[259] getglobal  5   0        ; R5 := print
[260] move       6   3        ; R6 := R3
[261] move       7   4        ; R7 := R4
[262] call       5   3   1    ;  := R5(R6, R7)
[263] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 265
[264] jmp        -6           ; pc+=-6 (goto [259])
[265] getglobal  0   0        ; R0 := print
[266] getglobal  1   49       ; R1 := os
[267] gettable   1   1   306  ; R1 := R1["time"]
[268] call       1   1   0    ; R1 to top := R1()
[269] call       0   0   1    ;  := R0(R1 to top)
[270] getglobal  0   0        ; R0 := print
[271] getglobal  1   49       ; R1 := os
[272] gettable   1   1   306  ; R1 := R1["time"]
[273] newtable   2   0   6    ; R2 := {} , array=0, hash=6
[274] settable   2   307 308  ; R2["year"] := 2018
[275] settable   2   309 268  ; R2["month"] := 2
[276] settable   2   310 311  ; R2["day"] := 14
[277] settable   2   312 313  ; R2["hour"] := 12
[278] settable   2   314 315  ; R2["min"] := 30
[279] settable   2   316 315  ; R2["sec"] := 30
[280] call       1   2   0    ; R1 to top := R1(R2)
[281] call       0   0   1    ;  := R0(R1 to top)
[282] getglobal  0   0        ; R0 := print
[283] getglobal  1   49       ; R1 := os
[284] gettable   1   1   317  ; R1 := R1["date"]
[285] call       1   1   0    ; R1 to top := R1()
[286] call       0   0   1    ;  := R0(R1 to top)
[287] getglobal  0   49       ; R0 := os
[288] gettable   0   0   317  ; R0 := R0["date"]
[289] loadk      1   62       ; R1 := "*t"
[290] loadk      2   63       ; R2 := 1518582630
[291] call       0   3   2    ; R0 := R0(R1, R2)
[292] setglobal  0   8        ; t := R0
[293] getglobal  0   0        ; R0 := print
[294] getglobal  1   8        ; R1 := t
[295] gettable   1   1   307  ; R1 := R1["year"]
[296] call       0   2   1    ;  := R0(R1)
[297] getglobal  0   0        ; R0 := print
[298] getglobal  1   8        ; R1 := t
[299] gettable   1   1   309  ; R1 := R1["month"]
[300] call       0   2   1    ;  := R0(R1)
[301] getglobal  0   0        ; R0 := print
[302] getglobal  1   8        ; R1 := t
[303] gettable   1   1   310  ; R1 := R1["day"]
[304] call       0   2   1    ;  := R0(R1)
[305] getglobal  0   0        ; R0 := print
[306] getglobal  1   8        ; R1 := t
[307] gettable   1   1   312  ; R1 := R1["hour"]
[308] call       0   2   1    ;  := R0(R1)
[309] getglobal  0   0        ; R0 := print
[310] getglobal  1   8        ; R1 := t
[311] gettable   1   1   314  ; R1 := R1["min"]
[312] call       0   2   1    ;  := R0(R1)
[313] getglobal  0   0        ; R0 := print
[314] getglobal  1   8        ; R1 := t
[315] gettable   1   1   316  ; R1 := R1["sec"]
[316] call       0   2   1    ;  := R0(R1)
[317] return     0   1        ; return 
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
002B  3D010000           sizecode (317)
002F  05000000           [001] getglobal  0   0        ; R0 := print
0033  45400000           [002] getglobal  1   1        ; R1 := math
0037  4680C000           [003] gettable   1   1   258  ; R1 := R1["type"]
003B  81C00000           [004] loadk      2   3        ; R2 := 100
003F  5C000001           [005] call       1   2   0    ; R1 to top := R1(R2)
0043  1C400000           [006] call       0   0   1    ;  := R0(R1 to top)
0047  05000000           [007] getglobal  0   0        ; R0 := print
004B  45400000           [008] getglobal  1   1        ; R1 := math
004F  4680C000           [009] gettable   1   1   258  ; R1 := R1["type"]
0053  81000100           [010] loadk      2   4        ; R2 := 3.14
0057  5C000001           [011] call       1   2   0    ; R1 to top := R1(R2)
005B  1C400000           [012] call       0   0   1    ;  := R0(R1 to top)
005F  05000000           [013] getglobal  0   0        ; R0 := print
0063  45400000           [014] getglobal  1   1        ; R1 := math
0067  4680C000           [015] gettable   1   1   258  ; R1 := R1["type"]
006B  81400100           [016] loadk      2   5        ; R2 := "100"
006F  5C000001           [017] call       1   2   0    ; R1 to top := R1(R2)
0073  1C400000           [018] call       0   0   1    ;  := R0(R1 to top)
0077  05000000           [019] getglobal  0   0        ; R0 := print
007B  45400000           [020] getglobal  1   1        ; R1 := math
007F  4680C100           [021] gettable   1   1   262  ; R1 := R1["tointeger"]
0083  81C00000           [022] loadk      2   3        ; R2 := 100
0087  5C000001           [023] call       1   2   0    ; R1 to top := R1(R2)
008B  1C400000           [024] call       0   0   1    ;  := R0(R1 to top)
008F  05000000           [025] getglobal  0   0        ; R0 := print
0093  45400000           [026] getglobal  1   1        ; R1 := math
0097  4680C100           [027] gettable   1   1   262  ; R1 := R1["tointeger"]
009B  81C00100           [028] loadk      2   7        ; R2 := "100.0"
009F  5C000001           [029] call       1   2   0    ; R1 to top := R1(R2)
00A3  1C400000           [030] call       0   0   1    ;  := R0(R1 to top)
00A7  05000000           [031] getglobal  0   0        ; R0 := print
00AB  45400000           [032] getglobal  1   1        ; R1 := math
00AF  4680C100           [033] gettable   1   1   262  ; R1 := R1["tointeger"]
00B3  81000100           [034] loadk      2   4        ; R2 := 3.14
00B7  5C000001           [035] call       1   2   0    ; R1 to top := R1(R2)
00BB  1C400000           [036] call       0   0   1    ;  := R0(R1 to top)
00BF  05400200           [037] getglobal  0   9        ; R0 := table
00C3  06804200           [038] gettable   0   0   266  ; R0 := R0["pack"]
00C7  41C00200           [039] loadk      1   11       ; R1 := 1
00CB  81000300           [040] loadk      2   12       ; R2 := 2
00CF  C1400300           [041] loadk      3   13       ; R3 := 3
00D3  01810300           [042] loadk      4   14       ; R4 := 4
00D7  41C10300           [043] loadk      5   15       ; R5 := 5
00DB  1C800003           [044] call       0   6   2    ; R0 := R0(R1 to R5)
00DF  07000200           [045] setglobal  0   8        ; t := R0
00E3  05000000           [046] getglobal  0   0        ; R0 := print
00E7  45400200           [047] getglobal  1   9        ; R1 := table
00EB  4600C400           [048] gettable   1   1   272  ; R1 := R1["unpack"]
00EF  85000200           [049] getglobal  2   8        ; R2 := t
00F3  5C000001           [050] call       1   2   0    ; R1 to top := R1(R2)
00F7  1C400000           [051] call       0   0   1    ;  := R0(R1 to top)
00FB  05400200           [052] getglobal  0   9        ; R0 := table
00FF  06404400           [053] gettable   0   0   273  ; R0 := R0["move"]
0103  45000200           [054] getglobal  1   8        ; R1 := t
0107  81800300           [055] loadk      2   14       ; R2 := 4
010B  C1C00300           [056] loadk      3   15       ; R3 := 5
010F  01C10200           [057] loadk      4   11       ; R4 := 1
0113  1C408002           [058] call       0   5   1    ;  := R0(R1 to R4)
0117  05000000           [059] getglobal  0   0        ; R0 := print
011B  45400200           [060] getglobal  1   9        ; R1 := table
011F  4600C400           [061] gettable   1   1   272  ; R1 := R1["unpack"]
0123  85000200           [062] getglobal  2   8        ; R2 := t
0127  5C000001           [063] call       1   2   0    ; R1 to top := R1(R2)
012B  1C400000           [064] call       0   0   1    ;  := R0(R1 to top)
012F  05400200           [065] getglobal  0   9        ; R0 := table
0133  06804400           [066] gettable   0   0   274  ; R0 := R0["insert"]
0137  45000200           [067] getglobal  1   8        ; R1 := t
013B  81400300           [068] loadk      2   13       ; R2 := 3
013F  C1000300           [069] loadk      3   12       ; R3 := 2
0143  1C400002           [070] call       0   4   1    ;  := R0(R1 to R3)
0147  05000000           [071] getglobal  0   0        ; R0 := print
014B  45400200           [072] getglobal  1   9        ; R1 := table
014F  4600C400           [073] gettable   1   1   272  ; R1 := R1["unpack"]
0153  85000200           [074] getglobal  2   8        ; R2 := t
0157  5C000001           [075] call       1   2   0    ; R1 to top := R1(R2)
015B  1C400000           [076] call       0   0   1    ;  := R0(R1 to top)
015F  05400200           [077] getglobal  0   9        ; R0 := table
0163  06C04400           [078] gettable   0   0   275  ; R0 := R0["remove"]
0167  45000200           [079] getglobal  1   8        ; R1 := t
016B  81000300           [080] loadk      2   12       ; R2 := 2
016F  1C408001           [081] call       0   3   1    ;  := R0(R1, R2)
0173  05000000           [082] getglobal  0   0        ; R0 := print
0177  45400200           [083] getglobal  1   9        ; R1 := table
017B  4600C400           [084] gettable   1   1   272  ; R1 := R1["unpack"]
017F  85000200           [085] getglobal  2   8        ; R2 := t
0183  5C000001           [086] call       1   2   0    ; R1 to top := R1(R2)
0187  1C400000           [087] call       0   0   1    ;  := R0(R1 to top)
018B  05400200           [088] getglobal  0   9        ; R0 := table
018F  06004500           [089] gettable   0   0   276  ; R0 := R0["sort"]
0193  45000200           [090] getglobal  1   8        ; R1 := t
0197  1C400001           [091] call       0   2   1    ;  := R0(R1)
019B  05000000           [092] getglobal  0   0        ; R0 := print
019F  45400200           [093] getglobal  1   9        ; R1 := table
01A3  4600C400           [094] gettable   1   1   272  ; R1 := R1["unpack"]
01A7  85000200           [095] getglobal  2   8        ; R2 := t
01AB  5C000001           [096] call       1   2   0    ; R1 to top := R1(R2)
01AF  1C400000           [097] call       0   0   1    ;  := R0(R1 to top)
01B3  05000000           [098] getglobal  0   0        ; R0 := print
01B7  45400200           [099] getglobal  1   9        ; R1 := table
01BB  4640C500           [100] gettable   1   1   277  ; R1 := R1["concat"]
01BF  85000200           [101] getglobal  2   8        ; R2 := t
01C3  C1800500           [102] loadk      3   22       ; R3 := ","
01C7  5C008001           [103] call       1   3   0    ; R1 to top := R1(R2, R3)
01CB  1C400000           [104] call       0   0   1    ;  := R0(R1 to top)
01CF  05000000           [105] getglobal  0   0        ; R0 := print
01D3  45C00500           [106] getglobal  1   23       ; R1 := string
01D7  4600C600           [107] gettable   1   1   280  ; R1 := R1["len"]
01DB  81400600           [108] loadk      2   25       ; R2 := "abc"
01DF  5C000001           [109] call       1   2   0    ; R1 to top := R1(R2)
01E3  1C400000           [110] call       0   0   1    ;  := R0(R1 to top)
01E7  05000000           [111] getglobal  0   0        ; R0 := print
01EB  45C00500           [112] getglobal  1   23       ; R1 := string
01EF  4680C600           [113] gettable   1   1   282  ; R1 := R1["rep"]
01F3  81C00600           [114] loadk      2   27       ; R2 := "a"
01F7  C1400300           [115] loadk      3   13       ; R3 := 3
01FB  01810500           [116] loadk      4   22       ; R4 := ","
01FF  5C000002           [117] call       1   4   0    ; R1 to top := R1(R2 to R4)
0203  1C400000           [118] call       0   0   1    ;  := R0(R1 to top)
0207  05000000           [119] getglobal  0   0        ; R0 := print
020B  45C00500           [120] getglobal  1   23       ; R1 := string
020F  4600C700           [121] gettable   1   1   284  ; R1 := R1["reverse"]
0213  81400600           [122] loadk      2   25       ; R2 := "abc"
0217  5C000001           [123] call       1   2   0    ; R1 to top := R1(R2)
021B  1C400000           [124] call       0   0   1    ;  := R0(R1 to top)
021F  05000000           [125] getglobal  0   0        ; R0 := print
0223  45C00500           [126] getglobal  1   23       ; R1 := string
0227  4640C700           [127] gettable   1   1   285  ; R1 := R1["lower"]
022B  81800700           [128] loadk      2   30       ; R2 := "ABC"
022F  5C000001           [129] call       1   2   0    ; R1 to top := R1(R2)
0233  1C400000           [130] call       0   0   1    ;  := R0(R1 to top)
0237  05000000           [131] getglobal  0   0        ; R0 := print
023B  45C00500           [132] getglobal  1   23       ; R1 := string
023F  46C0C700           [133] gettable   1   1   287  ; R1 := R1["upper"]
0243  81400600           [134] loadk      2   25       ; R2 := "abc"
0247  5C000001           [135] call       1   2   0    ; R1 to top := R1(R2)
024B  1C400000           [136] call       0   0   1    ;  := R0(R1 to top)
024F  05000000           [137] getglobal  0   0        ; R0 := print
0253  45C00500           [138] getglobal  1   23       ; R1 := string
0257  4600C800           [139] gettable   1   1   288  ; R1 := R1["sub"]
025B  81400800           [140] loadk      2   33       ; R2 := "abcdefg"
025F  C1400300           [141] loadk      3   13       ; R3 := 3
0263  01C10300           [142] loadk      4   15       ; R4 := 5
0267  5C000002           [143] call       1   4   0    ; R1 to top := R1(R2 to R4)
026B  1C400000           [144] call       0   0   1    ;  := R0(R1 to top)
026F  05000000           [145] getglobal  0   0        ; R0 := print
0273  45C00500           [146] getglobal  1   23       ; R1 := string
0277  4680C800           [147] gettable   1   1   290  ; R1 := R1["byte"]
027B  81400800           [148] loadk      2   33       ; R2 := "abcdefg"
027F  C1400300           [149] loadk      3   13       ; R3 := 3
0283  01C10300           [150] loadk      4   15       ; R4 := 5
0287  5C000002           [151] call       1   4   0    ; R1 to top := R1(R2 to R4)
028B  1C400000           [152] call       0   0   1    ;  := R0(R1 to top)
028F  05000000           [153] getglobal  0   0        ; R0 := print
0293  45C00500           [154] getglobal  1   23       ; R1 := string
0297  46C0C800           [155] gettable   1   1   291  ; R1 := R1["char"]
029B  81000900           [156] loadk      2   36       ; R2 := 99
029F  C1C00000           [157] loadk      3   3        ; R3 := 100
02A3  01410900           [158] loadk      4   37       ; R4 := 101
02A7  5C000002           [159] call       1   4   0    ; R1 to top := R1(R2 to R4)
02AB  1C400000           [160] call       0   0   1    ;  := R0(R1 to top)
02AF  01C00900           [161] loadk      0   39       ; R0 := "aBc"
02B3  07800900           [162] setglobal  0   38       ; s := R0
02B7  05000000           [163] getglobal  0   0        ; R0 := print
02BB  45800900           [164] getglobal  1   38       ; R1 := s
02BF  4B00C600           [165] self       1   1   280  ; R2 := R1; R1 := R1["len"]
02C3  5C000001           [166] call       1   2   0    ; R1 to top := R1(R2)
02C7  1C400000           [167] call       0   0   1    ;  := R0(R1 to top)
02CB  05000000           [168] getglobal  0   0        ; R0 := print
02CF  45800900           [169] getglobal  1   38       ; R1 := s
02D3  4B80C600           [170] self       1   1   282  ; R2 := R1; R1 := R1["rep"]
02D7  C1400300           [171] loadk      3   13       ; R3 := 3
02DB  01810500           [172] loadk      4   22       ; R4 := ","
02DF  5C000002           [173] call       1   4   0    ; R1 to top := R1(R2 to R4)
02E3  1C400000           [174] call       0   0   1    ;  := R0(R1 to top)
02E7  05000000           [175] getglobal  0   0        ; R0 := print
02EB  45800900           [176] getglobal  1   38       ; R1 := s
02EF  4B00C700           [177] self       1   1   284  ; R2 := R1; R1 := R1["reverse"]
02F3  5C000001           [178] call       1   2   0    ; R1 to top := R1(R2)
02F7  1C400000           [179] call       0   0   1    ;  := R0(R1 to top)
02FB  05000000           [180] getglobal  0   0        ; R0 := print
02FF  45800900           [181] getglobal  1   38       ; R1 := s
0303  4BC0C700           [182] self       1   1   287  ; R2 := R1; R1 := R1["upper"]
0307  5C000001           [183] call       1   2   0    ; R1 to top := R1(R2)
030B  1C400000           [184] call       0   0   1    ;  := R0(R1 to top)
030F  05000000           [185] getglobal  0   0        ; R0 := print
0313  45800900           [186] getglobal  1   38       ; R1 := s
0317  4B40C700           [187] self       1   1   285  ; R2 := R1; R1 := R1["lower"]
031B  5C000001           [188] call       1   2   0    ; R1 to top := R1(R2)
031F  1C400000           [189] call       0   0   1    ;  := R0(R1 to top)
0323  05000000           [190] getglobal  0   0        ; R0 := print
0327  45800900           [191] getglobal  1   38       ; R1 := s
032B  4B00C800           [192] self       1   1   288  ; R2 := R1; R1 := R1["sub"]
032F  C1C00200           [193] loadk      3   11       ; R3 := 1
0333  01010300           [194] loadk      4   12       ; R4 := 2
0337  5C000002           [195] call       1   4   0    ; R1 to top := R1(R2 to R4)
033B  1C400000           [196] call       0   0   1    ;  := R0(R1 to top)
033F  05000000           [197] getglobal  0   0        ; R0 := print
0343  45800900           [198] getglobal  1   38       ; R1 := s
0347  4B80C800           [199] self       1   1   290  ; R2 := R1; R1 := R1["byte"]
034B  C1C00200           [200] loadk      3   11       ; R3 := 1
034F  01010300           [201] loadk      4   12       ; R4 := 2
0353  5C000002           [202] call       1   4   0    ; R1 to top := R1(R2 to R4)
0357  1C400000           [203] call       0   0   1    ;  := R0(R1 to top)
035B  05000000           [204] getglobal  0   0        ; R0 := print
035F  45C00500           [205] getglobal  1   23       ; R1 := string
0363  4600C600           [206] gettable   1   1   280  ; R1 := R1["len"]
0367  81000A00           [207] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
036B  5C000001           [208] call       1   2   0    ; R1 to top := R1(R2)
036F  1C400000           [209] call       0   0   1    ;  := R0(R1 to top)
0373  05000000           [210] getglobal  0   0        ; R0 := print
0377  45400A00           [211] getglobal  1   41       ; R1 := utf8
037B  4600C600           [212] gettable   1   1   280  ; R1 := R1["len"]
037F  81000A00           [213] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
0383  5C000001           [214] call       1   2   0    ; R1 to top := R1(R2)
0387  1C400000           [215] call       0   0   1    ;  := R0(R1 to top)
038B  05000000           [216] getglobal  0   0        ; R0 := print
038F  45400A00           [217] getglobal  1   41       ; R1 := utf8
0393  46C0C800           [218] gettable   1   1   291  ; R1 := R1["char"]
0397  81800A00           [219] loadk      2   42       ; R2 := 20320
039B  C1C00A00           [220] loadk      3   43       ; R3 := 22909
039F  5C008001           [221] call       1   3   0    ; R1 to top := R1(R2, R3)
03A3  1C400000           [222] call       0   0   1    ;  := R0(R1 to top)
03A7  05000000           [223] getglobal  0   0        ; R0 := print
03AB  41000B00           [224] loadk      1   44       ; R1 := "u{4f60}u{597d}"
03AF  1C400001           [225] call       0   2   1    ;  := R0(R1)
03B3  05000000           [226] getglobal  0   0        ; R0 := print
03B7  45400A00           [227] getglobal  1   41       ; R1 := utf8
03BB  4640CB00           [228] gettable   1   1   301  ; R1 := R1["offset"]
03BF  81000A00           [229] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03C3  C1000300           [230] loadk      3   12       ; R3 := 2
03C7  5C008001           [231] call       1   3   0    ; R1 to top := R1(R2, R3)
03CB  1C400000           [232] call       0   0   1    ;  := R0(R1 to top)
03CF  05000000           [233] getglobal  0   0        ; R0 := print
03D3  45400A00           [234] getglobal  1   41       ; R1 := utf8
03D7  4640CB00           [235] gettable   1   1   301  ; R1 := R1["offset"]
03DB  81000A00           [236] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03DF  C1C00300           [237] loadk      3   15       ; R3 := 5
03E3  5C008001           [238] call       1   3   0    ; R1 to top := R1(R2, R3)
03E7  1C400000           [239] call       0   0   1    ;  := R0(R1 to top)
03EB  05000000           [240] getglobal  0   0        ; R0 := print
03EF  45400A00           [241] getglobal  1   41       ; R1 := utf8
03F3  4680CB00           [242] gettable   1   1   302  ; R1 := R1["codepoint"]
03F7  81000A00           [243] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03FB  C1800300           [244] loadk      3   14       ; R3 := 4
03FF  5C008001           [245] call       1   3   0    ; R1 to top := R1(R2, R3)
0403  1C400000           [246] call       0   0   1    ;  := R0(R1 to top)
0407  05000000           [247] getglobal  0   0        ; R0 := print
040B  45400A00           [248] getglobal  1   41       ; R1 := utf8
040F  4680CB00           [249] gettable   1   1   302  ; R1 := R1["codepoint"]
0413  81000A00           [250] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
0417  C1C00B00           [251] loadk      3   47       ; R3 := 13
041B  5C008001           [252] call       1   3   0    ; R1 to top := R1(R2, R3)
041F  1C400000           [253] call       0   0   1    ;  := R0(R1 to top)
0423  05400A00           [254] getglobal  0   41       ; R0 := utf8
0427  06004C00           [255] gettable   0   0   304  ; R0 := R0["codes"]
042B  41000A00           [256] loadk      1   40       ; R1 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
042F  1C000101           [257] call       0   2   4    ; R0 to R2 := R0(R1)
0433  16C00080           [258] jmp        4            ; pc+=4 (goto [263])
0437  45010000           [259] getglobal  5   0        ; R5 := print
043B  80018001           [260] move       6   3        ; R6 := R3
043F  C0010002           [261] move       7   4        ; R7 := R4
0443  5C418001           [262] call       5   3   1    ;  := R5(R6, R7)
0447  21800000           [263] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 265
044B  1640FE7F           [264] jmp        -6           ; pc+=-6 (goto [259])
044F  05000000           [265] getglobal  0   0        ; R0 := print
0453  45400C00           [266] getglobal  1   49       ; R1 := os
0457  4680CC00           [267] gettable   1   1   306  ; R1 := R1["time"]
045B  5C008000           [268] call       1   1   0    ; R1 to top := R1()
045F  1C400000           [269] call       0   0   1    ;  := R0(R1 to top)
0463  05000000           [270] getglobal  0   0        ; R0 := print
0467  45400C00           [271] getglobal  1   49       ; R1 := os
046B  4680CC00           [272] gettable   1   1   306  ; R1 := R1["time"]
046F  8A800100           [273] newtable   2   0   6    ; R2 := {} , array=0, hash=6
0473  8900CD99           [274] settable   2   307 308  ; R2["year"] := 2018
0477  8900C39A           [275] settable   2   309 268  ; R2["month"] := 2
047B  89C04D9B           [276] settable   2   310 311  ; R2["day"] := 14
047F  89404E9C           [277] settable   2   312 313  ; R2["hour"] := 12
0483  89C04E9D           [278] settable   2   314 315  ; R2["min"] := 30
0487  89C04E9E           [279] settable   2   316 315  ; R2["sec"] := 30
048B  5C000001           [280] call       1   2   0    ; R1 to top := R1(R2)
048F  1C400000           [281] call       0   0   1    ;  := R0(R1 to top)
0493  05000000           [282] getglobal  0   0        ; R0 := print
0497  45400C00           [283] getglobal  1   49       ; R1 := os
049B  4640CF00           [284] gettable   1   1   317  ; R1 := R1["date"]
049F  5C008000           [285] call       1   1   0    ; R1 to top := R1()
04A3  1C400000           [286] call       0   0   1    ;  := R0(R1 to top)
04A7  05400C00           [287] getglobal  0   49       ; R0 := os
04AB  06404F00           [288] gettable   0   0   317  ; R0 := R0["date"]
04AF  41800F00           [289] loadk      1   62       ; R1 := "*t"
04B3  81C00F00           [290] loadk      2   63       ; R2 := 1518582630
04B7  1C808001           [291] call       0   3   2    ; R0 := R0(R1, R2)
04BB  07000200           [292] setglobal  0   8        ; t := R0
04BF  05000000           [293] getglobal  0   0        ; R0 := print
04C3  45000200           [294] getglobal  1   8        ; R1 := t
04C7  46C0CC00           [295] gettable   1   1   307  ; R1 := R1["year"]
04CB  1C400001           [296] call       0   2   1    ;  := R0(R1)
04CF  05000000           [297] getglobal  0   0        ; R0 := print
04D3  45000200           [298] getglobal  1   8        ; R1 := t
04D7  4640CD00           [299] gettable   1   1   309  ; R1 := R1["month"]
04DB  1C400001           [300] call       0   2   1    ;  := R0(R1)
04DF  05000000           [301] getglobal  0   0        ; R0 := print
04E3  45000200           [302] getglobal  1   8        ; R1 := t
04E7  4680CD00           [303] gettable   1   1   310  ; R1 := R1["day"]
04EB  1C400001           [304] call       0   2   1    ;  := R0(R1)
04EF  05000000           [305] getglobal  0   0        ; R0 := print
04F3  45000200           [306] getglobal  1   8        ; R1 := t
04F7  4600CE00           [307] gettable   1   1   312  ; R1 := R1["hour"]
04FB  1C400001           [308] call       0   2   1    ;  := R0(R1)
04FF  05000000           [309] getglobal  0   0        ; R0 := print
0503  45000200           [310] getglobal  1   8        ; R1 := t
0507  4680CE00           [311] gettable   1   1   314  ; R1 := R1["min"]
050B  1C400001           [312] call       0   2   1    ;  := R0(R1)
050F  05000000           [313] getglobal  0   0        ; R0 := print
0513  45000200           [314] getglobal  1   8        ; R1 := t
0517  4600CF00           [315] gettable   1   1   316  ; R1 := R1["sec"]
051B  1C400001           [316] call       0   2   1    ;  := R0(R1)
051F  1E008000           [317] return     0   1        ; return 
                         * constants:
0523  40000000           sizek (64)
0527  04                 const type 4
0528  0600000000000000   string size (6)
0530  7072696E7400       "print\0"
                         const [0]: "print"
0536  04                 const type 4
0537  0500000000000000   string size (5)
053F  6D61746800         "math\0"
                         const [1]: "math"
0544  04                 const type 4
0545  0500000000000000   string size (5)
054D  7479706500         "type\0"
                         const [2]: "type"
0552  03                 const type 3
0553  0000000000005940   const [3]: (100)
055B  03                 const type 3
055C  1F85EB51B81E0940   const [4]: (3.14)
0564  04                 const type 4
0565  0400000000000000   string size (4)
056D  31303000           "100\0"
                         const [5]: "100"
0571  04                 const type 4
0572  0A00000000000000   string size (10)
057A  746F696E74656765+  "tointege"
0582  7200               "r\0"
                         const [6]: "tointeger"
0584  04                 const type 4
0585  0600000000000000   string size (6)
058D  3130302E3000       "100.0\0"
                         const [7]: "100.0"
0593  04                 const type 4
0594  0200000000000000   string size (2)
059C  7400               "t\0"
                         const [8]: "t"
059E  04                 const type 4
059F  0600000000000000   string size (6)
05A7  7461626C6500       "table\0"
                         const [9]: "table"
05AD  04                 const type 4
05AE  0500000000000000   string size (5)
05B6  7061636B00         "pack\0"
                         const [10]: "pack"
05BB  03                 const type 3
05BC  000000000000F03F   const [11]: (1)
05C4  03                 const type 3
05C5  0000000000000040   const [12]: (2)
05CD  03                 const type 3
05CE  0000000000000840   const [13]: (3)
05D6  03                 const type 3
05D7  0000000000001040   const [14]: (4)
05DF  03                 const type 3
05E0  0000000000001440   const [15]: (5)
05E8  04                 const type 4
05E9  0700000000000000   string size (7)
05F1  756E7061636B00     "unpack\0"
                         const [16]: "unpack"
05F8  04                 const type 4
05F9  0500000000000000   string size (5)
0601  6D6F766500         "move\0"
                         const [17]: "move"
0606  04                 const type 4
0607  0700000000000000   string size (7)
060F  696E7365727400     "insert\0"
                         const [18]: "insert"
0616  04                 const type 4
0617  0700000000000000   string size (7)
061F  72656D6F766500     "remove\0"
                         const [19]: "remove"
0626  04                 const type 4
0627  0500000000000000   string size (5)
062F  736F727400         "sort\0"
                         const [20]: "sort"
0634  04                 const type 4
0635  0700000000000000   string size (7)
063D  636F6E63617400     "concat\0"
                         const [21]: "concat"
0644  04                 const type 4
0645  0200000000000000   string size (2)
064D  2C00               ",\0"
                         const [22]: ","
064F  04                 const type 4
0650  0700000000000000   string size (7)
0658  737472696E6700     "string\0"
                         const [23]: "string"
065F  04                 const type 4
0660  0400000000000000   string size (4)
0668  6C656E00           "len\0"
                         const [24]: "len"
066C  04                 const type 4
066D  0400000000000000   string size (4)
0675  61626300           "abc\0"
                         const [25]: "abc"
0679  04                 const type 4
067A  0400000000000000   string size (4)
0682  72657000           "rep\0"
                         const [26]: "rep"
0686  04                 const type 4
0687  0200000000000000   string size (2)
068F  6100               "a\0"
                         const [27]: "a"
0691  04                 const type 4
0692  0800000000000000   string size (8)
069A  7265766572736500   "reverse\0"
                         const [28]: "reverse"
06A2  04                 const type 4
06A3  0600000000000000   string size (6)
06AB  6C6F77657200       "lower\0"
                         const [29]: "lower"
06B1  04                 const type 4
06B2  0400000000000000   string size (4)
06BA  41424300           "ABC\0"
                         const [30]: "ABC"
06BE  04                 const type 4
06BF  0600000000000000   string size (6)
06C7  757070657200       "upper\0"
                         const [31]: "upper"
06CD  04                 const type 4
06CE  0400000000000000   string size (4)
06D6  73756200           "sub\0"
                         const [32]: "sub"
06DA  04                 const type 4
06DB  0800000000000000   string size (8)
06E3  6162636465666700   "abcdefg\0"
                         const [33]: "abcdefg"
06EB  04                 const type 4
06EC  0500000000000000   string size (5)
06F4  6279746500         "byte\0"
                         const [34]: "byte"
06F9  04                 const type 4
06FA  0500000000000000   string size (5)
0702  6368617200         "char\0"
                         const [35]: "char"
0707  03                 const type 3
0708  0000000000C05840   const [36]: (99)
0710  03                 const type 3
0711  0000000000405940   const [37]: (101)
0719  04                 const type 4
071A  0200000000000000   string size (2)
0722  7300               "s\0"
                         const [38]: "s"
0724  04                 const type 4
0725  0400000000000000   string size (4)
072D  61426300           "aBc\0"
                         const [39]: "aBc"
0731  04                 const type 4
0732  1300000000000000   string size (19)
073A  E4BDA0E5A5BDEFBC+  "\228\189\160\229\165\189\239\188"
0742  8CE4B896E7958CEF+  "\140\228\184\150\231\149\140\239"
074A  BC8100             "\188\129\0"
                         const [40]: "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
074D  04                 const type 4
074E  0500000000000000   string size (5)
0756  7574663800         "utf8\0"
                         const [41]: "utf8"
075B  03                 const type 3
075C  0000000000D8D340   const [42]: (20320)
0764  03                 const type 3
0765  00000000405FD640   const [43]: (22909)
076D  04                 const type 4
076E  0F00000000000000   string size (15)
0776  757B346636307D75+  "u{4f60}u"
077E  7B353937647D00     "{597d}\0"
                         const [44]: "u{4f60}u{597d}"
0785  04                 const type 4
0786  0700000000000000   string size (7)
078E  6F666673657400     "offset\0"
                         const [45]: "offset"
0795  04                 const type 4
0796  0A00000000000000   string size (10)
079E  636F6465706F696E+  "codepoin"
07A6  7400               "t\0"
                         const [46]: "codepoint"
07A8  03                 const type 3
07A9  0000000000002A40   const [47]: (13)
07B1  04                 const type 4
07B2  0600000000000000   string size (6)
07BA  636F64657300       "codes\0"
                         const [48]: "codes"
07C0  04                 const type 4
07C1  0300000000000000   string size (3)
07C9  6F7300             "os\0"
                         const [49]: "os"
07CC  04                 const type 4
07CD  0500000000000000   string size (5)
07D5  74696D6500         "time\0"
                         const [50]: "time"
07DA  04                 const type 4
07DB  0500000000000000   string size (5)
07E3  7965617200         "year\0"
                         const [51]: "year"
07E8  03                 const type 3
07E9  0000000000889F40   const [52]: (2018)
07F1  04                 const type 4
07F2  0600000000000000   string size (6)
07FA  6D6F6E746800       "month\0"
                         const [53]: "month"
0800  04                 const type 4
0801  0400000000000000   string size (4)
0809  64617900           "day\0"
                         const [54]: "day"
080D  03                 const type 3
080E  0000000000002C40   const [55]: (14)
0816  04                 const type 4
0817  0500000000000000   string size (5)
081F  686F757200         "hour\0"
                         const [56]: "hour"
0824  03                 const type 3
0825  0000000000002840   const [57]: (12)
082D  04                 const type 4
082E  0400000000000000   string size (4)
0836  6D696E00           "min\0"
                         const [58]: "min"
083A  03                 const type 3
083B  0000000000003E40   const [59]: (30)
0843  04                 const type 4
0844  0400000000000000   string size (4)
084C  73656300           "sec\0"
                         const [60]: "sec"
0850  04                 const type 4
0851  0500000000000000   string size (5)
0859  6461746500         "date\0"
                         const [61]: "date"
085E  04                 const type 4
085F  0300000000000000   string size (3)
0867  2A7400             "*t\0"
                         const [62]: "*t"
086A  03                 const type 3
086B  000080D9EEA0D641   const [63]: (1518582630)
                         * functions:
0873  00000000           sizep (0)
                         * lines:
0877  3D010000           sizelineinfo (317)
                         [pc] (line)
087B  01000000           [001] (1)
087F  01000000           [002] (1)
0883  01000000           [003] (1)
0887  01000000           [004] (1)
088B  01000000           [005] (1)
088F  01000000           [006] (1)
0893  02000000           [007] (2)
0897  02000000           [008] (2)
089B  02000000           [009] (2)
089F  02000000           [010] (2)
08A3  02000000           [011] (2)
08A7  02000000           [012] (2)
08AB  03000000           [013] (3)
08AF  03000000           [014] (3)
08B3  03000000           [015] (3)
08B7  03000000           [016] (3)
08BB  03000000           [017] (3)
08BF  03000000           [018] (3)
08C3  04000000           [019] (4)
08C7  04000000           [020] (4)
08CB  04000000           [021] (4)
08CF  04000000           [022] (4)
08D3  04000000           [023] (4)
08D7  04000000           [024] (4)
08DB  05000000           [025] (5)
08DF  05000000           [026] (5)
08E3  05000000           [027] (5)
08E7  05000000           [028] (5)
08EB  05000000           [029] (5)
08EF  05000000           [030] (5)
08F3  06000000           [031] (6)
08F7  06000000           [032] (6)
08FB  06000000           [033] (6)
08FF  06000000           [034] (6)
0903  06000000           [035] (6)
0907  06000000           [036] (6)
090B  09000000           [037] (9)
090F  09000000           [038] (9)
0913  09000000           [039] (9)
0917  09000000           [040] (9)
091B  09000000           [041] (9)
091F  09000000           [042] (9)
0923  09000000           [043] (9)
0927  09000000           [044] (9)
092B  09000000           [045] (9)
092F  09000000           [046] (9)
0933  09000000           [047] (9)
0937  09000000           [048] (9)
093B  09000000           [049] (9)
093F  09000000           [050] (9)
0943  09000000           [051] (9)
0947  0A000000           [052] (10)
094B  0A000000           [053] (10)
094F  0A000000           [054] (10)
0953  0A000000           [055] (10)
0957  0A000000           [056] (10)
095B  0A000000           [057] (10)
095F  0A000000           [058] (10)
0963  0A000000           [059] (10)
0967  0A000000           [060] (10)
096B  0A000000           [061] (10)
096F  0A000000           [062] (10)
0973  0A000000           [063] (10)
0977  0A000000           [064] (10)
097B  0B000000           [065] (11)
097F  0B000000           [066] (11)
0983  0B000000           [067] (11)
0987  0B000000           [068] (11)
098B  0B000000           [069] (11)
098F  0B000000           [070] (11)
0993  0B000000           [071] (11)
0997  0B000000           [072] (11)
099B  0B000000           [073] (11)
099F  0B000000           [074] (11)
09A3  0B000000           [075] (11)
09A7  0B000000           [076] (11)
09AB  0C000000           [077] (12)
09AF  0C000000           [078] (12)
09B3  0C000000           [079] (12)
09B7  0C000000           [080] (12)
09BB  0C000000           [081] (12)
09BF  0C000000           [082] (12)
09C3  0C000000           [083] (12)
09C7  0C000000           [084] (12)
09CB  0C000000           [085] (12)
09CF  0C000000           [086] (12)
09D3  0C000000           [087] (12)
09D7  0D000000           [088] (13)
09DB  0D000000           [089] (13)
09DF  0D000000           [090] (13)
09E3  0D000000           [091] (13)
09E7  0D000000           [092] (13)
09EB  0D000000           [093] (13)
09EF  0D000000           [094] (13)
09F3  0D000000           [095] (13)
09F7  0D000000           [096] (13)
09FB  0D000000           [097] (13)
09FF  0E000000           [098] (14)
0A03  0E000000           [099] (14)
0A07  0E000000           [100] (14)
0A0B  0E000000           [101] (14)
0A0F  0E000000           [102] (14)
0A13  0E000000           [103] (14)
0A17  0E000000           [104] (14)
0A1B  11000000           [105] (17)
0A1F  11000000           [106] (17)
0A23  11000000           [107] (17)
0A27  11000000           [108] (17)
0A2B  11000000           [109] (17)
0A2F  11000000           [110] (17)
0A33  12000000           [111] (18)
0A37  12000000           [112] (18)
0A3B  12000000           [113] (18)
0A3F  12000000           [114] (18)
0A43  12000000           [115] (18)
0A47  12000000           [116] (18)
0A4B  12000000           [117] (18)
0A4F  12000000           [118] (18)
0A53  13000000           [119] (19)
0A57  13000000           [120] (19)
0A5B  13000000           [121] (19)
0A5F  13000000           [122] (19)
0A63  13000000           [123] (19)
0A67  13000000           [124] (19)
0A6B  14000000           [125] (20)
0A6F  14000000           [126] (20)
0A73  14000000           [127] (20)
0A77  14000000           [128] (20)
0A7B  14000000           [129] (20)
0A7F  14000000           [130] (20)
0A83  15000000           [131] (21)
0A87  15000000           [132] (21)
0A8B  15000000           [133] (21)
0A8F  15000000           [134] (21)
0A93  15000000           [135] (21)
0A97  15000000           [136] (21)
0A9B  16000000           [137] (22)
0A9F  16000000           [138] (22)
0AA3  16000000           [139] (22)
0AA7  16000000           [140] (22)
0AAB  16000000           [141] (22)
0AAF  16000000           [142] (22)
0AB3  16000000           [143] (22)
0AB7  16000000           [144] (22)
0ABB  17000000           [145] (23)
0ABF  17000000           [146] (23)
0AC3  17000000           [147] (23)
0AC7  17000000           [148] (23)
0ACB  17000000           [149] (23)
0ACF  17000000           [150] (23)
0AD3  17000000           [151] (23)
0AD7  17000000           [152] (23)
0ADB  18000000           [153] (24)
0ADF  18000000           [154] (24)
0AE3  18000000           [155] (24)
0AE7  18000000           [156] (24)
0AEB  18000000           [157] (24)
0AEF  18000000           [158] (24)
0AF3  18000000           [159] (24)
0AF7  18000000           [160] (24)
0AFB  1A000000           [161] (26)
0AFF  1A000000           [162] (26)
0B03  1B000000           [163] (27)
0B07  1B000000           [164] (27)
0B0B  1B000000           [165] (27)
0B0F  1B000000           [166] (27)
0B13  1B000000           [167] (27)
0B17  1C000000           [168] (28)
0B1B  1C000000           [169] (28)
0B1F  1C000000           [170] (28)
0B23  1C000000           [171] (28)
0B27  1C000000           [172] (28)
0B2B  1C000000           [173] (28)
0B2F  1C000000           [174] (28)
0B33  1D000000           [175] (29)
0B37  1D000000           [176] (29)
0B3B  1D000000           [177] (29)
0B3F  1D000000           [178] (29)
0B43  1D000000           [179] (29)
0B47  1E000000           [180] (30)
0B4B  1E000000           [181] (30)
0B4F  1E000000           [182] (30)
0B53  1E000000           [183] (30)
0B57  1E000000           [184] (30)
0B5B  1F000000           [185] (31)
0B5F  1F000000           [186] (31)
0B63  1F000000           [187] (31)
0B67  1F000000           [188] (31)
0B6B  1F000000           [189] (31)
0B6F  20000000           [190] (32)
0B73  20000000           [191] (32)
0B77  20000000           [192] (32)
0B7B  20000000           [193] (32)
0B7F  20000000           [194] (32)
0B83  20000000           [195] (32)
0B87  20000000           [196] (32)
0B8B  21000000           [197] (33)
0B8F  21000000           [198] (33)
0B93  21000000           [199] (33)
0B97  21000000           [200] (33)
0B9B  21000000           [201] (33)
0B9F  21000000           [202] (33)
0BA3  21000000           [203] (33)
0BA7  23000000           [204] (35)
0BAB  23000000           [205] (35)
0BAF  23000000           [206] (35)
0BB3  23000000           [207] (35)
0BB7  23000000           [208] (35)
0BBB  23000000           [209] (35)
0BBF  24000000           [210] (36)
0BC3  24000000           [211] (36)
0BC7  24000000           [212] (36)
0BCB  24000000           [213] (36)
0BCF  24000000           [214] (36)
0BD3  24000000           [215] (36)
0BD7  25000000           [216] (37)
0BDB  25000000           [217] (37)
0BDF  25000000           [218] (37)
0BE3  25000000           [219] (37)
0BE7  25000000           [220] (37)
0BEB  25000000           [221] (37)
0BEF  25000000           [222] (37)
0BF3  26000000           [223] (38)
0BF7  26000000           [224] (38)
0BFB  26000000           [225] (38)
0BFF  27000000           [226] (39)
0C03  27000000           [227] (39)
0C07  27000000           [228] (39)
0C0B  27000000           [229] (39)
0C0F  27000000           [230] (39)
0C13  27000000           [231] (39)
0C17  27000000           [232] (39)
0C1B  28000000           [233] (40)
0C1F  28000000           [234] (40)
0C23  28000000           [235] (40)
0C27  28000000           [236] (40)
0C2B  28000000           [237] (40)
0C2F  28000000           [238] (40)
0C33  28000000           [239] (40)
0C37  29000000           [240] (41)
0C3B  29000000           [241] (41)
0C3F  29000000           [242] (41)
0C43  29000000           [243] (41)
0C47  29000000           [244] (41)
0C4B  29000000           [245] (41)
0C4F  29000000           [246] (41)
0C53  2A000000           [247] (42)
0C57  2A000000           [248] (42)
0C5B  2A000000           [249] (42)
0C5F  2A000000           [250] (42)
0C63  2A000000           [251] (42)
0C67  2A000000           [252] (42)
0C6B  2A000000           [253] (42)
0C6F  2B000000           [254] (43)
0C73  2B000000           [255] (43)
0C77  2B000000           [256] (43)
0C7B  2B000000           [257] (43)
0C7F  2B000000           [258] (43)
0C83  2C000000           [259] (44)
0C87  2C000000           [260] (44)
0C8B  2C000000           [261] (44)
0C8F  2C000000           [262] (44)
0C93  2B000000           [263] (43)
0C97  2C000000           [264] (44)
0C9B  2F000000           [265] (47)
0C9F  2F000000           [266] (47)
0CA3  2F000000           [267] (47)
0CA7  2F000000           [268] (47)
0CAB  2F000000           [269] (47)
0CAF  30000000           [270] (48)
0CB3  30000000           [271] (48)
0CB7  30000000           [272] (48)
0CBB  30000000           [273] (48)
0CBF  30000000           [274] (48)
0CC3  30000000           [275] (48)
0CC7  30000000           [276] (48)
0CCB  31000000           [277] (49)
0CCF  31000000           [278] (49)
0CD3  31000000           [279] (49)
0CD7  30000000           [280] (48)
0CDB  30000000           [281] (48)
0CDF  33000000           [282] (51)
0CE3  33000000           [283] (51)
0CE7  33000000           [284] (51)
0CEB  33000000           [285] (51)
0CEF  33000000           [286] (51)
0CF3  34000000           [287] (52)
0CF7  34000000           [288] (52)
0CFB  34000000           [289] (52)
0CFF  34000000           [290] (52)
0D03  34000000           [291] (52)
0D07  34000000           [292] (52)
0D0B  35000000           [293] (53)
0D0F  35000000           [294] (53)
0D13  35000000           [295] (53)
0D17  35000000           [296] (53)
0D1B  36000000           [297] (54)
0D1F  36000000           [298] (54)
0D23  36000000           [299] (54)
0D27  36000000           [300] (54)
0D2B  37000000           [301] (55)
0D2F  37000000           [302] (55)
0D33  37000000           [303] (55)
0D37  37000000           [304] (55)
0D3B  38000000           [305] (56)
0D3F  38000000           [306] (56)
0D43  38000000           [307] (56)
0D47  38000000           [308] (56)
0D4B  39000000           [309] (57)
0D4F  39000000           [310] (57)
0D53  39000000           [311] (57)
0D57  39000000           [312] (57)
0D5B  3A000000           [313] (58)
0D5F  3A000000           [314] (58)
0D63  3A000000           [315] (58)
0D67  3A000000           [316] (58)
0D6B  3A000000           [317] (58)
                         * locals:
0D6F  05000000           sizelocvars (5)
0D73  1000000000000000   string size (16)
0D7B  28666F722067656E+  "(for gen"
0D83  657261746F722900   "erator)\0"
                         local [0]: (for generator)
0D8B  01010000             startpc (257)
0D8F  08010000             endpc   (264)
0D93  0C00000000000000   string size (12)
0D9B  28666F7220737461+  "(for sta"
0DA3  74652900           "te)\0"
                         local [1]: (for state)
0DA7  01010000             startpc (257)
0DAB  08010000             endpc   (264)
0DAF  0E00000000000000   string size (14)
0DB7  28666F7220636F6E+  "(for con"
0DBF  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0DC5  01010000             startpc (257)
0DC9  08010000             endpc   (264)
0DCD  0200000000000000   string size (2)
0DD5  7000               "p\0"
                         local [3]: p
0DD7  02010000             startpc (258)
0DDB  06010000             endpc   (262)
0DDF  0200000000000000   string size (2)
0DE7  6300               "c\0"
                         local [4]: c
0DE9  02010000             startpc (258)
0DED  06010000             endpc   (262)
                         * upvalues:
0DF1  00000000           sizeupvalues (0)
                         ** end of function 0 **

0DF5                     ** end of chunk **
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
002B  3D010000           sizecode (317)
002F  05000000           [001] getglobal  0   0        ; R0 := print
0033  45400000           [002] getglobal  1   1        ; R1 := math
0037  4680C000           [003] gettable   1   1   258  ; R1 := R1["type"]
003B  81C00000           [004] loadk      2   3        ; R2 := 100
003F  5C000001           [005] call       1   2   0    ; R1 to top := R1(R2)
0043  1C400000           [006] call       0   0   1    ;  := R0(R1 to top)
0047  05000000           [007] getglobal  0   0        ; R0 := print
004B  45400000           [008] getglobal  1   1        ; R1 := math
004F  4680C000           [009] gettable   1   1   258  ; R1 := R1["type"]
0053  81000100           [010] loadk      2   4        ; R2 := 3.14
0057  5C000001           [011] call       1   2   0    ; R1 to top := R1(R2)
005B  1C400000           [012] call       0   0   1    ;  := R0(R1 to top)
005F  05000000           [013] getglobal  0   0        ; R0 := print
0063  45400000           [014] getglobal  1   1        ; R1 := math
0067  4680C000           [015] gettable   1   1   258  ; R1 := R1["type"]
006B  81400100           [016] loadk      2   5        ; R2 := "100"
006F  5C000001           [017] call       1   2   0    ; R1 to top := R1(R2)
0073  1C400000           [018] call       0   0   1    ;  := R0(R1 to top)
0077  05000000           [019] getglobal  0   0        ; R0 := print
007B  45400000           [020] getglobal  1   1        ; R1 := math
007F  4680C100           [021] gettable   1   1   262  ; R1 := R1["tointeger"]
0083  81C00000           [022] loadk      2   3        ; R2 := 100
0087  5C000001           [023] call       1   2   0    ; R1 to top := R1(R2)
008B  1C400000           [024] call       0   0   1    ;  := R0(R1 to top)
008F  05000000           [025] getglobal  0   0        ; R0 := print
0093  45400000           [026] getglobal  1   1        ; R1 := math
0097  4680C100           [027] gettable   1   1   262  ; R1 := R1["tointeger"]
009B  81C00100           [028] loadk      2   7        ; R2 := "100.0"
009F  5C000001           [029] call       1   2   0    ; R1 to top := R1(R2)
00A3  1C400000           [030] call       0   0   1    ;  := R0(R1 to top)
00A7  05000000           [031] getglobal  0   0        ; R0 := print
00AB  45400000           [032] getglobal  1   1        ; R1 := math
00AF  4680C100           [033] gettable   1   1   262  ; R1 := R1["tointeger"]
00B3  81000100           [034] loadk      2   4        ; R2 := 3.14
00B7  5C000001           [035] call       1   2   0    ; R1 to top := R1(R2)
00BB  1C400000           [036] call       0   0   1    ;  := R0(R1 to top)
00BF  05400200           [037] getglobal  0   9        ; R0 := table
00C3  06804200           [038] gettable   0   0   266  ; R0 := R0["pack"]
00C7  41C00200           [039] loadk      1   11       ; R1 := 1
00CB  81000300           [040] loadk      2   12       ; R2 := 2
00CF  C1400300           [041] loadk      3   13       ; R3 := 3
00D3  01810300           [042] loadk      4   14       ; R4 := 4
00D7  41C10300           [043] loadk      5   15       ; R5 := 5
00DB  1C800003           [044] call       0   6   2    ; R0 := R0(R1 to R5)
00DF  07000200           [045] setglobal  0   8        ; t := R0
00E3  05000000           [046] getglobal  0   0        ; R0 := print
00E7  45400200           [047] getglobal  1   9        ; R1 := table
00EB  4600C400           [048] gettable   1   1   272  ; R1 := R1["unpack"]
00EF  85000200           [049] getglobal  2   8        ; R2 := t
00F3  5C000001           [050] call       1   2   0    ; R1 to top := R1(R2)
00F7  1C400000           [051] call       0   0   1    ;  := R0(R1 to top)
00FB  05400200           [052] getglobal  0   9        ; R0 := table
00FF  06404400           [053] gettable   0   0   273  ; R0 := R0["move"]
0103  45000200           [054] getglobal  1   8        ; R1 := t
0107  81800300           [055] loadk      2   14       ; R2 := 4
010B  C1C00300           [056] loadk      3   15       ; R3 := 5
010F  01C10200           [057] loadk      4   11       ; R4 := 1
0113  1C408002           [058] call       0   5   1    ;  := R0(R1 to R4)
0117  05000000           [059] getglobal  0   0        ; R0 := print
011B  45400200           [060] getglobal  1   9        ; R1 := table
011F  4600C400           [061] gettable   1   1   272  ; R1 := R1["unpack"]
0123  85000200           [062] getglobal  2   8        ; R2 := t
0127  5C000001           [063] call       1   2   0    ; R1 to top := R1(R2)
012B  1C400000           [064] call       0   0   1    ;  := R0(R1 to top)
012F  05400200           [065] getglobal  0   9        ; R0 := table
0133  06804400           [066] gettable   0   0   274  ; R0 := R0["insert"]
0137  45000200           [067] getglobal  1   8        ; R1 := t
013B  81400300           [068] loadk      2   13       ; R2 := 3
013F  C1000300           [069] loadk      3   12       ; R3 := 2
0143  1C400002           [070] call       0   4   1    ;  := R0(R1 to R3)
0147  05000000           [071] getglobal  0   0        ; R0 := print
014B  45400200           [072] getglobal  1   9        ; R1 := table
014F  4600C400           [073] gettable   1   1   272  ; R1 := R1["unpack"]
0153  85000200           [074] getglobal  2   8        ; R2 := t
0157  5C000001           [075] call       1   2   0    ; R1 to top := R1(R2)
015B  1C400000           [076] call       0   0   1    ;  := R0(R1 to top)
015F  05400200           [077] getglobal  0   9        ; R0 := table
0163  06C04400           [078] gettable   0   0   275  ; R0 := R0["remove"]
0167  45000200           [079] getglobal  1   8        ; R1 := t
016B  81000300           [080] loadk      2   12       ; R2 := 2
016F  1C408001           [081] call       0   3   1    ;  := R0(R1, R2)
0173  05000000           [082] getglobal  0   0        ; R0 := print
0177  45400200           [083] getglobal  1   9        ; R1 := table
017B  4600C400           [084] gettable   1   1   272  ; R1 := R1["unpack"]
017F  85000200           [085] getglobal  2   8        ; R2 := t
0183  5C000001           [086] call       1   2   0    ; R1 to top := R1(R2)
0187  1C400000           [087] call       0   0   1    ;  := R0(R1 to top)
018B  05400200           [088] getglobal  0   9        ; R0 := table
018F  06004500           [089] gettable   0   0   276  ; R0 := R0["sort"]
0193  45000200           [090] getglobal  1   8        ; R1 := t
0197  1C400001           [091] call       0   2   1    ;  := R0(R1)
019B  05000000           [092] getglobal  0   0        ; R0 := print
019F  45400200           [093] getglobal  1   9        ; R1 := table
01A3  4600C400           [094] gettable   1   1   272  ; R1 := R1["unpack"]
01A7  85000200           [095] getglobal  2   8        ; R2 := t
01AB  5C000001           [096] call       1   2   0    ; R1 to top := R1(R2)
01AF  1C400000           [097] call       0   0   1    ;  := R0(R1 to top)
01B3  05000000           [098] getglobal  0   0        ; R0 := print
01B7  45400200           [099] getglobal  1   9        ; R1 := table
01BB  4640C500           [100] gettable   1   1   277  ; R1 := R1["concat"]
01BF  85000200           [101] getglobal  2   8        ; R2 := t
01C3  C1800500           [102] loadk      3   22       ; R3 := ","
01C7  5C008001           [103] call       1   3   0    ; R1 to top := R1(R2, R3)
01CB  1C400000           [104] call       0   0   1    ;  := R0(R1 to top)
01CF  05000000           [105] getglobal  0   0        ; R0 := print
01D3  45C00500           [106] getglobal  1   23       ; R1 := string
01D7  4600C600           [107] gettable   1   1   280  ; R1 := R1["len"]
01DB  81400600           [108] loadk      2   25       ; R2 := "abc"
01DF  5C000001           [109] call       1   2   0    ; R1 to top := R1(R2)
01E3  1C400000           [110] call       0   0   1    ;  := R0(R1 to top)
01E7  05000000           [111] getglobal  0   0        ; R0 := print
01EB  45C00500           [112] getglobal  1   23       ; R1 := string
01EF  4680C600           [113] gettable   1   1   282  ; R1 := R1["rep"]
01F3  81C00600           [114] loadk      2   27       ; R2 := "a"
01F7  C1400300           [115] loadk      3   13       ; R3 := 3
01FB  01810500           [116] loadk      4   22       ; R4 := ","
01FF  5C000002           [117] call       1   4   0    ; R1 to top := R1(R2 to R4)
0203  1C400000           [118] call       0   0   1    ;  := R0(R1 to top)
0207  05000000           [119] getglobal  0   0        ; R0 := print
020B  45C00500           [120] getglobal  1   23       ; R1 := string
020F  4600C700           [121] gettable   1   1   284  ; R1 := R1["reverse"]
0213  81400600           [122] loadk      2   25       ; R2 := "abc"
0217  5C000001           [123] call       1   2   0    ; R1 to top := R1(R2)
021B  1C400000           [124] call       0   0   1    ;  := R0(R1 to top)
021F  05000000           [125] getglobal  0   0        ; R0 := print
0223  45C00500           [126] getglobal  1   23       ; R1 := string
0227  4640C700           [127] gettable   1   1   285  ; R1 := R1["lower"]
022B  81800700           [128] loadk      2   30       ; R2 := "ABC"
022F  5C000001           [129] call       1   2   0    ; R1 to top := R1(R2)
0233  1C400000           [130] call       0   0   1    ;  := R0(R1 to top)
0237  05000000           [131] getglobal  0   0        ; R0 := print
023B  45C00500           [132] getglobal  1   23       ; R1 := string
023F  46C0C700           [133] gettable   1   1   287  ; R1 := R1["upper"]
0243  81400600           [134] loadk      2   25       ; R2 := "abc"
0247  5C000001           [135] call       1   2   0    ; R1 to top := R1(R2)
024B  1C400000           [136] call       0   0   1    ;  := R0(R1 to top)
024F  05000000           [137] getglobal  0   0        ; R0 := print
0253  45C00500           [138] getglobal  1   23       ; R1 := string
0257  4600C800           [139] gettable   1   1   288  ; R1 := R1["sub"]
025B  81400800           [140] loadk      2   33       ; R2 := "abcdefg"
025F  C1400300           [141] loadk      3   13       ; R3 := 3
0263  01C10300           [142] loadk      4   15       ; R4 := 5
0267  5C000002           [143] call       1   4   0    ; R1 to top := R1(R2 to R4)
026B  1C400000           [144] call       0   0   1    ;  := R0(R1 to top)
026F  05000000           [145] getglobal  0   0        ; R0 := print
0273  45C00500           [146] getglobal  1   23       ; R1 := string
0277  4680C800           [147] gettable   1   1   290  ; R1 := R1["byte"]
027B  81400800           [148] loadk      2   33       ; R2 := "abcdefg"
027F  C1400300           [149] loadk      3   13       ; R3 := 3
0283  01C10300           [150] loadk      4   15       ; R4 := 5
0287  5C000002           [151] call       1   4   0    ; R1 to top := R1(R2 to R4)
028B  1C400000           [152] call       0   0   1    ;  := R0(R1 to top)
028F  05000000           [153] getglobal  0   0        ; R0 := print
0293  45C00500           [154] getglobal  1   23       ; R1 := string
0297  46C0C800           [155] gettable   1   1   291  ; R1 := R1["char"]
029B  81000900           [156] loadk      2   36       ; R2 := 99
029F  C1C00000           [157] loadk      3   3        ; R3 := 100
02A3  01410900           [158] loadk      4   37       ; R4 := 101
02A7  5C000002           [159] call       1   4   0    ; R1 to top := R1(R2 to R4)
02AB  1C400000           [160] call       0   0   1    ;  := R0(R1 to top)
02AF  01C00900           [161] loadk      0   39       ; R0 := "aBc"
02B3  07800900           [162] setglobal  0   38       ; s := R0
02B7  05000000           [163] getglobal  0   0        ; R0 := print
02BB  45800900           [164] getglobal  1   38       ; R1 := s
02BF  4B00C600           [165] self       1   1   280  ; R2 := R1; R1 := R1["len"]
02C3  5C000001           [166] call       1   2   0    ; R1 to top := R1(R2)
02C7  1C400000           [167] call       0   0   1    ;  := R0(R1 to top)
02CB  05000000           [168] getglobal  0   0        ; R0 := print
02CF  45800900           [169] getglobal  1   38       ; R1 := s
02D3  4B80C600           [170] self       1   1   282  ; R2 := R1; R1 := R1["rep"]
02D7  C1400300           [171] loadk      3   13       ; R3 := 3
02DB  01810500           [172] loadk      4   22       ; R4 := ","
02DF  5C000002           [173] call       1   4   0    ; R1 to top := R1(R2 to R4)
02E3  1C400000           [174] call       0   0   1    ;  := R0(R1 to top)
02E7  05000000           [175] getglobal  0   0        ; R0 := print
02EB  45800900           [176] getglobal  1   38       ; R1 := s
02EF  4B00C700           [177] self       1   1   284  ; R2 := R1; R1 := R1["reverse"]
02F3  5C000001           [178] call       1   2   0    ; R1 to top := R1(R2)
02F7  1C400000           [179] call       0   0   1    ;  := R0(R1 to top)
02FB  05000000           [180] getglobal  0   0        ; R0 := print
02FF  45800900           [181] getglobal  1   38       ; R1 := s
0303  4BC0C700           [182] self       1   1   287  ; R2 := R1; R1 := R1["upper"]
0307  5C000001           [183] call       1   2   0    ; R1 to top := R1(R2)
030B  1C400000           [184] call       0   0   1    ;  := R0(R1 to top)
030F  05000000           [185] getglobal  0   0        ; R0 := print
0313  45800900           [186] getglobal  1   38       ; R1 := s
0317  4B40C700           [187] self       1   1   285  ; R2 := R1; R1 := R1["lower"]
031B  5C000001           [188] call       1   2   0    ; R1 to top := R1(R2)
031F  1C400000           [189] call       0   0   1    ;  := R0(R1 to top)
0323  05000000           [190] getglobal  0   0        ; R0 := print
0327  45800900           [191] getglobal  1   38       ; R1 := s
032B  4B00C800           [192] self       1   1   288  ; R2 := R1; R1 := R1["sub"]
032F  C1C00200           [193] loadk      3   11       ; R3 := 1
0333  01010300           [194] loadk      4   12       ; R4 := 2
0337  5C000002           [195] call       1   4   0    ; R1 to top := R1(R2 to R4)
033B  1C400000           [196] call       0   0   1    ;  := R0(R1 to top)
033F  05000000           [197] getglobal  0   0        ; R0 := print
0343  45800900           [198] getglobal  1   38       ; R1 := s
0347  4B80C800           [199] self       1   1   290  ; R2 := R1; R1 := R1["byte"]
034B  C1C00200           [200] loadk      3   11       ; R3 := 1
034F  01010300           [201] loadk      4   12       ; R4 := 2
0353  5C000002           [202] call       1   4   0    ; R1 to top := R1(R2 to R4)
0357  1C400000           [203] call       0   0   1    ;  := R0(R1 to top)
035B  05000000           [204] getglobal  0   0        ; R0 := print
035F  45C00500           [205] getglobal  1   23       ; R1 := string
0363  4600C600           [206] gettable   1   1   280  ; R1 := R1["len"]
0367  81000A00           [207] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
036B  5C000001           [208] call       1   2   0    ; R1 to top := R1(R2)
036F  1C400000           [209] call       0   0   1    ;  := R0(R1 to top)
0373  05000000           [210] getglobal  0   0        ; R0 := print
0377  45400A00           [211] getglobal  1   41       ; R1 := utf8
037B  4600C600           [212] gettable   1   1   280  ; R1 := R1["len"]
037F  81000A00           [213] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
0383  5C000001           [214] call       1   2   0    ; R1 to top := R1(R2)
0387  1C400000           [215] call       0   0   1    ;  := R0(R1 to top)
038B  05000000           [216] getglobal  0   0        ; R0 := print
038F  45400A00           [217] getglobal  1   41       ; R1 := utf8
0393  46C0C800           [218] gettable   1   1   291  ; R1 := R1["char"]
0397  81800A00           [219] loadk      2   42       ; R2 := 20320
039B  C1C00A00           [220] loadk      3   43       ; R3 := 22909
039F  5C008001           [221] call       1   3   0    ; R1 to top := R1(R2, R3)
03A3  1C400000           [222] call       0   0   1    ;  := R0(R1 to top)
03A7  05000000           [223] getglobal  0   0        ; R0 := print
03AB  41000B00           [224] loadk      1   44       ; R1 := "u{4f60}u{597d}"
03AF  1C400001           [225] call       0   2   1    ;  := R0(R1)
03B3  05000000           [226] getglobal  0   0        ; R0 := print
03B7  45400A00           [227] getglobal  1   41       ; R1 := utf8
03BB  4640CB00           [228] gettable   1   1   301  ; R1 := R1["offset"]
03BF  81000A00           [229] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03C3  C1000300           [230] loadk      3   12       ; R3 := 2
03C7  5C008001           [231] call       1   3   0    ; R1 to top := R1(R2, R3)
03CB  1C400000           [232] call       0   0   1    ;  := R0(R1 to top)
03CF  05000000           [233] getglobal  0   0        ; R0 := print
03D3  45400A00           [234] getglobal  1   41       ; R1 := utf8
03D7  4640CB00           [235] gettable   1   1   301  ; R1 := R1["offset"]
03DB  81000A00           [236] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03DF  C1C00300           [237] loadk      3   15       ; R3 := 5
03E3  5C008001           [238] call       1   3   0    ; R1 to top := R1(R2, R3)
03E7  1C400000           [239] call       0   0   1    ;  := R0(R1 to top)
03EB  05000000           [240] getglobal  0   0        ; R0 := print
03EF  45400A00           [241] getglobal  1   41       ; R1 := utf8
03F3  4680CB00           [242] gettable   1   1   302  ; R1 := R1["codepoint"]
03F7  81000A00           [243] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
03FB  C1800300           [244] loadk      3   14       ; R3 := 4
03FF  5C008001           [245] call       1   3   0    ; R1 to top := R1(R2, R3)
0403  1C400000           [246] call       0   0   1    ;  := R0(R1 to top)
0407  05000000           [247] getglobal  0   0        ; R0 := print
040B  45400A00           [248] getglobal  1   41       ; R1 := utf8
040F  4680CB00           [249] gettable   1   1   302  ; R1 := R1["codepoint"]
0413  81000A00           [250] loadk      2   40       ; R2 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
0417  C1C00B00           [251] loadk      3   47       ; R3 := 13
041B  5C008001           [252] call       1   3   0    ; R1 to top := R1(R2, R3)
041F  1C400000           [253] call       0   0   1    ;  := R0(R1 to top)
0423  05400A00           [254] getglobal  0   41       ; R0 := utf8
0427  06004C00           [255] gettable   0   0   304  ; R0 := R0["codes"]
042B  41000A00           [256] loadk      1   40       ; R1 := "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
042F  1C000101           [257] call       0   2   4    ; R0 to R2 := R0(R1)
0433  16C00080           [258] jmp        4            ; pc+=4 (goto [263])
0437  45010000           [259] getglobal  5   0        ; R5 := print
043B  80018001           [260] move       6   3        ; R6 := R3
043F  C0010002           [261] move       7   4        ; R7 := R4
0443  5C418001           [262] call       5   3   1    ;  := R5(R6, R7)
0447  21800000           [263] tforloop   0       2    ; R3, R4 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 265
044B  1640FE7F           [264] jmp        -6           ; pc+=-6 (goto [259])
044F  05000000           [265] getglobal  0   0        ; R0 := print
0453  45400C00           [266] getglobal  1   49       ; R1 := os
0457  4680CC00           [267] gettable   1   1   306  ; R1 := R1["time"]
045B  5C008000           [268] call       1   1   0    ; R1 to top := R1()
045F  1C400000           [269] call       0   0   1    ;  := R0(R1 to top)
0463  05000000           [270] getglobal  0   0        ; R0 := print
0467  45400C00           [271] getglobal  1   49       ; R1 := os
046B  4680CC00           [272] gettable   1   1   306  ; R1 := R1["time"]
046F  8A800100           [273] newtable   2   0   6    ; R2 := {} , array=0, hash=6
0473  8900CD99           [274] settable   2   307 308  ; R2["year"] := 2018
0477  8900C39A           [275] settable   2   309 268  ; R2["month"] := 2
047B  89C04D9B           [276] settable   2   310 311  ; R2["day"] := 14
047F  89404E9C           [277] settable   2   312 313  ; R2["hour"] := 12
0483  89C04E9D           [278] settable   2   314 315  ; R2["min"] := 30
0487  89C04E9E           [279] settable   2   316 315  ; R2["sec"] := 30
048B  5C000001           [280] call       1   2   0    ; R1 to top := R1(R2)
048F  1C400000           [281] call       0   0   1    ;  := R0(R1 to top)
0493  05000000           [282] getglobal  0   0        ; R0 := print
0497  45400C00           [283] getglobal  1   49       ; R1 := os
049B  4640CF00           [284] gettable   1   1   317  ; R1 := R1["date"]
049F  5C008000           [285] call       1   1   0    ; R1 to top := R1()
04A3  1C400000           [286] call       0   0   1    ;  := R0(R1 to top)
04A7  05400C00           [287] getglobal  0   49       ; R0 := os
04AB  06404F00           [288] gettable   0   0   317  ; R0 := R0["date"]
04AF  41800F00           [289] loadk      1   62       ; R1 := "*t"
04B3  81C00F00           [290] loadk      2   63       ; R2 := 1518582630
04B7  1C808001           [291] call       0   3   2    ; R0 := R0(R1, R2)
04BB  07000200           [292] setglobal  0   8        ; t := R0
04BF  05000000           [293] getglobal  0   0        ; R0 := print
04C3  45000200           [294] getglobal  1   8        ; R1 := t
04C7  46C0CC00           [295] gettable   1   1   307  ; R1 := R1["year"]
04CB  1C400001           [296] call       0   2   1    ;  := R0(R1)
04CF  05000000           [297] getglobal  0   0        ; R0 := print
04D3  45000200           [298] getglobal  1   8        ; R1 := t
04D7  4640CD00           [299] gettable   1   1   309  ; R1 := R1["month"]
04DB  1C400001           [300] call       0   2   1    ;  := R0(R1)
04DF  05000000           [301] getglobal  0   0        ; R0 := print
04E3  45000200           [302] getglobal  1   8        ; R1 := t
04E7  4680CD00           [303] gettable   1   1   310  ; R1 := R1["day"]
04EB  1C400001           [304] call       0   2   1    ;  := R0(R1)
04EF  05000000           [305] getglobal  0   0        ; R0 := print
04F3  45000200           [306] getglobal  1   8        ; R1 := t
04F7  4600CE00           [307] gettable   1   1   312  ; R1 := R1["hour"]
04FB  1C400001           [308] call       0   2   1    ;  := R0(R1)
04FF  05000000           [309] getglobal  0   0        ; R0 := print
0503  45000200           [310] getglobal  1   8        ; R1 := t
0507  4680CE00           [311] gettable   1   1   314  ; R1 := R1["min"]
050B  1C400001           [312] call       0   2   1    ;  := R0(R1)
050F  05000000           [313] getglobal  0   0        ; R0 := print
0513  45000200           [314] getglobal  1   8        ; R1 := t
0517  4600CF00           [315] gettable   1   1   316  ; R1 := R1["sec"]
051B  1C400001           [316] call       0   2   1    ;  := R0(R1)
051F  1E008000           [317] return     0   1        ; return 
                         * constants:
0523  40000000           sizek (64)
0527  04                 const type 4
0528  0600000000000000   string size (6)
0530  7072696E7400       "print\0"
                         const [0]: "print"
0536  04                 const type 4
0537  0500000000000000   string size (5)
053F  6D61746800         "math\0"
                         const [1]: "math"
0544  04                 const type 4
0545  0500000000000000   string size (5)
054D  7479706500         "type\0"
                         const [2]: "type"
0552  03                 const type 3
0553  0000000000005940   const [3]: (100)
055B  03                 const type 3
055C  1F85EB51B81E0940   const [4]: (3.14)
0564  04                 const type 4
0565  0400000000000000   string size (4)
056D  31303000           "100\0"
                         const [5]: "100"
0571  04                 const type 4
0572  0A00000000000000   string size (10)
057A  746F696E74656765+  "tointege"
0582  7200               "r\0"
                         const [6]: "tointeger"
0584  04                 const type 4
0585  0600000000000000   string size (6)
058D  3130302E3000       "100.0\0"
                         const [7]: "100.0"
0593  04                 const type 4
0594  0200000000000000   string size (2)
059C  7400               "t\0"
                         const [8]: "t"
059E  04                 const type 4
059F  0600000000000000   string size (6)
05A7  7461626C6500       "table\0"
                         const [9]: "table"
05AD  04                 const type 4
05AE  0500000000000000   string size (5)
05B6  7061636B00         "pack\0"
                         const [10]: "pack"
05BB  03                 const type 3
05BC  000000000000F03F   const [11]: (1)
05C4  03                 const type 3
05C5  0000000000000040   const [12]: (2)
05CD  03                 const type 3
05CE  0000000000000840   const [13]: (3)
05D6  03                 const type 3
05D7  0000000000001040   const [14]: (4)
05DF  03                 const type 3
05E0  0000000000001440   const [15]: (5)
05E8  04                 const type 4
05E9  0700000000000000   string size (7)
05F1  756E7061636B00     "unpack\0"
                         const [16]: "unpack"
05F8  04                 const type 4
05F9  0500000000000000   string size (5)
0601  6D6F766500         "move\0"
                         const [17]: "move"
0606  04                 const type 4
0607  0700000000000000   string size (7)
060F  696E7365727400     "insert\0"
                         const [18]: "insert"
0616  04                 const type 4
0617  0700000000000000   string size (7)
061F  72656D6F766500     "remove\0"
                         const [19]: "remove"
0626  04                 const type 4
0627  0500000000000000   string size (5)
062F  736F727400         "sort\0"
                         const [20]: "sort"
0634  04                 const type 4
0635  0700000000000000   string size (7)
063D  636F6E63617400     "concat\0"
                         const [21]: "concat"
0644  04                 const type 4
0645  0200000000000000   string size (2)
064D  2C00               ",\0"
                         const [22]: ","
064F  04                 const type 4
0650  0700000000000000   string size (7)
0658  737472696E6700     "string\0"
                         const [23]: "string"
065F  04                 const type 4
0660  0400000000000000   string size (4)
0668  6C656E00           "len\0"
                         const [24]: "len"
066C  04                 const type 4
066D  0400000000000000   string size (4)
0675  61626300           "abc\0"
                         const [25]: "abc"
0679  04                 const type 4
067A  0400000000000000   string size (4)
0682  72657000           "rep\0"
                         const [26]: "rep"
0686  04                 const type 4
0687  0200000000000000   string size (2)
068F  6100               "a\0"
                         const [27]: "a"
0691  04                 const type 4
0692  0800000000000000   string size (8)
069A  7265766572736500   "reverse\0"
                         const [28]: "reverse"
06A2  04                 const type 4
06A3  0600000000000000   string size (6)
06AB  6C6F77657200       "lower\0"
                         const [29]: "lower"
06B1  04                 const type 4
06B2  0400000000000000   string size (4)
06BA  41424300           "ABC\0"
                         const [30]: "ABC"
06BE  04                 const type 4
06BF  0600000000000000   string size (6)
06C7  757070657200       "upper\0"
                         const [31]: "upper"
06CD  04                 const type 4
06CE  0400000000000000   string size (4)
06D6  73756200           "sub\0"
                         const [32]: "sub"
06DA  04                 const type 4
06DB  0800000000000000   string size (8)
06E3  6162636465666700   "abcdefg\0"
                         const [33]: "abcdefg"
06EB  04                 const type 4
06EC  0500000000000000   string size (5)
06F4  6279746500         "byte\0"
                         const [34]: "byte"
06F9  04                 const type 4
06FA  0500000000000000   string size (5)
0702  6368617200         "char\0"
                         const [35]: "char"
0707  03                 const type 3
0708  0000000000C05840   const [36]: (99)
0710  03                 const type 3
0711  0000000000405940   const [37]: (101)
0719  04                 const type 4
071A  0200000000000000   string size (2)
0722  7300               "s\0"
                         const [38]: "s"
0724  04                 const type 4
0725  0400000000000000   string size (4)
072D  61426300           "aBc\0"
                         const [39]: "aBc"
0731  04                 const type 4
0732  1300000000000000   string size (19)
073A  E4BDA0E5A5BDEFBC+  "\228\189\160\229\165\189\239\188"
0742  8CE4B896E7958CEF+  "\140\228\184\150\231\149\140\239"
074A  BC8100             "\188\129\0"
                         const [40]: "\228\189\160\229\165\189\239\188\140\228\184\150\231\149\140\239\188\129"
074D  04                 const type 4
074E  0500000000000000   string size (5)
0756  7574663800         "utf8\0"
                         const [41]: "utf8"
075B  03                 const type 3
075C  0000000000D8D340   const [42]: (20320)
0764  03                 const type 3
0765  00000000405FD640   const [43]: (22909)
076D  04                 const type 4
076E  0F00000000000000   string size (15)
0776  757B346636307D75+  "u{4f60}u"
077E  7B353937647D00     "{597d}\0"
                         const [44]: "u{4f60}u{597d}"
0785  04                 const type 4
0786  0700000000000000   string size (7)
078E  6F666673657400     "offset\0"
                         const [45]: "offset"
0795  04                 const type 4
0796  0A00000000000000   string size (10)
079E  636F6465706F696E+  "codepoin"
07A6  7400               "t\0"
                         const [46]: "codepoint"
07A8  03                 const type 3
07A9  0000000000002A40   const [47]: (13)
07B1  04                 const type 4
07B2  0600000000000000   string size (6)
07BA  636F64657300       "codes\0"
                         const [48]: "codes"
07C0  04                 const type 4
07C1  0300000000000000   string size (3)
07C9  6F7300             "os\0"
                         const [49]: "os"
07CC  04                 const type 4
07CD  0500000000000000   string size (5)
07D5  74696D6500         "time\0"
                         const [50]: "time"
07DA  04                 const type 4
07DB  0500000000000000   string size (5)
07E3  7965617200         "year\0"
                         const [51]: "year"
07E8  03                 const type 3
07E9  0000000000889F40   const [52]: (2018)
07F1  04                 const type 4
07F2  0600000000000000   string size (6)
07FA  6D6F6E746800       "month\0"
                         const [53]: "month"
0800  04                 const type 4
0801  0400000000000000   string size (4)
0809  64617900           "day\0"
                         const [54]: "day"
080D  03                 const type 3
080E  0000000000002C40   const [55]: (14)
0816  04                 const type 4
0817  0500000000000000   string size (5)
081F  686F757200         "hour\0"
                         const [56]: "hour"
0824  03                 const type 3
0825  0000000000002840   const [57]: (12)
082D  04                 const type 4
082E  0400000000000000   string size (4)
0836  6D696E00           "min\0"
                         const [58]: "min"
083A  03                 const type 3
083B  0000000000003E40   const [59]: (30)
0843  04                 const type 4
0844  0400000000000000   string size (4)
084C  73656300           "sec\0"
                         const [60]: "sec"
0850  04                 const type 4
0851  0500000000000000   string size (5)
0859  6461746500         "date\0"
                         const [61]: "date"
085E  04                 const type 4
085F  0300000000000000   string size (3)
0867  2A7400             "*t\0"
                         const [62]: "*t"
086A  03                 const type 3
086B  000080D9EEA0D641   const [63]: (1518582630)
                         * functions:
0873  00000000           sizep (0)
                         * lines:
0877  3D010000           sizelineinfo (317)
                         [pc] (line)
087B  01000000           [001] (1)
087F  01000000           [002] (1)
0883  01000000           [003] (1)
0887  01000000           [004] (1)
088B  01000000           [005] (1)
088F  01000000           [006] (1)
0893  02000000           [007] (2)
0897  02000000           [008] (2)
089B  02000000           [009] (2)
089F  02000000           [010] (2)
08A3  02000000           [011] (2)
08A7  02000000           [012] (2)
08AB  03000000           [013] (3)
08AF  03000000           [014] (3)
08B3  03000000           [015] (3)
08B7  03000000           [016] (3)
08BB  03000000           [017] (3)
08BF  03000000           [018] (3)
08C3  04000000           [019] (4)
08C7  04000000           [020] (4)
08CB  04000000           [021] (4)
08CF  04000000           [022] (4)
08D3  04000000           [023] (4)
08D7  04000000           [024] (4)
08DB  05000000           [025] (5)
08DF  05000000           [026] (5)
08E3  05000000           [027] (5)
08E7  05000000           [028] (5)
08EB  05000000           [029] (5)
08EF  05000000           [030] (5)
08F3  06000000           [031] (6)
08F7  06000000           [032] (6)
08FB  06000000           [033] (6)
08FF  06000000           [034] (6)
0903  06000000           [035] (6)
0907  06000000           [036] (6)
090B  09000000           [037] (9)
090F  09000000           [038] (9)
0913  09000000           [039] (9)
0917  09000000           [040] (9)
091B  09000000           [041] (9)
091F  09000000           [042] (9)
0923  09000000           [043] (9)
0927  09000000           [044] (9)
092B  09000000           [045] (9)
092F  09000000           [046] (9)
0933  09000000           [047] (9)
0937  09000000           [048] (9)
093B  09000000           [049] (9)
093F  09000000           [050] (9)
0943  09000000           [051] (9)
0947  0A000000           [052] (10)
094B  0A000000           [053] (10)
094F  0A000000           [054] (10)
0953  0A000000           [055] (10)
0957  0A000000           [056] (10)
095B  0A000000           [057] (10)
095F  0A000000           [058] (10)
0963  0A000000           [059] (10)
0967  0A000000           [060] (10)
096B  0A000000           [061] (10)
096F  0A000000           [062] (10)
0973  0A000000           [063] (10)
0977  0A000000           [064] (10)
097B  0B000000           [065] (11)
097F  0B000000           [066] (11)
0983  0B000000           [067] (11)
0987  0B000000           [068] (11)
098B  0B000000           [069] (11)
098F  0B000000           [070] (11)
0993  0B000000           [071] (11)
0997  0B000000           [072] (11)
099B  0B000000           [073] (11)
099F  0B000000           [074] (11)
09A3  0B000000           [075] (11)
09A7  0B000000           [076] (11)
09AB  0C000000           [077] (12)
09AF  0C000000           [078] (12)
09B3  0C000000           [079] (12)
09B7  0C000000           [080] (12)
09BB  0C000000           [081] (12)
09BF  0C000000           [082] (12)
09C3  0C000000           [083] (12)
09C7  0C000000           [084] (12)
09CB  0C000000           [085] (12)
09CF  0C000000           [086] (12)
09D3  0C000000           [087] (12)
09D7  0D000000           [088] (13)
09DB  0D000000           [089] (13)
09DF  0D000000           [090] (13)
09E3  0D000000           [091] (13)
09E7  0D000000           [092] (13)
09EB  0D000000           [093] (13)
09EF  0D000000           [094] (13)
09F3  0D000000           [095] (13)
09F7  0D000000           [096] (13)
09FB  0D000000           [097] (13)
09FF  0E000000           [098] (14)
0A03  0E000000           [099] (14)
0A07  0E000000           [100] (14)
0A0B  0E000000           [101] (14)
0A0F  0E000000           [102] (14)
0A13  0E000000           [103] (14)
0A17  0E000000           [104] (14)
0A1B  11000000           [105] (17)
0A1F  11000000           [106] (17)
0A23  11000000           [107] (17)
0A27  11000000           [108] (17)
0A2B  11000000           [109] (17)
0A2F  11000000           [110] (17)
0A33  12000000           [111] (18)
0A37  12000000           [112] (18)
0A3B  12000000           [113] (18)
0A3F  12000000           [114] (18)
0A43  12000000           [115] (18)
0A47  12000000           [116] (18)
0A4B  12000000           [117] (18)
0A4F  12000000           [118] (18)
0A53  13000000           [119] (19)
0A57  13000000           [120] (19)
0A5B  13000000           [121] (19)
0A5F  13000000           [122] (19)
0A63  13000000           [123] (19)
0A67  13000000           [124] (19)
0A6B  14000000           [125] (20)
0A6F  14000000           [126] (20)
0A73  14000000           [127] (20)
0A77  14000000           [128] (20)
0A7B  14000000           [129] (20)
0A7F  14000000           [130] (20)
0A83  15000000           [131] (21)
0A87  15000000           [132] (21)
0A8B  15000000           [133] (21)
0A8F  15000000           [134] (21)
0A93  15000000           [135] (21)
0A97  15000000           [136] (21)
0A9B  16000000           [137] (22)
0A9F  16000000           [138] (22)
0AA3  16000000           [139] (22)
0AA7  16000000           [140] (22)
0AAB  16000000           [141] (22)
0AAF  16000000           [142] (22)
0AB3  16000000           [143] (22)
0AB7  16000000           [144] (22)
0ABB  17000000           [145] (23)
0ABF  17000000           [146] (23)
0AC3  17000000           [147] (23)
0AC7  17000000           [148] (23)
0ACB  17000000           [149] (23)
0ACF  17000000           [150] (23)
0AD3  17000000           [151] (23)
0AD7  17000000           [152] (23)
0ADB  18000000           [153] (24)
0ADF  18000000           [154] (24)
0AE3  18000000           [155] (24)
0AE7  18000000           [156] (24)
0AEB  18000000           [157] (24)
0AEF  18000000           [158] (24)
0AF3  18000000           [159] (24)
0AF7  18000000           [160] (24)
0AFB  1A000000           [161] (26)
0AFF  1A000000           [162] (26)
0B03  1B000000           [163] (27)
0B07  1B000000           [164] (27)
0B0B  1B000000           [165] (27)
0B0F  1B000000           [166] (27)
0B13  1B000000           [167] (27)
0B17  1C000000           [168] (28)
0B1B  1C000000           [169] (28)
0B1F  1C000000           [170] (28)
0B23  1C000000           [171] (28)
0B27  1C000000           [172] (28)
0B2B  1C000000           [173] (28)
0B2F  1C000000           [174] (28)
0B33  1D000000           [175] (29)
0B37  1D000000           [176] (29)
0B3B  1D000000           [177] (29)
0B3F  1D000000           [178] (29)
0B43  1D000000           [179] (29)
0B47  1E000000           [180] (30)
0B4B  1E000000           [181] (30)
0B4F  1E000000           [182] (30)
0B53  1E000000           [183] (30)
0B57  1E000000           [184] (30)
0B5B  1F000000           [185] (31)
0B5F  1F000000           [186] (31)
0B63  1F000000           [187] (31)
0B67  1F000000           [188] (31)
0B6B  1F000000           [189] (31)
0B6F  20000000           [190] (32)
0B73  20000000           [191] (32)
0B77  20000000           [192] (32)
0B7B  20000000           [193] (32)
0B7F  20000000           [194] (32)
0B83  20000000           [195] (32)
0B87  20000000           [196] (32)
0B8B  21000000           [197] (33)
0B8F  21000000           [198] (33)
0B93  21000000           [199] (33)
0B97  21000000           [200] (33)
0B9B  21000000           [201] (33)
0B9F  21000000           [202] (33)
0BA3  21000000           [203] (33)
0BA7  23000000           [204] (35)
0BAB  23000000           [205] (35)
0BAF  23000000           [206] (35)
0BB3  23000000           [207] (35)
0BB7  23000000           [208] (35)
0BBB  23000000           [209] (35)
0BBF  24000000           [210] (36)
0BC3  24000000           [211] (36)
0BC7  24000000           [212] (36)
0BCB  24000000           [213] (36)
0BCF  24000000           [214] (36)
0BD3  24000000           [215] (36)
0BD7  25000000           [216] (37)
0BDB  25000000           [217] (37)
0BDF  25000000           [218] (37)
0BE3  25000000           [219] (37)
0BE7  25000000           [220] (37)
0BEB  25000000           [221] (37)
0BEF  25000000           [222] (37)
0BF3  26000000           [223] (38)
0BF7  26000000           [224] (38)
0BFB  26000000           [225] (38)
0BFF  27000000           [226] (39)
0C03  27000000           [227] (39)
0C07  27000000           [228] (39)
0C0B  27000000           [229] (39)
0C0F  27000000           [230] (39)
0C13  27000000           [231] (39)
0C17  27000000           [232] (39)
0C1B  28000000           [233] (40)
0C1F  28000000           [234] (40)
0C23  28000000           [235] (40)
0C27  28000000           [236] (40)
0C2B  28000000           [237] (40)
0C2F  28000000           [238] (40)
0C33  28000000           [239] (40)
0C37  29000000           [240] (41)
0C3B  29000000           [241] (41)
0C3F  29000000           [242] (41)
0C43  29000000           [243] (41)
0C47  29000000           [244] (41)
0C4B  29000000           [245] (41)
0C4F  29000000           [246] (41)
0C53  2A000000           [247] (42)
0C57  2A000000           [248] (42)
0C5B  2A000000           [249] (42)
0C5F  2A000000           [250] (42)
0C63  2A000000           [251] (42)
0C67  2A000000           [252] (42)
0C6B  2A000000           [253] (42)
0C6F  2B000000           [254] (43)
0C73  2B000000           [255] (43)
0C77  2B000000           [256] (43)
0C7B  2B000000           [257] (43)
0C7F  2B000000           [258] (43)
0C83  2C000000           [259] (44)
0C87  2C000000           [260] (44)
0C8B  2C000000           [261] (44)
0C8F  2C000000           [262] (44)
0C93  2B000000           [263] (43)
0C97  2C000000           [264] (44)
0C9B  2F000000           [265] (47)
0C9F  2F000000           [266] (47)
0CA3  2F000000           [267] (47)
0CA7  2F000000           [268] (47)
0CAB  2F000000           [269] (47)
0CAF  30000000           [270] (48)
0CB3  30000000           [271] (48)
0CB7  30000000           [272] (48)
0CBB  30000000           [273] (48)
0CBF  30000000           [274] (48)
0CC3  30000000           [275] (48)
0CC7  30000000           [276] (48)
0CCB  31000000           [277] (49)
0CCF  31000000           [278] (49)
0CD3  31000000           [279] (49)
0CD7  30000000           [280] (48)
0CDB  30000000           [281] (48)
0CDF  33000000           [282] (51)
0CE3  33000000           [283] (51)
0CE7  33000000           [284] (51)
0CEB  33000000           [285] (51)
0CEF  33000000           [286] (51)
0CF3  34000000           [287] (52)
0CF7  34000000           [288] (52)
0CFB  34000000           [289] (52)
0CFF  34000000           [290] (52)
0D03  34000000           [291] (52)
0D07  34000000           [292] (52)
0D0B  35000000           [293] (53)
0D0F  35000000           [294] (53)
0D13  35000000           [295] (53)
0D17  35000000           [296] (53)
0D1B  36000000           [297] (54)
0D1F  36000000           [298] (54)
0D23  36000000           [299] (54)
0D27  36000000           [300] (54)
0D2B  37000000           [301] (55)
0D2F  37000000           [302] (55)
0D33  37000000           [303] (55)
0D37  37000000           [304] (55)
0D3B  38000000           [305] (56)
0D3F  38000000           [306] (56)
0D43  38000000           [307] (56)
0D47  38000000           [308] (56)
0D4B  39000000           [309] (57)
0D4F  39000000           [310] (57)
0D53  39000000           [311] (57)
0D57  39000000           [312] (57)
0D5B  3A000000           [313] (58)
0D5F  3A000000           [314] (58)
0D63  3A000000           [315] (58)
0D67  3A000000           [316] (58)
0D6B  3A000000           [317] (58)
                         * locals:
0D6F  05000000           sizelocvars (5)
0D73  1000000000000000   string size (16)
0D7B  28666F722067656E+  "(for gen"
0D83  657261746F722900   "erator)\0"
                         local [0]: (for generator)
0D8B  01010000             startpc (257)
0D8F  08010000             endpc   (264)
0D93  0C00000000000000   string size (12)
0D9B  28666F7220737461+  "(for sta"
0DA3  74652900           "te)\0"
                         local [1]: (for state)
0DA7  01010000             startpc (257)
0DAB  08010000             endpc   (264)
0DAF  0E00000000000000   string size (14)
0DB7  28666F7220636F6E+  "(for con"
0DBF  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0DC5  01010000             startpc (257)
0DC9  08010000             endpc   (264)
0DCD  0200000000000000   string size (2)
0DD5  7000               "p\0"
                         local [3]: p
0DD7  02010000             startpc (258)
0DDB  06010000             endpc   (262)
0DDF  0200000000000000   string size (2)
0DE7  6300               "c\0"
                         local [4]: c
0DE9  02010000             startpc (258)
0DED  06010000             endpc   (262)
                         * upvalues:
0DF1  00000000           sizeupvalues (0)
                         ** end of function 0 **

0DF5                     ** end of chunk **
