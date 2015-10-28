Function Install-Chocolatey {

    <#
    .SYNOPSIS
        Everybody likes Chocolatey.

    .DESCRIPTION
        Can´t remember the command every single time.

    .EXAMPLE
        Install-Chocolatey

        Just install Chocolatey like a Boss.

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
    #>

    begin {
        Set-StrictMode -Version Latest

        # do we have admin privileges???
        $CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
        $IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        if (!($IsAdmin)) {
            Write-Error "...sorry, you have to install Chocolatey as an Administrator" -ErrorAction Stop
            # ...dead
        }
    } # END begin

     process {
        Invoke-Expression ((New-Object -TypeName Net.Webclient).DownloadString('https://chocolatey.org/install.ps1'))
    } # END process
}

