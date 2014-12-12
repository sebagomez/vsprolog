using System.ComponentModel.Composition;
using System.Windows.Media;
using Microsoft.VisualStudio.Text.Classification;
using Microsoft.VisualStudio.Utilities;
using Microsoft.VisualStudio.Language.StandardClassification;

namespace sebagomez.VSProlog.Coloring.Classification
{
	#region Format definition
	
	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologError)]
	[Name("PrologErrorFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class ErrorFormat : ClassificationFormatDefinition
	{
		public ErrorFormat()
		{
			this.DisplayName = "This is an error"; //human readable version of the name
			this.ForegroundColor = Colors.Red;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologComment)]
	[Name("PrologCommentFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class CommentFormat : ClassificationFormatDefinition
	{
		public CommentFormat()
		{
			this.DisplayName = "This is a comment"; //human readable version of the name
			this.ForegroundColor = Colors.Green;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologHead)]
	[Name("PrologHeadFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class HeadFormat : ClassificationFormatDefinition
	{
		public HeadFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.IsBold = true;
			this.ForegroundColor = Colors.DarkCyan;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologKeyline)]
	[Name("PrologKeylineFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class KeylineFormat : ClassificationFormatDefinition
	{
		public KeylineFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.ForegroundColor = Colors.Blue;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologKeyword)]
	[Name("PrologKeywordFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class KeywordFormat : ClassificationFormatDefinition
	{
		public KeywordFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.ForegroundColor = Colors.Blue;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologText)]
	[Name("PrologTextFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class PrologTextFormatDef : ClassificationFormatDefinition
	{
		public PrologTextFormatDef()
		{
			this.DisplayName = "This is a text"; //human readable version of the name
			this.ForegroundColor = Colors.DarkRed;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologPublictoken)]
	[Name("PrologPublicTokenFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class PublicTokenFormat : ClassificationFormatDefinition
	{
		public PublicTokenFormat()
		{
			this.DisplayName = "This is a text"; //human readable version of the name
			this.ForegroundColor = Colors.DarkCyan;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokenHelper.PrologParenthesis)]
	[Name("PrologParenthesisTokenFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class ParenthesisTokenFormat : ClassificationFormatDefinition
	{
		public ParenthesisTokenFormat()
		{
			this.DisplayName = "This is a text"; //human readable version of the name
			//this.ForegroundColor = Colors.DarkCyan;
			this.IsBold = true;
		}
	}
	
	#endregion //Format definition
}
