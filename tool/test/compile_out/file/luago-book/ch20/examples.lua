------------------------------
mymod = dofile("mymod.file")
mymod.foo() --> foo
mymod.bar() --> bar

mymod = require "mymod"
mymod.foo() --> foo
mymod.bar() --> bar

package.loaded.mymod = "hello"
mymod = require "mymod"
print(mymod) --> hello

package.preload.mymod = function(modname)
  local loader = function(modname, extra)
    print("loading")
  end
  return loader, ""
end


function preloadSearcher(modname)
  if package.preload[modname] ~= nil then
    return package.preload[modname]
  else
    return "\n\tno field package.preload['" .. modname .. "']"
  end
end

function luaSearcher(modname)
  local file, err = package.searchpath(modname, package.path)
  if file ~= nil then
    return loadfile(file), modname
  else
    return err
  end
end

function require(modname)
  if package.loaded[nodname] ~= nil then
    return package.loaded[modname]
  end

  local err = "module '" .. name .. "' not found:"
  for i, searcher in ipairs(package.searchers) do
    local loader, extra = searcher(modname)
    if type(loader) == "function" then
      local mod = loader(modname, extra)
      package.loaded[modname] = mod
      return mod
    else
      err = err .. loader
    end
  end
  error(err)
end

------------------------------
success compiling learn.lua
; source chunk: learn.lua
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "mymod"  ; 0
.const  "dofile"  ; 1
.const  "mymod.file"  ; 2
.const  "foo"  ; 3
.const  "bar"  ; 4
.const  "require"  ; 5
.const  "package"  ; 6
.const  "loaded"  ; 7
.const  "hello"  ; 8
.const  "print"  ; 9
.const  "preload"  ; 10
.const  "preloadSearcher"  ; 11
.const  "luaSearcher"  ; 12
[01] getglobal  0   1        ; R0 := dofile
[02] loadk      1   2        ; R1 := "mymod.file"
[03] call       0   2   2    ; R0 := R0(R1)
[04] setglobal  0   0        ; mymod := R0
[05] getglobal  0   0        ; R0 := mymod
[06] gettable   0   0   259  ; R0 := R0["foo"]
[07] call       0   1   1    ;  := R0()
[08] getglobal  0   0        ; R0 := mymod
[09] gettable   0   0   260  ; R0 := R0["bar"]
[10] call       0   1   1    ;  := R0()
[11] getglobal  0   5        ; R0 := require
[12] loadk      1   0        ; R1 := "mymod"
[13] call       0   2   2    ; R0 := R0(R1)
[14] setglobal  0   0        ; mymod := R0
[15] getglobal  0   0        ; R0 := mymod
[16] gettable   0   0   259  ; R0 := R0["foo"]
[17] call       0   1   1    ;  := R0()
[18] getglobal  0   0        ; R0 := mymod
[19] gettable   0   0   260  ; R0 := R0["bar"]
[20] call       0   1   1    ;  := R0()
[21] getglobal  0   6        ; R0 := package
[22] gettable   0   0   263  ; R0 := R0["loaded"]
[23] settable   0   256 264  ; R0["mymod"] := "hello"
[24] getglobal  0   5        ; R0 := require
[25] loadk      1   0        ; R1 := "mymod"
[26] call       0   2   2    ; R0 := R0(R1)
[27] setglobal  0   0        ; mymod := R0
[28] getglobal  0   9        ; R0 := print
[29] getglobal  1   0        ; R1 := mymod
[30] call       0   2   1    ;  := R0(R1)
[31] getglobal  0   6        ; R0 := package
[32] gettable   0   0   266  ; R0 := R0["preload"]
[33] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[34] settable   0   256 1    ; R0["mymod"] := R1
[35] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[36] setglobal  0   11       ; preloadSearcher := R0
[37] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[38] setglobal  0   12       ; luaSearcher := R0
[39] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[40] setglobal  0   5        ; require := R0
[41] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "modname"  ; 0
.local  "loader"  ; 1
.const  ""  ; 0
[1] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[2] move       2   1        ; R2 := R1
[3] loadk      3   0        ; R3 := ""
[4] return     2   3        ; return R2, R3
[5] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "modname"  ; 0
.local  "extra"  ; 1
.const  "print"  ; 0
.const  "loading"  ; 1
[1] getglobal  2   0        ; R2 := print
[2] loadk      3   1        ; R3 := "loading"
[3] call       2   2   1    ;  := R2(R3)
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "modname"  ; 0
.const  "package"  ; 0
.const  "preload"  ; 1
.const  nil  ; 2
.const  "\n\tno field package.preload['"  ; 3
.const  "']"  ; 4
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["preload"]
[03] gettable   1   1   0    ; R1 := R1[R0]
[04] eq         1   1   258  ; R1 == nil, pc+=1 (goto [6]) if false
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  1   0        ; R1 := package
[07] gettable   1   1   257  ; R1 := R1["preload"]
[08] gettable   1   1   0    ; R1 := R1[R0]
[09] return     1   2        ; return R1
[10] jmp        5            ; pc+=5 (goto [16])
[11] loadk      1   3        ; R1 := "\n\tno field package.preload['"
[12] move       2   0        ; R2 := R0
[13] loadk      3   4        ; R3 := "']"
[14] concat     1   1   3    ; R1 := R1..R2..R3
[15] return     1   2        ; return R1
[16] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 5 stacks
.function  0 1 0 5
.local  "modname"  ; 0
.local  "file"  ; 1
.local  "err"  ; 2
.const  "package"  ; 0
.const  "searchpath"  ; 1
.const  "path"  ; 2
.const  nil  ; 3
.const  "loadfile"  ; 4
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["searchpath"]
[03] move       2   0        ; R2 := R0
[04] getglobal  3   0        ; R3 := package
[05] gettable   3   3   258  ; R3 := R3["path"]
[06] call       1   3   3    ; R1, R2 := R1(R2, R3)
[07] eq         1   1   259  ; R1 == nil, pc+=1 (goto [9]) if false
[08] jmp        6            ; pc+=6 (goto [15])
[09] getglobal  3   4        ; R3 := loadfile
[10] move       4   1        ; R4 := R1
[11] call       3   2   2    ; R3 := R3(R4)
[12] move       4   0        ; R4 := R0
[13] return     3   3        ; return R3, R4
[14] jmp        1            ; pc+=1 (goto [16])
[15] return     2   2        ; return R2
[16] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 1 params, is_vararg = 0, 12 stacks
.function  0 1 0 12
.local  "modname"  ; 0
.local  "err"  ; 1
.local  "(for generator)"  ; 2
.local  "(for state)"  ; 3
.local  "(for control)"  ; 4
.local  "i"  ; 5
.local  "searcher"  ; 6
.local  "loader"  ; 7
.local  "extra"  ; 8
.local  "mod"  ; 9
.const  "package"  ; 0
.const  "loaded"  ; 1
.const  "nodname"  ; 2
.const  nil  ; 3
.const  "module '"  ; 4
.const  "name"  ; 5
.const  "' not found:"  ; 6
.const  "ipairs"  ; 7
.const  "searchers"  ; 8
.const  "type"  ; 9
.const  "function"  ; 10
.const  "error"  ; 11
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["loaded"]
[03] getglobal  2   2        ; R2 := nodname
[04] gettable   1   1   2    ; R1 := R1[R2]
[05] eq         1   1   259  ; R1 == nil, pc+=1 (goto [7]) if false
[06] jmp        4            ; pc+=4 (goto [11])
[07] getglobal  1   0        ; R1 := package
[08] gettable   1   1   257  ; R1 := R1["loaded"]
[09] gettable   1   1   0    ; R1 := R1[R0]
[10] return     1   2        ; return R1
[11] loadk      1   4        ; R1 := "module '"
[12] getglobal  2   5        ; R2 := name
[13] loadk      3   6        ; R3 := "' not found:"
[14] concat     1   1   3    ; R1 := R1..R2..R3
[15] getglobal  2   7        ; R2 := ipairs
[16] getglobal  3   0        ; R3 := package
[17] gettable   3   3   264  ; R3 := R3["searchers"]
[18] call       2   2   4    ; R2 to R4 := R2(R3)
[19] jmp        20           ; pc+=20 (goto [40])
[20] move       7   6        ; R7 := R6
[21] move       8   0        ; R8 := R0
[22] call       7   2   3    ; R7, R8 := R7(R8)
[23] getglobal  9   9        ; R9 := type
[24] move       10  7        ; R10 := R7
[25] call       9   2   2    ; R9 := R9(R10)
[26] eq         0   9   266  ; R9 == "function", pc+=1 (goto [28]) if true
[27] jmp        9            ; pc+=9 (goto [37])
[28] move       9   7        ; R9 := R7
[29] move       10  0        ; R10 := R0
[30] move       11  8        ; R11 := R8
[31] call       9   3   2    ; R9 := R9(R10, R11)
[32] getglobal  10  0        ; R10 := package
[33] gettable   10  10  257  ; R10 := R10["loaded"]
[34] settable   10  0   9    ; R10[R0] := R9
[35] return     9   2        ; return R9
[36] jmp        3            ; pc+=3 (goto [40])
[37] move       9   1        ; R9 := R1
[38] move       10  7        ; R10 := R7
[39] concat     1   9   10   ; R1 := R9..R10
[40] tforloop   2       2    ; R5, R6 := R2(R3,R4); if R5 ~= nil then R4 := R5 else PC := 42
[41] jmp        -22          ; pc+=-22 (goto [20])
[42] getglobal  2   11       ; R2 := error
[43] move       3   1        ; R3 := R1
[44] call       2   2   1    ;  := R2(R3)
[45] return     0   1        ; return 
; end of function 0_3

