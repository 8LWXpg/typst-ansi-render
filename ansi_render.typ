// ansi rendering function
#let ansi_render(body, font: "consolas") = {
	// putty terminal color
	let color = (
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
	)
	// dict with text style
	let match_text = (
		"1": (weight: "bold"),
		"3": (style: "italic"),
		"23": (style: "normal"),
		"30": (fill: color.at("black")),
		"31": (fill: color.at("red")),
		"32": (fill: color.at("green")),
		"33": (fill: color.at("yellow")),
		"34": (fill: color.at("blue")),
		"35": (fill: color.at("magenta")),
		"36": (fill: color.at("cyan")),
		"37": (fill: color.at("white")),
		"39": (fill: color.at("white")), // default text color
		"90": (fill: color.at("gray")),
		"91": (fill: color.at("lightred")),
		"92": (fill: color.at("lightgreen")),
		"93": (fill: color.at("lightyellow")),
		"94": (fill: color.at("lightblue")),
		"95": (fill: color.at("lightmagenta")),
		"96": (fill: color.at("lightcyan")),
		"97": (fill: color.at("lightwhite")),
		"default": (weight: "regular", style: "normal", fill: color.at("white"))
	)
	// dict with background style
	let match_bg = (
		"40": (fill: color.at("black")),
		"41": (fill: color.at("red")),
		"42": (fill: color.at("green")),
		"43": (fill: color.at("yellow")),
		"44": (fill: color.at("blue")),
		"45": (fill: color.at("magenta")),
		"46": (fill: color.at("cyan")),
		"47": (fill: color.at("white")),
		"49": (fill: color.at("black")), // default bg color
		"100": (fill: color.at("gray")),
		"101": (fill: color.at("lightred")),
		"102": (fill: color.at("lightgreen")),
		"103": (fill: color.at("lightyellow")),
		"104": (fill: color.at("lightblue")),
		"105": (fill: color.at("lightmagenta")),
		"106": (fill: color.at("lightcyan")),
		"107": (fill: color.at("lightwhite")),
		"default": (fill: color.at("black"))
	)

	let match_options(opt) = {
		let (opt_text, opt_bg) = ((:), (:))
		let ul = false
		for i in opt {
			if i == "0" {
				opt_text += match_text.default
				opt_bg += match_bg.default
			} else if i in match_bg.keys() {
				opt_bg += match_bg.at(i)
			} else if i in match_text.keys() {
				opt_text += match_text.at(i)
			} else if i == "4" {
				ul = true
			} else if i == "24" {
				ul = false
			}
		}
		(opt_text, opt_bg, ul)
	}

	let parse_option(body) = {
		let arr = ()
		let cur = 0
		for map in body.matches(regex("\x1b\[([0-9;]*)m([^\x1b]*)")) {
			// loop through all matches
			let str = map.captures.at(1)
			// split the string by newline
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

	let option = (match_text.default, match_bg.default, false)
	rect(..(match_bg.default),
		for (str, opt) in parse_option(body) {
			let m = match_options(opt)
			option.at(0) += m.at(0)
			option.at(1) += m.at(1)
			option.at(2) = m.at(2)

			box(..option.at(1),
				text(..option.at(0),
					if option.at(2) {
						underline[#str]
					} else {
						[#str]
					}
				)
			)
			// fill trailing spaces
			let s = str.find(regex("[ \t]+$"))
			if s != none {
				h(1em * s.len())
			}
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