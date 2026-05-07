param(
	[string]$version
)

# validate version
if ($version -match '^\d+\.\d+\.\d+$') {
	Write-Host -ForegroundColor Blue "Bumping to version $version"
}
else {
	Write-Host -ForegroundColor Red "Invalid version $version"
	exit 1
}

$lastTag = (git describe --tags --abbrev=0).Substring(1)

(Get-Content ./README.md) -replace [regex]::Escape($lastTag), $version | Set-Content ./README.md
(Get-Content ./typst.toml) -replace [regex]::Escape($lastTag), $version | Set-Content ./typst.toml

Write-Host -ForegroundColor Red "Don't forget to write a changelog!"