//========================================================================
// This conversion was produced by the Free Edition of
// C++ to C# Converter courtesy of Tangible Software Solutions.
// Order the Premium Edition at https://www.tangiblesoftwaresolutions.com
//========================================================================

/*
** Execute a protected call.
*/
public class CallS
{ // data to `f_call'
  public lua_TValue func;
  public int nresults;
}


/*
** Execute a protected C call.
*/
public class CCallS
{ // data to `f_Ccall'
  public lua_CFunction func;
  public object ud;
}