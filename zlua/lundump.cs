//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

/* for header of binary files -- this is Lua 5.1 */

/* for header of binary files -- this is the official format */

/* size of header of binary files */



public class LoadState
{
 public lua_State L;
 public Zio Z;
 public Mbuffer[] b;
 public readonly string name;
}

#if LUAC_TRUST_BINARIES
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define IF(c,s)
#define IF
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define error(S,s)
#define error
#else
//C++ TO C# CONVERTER TODO TASK: #define macros defined in multiple preprocessor conditionals can only be replaced within the scope of the preprocessor conditional:
//C++ TO C# CONVERTER NOTE: The following #define macro was replaced in-line:
//ORIGINAL LINE: #define IF(c,s) if (c) error(S,s)
#define IF

//C++ TO C# CONVERTER TODO TASK: Statements that are interrupted by preprocessor statements are not converted by C++ to C# Converter:
//C++ TO C# CONVERTER TODO TASK: The following statement was not recognized, possibly due to an unrecognized macro:
static void ({luaO_pushfstring(S.L,"%s: %s in precompiled chunk",S.name,why); luaD_throw(S.L,DefineConstants.LUA_ERRSYNTAX);})
#endif