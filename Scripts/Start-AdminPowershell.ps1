function Start-AdminPowershell {

    <#
    .SYNOPSIS
        Connects as "real" Administrator localy or to remote host.

    .DESCRIPTION
        Enter any Host with the "Administrator" Account. Sometimes "Run as..." isn´t enough.

    .PARAMETER ComputerName
        Specifies the remote host.

    .EXAMPLE
        Start-AdminPowershell -Computername PS-REMOTEPC

        Start Powershell Session on "PS-REMOTEPC" as User Administrator

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/
    #>

    [cmdletbinding()]

    param(
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)][Alias("CN","__Server","IPAddress","Server")][string]$Computername = $env:Computername
        )

    begin {
        Set-StrictMode -Version Latest

        $Domain = "$env:USERDOMAIN"
        $AdminCredentials = "$Domain\Administrator"
    } #END begin

    process {
        $AdminSession = New-PSSession -ComputerName $Computername -Credential $AdminCredentials
        Enter-PSSession $AdminSession
    } #END begin
}