; end of function 0

; source chunk: luac.out
; x86 standard (32-bit, little endian, doubles)

; function [0] definition (level 1) 0
; 0 upvalues, 0 params, is_vararg = 2, 2 stacks
.function  0 0 2 2
.const  "mymod"  ; 0
.const  "dofile"  ; 1
.const  "mymod.file"  ; 2
.const  "foo"  ; 3
.const  "bar"  ; 4
.const  "require"  ; 5
.const  "package"  ; 6
.const  "loaded"  ; 7
.const  "hello"  ; 8
.const  "print"  ; 9
.const  "preload"  ; 10
.const  "preloadSearcher"  ; 11
.const  "luaSearcher"  ; 12
[01] getglobal  0   1        ; R0 := dofile
[02] loadk      1   2        ; R1 := "mymod.file"
[03] call       0   2   2    ; R0 := R0(R1)
[04] setglobal  0   0        ; mymod := R0
[05] getglobal  0   0        ; R0 := mymod
[06] gettable   0   0   259  ; R0 := R0["foo"]
[07] call       0   1   1    ;  := R0()
[08] getglobal  0   0        ; R0 := mymod
[09] gettable   0   0   260  ; R0 := R0["bar"]
[10] call       0   1   1    ;  := R0()
[11] getglobal  0   5        ; R0 := require
[12] loadk      1   0        ; R1 := "mymod"
[13] call       0   2   2    ; R0 := R0(R1)
[14] setglobal  0   0        ; mymod := R0
[15] getglobal  0   0        ; R0 := mymod
[16] gettable   0   0   259  ; R0 := R0["foo"]
[17] call       0   1   1    ;  := R0()
[18] getglobal  0   0        ; R0 := mymod
[19] gettable   0   0   260  ; R0 := R0["bar"]
[20] call       0   1   1    ;  := R0()
[21] getglobal  0   6        ; R0 := package
[22] gettable   0   0   263  ; R0 := R0["loaded"]
[23] settable   0   256 264  ; R0["mymod"] := "hello"
[24] getglobal  0   5        ; R0 := require
[25] loadk      1   0        ; R1 := "mymod"
[26] call       0   2   2    ; R0 := R0(R1)
[27] setglobal  0   0        ; mymod := R0
[28] getglobal  0   9        ; R0 := print
[29] getglobal  1   0        ; R1 := mymod
[30] call       0   2   1    ;  := R0(R1)
[31] getglobal  0   6        ; R0 := package
[32] gettable   0   0   266  ; R0 := R0["preload"]
[33] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[34] settable   0   256 1    ; R0["mymod"] := R1
[35] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
[36] setglobal  0   11       ; preloadSearcher := R0
[37] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
[38] setglobal  0   12       ; luaSearcher := R0
[39] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
[40] setglobal  0   5        ; require := R0
[41] return     0   1        ; return 

; function [0] definition (level 2) 0_0
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "modname"  ; 0
.local  "loader"  ; 1
.const  ""  ; 0
[1] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
[2] move       2   1        ; R2 := R1
[3] loadk      3   0        ; R3 := ""
[4] return     2   3        ; return R2, R3
[5] return     0   1        ; return 

; function [0] definition (level 3) 0_0_0
; 0 upvalues, 2 params, is_vararg = 0, 4 stacks
.function  0 2 0 4
.local  "modname"  ; 0
.local  "extra"  ; 1
.const  "print"  ; 0
.const  "loading"  ; 1
[1] getglobal  2   0        ; R2 := print
[2] loadk      3   1        ; R3 := "loading"
[3] call       2   2   1    ;  := R2(R3)
[4] return     0   1        ; return 
; end of function 0_0_0

; end of function 0_0


; function [1] definition (level 2) 0_1
; 0 upvalues, 1 params, is_vararg = 0, 4 stacks
.function  0 1 0 4
.local  "modname"  ; 0
.const  "package"  ; 0
.const  "preload"  ; 1
.const  nil  ; 2
.const  "\n\tno field package.preload['"  ; 3
.const  "']"  ; 4
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["preload"]
[03] gettable   1   1   0    ; R1 := R1[R0]
[04] eq         1   1   258  ; R1 == nil, pc+=1 (goto [6]) if false
[05] jmp        5            ; pc+=5 (goto [11])
[06] getglobal  1   0        ; R1 := package
[07] gettable   1   1   257  ; R1 := R1["preload"]
[08] gettable   1   1   0    ; R1 := R1[R0]
[09] return     1   2        ; return R1
[10] jmp        5            ; pc+=5 (goto [16])
[11] loadk      1   3        ; R1 := "\n\tno field package.preload['"
[12] move       2   0        ; R2 := R0
[13] loadk      3   4        ; R3 := "']"
[14] concat     1   1   3    ; R1 := R1..R2..R3
[15] return     1   2        ; return R1
[16] return     0   1        ; return 
; end of function 0_1


; function [2] definition (level 2) 0_2
; 0 upvalues, 1 params, is_vararg = 0, 5 stacks
.function  0 1 0 5
.local  "modname"  ; 0
.local  "file"  ; 1
.local  "err"  ; 2
.const  "package"  ; 0
.const  "searchpath"  ; 1
.const  "path"  ; 2
.const  nil  ; 3
.const  "loadfile"  ; 4
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["searchpath"]
[03] move       2   0        ; R2 := R0
[04] getglobal  3   0        ; R3 := package
[05] gettable   3   3   258  ; R3 := R3["path"]
[06] call       1   3   3    ; R1, R2 := R1(R2, R3)
[07] eq         1   1   259  ; R1 == nil, pc+=1 (goto [9]) if false
[08] jmp        6            ; pc+=6 (goto [15])
[09] getglobal  3   4        ; R3 := loadfile
[10] move       4   1        ; R4 := R1
[11] call       3   2   2    ; R3 := R3(R4)
[12] move       4   0        ; R4 := R0
[13] return     3   3        ; return R3, R4
[14] jmp        1            ; pc+=1 (goto [16])
[15] return     2   2        ; return R2
[16] return     0   1        ; return 
; end of function 0_2


