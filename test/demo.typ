#import "../ansi-render.typ": ansi-render as __ansi-render, terminal-themes

// workaround before set is implemented
#let ansi-render = __ansi-render.with(inset: 5pt, radius: 3pt, theme: terminal-themes.vscode)

= Render text directly
#ansi-render(
"\u{1b}[38;2;255;0;0mThis text is red.\u{1b}[0m
\u{1b}[48;2;0;255;0mThis background is green.\u{1b}[0m
\u{1b}[38;2;255;255;255m\u{1b}[48;2;0;0;255mThis text is white on a blue background.\u{1b}[0m
\u{1b}[1mThis text is bold.\u{1b}[0m
\u{1b}[4mThis text is underlined.\u{1b}[0m
\u{1b}[38;2;255;165;0m\u{1b}[48;2;255;255;0mThis text is orange on a yellow background.\u{1b}[0m"
)

#ansi-render(
"\u{1b}[38;5;196mRed text\u{1b}[0m
\u{1b}[48;5;27mBlue background\u{1b}[0m
\u{1b}[38;5;226;48;5;18mYellow text on blue background\u{1b}[0m
\u{1b}[7mInverted text\u{1b}[0m
\u{1b}[38;5;208;48;5;237mOrange text on gray background\u{1b}[0m
\u{1b}[38;5;39;48;5;208mBlue text on orange background\u{1b}[0m
\u{1b}[38;5;255;48;5;0mWhite text on black background\u{1b}[0m"
)

#ansi-render(
"\u{1b}[31;1mHello \u{1b}[7mWorld\u{1b}[0m

\u{1b}[53;4;36mOver  and \u{1b}[35m Under!
\u{1b}[7;90mreverse\u{1b}[101m and \u{1b}[94;27mreverse"
)

= Render text from a file
#ansi-render(read("test.txt"), theme: terminal-themes.vscode-light, font: none)

= Uses the font supports ligatures
#ansi-render(read("test.txt"), font: "Cascadia Code", theme: terminal-themes.putty)

= Render bold text with bright colors
#let bold-bright-test = (
"\u{1b}[30mNormal\t \u{1b}[90mBright\t \u{1b}[1;30mBold\u{1b}[0m
\u{1b}[31mNormal\t \u{1b}[91mBright\t \u{1b}[1;31mBold\u{1b}[0m
\u{1b}[32mNormal\t \u{1b}[92mBright\t \u{1b}[1;32mBold\u{1b}[0m
\u{1b}[33mNormal\t \u{1b}[93mBright\t \u{1b}[1;33mBold\u{1b}[0m
\u{1b}[34mNormal\t \u{1b}[94mBright\t \u{1b}[1;34mBold\u{1b}[0m
\u{1b}[35mNormal\t \u{1b}[95mBright\t \u{1b}[1;35mBold\u{1b}[0m
\u{1b}[36mNormal\t \u{1b}[96mBright\t \u{1b}[1;36mBold\u{1b}[0m
\u{1b}[37mNormal\t \u{1b}[97mBright\t \u{1b}[1;37mBold\u{1b}[0m"
)

#grid(
  columns: 2,
  gutter: 10pt,
  ansi-render(bold-bright-test, theme: terminal-themes.vintage),
  ansi-render(bold-bright-test, theme: terminal-themes.vintage, bold-is-bright: true),
)
