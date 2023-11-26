param(
	[string]$version
)

$content = cat ./README.md | %{$_ -replace '"@preview/ansi-render:(\d+\.\d+\.\d+)"', "`"@preview/ansi-render:$version`""}
Set-Content ./README.md $content
$content = cat ./typst.toml | %{$_ -replace 'version = "(\d+\.\d+\.\d+)"', "version = `"$version`""}
Set-Content ./typst.toml $content

Write-Host -ForegroundColor Red "Don't forget to write a changelog!"