//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

#define LUAI_BITSINT

/*
** $Id: lopcodes.c,v 1.37.1.1 2007/12/27 13:02:25 roberto Exp $
** See Copyright Notice in lua.h
*/




/*
** $Id: lopcodes.h,v 1.125.1.1 2007/12/27 13:02:25 roberto Exp $
** Opcodes for Lua virtual machine
** See Copyright Notice in lua.h
*/


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_PATH_DEFAULT ".\\?.lua;" LUA_LDI"?.lua;" LUA_LDIR"?\\init.lua;" LUA_CDIR"?.lua;" LUA_CDIR"?\\init.lua"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_CPATH_DEFAULT ".\\?.dll;" LUA_CDI"?.dll;" LUA_CDIR"loadall.dll"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_LDIR LUA_ROOT "share/lua/5.1/"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_CDIR LUA_ROOT "lib/lua/5.1/"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_PATH_DEFAULT "./?.lua;" LUA_LDI"?.lua;" LUA_LDIR"?/init.lua;" LUA_CDIR"?.lua;" LUA_CDIR"?/init.lua"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_CPATH_DEFAULT "./?.so;" LUA_CDI"?.so;" LUA_CDIR"loadall.so"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_INTEGER ptrdiff_t
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_API __declspec(dllexport)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_API __declspec(dllimport)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_API extern
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUALIB_API LUA_API
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_FUNC static
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_FUNC extern
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_DATA LUAI_FUNC
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_FUNC extern
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_DATA extern
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_QL(x) "'" x "'"
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_QS LUA_QL("%s")
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_stdin_is_tty() isatty(0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_stdin_is_tty() _isatty(_fileno(stdin))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_stdin_is_tty() 1
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_readline(L,b,p) ((void)L, ((b)=readline(p)) != NULL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_saveline(L,idx) if (lua_strlen(L,idx) > 0) add_history(lua_tostring(L, idx));
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_freeline(L,b) ((void)L, free(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_readline(L,b,p) ((void)L, fputs(p, stdout), fflush(stdout), fgets(b, LUA_MAXINPUT, stdin) != NULL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_saveline(L,idx) { (void)L; (void)idx; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_freeline(L,b) { (void)L; (void)b; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_apicheck(L,o) { (void)L; assert(o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_apicheck(L,o) { (void)L; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_UINT32 unsigned int
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_INT32 int
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_MAXINT32 INT_MAX
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_UMEM size_t
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_MEM ptrdiff_t
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_UINT32 unsigned long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_INT32 long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_MAXINT32 LONG_MAX
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_UMEM unsigned long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_MEM long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAL_BUFFERSIZE BUFSIZ
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_NUMBER double
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_UACNUMBER double
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2str(s,n) sprintf((s), LUA_NUMBER_FMT, (n))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_str2number(s,p) strtod((s), (p))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numadd(a,b) ((a)+(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numsub(a,b) ((a)-(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_nummul(a,b) ((a)*(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numdiv(a,b) ((a)/(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_nummod(a,b) ((a) - floor((a)/(b))*(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numpow(a,b) (pow(a,b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numunm(a) (-(a))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numeq(a,b) ((a)==(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numlt(a,b) ((a)<(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numle(a,b) ((a)<=(b))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_numisnan(a) (!luai_numeq((a), (a)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2int(i,d) __asm fld d __asm fistp i
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2integer(i,n) lua_number2int(i, n)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2int(i,d) { volatile union luai_Cast u; u.l_d = (d) + 6755399441055744.0; (i) = u.l_l; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2integer(i,n) lua_number2int(i, n)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2int(i,d) ((i)=(int)(d))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_number2integer(i,d) ((i)=(lua_Integer)(d))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_USER_ALIGNMENT_T union { double u; void *s; long l; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_THROW(L,c) throw(c)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_TRY(L,c,a) try { a } catch(...) { if ((c)->status == 0) (c)->status = -1; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_jmpbuf int
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_THROW(L,c) _longjmp((c)->b, 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_TRY(L,c,a) if (_setjmp((c)->b) == 0) { a }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_jmpbuf jmp_buf
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_THROW(L,c) longjmp((c)->b, 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUAI_TRY(L,c,a) if (setjmp((c)->b) == 0) { a }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_jmpbuf jmp_buf
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_tmpnam(b,e) { strcpy(b, "/tmp/lua_XXXXXX"); e = mkstemp(b); if (e != -1) close(e); e = (e == -1); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TMPNAMBUFSIZE L_tmpnam
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_tmpnam(b,e) { e = (tmpnam(b) == NULL); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_popen(L,c,m) ((void)L, fflush(NULL), popen(c,m))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pclose(L,file) ((void)L, (pclose(file) != -1))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_popen(L,c,m) ((void)L, _popen(c,m))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pclose(L,file) ((void)L, (_pclose(file) != -1))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_popen(L,c,m) ((void)((void)c, m), luaL_error(L, LUA_QL("popen") " not supported"), (FILE*)0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pclose(L,file) ((void)((void)L, file), 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstateopen(L) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstateclose(L) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstatethread(L,L1) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstatefree(L) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstateresume(L,n) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_userstateyield(L,n) ((void)L)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_INTFRM_T long long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_INTFRM_T long
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_upvalueindex(i) (LUA_GLOBALSINDEX-(i))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pop(L,n) lua_settop(L, -(n)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_newtable(L) lua_createtable(L, 0, 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_register(L,n,f) (lua_pushcfunction(L, (f)), lua_setglobal(L, (n)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pushcfunction(L,f) lua_pushcclosure(L, (f), 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_strlen(L,i) lua_objlen(L, (i))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isfunction(L,n) (lua_type(L, (n)) == LUA_TFUNCTION)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_istable(L,n) (lua_type(L, (n)) == LUA_TTABLE)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_islightuserdata(L,n) (lua_type(L, (n)) == LUA_TLIGHTUSERDATA)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isnil(L,n) (lua_type(L, (n)) == LUA_TNIL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isboolean(L,n) (lua_type(L, (n)) == LUA_TBOOLEAN)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isthread(L,n) (lua_type(L, (n)) == LUA_TTHREAD)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isnone(L,n) (lua_type(L, (n)) == LUA_TNONE)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_isnoneornil(L, n) (lua_type(L, (n)) <= 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_pushliteral(L, s) lua_pushlstring(L, "" s, (sizeof(s)/sizeof(char))-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_setglobal(L,s) lua_setfield(L, LUA_GLOBALSINDEX, (s))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_getglobal(L,s) lua_getfield(L, LUA_GLOBALSINDEX, (s))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_tostring(L,i) lua_tolstring(L, (i), NULL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_open() luaL_newstate()
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_getregistry(L) lua_pushvalue(L, LUA_REGISTRYINDEX)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_getgccount(L) lua_gc(L, LUA_GCCOUNT, 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_Chunkreader lua_Reader
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_Chunkwriter lua_Writer
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_MASKCALL (1 << LUA_HOOKCALL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_MASKRET (1 << LUA_HOOKRET)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_MASKLINE (1 << LUA_HOOKLINE)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_MASKCOUNT (1 << LUA_HOOKCOUNT)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAX_SIZET ((size_t)(~(size_t)0)-2)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAX_LUMEM ((lu_mem)(~(lu_mem)0)-2)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAX_INT (INT_MAX-2)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define IntPoint(p) ((unsigned int)(lu_mem)(p))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define check_exp(c,e) (lua_assert(c), (e))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define api_check(l,e) lua_assert(e)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_assert(c) ((void)0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define check_exp(c,e) (e)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define api_check luai_apicheck
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define UNUSED(x) ((void)(x))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define cast(t, exp) ((t)(exp))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define cast_byte(i) cast(lu_byte, (i))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define cast_num(i) cast(lua_Number, (i))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define cast_int(i) cast(int, (i))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_lock(L) ((void) 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lua_unlock(L) ((void) 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luai_threadyield(L) {lua_unlock(L); lua_lock(L);}
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define condhardstacktests(x) ((void)0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define condhardstacktests(x) x


/*===========================================================================
  We assume that instructions are unsigned numbers.
  All instructions have an opcode in the first 6 bits.
  Instructions can have the following fields:
	`A' : 8 bits
	`B' : 9 bits
	`C' : 9 bits
	`Bx' : 18 bits (`B' and `C' together)
	`sBx' : signed Bx

  A signed argument is represented in excess K; that is, the number
  value is the unsigned value minus K. K is exactly the maximum value
  for that argument (so that -max is represented by 0, and +max is
  represented by 2*max), which is half the maximum for the corresponding
  unsigned argument.
===========================================================================*/


public enum OpMode
{
	iABC,
	iABx,
	iAsBx
} // basic instruction format


/*
** size and position of opcode arguments.
*/
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SIZE_Bx (SIZE_C + SIZE_B)


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define POS_A (POS_OP + SIZE_OP)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define POS_C (POS_A + SIZE_A)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define POS_B (POS_C + SIZE_C)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define POS_Bx POS_C


/*
** limits for opcode arguments.
** we use (signed) int to manipulate most arguments,
** so they must fit in LUAI_BITSINT-1 bits (-1 for sign)
*/
//C++ TO C# CONVERTER TODO TASK: C# does not allow setting or comparing #define constants:
#if SIZE_Bx < LUAI_BITSINT-1
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_Bx ((1<<SIZE_Bx)-1)
#define MAXARG_Bx
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_sBx (MAXARG_Bx>>1)
#define MAXARG_sBx
#else
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_Bx MAX_INT
#define MAXARG_Bx
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_sBx MAX_INT
#define MAXARG_sBx
#endif


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_A ((1<<SIZE_A)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_B ((1<<SIZE_B)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_C ((1<<SIZE_C)-1)


/* creates a mask with `n' 1 bits at position `p' */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MASK1(n,p) ((~((~(Instruction)0)<<n))<<p)

/* creates a mask with `n' 0 bits at position `p' */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MASK0(n,p) (~MASK1(n,p))

/*
** the following macros help to manipulate instructions
*/

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GET_OPCODE(i) (cast(OpCode, ((i)>>POS_OP) & MASK1(SIZE_OP,0)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SET_OPCODE(i,o) ((i) = (((i)&MASK0(SIZE_OP,POS_OP)) | ((cast(Instruction, o)<<POS_OP)&MASK1(SIZE_OP,POS_OP))))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GETARG_A(i) (cast(int, ((i)>>POS_A) & MASK1(SIZE_A,0)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SETARG_A(i,u) ((i) = (((i)&MASK0(SIZE_A,POS_A)) | ((cast(Instruction, u)<<POS_A)&MASK1(SIZE_A,POS_A))))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GETARG_B(i) (cast(int, ((i)>>POS_B) & MASK1(SIZE_B,0)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SETARG_B(i,b) ((i) = (((i)&MASK0(SIZE_B,POS_B)) | ((cast(Instruction, b)<<POS_B)&MASK1(SIZE_B,POS_B))))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GETARG_C(i) (cast(int, ((i)>>POS_C) & MASK1(SIZE_C,0)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SETARG_C(i,b) ((i) = (((i)&MASK0(SIZE_C,POS_C)) | ((cast(Instruction, b)<<POS_C)&MASK1(SIZE_C,POS_C))))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GETARG_Bx(i) (cast(int, ((i)>>POS_Bx) & MASK1(SIZE_Bx,0)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SETARG_Bx(i,b) ((i) = (((i)&MASK0(SIZE_Bx,POS_Bx)) | ((cast(Instruction, b)<<POS_Bx)&MASK1(SIZE_Bx,POS_Bx))))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define GETARG_sBx(i) (GETARG_Bx(i)-MAXARG_sBx)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define SETARG_sBx(i,b) SETARG_Bx((i),cast(unsigned int, (b)+MAXARG_sBx))


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define CREATE_ABC(o,a,b,c) ((cast(Instruction, o)<<POS_OP) | (cast(Instruction, a)<<POS_A) | (cast(Instruction, b)<<POS_B) | (cast(Instruction, c)<<POS_C))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define CREATE_ABx(o,a,bc) ((cast(Instruction, o)<<POS_OP) | (cast(Instruction, a)<<POS_A) | (cast(Instruction, bc)<<POS_Bx))


/*
** Macros to operate RK indices
*/

/* this bit 1 means constant (0 means register) */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define BITRK (1 << (SIZE_B - 1))

/* test whether value is a constant */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ISK(x) ((x) & BITRK)

/* gets the index of the constant */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define INDEXK(r) ((int)(r) & ~BITRK)

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXINDEXRK (BITRK - 1)

/* code a constant index as a RK value */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define RKASK(x) ((x) | BITRK)


/*
** invalid register that fits in 8 bits
*/
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NO_REG MAXARG_A


/*
** R(x) - register
** Kst(x) - constant (in constant table)
** RK(x) == if ISK(x) then Kst(INDEXK(x)) else R(x)
*/


/*
** grep "ORDER OP" if you change these enums
*/

public enum OpCode
{
/*----------------------------------------------------------------------
name		args	description
------------------------------------------------------------------------*/
OP_MOVE, //    A B    R(A) := R(B)
OP_LOADK, //    A Bx    R(A) := Kst(Bx)
OP_LOADBOOL, //    A B C    R(A) := (Bool)B; if (C) pc++
OP_LOADNIL, //    A B    R(A) := ... := R(B) := nil
OP_GETUPVAL, //    A B    R(A) := UpValue[B]

OP_GETGLOBAL, //    A Bx    R(A) := Gbl[Kst(Bx)]
OP_GETTABLE, //    A B C    R(A) := R(B)[RK(C)]

OP_SETGLOBAL, //    A Bx    Gbl[Kst(Bx)] := R(A)
OP_SETUPVAL, //    A B    UpValue[B] := R(A)
OP_SETTABLE, //    A B C    R(A)[RK(B)] := RK(C)

OP_NEWTABLE, //    A B C    R(A) := {} (size = B,C)

OP_SELF, //    A B C    R(A+1) := R(B); R(A) := R(B)[RK(C)]

OP_ADD, //    A B C    R(A) := RK(B) + RK(C)
OP_SUB, //    A B C    R(A) := RK(B) - RK(C)
OP_MUL, //    A B C    R(A) := RK(B) * RK(C)
OP_DIV, //    A B C    R(A) := RK(B) / RK(C)
OP_MOD, //    A B C    R(A) := RK(B) % RK(C)
OP_POW, //    A B C    R(A) := RK(B) ^ RK(C)
OP_UNM, //    A B    R(A) := -R(B)
OP_NOT, //    A B    R(A) := not R(B)
OP_LEN, //    A B    R(A) := length of R(B)

OP_CONCAT, //    A B C    R(A) := R(B).. ... ..R(C)

OP_JMP, //    sBx    pc+=sBx

OP_EQ, //    A B C    if ((RK(B) == RK(C)) ~= A) then pc++
OP_LT, //    A B C    if ((RK(B) <  RK(C)) ~= A) then pc++
OP_LE, //    A B C    if ((RK(B) <= RK(C)) ~= A) then pc++

OP_TEST, //    A C    if not (R(A) <=> C) then pc++
OP_TESTSET, //    A B C    if (R(B) <=> C) then R(A) := R(B) else pc++

OP_CALL, //    A B C    R(A), ... ,R(A+C-2) := R(A)(R(A+1), ... ,R(A+B-1))
OP_TAILCALL, //    A B C    return R(A)(R(A+1), ... ,R(A+B-1))
OP_RETURN, //    A B    return R(A), ... ,R(A+B-2)    (see note)

OP_FORLOOP, /*    A sBx    R(A)+=R(A+2);
			if R(A) <?= R(A+1) then { pc+=sBx; R(A+3)=R(A) }*/
OP_FORPREP, //    A sBx    R(A)-=R(A+2); pc+=sBx

OP_TFORLOOP, /*    A C    R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2));
                        if R(A+3) ~= nil then R(A+2)=R(A+3) else pc++	*/ 
OP_SETLIST, //    A B C    R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B

OP_CLOSE, //    A     close all variables in the stack up to (>=) R(A)
OP_CLOSURE, //    A Bx    R(A) := closure(KPROTO[Bx], R(A), ... ,R(A+n))

OP_VARARG //    A B    R(A), R(A+1), ..., R(A+B-1) = vararg
}


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NUM_OPCODES (cast(int, OP_VARARG) + 1)



/*===========================================================================
  Notes:
  (*) In OP_CALL, if (B == 0) then B = top. C is the number of returns - 1,
      and can be 0: OP_CALL then sets `top' to last_result+1, so
      next open instruction (OP_CALL, OP_RETURN, OP_SETLIST) may use `top'.

  (*) In OP_VARARG, if (B == 0) then use actual number of varargs and
      set top (like in OP_CALL with C == 0).

  (*) In OP_RETURN, if (B == 0) then return up to `top'

  (*) In OP_SETLIST, if (B == 0) then B = `top';
      if (C == 0) then next `instruction' is real C

  (*) For comparisons, A specifies what condition the test should accept
      (true or false).

  (*) All `skips' (pc++) assume that next instruction is a jump
===========================================================================*/


/*
** masks for instruction properties. The format is:
** bits 0-1: op mode
** bits 2-3: C arg mode
** bits 4-5: B arg mode
** bit 6: instruction set register A
** bit 7: operator is a test
*/  

public enum OpArgMask
{
  OpArgN, // argument is not used
  OpArgU, // argument is used
  OpArgR, // argument is a register or a jump offset
  OpArgK // argument is a constant or register/constant
}