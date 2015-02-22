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

     process {
        iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
     }
}
