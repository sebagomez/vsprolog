//------------------------------------------------------------------------------
// <copyright file="PrologClassifierClassificationDefinition.cs" company="Company">
//     Copyright (c) Company.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

using System.ComponentModel.Composition;
using Microsoft.VisualStudio.Text.Classification;
using Microsoft.VisualStudio.Utilities;

namespace sebagomez.VSProlog.Classifiers
{
	/// <summary>
	/// Classification type definition export for PrologClassifier
	/// </summary>
	internal static class PrologClassifierClassificationDefinition
	{
		// This disables "The field is never used" compiler's warning. Justification: the field is used by MEF.
#pragma warning disable 169

		/// <summary>
		/// Defines the "PrologClassifier" classification type.
		/// </summary>
		[Export(typeof(ClassificationTypeDefinition))]
		[Name("PrologClassifier")]
		private static ClassificationTypeDefinition typeDefinition;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologText)]
		internal static ClassificationTypeDefinition PrologTextClassificationDef = null;
		//[BaseDefinition(PredefinedClassificationTypeNames.String)]

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologError)]
		internal static ClassificationTypeDefinition error = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologComment)]
		internal static ClassificationTypeDefinition comment = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologHead)]
		internal static ClassificationTypeDefinition head = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologKeyword)]
		internal static ClassificationTypeDefinition keyword = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologKeyline)]
		internal static ClassificationTypeDefinition keyline = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologPublictoken)]
		internal static ClassificationTypeDefinition publictoken = null;

		[Export(typeof(ClassificationTypeDefinition))]
		[Name(Helpers.PrologTokens.PrologTokenHelper.PrologNumber)]
		internal static ClassificationTypeDefinition number = null;

#pragma warning restore 169
	}
}
