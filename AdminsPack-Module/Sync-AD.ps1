Function Sync-AD {

$User = [Security.Principal.WindowsIdentity]::GetCurrent()
$Role = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

	if(!$Role) {
		throw "This has to be run as Administrator. Exit"
		}

$RSATinst = $(Get-WindowsOptionalFeature -Online -FeatureName RSATClient-Roles-AD-Powershell)

if (($RSATinst).State -ne "Enabled") {
     Write-Output "RSAT-AD-Powershell is missing. ...installing"
     $(Enable-WindowsOptionalFeature -Online -FeatureName RSATClient-Roles-AD-Powershell -Verbose)
     }

$AllDCs = $((Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ }).Hostname

foreach ($DC in $AllDCs) {
    @(repadmin /kcc $DC)
    @(repadmin /syncall /A /e $DC)
    }
}
