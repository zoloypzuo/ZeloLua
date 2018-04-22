//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

/*
** {======================================================
** PATTERN MATCHING
** =======================================================
*/



public class MatchState
{
  public readonly string src_init; // init of source string
  public readonly string src_end; // end (`\0') of source string
  public lua_State L;
  public int level; // total number of captures (finished or unfinished)
//C++ TO C# CONVERTER NOTE: Classes must be named in C#, so the following class has been named AnonymousClass7:
  public class AnonymousClass7
  {
	public readonly string init;
	public ptrdiff_t len = new ptrdiff_t();
  }
  public AnonymousClass7[] capture = Arrays.InitializeWithDefaultInstances<AnonymousClass7>(DefineConstants.LUA_MAXCAPTURES);
}