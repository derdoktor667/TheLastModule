function Install-DesktopEssentials {

	Set-StrictMode -Version Latest
	
    # do we have admin privileges???
    $CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
    $IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (!($IsAdmin)) {
        Write-Error "...sorry, you don´t have enough rights to run the script" -ErrorAction Stop
        # ...dead
    }

    # ...we will use Chocolatey to install the tools
    if (!($env:ChocolateyInstall)) {
        Write-Error "...please use Install-Chocolatey first!" -ErrorAction Stop
        # ...dead
    }

	$Apps4Desktop = "7zip",
			"adobereader",
			"Chocolatey",
            "Chocolateygui",
            "directx",
            "DotNet3.5",         
            "DotNet4.5",
            "DotNet4.6",
            "DotNet4.6.1",
            "filezilla",
            "google-chrome-x64",
			"jre8",
            "nodejs",
            "NugetPackageExplorer",
            "paint.net",
            "powershell",
            "PSWindowsUpdate",
            "putty",
            "Silverlight",
            "SublimeText3",
            "sysinternals",
            "vcredist2005",
            "vcredist2008",
            "vcredist2010",
            "vcredist2012",
            "vcredist2013",
            "vcredist2015",
            "visualstudiocode",
            "vlc",
            "webpi",
            "winscp",
            "XmlNotepad"
		        
	Start-Process powershell.exe -ArgumentList "-command choco install $Apps4Desktop -pre -Y"
}
