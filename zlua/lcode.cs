//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

using System;

/*
** $Id: lcode.c,v 2.25.1.3 2007/12/28 15:32:23 roberto Exp $
** Code generator for Lua
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

/*
** $Id: lcode.h,v 1.48.1.1 2007/12/27 13:02:25 roberto Exp $
** Code generator for Lua
** See Copyright Notice in lua.h
*/


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
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LAST_TAG LUA_TTHREAD
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NUM_TAGS (LAST_TAG+1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TPROTO (LAST_TAG+1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TUPVAL (LAST_TAG+2)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TDEADKEY (LAST_TAG+3)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define CommonHeader GCObject *next; lu_byte tt; lu_byte marked
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define TValuefields Value value; int tt
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisnil(o) (ttype(o) == LUA_TNIL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisnumber(o) (ttype(o) == LUA_TNUMBER)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisstring(o) (ttype(o) == LUA_TSTRING)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttistable(o) (ttype(o) == LUA_TTABLE)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisfunction(o) (ttype(o) == LUA_TFUNCTION)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisboolean(o) (ttype(o) == LUA_TBOOLEAN)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisuserdata(o) (ttype(o) == LUA_TUSERDATA)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttisthread(o) (ttype(o) == LUA_TTHREAD)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttislightuserdata(o) (ttype(o) == LUA_TLIGHTUSERDATA)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ttype(o) ((o)->tt)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define gcvalue(o) check_exp(iscollectable(o), (o)->value.gc)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define pvalue(o) check_exp(ttislightuserdata(o), (o)->value.p)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define nvalue(o) check_exp(ttisnumber(o), (o)->value.n)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define rawtsvalue(o) check_exp(ttisstring(o), &(o)->value.gc->ts)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define tsvalue(o) (&rawtsvalue(o)->tsv)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define rawuvalue(o) check_exp(ttisuserdata(o), &(o)->value.gc->u)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define uvalue(o) (&rawuvalue(o)->uv)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define clvalue(o) check_exp(ttisfunction(o), &(o)->value.gc->cl)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define hvalue(o) check_exp(ttistable(o), &(o)->value.gc->h)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define bvalue(o) check_exp(ttisboolean(o), (o)->value.b)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define thvalue(o) check_exp(ttisthread(o), &(o)->value.gc->th)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define l_isfalse(o) (ttisnil(o) || (ttisboolean(o) && bvalue(o) == 0))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define checkconsistency(obj) lua_assert(!iscollectable(obj) || (ttype(obj) == (obj)->value.gc->gch.tt))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define checkliveness(g,obj) lua_assert(!iscollectable(obj) || ((ttype(obj) == (obj)->value.gc->gch.tt) && !isdead(g, (obj)->value.gc)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setnilvalue(obj) ((obj)->tt=LUA_TNIL)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setnvalue(obj,x) { TValue *i_o=(obj); i_o->value.n=(x); i_o->tt=LUA_TNUMBER; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setpvalue(obj,x) { TValue *i_o=(obj); i_o->value.p=(x); i_o->tt=LUA_TLIGHTUSERDATA; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setbvalue(obj,x) { TValue *i_o=(obj); i_o->value.b=(x); i_o->tt=LUA_TBOOLEAN; }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setsvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TSTRING; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setuvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TUSERDATA; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setthvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TTHREAD; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setclvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TFUNCTION; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define sethvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TTABLE; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setptvalue(L,obj,x) { TValue *i_o=(obj); i_o->value.gc=cast(GCObject *, (x)); i_o->tt=LUA_TPROTO; checkliveness(G(L),i_o); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj(L,obj1,obj2) { const TValue *o2=(obj2); TValue *o1=(obj1); o1->value = o2->value; o1->tt=o2->tt; checkliveness(G(L),o1); }
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobjs2s setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2s setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setsvalue2s setsvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define sethvalue2s sethvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setptvalue2s setptvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobjt2t setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2t setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2n setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setsvalue2n setsvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setttype(obj, tt) (ttype(obj) = (tt))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define iscollectable(o) (ttype(o) >= LUA_TSTRING)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define getstr(ts) cast(const char *, (ts) + 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define svalue(o) getstr(rawtsvalue(o))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ClosureHeader CommonHeader; lu_byte isC; lu_byte nupvalues; GCObject *gclist; struct Table *env
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define iscfunction(o) (ttype(o) == LUA_TFUNCTION && clvalue(o)->c.isC)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define isLfunction(o) (ttype(o) == LUA_TFUNCTION && !clvalue(o)->c.isC)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define lmod(s,size) (check_exp((size&(size-1))==0, (cast(int, (s) & ((size)-1)))))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define twoto(x) (1<<(x))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define sizenode(t) (twoto((t)->lsizenode))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaO_nilobject (&luaO_nilobject_)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ceillog2(x) (luaO_log2((x)-1) + 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_reallocv(L,b,on,n,e) ((cast(size_t, (n)+1) <= MAX_SIZET/(e)) ? luaM_realloc_(L, (b), (on)*(e), (n)*(e)) : luaM_toobig(L))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_freemem(L, b, s) luaM_realloc_(L, (b), (s), 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_free(L, b) luaM_realloc_(L, (b), sizeof(*(b)), 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_freearray(L, b, n, t) luaM_reallocv(L, (b), n, 0, sizeof(t))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_malloc(L,t) luaM_realloc_(L, NULL, 0, (t))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_new(L,t) cast(t *, luaM_malloc(L, sizeof(t)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_newvector(L,n,t) cast(t *, luaM_reallocv(L, NULL, 0, n, sizeof(t)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_growvector(L,v,nelems,size,t,limit,e) if ((nelems)+1 > (size)) ((v)=cast(t *, luaM_growaux_(L,v,&(size),sizeof(t),limit,e)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaM_reallocvector(L, v,oldn,n,t) ((v)=cast(t *, luaM_reallocv(L, v, oldn, n, sizeof(t))))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define char2int(c) cast(int, cast(unsigned char, (c)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define zgetc(z) (((z)->n--)>0 ? char2int(*(z)->p++) : luaZ_fill(z))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_initbuffer(L, buff) ((buff)->buffer = NULL, (buff)->buffsize = 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_buffer(buff) ((buff)->buffer)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_sizebuffer(buff) ((buff)->buffsize)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_bufflen(buff) ((buff)->n)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_resetbuffer(buff) ((buff)->n = 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_resizebuffer(L, buff, size) (luaM_reallocvector(L, (buff)->buffer, (buff)->buffsize, size, char), (buff)->buffsize = size)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaZ_freebuffer(L, buff) luaZ_resizebuffer(L, buff, 0)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define TOKEN_LEN (sizeof("function")/sizeof(char))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NUM_RESERVED (cast(int, TK_WHILE-FIRST_RESERVED+1))
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
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_Bx ((1<<SIZE_Bx)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_sBx (MAXARG_Bx>>1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_Bx MAX_INT
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_sBx MAX_INT
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_A ((1<<SIZE_A)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_B ((1<<SIZE_B)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXARG_C ((1<<SIZE_C)-1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MASK1(n,p) ((~((~(Instruction)0)<<n))<<p)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MASK0(n,p) (~MASK1(n,p))
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
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define BITRK (1 << (SIZE_B - 1))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ISK(x) ((x) & BITRK)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define INDEXK(r) ((int)(r) & ~BITRK)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define MAXINDEXRK (BITRK - 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define RKASK(x) ((x) | BITRK)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NO_REG MAXARG_A
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NUM_OPCODES (cast(int, OP_VARARG) + 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define getOpMode(m) (cast(enum OpMode, luaP_opmodes[m] & 3))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define getBMode(m) (cast(enum OpArgMask, (luaP_opmodes[m] >> 4) & 3))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define getCMode(m) (cast(enum OpArgMask, (luaP_opmodes[m] >> 2) & 3))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define testAMode(m) (luaP_opmodes[m] & (1 << 6))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define testTMode(m) (luaP_opmodes[m] & (1 << 7))


/*
** Marks the end of a patch list. It is an invalid value both as an absolute
** address, and as a list link (would link an element to itself).
*/


/*
** grep "ORDER OPR" if you change these enums
*/
public enum BinOpr
{
  OPR_ADD,
  OPR_SUB,
  OPR_MUL,
  OPR_DIV,
  OPR_MOD,
  OPR_POW,
  OPR_CONCAT,
  OPR_NE,
  OPR_EQ,
  OPR_LT,
  OPR_LE,
  OPR_GT,
  OPR_GE,
  OPR_AND,
  OPR_OR,
  OPR_NOBINOPR
}


public enum UnOpr
{
	OPR_MINUS,
	OPR_NOT,
	OPR_LEN,
	OPR_NOUNOPR
}