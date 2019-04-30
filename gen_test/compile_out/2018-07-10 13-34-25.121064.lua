------------------------------
var2=var1+100
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "var2"  ; 0 -- var2在var1前面
.const  "var1"  ; 1
.const  100  ; 2
[1] getglobal  0   1        ; R0 := var1  -- 全局变量在G，先用1索引id，再在G索引指针
[2] add        0   0   258  ; R0 := R0 + 100
[3] setglobal  0   0        ; var2 := R0
[4] return     0   1        ; return 
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
0027  04000000           sizecode (4)
002B  05400000           [1] getglobal  0   1        ; R0 := var1
002F  0C804000           [2] add        0   0   258  ; R0 := R0 + 100
0033  07000000           [3] setglobal  0   0        ; var2 := R0
0037  1E008000           [4] return     0   1        ; return 
                         * constants:
003B  03000000           sizek (3)
003F  04                 const type 4
0040  05000000           string size (5)
0044  7661723200         "var2\0"
                         const [0]: "var2"
0049  04                 const type 4
004A  05000000           string size (5)
004E  7661723100         "var1\0"
                         const [1]: "var1"
0053  03                 const type 3
0054  0000000000005940   const [2]: (100)
                         * functions:
005C  00000000           sizep (0)
                         * lines:
0060  04000000           sizelineinfo (4)
                         [pc] (line)
0064  01000000           [1] (1)
0068  01000000           [2] (1)
006C  01000000           [3] (1)
0070  01000000           [4] (1)
                         * locals:
0074  00000000           sizelocvars (0)
                         * upvalues:
0078  00000000           sizeupvalues (0)
                         ** end of function 0 **

007C                     ** end of chunk **
