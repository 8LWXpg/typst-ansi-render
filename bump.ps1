param(
	[string]$version
)

# validate version
if ($version -match '^\d+\.\d+\.\d+$') {
	Write-Host -ForegroundColor Blue "Bumping to version $version"
} else {
	Write-Host -ForegroundColor Red "Invalid version $version"
	exit 1
}

$content = cat ./README.md | %{$_ -replace '"@preview/ansi-render:(\d+\.\d+\.\d+)"', "`"@preview/ansi-render:$version`""}
Set-Content ./README.md $content
$content = cat ./typst.toml | %{$_ -replace 'version = "(\d+\.\d+\.\d+)"', "version = `"$version`""}
Set-Content ./typst.toml $content

Write-Host -ForegroundColor Red "Don't forget to write a changelog!"