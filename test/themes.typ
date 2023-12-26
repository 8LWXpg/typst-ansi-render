#import "../ansi-render.typ": *
#set document(date: none)
#set page(width: auto, height: auto)

#let preview = ansi-render.with(read("color.txt"), inset: 5pt, radius: 3pt)

= List of built-in themes
== VSCode
#preview(theme: terminal-themes.vscode)
== VSCode Light
#preview(theme: terminal-themes.vscode-light)
== Putty
#preview(theme: terminal-themes.putty)
== Campbell
#preview(theme: terminal-themes.campbell)
== Campbell Powershell
#preview(theme: terminal-themes.campbell-powershell)
== Vintage
#preview(theme: terminal-themes.vintage)
== One Half Dark
#preview(theme: terminal-themes.one-half-dark)
== One Half Light
#preview(theme: terminal-themes.one-half-light)
== Solarized Dark
#preview(theme: terminal-themes.solarized-dark)
== Solarized Light
#preview(theme: terminal-themes.solarized-light)
== Tango Dark
#preview(theme: terminal-themes.tango-dark)
== Tango Light
#preview(theme: terminal-themes.tango-light)
== Gruvbox Dark
#preview(theme: terminal-themes.gruvbox-dark)
== Gruvbox Light
#preview(theme: terminal-themes.gruvbox-light)