; function [3] definition (level 2) 0_3
; 0 upvalues, 1 params, is_vararg = 0, 12 stacks
.function  0 1 0 12
.local  "modname"  ; 0
.local  "err"  ; 1
.local  "(for generator)"  ; 2
.local  "(for state)"  ; 3
.local  "(for control)"  ; 4
.local  "i"  ; 5
.local  "searcher"  ; 6
.local  "loader"  ; 7
.local  "extra"  ; 8
.local  "mod"  ; 9
.const  "package"  ; 0
.const  "loaded"  ; 1
.const  "nodname"  ; 2
.const  nil  ; 3
.const  "module '"  ; 4
.const  "name"  ; 5
.const  "' not found:"  ; 6
.const  "ipairs"  ; 7
.const  "searchers"  ; 8
.const  "type"  ; 9
.const  "function"  ; 10
.const  "error"  ; 11
[01] getglobal  1   0        ; R1 := package
[02] gettable   1   1   257  ; R1 := R1["loaded"]
[03] getglobal  2   2        ; R2 := nodname
[04] gettable   1   1   2    ; R1 := R1[R2]
[05] eq         1   1   259  ; R1 == nil, pc+=1 (goto [7]) if false
[06] jmp        4            ; pc+=4 (goto [11])
[07] getglobal  1   0        ; R1 := package
[08] gettable   1   1   257  ; R1 := R1["loaded"]
[09] gettable   1   1   0    ; R1 := R1[R0]
[10] return     1   2        ; return R1
[11] loadk      1   4        ; R1 := "module '"
[12] getglobal  2   5        ; R2 := name
[13] loadk      3   6        ; R3 := "' not found:"
[14] concat     1   1   3    ; R1 := R1..R2..R3
[15] getglobal  2   7        ; R2 := ipairs
[16] getglobal  3   0        ; R3 := package
[17] gettable   3   3   264  ; R3 := R3["searchers"]
[18] call       2   2   4    ; R2 to R4 := R2(R3)
[19] jmp        20           ; pc+=20 (goto [40])
[20] move       7   6        ; R7 := R6
[21] move       8   0        ; R8 := R0
[22] call       7   2   3    ; R7, R8 := R7(R8)
[23] getglobal  9   9        ; R9 := type
[24] move       10  7        ; R10 := R7
[25] call       9   2   2    ; R9 := R9(R10)
[26] eq         0   9   266  ; R9 == "function", pc+=1 (goto [28]) if true
[27] jmp        9            ; pc+=9 (goto [37])
[28] move       9   7        ; R9 := R7
[29] move       10  0        ; R10 := R0
[30] move       11  8        ; R11 := R8
[31] call       9   3   2    ; R9 := R9(R10, R11)
[32] getglobal  10  0        ; R10 := package
[33] gettable   10  10  257  ; R10 := R10["loaded"]
[34] settable   10  0   9    ; R10[R0] := R9
[35] return     9   2        ; return R9
[36] jmp        3            ; pc+=3 (goto [40])
[37] move       9   1        ; R9 := R1
[38] move       10  7        ; R10 := R7
[39] concat     1   9   10   ; R1 := R9..R10
[40] tforloop   2       2    ; R5, R6 := R2(R3,R4); if R5 ~= nil then R4 := R5 else PC := 42
[41] jmp        -22          ; pc+=-22 (goto [20])
[42] getglobal  2   11       ; R2 := error
[43] move       3   1        ; R3 := R1
[44] call       2   2   1    ;  := R2(R3)
[45] return     0   1        ; return 
; end of function 0_3

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
002B  29000000           sizecode (41)
002F  05400000           [01] getglobal  0   1        ; R0 := dofile
0033  41800000           [02] loadk      1   2        ; R1 := "mymod.file"
0037  1C800001           [03] call       0   2   2    ; R0 := R0(R1)
003B  07000000           [04] setglobal  0   0        ; mymod := R0
003F  05000000           [05] getglobal  0   0        ; R0 := mymod
0043  06C04000           [06] gettable   0   0   259  ; R0 := R0["foo"]
0047  1C408000           [07] call       0   1   1    ;  := R0()
004B  05000000           [08] getglobal  0   0        ; R0 := mymod
004F  06004100           [09] gettable   0   0   260  ; R0 := R0["bar"]
0053  1C408000           [10] call       0   1   1    ;  := R0()
0057  05400100           [11] getglobal  0   5        ; R0 := require
005B  41000000           [12] loadk      1   0        ; R1 := "mymod"
005F  1C800001           [13] call       0   2   2    ; R0 := R0(R1)
0063  07000000           [14] setglobal  0   0        ; mymod := R0
0067  05000000           [15] getglobal  0   0        ; R0 := mymod
006B  06C04000           [16] gettable   0   0   259  ; R0 := R0["foo"]
006F  1C408000           [17] call       0   1   1    ;  := R0()
0073  05000000           [18] getglobal  0   0        ; R0 := mymod
0077  06004100           [19] gettable   0   0   260  ; R0 := R0["bar"]
007B  1C408000           [20] call       0   1   1    ;  := R0()
007F  05800100           [21] getglobal  0   6        ; R0 := package
0083  06C04100           [22] gettable   0   0   263  ; R0 := R0["loaded"]
0087  09004280           [23] settable   0   256 264  ; R0["mymod"] := "hello"
008B  05400100           [24] getglobal  0   5        ; R0 := require
008F  41000000           [25] loadk      1   0        ; R1 := "mymod"
0093  1C800001           [26] call       0   2   2    ; R0 := R0(R1)
0097  07000000           [27] setglobal  0   0        ; mymod := R0
009B  05400200           [28] getglobal  0   9        ; R0 := print
009F  45000000           [29] getglobal  1   0        ; R1 := mymod
00A3  1C400001           [30] call       0   2   1    ;  := R0(R1)
00A7  05800100           [31] getglobal  0   6        ; R0 := package
00AB  06804200           [32] gettable   0   0   266  ; R0 := R0["preload"]
00AF  64000000           [33] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
00B3  09400080           [34] settable   0   256 1    ; R0["mymod"] := R1
00B7  24400000           [35] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
00BB  07C00200           [36] setglobal  0   11       ; preloadSearcher := R0
00BF  24800000           [37] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
00C3  07000300           [38] setglobal  0   12       ; luaSearcher := R0
00C7  24C00000           [39] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
00CB  07400100           [40] setglobal  0   5        ; require := R0
00CF  1E008000           [41] return     0   1        ; return 
                         * constants:
00D3  0D000000           sizek (13)
00D7  04                 const type 4
00D8  0600000000000000   string size (6)
00E0  6D796D6F6400       "mymod\0"
                         const [0]: "mymod"
00E6  04                 const type 4
00E7  0700000000000000   string size (7)
00EF  646F66696C6500     "dofile\0"
                         const [1]: "dofile"
00F6  04                 const type 4
00F7  0B00000000000000   string size (11)
00FF  6D796D6F642E6669+  "mymod.fi"
0107  6C6500             "le\0"
                         const [2]: "mymod.file"
010A  04                 const type 4
010B  0400000000000000   string size (4)
0113  666F6F00           "foo\0"
                         const [3]: "foo"
0117  04                 const type 4
0118  0400000000000000   string size (4)
0120  62617200           "bar\0"
                         const [4]: "bar"
0124  04                 const type 4
0125  0800000000000000   string size (8)
012D  7265717569726500   "require\0"
                         const [5]: "require"
0135  04                 const type 4
0136  0800000000000000   string size (8)
013E  7061636B61676500   "package\0"
                         const [6]: "package"
0146  04                 const type 4
0147  0700000000000000   string size (7)
014F  6C6F6164656400     "loaded\0"
                         const [7]: "loaded"
0156  04                 const type 4
0157  0600000000000000   string size (6)
015F  68656C6C6F00       "hello\0"
                         const [8]: "hello"
0165  04                 const type 4
0166  0600000000000000   string size (6)
016E  7072696E7400       "print\0"
                         const [9]: "print"
0174  04                 const type 4
0175  0800000000000000   string size (8)
017D  7072656C6F616400   "preload\0"
                         const [10]: "preload"
0185  04                 const type 4
0186  1000000000000000   string size (16)
018E  7072656C6F616453+  "preloadS"
0196  6561726368657200   "earcher\0"
                         const [11]: "preloadSearcher"
019E  04                 const type 4
019F  0C00000000000000   string size (12)
01A7  6C75615365617263+  "luaSearc"
01AF  68657200           "her\0"
                         const [12]: "luaSearcher"
                         * functions:
01B3  04000000           sizep (4)
                         
01B7                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
01B7  0000000000000000   string size (0)
                         source name: (none)
01BF  0D000000           line defined (13)
01C3  12000000           last line defined (18)
01C7  00                 nups (0)
01C8  01                 numparams (1)
01C9  00                 is_vararg (0)
01CA  04                 maxstacksize (4)
                         * code:
01CB  05000000           sizecode (5)
01CF  64000000           [1] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
01D3  80008000           [2] move       2   1        ; R2 := R1
01D7  C1000000           [3] loadk      3   0        ; R3 := ""
01DB  9E008001           [4] return     2   3        ; return R2, R3
01DF  1E008000           [5] return     0   1        ; return 
                         * constants:
01E3  01000000           sizek (1)
01E7  04                 const type 4
01E8  0100000000000000   string size (0)
                         const [0]: ""
                         * functions:
01F1  01000000           sizep (1)
                         
01F5                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
01F5  0000000000000000   string size (0)
                         source name: (none)
01FD  0E000000           line defined (14)
0201  10000000           last line defined (16)
0205  00                 nups (0)
0206  02                 numparams (2)
0207  00                 is_vararg (0)
0208  04                 maxstacksize (4)
                         * code:
0209  04000000           sizecode (4)
020D  85000000           [1] getglobal  2   0        ; R2 := print
0211  C1400000           [2] loadk      3   1        ; R3 := "loading"
0215  9C400001           [3] call       2   2   1    ;  := R2(R3)
0219  1E008000           [4] return     0   1        ; return 
                         * constants:
021D  02000000           sizek (2)
0221  04                 const type 4
0222  0600000000000000   string size (6)
022A  7072696E7400       "print\0"
                         const [0]: "print"
0230  04                 const type 4
0231  0800000000000000   string size (8)
0239  6C6F6164696E6700   "loading\0"
                         const [1]: "loading"
                         * functions:
0241  00000000           sizep (0)
                         * lines:
0245  04000000           sizelineinfo (4)
                         [pc] (line)
0249  0F000000           [1] (15)
024D  0F000000           [2] (15)
0251  0F000000           [3] (15)
0255  10000000           [4] (16)
                         * locals:
0259  02000000           sizelocvars (2)
025D  0800000000000000   string size (8)
0265  6D6F646E616D6500   "modname\0"
                         local [0]: modname
026D  00000000             startpc (0)
0271  03000000             endpc   (3)
0275  0600000000000000   string size (6)
027D  657874726100       "extra\0"
                         local [1]: extra
0283  00000000             startpc (0)
0287  03000000             endpc   (3)
                         * upvalues:
028B  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
028F  05000000           sizelineinfo (5)
                         [pc] (line)
0293  10000000           [1] (16)
0297  11000000           [2] (17)
029B  11000000           [3] (17)
029F  11000000           [4] (17)
02A3  12000000           [5] (18)
                         * locals:
02A7  02000000           sizelocvars (2)
02AB  0800000000000000   string size (8)
02B3  6D6F646E616D6500   "modname\0"
                         local [0]: modname
02BB  00000000             startpc (0)
02BF  04000000             endpc   (4)
02C3  0700000000000000   string size (7)
02CB  6C6F6164657200     "loader\0"
                         local [1]: loader
02D2  01000000             startpc (1)
02D6  04000000             endpc   (4)
                         * upvalues:
02DA  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
02DE                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
02DE  0000000000000000   string size (0)
                         source name: (none)
