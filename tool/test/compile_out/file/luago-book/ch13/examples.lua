------------------------------
--[[
public void lock2seconds(Lock lock) {
	if (!lock.tryLock()) {
		throw new RuntimeException("Unable to acquire the lock!");
	}
	try {
		Thread.sleep(2000);
	} catch (InterruptedException e) {
		// ignore
	} finally {
		lock.unlock();
	}
}
]]

function lock2seconds(lock)
  if not lock:tryLock() then
    error("Unable to acquire the lock!")
  end
  pcall(function()
    sleep(2000)
  end)
  lock:unlock()
end

function lock2seconds(lock)
  if not lock:tryLock() then
    error({err = "Unable to acquire the lock!"})
  end
end

function lock2seconds(lock)
  if not lock:tryLock() then
    error {err = "Unable to acquire the lock!"}
  end
end

function lock2seconds(lock)
  lock:lock()
  pcall(sleep, 2000)
  lock:unlock()
end

function lock2seconds(lock)
  lock:lock()
  local ok, msg = pcall(sleep, 2000)
  lock:unlock()
  if ok then
    print("ok")
  else
    print("error: " .. msg)
  end
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "lock2seconds"  ; 0
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; lock2seconds := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   0        ; lock2seconds := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   0        ; lock2seconds := R0
[07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[08] setglobal  0   0        ; lock2seconds := R0
[09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[10] setglobal  0   0        ; lock2seconds := R0
[11] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "Unable to acquire the lock!"  ; 2
.const  "pcall"  ; 3
.const  "unlock"  ; 4
[01] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[02] call       1   2   2    ; R1 := R1(R2)
[03] test       1       1    ; if not R1 then pc+=1 (goto [5])
[04] jmp        3            ; pc+=3 (goto [8])
[05] getglobal  1   1        ; R1 := error
[06] loadk      2   2        ; R2 := "Unable to acquire the lock!"
[07] call       1   2   1    ;  := R1(R2)
[08] getglobal  1   3        ; R1 := pcall
[09] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
[10] call       1   2   1    ;  := R1(R2)
[11] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
[12] call       1   2   1    ;  := R1(R2)
[13] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "sleep"  ; 0
.const  2000  ; 1
[1] getglobal  0   0        ; R0 := sleep
[2] loadk      1   1        ; R1 := 2000
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "err"  ; 2
.const  "Unable to acquire the lock!"  ; 3
[1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[2] call       1   2   2    ; R1 := R1(R2)
[3] test       1       1    ; if not R1 then pc+=1 (goto [5])
[4] jmp        4            ; pc+=4 (goto [9])
[5] getglobal  1   1        ; R1 := error
[6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
[7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "err"  ; 2
.const  "Unable to acquire the lock!"  ; 3
[1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[2] call       1   2   2    ; R1 := R1(R2)
[3] test       1       1    ; if not R1 then pc+=1 (goto [5])
[4] jmp        4            ; pc+=4 (goto [9])
[5] getglobal  1   1        ; R1 := error
[6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
[7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "lock"  ; 0
.const  "lock"  ; 0
.const  "pcall"  ; 1
.const  "sleep"  ; 2
.const  2000  ; 3
.const  "unlock"  ; 4
[1] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
[2] call       1   2   1    ;  := R1(R2)
[3] getglobal  1   1        ; R1 := pcall
[4] getglobal  2   2        ; R2 := sleep
[5] loadk      3   3        ; R3 := 2000
[6] call       1   3   1    ;  := R1(R2, R3)
[7] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 1 params, is_vararg = 0, 6 stacks
.function  0 1 0 6
.local  "lock"  ; 0
.local  "ok"  ; 1
.local  "msg"  ; 2
.const  "lock"  ; 0
.const  "pcall"  ; 1
.const  "sleep"  ; 2
.const  2000  ; 3
.const  "unlock"  ; 4
.const  "print"  ; 5
.const  "ok"  ; 6
.const  "error: "  ; 7
[01] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
[02] call       1   2   1    ;  := R1(R2)
[03] getglobal  1   1        ; R1 := pcall
[04] getglobal  2   2        ; R2 := sleep
[05] loadk      3   3        ; R3 := 2000
[06] call       1   3   3    ; R1, R2 := R1(R2, R3)
[07] self       3   0   260  ; R4 := R0; R3 := R0["unlock"]
[08] call       3   2   1    ;  := R3(R4)
[09] test       1       0    ; if R1 then pc+=1 (goto [11])
[10] jmp        4            ; pc+=4 (goto [15])
[11] getglobal  3   5        ; R3 := print
[12] loadk      4   6        ; R4 := "ok"
[13] call       3   2   1    ;  := R3(R4)
[14] jmp        5            ; pc+=5 (goto [20])
[15] getglobal  3   5        ; R3 := print
[16] loadk      4   7        ; R4 := "error: "
[17] move       5   2        ; R5 := R2
[18] concat     4   4   5    ; R4 := R4..R5
[19] call       3   2   1    ;  := R3(R4)
[20] return     0   1        ; return 
; end of function 0_4

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "lock2seconds"  ; 0
[01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
[02] setglobal  0   0        ; lock2seconds := R0
[03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[04] setglobal  0   0        ; lock2seconds := R0
[05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[06] setglobal  0   0        ; lock2seconds := R0
[07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[08] setglobal  0   0        ; lock2seconds := R0
[09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
[10] setglobal  0   0        ; lock2seconds := R0
[11] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "Unable to acquire the lock!"  ; 2
.const  "pcall"  ; 3
.const  "unlock"  ; 4
[01] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[02] call       1   2   2    ; R1 := R1(R2)
[03] test       1       1    ; if not R1 then pc+=1 (goto [5])
[04] jmp        3            ; pc+=3 (goto [8])
[05] getglobal  1   1        ; R1 := error
[06] loadk      2   2        ; R2 := "Unable to acquire the lock!"
[07] call       1   2   1    ;  := R1(R2)
[08] getglobal  1   3        ; R1 := pcall
[09] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
[10] call       1   2   1    ;  := R1(R2)
[11] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
[12] call       1   2   1    ;  := R1(R2)
[13] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 0 params, is_vararg = 0, 2 stacks
.function  0 0 0 2
.const  "sleep"  ; 0
.const  2000  ; 1
[1] getglobal  0   0        ; R0 := sleep
[2] loadk      1   1        ; R1 := 2000
[3] call       0   2   1    ;  := R0(R1)
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "err"  ; 2
.const  "Unable to acquire the lock!"  ; 3
[1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[2] call       1   2   2    ; R1 := R1(R2)
[3] test       1       1    ; if not R1 then pc+=1 (goto [5])
[4] jmp        4            ; pc+=4 (goto [9])
[5] getglobal  1   1        ; R1 := error
[6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
[7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 3 stacks
.function  0 1 0 3
.local  "lock"  ; 0
.const  "tryLock"  ; 0
.const  "error"  ; 1
.const  "err"  ; 2
.const  "Unable to acquire the lock!"  ; 3
[1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
[2] call       1   2   2    ; R1 := R1(R2)
[3] test       1       1    ; if not R1 then pc+=1 (goto [5])
[4] jmp        4            ; pc+=4 (goto [9])
[5] getglobal  1   1        ; R1 := error
[6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
[7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "lock"  ; 0
.const  "lock"  ; 0
.const  "pcall"  ; 1
.const  "sleep"  ; 2
.const  2000  ; 3
.const  "unlock"  ; 4
[1] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
[2] call       1   2   1    ;  := R1(R2)
[3] getglobal  1   1        ; R1 := pcall
[4] getglobal  2   2        ; R2 := sleep
[5] loadk      3   3        ; R3 := 2000
[6] call       1   3   1    ;  := R1(R2, R3)
[7] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
[8] call       1   2   1    ;  := R1(R2)
[9] return     0   1        ; return 
; end of function 0_3


; function [4] definition (level 2) 0_4
; 0 upvalues, 1 params, is_vararg = 0, 6 stacks
.function  0 1 0 6
.local  "lock"  ; 0
.local  "ok"  ; 1
.local  "msg"  ; 2
.const  "lock"  ; 0
.const  "pcall"  ; 1
.const  "sleep"  ; 2
.const  2000  ; 3
.const  "unlock"  ; 4
.const  "print"  ; 5
.const  "ok"  ; 6
.const  "error: "  ; 7
[01] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
[02] call       1   2   1    ;  := R1(R2)
[03] getglobal  1   1        ; R1 := pcall
[04] getglobal  2   2        ; R2 := sleep
[05] loadk      3   3        ; R3 := 2000
[06] call       1   3   3    ; R1, R2 := R1(R2, R3)
[07] self       3   0   260  ; R4 := R0; R3 := R0["unlock"]
[08] call       3   2   1    ;  := R3(R4)
[09] test       1       0    ; if R1 then pc+=1 (goto [11])
[10] jmp        4            ; pc+=4 (goto [15])
[11] getglobal  3   5        ; R3 := print
[12] loadk      4   6        ; R4 := "ok"
[13] call       3   2   1    ;  := R3(R4)
[14] jmp        5            ; pc+=5 (goto [20])
[15] getglobal  3   5        ; R3 := print
[16] loadk      4   7        ; R4 := "error: "
[17] move       5   2        ; R5 := R2
[18] concat     4   4   5    ; R4 := R4..R5
[19] call       3   2   1    ;  := R3(R4)
[20] return     0   1        ; return 
; end of function 0_4

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
002A  02                 maxstacksize (2)
                         * code:
002B  0B000000           sizecode (11)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; lock2seconds := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07000000           [04] setglobal  0   0        ; lock2seconds := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07000000           [06] setglobal  0   0        ; lock2seconds := R0
0047  24C00000           [07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
004B  07000000           [08] setglobal  0   0        ; lock2seconds := R0
004F  24000100           [09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0053  07000000           [10] setglobal  0   0        ; lock2seconds := R0
0057  1E008000           [11] return     0   1        ; return 
                         * constants:
005B  01000000           sizek (1)
005F  04                 const type 4
0060  0D00000000000000   string size (13)
0068  6C6F636B32736563+  "lock2sec"
0070  6F6E647300         "onds\0"
                         const [0]: "lock2seconds"
                         * functions:
0075  05000000           sizep (5)
                         
0079                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0079  0000000000000000   string size (0)
                         source name: (none)
0081  10000000           line defined (16)
0085  18000000           last line defined (24)
0089  00                 nups (0)
008A  01                 numparams (1)
008B  00                 is_vararg (0)
008C  03                 maxstacksize (3)
                         * code:
008D  0D000000           sizecode (13)
0091  4B004000           [01] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
0095  5C800001           [02] call       1   2   2    ; R1 := R1(R2)
0099  5A400000           [03] test       1       1    ; if not R1 then pc+=1 (goto [5])
009D  16800080           [04] jmp        3            ; pc+=3 (goto [8])
00A1  45400000           [05] getglobal  1   1        ; R1 := error
00A5  81800000           [06] loadk      2   2        ; R2 := "Unable to acquire the lock!"
00A9  5C400001           [07] call       1   2   1    ;  := R1(R2)
00AD  45C00000           [08] getglobal  1   3        ; R1 := pcall
00B1  A4000000           [09] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
00B5  5C400001           [10] call       1   2   1    ;  := R1(R2)
00B9  4B004100           [11] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
00BD  5C400001           [12] call       1   2   1    ;  := R1(R2)
00C1  1E008000           [13] return     0   1        ; return 
                         * constants:
00C5  05000000           sizek (5)
00C9  04                 const type 4
00CA  0800000000000000   string size (8)
00D2  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
00DA  04                 const type 4
00DB  0600000000000000   string size (6)
00E3  6572726F7200       "error\0"
                         const [1]: "error"
00E9  04                 const type 4
00EA  1C00000000000000   string size (28)
00F2  556E61626C652074+  "Unable t"
00FA  6F20616371756972+  "o acquir"
0102  6520746865206C6F+  "e the lo"
010A  636B2100           "ck!\0"
                         const [2]: "Unable to acquire the lock!"
010E  04                 const type 4
010F  0600000000000000   string size (6)
0117  7063616C6C00       "pcall\0"
                         const [3]: "pcall"
011D  04                 const type 4
011E  0700000000000000   string size (7)
0126  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
                         * functions:
012D  01000000           sizep (1)
                         
0131                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0131  0000000000000000   string size (0)
                         source name: (none)
0139  14000000           line defined (20)
013D  16000000           last line defined (22)
0141  00                 nups (0)
0142  00                 numparams (0)
0143  00                 is_vararg (0)
0144  02                 maxstacksize (2)
                         * code:
0145  04000000           sizecode (4)
0149  05000000           [1] getglobal  0   0        ; R0 := sleep
014D  41400000           [2] loadk      1   1        ; R1 := 2000
0151  1C400001           [3] call       0   2   1    ;  := R0(R1)
0155  1E008000           [4] return     0   1        ; return 
                         * constants:
0159  02000000           sizek (2)
015D  04                 const type 4
015E  0600000000000000   string size (6)
0166  736C65657000       "sleep\0"
                         const [0]: "sleep"
016C  03                 const type 3
016D  0000000000409F40   const [1]: (2000)
                         * functions:
0175  00000000           sizep (0)
                         * lines:
0179  04000000           sizelineinfo (4)
                         [pc] (line)
017D  15000000           [1] (21)
0181  15000000           [2] (21)
0185  15000000           [3] (21)
0189  16000000           [4] (22)
                         * locals:
018D  00000000           sizelocvars (0)
                         * upvalues:
0191  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
0195  0D000000           sizelineinfo (13)
                         [pc] (line)
0199  11000000           [01] (17)
019D  11000000           [02] (17)
01A1  11000000           [03] (17)
01A5  11000000           [04] (17)
01A9  12000000           [05] (18)
01AD  12000000           [06] (18)
01B1  12000000           [07] (18)
01B5  14000000           [08] (20)
01B9  16000000           [09] (22)
01BD  14000000           [10] (20)
01C1  17000000           [11] (23)
01C5  17000000           [12] (23)
01C9  18000000           [13] (24)
                         * locals:
01CD  01000000           sizelocvars (1)
01D1  0500000000000000   string size (5)
01D9  6C6F636B00         "lock\0"
                         local [0]: lock
01DE  00000000             startpc (0)
01E2  0C000000             endpc   (12)
                         * upvalues:
01E6  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
01EA                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
01EA  0000000000000000   string size (0)
                         source name: (none)
01F2  1A000000           line defined (26)
01F6  1E000000           last line defined (30)
01FA  00                 nups (0)
01FB  01                 numparams (1)
01FC  00                 is_vararg (0)
01FD  03                 maxstacksize (3)
                         * code:
01FE  09000000           sizecode (9)
0202  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
0206  5C800001           [2] call       1   2   2    ; R1 := R1(R2)
020A  5A400000           [3] test       1       1    ; if not R1 then pc+=1 (goto [5])
020E  16C00080           [4] jmp        4            ; pc+=4 (goto [9])
0212  45400000           [5] getglobal  1   1        ; R1 := error
0216  8A400000           [6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
021A  89C04081           [7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
021E  5C400001           [8] call       1   2   1    ;  := R1(R2)
0222  1E008000           [9] return     0   1        ; return 
                         * constants:
0226  04000000           sizek (4)
022A  04                 const type 4
022B  0800000000000000   string size (8)
0233  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
023B  04                 const type 4
023C  0600000000000000   string size (6)
0244  6572726F7200       "error\0"
                         const [1]: "error"
024A  04                 const type 4
024B  0400000000000000   string size (4)
0253  65727200           "err\0"
                         const [2]: "err"
0257  04                 const type 4
0258  1C00000000000000   string size (28)
0260  556E61626C652074+  "Unable t"
0268  6F20616371756972+  "o acquir"
0270  6520746865206C6F+  "e the lo"
0278  636B2100           "ck!\0"
                         const [3]: "Unable to acquire the lock!"
                         * functions:
027C  00000000           sizep (0)
                         * lines:
0280  09000000           sizelineinfo (9)
                         [pc] (line)
0284  1B000000           [1] (27)
0288  1B000000           [2] (27)
028C  1B000000           [3] (27)
0290  1B000000           [4] (27)
0294  1C000000           [5] (28)
0298  1C000000           [6] (28)
029C  1C000000           [7] (28)
02A0  1C000000           [8] (28)
02A4  1E000000           [9] (30)
                         * locals:
02A8  01000000           sizelocvars (1)
02AC  0500000000000000   string size (5)
02B4  6C6F636B00         "lock\0"
                         local [0]: lock
02B9  00000000             startpc (0)
02BD  08000000             endpc   (8)
                         * upvalues:
02C1  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
02C5                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
02C5  0000000000000000   string size (0)
                         source name: (none)
02CD  20000000           line defined (32)
02D1  24000000           last line defined (36)
02D5  00                 nups (0)
02D6  01                 numparams (1)
02D7  00                 is_vararg (0)
02D8  03                 maxstacksize (3)
                         * code:
02D9  09000000           sizecode (9)
02DD  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
02E1  5C800001           [2] call       1   2   2    ; R1 := R1(R2)
02E5  5A400000           [3] test       1       1    ; if not R1 then pc+=1 (goto [5])
02E9  16C00080           [4] jmp        4            ; pc+=4 (goto [9])
02ED  45400000           [5] getglobal  1   1        ; R1 := error
02F1  8A400000           [6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
02F5  89C04081           [7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
02F9  5C400001           [8] call       1   2   1    ;  := R1(R2)
02FD  1E008000           [9] return     0   1        ; return 
                         * constants:
0301  04000000           sizek (4)
0305  04                 const type 4
0306  0800000000000000   string size (8)
030E  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
0316  04                 const type 4
0317  0600000000000000   string size (6)
031F  6572726F7200       "error\0"
                         const [1]: "error"
0325  04                 const type 4
0326  0400000000000000   string size (4)
032E  65727200           "err\0"
                         const [2]: "err"
0332  04                 const type 4
0333  1C00000000000000   string size (28)
033B  556E61626C652074+  "Unable t"
0343  6F20616371756972+  "o acquir"
034B  6520746865206C6F+  "e the lo"
0353  636B2100           "ck!\0"
                         const [3]: "Unable to acquire the lock!"
                         * functions:
0357  00000000           sizep (0)
                         * lines:
035B  09000000           sizelineinfo (9)
                         [pc] (line)
035F  21000000           [1] (33)
0363  21000000           [2] (33)
0367  21000000           [3] (33)
036B  21000000           [4] (33)
036F  22000000           [5] (34)
0373  22000000           [6] (34)
0377  22000000           [7] (34)
037B  22000000           [8] (34)
037F  24000000           [9] (36)
                         * locals:
0383  01000000           sizelocvars (1)
0387  0500000000000000   string size (5)
038F  6C6F636B00         "lock\0"
                         local [0]: lock
0394  00000000             startpc (0)
0398  08000000             endpc   (8)
                         * upvalues:
039C  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
03A0                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
03A0  0000000000000000   string size (0)
                         source name: (none)
03A8  26000000           line defined (38)
03AC  2A000000           last line defined (42)
03B0  00                 nups (0)
03B1  01                 numparams (1)
03B2  00                 is_vararg (0)
03B3  04                 maxstacksize (4)
                         * code:
03B4  09000000           sizecode (9)
03B8  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
03BC  5C400001           [2] call       1   2   1    ;  := R1(R2)
03C0  45400000           [3] getglobal  1   1        ; R1 := pcall
03C4  85800000           [4] getglobal  2   2        ; R2 := sleep
03C8  C1C00000           [5] loadk      3   3        ; R3 := 2000
03CC  5C408001           [6] call       1   3   1    ;  := R1(R2, R3)
03D0  4B004100           [7] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
03D4  5C400001           [8] call       1   2   1    ;  := R1(R2)
03D8  1E008000           [9] return     0   1        ; return 
                         * constants:
03DC  05000000           sizek (5)
03E0  04                 const type 4
03E1  0500000000000000   string size (5)
03E9  6C6F636B00         "lock\0"
                         const [0]: "lock"
03EE  04                 const type 4
03EF  0600000000000000   string size (6)
03F7  7063616C6C00       "pcall\0"
                         const [1]: "pcall"
03FD  04                 const type 4
03FE  0600000000000000   string size (6)
0406  736C65657000       "sleep\0"
                         const [2]: "sleep"
040C  03                 const type 3
040D  0000000000409F40   const [3]: (2000)
0415  04                 const type 4
0416  0700000000000000   string size (7)
041E  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
                         * functions:
0425  00000000           sizep (0)
                         * lines:
0429  09000000           sizelineinfo (9)
                         [pc] (line)
042D  27000000           [1] (39)
0431  27000000           [2] (39)
0435  28000000           [3] (40)
0439  28000000           [4] (40)
043D  28000000           [5] (40)
0441  28000000           [6] (40)
0445  29000000           [7] (41)
0449  29000000           [8] (41)
044D  2A000000           [9] (42)
                         * locals:
0451  01000000           sizelocvars (1)
0455  0500000000000000   string size (5)
045D  6C6F636B00         "lock\0"
                         local [0]: lock
0462  00000000             startpc (0)
0466  08000000             endpc   (8)
                         * upvalues:
046A  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
046E                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
046E  0000000000000000   string size (0)
                         source name: (none)
0476  2C000000           line defined (44)
047A  35000000           last line defined (53)
047E  00                 nups (0)
047F  01                 numparams (1)
0480  00                 is_vararg (0)
0481  06                 maxstacksize (6)
                         * code:
0482  14000000           sizecode (20)
0486  4B004000           [01] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
048A  5C400001           [02] call       1   2   1    ;  := R1(R2)
048E  45400000           [03] getglobal  1   1        ; R1 := pcall
0492  85800000           [04] getglobal  2   2        ; R2 := sleep
0496  C1C00000           [05] loadk      3   3        ; R3 := 2000
049A  5CC08001           [06] call       1   3   3    ; R1, R2 := R1(R2, R3)
049E  CB004100           [07] self       3   0   260  ; R4 := R0; R3 := R0["unlock"]
04A2  DC400001           [08] call       3   2   1    ;  := R3(R4)
04A6  5A000000           [09] test       1       0    ; if R1 then pc+=1 (goto [11])
04AA  16C00080           [10] jmp        4            ; pc+=4 (goto [15])
04AE  C5400100           [11] getglobal  3   5        ; R3 := print
04B2  01810100           [12] loadk      4   6        ; R4 := "ok"
04B6  DC400001           [13] call       3   2   1    ;  := R3(R4)
04BA  16000180           [14] jmp        5            ; pc+=5 (goto [20])
04BE  C5400100           [15] getglobal  3   5        ; R3 := print
04C2  01C10100           [16] loadk      4   7        ; R4 := "error: "
04C6  40010001           [17] move       5   2        ; R5 := R2
04CA  15410102           [18] concat     4   4   5    ; R4 := R4..R5
04CE  DC400001           [19] call       3   2   1    ;  := R3(R4)
04D2  1E008000           [20] return     0   1        ; return 
                         * constants:
04D6  08000000           sizek (8)
04DA  04                 const type 4
04DB  0500000000000000   string size (5)
04E3  6C6F636B00         "lock\0"
                         const [0]: "lock"
04E8  04                 const type 4
04E9  0600000000000000   string size (6)
04F1  7063616C6C00       "pcall\0"
                         const [1]: "pcall"
04F7  04                 const type 4
04F8  0600000000000000   string size (6)
0500  736C65657000       "sleep\0"
                         const [2]: "sleep"
0506  03                 const type 3
0507  0000000000409F40   const [3]: (2000)
050F  04                 const type 4
0510  0700000000000000   string size (7)
0518  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
051F  04                 const type 4
0520  0600000000000000   string size (6)
0528  7072696E7400       "print\0"
                         const [5]: "print"
052E  04                 const type 4
052F  0300000000000000   string size (3)
0537  6F6B00             "ok\0"
                         const [6]: "ok"
053A  04                 const type 4
053B  0800000000000000   string size (8)
0543  6572726F723A2000   "error: \0"
                         const [7]: "error: "
                         * functions:
054B  00000000           sizep (0)
                         * lines:
054F  14000000           sizelineinfo (20)
                         [pc] (line)
0553  2D000000           [01] (45)
0557  2D000000           [02] (45)
055B  2E000000           [03] (46)
055F  2E000000           [04] (46)
0563  2E000000           [05] (46)
0567  2E000000           [06] (46)
056B  2F000000           [07] (47)
056F  2F000000           [08] (47)
0573  30000000           [09] (48)
0577  30000000           [10] (48)
057B  31000000           [11] (49)
057F  31000000           [12] (49)
0583  31000000           [13] (49)
0587  31000000           [14] (49)
058B  33000000           [15] (51)
058F  33000000           [16] (51)
0593  33000000           [17] (51)
0597  33000000           [18] (51)
059B  33000000           [19] (51)
059F  35000000           [20] (53)
                         * locals:
05A3  03000000           sizelocvars (3)
05A7  0500000000000000   string size (5)
05AF  6C6F636B00         "lock\0"
                         local [0]: lock
05B4  00000000             startpc (0)
05B8  13000000             endpc   (19)
05BC  0300000000000000   string size (3)
05C4  6F6B00             "ok\0"
                         local [1]: ok
05C7  06000000             startpc (6)
05CB  13000000             endpc   (19)
05CF  0400000000000000   string size (4)
05D7  6D736700           "msg\0"
                         local [2]: msg
05DB  06000000             startpc (6)
05DF  13000000             endpc   (19)
                         * upvalues:
05E3  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         * lines:
05E7  0B000000           sizelineinfo (11)
                         [pc] (line)
05EB  18000000           [01] (24)
05EF  10000000           [02] (16)
05F3  1E000000           [03] (30)
05F7  1A000000           [04] (26)
05FB  24000000           [05] (36)
05FF  20000000           [06] (32)
0603  2A000000           [07] (42)
0607  26000000           [08] (38)
060B  35000000           [09] (53)
060F  2C000000           [10] (44)
0613  35000000           [11] (53)
                         * locals:
0617  00000000           sizelocvars (0)
                         * upvalues:
061B  00000000           sizeupvalues (0)
                         ** end of function 0 **

061F                     ** end of chunk **
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
002A  02                 maxstacksize (2)
                         * code:
002B  0B000000           sizecode (11)
002F  24000000           [01] closure    0   0        ; R0 := closure(function[0]) 0 upvalues
0033  07000000           [02] setglobal  0   0        ; lock2seconds := R0
0037  24400000           [03] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
003B  07000000           [04] setglobal  0   0        ; lock2seconds := R0
003F  24800000           [05] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
0043  07000000           [06] setglobal  0   0        ; lock2seconds := R0
0047  24C00000           [07] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
004B  07000000           [08] setglobal  0   0        ; lock2seconds := R0
004F  24000100           [09] closure    0   4        ; R0 := closure(function[4]) 0 upvalues
0053  07000000           [10] setglobal  0   0        ; lock2seconds := R0
0057  1E008000           [11] return     0   1        ; return 
                         * constants:
005B  01000000           sizek (1)
005F  04                 const type 4
0060  0D00000000000000   string size (13)
0068  6C6F636B32736563+  "lock2sec"
0070  6F6E647300         "onds\0"
                         const [0]: "lock2seconds"
                         * functions:
0075  05000000           sizep (5)
                         
0079                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
0079  0000000000000000   string size (0)
                         source name: (none)
0081  10000000           line defined (16)
0085  18000000           last line defined (24)
0089  00                 nups (0)
008A  01                 numparams (1)
008B  00                 is_vararg (0)
008C  03                 maxstacksize (3)
                         * code:
008D  0D000000           sizecode (13)
0091  4B004000           [01] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
0095  5C800001           [02] call       1   2   2    ; R1 := R1(R2)
0099  5A400000           [03] test       1       1    ; if not R1 then pc+=1 (goto [5])
009D  16800080           [04] jmp        3            ; pc+=3 (goto [8])
00A1  45400000           [05] getglobal  1   1        ; R1 := error
00A5  81800000           [06] loadk      2   2        ; R2 := "Unable to acquire the lock!"
00A9  5C400001           [07] call       1   2   1    ;  := R1(R2)
00AD  45C00000           [08] getglobal  1   3        ; R1 := pcall
00B1  A4000000           [09] closure    2   0        ; R2 := closure(function[0]) 0 upvalues
00B5  5C400001           [10] call       1   2   1    ;  := R1(R2)
00B9  4B004100           [11] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
00BD  5C400001           [12] call       1   2   1    ;  := R1(R2)
00C1  1E008000           [13] return     0   1        ; return 
                         * constants:
00C5  05000000           sizek (5)
00C9  04                 const type 4
00CA  0800000000000000   string size (8)
00D2  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
00DA  04                 const type 4
00DB  0600000000000000   string size (6)
00E3  6572726F7200       "error\0"
                         const [1]: "error"
00E9  04                 const type 4
00EA  1C00000000000000   string size (28)
00F2  556E61626C652074+  "Unable t"
00FA  6F20616371756972+  "o acquir"
0102  6520746865206C6F+  "e the lo"
010A  636B2100           "ck!\0"
                         const [2]: "Unable to acquire the lock!"
010E  04                 const type 4
010F  0600000000000000   string size (6)
0117  7063616C6C00       "pcall\0"
                         const [3]: "pcall"
011D  04                 const type 4
011E  0700000000000000   string size (7)
0126  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
                         * functions:
012D  01000000           sizep (1)
                         
0131                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
0131  0000000000000000   string size (0)
                         source name: (none)
0139  14000000           line defined (20)
013D  16000000           last line defined (22)
0141  00                 nups (0)
0142  00                 numparams (0)
0143  00                 is_vararg (0)
0144  02                 maxstacksize (2)
                         * code:
0145  04000000           sizecode (4)
0149  05000000           [1] getglobal  0   0        ; R0 := sleep
014D  41400000           [2] loadk      1   1        ; R1 := 2000
0151  1C400001           [3] call       0   2   1    ;  := R0(R1)
0155  1E008000           [4] return     0   1        ; return 
                         * constants:
0159  02000000           sizek (2)
015D  04                 const type 4
015E  0600000000000000   string size (6)
0166  736C65657000       "sleep\0"
                         const [0]: "sleep"
016C  03                 const type 3
016D  0000000000409F40   const [1]: (2000)
                         * functions:
0175  00000000           sizep (0)
                         * lines:
0179  04000000           sizelineinfo (4)
                         [pc] (line)
017D  15000000           [1] (21)
0181  15000000           [2] (21)
0185  15000000           [3] (21)
0189  16000000           [4] (22)
                         * locals:
018D  00000000           sizelocvars (0)
                         * upvalues:
0191  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
0195  0D000000           sizelineinfo (13)
                         [pc] (line)
0199  11000000           [01] (17)
019D  11000000           [02] (17)
01A1  11000000           [03] (17)
01A5  11000000           [04] (17)
01A9  12000000           [05] (18)
01AD  12000000           [06] (18)
01B1  12000000           [07] (18)
01B5  14000000           [08] (20)
01B9  16000000           [09] (22)
01BD  14000000           [10] (20)
01C1  17000000           [11] (23)
01C5  17000000           [12] (23)
01C9  18000000           [13] (24)
                         * locals:
01CD  01000000           sizelocvars (1)
01D1  0500000000000000   string size (5)
01D9  6C6F636B00         "lock\0"
                         local [0]: lock
01DE  00000000             startpc (0)
01E2  0C000000             endpc   (12)
                         * upvalues:
01E6  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
01EA                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
01EA  0000000000000000   string size (0)
                         source name: (none)
01F2  1A000000           line defined (26)
01F6  1E000000           last line defined (30)
01FA  00                 nups (0)
01FB  01                 numparams (1)
01FC  00                 is_vararg (0)
01FD  03                 maxstacksize (3)
                         * code:
01FE  09000000           sizecode (9)
0202  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
0206  5C800001           [2] call       1   2   2    ; R1 := R1(R2)
020A  5A400000           [3] test       1       1    ; if not R1 then pc+=1 (goto [5])
020E  16C00080           [4] jmp        4            ; pc+=4 (goto [9])
0212  45400000           [5] getglobal  1   1        ; R1 := error
0216  8A400000           [6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
021A  89C04081           [7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
021E  5C400001           [8] call       1   2   1    ;  := R1(R2)
0222  1E008000           [9] return     0   1        ; return 
                         * constants:
0226  04000000           sizek (4)
022A  04                 const type 4
022B  0800000000000000   string size (8)
0233  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
023B  04                 const type 4
023C  0600000000000000   string size (6)
0244  6572726F7200       "error\0"
                         const [1]: "error"
024A  04                 const type 4
024B  0400000000000000   string size (4)
0253  65727200           "err\0"
                         const [2]: "err"
0257  04                 const type 4
0258  1C00000000000000   string size (28)
0260  556E61626C652074+  "Unable t"
0268  6F20616371756972+  "o acquir"
0270  6520746865206C6F+  "e the lo"
0278  636B2100           "ck!\0"
                         const [3]: "Unable to acquire the lock!"
                         * functions:
027C  00000000           sizep (0)
                         * lines:
0280  09000000           sizelineinfo (9)
                         [pc] (line)
0284  1B000000           [1] (27)
0288  1B000000           [2] (27)
028C  1B000000           [3] (27)
0290  1B000000           [4] (27)
0294  1C000000           [5] (28)
0298  1C000000           [6] (28)
029C  1C000000           [7] (28)
02A0  1C000000           [8] (28)
02A4  1E000000           [9] (30)
                         * locals:
02A8  01000000           sizelocvars (1)
02AC  0500000000000000   string size (5)
02B4  6C6F636B00         "lock\0"
                         local [0]: lock
02B9  00000000             startpc (0)
02BD  08000000             endpc   (8)
                         * upvalues:
02C1  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
02C5                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
02C5  0000000000000000   string size (0)
                         source name: (none)
02CD  20000000           line defined (32)
02D1  24000000           last line defined (36)
02D5  00                 nups (0)
02D6  01                 numparams (1)
02D7  00                 is_vararg (0)
02D8  03                 maxstacksize (3)
                         * code:
02D9  09000000           sizecode (9)
02DD  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["tryLock"]
02E1  5C800001           [2] call       1   2   2    ; R1 := R1(R2)
02E5  5A400000           [3] test       1       1    ; if not R1 then pc+=1 (goto [5])
02E9  16C00080           [4] jmp        4            ; pc+=4 (goto [9])
02ED  45400000           [5] getglobal  1   1        ; R1 := error
02F1  8A400000           [6] newtable   2   0   1    ; R2 := {} , array=0, hash=1
02F5  89C04081           [7] settable   2   258 259  ; R2["err"] := "Unable to acquire the lock!"
02F9  5C400001           [8] call       1   2   1    ;  := R1(R2)
02FD  1E008000           [9] return     0   1        ; return 
                         * constants:
0301  04000000           sizek (4)
0305  04                 const type 4
0306  0800000000000000   string size (8)
030E  7472794C6F636B00   "tryLock\0"
                         const [0]: "tryLock"
0316  04                 const type 4
0317  0600000000000000   string size (6)
031F  6572726F7200       "error\0"
                         const [1]: "error"
0325  04                 const type 4
0326  0400000000000000   string size (4)
032E  65727200           "err\0"
                         const [2]: "err"
0332  04                 const type 4
0333  1C00000000000000   string size (28)
033B  556E61626C652074+  "Unable t"
0343  6F20616371756972+  "o acquir"
034B  6520746865206C6F+  "e the lo"
0353  636B2100           "ck!\0"
                         const [3]: "Unable to acquire the lock!"
                         * functions:
0357  00000000           sizep (0)
                         * lines:
035B  09000000           sizelineinfo (9)
                         [pc] (line)
035F  21000000           [1] (33)
0363  21000000           [2] (33)
0367  21000000           [3] (33)
036B  21000000           [4] (33)
036F  22000000           [5] (34)
0373  22000000           [6] (34)
0377  22000000           [7] (34)
037B  22000000           [8] (34)
037F  24000000           [9] (36)
                         * locals:
0383  01000000           sizelocvars (1)
0387  0500000000000000   string size (5)
038F  6C6F636B00         "lock\0"
                         local [0]: lock
0394  00000000             startpc (0)
0398  08000000             endpc   (8)
                         * upvalues:
039C  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
03A0                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
03A0  0000000000000000   string size (0)
                         source name: (none)
03A8  26000000           line defined (38)
03AC  2A000000           last line defined (42)
03B0  00                 nups (0)
03B1  01                 numparams (1)
03B2  00                 is_vararg (0)
03B3  04                 maxstacksize (4)
                         * code:
03B4  09000000           sizecode (9)
03B8  4B004000           [1] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
03BC  5C400001           [2] call       1   2   1    ;  := R1(R2)
03C0  45400000           [3] getglobal  1   1        ; R1 := pcall
03C4  85800000           [4] getglobal  2   2        ; R2 := sleep
03C8  C1C00000           [5] loadk      3   3        ; R3 := 2000
03CC  5C408001           [6] call       1   3   1    ;  := R1(R2, R3)
03D0  4B004100           [7] self       1   0   260  ; R2 := R0; R1 := R0["unlock"]
03D4  5C400001           [8] call       1   2   1    ;  := R1(R2)
03D8  1E008000           [9] return     0   1        ; return 
                         * constants:
03DC  05000000           sizek (5)
03E0  04                 const type 4
03E1  0500000000000000   string size (5)
03E9  6C6F636B00         "lock\0"
                         const [0]: "lock"
03EE  04                 const type 4
03EF  0600000000000000   string size (6)
03F7  7063616C6C00       "pcall\0"
                         const [1]: "pcall"
03FD  04                 const type 4
03FE  0600000000000000   string size (6)
0406  736C65657000       "sleep\0"
                         const [2]: "sleep"
040C  03                 const type 3
040D  0000000000409F40   const [3]: (2000)
0415  04                 const type 4
0416  0700000000000000   string size (7)
041E  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
                         * functions:
0425  00000000           sizep (0)
                         * lines:
0429  09000000           sizelineinfo (9)
                         [pc] (line)
042D  27000000           [1] (39)
0431  27000000           [2] (39)
0435  28000000           [3] (40)
0439  28000000           [4] (40)
043D  28000000           [5] (40)
0441  28000000           [6] (40)
0445  29000000           [7] (41)
0449  29000000           [8] (41)
044D  2A000000           [9] (42)
                         * locals:
0451  01000000           sizelocvars (1)
0455  0500000000000000   string size (5)
045D  6C6F636B00         "lock\0"
                         local [0]: lock
0462  00000000             startpc (0)
0466  08000000             endpc   (8)
                         * upvalues:
046A  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         
046E                     ** function [4] definition (level 2) 0_4
                         ** start of function 0_4 **
046E  0000000000000000   string size (0)
                         source name: (none)
0476  2C000000           line defined (44)
047A  35000000           last line defined (53)
047E  00                 nups (0)
047F  01                 numparams (1)
0480  00                 is_vararg (0)
0481  06                 maxstacksize (6)
                         * code:
0482  14000000           sizecode (20)
0486  4B004000           [01] self       1   0   256  ; R2 := R0; R1 := R0["lock"]
048A  5C400001           [02] call       1   2   1    ;  := R1(R2)
048E  45400000           [03] getglobal  1   1        ; R1 := pcall
0492  85800000           [04] getglobal  2   2        ; R2 := sleep
0496  C1C00000           [05] loadk      3   3        ; R3 := 2000
049A  5CC08001           [06] call       1   3   3    ; R1, R2 := R1(R2, R3)
049E  CB004100           [07] self       3   0   260  ; R4 := R0; R3 := R0["unlock"]
04A2  DC400001           [08] call       3   2   1    ;  := R3(R4)
04A6  5A000000           [09] test       1       0    ; if R1 then pc+=1 (goto [11])
04AA  16C00080           [10] jmp        4            ; pc+=4 (goto [15])
04AE  C5400100           [11] getglobal  3   5        ; R3 := print
04B2  01810100           [12] loadk      4   6        ; R4 := "ok"
04B6  DC400001           [13] call       3   2   1    ;  := R3(R4)
04BA  16000180           [14] jmp        5            ; pc+=5 (goto [20])
04BE  C5400100           [15] getglobal  3   5        ; R3 := print
04C2  01C10100           [16] loadk      4   7        ; R4 := "error: "
04C6  40010001           [17] move       5   2        ; R5 := R2
04CA  15410102           [18] concat     4   4   5    ; R4 := R4..R5
04CE  DC400001           [19] call       3   2   1    ;  := R3(R4)
04D2  1E008000           [20] return     0   1        ; return 
                         * constants:
04D6  08000000           sizek (8)
04DA  04                 const type 4
04DB  0500000000000000   string size (5)
04E3  6C6F636B00         "lock\0"
                         const [0]: "lock"
04E8  04                 const type 4
04E9  0600000000000000   string size (6)
04F1  7063616C6C00       "pcall\0"
                         const [1]: "pcall"
04F7  04                 const type 4
04F8  0600000000000000   string size (6)
0500  736C65657000       "sleep\0"
                         const [2]: "sleep"
0506  03                 const type 3
0507  0000000000409F40   const [3]: (2000)
050F  04                 const type 4
0510  0700000000000000   string size (7)
0518  756E6C6F636B00     "unlock\0"
                         const [4]: "unlock"
051F  04                 const type 4
0520  0600000000000000   string size (6)
0528  7072696E7400       "print\0"
                         const [5]: "print"
052E  04                 const type 4
052F  0300000000000000   string size (3)
0537  6F6B00             "ok\0"
                         const [6]: "ok"
053A  04                 const type 4
053B  0800000000000000   string size (8)
0543  6572726F723A2000   "error: \0"
                         const [7]: "error: "
                         * functions:
054B  00000000           sizep (0)
                         * lines:
054F  14000000           sizelineinfo (20)
                         [pc] (line)
0553  2D000000           [01] (45)
0557  2D000000           [02] (45)
055B  2E000000           [03] (46)
055F  2E000000           [04] (46)
0563  2E000000           [05] (46)
0567  2E000000           [06] (46)
056B  2F000000           [07] (47)
056F  2F000000           [08] (47)
0573  30000000           [09] (48)
0577  30000000           [10] (48)
057B  31000000           [11] (49)
057F  31000000           [12] (49)
0583  31000000           [13] (49)
0587  31000000           [14] (49)
058B  33000000           [15] (51)
058F  33000000           [16] (51)
0593  33000000           [17] (51)
0597  33000000           [18] (51)
059B  33000000           [19] (51)
059F  35000000           [20] (53)
                         * locals:
05A3  03000000           sizelocvars (3)
05A7  0500000000000000   string size (5)
05AF  6C6F636B00         "lock\0"
                         local [0]: lock
05B4  00000000             startpc (0)
05B8  13000000             endpc   (19)
05BC  0300000000000000   string size (3)
05C4  6F6B00             "ok\0"
                         local [1]: ok
05C7  06000000             startpc (6)
05CB  13000000             endpc   (19)
05CF  0400000000000000   string size (4)
05D7  6D736700           "msg\0"
                         local [2]: msg
05DB  06000000             startpc (6)
05DF  13000000             endpc   (19)
                         * upvalues:
05E3  00000000           sizeupvalues (0)
                         ** end of function 0_4 **

                         * lines:
05E7  0B000000           sizelineinfo (11)
                         [pc] (line)
05EB  18000000           [01] (24)
05EF  10000000           [02] (16)
05F3  1E000000           [03] (30)
05F7  1A000000           [04] (26)
05FB  24000000           [05] (36)
05FF  20000000           [06] (32)
0603  2A000000           [07] (42)
0607  26000000           [08] (38)
060B  35000000           [09] (53)
060F  2C000000           [10] (44)
0613  35000000           [11] (53)
                         * locals:
0617  00000000           sizelocvars (0)
                         * upvalues:
061B  00000000           sizeupvalues (0)
                         ** end of function 0 **

061F                     ** end of chunk **
