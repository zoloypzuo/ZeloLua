------------------------------

local a,b,c
c = a == b
------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] eq         1   0   1    ; R0 == R1, pc+=1 (goto [3]) if false
[2] jmp        1            ; pc+=1 (goto [4])
[3] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [5])
[4] loadbool   2   1   0    ; R2 := true
[5] return     0   1        ; return 
; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.local  "a"  ; 0
.local  "b"  ; 1
.local  "c"  ; 2
[1] eq         1   0   1    ; R0 == R1, pc+=1 (goto [3]) if false
[2] jmp        1            ; pc+=1 (goto [4])
[3] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [5])
[4] loadbool   2   1   0    ; R2 := true
[5] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  05000000           sizecode (5)
002F  57400000           [1] eq         1   0   1    ; R0 == R1, pc+=1 (goto [3]) if false
0033  16000080           [2] jmp        1            ; pc+=1 (goto [4])
0037  82400000           [3] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [5])
003B  82008000           [4] loadbool   2   1   0    ; R2 := true
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  00000000           sizek (0)
                         * functions:
0047  00000000           sizep (0)
                         * lines:
004B  05000000           sizelineinfo (5)
                         [pc] (line)
004F  03000000           [1] (3)
0053  03000000           [2] (3)
0057  03000000           [3] (3)
005B  03000000           [4] (3)
005F  03000000           [5] (3)
                         * locals:
0063  03000000           sizelocvars (3)
0067  0200000000000000   string size (2)
006F  6100               "a\0"
                         local [0]: a
0071  00000000             startpc (0)
0075  04000000             endpc   (4)
0079  0200000000000000   string size (2)
0081  6200               "b\0"
                         local [1]: b
0083  00000000             startpc (0)
0087  04000000             endpc   (4)
008B  0200000000000000   string size (2)
0093  6300               "c\0"
                         local [2]: c
0095  00000000             startpc (0)
0099  04000000             endpc   (4)
                         * upvalues:
009D  00000000           sizeupvalues (0)
                         ** end of function 0 **

00A1                     ** end of chunk **
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
002A  03                 maxstacksize (3)
                         * code:
002B  05000000           sizecode (5)
002F  57400000           [1] eq         1   0   1    ; R0 == R1, pc+=1 (goto [3]) if false
0033  16000080           [2] jmp        1            ; pc+=1 (goto [4])
0037  82400000           [3] loadbool   2   0   1    ; R2 := false; PC := pc+=1 (goto [5])
003B  82008000           [4] loadbool   2   1   0    ; R2 := true
003F  1E008000           [5] return     0   1        ; return 
                         * constants:
0043  00000000           sizek (0)
                         * functions:
0047  00000000           sizep (0)
                         * lines:
004B  05000000           sizelineinfo (5)
                         [pc] (line)
004F  03000000           [1] (3)
0053  03000000           [2] (3)
0057  03000000           [3] (3)
005B  03000000           [4] (3)
005F  03000000           [5] (3)
                         * locals:
0063  03000000           sizelocvars (3)
0067  0200000000000000   string size (2)
006F  6100               "a\0"
                         local [0]: a
0071  00000000             startpc (0)
0075  04000000             endpc   (4)
0079  0200000000000000   string size (2)
0081  6200               "b\0"
                         local [1]: b
0083  00000000             startpc (0)
0087  04000000             endpc   (4)
008B  0200000000000000   string size (2)
0093  6300               "c\0"
                         local [2]: c
0095  00000000             startpc (0)
0099  04000000             endpc   (4)
                         * upvalues:
009D  00000000           sizeupvalues (0)
                         ** end of function 0 **

00A1                     ** end of chunk **
