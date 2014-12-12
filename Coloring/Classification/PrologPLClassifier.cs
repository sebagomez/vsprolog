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
	internal sealed class PrologPLClassifier : ITaggerProvider
	{

		[Export]
		[Name("Prolog")]
		[BaseDefinition("code")]
		internal static ContentTypeDefinition PrologContentType = null;

		[Export]
		[FileExtension(".pl")]
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
	
}
