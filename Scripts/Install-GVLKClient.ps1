<#
    .SYNOPSIS
        Deploy GVLK Key and setup the KMS Server connection.

    .DESCRIPTION
        Install the GVLKey and activate the Host with a KMS Server.

    .PARAMETER GVLKey
        The GVLKey to use for activation.

    .PARAMETER KMSHost
        The KMS Server to use for activation.

    .EXAMPLE
        Install-GVLKClient -GVLKey "XXXX-XXXX-XXXX-XXXX-XXXX" -KMSHost kms.contoso.com:1688

        This will setup the localhost with the given GVLKey and activate with the KMS Server.

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
#>

function Install-GVLKClient {

    [cmdletbinding()]

    param(
        [parameter(mandatory=$true)]$GVLKey,
        [parameter(mandatory=$true)]$KMSHost,
        [parameter(mandatory=$true)]$WinEditionWanted,
        [parameter(mandatory=$false)]$Computername = $env:COMPUTERNAME
        )

    Set-StrictMode -Version Latest

    # do we have admin privileges???
    $CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
    $IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if (!($IsAdmin)) {
        Write-Error "...sorry, you don´t have enough rights to run the script" -ErrorAction Stop
        # ...dead
    }

    # ...currently OS edition
    $WinEditionOnline = (Get-WindowsEdition -Online).Edition

    if(!($WinEditionOnline -notlike $WinEditionWanted)) {
        dism /online /set-edition:$WinEditionWanted /productkey:$GVLKey /accepteula
    }
}
