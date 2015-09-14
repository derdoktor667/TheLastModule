# ...always use "autosize"
# $PSDefaultParameterValues['Format-[wt]*:Autosize'] = $true

# ...pimp my Error
$a = $(Get-Host).PrivateData
$a.ErrorBackgroundColor = "red"
$a.ErrorForegroundColor = "white"
$a.ProgressForegroundColor = "blue"
$a.ProgressBackgroundColor = "white"

# ...add some more colors
Function prompt {
    $promptText = "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
    $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if ($isAdmin -eq $true ) {
        $Color = "Red"
        $Title = "### ADMIN MODE: activated ### on " + $env:COMPUTERNAME;
        }

    else {
        $Color = "Green"
        $Title = $($env:COMPUTERNAME);
        }

    Write-Host $promptText -NoNewLine -ForegroundColor $Color
    $Host.UI.RawUI.WindowTitle = $Title;
    Return " "
    }

# ...my home is my castle
Set-Location -Path $HOME
