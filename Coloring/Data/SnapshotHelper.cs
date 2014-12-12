using Microsoft.VisualStudio.Text;

namespace sebagomez.VSProlog.Coloring.Data
{
	internal class SnapshotHelper
	{
		public SnapshotSpan Snapshot { get; private set; }
		public PrologTokenTypes TokenType { get; private set; }

		public SnapshotHelper(SnapshotSpan span, PrologTokenTypes type)
		{
			Snapshot = span;
			TokenType = type;
		}
	}
}
