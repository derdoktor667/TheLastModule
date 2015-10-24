function Get-BingDailyImage {
	
	<#
	.SYNOPSIS
		Downloads todays Bing Wallpaper.

	.DESCRIPTION
	    This script can be used to download the daily Bing Wallpaper
    	to use it as a Windows Desktop wallpaper or something. 

	.PARAMETER Path
    	The Path for the downloaded Bing Wallpaper     

	.PARAMETER Resolution
    	Select a custom resolution for the downloaded Bing Wallpaper
    	By default the script will use 1920x1080 (FullHD) for
    	the downloaded Bing Wallpaper. Has to be set as:
        	1024x768
        	1366x768
    	or something.

	.EXAMPLE
		.\Get-BingDailyImage -Path C:\temp\BingImages

		Description
    	-----------
    	Get today's Bing Wallpaper and downloads it to C:\temp\BingImages\BINGFILENAME.jpg

	.NOTES
    	Author: Wastl Kraus
    	Email : derdoktor667@gmail.com

	.LINK
    	http://wir-sind-die-matrix.de/

	#>

# START FRESH

	[CmdletBinding()]

	Param (
		[String]$Path = $HOME,
		[String]$Resolution = "1920x1080"
	)

	# some prerequesites
	begin {
		Set-StrictMode -Version Latest
		
		$env:TEMP = Join-Path -Path $HOME -ChildPath "AppData\Local\Temp"
		[string]$BingUrl = "http://www.bing.com"
		[string]$FeedURL = "/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=de-DE"
		[string]$RequestUrl = $BingUrl + $FeedURL
    } #END begin
    
	# now the tricky part
	process {
		$RequestBing = Invoke-WebRequest -Uri $RequestUrl
		[Xml]$ResponseBing = $RequestBing.Content
		$ImageBaseUrl = $ResponseBing.images.image
		$DownloadUri = New-Object -TypeName System.Uri -Args "$($BingUrl)$($ImageBaseUrl.urlBase)_$($Resolution).jpg"
		$ImageName = $DownloadUri.Segments[$DownloadUri.Segments.Count -1]
		$DownloadedImageName = "$($ImageName.Split("_")[0])_$($ImageName.Split("_")[$ImageName.Split("_").Count -1])"
		Invoke-WebRequest -Uri $DownloadUri -OutFile "$Path\$DownloadedImageName"
		} #END process
	# DONE
}
