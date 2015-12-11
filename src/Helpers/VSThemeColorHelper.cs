using Microsoft.VisualStudio.PlatformUI;
using System.Drawing;

namespace sebagomez.VSProlog.Helpers
{
	internal class VSThemeColorHelper
	{
		public enum Theme
		{
			Dark,
			Light,
			Blue,
			UNKNOWN
		}

		public const string RED = "#D85050";
		public const string GREEN = "#57A64A";
		public const string BLUE = "#007ACC";

		static VSThemeColorHelper()
		{
			CalculateTheme();
			//VSColorTheme.ThemeChanged += VSColorTheme_ThemeChanged;
		}

		static void VSColorTheme_ThemeChanged(ThemeChangedEventArgs e)
		{
			CalculateTheme();
		}

		static void CalculateTheme()
		{
			Color backgroundColor = VSColorTheme.GetThemedColor(EnvironmentColors.ToolWindowBackgroundColorKey);
			switch (backgroundColor.Name)
			{
				case "ff252526":
					s_theme = Theme.Dark;
					break;
				case "ffffffff":
					s_theme = Theme.Blue;
					break;
				case "fff5f5f5":
					s_theme = Theme.Light;
					break;
				default:
					s_theme = Theme.UNKNOWN;
					break;
			}
		}

		static Theme s_theme;
		public static Theme CurrentTheme
		{
			get { return s_theme; }
		}
	}
}

