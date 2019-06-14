using System;
using System.Linq;
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
														   //const string HEAD_REG2 = @"^(\w)+(.*)\."; // ends with .
		const string HEAD_REG3 = @"^(\w)+(.*)\("; // ends with (
		const string TEXT_REG = @"'[^']*'";
		const string PUBLIC_REG = @"^\u003a\u002d+(.)*";
		const string NUMBER_REG = @"\W(\d+)";

		const string START_BLOCK_COMMENT_REG = @"/\*(.*)";
		const string END_BLOCK_COMMENT_REG = @"(.*?)\*/";
		const string BLOCK_COMMENT_REG = @"/\*(.*?)\*/";

		static readonly string[] KEYWORDS = new string[] { "fail", "true", "Yes" };

		//const string TEXT2_REG = @"\$[^']*\$";

		static object lockObject = new object();

		public static IList<ClassificationSpan> GetTokens(SnapshotSpan snapSpan, IClassificationTypeRegistryService registry)
		{
			lock (lockObject)
			{
				Regex blockReg = new Regex(BLOCK_COMMENT_REG);
				Regex startCommReg = new Regex(START_BLOCK_COMMENT_REG);
				Regex endCommReg = new Regex(END_BLOCK_COMMENT_REG);

				List<ClassificationSpan> result = new List<ClassificationSpan>();
				var lines = snapSpan.Snapshot.Lines.Where(l => l.Start >= snapSpan.Start && l.End <= snapSpan.End);
				//var lines = snapSpan.Snapshot.Lines;
				bool inCommentBlock = false;

				foreach (var line in lines)
				{

					SnapshotSpan span = line.Extent;

					int curLoc = line.Start.Position;
					string formattedLine = line.GetText();
					int commentStart = formattedLine.Length;
					int commentEnd = formattedLine.Length;

					Regex reg = new Regex(COMMENTLINE_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{

						commentStart = Math.Min(match.Index, commentStart);

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment));
					}

					foreach (Match match in blockReg.Matches(formattedLine))
					{
						commentStart = Math.Min(match.Index, commentStart);
						commentEnd = Math.Min(match.Index + match.Length, commentEnd);
						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment));

					}


					foreach (Match match in startCommReg.Matches(formattedLine))
					{
						if (match.Index >= commentStart && match.Index < commentEnd)
							continue;

						commentStart = Math.Min(match.Index + curLoc, commentStart);
						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment));
						inCommentBlock = true;
					}


					foreach (Match match in endCommReg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;
						if (formattedLine.IndexOf("/*") != -1 && formattedLine.IndexOf("/*") < formattedLine.IndexOf("*/"))
							continue;

						commentEnd = Math.Max(match.Index + curLoc + match.Length, commentEnd);

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment));
						inCommentBlock = false;
					}

					if (inCommentBlock)
					{
						AddClassificatioType(result, span, null, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologComment));
						continue;
					}

					reg = new Regex(KEYLINE_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologKeyline));
					}

					reg = new Regex(HEAD_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;
						if (match.Value.Contains("("))
							continue;

						int length = formattedLine.IndexOf(":-");
						result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), length != -1 ? length : match.Length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologHead)));
					}

					reg = new Regex(HEAD_REG3);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;

						int length = Math.Min(match.Length, formattedLine.IndexOf("("));
						result.Add(new ClassificationSpan(new SnapshotSpan(new SnapshotPoint(span.Snapshot, match.Index + curLoc), length), registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologHead)));
					}


					reg = new Regex(TEXT_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologText));
					}

					foreach (string keyword in KEYWORDS)
					{
						reg = new Regex($@"\b{keyword}");
						foreach (Match match in reg.Matches(formattedLine))
						{
							if (match.Index > commentStart)
								continue;

							AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologKeyword));
						}
					}

					reg = new Regex(NUMBER_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologNumber));
					}

					reg = new Regex(PUBLIC_REG);
					foreach (Match match in reg.Matches(formattedLine))
					{
						if (match.Index > commentStart)
							continue;

						AddClassificatioType(result, span, match, registry.GetClassificationType(PrologTokens.PrologTokenHelper.PrologPublictoken));
					}


					if (!inCommentBlock && result.Count > 0)
						return result;
				}

				return result;
			}

		}

		static void AddClassificatioType(List<ClassificationSpan> result, SnapshotSpan span, Match match, IClassificationType classificationType)
		{
			int start = match == null ? 0 : match.Index;
			int length = match == null ? span.Length : match.Length;
			SnapshotSpan regSpan = new SnapshotSpan(span.Snapshot, span.Start.Position + start, length);
			result.Add(new ClassificationSpan(regSpan, classificationType));
		}
	}
}
