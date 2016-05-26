Function Install-ServerEssentials {

	begin {
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
	} # END begin
	
	process {
		$Apps4Server = "7zip.Install",
			"Chocolatey",
			"Chocolateygui",
			"directx",
			"DotNet3.5",
			"DotNet4.5",
			"google-chrome-x64",
			"NugetPackageExplorer",
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
			"webpi",
			"winscp",
			"XmlNotepad"
		
		Start-Process powershell.exe -ArgumentList "-command choco install $Apps4Server -pre -Y"
	} # END process
}

