 function Install-DesktopEssentials {
 
 begin {
        Set-StrictMode -Version Latest

        # do we have admin privileges???
        $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
        $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        if (!($isAdmin)) {
            Write-Error "...sorry, you don´t have enough rights to run the script" -ErrorAction Stop
            # ...dead
        }

        # ...we will use Chocolatey to install the tools
        if (!($env:ChocolateyInstall)) {
            Write-Error "...please use Install-Chocolatey first!" -ErrorAction Stop
            # ...dead
        }
    }

     process {
        choco install chocolatey -pre -force -Y
        choco install 7zip ccleaner filezilla putty.install winscp googlechrome googleearth chocolateygui jre8 jdk8 sublimetext3 brackets sysinternals directx steam -pre -force -Y
     }
}