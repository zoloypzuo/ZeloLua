//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

using System.Runtime.InteropServices;

/*
** $Id: lobject.c,v 2.22.1.1 2007/12/27 13:02:25 roberto Exp $
** Some generic functions over Lua objects
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
** $Id: lobject.h,v 2.20.1.2 2008/08/06 13:29:48 roberto Exp $
** Type definitions for Lua objects
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


/* tags for values visible from Lua */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LAST_TAG LUA_TTHREAD

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define NUM_TAGS (LAST_TAG+1)


/*
** Extra tags for non-values
*/
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TPROTO (LAST_TAG+1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TUPVAL (LAST_TAG+2)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_TDEADKEY (LAST_TAG+3)


/*
** Union of all collectable objects
*/


/*
** Common Header for all collectable objects (in macro form, to be
** included in other objects)
*/
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define CommonHeader GCObject *next; lu_byte tt; lu_byte marked


/*
** Common header in struct form
*/
public class GCheader
{
  public GCObject next;
  public byte tt;
  public byte marked;
}




/*
** Union of all Lua values
*/
//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#:
//ORIGINAL LINE: union Value
public struct Value
{
  public GCObject gc;
  public object[] p;
  public double n;
  public int b;
}


/*
** Tagged Values
*/

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define TValuefields Value value; int tt

public class lua_TValue
{
  public Value value = new Value();
  public int tt;
}


/* Macros to test type */
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

/* Macros to access values */
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

/*
** for internal debug only
*/
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define checkconsistency(obj) lua_assert(!iscollectable(obj) || (ttype(obj) == (obj)->value.gc->gch.tt))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define checkliveness(g,obj) lua_assert(!iscollectable(obj) || ((ttype(obj) == (obj)->value.gc->gch.tt) && !isdead(g, (obj)->value.gc)))


/* Macros to set values */
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


/*
** different types of sets, according to destination
*/

/* from stack to (same) stack */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobjs2s setobj
/* to stack (not from same stack) */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2s setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setsvalue2s setsvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define sethvalue2s sethvalue
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setptvalue2s setptvalue
/* from table to same table */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobjt2t setobj
/* to table */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2t setobj
/* to new object */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setobj2n setobj
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setsvalue2n setsvalue

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define setttype(obj, tt) (ttype(obj) = (tt))


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define iscollectable(o) (ttype(o) >= LUA_TSTRING)





/*
** String headers for string table
*/
//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#:
//ORIGINAL LINE: union TString
public struct TString
{
  public L_Umaxalign dummy; // ensures maximum alignment for strings
//C++ TO C# CONVERTER NOTE: Classes must be named in C#, so the following class has been named AnonymousClass:
  public class AnonymousClass
  {
	public GCObject next;
	public byte tt;
	public byte marked;
	public byte reserved;
	public uint hash;
	public size_t len = new size_t();
  }
  public AnonymousClass tsv;
}


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define getstr(ts) cast(const char *, (ts) + 1)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define svalue(o) getstr(rawtsvalue(o))



//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#:
//ORIGINAL LINE: union Udata
public struct Udata
{
  public L_Umaxalign dummy; // ensures maximum alignment for `local' udata
//C++ TO C# CONVERTER NOTE: Classes must be named in C#, so the following class has been named AnonymousClass2:
  public class AnonymousClass2
  {
	public GCObject next;
	public byte tt;
	public byte marked;
	public Table metatable;
	public Table env;
	public size_t len = new size_t();
  }
  public AnonymousClass2 uv;
}




/*
** Function Prototypes
*/
public class Proto
{
  public GCObject next;
  public byte tt;
  public byte marked;
  public lua_TValue[] k; // constants used by the function
  public LUAI_UINT32[] code;
  public Proto[] p; // functions defined inside the function
  public int[] lineinfo; // map from opcodes to source lines
  public LocVar[] locvars; // information about local variables
  public TString[] upvalues; // upvalue names
  public TString[] source;
  public int sizeupvalues;
  public int sizek; // size of `k'
  public int sizecode;
  public int sizelineinfo;
  public int sizep; // size of `p'
  public int sizelocvars;
  public int linedefined;
  public int lastlinedefined;
  public GCObject gclist;
  public byte nups; // number of upvalues
  public byte numparams;
  public byte is_vararg;
  public byte maxstacksize;
}


/* masks for new-style vararg */


public class LocVar
{
  public TString varname;
  public int startpc; // first point where variable is active
  public int endpc; // first point where variable is dead
}



/*
** Upvalues
*/

public class UpVal
{
  public GCObject next;
  public byte tt;
  public byte marked;
  public lua_TValue v; // points to stack or to its own value
//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#:
//ORIGINAL LINE: union
//C++ TO C# CONVERTER NOTE: Structs must be named in C#, so the following struct has been named AnonymousStruct:
  public struct AnonymousStruct
  {
	public lua_TValue value; // the value (when closed)
//C++ TO C# CONVERTER NOTE: Classes must be named in C#, so the following class has been named AnonymousClass3:
	public class AnonymousClass3
	{ // double linked list (when open)
	  public UpVal prev;
	  public UpVal next;
	}
	public AnonymousClass3 l;
  }
  public AnonymousStruct u = new AnonymousStruct();
}


/*
** Closures
*/

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define ClosureHeader CommonHeader; lu_byte isC; lu_byte nupvalues; GCObject *gclist; struct Table *env

public class CClosure
{
  public GCObject next;
  public byte tt;
  public byte marked;
  public byte isC;
  public byte nupvalues;
  public GCObject gclist;
  public Table env;
  public lua_CFunction f;
  public lua_TValue[] upvalue = Arrays.InitializeWithDefaultInstances<lua_TValue>(1);
}


public class LClosure
{
  public GCObject next;
  public byte tt;
  public byte marked;
  public byte isC;
  public byte nupvalues;
  public GCObject gclist;
  public Table env;
  public Proto[] p;
  public UpVal[] upvals = Arrays.InitializeWithDefaultInstances<UpVal>(1);
}


//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#, but the following union can be replicated with the StructLayout and FieldOffset attributes:
//ORIGINAL LINE: union Closure
[StructLayout(LayoutKind.Explicit)]
public struct Closure
{
  [FieldOffset(0)]
  public CClosure c;
  [FieldOffset(0)]
  public LClosure l;
}


//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define iscfunction(o) (ttype(o) == LUA_TFUNCTION && clvalue(o)->c.isC)
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define isLfunction(o) (ttype(o) == LUA_TFUNCTION && !clvalue(o)->c.isC)


/*
** Tables
*/

//C++ TO C# CONVERTER TODO TASK: Unions are not supported in C#:
//ORIGINAL LINE: union TKey
public struct TKey
{
//C++ TO C# CONVERTER NOTE: Classes must be named in C#, so the following class has been named AnonymousClass4:
  public class AnonymousClass4
  {
	public Value value = new Value();
	public int tt;
	public Node next; // for chaining
  }
  public AnonymousClass4 nk;
  public lua_TValue tvk;
}


public class Node
{
  public lua_TValue i_val = new lua_TValue();
  public TKey i_key = new TKey();
}


public class Table
{
  public GCObject next;
  public byte tt;
  public byte marked;
  public byte flags; // 1<<p means tagmethod(p) is not present
  public byte lsizenode; // log2 of size of `node' array
  public Table metatable;
  public lua_TValue[] array; // array part
  public Node[] node;
  public Node lastfree; // any free position is before this position
  public GCObject gclist;
  public int sizearray; // size of `array' array
}