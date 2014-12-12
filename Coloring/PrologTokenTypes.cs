
namespace sebagomez.VSProlog.Coloring
{
	public enum PrologTokenTypes
	{
		PrologError, PrologComment, PrologHead, PrologKeyline, PrologKeyword, PrologText, PrologPublictoken, PrologParenthesis
	}

	internal sealed class PrologTokenHelper
	{
		public const string PrologError = "PrologError";
		public const string PrologComment = "PrologComment";
		public const string PrologHead = "PrologHead";
		public const string PrologKeyline = "PrologKeyline";
		public const string PrologKeyword = "PrologKeyword";
		public const string PrologText = "PrologText";
		public const string PrologPublictoken = "PrologPublictoken";
		public const string PrologParenthesis = "PrologParenthesis";
	}
}
