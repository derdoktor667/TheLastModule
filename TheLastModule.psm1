# ...dot source the foo
Get-ChildItem -Path $PSScriptRoot | Unblock-File
Get-ChildItem -Path $PSScriptRoot\Scripts\*.ps1 | Foreach-Object { . $_.FullName}
