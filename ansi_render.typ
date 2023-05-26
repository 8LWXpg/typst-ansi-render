// add your theme here!
#let themes = (
	// vscode terminal theme
	vscode: (
		black: rgb(0, 0, 0),
		red: rgb(205, 49, 49),
		green: rgb(13, 188, 121),
		yellow: rgb(229, 229, 16),
		blue: rgb(36, 114, 200),
		magenta: rgb(188, 63, 188),
		cyan: rgb(17, 168, 205),
		white: rgb(229, 229, 229),
		gray: rgb(102, 102, 102),
		lightred: rgb(214, 76, 76),
		lightgreen: rgb(35, 209, 139),
		lightyellow: rgb(245, 245, 67),
		lightblue: rgb(59, 142, 234),
		lightmagenta: rgb(214, 112, 214),
		lightcyan: rgb(41, 184, 219),
		lightwhite: rgb(229, 229, 229),
		default_text: rgb(229, 229, 229), // white
		default_bg: rgb(0, 0, 0), // black
	),

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
		default_text: rgb(187, 187, 187), // white
		default_bg: rgb(0, 0, 0), // black
	),
)

// ansi rendering function
#let ansi_render(body, font: "consolas", size: 11pt, theme: themes.vscode) = {
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
		"39": (fill: theme.default_text),
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
		"49": (fill: theme.default_bg),
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
		// parse 38;5 48;5
		let parse_8bit_color(num) = {
			num = int(num)
			let colors = (0, 95, 135, 175, 215, 255)
			if num <= 7 { match_text.at(str(num+30)) }
			else if num <= 15 { match_bg.at(str(num+32)) }
			else if num <= 231 {
				num -= 16
				let (r, g, b) = (colors.at(int(num/36)), colors.at(calc.rem(int(num/6),6)), colors.at(calc.rem(num,6)))
				(fill: rgb(r, g, b))
			} else {
				num -= 232
				let (r, g, b) = (8+10*num, 8+10*num, 8+10*num)
				(fill: rgb(r, g, b))
			}
		}

		let (opt_text, opt_bg) = ((:), (:))
		let (ul, ol, reverse, last) = (none, none, none, none)
		let count = 0
		let color = (0, 0, 0)

		// match options
		for i in opt {
			if last == "382" or last =="482" {
				color.at(count) = int(i)
				count += 1
				if count == 3 {
					if last == "382" { opt_text += (fill: rgb(..color)) }
					else { opt_bg += (fill: rgb(..color)) }
					count = 0
					last = none
				}
				continue
			}
			else if last == "385" {
				opt_text += parse_8bit_color(i)
				last = none
				continue
			}
			else if last == "485" {
				opt_bg += parse_8bit_color(i)
				last = none
				continue
			}
			else if i == "0" {
				opt_text += match_text.default
				opt_bg += match_bg.default
				ul = false
				ol = false
				reverse = false
			}
			else if i in match_bg.keys() { opt_bg += match_bg.at(i) }
			else if i in match_text.keys() { opt_text += match_text.at(i) }
			else if i == "4" { ul = true }
			else if i == "24" { ul = false }
			else if i == "53" { ol = true }
			else if i == "55" { ol = false }
			else if i == "7" { reverse = true }
			else if i == "27" { reverse = false }
			else if i == "38" or i == "48" {
				last = i
				continue
			}
			else if i == "2" or i == "5" {
				if last == "38" or last == "48" {
					last += i
					count = 0
					continue
				}
			}
			last = none
		}
		(text: opt_text, bg: opt_bg, ul: ul, ol: ol, reverse: reverse)
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

	set text(..(match_text.default), font: font, size: size, top-edge: "ascender", bottom-edge: "descender")
	set par(leading: 0em)

	let option = (
		text: match_text.default,
		bg: match_bg.default,
		ul: false,
		ol: false,
		reverse: false
	)
	rect(..(match_bg.default),
		for (str, opt) in parse_option(body) {
			let m = match_options(opt)
			option.text += m.text
			option.bg += m.bg
			if m.reverse != none { option.reverse = m.reverse }
			if option.reverse {
				(option.text.fill, option.bg.fill) = (option.bg.fill, option.text.fill)
			}
			if m.ul != none { option.ul = m.ul }
			if m.ol != none { option.ol = m.ol }

			// hack for under/overline trailing whitespace
			str = str.replace(regex("([ \t]+)$"), m => m.captures.at(0) + "\u{200b}")
			box(..option.bg,
				text(..option.text,
					if option.ul {
						if option.ol {
							let s = str.find(regex("([ \t]+)$"))
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
