------------------------------
function max(a,b)
	local m=a
	if b>a then
		m=b
	end
	return m
end
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "max"  ; 0
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; max := R0
[3] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 2 params, is_vararg = 0, 3 stacks
.function  0 2 0 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "m"  ; 2
[1] move       2   0        ; R2 := R0
[2] lt         0   0   1    ; R0 < R1, pc+=1 (goto [4]) if true ; if a < b then goto [4]
[3] jmp        1            ; pc+=1 (goto [5]) 
[4] move       2   1        ; R2 := R1
[5] return     2   2        ; return R2
[6] return     0   1        ; return 
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
0027  03000000           sizecode (3)
002B  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
002F  07000000           [2] setglobal  0   0        ; max := R0
0033  1E008000           [3] return     0   1        ; return 
                         * constants:
0037  01000000           sizek (1)
003B  04                 const type 4
003C  04000000           string size (4)
0040  6D617800           "max\0"
                         const [0]: "max"
                         * functions:
0044  01000000           sizep (1)
                         
0048                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0048  00000000           string size (0)
                         source name: (none)
004C  01000000           line defined (1)
0050  07000000           last line defined (7)
0054  00                 nups (0)
0055  02                 numparams (2)
0056  00                 is_vararg (0)
0057  03                 maxstacksize (3)
                         * code:
0058  06000000           sizecode (6)
005C  80000000           [1] move       2   0        ; R2 := R0
0060  18400000           [2] lt         0   0   1    ; R0 < R1, pc+=1 (goto [4]) if true
0064  16000080           [3] jmp        1            ; pc+=1 (goto [5])
0068  80008000           [4] move       2   1        ; R2 := R1
006C  9E000001           [5] return     2   2        ; return R2
0070  1E008000           [6] return     0   1        ; return 
                         * constants:
0074  00000000           sizek (0)
                         * functions:
0078  00000000           sizep (0)
                         * lines:
007C  06000000           sizelineinfo (6)
                         [pc] (line)
0080  02000000           [1] (2)
0084  03000000           [2] (3)
0088  03000000           [3] (3)
008C  04000000           [4] (4)
0090  06000000           [5] (6)
0094  07000000           [6] (7)
                         * locals:
0098  03000000           sizelocvars (3)
009C  02000000           string size (2)
00A0  6100               "a\0"
                         local [0]: a
00A2  00000000             startpc (0)
00A6  05000000             endpc   (5)
00AA  02000000           string size (2)
00AE  6200               "b\0"
                         local [1]: b
00B0  00000000             startpc (0)
00B4  05000000             endpc   (5)
00B8  02000000           string size (2)
00BC  6D00               "m\0"
                         local [2]: m
00BE  01000000             startpc (1)
00C2  05000000             endpc   (5)
                         * upvalues:
00C6  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
00CA  03000000           sizelineinfo (3)
                         [pc] (line)
00CE  07000000           [1] (7)
00D2  01000000           [2] (1)
00D6  07000000           [3] (7)
                         * locals:
00DA  00000000           sizelocvars (0)
                         * upvalues:
00DE  00000000           sizeupvalues (0)
                         ** end of function 0 **

00E2                     ** end of chunk **
