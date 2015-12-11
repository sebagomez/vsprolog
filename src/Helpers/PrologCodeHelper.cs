using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Classification;

namespace sebagomez.VSProlog.Helpers
{
	class PrologCodeHelper
	{
		const string COMMENTLINE_REG = @"\u0025(.*)"; // %
		const string KEYLINE_REG = @"\u0023([\w]*)"; // #
		const string HEAD_REG = @"^(\w)+(.*)\u003a\u002d"; // :-
		const string TEXT_REG = @"'[^']*'";
		const string PUBLIC_REG = @"^\u003a\u002d+(.)*";

		const string START_BLOCK_COMMENT_REG = @"/\*(.*)";
		const string END_BLOCK_COMMENT_REG = @"(.*?)\*/";
		const string BLOCK_COMMENT_REG = @"/\*(.*?)\*/";

		//const string TEXT2_REG = @"\$[^']*\$";

		public static IList<ClassificationSpan> GetTokens(SnapshotSpan span, IClassificationTypeRegistryService registry)
		{
			Regex blockReg = new Regex(BLOCK_COMMENT_REG);
			Regex startCommReg = new Regex(START_BLOCK_COMMENT_REG);
			Regex endCommReg = new Regex(END_BLOCK_COMMENT_REG);

			var result = new List<ClassificationSpan>();
			ITextSnapshotLine containingLine = span.Start.GetContainingLine();
			int curLoc = containingLine.Start.Position;
			string formattedLine = containingLine.GetText();
			int commentStart = int.MaxValue;
			int commentEnd = int.MinValue;

			//string text = span.GetText();

			//bool inCommentBlock = false;
			//for (int i = containingLine.LineNumber - 1; 0 <= i; i--)
			//{
			//	var line = span.Snapshot.GetLineFromLineNumber(i);
			//	string lineText = line.GetText();
			//	if (blockReg.IsMatch(lineText))
			//		continue;
			//	if (endCommReg.IsMatch(lineText))
			//	{
			//		inCommentBlock = false;
			//		break;
			//	}
			//	if (startCommReg.IsMatch(lineText))
			//	{
			//		inCommentBlock = true;
			//		break;
			//	}
			//}

			//int currentLine = containingLine.LineNumber;
			//if (currentLine > 0)
			//{
			//	ITextSnapshotLine prevLine = span.Snapshot.GetLineFromLineNumber(currentLine - 1);
				

			//}

			//if (inCommentBlock)
			//{
			//	result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, curLoc), formattedLine.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment)));
			//	return result;
			//}

			Regex reg = new Regex(COMMENTLINE_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				commentStart = Math.Min(match.Index + curLoc, commentStart);
				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment)));
			}

			foreach (Match match in blockReg.Matches(formattedLine))
			{
				commentStart = Math.Min(match.Index + curLoc, commentStart);
				commentEnd = Math.Max(match.Index + curLoc + match.Length, commentEnd);
				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment)));
			}

			foreach (Match match in startCommReg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				commentStart = Math.Min(match.Index + curLoc, commentStart);
				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment)));
			}

			foreach (Match match in endCommReg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				commentEnd = Math.Max(match.Index + curLoc + match.Length, commentEnd);
				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment)));
			}


			reg = new Regex(KEYLINE_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologKeyline)));

			}

			reg = new Regex(HEAD_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				int length = formattedLine.IndexOf("(");
				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), length != -1 ? length : match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologHead)));
			}

			reg = new Regex(TEXT_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologText)));
			}

			reg = new Regex(PUBLIC_REG);
			foreach (Match match in reg.Matches(formattedLine))
			{
				if (match.Index > commentStart)
					continue;

				result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologPublictoken)));
			}

			return result;

		}
	}
}
