# ...dot source the foo
Get-ChildItem -Path $PSScriptRoot -Recurse | Unblock-File 
Get-ChildItem -Path $PSScriptRoot -Recurse -Filter *.ps1 | ForEach-Object {. $_.FullName}
