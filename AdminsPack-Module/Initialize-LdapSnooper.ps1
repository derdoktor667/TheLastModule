Function Initialize-LDAPSnooper {    
    $Snooper = (New-Object -TypeName System.DirectoryServices.DirectorySearcher)
    $Snooper.filter = "(objectclass=computer)"
    $Targets = $Snooper.FindAll()
   
    # clean the list just to be sure
    [Array] $pcs = $null;

    foreach($Target in $Targets) {
        $pcs += New-Object psobject -Property @{
        Name = [string]$Target.Properties["cn"]
        OS = [string]$Target.Properties["operatingsystem"]
#        SP = [string]$Target.Properties["operatingsystemservicepack"]
#        SPN = [string]$Target.Properties["serviceprincipalname"]
        }
    }
    # add a fancy filter for "Windows" OS
    $WinPCs = ($pcs).OS -like "*Windows*"
    $WinPCs
    }