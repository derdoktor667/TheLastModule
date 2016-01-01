# ...dot source the foo
Get-ChildItem -Path $PSScriptRoot\Scripts | Unblock-File -Verbose
Get-ChildItem -Path $PSScriptRoot\Scripts\*.ps1 | Foreach-Object { . $_.FullName} -Verbose
