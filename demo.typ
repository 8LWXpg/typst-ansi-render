#import "ansi_render.typ"

#ansi_render.ansi_render(
"\u{1b}[38;2;255;0;0mThis text is red.\u{1b}[0m
\u{1b}[48;2;0;255;0mThis background is green.\u{1b}[0m
\u{1b}[38;2;255;255;255m\u{1b}[48;2;0;0;255mThis text is white on a blue background.\u{1b}[0m
\u{1b}[1mThis text is bold.\u{1b}[0m
\u{1b}[4mThis text is underlined.\u{1b}[0m
\u{1b}[38;2;255;165;0m\u{1b}[48;2;255;255;0mThis text is orange on a yellow background.\u{1b}[0m
"
)

#ansi_render.ansi_render(
"\u{1b}[38;5;196mRed text\u{1b}[0m
\u{1b}[48;5;27mBlue background\u{1b}[0m
\u{1b}[38;5;226;48;5;18mYellow text on blue background\u{1b}[0m
\u{1b}[7mInverted text\u{1b}[0m
\u{1b}[38;5;208;48;5;237mOrange text on gray background\u{1b}[0m
\u{1b}[38;5;39;48;5;208mBlue text on orange background\u{1b}[0m
\u{1b}[38;5;255;48;5;0mWhite text on black background\u{1b}[0m"
)

#ansi_render.ansi_render(
"\u{1b}[31;1mHello \u{1b}[7mWorld\u{1b}[0m

\u{1b}[53;4;36mOver  and \u{1b}[35m Under!
\u{1b}[7;90mreverse\u{1b}[101m and \u{1b}[94;27mreverse"
)

// uses the font supports ligatures
#ansi_render.ansi_render(read("test.txt"), font: "CaskaydiaCove Nerd Font Mono", theme: ansi_render.themes.putty)