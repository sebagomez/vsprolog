//------------------------------------------------------------------------------
// <copyright file="PrologClassifier.cs" company="Company">
//     Copyright (c) Company.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.Text;
using Microsoft.VisualStudio.Text.Classification;
using sebagomez.VSProlog.Helpers;

namespace sebagomez.VSProlog.Classifiers
{
	/// <summary>
	/// Classifier that classifies all text as an instance of the "PrologClassifier" classification type.
	/// </summary>
	internal class PrologClassifier : IClassifier
	{
		/// <summary>
		/// Classification type.
		/// </summary>
		private readonly IClassificationType classificationType;

		/// <summary>
		/// Initializes a new instance of the <see cref="PrologClassifier"/> class.
		/// </summary>
		/// <param name="registry">Classification registry.</param>
		internal PrologClassifier(IClassificationTypeRegistryService registry)
		{
			m_registry = registry;
			this.classificationType = registry.GetClassificationType("PrologClassifier");
		}

		IClassificationTypeRegistryService m_registry;

		#region IClassifier

#pragma warning disable 67

		/// <summary>
		/// An event that occurs when the classification of a span of text has changed.
		/// </summary>
		/// <remarks>
		/// This event gets raised if a non-text change would affect the classification in some way,
		/// for example typing /* would cause the classification to change in C# without directly
		/// affecting the span.
		/// </remarks>
		public event EventHandler<ClassificationChangedEventArgs> ClassificationChanged;

#pragma warning restore 67

		/// <summary>
		/// Gets all the <see cref="ClassificationSpan"/> objects that intersect with the given range of text.
		/// </summary>
		/// <remarks>
		/// This method scans the given SnapshotSpan for potential matches for this classification.
		/// In this instance, it classifies everything and returns each span as a new ClassificationSpan.
		/// </remarks>
		/// <param name="span">The span currently being classified.</param>
		/// <returns>A list of ClassificationSpans that represent spans identified to be of this classification.</returns>
		public IList<ClassificationSpan> GetClassificationSpans(SnapshotSpan span)
		{
			return PrologCodeHelper.GetTokens(span, m_registry);
		}

		#endregion
	}
}
