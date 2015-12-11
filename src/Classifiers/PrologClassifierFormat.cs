//------------------------------------------------------------------------------
// <copyright file="PrologClassifierFormat.cs" company="Company">
//     Copyright (c) Company.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

using System.ComponentModel.Composition;
using System.Windows.Media;
using Microsoft.VisualStudio.Text.Classification;
using Microsoft.VisualStudio.Utilities;
using sebagomez.VSProlog.Helpers;

namespace sebagomez.VSProlog.Classifiers
{
	/// <summary>
	/// Defines an editor format for the PrologClassifier type that has a purple background
	/// and is underlined.
	/// </summary>
	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = "PrologClassifier")]
	[Name("PrologClassifier")]
	[UserVisible(true)] // This should be visible to the end user
	[Order(Before = Priority.Default)] // Set the priority to be after the default classifiers
	internal sealed class PrologClassifierFormat : ClassificationFormatDefinition
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="PrologClassifierFormat"/> class.
		/// </summary>
		public PrologClassifierFormat()
		{
			this.DisplayName = "PrologClassifier"; // Human readable version of the name
			this.BackgroundColor = Colors.BlueViolet;
			this.TextDecorations = System.Windows.TextDecorations.Underline;
		}
	}

	#region Format definition

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = Helpers.PrologTokens.PrologTokenHelper.PrologError)]
	[Name("PrologErrorFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class ErrorFormat : ClassificationFormatDefinition
	{
		public ErrorFormat()
		{
			this.DisplayName = "This is an error"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark? (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString(VSThemeColorHelper.RED) :  Colors.Red;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologComment)]
	[Name("PrologCommentFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class CommentFormat : ClassificationFormatDefinition
	{
		public CommentFormat()
		{
			this.DisplayName = "This is a comment"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark ? (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString(VSThemeColorHelper.GREEN) : Colors.Green;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologHead)]
	[Name("PrologHeadFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class HeadFormat : ClassificationFormatDefinition
	{
		public HeadFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.IsBold = true;
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark ? Colors.DarkCyan : Colors.DarkCyan;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologKeyline)]
	[Name("PrologKeylineFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class KeylineFormat : ClassificationFormatDefinition
	{
		public KeylineFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark ? (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString(VSThemeColorHelper.BLUE) : this.ForegroundColor = Colors.Blue;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologKeyword)]
	[Name("PrologKeywordFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class KeywordFormat : ClassificationFormatDefinition
	{
		public KeywordFormat()
		{
			this.DisplayName = "This is a definition"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark? (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString(VSThemeColorHelper.BLUE) : Colors.Blue;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologText)]
	[Name("PrologTextFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class PrologTextFormatDef : ClassificationFormatDefinition
	{
		public PrologTextFormatDef()
		{
			this.DisplayName = "This is a text"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark ? (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString(VSThemeColorHelper.RED) : Colors.DarkRed;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologPublictoken)]
	[Name("PrologPublicTokenFormat")]
	[UserVisible(false)]
	[Order(Before = Priority.Default)]
	internal sealed class PublicTokenFormat : ClassificationFormatDefinition
	{
		public PublicTokenFormat()
		{
			this.DisplayName = "This is a text"; //human readable version of the name
			this.ForegroundColor = VSThemeColorHelper.CurrentTheme == VSThemeColorHelper.Theme.Dark? Colors.Cyan : Colors.DarkCyan;
		}
	}

	[Export(typeof(EditorFormatDefinition))]
	[ClassificationType(ClassificationTypeNames = PrologTokens.PrologTokenHelper.PrologParenthesis)]
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
