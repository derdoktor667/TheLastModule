function Update-ADMXCentralStore {
        
    <#

    .SYNOPSIS
        Copy the local Policy Definitions to domains central store.

    .DESCRIPTION
        Creates a folder on a domain controller to share group
		policy definitions.

    .PARAMETER UICulture
        Specifies the csv File export path.

    .EXAMPLE
        Update-ADMXCentralStore

        This command uses your local UI Language for creating your pool.

	.EXAMPLE
		Update-ADMXCentralStore -UICulture en-US,de-DE

		This example will update your central store with the policy
		definition languages for English (US) and German.

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/

    #>
	
    [cmdletbinding()]

    Param (
	$UICulture = @((Get-UICulture).Name)
    )

	# We need to be in admins group for this
	$CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
	$IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (!($IsAdmin)) {
            Write-Error "...sorry, you don´t have enough rights to run the script" -ErrorAction Stop
            # ...dead
	}

	# get some informations and prereqs
	$Domain = (Get-ADDomainController).Domain
	$SysvolPath = Join-Path -Path \\ -ChildPath $Domain\SYSVOL
	$PoliciesPath = Join-Path -Path $Domain -ChildPath Policies
	$PolicyDefinitionPath = Join-Path -Path "$SysvolPath\$PoliciesPath" -ChildPath PolicyDefinitions
	$LocalPoliciesPath = Join-Path -Path $env:windir -ChildPath PolicyDefinitions

	if ($Domain -eq $null) {
		Write-Error "Local domain could not be resolved. Exit" -ErrorAction Stop
		# ...dead
	}

	if (!(Test-Path $LocalPoliciesPath)) {
		Write-Error "Local policy definitions not found. Exit" -ErrorAction Stop
		# ...dead
    }

	# let´s see what we have got
	$ADMX2Copy = (Get-ChildItem -Path $LocalPoliciesPath -Recurse -Filter *.admx).FullName
	$UICulturesLocal = (Get-ChildItem -Path $LocalPoliciesPath -Recurse).FullName

    if (!(Test-Path $PolicyDefinitionPath)) {
        New-Item -Path $PolicyDefinitionPath -ItemType Directory -Force
        Write-Output "Created the Central Store Directory: $PolicyDefinitionPath"
    }

	foreach ($ADMX in $ADMX2Copy) {
		Copy-Item -Path $ADMX -Destination $PolicyDefinitionPath -Force
		Write-Output "Copy file: $ADMX"
	}

    foreach ($UI2Copy in $UICulture) {
        New-Item -Path "$PolicyDefinitionPath\$UI2Copy" -ItemType Directory -Force
        $Dir2Copy = (Get-ChildItem -Path $UICulturesLocal -Recurse -Filter *.adml).FullName

            if ($Dir2Copy -eq $null) {
                Write-Error "Selected UICulture $Dir2Copy not found. Exit" -ErrorAction Stop
            }

        Copy-Item -Path $Dir2Copy -Destination "$PolicyDefinitionPath\$UI2Copy" -Force
        Write-Output ""
   }
	
	Write-Output "All done. Exit" 

}
