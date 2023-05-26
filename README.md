# ANSI Escape Sequence Renderer

This script provides a simple way to render text with ANSI escape sequences in a terminal. It uses the `ansi_render` function from the `ansi_render.typ` module to render text with various formatting options, including foreground and background colors, bold and underlined text, and inverted text.

## Usage

```typst
#import "ansi_render.typ"

ansi_render.render(body, font: font, theme: ansi_render.themes)
```

## Demo

see [demo.pdf](https://github.com/8LWXpg/typst-ansi_render/blob/master/demo.pdf)
