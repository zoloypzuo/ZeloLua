------------------------------
function fibonacci(n)
  if n < 2 then
    return n
  else
    return fibonacci(n-1) + fibonacci(n-2)
  end
end

print(fibonacci(16))

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "fibonacci"  ; 0
.const  "print"  ; 1
.const  16  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; fibonacci := R0
[3] getglobal  0   1        ; R0 := print
[4] getglobal  1   0        ; R1 := fibonacci
[5] loadk      2   2        ; R2 := 16
[6] call       1   2   0    ; R1 to top := R1(R2)
[7] call       0   0   1    ;  := R0(R1 to top)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "n"  ; 0
.const  2  ; 0
.const  "fibonacci"  ; 1
.const  1  ; 2
[01] lt         0   0   256  ; R0 < 2, pc+=1 (goto [3]) if true
[02] jmp        2            ; pc+=2 (goto [5])
[03] return     0   2        ; return R0
[04] jmp        8            ; pc+=8 (goto [13])
[05] getglobal  1   1        ; R1 := fibonacci
[06] sub        2   0   258  ; R2 := R0 - 1
[07] call       1   2   2    ; R1 := R1(R2)
[08] getglobal  2   1        ; R2 := fibonacci
[09] sub        3   0   256  ; R3 := R0 - 2
[10] call       2   2   2    ; R2 := R2(R3)
[11] add        1   1   2    ; R1 := R1 + R2
[12] return     1   2        ; return R1
[13] return     0   1        ; return 
; end of function 0_0

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 3 stacks
.function  0 0 2 3
.const  "fibonacci"  ; 0
.const  "print"  ; 1
.const  16  ; 2
[1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[2] setglobal  0   0        ; fibonacci := R0
[3] getglobal  0   1        ; R0 := print
[4] getglobal  1   0        ; R1 := fibonacci
[5] loadk      2   2        ; R2 := 16
[6] call       1   2   0    ; R1 to top := R1(R2)
[7] call       0   0   1    ;  := R0(R1 to top)
[8] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "n"  ; 0
.const  2  ; 0
.const  "fibonacci"  ; 1
.const  1  ; 2
[01] lt         0   0   256  ; R0 < 2, pc+=1 (goto [3]) if true
[02] jmp        2            ; pc+=2 (goto [5])
[03] return     0   2        ; return R0
[04] jmp        8            ; pc+=8 (goto [13])
[05] getglobal  1   1        ; R1 := fibonacci
[06] sub        2   0   258  ; R2 := R0 - 1
[07] call       1   2   2    ; R1 := R1(R2)
[08] getglobal  2   1        ; R2 := fibonacci
[09] sub        3   0   256  ; R3 := R0 - 2
[10] call       2   2   2    ; R2 := R2(R3)
[11] add        1   1   2    ; R1 := R1 + R2
[12] return     1   2        ; return R1
[13] return     0   1        ; return 
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
002A  03                 maxstacksize (3)
                         * code:
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; fibonacci := R0
0037  05400000           [3] getglobal  0   1        ; R0 := print
003B  45000000           [4] getglobal  1   0        ; R1 := fibonacci
003F  81800000           [5] loadk      2   2        ; R2 := 16
0043  5C000001           [6] call       1   2   0    ; R1 to top := R1(R2)
0047  1C400000           [7] call       0   0   1    ;  := R0(R1 to top)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  03000000           sizek (3)
0053  04                 const type 4
0054  0A00000000000000   string size (10)
005C  6669626F6E616363+  "fibonacc"
0064  6900               "i\0"
                         const [0]: "fibonacci"
0066  04                 const type 4
0067  0600000000000000   string size (6)
006F  7072696E7400       "print\0"
                         const [1]: "print"
0075  03                 const type 3
0076  0000000000003040   const [2]: (16)
                         * functions:
007E  01000000           sizep (1)
                         
0082                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0082  0000000000000000   string size (0)
                         source name: (none)
008A  01000000           line defined (1)
008E  07000000           last line defined (7)
0092  00                 nups (0)
0093  01                 numparams (1)
0094  00                 is_vararg (0)
0095  04                 maxstacksize (4)
                         * code:
0096  0D000000           sizecode (13)
009A  18004000           [01] lt         0   0   256  ; R0 < 2, pc+=1 (goto [3]) if true
009E  16400080           [02] jmp        2            ; pc+=2 (goto [5])
00A2  1E000001           [03] return     0   2        ; return R0
00A6  16C00180           [04] jmp        8            ; pc+=8 (goto [13])
00AA  45400000           [05] getglobal  1   1        ; R1 := fibonacci
00AE  8D804000           [06] sub        2   0   258  ; R2 := R0 - 1
00B2  5C800001           [07] call       1   2   2    ; R1 := R1(R2)
00B6  85400000           [08] getglobal  2   1        ; R2 := fibonacci
00BA  CD004000           [09] sub        3   0   256  ; R3 := R0 - 2
00BE  9C800001           [10] call       2   2   2    ; R2 := R2(R3)
00C2  4C808000           [11] add        1   1   2    ; R1 := R1 + R2
00C6  5E000001           [12] return     1   2        ; return R1
00CA  1E008000           [13] return     0   1        ; return 
                         * constants:
00CE  03000000           sizek (3)
00D2  03                 const type 3
00D3  0000000000000040   const [0]: (2)
00DB  04                 const type 4
00DC  0A00000000000000   string size (10)
00E4  6669626F6E616363+  "fibonacc"
00EC  6900               "i\0"
                         const [1]: "fibonacci"
00EE  03                 const type 3
00EF  000000000000F03F   const [2]: (1)
                         * functions:
00F7  00000000           sizep (0)
                         * lines:
00FB  0D000000           sizelineinfo (13)
                         [pc] (line)
00FF  02000000           [01] (2)
0103  02000000           [02] (2)
0107  03000000           [03] (3)
010B  03000000           [04] (3)
010F  05000000           [05] (5)
0113  05000000           [06] (5)
0117  05000000           [07] (5)
011B  05000000           [08] (5)
011F  05000000           [09] (5)
0123  05000000           [10] (5)
0127  05000000           [11] (5)
012B  05000000           [12] (5)
012F  07000000           [13] (7)
                         * locals:
0133  01000000           sizelocvars (1)
0137  0200000000000000   string size (2)
013F  6E00               "n\0"
                         local [0]: n
0141  00000000             startpc (0)
0145  0C000000             endpc   (12)
                         * upvalues:
0149  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
014D  08000000           sizelineinfo (8)
                         [pc] (line)
0151  07000000           [1] (7)
0155  01000000           [2] (1)
0159  09000000           [3] (9)
015D  09000000           [4] (9)
0161  09000000           [5] (9)
0165  09000000           [6] (9)
0169  09000000           [7] (9)
016D  09000000           [8] (9)
                         * locals:
0171  00000000           sizelocvars (0)
                         * upvalues:
0175  00000000           sizeupvalues (0)
                         ** end of function 0 **

0179                     ** end of chunk **
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
002B  08000000           sizecode (8)
002F  24000000           [1] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [2] setglobal  0   0        ; fibonacci := R0
0037  05400000           [3] getglobal  0   1        ; R0 := print
003B  45000000           [4] getglobal  1   0        ; R1 := fibonacci
003F  81800000           [5] loadk      2   2        ; R2 := 16
0043  5C000001           [6] call       1   2   0    ; R1 to top := R1(R2)
0047  1C400000           [7] call       0   0   1    ;  := R0(R1 to top)
004B  1E008000           [8] return     0   1        ; return 
                         * constants:
004F  03000000           sizek (3)
0053  04                 const type 4
0054  0A00000000000000   string size (10)
005C  6669626F6E616363+  "fibonacc"
0064  6900               "i\0"
                         const [0]: "fibonacci"
0066  04                 const type 4
0067  0600000000000000   string size (6)
006F  7072696E7400       "print\0"
                         const [1]: "print"
0075  03                 const type 3
0076  0000000000003040   const [2]: (16)
                         * functions:
007E  01000000           sizep (1)
                         
0082                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0082  0000000000000000   string size (0)
                         source name: (none)
008A  01000000           line defined (1)
008E  07000000           last line defined (7)
0092  00                 nups (0)
0093  01                 numparams (1)
0094  00                 is_vararg (0)
0095  04                 maxstacksize (4)
                         * code:
0096  0D000000           sizecode (13)
009A  18004000           [01] lt         0   0   256  ; R0 < 2, pc+=1 (goto [3]) if true
009E  16400080           [02] jmp        2            ; pc+=2 (goto [5])
00A2  1E000001           [03] return     0   2        ; return R0
00A6  16C00180           [04] jmp        8            ; pc+=8 (goto [13])
00AA  45400000           [05] getglobal  1   1        ; R1 := fibonacci
00AE  8D804000           [06] sub        2   0   258  ; R2 := R0 - 1
00B2  5C800001           [07] call       1   2   2    ; R1 := R1(R2)
00B6  85400000           [08] getglobal  2   1        ; R2 := fibonacci
00BA  CD004000           [09] sub        3   0   256  ; R3 := R0 - 2
00BE  9C800001           [10] call       2   2   2    ; R2 := R2(R3)
00C2  4C808000           [11] add        1   1   2    ; R1 := R1 + R2
00C6  5E000001           [12] return     1   2        ; return R1
00CA  1E008000           [13] return     0   1        ; return 
                         * constants:
00CE  03000000           sizek (3)
00D2  03                 const type 3
00D3  0000000000000040   const [0]: (2)
00DB  04                 const type 4
00DC  0A00000000000000   string size (10)
00E4  6669626F6E616363+  "fibonacc"
00EC  6900               "i\0"
                         const [1]: "fibonacci"
00EE  03                 const type 3
00EF  000000000000F03F   const [2]: (1)
                         * functions:
00F7  00000000           sizep (0)
                         * lines:
00FB  0D000000           sizelineinfo (13)
                         [pc] (line)
00FF  02000000           [01] (2)
0103  02000000           [02] (2)
0107  03000000           [03] (3)
010B  03000000           [04] (3)
010F  05000000           [05] (5)
0113  05000000           [06] (5)
0117  05000000           [07] (5)
011B  05000000           [08] (5)
011F  05000000           [09] (5)
0123  05000000           [10] (5)
0127  05000000           [11] (5)
012B  05000000           [12] (5)
012F  07000000           [13] (7)
                         * locals:
0133  01000000           sizelocvars (1)
0137  0200000000000000   string size (2)
013F  6E00               "n\0"
                         local [0]: n
0141  00000000             startpc (0)
0145  0C000000             endpc   (12)
                         * upvalues:
0149  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         * lines:
014D  08000000           sizelineinfo (8)
                         [pc] (line)
0151  07000000           [1] (7)
0155  01000000           [2] (1)
0159  09000000           [3] (9)
015D  09000000           [4] (9)
0161  09000000           [5] (9)
0165  09000000           [6] (9)
0169  09000000           [7] (9)
016D  09000000           [8] (9)
                         * locals:
0171  00000000           sizelocvars (0)
                         * upvalues:
0175  00000000           sizeupvalues (0)
                         ** end of function 0 **

0179                     ** end of chunk **
