using System.ComponentModel.Composition;
using Microsoft.VisualStudio.Text.Classification;
using Microsoft.VisualStudio.Utilities;
using Microsoft.VisualStudio.Language.StandardClassification;

namespace sebagomez.VSProlog.Coloring.Classification
{
	internal static class OrdinaryClassificationDefinition
	{
		#region Type definition

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologText)]
		internal static ClassificationTypeDefinition PrologTextClassificationDef = null;
		//[BaseDefinition(PredefinedClassificationTypeNames.String)]

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologError)]
		internal static ClassificationTypeDefinition error = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologComment)]
		internal static ClassificationTypeDefinition comment = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologHead)]
		internal static ClassificationTypeDefinition head = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologKeyword)]
		internal static ClassificationTypeDefinition keyword = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologKeyline)]
		internal static ClassificationTypeDefinition keyline = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(PrologTokenHelper.PrologPublictoken)]
		internal static ClassificationTypeDefinition publictoken = null;

		#endregion
	}
}
