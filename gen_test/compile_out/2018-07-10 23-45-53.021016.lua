------------------------------
function f(a)
  return function(b)
      return a+b
    end
end
f(1)(2)
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "f"  ; 0
.const  1  ; 1
.const  2  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; f := R0
[3] getglobal  0   0        ; R0 := f
[4] loadk      1   1        ; R1 := 1
[5] call       0   2   2    ; R0 := R0(R1) -- f(1) here is compiled to sth like 'temp = f(1)', so it is a call exp
[6] loadk      1   2        ; R1 := 2
[7] call       0   2   1    ;  := R0(R1) -- call statement do not return val
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  0 1 0 2
.local  "a"  ; 0
[1] closure    1   0        ; R1 := closure(function[0]) 1 upvalues ; --'return exp', the exp is considered local because no var/ lvalue is needed
[2] move       0   0        ; R0 := R0
[3] return     1   2        ; return R1
[4] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 1 upvalues, 1 params, is_vararg = 0, 2 stacks
.function  1 1 0 2
.local  "b"  ; 0
.upvalue  "a"  ; 0
[1] getupval   1   0        ; R1 := U0 , a
[2] add        1   1   0    ; R1 := R1 + R0
[3] return     1   2        ; return R1
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0

; end of function 0


------------------------------
Pos   Hex Data           Description or Code
------------------------------------------------------------------------
0000                     ** source chunk: luac.out
                         ** global header start **
0000  1B4C7561           header signature: "\27Lua"
0004  51                 version (major:minor hex digits)
0005  00                 format (0=official)
0006  01                 endianness (1=little endian)
0007  04                 size of int (bytes)
0008  04                 size of size_t (bytes)
0009  04                 size of Instruction (bytes)
000A  08                 size of number (bytes)
000B  00                 integral (1=integral)
                         * number type: double
                         * x86 standard (32-bit, little endian, doubles)
                         ** global header end **
                         
000C                     ** function [0] definition (level 1) 0
                         ** start of function 0 **
000C  0B000000           string size (11)
0010  406C6561726E2E6C+  "@learn.l"
0018  756100             "ua\0"
                         source name: @learn.lua
001B  00000000           line defined (0)
001F  00000000           last line defined (0)
0023  00                 nups (0)
0024  00                 numparams (0)
0025  02                 is_vararg (2)
0026  02                 maxstacksize (2)
                         * code:
0027  08000000           sizecode (8)
002B  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
002F  07000000           [2] setglobal  0   0        ; f := R0
0033  05000000           [3] getglobal  0   0        ; R0 := f
0037  41400000           [4] loadk      1   1        ; R1 := 1
003B  1C800001           [5] call       0   2   2    ; R0 := R0(R1)
003F  41800000           [6] loadk      1   2        ; R1 := 2
0043  1C400001           [7] call       0   2   1    ;  := R0(R1)
0047  1E008000           [8] return     0   1        ; return 
                         * constants:
004B  03000000           sizek (3)
004F  04                 const type 4
0050  02000000           string size (2)
0054  6600               "f\0"
                         const [0]: "f"
0056  03                 const type 3
0057  000000000000F03F   const [1]: (1)
005F  03                 const type 3
0060  0000000000000040   const [2]: (2)
                         * functions:
0068  01000000           sizep (1)
                         
006C                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
006C  00000000           string size (0)
                         source name: (none)
0070  01000000           line defined (1)
0074  05000000           last line defined (5)
0078  00                 nups (0)
0079  01                 numparams (1)
007A  00                 is_vararg (0)
007B  02                 maxstacksize (2)
                         * code:
007C  04000000           sizecode (4)
0080  64000000           [1] closure    1   0        ; R1 := closure(function[0]) 1 upvalues
0084  00000000           [2] move       0   0        ; R0 := R0
0088  5E000001           [3] return     1   2        ; return R1
008C  1E008000           [4] return     0   1        ; return 
                         * constants:
0090  00000000           sizek (0)
                         * functions:
0094  01000000           sizep (1)
                         
0098                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0098  00000000           string size (0)
                         source name: (none)
009C  02000000           line defined (2)
00A0  04000000           last line defined (4)
00A4  01                 nups (1)
00A5  01                 numparams (1)
00A6  00                 is_vararg (0)
00A7  02                 maxstacksize (2)
                         * code:
00A8  04000000           sizecode (4)
00AC  44000000           [1] getupval   1   0        ; R1 := U0 , a
00B0  4C008000           [2] add        1   1   0    ; R1 := R1 + R0
00B4  5E000001           [3] return     1   2        ; return R1
00B8  1E008000           [4] return     0   1        ; return 
                         * constants:
00BC  00000000           sizek (0)
                         * functions:
00C0  00000000           sizep (0)
                         * lines:
00C4  04000000           sizelineinfo (4)
                         [pc] (line)
00C8  03000000           [1] (3)
00CC  03000000           [2] (3)
00D0  03000000           [3] (3)
00D4  04000000           [4] (4)
                         * locals:
00D8  01000000           sizelocvars (1)
00DC  02000000           string size (2)
00E0  6200               "b\0"
                         local [0]: b
00E2  00000000             startpc (0)
00E6  03000000             endpc   (3)
                         * upvalues:
00EA  01000000           sizeupvalues (1)
00EE  02000000           string size (2)
00F2  6100               "a\0"
                         upvalue [0]: a
                         ** end of function 0_0_0 **

                         * lines:
00F4  04000000           sizelineinfo (4)
                         [pc] (line)
00F8  04000000           [1] (4)
00FC  04000000           [2] (4)
0100  04000000           [3] (4)
0104  05000000           [4] (5)
                         * locals:
0108  01000000           sizelocvars (1)
010C  02000000           string size (2)
0110  6100               "a\0"
                         local [0]: a
0112  00000000             startpc (0)
0116  03000000             endpc   (3)
                         * upvalues:
011A  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
011E  08000000           sizelineinfo (8)
                         [pc] (line)
0122  05000000           [1] (5)
0126  01000000           [2] (1)
012A  06000000           [3] (6)
012E  06000000           [4] (6)
0132  06000000           [5] (6)
0136  06000000           [6] (6)
013A  06000000           [7] (6)
013E  06000000           [8] (6)
                         * locals:
0142  00000000           sizelocvars (0)
                         * upvalues:
0146  00000000           sizeupvalues (0)
                         ** end of function 0 **

014A                     ** end of chunk **
