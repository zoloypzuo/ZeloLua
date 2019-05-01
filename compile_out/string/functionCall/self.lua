------------------------------

-- Meta class
Shape = {area = 0}

function Shape:new (o,side)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  side = side or 0
  self.area = side*side;
  return o
end

function Shape:printArea ()
  print(self.area)
end

myshape = Shape:new(nil,10)

myshape:printArea()


------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "Shape"  ; 0
.const  "area"  ; 1
.const  0  ; 2
.const  "new"  ; 3
.const  "printArea"  ; 4
.const  "myshape"  ; 5
.const  10  ; 6
[01] newtable   0   0   1    ; R0 := {} , array=0, hash=1
[02] settable   0   257 258  ; R0["area"] := 0
[03] setglobal  0   0        ; Shape := R0
[04] getglobal  0   0        ; R0 := Shape
[05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[06] settable   0   259 1    ; R0["new"] := R1
[07] getglobal  0   0        ; R0 := Shape
[08] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[09] settable   0   260 1    ; R0["printArea"] := R1
[10] getglobal  0   0        ; R0 := Shape
[11] self       0   0   259  ; R1 := R0; R0 := R0["new"]
[12] loadnil    2   2        ; R2,  := nil
[13] loadk      3   6        ; R3 := 10
[14] call       0   4   2    ; R0 := R0(R1 to R3)
[15] setglobal  0   5        ; myshape := R0
[16] getglobal  0   5        ; R0 := myshape
[17] self       0   0   260  ; R1 := R0; R0 := R0["printArea"]
[18] call       0   2   1    ;  := R0(R1)
[19] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 6 stacks
.function  0 3 0 6
.local  "self"  ; 0
.local  "o"  ; 1
.local  "side"  ; 2
.const  "setmetatable"  ; 0
.const  "__index"  ; 1
.const  0  ; 2
.const  "area"  ; 3
[01] test       1       1    ; if not R1 then pc+=1 (goto [3])
[02] jmp        2            ; pc+=2 (goto [5])
[03] newtable   3   0   0    ; R3 := {} , array=0, hash=0
[04] move       1   3        ; R1 := R3
[05] getglobal  3   0        ; R3 := setmetatable
[06] move       4   1        ; R4 := R1
[07] move       5   0        ; R5 := R0
[08] call       3   3   1    ;  := R3(R4, R5)
[09] settable   0   257 0    ; R0["__index"] := R0
[10] test       2       1    ; if not R2 then pc+=1 (goto [12])
[11] jmp        1            ; pc+=1 (goto [13])
[12] loadk      2   2        ; R2 := 0
[13] mul        3   2   2    ; R3 := R2 * R2
[14] settable   0   259 3    ; R0["area"] := R3
[15] return     1   2        ; return R1
[16] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "self"  ; 0
.const  "print"  ; 0
.const  "area"  ; 1
[1] getglobal  1   0        ; R1 := print
[2] gettable   2   0   257  ; R2 := R0["area"]
[3] call       1   2   1    ;  := R1(R2)
[4] return     0   1        ; return 
; end of function 0_1

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 4 stacks
.function  0 0 2 4
.const  "Shape"  ; 0
.const  "area"  ; 1
.const  0  ; 2
.const  "new"  ; 3
.const  "printArea"  ; 4
.const  "myshape"  ; 5
.const  10  ; 6
[01] newtable   0   0   1    ; R0 := {} , array=0, hash=1
[02] settable   0   257 258  ; R0["area"] := 0
[03] setglobal  0   0        ; Shape := R0
[04] getglobal  0   0        ; R0 := Shape
[05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[06] settable   0   259 1    ; R0["new"] := R1
[07] getglobal  0   0        ; R0 := Shape
[08] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
[09] settable   0   260 1    ; R0["printArea"] := R1
[10] getglobal  0   0        ; R0 := Shape
[11] self       0   0   259  ; R1 := R0; R0 := R0["new"]
[12] loadnil    2   2        ; R2,  := nil
[13] loadk      3   6        ; R3 := 10
[14] call       0   4   2    ; R0 := R0(R1 to R3)
[15] setglobal  0   5        ; myshape := R0
[16] getglobal  0   5        ; R0 := myshape
[17] self       0   0   260  ; R1 := R0; R0 := R0["printArea"]
[18] call       0   2   1    ;  := R0(R1)
[19] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 3 params, is_vararg = 0, 6 stacks
.function  0 3 0 6
.local  "self"  ; 0
.local  "o"  ; 1
.local  "side"  ; 2
.const  "setmetatable"  ; 0
.const  "__index"  ; 1
.const  0  ; 2
.const  "area"  ; 3
[01] test       1       1    ; if not R1 then pc+=1 (goto [3])
[02] jmp        2            ; pc+=2 (goto [5])
[03] newtable   3   0   0    ; R3 := {} , array=0, hash=0
[04] move       1   3        ; R1 := R3
[05] getglobal  3   0        ; R3 := setmetatable
[06] move       4   1        ; R4 := R1
[07] move       5   0        ; R5 := R0
[08] call       3   3   1    ;  := R3(R4, R5)
[09] settable   0   257 0    ; R0["__index"] := R0
[10] test       2       1    ; if not R2 then pc+=1 (goto [12])
[11] jmp        1            ; pc+=1 (goto [13])
[12] loadk      2   2        ; R2 := 0
[13] mul        3   2   2    ; R3 := R2 * R2
[14] settable   0   259 3    ; R0["area"] := R3
[15] return     1   2        ; return R1
[16] return     0   1        ; return 
; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "self"  ; 0
.const  "print"  ; 0
.const  "area"  ; 1
[1] getglobal  1   0        ; R1 := print
[2] gettable   2   0   257  ; R2 := R0["area"]
[3] call       1   2   1    ;  := R1(R2)
[4] return     0   1        ; return 
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
002A  04                 maxstacksize (4)
                         * code:
002B  13000000           sizecode (19)
002F  0A400000           [01] newtable   0   0   1    ; R0 := {} , array=0, hash=1
0033  0980C080           [02] settable   0   257 258  ; R0["area"] := 0
0037  07000000           [03] setglobal  0   0        ; Shape := R0
003B  05000000           [04] getglobal  0   0        ; R0 := Shape
003F  64000000           [05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0043  09408081           [06] settable   0   259 1    ; R0["new"] := R1
0047  05000000           [07] getglobal  0   0        ; R0 := Shape
004B  64400000           [08] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
004F  09400082           [09] settable   0   260 1    ; R0["printArea"] := R1
0053  05000000           [10] getglobal  0   0        ; R0 := Shape
0057  0BC04000           [11] self       0   0   259  ; R1 := R0; R0 := R0["new"]
005B  83000001           [12] loadnil    2   2        ; R2,  := nil
005F  C1800100           [13] loadk      3   6        ; R3 := 10
0063  1C800002           [14] call       0   4   2    ; R0 := R0(R1 to R3)
0067  07400100           [15] setglobal  0   5        ; myshape := R0
006B  05400100           [16] getglobal  0   5        ; R0 := myshape
006F  0B004100           [17] self       0   0   260  ; R1 := R0; R0 := R0["printArea"]
0073  1C400001           [18] call       0   2   1    ;  := R0(R1)
0077  1E008000           [19] return     0   1        ; return 
                         * constants:
007B  07000000           sizek (7)
007F  04                 const type 4
0080  0600000000000000   string size (6)
0088  536861706500       "Shape\0"
                         const [0]: "Shape"
008E  04                 const type 4
008F  0500000000000000   string size (5)
0097  6172656100         "area\0"
                         const [1]: "area"
009C  03                 const type 3
009D  0000000000000000   const [2]: (0)
00A5  04                 const type 4
00A6  0400000000000000   string size (4)
00AE  6E657700           "new\0"
                         const [3]: "new"
00B2  04                 const type 4
00B3  0A00000000000000   string size (10)
00BB  7072696E74417265+  "printAre"
00C3  6100               "a\0"
                         const [4]: "printArea"
00C5  04                 const type 4
00C6  0800000000000000   string size (8)
00CE  6D79736861706500   "myshape\0"
                         const [5]: "myshape"
00D6  03                 const type 3
00D7  0000000000002440   const [6]: (10)
                         * functions:
00DF  02000000           sizep (2)
                         
00E3                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E3  0000000000000000   string size (0)
                         source name: (none)
00EB  05000000           line defined (5)
00EF  0C000000           last line defined (12)
00F3  00                 nups (0)
00F4  03                 numparams (3)
00F5  00                 is_vararg (0)
00F6  06                 maxstacksize (6)
                         * code:
00F7  10000000           sizecode (16)
00FB  5A400000           [01] test       1       1    ; if not R1 then pc+=1 (goto [3])
00FF  16400080           [02] jmp        2            ; pc+=2 (goto [5])
0103  CA000000           [03] newtable   3   0   0    ; R3 := {} , array=0, hash=0
0107  40008001           [04] move       1   3        ; R1 := R3
010B  C5000000           [05] getglobal  3   0        ; R3 := setmetatable
010F  00018000           [06] move       4   1        ; R4 := R1
0113  40010000           [07] move       5   0        ; R5 := R0
0117  DC408001           [08] call       3   3   1    ;  := R3(R4, R5)
011B  09008080           [09] settable   0   257 0    ; R0["__index"] := R0
011F  9A400000           [10] test       2       1    ; if not R2 then pc+=1 (goto [12])
0123  16000080           [11] jmp        1            ; pc+=1 (goto [13])
0127  81800000           [12] loadk      2   2        ; R2 := 0
012B  CE800001           [13] mul        3   2   2    ; R3 := R2 * R2
012F  09C08081           [14] settable   0   259 3    ; R0["area"] := R3
0133  5E000001           [15] return     1   2        ; return R1
0137  1E008000           [16] return     0   1        ; return 
                         * constants:
013B  04000000           sizek (4)
013F  04                 const type 4
0140  0D00000000000000   string size (13)
0148  7365746D65746174+  "setmetat"
0150  61626C6500         "able\0"
                         const [0]: "setmetatable"
0155  04                 const type 4
0156  0800000000000000   string size (8)
015E  5F5F696E64657800   "__index\0"
                         const [1]: "__index"
0166  03                 const type 3
0167  0000000000000000   const [2]: (0)
016F  04                 const type 4
0170  0500000000000000   string size (5)
0178  6172656100         "area\0"
                         const [3]: "area"
                         * functions:
017D  00000000           sizep (0)
                         * lines:
0181  10000000           sizelineinfo (16)
                         [pc] (line)
0185  06000000           [01] (6)
0189  06000000           [02] (6)
018D  06000000           [03] (6)
0191  06000000           [04] (6)
0195  07000000           [05] (7)
0199  07000000           [06] (7)
019D  07000000           [07] (7)
01A1  07000000           [08] (7)
01A5  08000000           [09] (8)
01A9  09000000           [10] (9)
01AD  09000000           [11] (9)
01B1  09000000           [12] (9)
01B5  0A000000           [13] (10)
01B9  0A000000           [14] (10)
01BD  0B000000           [15] (11)
01C1  0C000000           [16] (12)
                         * locals:
01C5  03000000           sizelocvars (3)
01C9  0500000000000000   string size (5)
01D1  73656C6600         "self\0"
                         local [0]: self
01D6  00000000             startpc (0)
01DA  0F000000             endpc   (15)
01DE  0200000000000000   string size (2)
01E6  6F00               "o\0"
                         local [1]: o
01E8  00000000             startpc (0)
01EC  0F000000             endpc   (15)
01F0  0500000000000000   string size (5)
01F8  7369646500         "side\0"
                         local [2]: side
01FD  00000000             startpc (0)
0201  0F000000             endpc   (15)
                         * upvalues:
0205  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0209                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0209  0000000000000000   string size (0)
                         source name: (none)
0211  0E000000           line defined (14)
0215  10000000           last line defined (16)
0219  00                 nups (0)
021A  01                 numparams (1)
021B  00                 is_vararg (0)
021C  03                 maxstacksize (3)
                         * code:
021D  04000000           sizecode (4)
0221  45000000           [1] getglobal  1   0        ; R1 := print
0225  86404000           [2] gettable   2   0   257  ; R2 := R0["area"]
0229  5C400001           [3] call       1   2   1    ;  := R1(R2)
022D  1E008000           [4] return     0   1        ; return 
                         * constants:
0231  02000000           sizek (2)
0235  04                 const type 4
0236  0600000000000000   string size (6)
023E  7072696E7400       "print\0"
                         const [0]: "print"
0244  04                 const type 4
0245  0500000000000000   string size (5)
024D  6172656100         "area\0"
                         const [1]: "area"
                         * functions:
0252  00000000           sizep (0)
                         * lines:
0256  04000000           sizelineinfo (4)
                         [pc] (line)
025A  0F000000           [1] (15)
025E  0F000000           [2] (15)
0262  0F000000           [3] (15)
0266  10000000           [4] (16)
                         * locals:
026A  01000000           sizelocvars (1)
026E  0500000000000000   string size (5)
0276  73656C6600         "self\0"
                         local [0]: self
027B  00000000             startpc (0)
027F  03000000             endpc   (3)
                         * upvalues:
0283  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
0287  13000000           sizelineinfo (19)
                         [pc] (line)
028B  03000000           [01] (3)
028F  03000000           [02] (3)
0293  03000000           [03] (3)
0297  05000000           [04] (5)
029B  0C000000           [05] (12)
029F  05000000           [06] (5)
02A3  0E000000           [07] (14)
02A7  10000000           [08] (16)
02AB  0E000000           [09] (14)
02AF  12000000           [10] (18)
02B3  12000000           [11] (18)
02B7  12000000           [12] (18)
02BB  12000000           [13] (18)
02BF  12000000           [14] (18)
02C3  12000000           [15] (18)
02C7  14000000           [16] (20)
02CB  14000000           [17] (20)
02CF  14000000           [18] (20)
02D3  14000000           [19] (20)
                         * locals:
02D7  00000000           sizelocvars (0)
                         * upvalues:
02DB  00000000           sizeupvalues (0)
                         ** end of function 0 **

02DF                     ** end of chunk **
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
002B  13000000           sizecode (19)
002F  0A400000           [01] newtable   0   0   1    ; R0 := {} , array=0, hash=1
0033  0980C080           [02] settable   0   257 258  ; R0["area"] := 0
0037  07000000           [03] setglobal  0   0        ; Shape := R0
003B  05000000           [04] getglobal  0   0        ; R0 := Shape
003F  64000000           [05] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
0043  09408081           [06] settable   0   259 1    ; R0["new"] := R1
0047  05000000           [07] getglobal  0   0        ; R0 := Shape
004B  64400000           [08] closure    1   1        ; R1 := closure(function[1]) 0 upvalues
004F  09400082           [09] settable   0   260 1    ; R0["printArea"] := R1
0053  05000000           [10] getglobal  0   0        ; R0 := Shape
0057  0BC04000           [11] self       0   0   259  ; R1 := R0; R0 := R0["new"]
005B  83000001           [12] loadnil    2   2        ; R2,  := nil
005F  C1800100           [13] loadk      3   6        ; R3 := 10
0063  1C800002           [14] call       0   4   2    ; R0 := R0(R1 to R3)
0067  07400100           [15] setglobal  0   5        ; myshape := R0
006B  05400100           [16] getglobal  0   5        ; R0 := myshape
006F  0B004100           [17] self       0   0   260  ; R1 := R0; R0 := R0["printArea"]
0073  1C400001           [18] call       0   2   1    ;  := R0(R1)
0077  1E008000           [19] return     0   1        ; return 
                         * constants:
007B  07000000           sizek (7)
007F  04                 const type 4
0080  0600000000000000   string size (6)
0088  536861706500       "Shape\0"
                         const [0]: "Shape"
008E  04                 const type 4
008F  0500000000000000   string size (5)
0097  6172656100         "area\0"
                         const [1]: "area"
009C  03                 const type 3
009D  0000000000000000   const [2]: (0)
00A5  04                 const type 4
00A6  0400000000000000   string size (4)
00AE  6E657700           "new\0"
                         const [3]: "new"
00B2  04                 const type 4
00B3  0A00000000000000   string size (10)
00BB  7072696E74417265+  "printAre"
00C3  6100               "a\0"
                         const [4]: "printArea"
00C5  04                 const type 4
00C6  0800000000000000   string size (8)
00CE  6D79736861706500   "myshape\0"
                         const [5]: "myshape"
00D6  03                 const type 3
00D7  0000000000002440   const [6]: (10)
                         * functions:
00DF  02000000           sizep (2)
                         
00E3                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
00E3  0000000000000000   string size (0)
                         source name: (none)
00EB  05000000           line defined (5)
00EF  0C000000           last line defined (12)
00F3  00                 nups (0)
00F4  03                 numparams (3)
00F5  00                 is_vararg (0)
00F6  06                 maxstacksize (6)
                         * code:
00F7  10000000           sizecode (16)
00FB  5A400000           [01] test       1       1    ; if not R1 then pc+=1 (goto [3])
00FF  16400080           [02] jmp        2            ; pc+=2 (goto [5])
0103  CA000000           [03] newtable   3   0   0    ; R3 := {} , array=0, hash=0
0107  40008001           [04] move       1   3        ; R1 := R3
010B  C5000000           [05] getglobal  3   0        ; R3 := setmetatable
010F  00018000           [06] move       4   1        ; R4 := R1
0113  40010000           [07] move       5   0        ; R5 := R0
0117  DC408001           [08] call       3   3   1    ;  := R3(R4, R5)
011B  09008080           [09] settable   0   257 0    ; R0["__index"] := R0
011F  9A400000           [10] test       2       1    ; if not R2 then pc+=1 (goto [12])
0123  16000080           [11] jmp        1            ; pc+=1 (goto [13])
0127  81800000           [12] loadk      2   2        ; R2 := 0
012B  CE800001           [13] mul        3   2   2    ; R3 := R2 * R2
012F  09C08081           [14] settable   0   259 3    ; R0["area"] := R3
0133  5E000001           [15] return     1   2        ; return R1
0137  1E008000           [16] return     0   1        ; return 
                         * constants:
013B  04000000           sizek (4)
013F  04                 const type 4
0140  0D00000000000000   string size (13)
0148  7365746D65746174+  "setmetat"
0150  61626C6500         "able\0"
                         const [0]: "setmetatable"
0155  04                 const type 4
0156  0800000000000000   string size (8)
015E  5F5F696E64657800   "__index\0"
                         const [1]: "__index"
0166  03                 const type 3
0167  0000000000000000   const [2]: (0)
016F  04                 const type 4
0170  0500000000000000   string size (5)
0178  6172656100         "area\0"
                         const [3]: "area"
                         * functions:
017D  00000000           sizep (0)
                         * lines:
0181  10000000           sizelineinfo (16)
                         [pc] (line)
0185  06000000           [01] (6)
0189  06000000           [02] (6)
018D  06000000           [03] (6)
0191  06000000           [04] (6)
0195  07000000           [05] (7)
0199  07000000           [06] (7)
019D  07000000           [07] (7)
01A1  07000000           [08] (7)
01A5  08000000           [09] (8)
01A9  09000000           [10] (9)
01AD  09000000           [11] (9)
01B1  09000000           [12] (9)
01B5  0A000000           [13] (10)
01B9  0A000000           [14] (10)
01BD  0B000000           [15] (11)
01C1  0C000000           [16] (12)
                         * locals:
01C5  03000000           sizelocvars (3)
01C9  0500000000000000   string size (5)
01D1  73656C6600         "self\0"
                         local [0]: self
01D6  00000000             startpc (0)
01DA  0F000000             endpc   (15)
01DE  0200000000000000   string size (2)
01E6  6F00               "o\0"
                         local [1]: o
01E8  00000000             startpc (0)
01EC  0F000000             endpc   (15)
01F0  0500000000000000   string size (5)
01F8  7369646500         "side\0"
                         local [2]: side
01FD  00000000             startpc (0)
0201  0F000000             endpc   (15)
                         * upvalues:
0205  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
0209                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
0209  0000000000000000   string size (0)
                         source name: (none)
0211  0E000000           line defined (14)
0215  10000000           last line defined (16)
0219  00                 nups (0)
021A  01                 numparams (1)
021B  00                 is_vararg (0)
021C  03                 maxstacksize (3)
                         * code:
021D  04000000           sizecode (4)
0221  45000000           [1] getglobal  1   0        ; R1 := print
0225  86404000           [2] gettable   2   0   257  ; R2 := R0["area"]
0229  5C400001           [3] call       1   2   1    ;  := R1(R2)
022D  1E008000           [4] return     0   1        ; return 
                         * constants:
0231  02000000           sizek (2)
0235  04                 const type 4
0236  0600000000000000   string size (6)
023E  7072696E7400       "print\0"
                         const [0]: "print"
0244  04                 const type 4
0245  0500000000000000   string size (5)
024D  6172656100         "area\0"
                         const [1]: "area"
                         * functions:
0252  00000000           sizep (0)
                         * lines:
0256  04000000           sizelineinfo (4)
                         [pc] (line)
025A  0F000000           [1] (15)
025E  0F000000           [2] (15)
0262  0F000000           [3] (15)
0266  10000000           [4] (16)
                         * locals:
026A  01000000           sizelocvars (1)
026E  0500000000000000   string size (5)
0276  73656C6600         "self\0"
                         local [0]: self
027B  00000000             startpc (0)
027F  03000000             endpc   (3)
                         * upvalues:
0283  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         * lines:
0287  13000000           sizelineinfo (19)
                         [pc] (line)
028B  03000000           [01] (3)
028F  03000000           [02] (3)
0293  03000000           [03] (3)
0297  05000000           [04] (5)
029B  0C000000           [05] (12)
029F  05000000           [06] (5)
02A3  0E000000           [07] (14)
02A7  10000000           [08] (16)
02AB  0E000000           [09] (14)
02AF  12000000           [10] (18)
02B3  12000000           [11] (18)
02B7  12000000           [12] (18)
02BB  12000000           [13] (18)
02BF  12000000           [14] (18)
02C3  12000000           [15] (18)
02C7  14000000           [16] (20)
02CB  14000000           [17] (20)
02CF  14000000           [18] (20)
02D3  14000000           [19] (20)
                         * locals:
02D7  00000000           sizelocvars (0)
                         * upvalues:
02DB  00000000           sizeupvalues (0)
                         ** end of function 0 **

02DF                     ** end of chunk **