02E6  15000000           line defined (21)
02EA  1B000000           last line defined (27)
02EE  00                 nups (0)
02EF  01                 numparams (1)
02F0  00                 is_vararg (0)
02F1  04                 maxstacksize (4)
                         * code:
02F2  10000000           sizecode (16)
02F6  45000000           [01] getglobal  1   0        ; R1 := package
02FA  4640C000           [02] gettable   1   1   257  ; R1 := R1["preload"]
02FE  46008000           [03] gettable   1   1   0    ; R1 := R1[R0]
0302  5780C000           [04] eq         1   1   258  ; R1 == nil, pc+=1 (goto [6]) if false
0306  16000180           [05] jmp        5            ; pc+=5 (goto [11])
030A  45000000           [06] getglobal  1   0        ; R1 := package
030E  4640C000           [07] gettable   1   1   257  ; R1 := R1["preload"]
0312  46008000           [08] gettable   1   1   0    ; R1 := R1[R0]
0316  5E000001           [09] return     1   2        ; return R1
031A  16000180           [10] jmp        5            ; pc+=5 (goto [16])
031E  41C00000           [11] loadk      1   3        ; R1 := "\n\tno field package.preload['"
0322  80000000           [12] move       2   0        ; R2 := R0
0326  C1000100           [13] loadk      3   4        ; R3 := "']"
032A  55C08000           [14] concat     1   1   3    ; R1 := R1..R2..R3
032E  5E000001           [15] return     1   2        ; return R1
0332  1E008000           [16] return     0   1        ; return 
                         * constants:
0336  05000000           sizek (5)
033A  04                 const type 4
033B  0800000000000000   string size (8)
0343  7061636B61676500   "package\0"
                         const [0]: "package"
034B  04                 const type 4
034C  0800000000000000   string size (8)
0354  7072656C6F616400   "preload\0"
                         const [1]: "preload"
035C  00                 const type 0
                         const [2]: nil
035D  04                 const type 4
035E  1D00000000000000   string size (29)
0366  0A096E6F20666965+  "\n\tno fie"
036E  6C64207061636B61+  "ld packa"
0376  67652E7072656C6F+  "ge.prelo"
037E  61645B2700         "ad['\0"
                         const [3]: "\n\tno field package.preload['"
0383  04                 const type 4
0384  0300000000000000   string size (3)
038C  275D00             "']\0"
                         const [4]: "']"
                         * functions:
038F  00000000           sizep (0)
                         * lines:
0393  10000000           sizelineinfo (16)
                         [pc] (line)
0397  16000000           [01] (22)
039B  16000000           [02] (22)
039F  16000000           [03] (22)
03A3  16000000           [04] (22)
03A7  16000000           [05] (22)
03AB  17000000           [06] (23)
03AF  17000000           [07] (23)
03B3  17000000           [08] (23)
03B7  17000000           [09] (23)
03BB  17000000           [10] (23)
03BF  19000000           [11] (25)
03C3  19000000           [12] (25)
03C7  19000000           [13] (25)
03CB  19000000           [14] (25)
03CF  19000000           [15] (25)
03D3  1B000000           [16] (27)
                         * locals:
03D7  01000000           sizelocvars (1)
03DB  0800000000000000   string size (8)
03E3  6D6F646E616D6500   "modname\0"
                         local [0]: modname
03EB  00000000             startpc (0)
03EF  0F000000             endpc   (15)
                         * upvalues:
03F3  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
03F7                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
03F7  0000000000000000   string size (0)
                         source name: (none)
03FF  1D000000           line defined (29)
0403  24000000           last line defined (36)
0407  00                 nups (0)
0408  01                 numparams (1)
0409  00                 is_vararg (0)
040A  05                 maxstacksize (5)
                         * code:
040B  10000000           sizecode (16)
040F  45000000           [01] getglobal  1   0        ; R1 := package
0413  4640C000           [02] gettable   1   1   257  ; R1 := R1["searchpath"]
0417  80000000           [03] move       2   0        ; R2 := R0
041B  C5000000           [04] getglobal  3   0        ; R3 := package
041F  C680C001           [05] gettable   3   3   258  ; R3 := R3["path"]
0423  5CC08001           [06] call       1   3   3    ; R1, R2 := R1(R2, R3)
0427  57C0C000           [07] eq         1   1   259  ; R1 == nil, pc+=1 (goto [9]) if false
042B  16400180           [08] jmp        6            ; pc+=6 (goto [15])
042F  C5000100           [09] getglobal  3   4        ; R3 := loadfile
0433  00018000           [10] move       4   1        ; R4 := R1
0437  DC800001           [11] call       3   2   2    ; R3 := R3(R4)
043B  00010000           [12] move       4   0        ; R4 := R0
043F  DE008001           [13] return     3   3        ; return R3, R4
0443  16000080           [14] jmp        1            ; pc+=1 (goto [16])
0447  9E000001           [15] return     2   2        ; return R2
044B  1E008000           [16] return     0   1        ; return 
                         * constants:
044F  05000000           sizek (5)
0453  04                 const type 4
0454  0800000000000000   string size (8)
045C  7061636B61676500   "package\0"
                         const [0]: "package"
0464  04                 const type 4
0465  0B00000000000000   string size (11)
046D  7365617263687061+  "searchpa"
0475  746800             "th\0"
                         const [1]: "searchpath"
0478  04                 const type 4
0479  0500000000000000   string size (5)
0481  7061746800         "path\0"
                         const [2]: "path"
0486  00                 const type 0
                         const [3]: nil
0487  04                 const type 4
0488  0900000000000000   string size (9)
0490  6C6F616466696C65+  "loadfile"
0498  00                 "\0"
                         const [4]: "loadfile"
                         * functions:
0499  00000000           sizep (0)
                         * lines:
049D  10000000           sizelineinfo (16)
                         [pc] (line)
04A1  1E000000           [01] (30)
04A5  1E000000           [02] (30)
04A9  1E000000           [03] (30)
04AD  1E000000           [04] (30)
04B1  1E000000           [05] (30)
04B5  1E000000           [06] (30)
04B9  1F000000           [07] (31)
04BD  1F000000           [08] (31)
04C1  20000000           [09] (32)
04C5  20000000           [10] (32)
04C9  20000000           [11] (32)
04CD  20000000           [12] (32)
04D1  20000000           [13] (32)
04D5  20000000           [14] (32)
04D9  22000000           [15] (34)
04DD  24000000           [16] (36)
                         * locals:
04E1  03000000           sizelocvars (3)
04E5  0800000000000000   string size (8)
04ED  6D6F646E616D6500   "modname\0"
                         local [0]: modname
04F5  00000000             startpc (0)
04F9  0F000000             endpc   (15)
04FD  0500000000000000   string size (5)
0505  66696C6500         "file\0"
                         local [1]: file
050A  06000000             startpc (6)
050E  0F000000             endpc   (15)
0512  0400000000000000   string size (4)
051A  65727200           "err\0"
                         local [2]: err
051E  06000000             startpc (6)
0522  0F000000             endpc   (15)
                         * upvalues:
0526  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
052A                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
052A  0000000000000000   string size (0)
                         source name: (none)
0532  26000000           line defined (38)
0536  37000000           last line defined (55)
053A  00                 nups (0)
053B  01                 numparams (1)
053C  00                 is_vararg (0)
053D  0C                 maxstacksize (12)
                         * code:
053E  2D000000           sizecode (45)
0542  45000000           [01] getglobal  1   0        ; R1 := package
0546  4640C000           [02] gettable   1   1   257  ; R1 := R1["loaded"]
054A  85800000           [03] getglobal  2   2        ; R2 := nodname
054E  46808000           [04] gettable   1   1   2    ; R1 := R1[R2]
0552  57C0C000           [05] eq         1   1   259  ; R1 == nil, pc+=1 (goto [7]) if false
0556  16C00080           [06] jmp        4            ; pc+=4 (goto [11])
055A  45000000           [07] getglobal  1   0        ; R1 := package
055E  4640C000           [08] gettable   1   1   257  ; R1 := R1["loaded"]
0562  46008000           [09] gettable   1   1   0    ; R1 := R1[R0]
0566  5E000001           [10] return     1   2        ; return R1
056A  41000100           [11] loadk      1   4        ; R1 := "module '"
056E  85400100           [12] getglobal  2   5        ; R2 := name
0572  C1800100           [13] loadk      3   6        ; R3 := "' not found:"
0576  55C08000           [14] concat     1   1   3    ; R1 := R1..R2..R3
057A  85C00100           [15] getglobal  2   7        ; R2 := ipairs
057E  C5000000           [16] getglobal  3   0        ; R3 := package
0582  C600C201           [17] gettable   3   3   264  ; R3 := R3["searchers"]
0586  9C000101           [18] call       2   2   4    ; R2 to R4 := R2(R3)
058A  16C00480           [19] jmp        20           ; pc+=20 (goto [40])
058E  C0010003           [20] move       7   6        ; R7 := R6
0592  00020000           [21] move       8   0        ; R8 := R0
0596  DCC10001           [22] call       7   2   3    ; R7, R8 := R7(R8)
059A  45420200           [23] getglobal  9   9        ; R9 := type
059E  80028003           [24] move       10  7        ; R10 := R7
05A2  5C820001           [25] call       9   2   2    ; R9 := R9(R10)
05A6  1780C204           [26] eq         0   9   266  ; R9 == "function", pc+=1 (goto [28]) if true
05AA  16000280           [27] jmp        9            ; pc+=9 (goto [37])
05AE  40028003           [28] move       9   7        ; R9 := R7
05B2  80020000           [29] move       10  0        ; R10 := R0
05B6  C0020004           [30] move       11  8        ; R11 := R8
05BA  5C828001           [31] call       9   3   2    ; R9 := R9(R10, R11)
05BE  85020000           [32] getglobal  10  0        ; R10 := package
05C2  86424005           [33] gettable   10  10  257  ; R10 := R10["loaded"]
05C6  89420200           [34] settable   10  0   9    ; R10[R0] := R9
05CA  5E020001           [35] return     9   2        ; return R9
05CE  16800080           [36] jmp        3            ; pc+=3 (goto [40])
05D2  40028000           [37] move       9   1        ; R9 := R1
05D6  80028003           [38] move       10  7        ; R10 := R7
05DA  55808204           [39] concat     1   9   10   ; R1 := R9..R10
05DE  A1800000           [40] tforloop   2       2    ; R5, R6 := R2(R3,R4); if R5 ~= nil then R4 := R5 else PC := 42
05E2  1640FA7F           [41] jmp        -22          ; pc+=-22 (goto [20])
05E6  85C00200           [42] getglobal  2   11       ; R2 := error
05EA  C0008000           [43] move       3   1        ; R3 := R1
05EE  9C400001           [44] call       2   2   1    ;  := R2(R3)
05F2  1E008000           [45] return     0   1        ; return 
                         * constants:
