// themes
#let themes = (
	// putty terminal theme
	putty: (
		black: rgb(0, 0, 0),
		red: rgb(187, 0, 0),
		green: rgb(0, 187, 0),
		yellow: rgb(187, 187, 0),
		blue: rgb(0, 0, 187),
		magenta: rgb(187, 0, 187),
		cyan: rgb(0, 187, 187),
		white: rgb(187, 187, 187),
		gray: rgb(85, 85, 85),
		lightred: rgb(255, 0, 0),
		lightgreen: rgb(0, 255, 0),
		lightyellow: rgb(255, 255, 0),
		lightblue: rgb(0, 0, 255),
		lightmagenta: rgb(255, 0, 255),
		lightcyan: rgb(0, 255, 255),
		lightwhite: rgb(255, 255, 255),
		default_text: rgb(187, 187, 187),
		default_bg: rgb(0, 0, 0)
	)
)

// ansi rendering function
#let ansi_render(body, font: "consolas", theme: themes.putty) = {
	// dict with text style
	let match_text = (
		"1": (weight: "bold"),
		"3": (style: "italic"),
		"23": (style: "normal"),
		"30": (fill: theme.black),
		"31": (fill: theme.red),
		"32": (fill: theme.green),
		"33": (fill: theme.yellow),
		"34": (fill: theme.blue),
		"35": (fill: theme.magenta),
		"36": (fill: theme.cyan),
		"37": (fill: theme.white),
		"39": (fill: theme.default_text), // default text theme
		"90": (fill: theme.gray),
		"91": (fill: theme.lightred),
		"92": (fill: theme.lightgreen),
		"93": (fill: theme.lightyellow),
		"94": (fill: theme.lightblue),
		"95": (fill: theme.lightmagenta),
		"96": (fill: theme.lightcyan),
		"97": (fill: theme.lightwhite),
		"default": (weight: "regular", style: "normal", fill: theme.default_text)
	)
	// dict with background style
	let match_bg = (
		"40": (fill: theme.black),
		"41": (fill: theme.red),
		"42": (fill: theme.green),
		"43": (fill: theme.yellow),
		"44": (fill: theme.blue),
		"45": (fill: theme.magenta),
		"46": (fill: theme.cyan),
		"47": (fill: theme.white),
		"49": (fill: theme.default_bg), // default bg theme
		"100": (fill: theme.gray),
		"101": (fill: theme.lightred),
		"102": (fill: theme.lightgreen),
		"103": (fill: theme.lightyellow),
		"104": (fill: theme.lightblue),
		"105": (fill: theme.lightmagenta),
		"106": (fill: theme.lightcyan),
		"107": (fill: theme.lightwhite),
		"default": (fill: theme.default_bg)
	)

	let match_options(opt) = {
		let (opt_text, opt_bg) = ((:), (:))
		let ul = none
		let ol = none
		for i in opt {
			if i == "0" {
				opt_text += match_text.default
				opt_bg += match_bg.default
				ul = false
				ol = false
			} else if i in match_bg.keys() {
				opt_bg += match_bg.at(i)
			} else if i in match_text.keys() {
				opt_text += match_text.at(i)
			} else if i == "4" {
				ul = true
			} else if i == "24" {
				ul = false
			} else if i == "53" {
				ol = true
			} else if i == "55" {
				ol = false
			}
		}
		(text: opt_text, bg: opt_bg, ul: ul, ol: ol)
	}

	let parse_option(body) = {
		let arr = ()
		let cur = 0
		for map in body.matches(regex("\x1b\[([0-9;]*)m([^\x1b]*)")) {
			// loop through all matches
			let str = map.captures.at(1)
			// split the string by newline and preserve newline
			let split = str.split("\n")
			for (k, v) in split.enumerate() {
				if k != split.len()-1 {
					v = v + "\n"
				}
				let temp = (v, ())
				for option in map.captures.at(0).split(";") {
					temp.at(1).push(option)
				}
				arr.push(temp)
			}
			cur += 1
		}
		arr
	}

	set text(..(match_text.default), font: font, top-edge: "ascender", bottom-edge: "descender")
	set par(leading: 0em)

	let option = (
		text: match_text.default,
		bg: match_bg.default,
		ul: false,
		ol: false
	)
	rect(..(match_bg.default),
		for (str, opt) in parse_option(body) {
			// TODO: support option 7,27 (reverse, no reverse)
			// TODO: support option 38,48 (foreground, background color)
			let m = match_options(opt)
			option.text += m.text
			option.bg += m.bg
			if m.ul != none { option.ul = m.ul }
			if m.ol != none { option.ol = m.ol }

			// hack for trailing whitespace
			str = str.replace(regex("([ \t]+)$"), m => m.captures.at(0) + "\u{200b}")
			box(..option.bg,
				text(..option.text,
					if option.ul {
						if option.ol {
							overline(underline[#str])
						} else {
							underline[#str]
						}
					} else {
						if option.ol {
							overline[#str]
						} else {
							[#str]
						}
					}
				)
			)
			// fill trailing newlines
			let s =	str.find(regex("\n+$"))
			if s != none {
				for i in s {
					linebreak()
				}
			}

		}
	)
}

#ansi_render(
"\u{001b}[1;31m----------------------------------------------------------------------\u{001b}[0m
\u{001b}[1;31mNameError\u{001b}[0m                            Traceback (most recent call last)
Cell \u{001b}[1;32mIn[9], line 1\u{001b}[0m
\u{001b}[1;32m----> 1\u{001b}[0m this_will_error

\u{001b}[1;31mNameError\u{001b}[0m: name 'this_will_error' is not defined"
)

#ansi_render(read("test.txt"))

#ansi_render(
"\u{1b}[53;4;36mOver and \u{1b}[35mUnder!"
)

#overline("Overline \u{200b}")