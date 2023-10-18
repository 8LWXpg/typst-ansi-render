# extract image from README code block and export to img folder
Push-Location
Set-Location $PSScriptRoot

$template =
'#import "../ansi-render.typ": *
#set page(width: auto, height: auto, margin: 3pt)
'
$m = (Get-Content ../README.md -Raw | Select-String -Pattern '```typst([\s\S]*?)```' -AllMatches).Matches.Captures
for ($i = 1; $i -le $m.Count - 1; $i++) {
	$content = $m[$i].Groups[1].Value
	$file = "$i.typ"
	$template + $content > "$i.typ"
	typst c $file "../img/$i.svg" --root ../ --ppi 216 && Remove-Item $file
}

Pop-Location