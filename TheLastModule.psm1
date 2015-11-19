# ...dot source the foo
$ScriptsDir = Join-Path -Path $PSScriptRoot -ChildPath Scripts
Get-ChildItem -Path $PSScriptRoot -Recurse | Unblock-File -Confirm: $false
Get-ChildItem -Path $ScriptsDir -Recurse -Filter *.ps1 | ForEach-Object {. $_.FullName}
