# ...always use "autosize"
# $PSDefaultParameterValues['Format-[wt]*:Autosize'] = $true

# ...pimp my Error
$a = $(Get-Host).PrivateData
$a.ErrorBackgroundColor = "red"
$a.ErrorForegroundColor = "white"
# $a.ProgressForegroundColor = "blue"
# $a.ProgressBackgroundColor = "white"

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

# ...my castle
Set-Location -Path $HOME

#Script Browser Begin
#Version: 1.3.2
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\System.Windows.Interactivity.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\ScriptBrowser.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\BestPractices.dll'
$scriptBrowser = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Browser', [ScriptExplorer.Views.MainView], $true)
$scriptAnalyzer = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Analyzer', [BestPractices.Views.BestPracticesView], $true)
$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools.SelectedAddOnTool = $scriptBrowser
#Script Browser End
