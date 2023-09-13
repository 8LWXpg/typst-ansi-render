#import "ansi-render.typ": *

= Render text directly
#ansi-render(
"\u{1b}[38;2;255;0;0mThis text is red.\u{1b}[0m
\u{1b}[48;2;0;255;0mThis background is green.\u{1b}[0m
\u{1b}[38;2;255;255;255m\u{1b}[48;2;0;0;255mThis text is white on a blue background.\u{1b}[0m
\u{1b}[1mThis text is bold.\u{1b}[0m
\u{1b}[4mThis text is underlined.\u{1b}[0m
\u{1b}[38;2;255;165;0m\u{1b}[48;2;255;255;0mThis text is orange on a yellow background.\u{1b}[0m
",
inset: 5pt,
radius: 3pt,
theme: terminal-themes.vscode
)

#ansi-render(
"\u{1b}[38;5;196mRed text\u{1b}[0m
\u{1b}[48;5;27mBlue background\u{1b}[0m
\u{1b}[38;5;226;48;5;18mYellow text on blue background\u{1b}[0m
\u{1b}[7mInverted text\u{1b}[0m
\u{1b}[38;5;208;48;5;237mOrange text on gray background\u{1b}[0m
\u{1b}[38;5;39;48;5;208mBlue text on orange background\u{1b}[0m
\u{1b}[38;5;255;48;5;0mWhite text on black background\u{1b}[0m",
inset: 5pt,
radius: 3pt,
theme: terminal-themes.vscode
)

#ansi-render(
"\u{1b}[31;1mHello \u{1b}[7mWorld\u{1b}[0m

\u{1b}[53;4;36mOver  and \u{1b}[35m Under!
\u{1b}[7;90mreverse\u{1b}[101m and \u{1b}[94;27mreverse",
inset: 5pt,
radius: 3pt,
theme: terminal-themes.vscode
)

= Render text from a file
#ansi-render(read("test.txt"), inset: 5pt, radius: 3pt)

= Uses the font supports ligatures
#ansi-render(read("test.txt"), font: "CaskaydiaCove Nerd Font Mono", inset: 5pt, radius: 3pt, theme: terminal-themes.putty)

= List of built-in themes
== VSCode
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.vscode)
== VSCode Light
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.vscode-light)
== Putty
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.putty)
== Campbell
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.campbell)
== Campbell Powershell
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.campbell-powershell)
== Vintage
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.vintage)
== One Half Dark
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.one-half-dark)
== One Half Light
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.one-half-light)
== Solarized Dark
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.solarized-dark)
== Solarized Light
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.solarized-light)
== Tango Dark
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.tango-dark)
== Tango Light
#ansi-render(read("color.txt"), size: 8pt, inset: 5pt, radius: 3pt, theme: terminal-themes.tango-light)