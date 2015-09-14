
Get-ChildItem -Path -Recurse $PSScriptRoot | Unblock-File 
Get-ChildItem -Path -Recurse $PSScriptRoot\*.ps1 | foreach-Object {. $_.FullName}  
