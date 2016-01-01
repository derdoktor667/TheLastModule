<#

    .SYNOPSIS
        Backup the local Certificates to given path.

    .DESCRIPTION
        Certs are important. ...let´s backup all at once.

    .PARAMETER Path
        Specifies the backup path.

    .EXAMPLE
        Backup-LocalCertStore -Path "c:\temp"

        Creates a directory named CertBackup_localhostname

    .NOTES
        Author: Wastl Kraus
        Email : derdoktor667@gmail.com

    .LINK
        http://wir-sind-die-matrix.de/

#>

function Backup-LocalCertStore {
    
    [cmdletbinding()]

    param(
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)][string]$Path = $env:temp
        )

    Set-StrictMode -Version Latest
    
    [String]$CertBackupLocation = "$Path\CertBackup_$env:COMPUTERNAME"
    $AllCerts = Get-ChildItem Cert:\\ -Recurse | Where-Object PSIsContainer -eq $false

    if (!(Test-Path $CertBackupLocation)) {
        New-Item -Path $CertBackupLocation -ItemType Directory
    }

    foreach ($Cert In $AllCerts) {
        [String]$StoreLocation = $($Cert.PSParentPath -Split "::")[-1]

        if (!(Test-Path (Join-Path -Path $CertBackupLocation -ChildPath $StoreLocation))) {
            New-Item (Join-Path $CertBackupLocation $StoreLocation) -ItemType Directory
        }

        if (!($Cert.HasPrivateKey -And -Not $Cert.Archived)) {
            $Filepath = [String](Join-Path (Join-Path -Path $CertBackupLocation -ChildPath $StoreLocation) $Cert.Thumbprint) + '.crt'
            Export-Certificate -Cert $Cert -FilePath $Filepath -Force -Verbose
        }
    }
}
