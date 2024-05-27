#import "../ansi-render.typ": ansi-render as __ansi-render, terminal-themes
#set document(date: none)

// workaround before set is implemented
#let ansi-render = __ansi-render.with(inset: 5pt, radius: 3pt, theme: terminal-themes.vscode)

// newline with background color
#ansi-render("\u{1b}[101mHello


World")

// Render empty newlines
#grid(
  columns: (auto, auto),
  column-gutter: 1pt,
  ansi-render("\n\n\n\n\n"),
  ansi-render("1\n2\n3\n4\n5\n6"),
)