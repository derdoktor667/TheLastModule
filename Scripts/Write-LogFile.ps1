<#
    .SYNOPSIS
        Creates a simple Logfile.

    .DESCRIPTION
        Add some simple logging for the module.

    .PARAMETER LogLevel
        Colors makes us happy.

	.PARAMETER LogMessage
		The "Message".

	.PARAMETER LogFile
		Where to put the LogFile?

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
#>

function Write-Log {

    param
    (
		[int]$LogLevel,
		[string]$LogMessage,
		[string]$LogFile = "$env:TEMP\TheLastModuleLogFile.txt"
        )
    
   	Set-StrictMode -Version Latest

	Switch ($LogLevel){
		0 {$Color = "Green"}
		1 {$Color = "Yellow"}        
		2 {$Color = "Red"}
	}

	# do we have a Log already?
	if (!(Test-Path $LogFile)) {
		New-Item -Path $LogFile -Force -Verbose
	}

    $LogMessage = $((Get-Date -Format g)) + " - " + $LogMessage
    Write-Host $LogMessage -ForegroundColor $Color
    Add-Content -LiteralPath $LogFile -Value $LogMessage   

}
