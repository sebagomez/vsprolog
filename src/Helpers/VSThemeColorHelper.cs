using Microsoft.VisualStudio.PlatformUI;
using System.Collections.Generic;
using System.Windows.Media;

namespace sebagomez.VSProlog.Helpers
{
	internal class VSThemeColorHelper
	{
		public enum Theme
		{
			Dark,
			Light,
			Blue,
			ANY
		}

		static VSThemeColorHelper()
		{
			CalculateTheme();
			VSColorTheme.ThemeChanged += VSColorTheme_ThemeChanged;
		}

		static void VSColorTheme_ThemeChanged(ThemeChangedEventArgs e)
		{
			CalculateTheme();
		}

		static void CalculateTheme()
		{
			System.Drawing.Color backgroundColor = VSColorTheme.GetThemedColor(EnvironmentColors.ToolWindowBackgroundColorKey);
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
					s_theme = Theme.ANY;
					break;
			}
		}

		static Theme s_theme;
		public static Theme CurrentTheme
		{
			get { return s_theme; }
		}

		#region Colors
		//https://docs.microsoft.com/en-us/visualstudio/extensibility/ux-guidelines/color-value-reference-for-visual-studio?view=vs-2019
		//https://docs.microsoft.com/en-us/dotnet/api/system.windows.media.colors?view=netframework-4.8
		static Dictionary<string, Dictionary<Theme, Color>> s_colors = new Dictionary<string, Dictionary<Theme, Color>>
		{
			{ PrologTokens.PrologTokenHelper.PrologText, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.Salmon },
					{ Theme.ANY, Colors.DarkRed },
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologHead, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.NavajoWhite },
					{ Theme.ANY, Colors.DarkViolet }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologError, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.Red },
					{ Theme.ANY, Colors.DarkRed }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologComment, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.SeaGreen },
					{ Theme.ANY, Colors.DarkGreen }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologKeyline, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.Plum },
					{ Theme.ANY, Colors.Purple }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologKeyword, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.Orange },
					{ Theme.ANY, Colors.DarkOrange }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologPublictoken, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.LightSeaGreen },
					{ Theme.ANY, Colors.RoyalBlue }
				}
			},
			{ PrologTokens.PrologTokenHelper.PrologNumber, new Dictionary<Theme, Color>
				{
					{ Theme.Dark, Colors.Khaki },
					{ Theme.ANY, Colors.OrangeRed }
				}
			}

		};

		public static System.Windows.Media.Color GetTokenColor(string token)
		{
			if (s_colors[token].ContainsKey(CurrentTheme))
				return s_colors[token][CurrentTheme];

			return s_colors[token][Theme.ANY];
		}

		#endregion

	}
}

