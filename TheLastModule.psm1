# ...are we lost???
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$AdminTools = Join-Path -Path $ScriptDir -ChildPath AdminTools
# ...do you already have a $PROFILE???

if (!(Test-Path $PROFILE)) {
	New-Item -Path $PROFILE -ItemType File -Force -ErrorAction Continue
}

# ...may I add some magic to your $PROFILE????
Write-Output "Do you want to add prefered optimizations to your Powershell Profile?"
$PimpProfile = Read-Host "[Y/n]: "

if ($PimpProfile -like "Y") {
	$PimpSource = Join-Path -Path $ScriptDir -ChildPath ProfileOptimization
	Get-Content -Path "$PimpSource\Microsoft.PowerShell_profile.txt" | Add-Content -Path $PROFILE
	}

# ...dot source the foo
Get-ChildItem -Path $ScriptDir -Recurse| Unblock-File 
Get-ChildItem -Path $AdminTools | foreach-Object {. $_.FullName}

# ...all good
Write-Output "All good. Use 'Get-Command -Module TheLastModule' for more informations."
