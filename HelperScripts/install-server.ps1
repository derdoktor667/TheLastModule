# let´s wrap it in a function to be sure

function Get-DownloadFiles {
        param (
            [string]$URL,
            [string]$file
        )

        Write-Host "Downloading $URL to $file"
        $downloader = new-object System.Net.WebClient
        $downloader.DownloadFile($URL, $file)
    }

function install-server {
    
    $URL = "https://chocolatey.org/api/v2/package/chocolatey/"
    if ($env:TEMP -eq $null) {
        $env:TEMP = Join-Path $env:SystemDrive 'temp'
    }

    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "chocInstall"
    if (![System.IO.Directory]::Exists($tempDir)) {
        [System.IO.Directory]::CreateDirectory($tempDir)
        }

    $file = Join-Path $tempDir "chocolatey.zip"

    Get-DownloadFiles $URL $file

    Write-Host "Download 7Zip commandline tool"
    $7zaExe = Join-Path $tempDir '7za.exe'

    Get-DownloadFiles 'http://tools.wir-sind-die-matrix.de/7za.exe' "$7zaExe"

    Write-Host "Extracting $file to $tempDir..."
    Start-Process "$7zaExe" -ArgumentList "x -o`"$tempDir`" -y `"$file`"" -Wait -NoNewWindow


    Write-Host "Installing chocolatey on this machine"
    $toolsFolder = Join-Path $tempDir "tools"
    $chocInstallPS1 = Join-Path $toolsFolder "chocolateyInstall.ps1"

    & $chocInstallPS1

    Write-Host 'Ensuring chocolatey commands are on the path'

    $chocInstallVariableName = "ChocolateyInstall"
    $chocoPath = [Environment]::GetEnvironmentVariable($chocInstallVariableName, [System.EnvironmentVariableTarget]::User)
    $chocoExePath = 'C:\ProgramData\Chocolatey\bin'

    if ($chocoPath -ne $null) {
            $chocoExePath = Join-Path $chocoPath 'bin'
        }

    if ($($env:Path).ToLower().Contains($($chocoExePath).ToLower()) -eq $false) {
            $env:Path = [Environment]::GetEnvironmentVariable('Path',[System.EnvironmentVariableTarget]::Machine);
        }

$Apps4Servers = "7zip",
                "chocolatey",
                "ChocolateyGUI",
                "directx",
                "DotNet3.5",
                "DotNet4.5",
                "DotNet4.5.1",
                "DotNet4.6",
                "DotNet4.6.1",
                "google-chrome-x64",
                "NugetPackageExplorer",
                "PowerShell",
                "putty",
                "Silverlight",
                "sysinternals",
                "vcredist2005",
                "vcredist2008",
                "vcredist2010",
                "vcredist2012",
                "vcredist2013",
                "vcredist2015",
                "visualStudioCode",
                "webpi",
                "winscp"
    
    $PowerShellName = "powershell.exe"
    $ArgumentList = "-command choco install $Apps4Servers -pre -Y"
    Start-Process $PowerShellName -ArgumentList $ArgumentList

}
