------------------------------
local var1
local var2
var2=var1+100
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.local  "var1"  ; 0    -- local直接在编译期占据一个寄存器
.local  "var2"  ; 1
.const  100  ; 0
[1] add        1   0   256  ; R1 := R0 + 100 -- const[0]用256索引
[2] return     0   1        ; return 
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
0027  02000000           sizecode (2)
002B  4C004000           [1] add        1   0   256  ; R1 := R0 + 100
002F  1E008000           [2] return     0   1        ; return 
                         * constants:
0033  01000000           sizek (1)
0037  03                 const type 3
0038  0000000000005940   const [0]: (100)
                         * functions:
0040  00000000           sizep (0)
                         * lines:
0044  02000000           sizelineinfo (2)
                         [pc] (line)
0048  03000000           [1] (3)
004C  03000000           [2] (3)
                         * locals:
0050  02000000           sizelocvars (2)
0054  05000000           string size (5)
0058  7661723100         "var1\0"
                         local [0]: var1
005D  00000000             startpc (0)
0061  01000000             endpc   (1)
0065  05000000           string size (5)
0069  7661723200         "var2\0"
                         local [1]: var2
006E  00000000             startpc (0)
0072  01000000             endpc   (1)
                         * upvalues:
0076  00000000           sizeupvalues (0)
                         ** end of function 0 **

007A                     ** end of chunk **
