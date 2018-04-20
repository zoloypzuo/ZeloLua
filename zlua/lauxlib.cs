//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

using System;

/* extra error code for `luaL_load' */
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define LUA_ERRFILE (LUA_ERRERR+1)


public class luaL_Reg
{
  public readonly string name;
  public lua_CFunction func;
}




/*
** ===============================================================
** some useful macros
** ===============================================================
*/

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_argcheck(L, cond,numarg,extramsg) ((void)((cond) || luaL_argerror(L, (numarg), (extramsg))))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_checkstring(L,n) (luaL_checklstring(L, (n), NULL))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_optstring(L,n,d) (luaL_optlstring(L, (n), (d), NULL))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_checkint(L,n) ((int)luaL_checkinteger(L, (n)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_optint(L,n,d) ((int)luaL_optinteger(L, (n), (d)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_checklong(L,n) ((long)luaL_checkinteger(L, (n)))
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_optlong(L,n,d) ((long)luaL_optinteger(L, (n), (d)))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_typename(L,i) lua_typename(L, lua_type(L,(i)))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_dofile(L, fn) (luaL_loadfile(L, fn) || lua_pcall(L, 0, LUA_MULTRET, 0))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_dostring(L, s) (luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_getmetatable(L,n) (lua_getfield(L, LUA_REGISTRYINDEX, (n)))

//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define luaL_opt(L,f,n,d) (lua_isnoneornil(L,(n)) ? (d) : f(L,(n)))

/*
** {======================================================
** Generic Buffer manipulation
** =======================================================
*/



public class luaL_Buffer
{
  public string p; // current position in buffer
  public int lvl; // number of strings in the stack (level)
  public lua_State L;
  public string buffer = new string(new char[BUFSIZ]);
}



/*
** {======================================================
** Load functions
** =======================================================
*/

public class LoadF
{
  public int extraline;
  public FILE f;
  public string buff = new string(new char[BUFSIZ]);
}


public class LoadS
{
  public readonly string s;
  public size_t size = new size_t();
}