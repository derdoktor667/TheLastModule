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
		$Apps4Desktop = "7zip.Install",
			"adobereader",
			"Brackets",
            "ccleaner",
            "Chocolatey",
            "Chocolateygui",
            "directx",
            "DotNet3.5",         
            "DotNet4.5",
            "filezilla",
            "google-chrome-x64",
			"googleearth",
			"jdk8",
			"jre8",
            "nodejs.install",
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
            "vlc",
            "webpi",
            "winscp",
            "XmlNotepad"
		        
	Start-Process powershell.exe -ArgumentList "-command choco install $Apps4Desktop -pre -Y"
	}
}
