import re
def all_lowercase2pascal(s:str):
	'''eg. loadbool => LoadBool
	>>> all_lowercase2pascal('loadbool') == 'LoadBool'
	'''
	dictionary=['load','bool','global','set','get','k','nil','new','table','len','add','eq','jmp','closure','call','return','list']
	pattern='|'.join(dictionary)
	return ''.join(map(lambda s:s.title(),re.findall(pattern,s)))

text='''002B  07000000           [01] setglobal  0   0        ; 
002F  02000000           [02] loadbool   0   0   0    ; R0 := false
0033  07400000           [03] setglobal  0   1        ; a1 := R0
0037  02008000           [04] loadbool   0   1   0    ; R0 := true
003B  07800000           [05] setglobal  0   2        ; a2 := R0
003F  01000100           [06] loadk      0   4        ; R0 := 1
0043  07C00000           [07] setglobal  0   3        ; b := R0
0047  01800100           [08] loadk      0   6        ; R0 := 1.2
004B  07400100           [09] setglobal  0   5        ; b1 := R0
004F  01000200           [10] loadk      0   8        ; R0 := "lalala"
0053  07C00100           [11] setglobal  0   7        ; c := R0
0057  03000000           [12] loadnil    0   0        ; R0,  := nil
005B  42000000           [13] loadbool   1   0   0    ; R1 := false
005F  82008000           [14] loadbool   2   1   0    ; R2 := true
0063  C1000100           [15] loadk      3   4        ; R3 := 1
0067  01810100           [16] loadk      4   6        ; R4 := 1.2
006B  41010200           [17] loadk      5   8        ; R5 := "lalala"
006F  8A010001           [18] newtable   6   2   0    ; R6 := {} , array=2, hash=0
0073  C1010100           [19] loadk      7   4        ; R7 := 1
0077  01420200           [20] loadk      8   9        ; R8 := 2
007B  A2410001           [21] setlist    6   2   1    ; R6[1 to 2] := R7 to R8
0083  C1410200           [23] loadk      7   9        ; R7 := 2
0087  01820200           [24] loadk      8   10       ; R8 := 3
008B  4C02C385           [25] add        9   267 268  ; R9 := "1" + "2"
008F  57404282           [26] eq         1   260 265  ; 1 == 2, pc+=1 (goto [28]) if false
009B  82028000           [29] loadbool   10  1   0    ; R10 := true
009F  C2020000           [30] loadbool   11  0   0    ; R11 := false
00A3  24030000           [31] closure    12  0        ; R12 := closure(function[0]) 0 upvalues
00A7  07430300           [32] setglobal  12  13       ; add := R12
00AB  05430300           [33] getglobal  12  13       ; R12 := add
00AF  41030100           [34] loadk      13  4        ; R13 := 1
00B3  81430200           [35] loadk      14  9        ; R14 := 2
00B7  1C838001           [36] call       12  3   2    ; R12 := R12(R13, R14) '''
a=text.split('\n')
b=map(lambda s:s.split(),a)
opr2_codes=[]
opr3_codes=[]
def f():
	for i in b:
		t=i[1]
		instr_hex=''.join([t[6:8],t[4:6],t[2:4],t[0:2]])
		op=i[3]
		opr1=i[4]
		opr2=i[5]
		opr3=i[6] if i[6]!=';' else ''
		# line for create 
		# line ='Assert.AreEqual<UInt32>(0x'+instr_hex+', (uint) new Instruction(Opcodes.'+all_lowercase2pascal(op)+','+opr1+','+opr2
		# if opr3:
		# 	line+=(','+opr3+'));')
		# 	opr3_codes.append(line)
		# else:
		# 	line+='));'
		# 	opr2_codes.append(line)
		
		# line for get
		# line='Assert.AreEqual<Int32>('+opr2+',  new Instruction(Opcodes.'+all_lowercase2pascal(op)+','+opr1+','+opr2+').Bx);'
		# if not opr3:
		# 	opr2_codes.append(line)

		# bytecode
		yield instr_hex
# for i in opr2_codes:print(i)
# for i in opr3_codes:print(i)
print('[0x'+',0x'.join(f())+']')