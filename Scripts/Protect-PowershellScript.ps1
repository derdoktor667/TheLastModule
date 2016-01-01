<#
    .SYNOPSIS
        Sign your Powershell Scripts easily.

    .DESCRIPTION
        One Command to sign them all.

    .PARAMETER ScriptPath
        Specifies the script to sign.

    .EXAMPLE
        Protect-PowershellScript -ScriptPath c:\temp\example.ps1

        Sign the "example.ps1" script

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/

#>

function Protect-PowershellScript {
    
    [cmdletbinding()]

    param(
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True,Mandatory=$True)][string]$ScriptPath
	)

    Set-StrictMode -Version Latest

    $SignCert = Get-ChildItem -Path cert:\ -Recurse –Codesign
    $TimeStampURL = "http://timestamp.verisign.com/scripts/timstamp.dll"

    # check for the Certificate
    if ($SignCert -eq $null) {
        Write-Error "Could not find a suitable Certificate. Exit" -ErrorAction Stop
        # ...dead
    }
        
    # is there an Powershell Script?
    if (!(Test-Path $ScriptPath -Filter "*.ps1")) {
        Write-Error "Could not find Powershell Script to sign. Exit" -ErrorAction Stop
        # ...dead        
    }

    Set-AuthenticodeSignature -FilePath $ScriptPath -Certificate $SignCert -IncludeChain all -TimestampServer $TimeStampURL

}
