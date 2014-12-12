using System.Collections.Generic;
using System.Text.RegularExpressions;
using Microsoft.VisualStudio.Text;
using sebagomez.VSProlog.Coloring.Data;

namespace sebagomez.VSProlog.Coloring
{
	internal class PrologCodeHelper
	{
		const string COMMENT_REG = @"\u0025(.*)"; // %
		const string KEYLINE_REG = @"\u0023([\w]*)"; // #
		const string HEAD_REG = @"^(\w)+(.*)\u003a\u002d"; // :-
		const string TEXT_REG = @"'[^']*'";
		const string PUBLIC_REG = @"^\u003a\u002d+(.)*";

		//const string TEXT2_REG = @"\$[^']*\$";

		public static IEnumerable<SnapshotHelper> GetTokens(SnapshotSpan span)
		{
			ITextSnapshotLine containingLine = span.Start.GetContainingLine();
			int curLoc = containingLine.Start.Position;
			string formattedLine = containingLine.GetText();

			int commentMatch = int.MaxValue;
			Regex reg = new Regex(COMMENT_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				commentMatch = match.Index < commentMatch ? match.Index : commentMatch;
				yield return new SnapshotHelper(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), PrologTokenTypes.PrologComment);
			}

			reg = new Regex(KEYLINE_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index < commentMatch)
					yield return new SnapshotHelper(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), PrologTokenTypes.PrologKeyline);
			}

			reg = new Regex(HEAD_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index < commentMatch)
				{
					int length = formattedLine.IndexOf("(");
					yield return new SnapshotHelper(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), length != -1 ? length : match.Length), PrologTokenTypes.PrologKeyline);
				}
			}

			reg = new Regex(TEXT_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index < commentMatch)
					yield return new SnapshotHelper(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), PrologTokenTypes.PrologText);
			}

			reg = new Regex(PUBLIC_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index < commentMatch)
					yield return new SnapshotHelper(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), PrologTokenTypes.PrologPublictoken);
			}

		}
	}

}
