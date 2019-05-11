------------------------------
function div0(a, b)
  if b == 0 then
    error("DIV BY ZERO !")
  else
    return a / b
  end
end

function div1(a, b) return div0(a, b) end
function div2(a, b) return div1(a, b) end

ok, result = pcall(div2, 4, 2); print(ok, result)
ok, err = pcall(div2, 5, 0);    print(ok, err)
ok, err = pcall(div2, {}, {});  print(ok, err)
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "div0"  ; 0
.const  "div1"  ; 1
.const  "div2"  ; 2
.const  "ok"  ; 3
.const  "result"  ; 4
.const  "pcall"  ; 5
.const  4  ; 6
.const  2  ; 7
.const  "print"  ; 8
.const  "err"  ; 9
.const  5  ; 10
.const  0  ; 11
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; div0 := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; div1 := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   2        ; div2 := R0
[07] getglobal  0   5        ; R0 := pcall
[08] getglobal  1   2        ; R1 := div2
[09] loadk      2   6        ; R2 := 4
[10] loadk      3   7        ; R3 := 2
[11] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[12] setglobal  1   4        ; result := R1
[13] setglobal  0   3        ; ok := R0
[14] getglobal  0   8        ; R0 := print
[15] getglobal  1   3        ; R1 := ok
[16] getglobal  2   4        ; R2 := result
[17] call       0   3   1    ;  := R0(R1, R2)
[18] getglobal  0   5        ; R0 := pcall
[19] getglobal  1   2        ; R1 := div2
[20] loadk      2   10       ; R2 := 5
[21] loadk      3   11       ; R3 := 0
[22] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[23] setglobal  1   9        ; err := R1
[24] setglobal  0   3        ; ok := R0
[25] getglobal  0   8        ; R0 := print
[26] getglobal  1   3        ; R1 := ok
[27] getglobal  2   9        ; R2 := err
[28] call       0   3   1    ;  := R0(R1, R2)
[29] getglobal  0   5        ; R0 := pcall
[30] getglobal  1   2        ; R1 := div2
[31] newtable   2   0   0    ; R2 := {} , array=0, hash=0
[32] newtable   3   0   0    ; R3 := {} , array=0, hash=0
[33] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[34] setglobal  1   9        ; err := R1
[35] setglobal  0   3        ; ok := R0
[36] getglobal  0   8        ; R0 := print
[37] getglobal  1   3        ; R1 := ok
[38] getglobal  2   9        ; R2 := err
[39] call       0   3   1    ;  := R0(R1, R2)
[40] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "a"  ; 0
.local  "b"  ; 1
.const  0  ; 0
.const  "error"  ; 1
.const  "DIV BY ZERO !"  ; 2
[1] eq         0   1   256  ; R1 == 0, pc+=1 (goto [3]) if true
[2] jmp        4            ; pc+=4 (goto [7])
[3] getglobal  2   1        ; R2 := error
[4] loadk      3   2        ; R3 := "DIV BY ZERO !"
[5] call       2   2   1    ;  := R2(R3)
[6] jmp        2            ; pc+=2 (goto [9])
[7] div        2   0   1    ; R2 := R0 / R1
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  "div0"  ; 0
[1] getglobal  2   0        ; R2 := div0
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[5] return     2   0        ; return R2 to top
[6] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  "div1"  ; 0
[1] getglobal  2   0        ; R2 := div1
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[5] return     2   0        ; return R2 to top
[6] return     0   1        ; return 
; end of function 0_2

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "div0"  ; 0
.const  "div1"  ; 1
.const  "div2"  ; 2
.const  "ok"  ; 3
.const  "result"  ; 4
.const  "pcall"  ; 5
.const  4  ; 6
.const  2  ; 7
.const  "print"  ; 8
.const  "err"  ; 9
.const  5  ; 10
.const  0  ; 11
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; div0 := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   1        ; div1 := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   2        ; div2 := R0
[07] getglobal  0   5        ; R0 := pcall
[08] getglobal  1   2        ; R1 := div2
[09] loadk      2   6        ; R2 := 4
[10] loadk      3   7        ; R3 := 2
[11] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[12] setglobal  1   4        ; result := R1
[13] setglobal  0   3        ; ok := R0
[14] getglobal  0   8        ; R0 := print
[15] getglobal  1   3        ; R1 := ok
[16] getglobal  2   4        ; R2 := result
[17] call       0   3   1    ;  := R0(R1, R2)
[18] getglobal  0   5        ; R0 := pcall
[19] getglobal  1   2        ; R1 := div2
[20] loadk      2   10       ; R2 := 5
[21] loadk      3   11       ; R3 := 0
[22] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[23] setglobal  1   9        ; err := R1
[24] setglobal  0   3        ; ok := R0
[25] getglobal  0   8        ; R0 := print
[26] getglobal  1   3        ; R1 := ok
[27] getglobal  2   9        ; R2 := err
[28] call       0   3   1    ;  := R0(R1, R2)
[29] getglobal  0   5        ; R0 := pcall
[30] getglobal  1   2        ; R1 := div2
[31] newtable   2   0   0    ; R2 := {} , array=0, hash=0
[32] newtable   3   0   0    ; R3 := {} , array=0, hash=0
[33] call       0   4   3    ; R0, R1 := R0(R1 to R3)
[34] setglobal  1   9        ; err := R1
[35] setglobal  0   3        ; ok := R0
[36] getglobal  0   8        ; R0 := print
[37] getglobal  1   3        ; R1 := ok
[38] getglobal  2   9        ; R2 := err
[39] call       0   3   1    ;  := R0(R1, R2)
[40] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "a"  ; 0
.local  "b"  ; 1
.const  0  ; 0
.const  "error"  ; 1
.const  "DIV BY ZERO !"  ; 2
[1] eq         0   1   256  ; R1 == 0, pc+=1 (goto [3]) if true
[2] jmp        4            ; pc+=4 (goto [7])
[3] getglobal  2   1        ; R2 := error
[4] loadk      3   2        ; R3 := "DIV BY ZERO !"
[5] call       2   2   1    ;  := R2(R3)
[6] jmp        2            ; pc+=2 (goto [9])
[7] div        2   0   1    ; R2 := R0 / R1
[8] return     2   2        ; return R2
[9] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  "div0"  ; 0
[1] getglobal  2   0        ; R2 := div0
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[5] return     2   0        ; return R2 to top
[6] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 2 params, is_vararg = 0, 5 stacks
.function  0 2 0 5
.local  "a"  ; 0
.local  "b"  ; 1
.const  "div1"  ; 0
[1] getglobal  2   0        ; R2 := div1
[2] move       3   0        ; R3 := R0
[3] move       4   1        ; R4 := R1
[4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
[5] return     2   0        ; return R2 to top
[6] return     0   1        ; return 
; end of function 0_2

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
002A  04                 maxstacksize (4)
                         * code:
002B  28000000           sizecode (40)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; div0 := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; div1 := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [06] setglobal  0   2        ; div2 := R0
0047  05400100           [07] getglobal  0   5        ; R0 := pcall
004B  45800000           [08] getglobal  1   2        ; R1 := div2
004F  81800100           [09] loadk      2   6        ; R2 := 4
0053  C1C00100           [10] loadk      3   7        ; R3 := 2
0057  1CC00002           [11] call       0   4   3    ; R0, R1 := R0(R1 to R3)
005B  47000100           [12] setglobal  1   4        ; result := R1
005F  07C00000           [13] setglobal  0   3        ; ok := R0
0063  05000200           [14] getglobal  0   8        ; R0 := print
0067  45C00000           [15] getglobal  1   3        ; R1 := ok
006B  85000100           [16] getglobal  2   4        ; R2 := result
006F  1C408001           [17] call       0   3   1    ;  := R0(R1, R2)
0073  05400100           [18] getglobal  0   5        ; R0 := pcall
0077  45800000           [19] getglobal  1   2        ; R1 := div2
007B  81800200           [20] loadk      2   10       ; R2 := 5
007F  C1C00200           [21] loadk      3   11       ; R3 := 0
0083  1CC00002           [22] call       0   4   3    ; R0, R1 := R0(R1 to R3)
0087  47400200           [23] setglobal  1   9        ; err := R1
008B  07C00000           [24] setglobal  0   3        ; ok := R0
008F  05000200           [25] getglobal  0   8        ; R0 := print
0093  45C00000           [26] getglobal  1   3        ; R1 := ok
0097  85400200           [27] getglobal  2   9        ; R2 := err
009B  1C408001           [28] call       0   3   1    ;  := R0(R1, R2)
009F  05400100           [29] getglobal  0   5        ; R0 := pcall
00A3  45800000           [30] getglobal  1   2        ; R1 := div2
00A7  8A000000           [31] newtable   2   0   0    ; R2 := {} , array=0, hash=0
00AB  CA000000           [32] newtable   3   0   0    ; R3 := {} , array=0, hash=0
00AF  1CC00002           [33] call       0   4   3    ; R0, R1 := R0(R1 to R3)
00B3  47400200           [34] setglobal  1   9        ; err := R1
00B7  07C00000           [35] setglobal  0   3        ; ok := R0
00BB  05000200           [36] getglobal  0   8        ; R0 := print
00BF  45C00000           [37] getglobal  1   3        ; R1 := ok
00C3  85400200           [38] getglobal  2   9        ; R2 := err
00C7  1C408001           [39] call       0   3   1    ;  := R0(R1, R2)
00CB  1E008000           [40] return     0   1        ; return 
                         * constants:
00CF  0C000000           sizek (12)
00D3  04                 const type 4
00D4  0500000000000000   string size (5)
00DC  6469763000         "div0\0"
                         const [0]: "div0"
00E1  04                 const type 4
00E2  0500000000000000   string size (5)
00EA  6469763100         "div1\0"
                         const [1]: "div1"
00EF  04                 const type 4
00F0  0500000000000000   string size (5)
00F8  6469763200         "div2\0"
                         const [2]: "div2"
00FD  04                 const type 4
00FE  0300000000000000   string size (3)
0106  6F6B00             "ok\0"
                         const [3]: "ok"
0109  04                 const type 4
010A  0700000000000000   string size (7)
0112  726573756C7400     "result\0"
                         const [4]: "result"
0119  04                 const type 4
011A  0600000000000000   string size (6)
0122  7063616C6C00       "pcall\0"
                         const [5]: "pcall"
0128  03                 const type 3
0129  0000000000001040   const [6]: (4)
0131  03                 const type 3
0132  0000000000000040   const [7]: (2)
013A  04                 const type 4
013B  0600000000000000   string size (6)
0143  7072696E7400       "print\0"
                         const [8]: "print"
0149  04                 const type 4
014A  0400000000000000   string size (4)
0152  65727200           "err\0"
                         const [9]: "err"
0156  03                 const type 3
0157  0000000000001440   const [10]: (5)
015F  03                 const type 3
0160  0000000000000000   const [11]: (0)
                         * functions:
0168  03000000           sizep (3)
                         
016C                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
016C  0000000000000000   string size (0)
                         source name: (none)
0174  01000000           line defined (1)
0178  07000000           last line defined (7)
017C  00                 nups (0)
017D  02                 numparams (2)
017E  00                 is_vararg (0)
017F  04                 maxstacksize (4)
                         * code:
0180  09000000           sizecode (9)
0184  1700C000           [1] eq         0   1   256  ; R1 == 0, pc+=1 (goto [3]) if true
0188  16C00080           [2] jmp        4            ; pc+=4 (goto [7])
018C  85400000           [3] getglobal  2   1        ; R2 := error
0190  C1800000           [4] loadk      3   2        ; R3 := "DIV BY ZERO !"
0194  9C400001           [5] call       2   2   1    ;  := R2(R3)
0198  16400080           [6] jmp        2            ; pc+=2 (goto [9])
019C  8F400000           [7] div        2   0   1    ; R2 := R0 / R1
01A0  9E000001           [8] return     2   2        ; return R2
01A4  1E008000           [9] return     0   1        ; return 
                         * constants:
01A8  03000000           sizek (3)
01AC  03                 const type 3
01AD  0000000000000000   const [0]: (0)
01B5  04                 const type 4
01B6  0600000000000000   string size (6)
01BE  6572726F7200       "error\0"
                         const [1]: "error"
01C4  04                 const type 4
01C5  0E00000000000000   string size (14)
01CD  444956204259205A+  "DIV BY Z"
01D5  45524F202100       "ERO !\0"
                         const [2]: "DIV BY ZERO !"
                         * functions:
01DB  00000000           sizep (0)
                         * lines:
01DF  09000000           sizelineinfo (9)
                         [pc] (line)
01E3  02000000           [1] (2)
01E7  02000000           [2] (2)
01EB  03000000           [3] (3)
01EF  03000000           [4] (3)
01F3  03000000           [5] (3)
01F7  03000000           [6] (3)
01FB  05000000           [7] (5)
01FF  05000000           [8] (5)
0203  07000000           [9] (7)
                         * locals:
0207  02000000           sizelocvars (2)
020B  0200000000000000   string size (2)
0213  6100               "a\0"
                         local [0]: a
0215  00000000             startpc (0)
0219  08000000             endpc   (8)
021D  0200000000000000   string size (2)
0225  6200               "b\0"
                         local [1]: b
0227  00000000             startpc (0)
022B  08000000             endpc   (8)
                         * upvalues:
022F  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0233                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0233  0000000000000000   string size (0)
                         source name: (none)
023B  09000000           line defined (9)
023F  09000000           last line defined (9)
0243  00                 nups (0)
0244  02                 numparams (2)
0245  00                 is_vararg (0)
0246  05                 maxstacksize (5)
                         * code:
0247  06000000           sizecode (6)
024B  85000000           [1] getglobal  2   0        ; R2 := div0
024F  C0000000           [2] move       3   0        ; R3 := R0
0253  00018000           [3] move       4   1        ; R4 := R1
0257  9D008001           [4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
025B  9E000000           [5] return     2   0        ; return R2 to top
025F  1E008000           [6] return     0   1        ; return 
                         * constants:
0263  01000000           sizek (1)
0267  04                 const type 4
0268  0500000000000000   string size (5)
0270  6469763000         "div0\0"
                         const [0]: "div0"
                         * functions:
0275  00000000           sizep (0)
                         * lines:
0279  06000000           sizelineinfo (6)
                         [pc] (line)
027D  09000000           [1] (9)
0281  09000000           [2] (9)
0285  09000000           [3] (9)
0289  09000000           [4] (9)
028D  09000000           [5] (9)
0291  09000000           [6] (9)
                         * locals:
0295  02000000           sizelocvars (2)
0299  0200000000000000   string size (2)
02A1  6100               "a\0"
                         local [0]: a
02A3  00000000             startpc (0)
02A7  05000000             endpc   (5)
02AB  0200000000000000   string size (2)
02B3  6200               "b\0"
                         local [1]: b
02B5  00000000             startpc (0)
02B9  05000000             endpc   (5)
                         * upvalues:
02BD  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
02C1                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
02C1  0000000000000000   string size (0)
                         source name: (none)
02C9  0A000000           line defined (10)
02CD  0A000000           last line defined (10)
02D1  00                 nups (0)
02D2  02                 numparams (2)
02D3  00                 is_vararg (0)
02D4  05                 maxstacksize (5)
                         * code:
02D5  06000000           sizecode (6)
02D9  85000000           [1] getglobal  2   0        ; R2 := div1
02DD  C0000000           [2] move       3   0        ; R3 := R0
02E1  00018000           [3] move       4   1        ; R4 := R1
02E5  9D008001           [4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
02E9  9E000000           [5] return     2   0        ; return R2 to top
02ED  1E008000           [6] return     0   1        ; return 
                         * constants:
02F1  01000000           sizek (1)
02F5  04                 const type 4
02F6  0500000000000000   string size (5)
02FE  6469763100         "div1\0"
                         const [0]: "div1"
                         * functions:
0303  00000000           sizep (0)
                         * lines:
0307  06000000           sizelineinfo (6)
                         [pc] (line)
030B  0A000000           [1] (10)
030F  0A000000           [2] (10)
0313  0A000000           [3] (10)
0317  0A000000           [4] (10)
031B  0A000000           [5] (10)
031F  0A000000           [6] (10)
                         * locals:
0323  02000000           sizelocvars (2)
0327  0200000000000000   string size (2)
032F  6100               "a\0"
                         local [0]: a
0331  00000000             startpc (0)
0335  05000000             endpc   (5)
0339  0200000000000000   string size (2)
0341  6200               "b\0"
                         local [1]: b
0343  00000000             startpc (0)
0347  05000000             endpc   (5)
                         * upvalues:
034B  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         * lines:
034F  28000000           sizelineinfo (40)
                         [pc] (line)
0353  07000000           [01] (7)
0357  01000000           [02] (1)
035B  09000000           [03] (9)
035F  09000000           [04] (9)
0363  0A000000           [05] (10)
0367  0A000000           [06] (10)
036B  0C000000           [07] (12)
036F  0C000000           [08] (12)
0373  0C000000           [09] (12)
0377  0C000000           [10] (12)
037B  0C000000           [11] (12)
037F  0C000000           [12] (12)
0383  0C000000           [13] (12)
0387  0C000000           [14] (12)
038B  0C000000           [15] (12)
038F  0C000000           [16] (12)
0393  0C000000           [17] (12)
0397  0D000000           [18] (13)
039B  0D000000           [19] (13)
039F  0D000000           [20] (13)
03A3  0D000000           [21] (13)
03A7  0D000000           [22] (13)
03AB  0D000000           [23] (13)
03AF  0D000000           [24] (13)
03B3  0D000000           [25] (13)
03B7  0D000000           [26] (13)
03BB  0D000000           [27] (13)
03BF  0D000000           [28] (13)
03C3  0E000000           [29] (14)
03C7  0E000000           [30] (14)
03CB  0E000000           [31] (14)
03CF  0E000000           [32] (14)
03D3  0E000000           [33] (14)
03D7  0E000000           [34] (14)
03DB  0E000000           [35] (14)
03DF  0E000000           [36] (14)
03E3  0E000000           [37] (14)
03E7  0E000000           [38] (14)
03EB  0E000000           [39] (14)
03EF  0E000000           [40] (14)
                         * locals:
03F3  00000000           sizelocvars (0)
                         * upvalues:
03F7  00000000           sizeupvalues (0)
                         ** end of function 0 **

03FB                     ** end of chunk **
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
002A  04                 maxstacksize (4)
                         * code:
002B  28000000           sizecode (40)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; div0 := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07400000           [04] setglobal  0   1        ; div1 := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07800000           [06] setglobal  0   2        ; div2 := R0
0047  05400100           [07] getglobal  0   5        ; R0 := pcall
004B  45800000           [08] getglobal  1   2        ; R1 := div2
004F  81800100           [09] loadk      2   6        ; R2 := 4
0053  C1C00100           [10] loadk      3   7        ; R3 := 2
0057  1CC00002           [11] call       0   4   3    ; R0, R1 := R0(R1 to R3)
005B  47000100           [12] setglobal  1   4        ; result := R1
005F  07C00000           [13] setglobal  0   3        ; ok := R0
0063  05000200           [14] getglobal  0   8        ; R0 := print
0067  45C00000           [15] getglobal  1   3        ; R1 := ok
006B  85000100           [16] getglobal  2   4        ; R2 := result
006F  1C408001           [17] call       0   3   1    ;  := R0(R1, R2)
0073  05400100           [18] getglobal  0   5        ; R0 := pcall
0077  45800000           [19] getglobal  1   2        ; R1 := div2
007B  81800200           [20] loadk      2   10       ; R2 := 5
007F  C1C00200           [21] loadk      3   11       ; R3 := 0
0083  1CC00002           [22] call       0   4   3    ; R0, R1 := R0(R1 to R3)
0087  47400200           [23] setglobal  1   9        ; err := R1
008B  07C00000           [24] setglobal  0   3        ; ok := R0
008F  05000200           [25] getglobal  0   8        ; R0 := print
0093  45C00000           [26] getglobal  1   3        ; R1 := ok
0097  85400200           [27] getglobal  2   9        ; R2 := err
009B  1C408001           [28] call       0   3   1    ;  := R0(R1, R2)
009F  05400100           [29] getglobal  0   5        ; R0 := pcall
00A3  45800000           [30] getglobal  1   2        ; R1 := div2
00A7  8A000000           [31] newtable   2   0   0    ; R2 := {} , array=0, hash=0
00AB  CA000000           [32] newtable   3   0   0    ; R3 := {} , array=0, hash=0
00AF  1CC00002           [33] call       0   4   3    ; R0, R1 := R0(R1 to R3)
00B3  47400200           [34] setglobal  1   9        ; err := R1
00B7  07C00000           [35] setglobal  0   3        ; ok := R0
00BB  05000200           [36] getglobal  0   8        ; R0 := print
00BF  45C00000           [37] getglobal  1   3        ; R1 := ok
00C3  85400200           [38] getglobal  2   9        ; R2 := err
00C7  1C408001           [39] call       0   3   1    ;  := R0(R1, R2)
00CB  1E008000           [40] return     0   1        ; return 
                         * constants:
00CF  0C000000           sizek (12)
00D3  04                 const type 4
00D4  0500000000000000   string size (5)
00DC  6469763000         "div0\0"
                         const [0]: "div0"
00E1  04                 const type 4
00E2  0500000000000000   string size (5)
00EA  6469763100         "div1\0"
                         const [1]: "div1"
00EF  04                 const type 4
00F0  0500000000000000   string size (5)
00F8  6469763200         "div2\0"
                         const [2]: "div2"
00FD  04                 const type 4
00FE  0300000000000000   string size (3)
0106  6F6B00             "ok\0"
                         const [3]: "ok"
0109  04                 const type 4
010A  0700000000000000   string size (7)
0112  726573756C7400     "result\0"
                         const [4]: "result"
0119  04                 const type 4
011A  0600000000000000   string size (6)
0122  7063616C6C00       "pcall\0"
                         const [5]: "pcall"
0128  03                 const type 3
0129  0000000000001040   const [6]: (4)
0131  03                 const type 3
0132  0000000000000040   const [7]: (2)
013A  04                 const type 4
013B  0600000000000000   string size (6)
0143  7072696E7400       "print\0"
                         const [8]: "print"
0149  04                 const type 4
014A  0400000000000000   string size (4)
0152  65727200           "err\0"
                         const [9]: "err"
0156  03                 const type 3
0157  0000000000001440   const [10]: (5)
015F  03                 const type 3
0160  0000000000000000   const [11]: (0)
                         * functions:
0168  03000000           sizep (3)
                         
016C                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
016C  0000000000000000   string size (0)
                         source name: (none)
0174  01000000           line defined (1)
0178  07000000           last line defined (7)
017C  00                 nups (0)
017D  02                 numparams (2)
017E  00                 is_vararg (0)
017F  04                 maxstacksize (4)
                         * code:
0180  09000000           sizecode (9)
0184  1700C000           [1] eq         0   1   256  ; R1 == 0, pc+=1 (goto [3]) if true
0188  16C00080           [2] jmp        4            ; pc+=4 (goto [7])
018C  85400000           [3] getglobal  2   1        ; R2 := error
0190  C1800000           [4] loadk      3   2        ; R3 := "DIV BY ZERO !"
0194  9C400001           [5] call       2   2   1    ;  := R2(R3)
0198  16400080           [6] jmp        2            ; pc+=2 (goto [9])
019C  8F400000           [7] div        2   0   1    ; R2 := R0 / R1
01A0  9E000001           [8] return     2   2        ; return R2
01A4  1E008000           [9] return     0   1        ; return 
                         * constants:
01A8  03000000           sizek (3)
01AC  03                 const type 3
01AD  0000000000000000   const [0]: (0)
01B5  04                 const type 4
01B6  0600000000000000   string size (6)
01BE  6572726F7200       "error\0"
                         const [1]: "error"
01C4  04                 const type 4
01C5  0E00000000000000   string size (14)
01CD  444956204259205A+  "DIV BY Z"
01D5  45524F202100       "ERO !\0"
                         const [2]: "DIV BY ZERO !"
                         * functions:
01DB  00000000           sizep (0)
                         * lines:
01DF  09000000           sizelineinfo (9)
                         [pc] (line)
01E3  02000000           [1] (2)
01E7  02000000           [2] (2)
01EB  03000000           [3] (3)
01EF  03000000           [4] (3)
01F3  03000000           [5] (3)
01F7  03000000           [6] (3)
01FB  05000000           [7] (5)
01FF  05000000           [8] (5)
0203  07000000           [9] (7)
                         * locals:
0207  02000000           sizelocvars (2)
020B  0200000000000000   string size (2)
0213  6100               "a\0"
                         local [0]: a
0215  00000000             startpc (0)
0219  08000000             endpc   (8)
021D  0200000000000000   string size (2)
0225  6200               "b\0"
                         local [1]: b
0227  00000000             startpc (0)
022B  08000000             endpc   (8)
                         * upvalues:
022F  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0233                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0233  0000000000000000   string size (0)
                         source name: (none)
023B  09000000           line defined (9)
023F  09000000           last line defined (9)
0243  00                 nups (0)
0244  02                 numparams (2)
0245  00                 is_vararg (0)
0246  05                 maxstacksize (5)
                         * code:
0247  06000000           sizecode (6)
024B  85000000           [1] getglobal  2   0        ; R2 := div0
024F  C0000000           [2] move       3   0        ; R3 := R0
0253  00018000           [3] move       4   1        ; R4 := R1
0257  9D008001           [4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
025B  9E000000           [5] return     2   0        ; return R2 to top
025F  1E008000           [6] return     0   1        ; return 
                         * constants:
0263  01000000           sizek (1)
0267  04                 const type 4
0268  0500000000000000   string size (5)
0270  6469763000         "div0\0"
                         const [0]: "div0"
                         * functions:
0275  00000000           sizep (0)
                         * lines:
0279  06000000           sizelineinfo (6)
                         [pc] (line)
027D  09000000           [1] (9)
0281  09000000           [2] (9)
0285  09000000           [3] (9)
0289  09000000           [4] (9)
028D  09000000           [5] (9)
0291  09000000           [6] (9)
                         * locals:
0295  02000000           sizelocvars (2)
0299  0200000000000000   string size (2)
02A1  6100               "a\0"
                         local [0]: a
02A3  00000000             startpc (0)
02A7  05000000             endpc   (5)
02AB  0200000000000000   string size (2)
02B3  6200               "b\0"
                         local [1]: b
02B5  00000000             startpc (0)
02B9  05000000             endpc   (5)
                         * upvalues:
02BD  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
02C1                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
02C1  0000000000000000   string size (0)
                         source name: (none)
02C9  0A000000           line defined (10)
02CD  0A000000           last line defined (10)
02D1  00                 nups (0)
02D2  02                 numparams (2)
02D3  00                 is_vararg (0)
02D4  05                 maxstacksize (5)
                         * code:
02D5  06000000           sizecode (6)
02D9  85000000           [1] getglobal  2   0        ; R2 := div1
02DD  C0000000           [2] move       3   0        ; R3 := R0
02E1  00018000           [3] move       4   1        ; R4 := R1
02E5  9D008001           [4] tailcall   2   3   0    ; R2 to top := R2(R3, R4)
02E9  9E000000           [5] return     2   0        ; return R2 to top
02ED  1E008000           [6] return     0   1        ; return 
                         * constants:
02F1  01000000           sizek (1)
02F5  04                 const type 4
02F6  0500000000000000   string size (5)
02FE  6469763100         "div1\0"
                         const [0]: "div1"
                         * functions:
0303  00000000           sizep (0)
                         * lines:
0307  06000000           sizelineinfo (6)
                         [pc] (line)
030B  0A000000           [1] (10)
030F  0A000000           [2] (10)
0313  0A000000           [3] (10)
0317  0A000000           [4] (10)
031B  0A000000           [5] (10)
031F  0A000000           [6] (10)
                         * locals:
0323  02000000           sizelocvars (2)
0327  0200000000000000   string size (2)
032F  6100               "a\0"
                         local [0]: a
0331  00000000             startpc (0)
0335  05000000             endpc   (5)
0339  0200000000000000   string size (2)
0341  6200               "b\0"
                         local [1]: b
0343  00000000             startpc (0)
0347  05000000             endpc   (5)
                         * upvalues:
034B  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         * lines:
034F  28000000           sizelineinfo (40)
                         [pc] (line)
0353  07000000           [01] (7)
0357  01000000           [02] (1)
035B  09000000           [03] (9)
035F  09000000           [04] (9)
0363  0A000000           [05] (10)
0367  0A000000           [06] (10)
036B  0C000000           [07] (12)
036F  0C000000           [08] (12)
0373  0C000000           [09] (12)
0377  0C000000           [10] (12)
037B  0C000000           [11] (12)
037F  0C000000           [12] (12)
0383  0C000000           [13] (12)
0387  0C000000           [14] (12)
038B  0C000000           [15] (12)
038F  0C000000           [16] (12)
0393  0C000000           [17] (12)
0397  0D000000           [18] (13)
039B  0D000000           [19] (13)
039F  0D000000           [20] (13)
03A3  0D000000           [21] (13)
03A7  0D000000           [22] (13)
03AB  0D000000           [23] (13)
03AF  0D000000           [24] (13)
03B3  0D000000           [25] (13)
03B7  0D000000           [26] (13)
03BB  0D000000           [27] (13)
03BF  0D000000           [28] (13)
03C3  0E000000           [29] (14)
03C7  0E000000           [30] (14)
03CB  0E000000           [31] (14)
03CF  0E000000           [32] (14)
03D3  0E000000           [33] (14)
03D7  0E000000           [34] (14)
03DB  0E000000           [35] (14)
03DF  0E000000           [36] (14)
03E3  0E000000           [37] (14)
03E7  0E000000           [38] (14)
03EB  0E000000           [39] (14)
03EF  0E000000           [40] (14)
                         * locals:
03F3  00000000           sizelocvars (0)
                         * upvalues:
03F7  00000000           sizeupvalues (0)
                         ** end of function 0 **

03FB                     ** end of chunk **