05F6  0C000000           sizek (12)
05FA  04                 const type 4
05FB  0800000000000000   string size (8)
0603  7061636B61676500   "package\0"
                         const [0]: "package"
060B  04                 const type 4
060C  0700000000000000   string size (7)
0614  6C6F6164656400     "loaded\0"
                         const [1]: "loaded"
061B  04                 const type 4
061C  0800000000000000   string size (8)
0624  6E6F646E616D6500   "nodname\0"
                         const [2]: "nodname"
062C  00                 const type 0
                         const [3]: nil
062D  04                 const type 4
062E  0900000000000000   string size (9)
0636  6D6F64756C652027+  "module '"
063E  00                 "\0"
                         const [4]: "module '"
063F  04                 const type 4
0640  0500000000000000   string size (5)
0648  6E616D6500         "name\0"
                         const [5]: "name"
064D  04                 const type 4
064E  0D00000000000000   string size (13)
0656  27206E6F7420666F+  "' not fo"
065E  756E643A00         "und:\0"
                         const [6]: "' not found:"
0663  04                 const type 4
0664  0700000000000000   string size (7)
066C  69706169727300     "ipairs\0"
                         const [7]: "ipairs"
0673  04                 const type 4
0674  0A00000000000000   string size (10)
067C  7365617263686572+  "searcher"
0684  7300               "s\0"
                         const [8]: "searchers"
0686  04                 const type 4
0687  0500000000000000   string size (5)
068F  7479706500         "type\0"
                         const [9]: "type"
0694  04                 const type 4
0695  0900000000000000   string size (9)
069D  66756E6374696F6E+  "function"
06A5  00                 "\0"
                         const [10]: "function"
06A6  04                 const type 4
06A7  0600000000000000   string size (6)
06AF  6572726F7200       "error\0"
                         const [11]: "error"
                         * functions:
06B5  00000000           sizep (0)
                         * lines:
06B9  2D000000           sizelineinfo (45)
                         [pc] (line)
06BD  27000000           [01] (39)
06C1  27000000           [02] (39)
06C5  27000000           [03] (39)
06C9  27000000           [04] (39)
06CD  27000000           [05] (39)
06D1  27000000           [06] (39)
06D5  28000000           [07] (40)
06D9  28000000           [08] (40)
06DD  28000000           [09] (40)
06E1  28000000           [10] (40)
06E5  2B000000           [11] (43)
06E9  2B000000           [12] (43)
06ED  2B000000           [13] (43)
06F1  2B000000           [14] (43)
06F5  2C000000           [15] (44)
06F9  2C000000           [16] (44)
06FD  2C000000           [17] (44)
0701  2C000000           [18] (44)
0705  2C000000           [19] (44)
0709  2D000000           [20] (45)
070D  2D000000           [21] (45)
0711  2D000000           [22] (45)
0715  2E000000           [23] (46)
0719  2E000000           [24] (46)
071D  2E000000           [25] (46)
0721  2E000000           [26] (46)
0725  2E000000           [27] (46)
0729  2F000000           [28] (47)
072D  2F000000           [29] (47)
0731  2F000000           [30] (47)
0735  2F000000           [31] (47)
0739  30000000           [32] (48)
073D  30000000           [33] (48)
0741  30000000           [34] (48)
0745  31000000           [35] (49)
0749  31000000           [36] (49)
074D  33000000           [37] (51)
0751  33000000           [38] (51)
0755  33000000           [39] (51)
0759  2C000000           [40] (44)
075D  34000000           [41] (52)
0761  36000000           [42] (54)
0765  36000000           [43] (54)
0769  36000000           [44] (54)
076D  37000000           [45] (55)
                         * locals:
0771  0A000000           sizelocvars (10)
0775  0800000000000000   string size (8)
077D  6D6F646E616D6500   "modname\0"
                         local [0]: modname
0785  00000000             startpc (0)
0789  2C000000             endpc   (44)
078D  0400000000000000   string size (4)
0795  65727200           "err\0"
                         local [1]: err
0799  0E000000             startpc (14)
079D  2C000000             endpc   (44)
07A1  1000000000000000   string size (16)
07A9  28666F722067656E+  "(for gen"
07B1  657261746F722900   "erator)\0"
                         local [2]: (for generator)
07B9  12000000             startpc (18)
07BD  29000000             endpc   (41)
07C1  0C00000000000000   string size (12)
07C9  28666F7220737461+  "(for sta"
07D1  74652900           "te)\0"
                         local [3]: (for state)
07D5  12000000             startpc (18)
07D9  29000000             endpc   (41)
07DD  0E00000000000000   string size (14)
07E5  28666F7220636F6E+  "(for con"
07ED  74726F6C2900       "trol)\0"
                         local [4]: (for control)
07F3  12000000             startpc (18)
07F7  29000000             endpc   (41)
07FB  0200000000000000   string size (2)
0803  6900               "i\0"
                         local [5]: i
0805  13000000             startpc (19)
0809  27000000             endpc   (39)
080D  0900000000000000   string size (9)
0815  7365617263686572+  "searcher"
081D  00                 "\0"
                         local [6]: searcher
081E  13000000             startpc (19)
0822  27000000             endpc   (39)
0826  0700000000000000   string size (7)
082E  6C6F6164657200     "loader\0"
                         local [7]: loader
0835  16000000             startpc (22)
0839  27000000             endpc   (39)
083D  0600000000000000   string size (6)
0845  657874726100       "extra\0"
                         local [8]: extra
084B  16000000             startpc (22)
084F  27000000             endpc   (39)
0853  0400000000000000   string size (4)
085B  6D6F6400           "mod\0"
                         local [9]: mod
085F  1F000000             startpc (31)
0863  23000000             endpc   (35)
                         * upvalues:
0867  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
086B  29000000           sizelineinfo (41)
                         [pc] (line)
086F  01000000           [01] (1)
0873  01000000           [02] (1)
0877  01000000           [03] (1)
087B  01000000           [04] (1)
087F  02000000           [05] (2)
0883  02000000           [06] (2)
0887  02000000           [07] (2)
088B  03000000           [08] (3)
088F  03000000           [09] (3)
0893  03000000           [10] (3)
0897  05000000           [11] (5)
089B  05000000           [12] (5)
089F  05000000           [13] (5)
08A3  05000000           [14] (5)
08A7  06000000           [15] (6)
08AB  06000000           [16] (6)
08AF  06000000           [17] (6)
08B3  07000000           [18] (7)
08B7  07000000           [19] (7)
08BB  07000000           [20] (7)
08BF  09000000           [21] (9)
08C3  09000000           [22] (9)
08C7  09000000           [23] (9)
08CB  0A000000           [24] (10)
08CF  0A000000           [25] (10)
08D3  0A000000           [26] (10)
08D7  0A000000           [27] (10)
08DB  0B000000           [28] (11)
08DF  0B000000           [29] (11)
08E3  0B000000           [30] (11)
08E7  0D000000           [31] (13)
08EB  0D000000           [32] (13)
08EF  12000000           [33] (18)
08F3  12000000           [34] (18)
08F7  1B000000           [35] (27)
08FB  15000000           [36] (21)
08FF  24000000           [37] (36)
0903  1D000000           [38] (29)
0907  37000000           [39] (55)
090B  26000000           [40] (38)
090F  37000000           [41] (55)
                         * locals:
0913  00000000           sizelocvars (0)
                         * upvalues:
0917  00000000           sizeupvalues (0)
                         ** end of function 0 **

