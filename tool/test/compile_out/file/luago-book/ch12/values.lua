------------------------------
-- PiL ch18
function values(t)
  local i = 0
  return function ()
    i = i + 1; return t[i]
  end
end

t = {10, 20, 30}
for v in values(t) do
  print(v)
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "v"  ; 3
.const  "values"  ; 0
.const  "t"  ; 1
.const  10  ; 2
.const  20  ; 3
.const  30  ; 4
.const  "print"  ; 5
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; values := R0
[03] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[04] loadk      1   2        ; R1 := 10
[05] loadk      2   3        ; R2 := 20
[06] loadk      3   4        ; R3 := 30
[07] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[08] setglobal  0   1        ; t := R0
[09] getglobal  0   0        ; R0 := values
[10] getglobal  1   1        ; R1 := t
[11] call       0   2   4    ; R0 to R2 := R0(R1)
[12] jmp        3            ; pc+=3 (goto [16])
[13] getglobal  4   5        ; R4 := print
[14] move       5   3        ; R5 := R3
[15] call       4   2   1    ;  := R4(R5)
[16] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 18
[17] jmp        -5           ; pc+=-5 (goto [13])
[18] return     0   1        ; return 

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
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "i"  ; 0
.upvalue  "t"  ; 1
.const  1  ; 0
[1] getupval   0   0        ; R0 := U0 , i
[2] add        0   0   256  ; R0 := R0 + 1
[3] setupval   0   0        ; U0 := R0 , i
[4] getupval   0   1        ; R0 := U1 , t
[5] getupval   1   0        ; R1 := U0 , i
[6] gettable   0   0   1    ; R0 := R0[R1]
[7] return     0   2        ; return R0
[8] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 6 stacks
.function  0 0 2 6
.local  "(for generator)"  ; 0
.local  "(for state)"  ; 1
.local  "(for control)"  ; 2
.local  "v"  ; 3
.const  "values"  ; 0
.const  "t"  ; 1
.const  10  ; 2
.const  20  ; 3
.const  30  ; 4
.const  "print"  ; 5
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; values := R0
[03] newtable   0   3   0    ; R0 := {} , array=3, hash=0
[04] loadk      1   2        ; R1 := 10
[05] loadk      2   3        ; R2 := 20
[06] loadk      3   4        ; R3 := 30
[07] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
[08] setglobal  0   1        ; t := R0
[09] getglobal  0   0        ; R0 := values
[10] getglobal  1   1        ; R1 := t
[11] call       0   2   4    ; R0 to R2 := R0(R1)
[12] jmp        3            ; pc+=3 (goto [16])
[13] getglobal  4   5        ; R4 := print
[14] move       5   3        ; R5 := R3
[15] call       4   2   1    ;  := R4(R5)
[16] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 18
[17] jmp        -5           ; pc+=-5 (goto [13])
[18] return     0   1        ; return 

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
; 2 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  2 0 0 2
.upvalue  "i"  ; 0
.upvalue  "t"  ; 1
.const  1  ; 0
[1] getupval   0   0        ; R0 := U0 , i
[2] add        0   0   256  ; R0 := R0 + 1
[3] setupval   0   0        ; U0 := R0 , i
[4] getupval   0   1        ; R0 := U1 , t
[5] getupval   1   0        ; R1 := U0 , i
[6] gettable   0   0   1    ; R0 := R0[R1]
[7] return     0   2        ; return R0
[8] return     0   1        ; return 
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
002A  06                 maxstacksize (6)
                         * code:
002B  12000000           sizecode (18)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; values := R0
0037  0A008001           [03] newtable   0   3   0    ; R0 := {} , array=3, hash=0
003B  41800000           [04] loadk      1   2        ; R1 := 10
003F  81C00000           [05] loadk      2   3        ; R2 := 20
0043  C1000100           [06] loadk      3   4        ; R3 := 30
0047  22408001           [07] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
004B  07400000           [08] setglobal  0   1        ; t := R0
004F  05000000           [09] getglobal  0   0        ; R0 := values
0053  45400000           [10] getglobal  1   1        ; R1 := t
0057  1C000101           [11] call       0   2   4    ; R0 to R2 := R0(R1)
005B  16800080           [12] jmp        3            ; pc+=3 (goto [16])
005F  05410100           [13] getglobal  4   5        ; R4 := print
0063  40018001           [14] move       5   3        ; R5 := R3
0067  1C410001           [15] call       4   2   1    ;  := R4(R5)
006B  21400000           [16] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 18
006F  1680FE7F           [17] jmp        -5           ; pc+=-5 (goto [13])
0073  1E008000           [18] return     0   1        ; return 
                         * constants:
0077  06000000           sizek (6)
007B  04                 const type 4
007C  0700000000000000   string size (7)
0084  76616C75657300     "values\0"
                         const [0]: "values"
008B  04                 const type 4
008C  0200000000000000   string size (2)
0094  7400               "t\0"
                         const [1]: "t"
0096  03                 const type 3
0097  0000000000002440   const [2]: (10)
009F  03                 const type 3
00A0  0000000000003440   const [3]: (20)
00A8  03                 const type 3
00A9  0000000000003E40   const [4]: (30)
00B1  04                 const type 4
00B2  0600000000000000   string size (6)
00BA  7072696E7400       "print\0"
                         const [5]: "print"
                         * functions:
00C0  01000000           sizep (1)
                         
00C4                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00C4  0000000000000000   string size (0)
                         source name: (none)
00CC  02000000           line defined (2)
00D0  07000000           last line defined (7)
00D4  00                 nups (0)
00D5  01                 numparams (1)
00D6  00                 is_vararg (0)
00D7  03                 maxstacksize (3)
                         * code:
00D8  06000000           sizecode (6)
00DC  41000000           [1] loadk      1   0        ; R1 := 0
00E0  A4000000           [2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
00E4  00008000           [3] move       0   1        ; R0 := R1
00E8  00000000           [4] move       0   0        ; R0 := R0
00EC  9E000001           [5] return     2   2        ; return R2
00F0  1E008000           [6] return     0   1        ; return 
                         * constants:
00F4  01000000           sizek (1)
00F8  03                 const type 3
00F9  0000000000000000   const [0]: (0)
                         * functions:
0101  01000000           sizep (1)
                         
0105                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0105  0000000000000000   string size (0)
                         source name: (none)
010D  04000000           line defined (4)
0111  06000000           last line defined (6)
0115  02                 nups (2)
0116  00                 numparams (0)
0117  00                 is_vararg (0)
0118  02                 maxstacksize (2)
                         * code:
0119  08000000           sizecode (8)
011D  04000000           [1] getupval   0   0        ; R0 := U0 , i
0121  0C004000           [2] add        0   0   256  ; R0 := R0 + 1
0125  08000000           [3] setupval   0   0        ; U0 := R0 , i
0129  04008000           [4] getupval   0   1        ; R0 := U1 , t
012D  44000000           [5] getupval   1   0        ; R1 := U0 , i
0131  06400000           [6] gettable   0   0   1    ; R0 := R0[R1]
0135  1E000001           [7] return     0   2        ; return R0
0139  1E008000           [8] return     0   1        ; return 
                         * constants:
013D  01000000           sizek (1)
0141  03                 const type 3
0142  000000000000F03F   const [0]: (1)
                         * functions:
014A  00000000           sizep (0)
                         * lines:
014E  08000000           sizelineinfo (8)
                         [pc] (line)
0152  05000000           [1] (5)
0156  05000000           [2] (5)
015A  05000000           [3] (5)
015E  05000000           [4] (5)
0162  05000000           [5] (5)
0166  05000000           [6] (5)
016A  05000000           [7] (5)
016E  06000000           [8] (6)
                         * locals:
0172  00000000           sizelocvars (0)
                         * upvalues:
0176  02000000           sizeupvalues (2)
017A  0200000000000000   string size (2)
0182  6900               "i\0"
                         upvalue [0]: i
0184  0200000000000000   string size (2)
018C  7400               "t\0"
                         upvalue [1]: t
                         ** end of function 0_0_0 **

                         * lines:
018E  06000000           sizelineinfo (6)
                         [pc] (line)
0192  03000000           [1] (3)
0196  06000000           [2] (6)
019A  06000000           [3] (6)
019E  06000000           [4] (6)
01A2  06000000           [5] (6)
01A6  07000000           [6] (7)
                         * locals:
01AA  02000000           sizelocvars (2)
01AE  0200000000000000   string size (2)
01B6  7400               "t\0"
                         local [0]: t
01B8  00000000             startpc (0)
01BC  05000000             endpc   (5)
01C0  0200000000000000   string size (2)
01C8  6900               "i\0"
                         local [1]: i
01CA  01000000             startpc (1)
01CE  05000000             endpc   (5)
                         * upvalues:
01D2  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
01D6  12000000           sizelineinfo (18)
                         [pc] (line)
01DA  07000000           [01] (7)
01DE  02000000           [02] (2)
01E2  09000000           [03] (9)
01E6  09000000           [04] (9)
01EA  09000000           [05] (9)
01EE  09000000           [06] (9)
01F2  09000000           [07] (9)
01F6  09000000           [08] (9)
01FA  0A000000           [09] (10)
01FE  0A000000           [10] (10)
0202  0A000000           [11] (10)
0206  0A000000           [12] (10)
020A  0B000000           [13] (11)
020E  0B000000           [14] (11)
0212  0B000000           [15] (11)
0216  0A000000           [16] (10)
021A  0B000000           [17] (11)
021E  0C000000           [18] (12)
                         * locals:
0222  04000000           sizelocvars (4)
0226  1000000000000000   string size (16)
022E  28666F722067656E+  "(for gen"
0236  657261746F722900   "erator)\0"
                         local [0]: (for generator)
023E  0B000000             startpc (11)
0242  11000000             endpc   (17)
0246  0C00000000000000   string size (12)
024E  28666F7220737461+  "(for sta"
0256  74652900           "te)\0"
                         local [1]: (for state)
025A  0B000000             startpc (11)
025E  11000000             endpc   (17)
0262  0E00000000000000   string size (14)
026A  28666F7220636F6E+  "(for con"
0272  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0278  0B000000             startpc (11)
027C  11000000             endpc   (17)
0280  0200000000000000   string size (2)
0288  7600               "v\0"
                         local [3]: v
028A  0C000000             startpc (12)
028E  0F000000             endpc   (15)
                         * upvalues:
0292  00000000           sizeupvalues (0)
                         ** end of function 0 **

0296                     ** end of chunk **
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
002B  12000000           sizecode (18)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; values := R0
0037  0A008001           [03] newtable   0   3   0    ; R0 := {} , array=3, hash=0
003B  41800000           [04] loadk      1   2        ; R1 := 10
003F  81C00000           [05] loadk      2   3        ; R2 := 20
0043  C1000100           [06] loadk      3   4        ; R3 := 30
0047  22408001           [07] setlist    0   3   1    ; R0[1 to 3] := R1 to R3
004B  07400000           [08] setglobal  0   1        ; t := R0
004F  05000000           [09] getglobal  0   0        ; R0 := values
0053  45400000           [10] getglobal  1   1        ; R1 := t
0057  1C000101           [11] call       0   2   4    ; R0 to R2 := R0(R1)
005B  16800080           [12] jmp        3            ; pc+=3 (goto [16])
005F  05410100           [13] getglobal  4   5        ; R4 := print
0063  40018001           [14] move       5   3        ; R5 := R3
0067  1C410001           [15] call       4   2   1    ;  := R4(R5)
006B  21400000           [16] tforloop   0       1    ; R3 := R0(R1,R2); if R3 ~= nil then R2 := R3 else PC := 18
006F  1680FE7F           [17] jmp        -5           ; pc+=-5 (goto [13])
0073  1E008000           [18] return     0   1        ; return 
                         * constants:
0077  06000000           sizek (6)
007B  04                 const type 4
007C  0700000000000000   string size (7)
0084  76616C75657300     "values\0"
                         const [0]: "values"
008B  04                 const type 4
008C  0200000000000000   string size (2)
0094  7400               "t\0"
                         const [1]: "t"
0096  03                 const type 3
0097  0000000000002440   const [2]: (10)
009F  03                 const type 3
00A0  0000000000003440   const [3]: (20)
00A8  03                 const type 3
00A9  0000000000003E40   const [4]: (30)
00B1  04                 const type 4
00B2  0600000000000000   string size (6)
00BA  7072696E7400       "print\0"
                         const [5]: "print"
                         * functions:
00C0  01000000           sizep (1)
                         
00C4                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00C4  0000000000000000   string size (0)
                         source name: (none)
00CC  02000000           line defined (2)
00D0  07000000           last line defined (7)
00D4  00                 nups (0)
00D5  01                 numparams (1)
00D6  00                 is_vararg (0)
00D7  03                 maxstacksize (3)
                         * code:
00D8  06000000           sizecode (6)
00DC  41000000           [1] loadk      1   0        ; R1 := 0
00E0  A4000000           [2] closure    2   0        ; R2 := closure(function[0]) 2 upvalues
00E4  00008000           [3] move       0   1        ; R0 := R1
00E8  00000000           [4] move       0   0        ; R0 := R0
00EC  9E000001           [5] return     2   2        ; return R2
00F0  1E008000           [6] return     0   1        ; return 
                         * constants:
00F4  01000000           sizek (1)
00F8  03                 const type 3
00F9  0000000000000000   const [0]: (0)
                         * functions:
0101  01000000           sizep (1)
                         
0105                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0105  0000000000000000   string size (0)
                         source name: (none)
010D  04000000           line defined (4)
0111  06000000           last line defined (6)
0115  02                 nups (2)
0116  00                 numparams (0)
0117  00                 is_vararg (0)
0118  02                 maxstacksize (2)
                         * code:
0119  08000000           sizecode (8)
011D  04000000           [1] getupval   0   0        ; R0 := U0 , i
0121  0C004000           [2] add        0   0   256  ; R0 := R0 + 1
0125  08000000           [3] setupval   0   0        ; U0 := R0 , i
0129  04008000           [4] getupval   0   1        ; R0 := U1 , t
012D  44000000           [5] getupval   1   0        ; R1 := U0 , i
0131  06400000           [6] gettable   0   0   1    ; R0 := R0[R1]
0135  1E000001           [7] return     0   2        ; return R0
0139  1E008000           [8] return     0   1        ; return 
                         * constants:
013D  01000000           sizek (1)
0141  03                 const type 3
0142  000000000000F03F   const [0]: (1)
                         * functions:
014A  00000000           sizep (0)
                         * lines:
014E  08000000           sizelineinfo (8)
                         [pc] (line)
0152  05000000           [1] (5)
0156  05000000           [2] (5)
015A  05000000           [3] (5)
015E  05000000           [4] (5)
0162  05000000           [5] (5)
0166  05000000           [6] (5)
016A  05000000           [7] (5)
016E  06000000           [8] (6)
                         * locals:
0172  00000000           sizelocvars (0)
                         * upvalues:
0176  02000000           sizeupvalues (2)
017A  0200000000000000   string size (2)
0182  6900               "i\0"
                         upvalue [0]: i
0184  0200000000000000   string size (2)
018C  7400               "t\0"
                         upvalue [1]: t
                         ** end of function 0_0_0 **

                         * lines:
018E  06000000           sizelineinfo (6)
                         [pc] (line)
0192  03000000           [1] (3)
0196  06000000           [2] (6)
019A  06000000           [3] (6)
019E  06000000           [4] (6)
01A2  06000000           [5] (6)
01A6  07000000           [6] (7)
                         * locals:
01AA  02000000           sizelocvars (2)
01AE  0200000000000000   string size (2)
01B6  7400               "t\0"
                         local [0]: t
01B8  00000000             startpc (0)
01BC  05000000             endpc   (5)
01C0  0200000000000000   string size (2)
01C8  6900               "i\0"
                         local [1]: i
01CA  01000000             startpc (1)
01CE  05000000             endpc   (5)
                         * upvalues:
01D2  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
01D6  12000000           sizelineinfo (18)
                         [pc] (line)
01DA  07000000           [01] (7)
01DE  02000000           [02] (2)
01E2  09000000           [03] (9)
01E6  09000000           [04] (9)
01EA  09000000           [05] (9)
01EE  09000000           [06] (9)
01F2  09000000           [07] (9)
01F6  09000000           [08] (9)
01FA  0A000000           [09] (10)
01FE  0A000000           [10] (10)
0202  0A000000           [11] (10)
0206  0A000000           [12] (10)
020A  0B000000           [13] (11)
020E  0B000000           [14] (11)
0212  0B000000           [15] (11)
0216  0A000000           [16] (10)
021A  0B000000           [17] (11)
021E  0C000000           [18] (12)
                         * locals:
0222  04000000           sizelocvars (4)
0226  1000000000000000   string size (16)
022E  28666F722067656E+  "(for gen"
0236  657261746F722900   "erator)\0"
                         local [0]: (for generator)
023E  0B000000             startpc (11)
0242  11000000             endpc   (17)
0246  0C00000000000000   string size (12)
024E  28666F7220737461+  "(for sta"
0256  74652900           "te)\0"
                         local [1]: (for state)
025A  0B000000             startpc (11)
025E  11000000             endpc   (17)
0262  0E00000000000000   string size (14)
026A  28666F7220636F6E+  "(for con"
0272  74726F6C2900       "trol)\0"
                         local [2]: (for control)
0278  0B000000             startpc (11)
027C  11000000             endpc   (17)
0280  0200000000000000   string size (2)
0288  7600               "v\0"
                         local [3]: v
028A  0C000000             startpc (12)
028E  0F000000             endpc   (15)
                         * upvalues:
0292  00000000           sizeupvalues (0)
                         ** end of function 0 **

0296                     ** end of chunk **
