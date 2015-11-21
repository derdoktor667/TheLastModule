Function Backup-GPwmiFilter {

    <#
    .SYNOPSIS
        Backup the Group Policy WMI-Filters into csv-File.

    .DESCRIPTION
        Exports all WMI Filters at once.

    .PARAMETER Path
        Specifies the csv File export path.

    .EXAMPLE
        Backup-GPwmiFilter -Path "c:\temp"

        Exports all WMI Filters into "C:\temp\GPwmiFilters-CurrentDate.csv

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
    #>
	
    [cmdletbinding()]

    Param (
	[String]$Path = $HOME
    )

	$CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
	$IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (!($IsAdmin)) {
            Write-Error "...sorry, you don´t have enough rights to run the script" -ErrorAction Stop
            # ...dead
            }
    
    $Timestamp = Get-Date -Format g | ForEach-Object {$_ -replace ":", "."} | ForEach-Object {$_ -replace " "}
    $CSVFile = Join-Path -Path $Path -ChildPath GPWMIFilter-$Timestamp.csv
    
    Set-Content -Path $CSVFile $null
    
    $WMIFilters = Get-ADObject -Filter 'objectClass -eq "msWMI-Som"' -Properties "msWMI-Name","msWMI-Parm1","msWMI-Parm2"

    foreach ($WMIFilter in $WMIFilters) {
        $NewContent = $WMIFilter."msWMI-Name" + "`t" + $WMIFilter."msWMI-Parm1" + "`t" + $WMIFilter."msWMI-Parm2"
        Add-Content $NewContent -Path $CSVFile
    }
    
    Write-Output "Done, your file might be at $CSVFile"       
    
}