091B                     ** end of chunk **
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
002B  29000000           sizecode (41)
002F  05400000           [01] getglobal  0   1        ; R0 := dofile
0033  41800000           [02] loadk      1   2        ; R1 := "mymod.file"
0037  1C800001           [03] call       0   2   2    ; R0 := R0(R1)
003B  07000000           [04] setglobal  0   0        ; mymod := R0
003F  05000000           [05] getglobal  0   0        ; R0 := mymod
0043  06C04000           [06] gettable   0   0   259  ; R0 := R0["foo"]
0047  1C408000           [07] call       0   1   1    ;  := R0()
004B  05000000           [08] getglobal  0   0        ; R0 := mymod
004F  06004100           [09] gettable   0   0   260  ; R0 := R0["bar"]
0053  1C408000           [10] call       0   1   1    ;  := R0()
0057  05400100           [11] getglobal  0   5        ; R0 := require
005B  41000000           [12] loadk      1   0        ; R1 := "mymod"
005F  1C800001           [13] call       0   2   2    ; R0 := R0(R1)
0063  07000000           [14] setglobal  0   0        ; mymod := R0
0067  05000000           [15] getglobal  0   0        ; R0 := mymod
006B  06C04000           [16] gettable   0   0   259  ; R0 := R0["foo"]
006F  1C408000           [17] call       0   1   1    ;  := R0()
0073  05000000           [18] getglobal  0   0        ; R0 := mymod
0077  06004100           [19] gettable   0   0   260  ; R0 := R0["bar"]
007B  1C408000           [20] call       0   1   1    ;  := R0()
007F  05800100           [21] getglobal  0   6        ; R0 := package
0083  06C04100           [22] gettable   0   0   263  ; R0 := R0["loaded"]
0087  09004280           [23] settable   0   256 264  ; R0["mymod"] := "hello"
008B  05400100           [24] getglobal  0   5        ; R0 := require
008F  41000000           [25] loadk      1   0        ; R1 := "mymod"
0093  1C800001           [26] call       0   2   2    ; R0 := R0(R1)
0097  07000000           [27] setglobal  0   0        ; mymod := R0
009B  05400200           [28] getglobal  0   9        ; R0 := print
009F  45000000           [29] getglobal  1   0        ; R1 := mymod
00A3  1C400001           [30] call       0   2   1    ;  := R0(R1)
00A7  05800100           [31] getglobal  0   6        ; R0 := package
00AB  06804200           [32] gettable   0   0   266  ; R0 := R0["preload"]
00AF  64000000           [33] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
00B3  09400080           [34] settable   0   256 1    ; R0["mymod"] := R1
00B7  24400000           [35] closure    0   1        ; R0 := closure(function[1]) 0 upvalues
00BB  07C00200           [36] setglobal  0   11       ; preloadSearcher := R0
00BF  24800000           [37] closure    0   2        ; R0 := closure(function[2]) 0 upvalues
00C3  07000300           [38] setglobal  0   12       ; luaSearcher := R0
00C7  24C00000           [39] closure    0   3        ; R0 := closure(function[3]) 0 upvalues
00CB  07400100           [40] setglobal  0   5        ; require := R0
00CF  1E008000           [41] return     0   1        ; return 
                         * constants:
00D3  0D000000           sizek (13)
00D7  04                 const type 4
00D8  0600000000000000   string size (6)
00E0  6D796D6F6400       "mymod\0"
                         const [0]: "mymod"
00E6  04                 const type 4
00E7  0700000000000000   string size (7)
00EF  646F66696C6500     "dofile\0"
                         const [1]: "dofile"
00F6  04                 const type 4
00F7  0B00000000000000   string size (11)
00FF  6D796D6F642E6669+  "mymod.fi"
0107  6C6500             "le\0"
                         const [2]: "mymod.file"
010A  04                 const type 4
010B  0400000000000000   string size (4)
0113  666F6F00           "foo\0"
                         const [3]: "foo"
0117  04                 const type 4
0118  0400000000000000   string size (4)
0120  62617200           "bar\0"
                         const [4]: "bar"
0124  04                 const type 4
0125  0800000000000000   string size (8)
012D  7265717569726500   "require\0"
                         const [5]: "require"
0135  04                 const type 4
0136  0800000000000000   string size (8)
013E  7061636B61676500   "package\0"
                         const [6]: "package"
0146  04                 const type 4
0147  0700000000000000   string size (7)
014F  6C6F6164656400     "loaded\0"
                         const [7]: "loaded"
0156  04                 const type 4
0157  0600000000000000   string size (6)
015F  68656C6C6F00       "hello\0"
                         const [8]: "hello"
0165  04                 const type 4
0166  0600000000000000   string size (6)
016E  7072696E7400       "print\0"
                         const [9]: "print"
0174  04                 const type 4
0175  0800000000000000   string size (8)
017D  7072656C6F616400   "preload\0"
                         const [10]: "preload"
0185  04                 const type 4
0186  1000000000000000   string size (16)
018E  7072656C6F616453+  "preloadS"
0196  6561726368657200   "earcher\0"
                         const [11]: "preloadSearcher"
019E  04                 const type 4
019F  0C00000000000000   string size (12)
01A7  6C75615365617263+  "luaSearc"
01AF  68657200           "her\0"
                         const [12]: "luaSearcher"
                         * functions:
01B3  04000000           sizep (4)
                         
01B7                     ** function [0] definition (level 2) 0_0
                         ** start of function 0_0 **
01B7  0000000000000000   string size (0)
                         source name: (none)
01BF  0D000000           line defined (13)
01C3  12000000           last line defined (18)
01C7  00                 nups (0)
01C8  01                 numparams (1)
01C9  00                 is_vararg (0)
01CA  04                 maxstacksize (4)
                         * code:
01CB  05000000           sizecode (5)
01CF  64000000           [1] closure    1   0        ; R1 := closure(function[0]) 0 upvalues
01D3  80008000           [2] move       2   1        ; R2 := R1
01D7  C1000000           [3] loadk      3   0        ; R3 := ""
01DB  9E008001           [4] return     2   3        ; return R2, R3
01DF  1E008000           [5] return     0   1        ; return 
                         * constants:
01E3  01000000           sizek (1)
01E7  04                 const type 4
01E8  0100000000000000   string size (0)
                         const [0]: ""
                         * functions:
01F1  01000000           sizep (1)
                         
01F5                     ** function [0] definition (level 3) 0_0_0
                         ** start of function 0_0_0 **
01F5  0000000000000000   string size (0)
                         source name: (none)
01FD  0E000000           line defined (14)
0201  10000000           last line defined (16)
0205  00                 nups (0)
0206  02                 numparams (2)
0207  00                 is_vararg (0)
0208  04                 maxstacksize (4)
                         * code:
0209  04000000           sizecode (4)
020D  85000000           [1] getglobal  2   0        ; R2 := print
0211  C1400000           [2] loadk      3   1        ; R3 := "loading"
0215  9C400001           [3] call       2   2   1    ;  := R2(R3)
0219  1E008000           [4] return     0   1        ; return 
                         * constants:
021D  02000000           sizek (2)
0221  04                 const type 4
0222  0600000000000000   string size (6)
022A  7072696E7400       "print\0"
                         const [0]: "print"
0230  04                 const type 4
0231  0800000000000000   string size (8)
0239  6C6F6164696E6700   "loading\0"
                         const [1]: "loading"
                         * functions:
0241  00000000           sizep (0)
                         * lines:
0245  04000000           sizelineinfo (4)
                         [pc] (line)
0249  0F000000           [1] (15)
024D  0F000000           [2] (15)
0251  0F000000           [3] (15)
0255  10000000           [4] (16)
                         * locals:
0259  02000000           sizelocvars (2)
025D  0800000000000000   string size (8)
0265  6D6F646E616D6500   "modname\0"
                         local [0]: modname
026D  00000000             startpc (0)
0271  03000000             endpc   (3)
0275  0600000000000000   string size (6)
027D  657874726100       "extra\0"
                         local [1]: extra
0283  00000000             startpc (0)
0287  03000000             endpc   (3)
                         * upvalues:
028B  00000000           sizeupvalues (0)
                         ** end of function 0_0_0 **

                         * lines:
028F  05000000           sizelineinfo (5)
                         [pc] (line)
0293  10000000           [1] (16)
0297  11000000           [2] (17)
029B  11000000           [3] (17)
029F  11000000           [4] (17)
02A3  12000000           [5] (18)
                         * locals:
02A7  02000000           sizelocvars (2)
02AB  0800000000000000   string size (8)
02B3  6D6F646E616D6500   "modname\0"
                         local [0]: modname
02BB  00000000             startpc (0)
02BF  04000000             endpc   (4)
02C3  0700000000000000   string size (7)
02CB  6C6F6164657200     "loader\0"
                         local [1]: loader
02D2  01000000             startpc (1)
02D6  04000000             endpc   (4)
                         * upvalues:
02DA  00000000           sizeupvalues (0)
                         ** end of function 0_0 **

                         
02DE                     ** function [1] definition (level 2) 0_1
                         ** start of function 0_1 **
02DE  0000000000000000   string size (0)
                         source name: (none)
02E6  15000000           line defined (21)
02EA  1B000000           last line defined (27)
02EE  00                 nups (0)
02EF  01                 numparams (1)
02F0  00                 is_vararg (0)
02F1  04                 maxstacksize (4)
                         * code:
