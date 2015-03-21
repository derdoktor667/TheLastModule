Function Protect-PowershellScript {

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

    [cmdletbinding()]

    param(
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)][string]$ScriptPath = $(throw "-ScriptPath not given. Exit.")
        )

    begin {
        Set-StrictMode -Version Latest
        $signcert = $(Get-ChildItem cert:\ -Recurse –Codesign)
        $timeStampURL = "http://timestamp.verisign.com/scripts/timstamp.dll"

        # check for the Certificate
        if ($signcert -eq $null) {
            $(throw "Could not find a suitable Certificate. Exit")
            }
    }

    process {
        Set-AuthenticodeSignature -FilePath $ScriptPath -Certificate $signcert -IncludeChain all -TimestampServer $timeStampURL
    }
}
