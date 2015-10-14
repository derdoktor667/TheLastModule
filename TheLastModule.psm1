# ...are we lost???
$ScriptDir = Convert-Path .
$AdminTools = Join-Path -Path $ScriptDir -ChildPath Scripts

# ...do you already have a $PROFILE???
if (!(Test-Path $PROFILE)) {
	New-Item -Path $PROFILE -ItemType File
}

# ...dot source the foo
Get-ChildItem -Path $ScriptDir -Recurse | Unblock-File 
Get-ChildItem -Path $AdminTools -Recurse -Filter *.ps1 | foreach-Object {. $_.FullName}
