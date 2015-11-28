# ...pimp my Error
$a = $(Get-Host).PrivateData
$a.ErrorBackgroundColor = "Red"
$a.ErrorForegroundColor = "White"
$a.ProgressForegroundColor = "Blue"
$a.ProgressBackgroundColor = "White"

# ...add some more colors
Function prompt {
    $PromptText = "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($NestedPromptLevel + 1)) ";
    $CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
    $IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if ($IsAdmin -eq $true ) {
        $Color = "Red"
        $Title = "### ADMIN MODE: activated ### on " + $env:COMPUTERNAME;
        }

    else {
        $Color = "Green"
        $Title = "$env:COMPUTERNAME";
        }

    Write-Host $PromptText -NoNewLine -ForegroundColor $Color
    $Host.UI.RawUI.WindowTitle = $Title;
    Return " "
    }

# ...my home is my castle
Set-Location -Path $HOME
