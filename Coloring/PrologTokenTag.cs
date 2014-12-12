using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Tagging;
using Microsoft.VisualStudio.Utilities;
using sebagomez.VSProlog.Coloring.Data;

namespace sebagomez.VSProlog.Coloring
{
	[Export(typeof(ITaggerProvider))]
	[ContentType("Prolog")]
	[TagType(typeof(PrologTokenTag))]
	internal sealed class PrologTokenTagProvider : ITaggerProvider
	{

		public ITagger<T> CreateTagger<T>(ITextBuffer buffer) where T : ITag
		{
			return new PrologTokenTagger(buffer) as ITagger<T>;
		}
	}

	public class PrologTokenTag : ITag
	{
		public PrologTokenTypes TokenType { get; private set; }

		public PrologTokenTag(PrologTokenTypes type)
		{
			TokenType = type;
		}
	}

	internal sealed class PrologTokenTagger : ITagger<PrologTokenTag>
	{
		ITextBuffer _buffer;
		IDictionary<string, PrologTokenTypes> _prologTypes;

		internal PrologTokenTagger(ITextBuffer buffer)
		{
			_buffer = buffer;
			_prologTypes = new Dictionary<string, PrologTokenTypes>();

			foreach (PrologTokenTypes token in Enum.GetValues(typeof(PrologTokenTypes)))
				_prologTypes.Add(token.ToString(), token);
		}

		public event EventHandler<SnapshotSpanEventArgs> TagsChanged
		{
			add { }
			remove { }
		}

		public IEnumerable<ITagSpan<PrologTokenTag>> GetTags(NormalizedSnapshotSpanCollection spans)
		{
			foreach (SnapshotSpan curSpan in spans)
			{
				ITextSnapshotLine containingLine = curSpan.Start.GetContainingLine();
				int curLoc = containingLine.Start.Position;
				string formattedLine = containingLine.GetText();

				foreach (SnapshotHelper item in PrologCodeHelper.GetTokens(curSpan))
				{
					if (item.Snapshot.IntersectsWith(curSpan))
						yield return new TagSpan<PrologTokenTag>(item.Snapshot, new PrologTokenTag(item.TokenType));
				}

				//add an extra char location because of the space
				curLoc += formattedLine.Length + 1;
			}

		}
	}
}