02F2  10000000           sizecode (16)
02F6  45000000           [01] getglobal  1   0        ; R1 := package
02FA  4640C000           [02] gettable   1   1   257  ; R1 := R1["preload"]
02FE  46008000           [03] gettable   1   1   0    ; R1 := R1[R0]
0302  5780C000           [04] eq         1   1   258  ; R1 == nil, pc+=1 (goto [6]) if false
0306  16000180           [05] jmp        5            ; pc+=5 (goto [11])
030A  45000000           [06] getglobal  1   0        ; R1 := package
030E  4640C000           [07] gettable   1   1   257  ; R1 := R1["preload"]
0312  46008000           [08] gettable   1   1   0    ; R1 := R1[R0]
0316  5E000001           [09] return     1   2        ; return R1
031A  16000180           [10] jmp        5            ; pc+=5 (goto [16])
031E  41C00000           [11] loadk      1   3        ; R1 := "\n\tno field package.preload['"
0322  80000000           [12] move       2   0        ; R2 := R0
0326  C1000100           [13] loadk      3   4        ; R3 := "']"
032A  55C08000           [14] concat     1   1   3    ; R1 := R1..R2..R3
032E  5E000001           [15] return     1   2        ; return R1
0332  1E008000           [16] return     0   1        ; return 
                         * constants:
0336  05000000           sizek (5)
033A  04                 const type 4
033B  0800000000000000   string size (8)
0343  7061636B61676500   "package\0"
                         const [0]: "package"
034B  04                 const type 4
034C  0800000000000000   string size (8)
0354  7072656C6F616400   "preload\0"
                         const [1]: "preload"
035C  00                 const type 0
                         const [2]: nil
035D  04                 const type 4
035E  1D00000000000000   string size (29)
0366  0A096E6F20666965+  "\n\tno fie"
036E  6C64207061636B61+  "ld packa"
0376  67652E7072656C6F+  "ge.prelo"
037E  61645B2700         "ad['\0"
                         const [3]: "\n\tno field package.preload['"
0383  04                 const type 4
0384  0300000000000000   string size (3)
038C  275D00             "']\0"
                         const [4]: "']"
                         * functions:
038F  00000000           sizep (0)
                         * lines:
0393  10000000           sizelineinfo (16)
                         [pc] (line)
0397  16000000           [01] (22)
039B  16000000           [02] (22)
039F  16000000           [03] (22)
03A3  16000000           [04] (22)
03A7  16000000           [05] (22)
03AB  17000000           [06] (23)
03AF  17000000           [07] (23)
03B3  17000000           [08] (23)
03B7  17000000           [09] (23)
03BB  17000000           [10] (23)
03BF  19000000           [11] (25)
03C3  19000000           [12] (25)
03C7  19000000           [13] (25)
03CB  19000000           [14] (25)
03CF  19000000           [15] (25)
03D3  1B000000           [16] (27)
                         * locals:
03D7  01000000           sizelocvars (1)
03DB  0800000000000000   string size (8)
03E3  6D6F646E616D6500   "modname\0"
                         local [0]: modname
03EB  00000000             startpc (0)
03EF  0F000000             endpc   (15)
                         * upvalues:
03F3  00000000           sizeupvalues (0)
                         ** end of function 0_1 **

                         
03F7                     ** function [2] definition (level 2) 0_2
                         ** start of function 0_2 **
03F7  0000000000000000   string size (0)
                         source name: (none)
03FF  1D000000           line defined (29)
0403  24000000           last line defined (36)
0407  00                 nups (0)
0408  01                 numparams (1)
0409  00                 is_vararg (0)
040A  05                 maxstacksize (5)
                         * code:
040B  10000000           sizecode (16)
040F  45000000           [01] getglobal  1   0        ; R1 := package
0413  4640C000           [02] gettable   1   1   257  ; R1 := R1["searchpath"]
0417  80000000           [03] move       2   0        ; R2 := R0
041B  C5000000           [04] getglobal  3   0        ; R3 := package
041F  C680C001           [05] gettable   3   3   258  ; R3 := R3["path"]
0423  5CC08001           [06] call       1   3   3    ; R1, R2 := R1(R2, R3)
0427  57C0C000           [07] eq         1   1   259  ; R1 == nil, pc+=1 (goto [9]) if false
042B  16400180           [08] jmp        6            ; pc+=6 (goto [15])
042F  C5000100           [09] getglobal  3   4        ; R3 := loadfile
0433  00018000           [10] move       4   1        ; R4 := R1
0437  DC800001           [11] call       3   2   2    ; R3 := R3(R4)
043B  00010000           [12] move       4   0        ; R4 := R0
043F  DE008001           [13] return     3   3        ; return R3, R4
0443  16000080           [14] jmp        1            ; pc+=1 (goto [16])
0447  9E000001           [15] return     2   2        ; return R2
044B  1E008000           [16] return     0   1        ; return 
                         * constants:
044F  05000000           sizek (5)
0453  04                 const type 4
0454  0800000000000000   string size (8)
045C  7061636B61676500   "package\0"
                         const [0]: "package"
0464  04                 const type 4
0465  0B00000000000000   string size (11)
046D  7365617263687061+  "searchpa"
0475  746800             "th\0"
                         const [1]: "searchpath"
0478  04                 const type 4
0479  0500000000000000   string size (5)
0481  7061746800         "path\0"
                         const [2]: "path"
0486  00                 const type 0
                         const [3]: nil
0487  04                 const type 4
0488  0900000000000000   string size (9)
0490  6C6F616466696C65+  "loadfile"
0498  00                 "\0"
                         const [4]: "loadfile"
                         * functions:
0499  00000000           sizep (0)
                         * lines:
049D  10000000           sizelineinfo (16)
                         [pc] (line)
04A1  1E000000           [01] (30)
04A5  1E000000           [02] (30)
04A9  1E000000           [03] (30)
04AD  1E000000           [04] (30)
04B1  1E000000           [05] (30)
04B5  1E000000           [06] (30)
04B9  1F000000           [07] (31)
04BD  1F000000           [08] (31)
04C1  20000000           [09] (32)
04C5  20000000           [10] (32)
04C9  20000000           [11] (32)
04CD  20000000           [12] (32)
04D1  20000000           [13] (32)
04D5  20000000           [14] (32)
04D9  22000000           [15] (34)
04DD  24000000           [16] (36)
                         * locals:
04E1  03000000           sizelocvars (3)
04E5  0800000000000000   string size (8)
04ED  6D6F646E616D6500   "modname\0"
                         local [0]: modname
04F5  00000000             startpc (0)
04F9  0F000000             endpc   (15)
04FD  0500000000000000   string size (5)
0505  66696C6500         "file\0"
                         local [1]: file
050A  06000000             startpc (6)
050E  0F000000             endpc   (15)
0512  0400000000000000   string size (4)
051A  65727200           "err\0"
                         local [2]: err
051E  06000000             startpc (6)
0522  0F000000             endpc   (15)
                         * upvalues:
0526  00000000           sizeupvalues (0)
                         ** end of function 0_2 **

                         
052A                     ** function [3] definition (level 2) 0_3
                         ** start of function 0_3 **
052A  0000000000000000   string size (0)
                         source name: (none)
0532  26000000           line defined (38)
0536  37000000           last line defined (55)
053A  00                 nups (0)
053B  01                 numparams (1)
053C  00                 is_vararg (0)
053D  0C                 maxstacksize (12)
                         * code:
053E  2D000000           sizecode (45)
0542  45000000           [01] getglobal  1   0        ; R1 := package
0546  4640C000           [02] gettable   1   1   257  ; R1 := R1["loaded"]
054A  85800000           [03] getglobal  2   2        ; R2 := nodname
054E  46808000           [04] gettable   1   1   2    ; R1 := R1[R2]
0552  57C0C000           [05] eq         1   1   259  ; R1 == nil, pc+=1 (goto [7]) if false
0556  16C00080           [06] jmp        4            ; pc+=4 (goto [11])
055A  45000000           [07] getglobal  1   0        ; R1 := package
055E  4640C000           [08] gettable   1   1   257  ; R1 := R1["loaded"]
0562  46008000           [09] gettable   1   1   0    ; R1 := R1[R0]
0566  5E000001           [10] return     1   2        ; return R1
056A  41000100           [11] loadk      1   4        ; R1 := "module '"
056E  85400100           [12] getglobal  2   5        ; R2 := name
0572  C1800100           [13] loadk      3   6        ; R3 := "' not found:"
0576  55C08000           [14] concat     1   1   3    ; R1 := R1..R2..R3
057A  85C00100           [15] getglobal  2   7        ; R2 := ipairs
057E  C5000000           [16] getglobal  3   0        ; R3 := package
0582  C600C201           [17] gettable   3   3   264  ; R3 := R3["searchers"]
0586  9C000101           [18] call       2   2   4    ; R2 to R4 := R2(R3)
058A  16C00480           [19] jmp        20           ; pc+=20 (goto [40])
058E  C0010003           [20] move       7   6        ; R7 := R6
0592  00020000           [21] move       8   0        ; R8 := R0
0596  DCC10001           [22] call       7   2   3    ; R7, R8 := R7(R8)
059A  45420200           [23] getglobal  9   9        ; R9 := type
059E  80028003           [24] move       10  7        ; R10 := R7
05A2  5C820001           [25] call       9   2   2    ; R9 := R9(R10)
05A6  1780C204           [26] eq         0   9   266  ; R9 == "function", pc+=1 (goto [28]) if true
05AA  16000280           [27] jmp        9            ; pc+=9 (goto [37])
05AE  40028003           [28] move       9   7        ; R9 := R7
05B2  80020000           [29] move       10  0        ; R10 := R0
05B6  C0020004           [30] move       11  8        ; R11 := R8
05BA  5C828001           [31] call       9   3   2    ; R9 := R9(R10, R11)
05BE  85020000           [32] getglobal  10  0        ; R10 := package
05C2  86424005           [33] gettable   10  10  257  ; R10 := R10["loaded"]
05C6  89420200           [34] settable   10  0   9    ; R10[R0] := R9
05CA  5E020001           [35] return     9   2        ; return R9
05CE  16800080           [36] jmp        3            ; pc+=3 (goto [40])
05D2  40028000           [37] move       9   1        ; R9 := R1
05D6  80028003           [38] move       10  7        ; R10 := R7
05DA  55808204           [39] concat     1   9   10   ; R1 := R9..R10
05DE  A1800000           [40] tforloop   2       2    ; R5, R6 := R2(R3,R4); if R5 ~= nil then R4 := R5 else PC := 42
05E2  1640FA7F           [41] jmp        -22          ; pc+=-22 (goto [20])
05E6  85C00200           [42] getglobal  2   11       ; R2 := error
05EA  C0008000           [43] move       3   1        ; R3 := R1
05EE  9C400001           [44] call       2   2   1    ;  := R2(R3)
05F2  1E008000           [45] return     0   1        ; return 
                         * constants:
05F6  0C000000           sizek (12)
05FA  04                 const type 4
05FB  0800000000000000   string size (8)
0603  7061636B61676500   "package\0"
                         const [0]: "package"
060B  04                 const type 4
060C  0700000000000000   string size (7)
0614  6C6F6164656400     "loaded\0"
                         const [1]: "loaded"
061B  04                 const type 4
061C  0800000000000000   string size (8)
0624  6E6F646E616D6500   "nodname\0"
                         const [2]: "nodname"
062C  00                 const type 0
                         const [3]: nil
062D  04                 const type 4
062E  0900000000000000   string size (9)
0636  6D6F64756C652027+  "module '"
063E  00                 "\0"
                         const [4]: "module '"
063F  04                 const type 4
0640  0500000000000000   string size (5)
0648  6E616D6500         "name\0"
                         const [5]: "name"
064D  04                 const type 4
064E  0D00000000000000   string size (13)
0656  27206E6F7420666F+  "' not fo"
065E  756E643A00         "und:\0"
                         const [6]: "' not found:"
0663  04                 const type 4
0664  0700000000000000   string size (7)
066C  69706169727300     "ipairs\0"
                         const [7]: "ipairs"
0673  04                 const type 4
0674  0A00000000000000   string size (10)
067C  7365617263686572+  "searcher"
0684  7300               "s\0"
                         const [8]: "searchers"
0686  04                 const type 4
0687  0500000000000000   string size (5)
068F  7479706500         "type\0"
                         const [9]: "type"
0694  04                 const type 4
0695  0900000000000000   string size (9)
069D  66756E6374696F6E+  "function"
06A5  00                 "\0"
                         const [10]: "function"
06A6  04                 const type 4
06A7  0600000000000000   string size (6)
06AF  6572726F7200       "error\0"
                         const [11]: "error"
                         * functions:
06B5  00000000           sizep (0)
                         * lines:
06B9  2D000000           sizelineinfo (45)
                         [pc] (line)
06BD  27000000           [01] (39)
06C1  27000000           [02] (39)
06C5  27000000           [03] (39)
06C9  27000000           [04] (39)
06CD  27000000           [05] (39)
06D1  27000000           [06] (39)
06D5  28000000           [07] (40)
06D9  28000000           [08] (40)
06DD  28000000           [09] (40)
06E1  28000000           [10] (40)
06E5  2B000000           [11] (43)
06E9  2B000000           [12] (43)
06ED  2B000000           [13] (43)
06F1  2B000000           [14] (43)
06F5  2C000000           [15] (44)
06F9  2C000000           [16] (44)
06FD  2C000000           [17] (44)
0701  2C000000           [18] (44)
0705  2C000000           [19] (44)
0709  2D000000           [20] (45)
070D  2D000000           [21] (45)
0711  2D000000           [22] (45)
0715  2E000000           [23] (46)
0719  2E000000           [24] (46)
071D  2E000000           [25] (46)
0721  2E000000           [26] (46)
0725  2E000000           [27] (46)
0729  2F000000           [28] (47)
072D  2F000000           [29] (47)
0731  2F000000           [30] (47)
0735  2F000000           [31] (47)
0739  30000000           [32] (48)
073D  30000000           [33] (48)
0741  30000000           [34] (48)
0745  31000000           [35] (49)
0749  31000000           [36] (49)
074D  33000000           [37] (51)
0751  33000000           [38] (51)
0755  33000000           [39] (51)
0759  2C000000           [40] (44)
075D  34000000           [41] (52)
0761  36000000           [42] (54)
0765  36000000           [43] (54)
0769  36000000           [44] (54)
076D  37000000           [45] (55)
                         * locals:
0771  0A000000           sizelocvars (10)
0775  0800000000000000   string size (8)
077D  6D6F646E616D6500   "modname\0"
                         local [0]: modname
0785  00000000             startpc (0)
0789  2C000000             endpc   (44)
078D  0400000000000000   string size (4)
0795  65727200           "err\0"
                         local [1]: err
0799  0E000000             startpc (14)
079D  2C000000             endpc   (44)
07A1  1000000000000000   string size (16)
07A9  28666F722067656E+  "(for gen"
07B1  657261746F722900   "erator)\0"
                         local [2]: (for generator)
07B9  12000000             startpc (18)
07BD  29000000             endpc   (41)
07C1  0C00000000000000   string size (12)
07C9  28666F7220737461+  "(for sta"
07D1  74652900           "te)\0"
                         local [3]: (for state)
07D5  12000000             startpc (18)
07D9  29000000             endpc   (41)
07DD  0E00000000000000   string size (14)
07E5  28666F7220636F6E+  "(for con"
07ED  74726F6C2900       "trol)\0"
                         local [4]: (for control)
07F3  12000000             startpc (18)
07F7  29000000             endpc   (41)
07FB  0200000000000000   string size (2)
0803  6900               "i\0"
                         local [5]: i
0805  13000000             startpc (19)
0809  27000000             endpc   (39)
080D  0900000000000000   string size (9)
0815  7365617263686572+  "searcher"
081D  00                 "\0"
                         local [6]: searcher
081E  13000000             startpc (19)
0822  27000000             endpc   (39)
0826  0700000000000000   string size (7)
082E  6C6F6164657200     "loader\0"
                         local [7]: loader
0835  16000000             startpc (22)
0839  27000000             endpc   (39)
083D  0600000000000000   string size (6)
0845  657874726100       "extra\0"
                         local [8]: extra
084B  16000000             startpc (22)
084F  27000000             endpc   (39)
0853  0400000000000000   string size (4)
085B  6D6F6400           "mod\0"
                         local [9]: mod
085F  1F000000             startpc (31)
0863  23000000             endpc   (35)
                         * upvalues:
0867  00000000           sizeupvalues (0)
                         ** end of function 0_3 **

                         * lines:
086B  29000000           sizelineinfo (41)
                         [pc] (line)
086F  01000000           [01] (1)
0873  01000000           [02] (1)
0877  01000000           [03] (1)
087B  01000000           [04] (1)
087F  02000000           [05] (2)
0883  02000000           [06] (2)
0887  02000000           [07] (2)
088B  03000000           [08] (3)
088F  03000000           [09] (3)
0893  03000000           [10] (3)
0897  05000000           [11] (5)
089B  05000000           [12] (5)
089F  05000000           [13] (5)
08A3  05000000           [14] (5)
08A7  06000000           [15] (6)
08AB  06000000           [16] (6)
08AF  06000000           [17] (6)
08B3  07000000           [18] (7)
08B7  07000000           [19] (7)
08BB  07000000           [20] (7)
08BF  09000000           [21] (9)
08C3  09000000           [22] (9)
08C7  09000000           [23] (9)
08CB  0A000000           [24] (10)
08CF  0A000000           [25] (10)
08D3  0A000000           [26] (10)
08D7  0A000000           [27] (10)
08DB  0B000000           [28] (11)
08DF  0B000000           [29] (11)
08E3  0B000000           [30] (11)
08E7  0D000000           [31] (13)
08EB  0D000000           [32] (13)
08EF  12000000           [33] (18)
08F3  12000000           [34] (18)
08F7  1B000000           [35] (27)
08FB  15000000           [36] (21)
08FF  24000000           [37] (36)
0903  1D000000           [38] (29)
0907  37000000           [39] (55)
090B  26000000           [40] (38)
090F  37000000           [41] (55)
                         * locals:
0913  00000000           sizelocvars (0)
                         * upvalues:
0917  00000000           sizeupvalues (0)
                         ** end of function 0 **

091B                     ** end of chunk **
