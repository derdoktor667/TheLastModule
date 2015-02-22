
Function Install-GVLKClient {

<#
    .SYNOPSIS
        Deploy GVLK Key and setup the KMS Server connection.

    .DESCRIPTION
        Install the GVLKey and activate the Host with a KMS Server.

    .PARAMETER GVLKey
        The GVLKey to use for activation.

    .PARAMETER KMSHost
        The KMS Hoar to use for activation.

    .EXAMPLE
        Install-GVLKClient -GVLKey "XXXX-XXXX-XXXX-XXXX-XXXX" -KMSHost kms.contoso.com:1688

        This will setup the localhost with the given GVLKey and activate with the KMS Server.

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
    #>

    [cmdletbinding()]

    param(
        [parameter][string]$GVLKey = $(throw "Please provide a GVLKey, Exit."),
        [parameter][string]$KMSHost = $(throw "Please provide a KMS Server, Exit.")
        )

    begin {
        $WinEditionOnline = (Get-WindowsEdition -Online).Edition
        $WinEditionWanted = "ServerStandard"
        }
        
    process {       
        if(!($WinEditionOnline -eq $WinEditionWanted)) {
        Invoke-Command -ScriptBlock {dism /online /set-edition:$WinEditionWanted /productkey:$GVLKey /accepteula}
        Invoke-Command -ScriptBlock {slmgr.vbs /skms $KMSHost}
        Invoke-Command -ScriptBlock {slmgr.vbs /ato}
        Invoke-Command -ScriptBlock {slmgr.vbs /dli}
        }
    }
}