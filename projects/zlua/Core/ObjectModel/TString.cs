namespace ZoloLua.Core.ObjectModel
{
    /// <summary>
    ///     the string type of lua, just warpper of C# string
    /// </summary>
    public class TString : GCObject
    {
        public string str; //可以设置str，这样复用TString对象，因为只是个warpper，

        public TString(string str)
        {
            this.str = str;
        }

        public int len => str.Length;

        public override string ToString()
        {
            return str;
        }

        public override bool Equals(object obj)
        {
            return obj is TString && str.Equals((obj as TString).str);
        }

        public override int GetHashCode()
        {
            return str.GetHashCode();
        }

        public static implicit operator string(TString tstr)
        {
            return tstr.str;
        }

        public static implicit operator TString(string str)
        {
            return new TString(str);
        }
    }
}