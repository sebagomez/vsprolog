using System;
using System.ComponentModel.Composition;
using EnvDTE;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Editor;
using Microsoft.VisualStudio.OLE.Interop;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Shell.Interop;
using Microsoft.VisualStudio.Text.Editor;
using Microsoft.VisualStudio.TextManager.Interop;
using Microsoft.VisualStudio.Utilities;

namespace sebagomez.VSProlog.Commands
{
	[Export(typeof(IVsTextViewCreationListener))]
	[ContentType("Prolog")]
	[TextViewRole(PredefinedTextViewRoles.Editable)]
	class CommandFilterProvider : IVsTextViewCreationListener
	{
		[Import(typeof(IVsEditorAdaptersFactoryService))]
		internal IVsEditorAdaptersFactoryService editorFactory = null;

		public void VsTextViewCreated(IVsTextView textViewAdapter)
		{
			IWpfTextView textView = editorFactory.GetWpfTextView(textViewAdapter);
			if (textView == null)
				return;

			AddCommandFilter(textViewAdapter, new EditorCommandFilter(textView));
		}

		void AddCommandFilter(IVsTextView viewAdapter, EditorCommandFilter commandFilter)
		{
			//get the view adapter from the editor factory
			IOleCommandTarget next;
			int hr = viewAdapter.AddCommandFilter(commandFilter, out next);

			if (hr == VSConstants.S_OK)
			{
				if (next != null)
					commandFilter.SetNextTarget(next);
			}
		}
	}

	class EditorCommandFilter : IOleCommandTarget
	{
		private IWpfTextView m_textView;
		private IOleCommandTarget m_nextTarget;

		public EditorCommandFilter(IWpfTextView textView)
		{
			this.m_textView = textView;
		}

		internal void SetNextTarget(IOleCommandTarget nextTarget)
		{
			this.m_nextTarget = nextTarget;
		}

		public int Exec(ref Guid pguidCmdGroup, uint nCmdID, uint nCmdexecopt, IntPtr pvaIn, IntPtr pvaOut)
		{
			if (pguidCmdGroup == VSConstants.CMDSETID.StandardCommandSet97_guid && nCmdID == (uint)VSConstants.VSStd97CmdID.GotoDefn)
			{
				string currentPredicate = GetCurrentPredicte();

				if (string.IsNullOrWhiteSpace(currentPredicate))
					return (int)VSConstants.S_OK;

				DTE dte = Package.GetGlobalService(typeof(SDTE)) as DTE;

				if (dte == null || dte.ActiveDocument == null || dte.ActiveDocument.Object() == null || !(dte.ActiveDocument.Object() is TextDocument))
					return (int)VSConstants.S_OK;

				string fileExtension = dte.ActiveDocument.Name.Substring(dte.ActiveDocument.Name.LastIndexOf(".") + 1);

				dte.Find.Action = vsFindAction.vsFindActionFindAll;
				dte.Find.Backwards = true;
				dte.Find.FilesOfType = string.Format("*.{0}", fileExtension);
				dte.Find.FindWhat = "^" + currentPredicate + @"(\(.*\))*\:-"; //^pattern(\(.*\))*\:-
				dte.Find.KeepModifiedDocumentsOpen = true;
				dte.Find.MatchCase = false;
				dte.Find.MatchInHiddenText = true;
				dte.Find.MatchWholeWord = false;
				dte.Find.PatternSyntax = vsFindPatternSyntax.vsFindPatternSyntaxRegExpr;
				dte.Find.ResultsLocation = vsFindResultsLocation.vsFindResults1;
				dte.Find.SearchSubfolders = true;
#if DEBUG
				dte.Find.Target = vsFindTarget.vsFindTargetCurrentDocument;
#else
				dte.Find.Target = vsFindTarget.vsFindTargetCurrentProject;
#endif
				dte.Find.Execute();

				//Indicate we handled the Exec so the shell doesn't continue looking for handlers.
				return (int)VSConstants.S_OK;
			}
			else
			{
				if (m_nextTarget != null)
				{
					return m_nextTarget.Exec(ref pguidCmdGroup, nCmdID, nCmdexecopt, pvaIn, pvaOut);
				}
			}

			return (int)Microsoft.VisualStudio.OLE.Interop.OLECMDF.OLECMDF_INVISIBLE;
		}

		public int QueryStatus(ref Guid pguidCmdGroup, uint cCmds, OLECMD[] prgCmds, IntPtr pCmdText)
		{
			if (pguidCmdGroup == VSConstants.CMDSETID.StandardCommandSet97_guid && prgCmds[0].cmdID == (uint)VSConstants.VSStd97CmdID.GotoDefn)
			{
				string currentPredicate = GetCurrentPredicte();

				if (string.IsNullOrEmpty(currentPredicate))
					prgCmds[0].cmdf = (uint)(OLECMDF.OLECMDF_SUPPORTED | OLECMDF.OLECMDF_INVISIBLE);
				else
					prgCmds[0].cmdf = (uint)(OLECMDF.OLECMDF_ENABLED | OLECMDF.OLECMDF_SUPPORTED);

				//INdicate we handled the QueryStatus so the shell doesn't continue looking for handlers.
				return VSConstants.S_OK;
			}
			else if (m_nextTarget != null)
			{
				return m_nextTarget.QueryStatus(ref pguidCmdGroup, cCmds, prgCmds, pCmdText);
			}

			return (int)Microsoft.VisualStudio.OLE.Interop.OLECMDF.OLECMDF_INVISIBLE;
		}

		string GetCurrentPredicte()
		{
			string currentLine = m_textView.Caret.Position.BufferPosition.GetContainingLine().GetText();

			if (string.IsNullOrWhiteSpace(currentLine))
				return null;

			if (currentLine.StartsWith(":-"))
				return null;

			int lineStart = m_textView.Caret.Position.BufferPosition.GetContainingLine().Start.Position;
			int bufferPosition = m_textView.Caret.Position.BufferPosition.Position;
			int linePosition = bufferPosition - lineStart;

			char c = currentLine[0];
			int i = 1;
			string predicate = string.Empty;
			while (c != '(' && c != ',' && i <= currentLine.Length)
			{
				if (c == '%')
					return null;

				predicate += c;
				c = currentLine[i++];
			}

			if (i < linePosition)
				return null;
			else
				return predicate.Trim(); ;
		}
	}

}
