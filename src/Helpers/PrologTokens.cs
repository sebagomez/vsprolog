namespace sebagomez.VSProlog.Helpers
{
	public class PrologTokens
	{
		public enum PrologTokenTypes
		{
			PrologError, PrologComment, PrologHead, PrologKeyline, PrologKeyword, PrologText, PrologPublictoken, PrologParenthesis, PrologNumber
		}

		public sealed class PrologTokenHelper
		{
			public const string PrologError = "PrologError";
			public const string PrologComment = "PrologComment";
			public const string PrologHead = "PrologHead";
			public const string PrologKeyline = "PrologKeyline";
			public const string PrologKeyword = "PrologKeyword";
			public const string PrologText = "PrologText";
			public const string PrologPublictoken = "PrologPublictoken";
			public const string PrologParenthesis = "PrologParenthesis";
			public const string PrologNumber = "PrologNumber";
		}
	}
}
