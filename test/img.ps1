# extract image from README code block and export to img folder
Push-Location
Set-Location $PSScriptRoot

$template =
'#import "lib.typ": *
#set page(width: auto, height: auto, margin: 3pt)
'
$m = (Get-Content ../README.md -Raw | Select-String -Pattern '```typst([\s\S]*?)```' -AllMatches).Matches.Captures
for ($i = 1; $i -lt $m.Count; $i++) {
	$content = $m[$i].Groups[1].Value
	$template + $content | typst c - "../img/$i.png" --root ../ --ppi 300
}

Pop-Location