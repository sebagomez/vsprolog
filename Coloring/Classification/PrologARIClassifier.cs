using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Classification;
using Microsoft.VisualStudio.Text.Tagging;
using Microsoft.VisualStudio.Utilities;

namespace sebagomez.VSProlog.Coloring.Classification
{
	[Export(typeof(ITaggerProvider))]
	[ContentType("Prolog")]
	[TagType(typeof(ClassificationTag))]
	internal sealed class PrologClassifierProvider : ITaggerProvider
	{

		[Export]
		[Name("Prolog")]
		[BaseDefinition("code")]
		internal static ContentTypeDefinition PrologContentType = null;

		[Export]
		[FileExtension(".ari")]
		[ContentType("Prolog")]
		internal static FileExtensionToContentTypeDefinition PrologFileType = null;

		[Import]
		internal IClassificationTypeRegistryService ClassificationTypeRegistry = null;

		[Import]
		internal IBufferTagAggregatorFactoryService aggregatorFactory = null;

		public ITagger<T> CreateTagger<T>(ITextBuffer buffer) where T : ITag
		{

			ITagAggregator<PrologTokenTag> prologTagAggregator = 
											aggregatorFactory.CreateTagAggregator<PrologTokenTag>(buffer);

			return new PrologClassifier(buffer, prologTagAggregator, ClassificationTypeRegistry) as ITagger<T>;
		}
	}

	internal sealed class PrologClassifier : ITagger<ClassificationTag>
	{
		ITextBuffer _buffer;
		ITagAggregator<PrologTokenTag> _aggregator;
		IDictionary<PrologTokenTypes, IClassificationType> _prologTypes;

		internal PrologClassifier(ITextBuffer buffer, 
							   ITagAggregator<PrologTokenTag> prologTagAggregator, 
							   IClassificationTypeRegistryService typeService)
		{
			_buffer = buffer;
			_aggregator = prologTagAggregator;
			_prologTypes = new Dictionary<PrologTokenTypes, IClassificationType>();

			foreach (PrologTokenTypes token in Enum.GetValues(typeof(PrologTokenTypes)))
				_prologTypes[token] = typeService.GetClassificationType(token.ToString());				
		}

		public event EventHandler<SnapshotSpanEventArgs> TagsChanged
		{
			add { }
			remove { }
		}

		public IEnumerable<ITagSpan<ClassificationTag>> GetTags(NormalizedSnapshotSpanCollection spans)
		{

			foreach (var tagSpan in this._aggregator.GetTags(spans))
			{
				var tagSpans = tagSpan.Span.GetSpans(spans[0].Snapshot);
				yield return new TagSpan<ClassificationTag>(tagSpans[0], new ClassificationTag(_prologTypes[tagSpan.Tag.TokenType]));
			}
		}
	}
}
