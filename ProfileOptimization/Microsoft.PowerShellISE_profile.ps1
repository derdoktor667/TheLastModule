# ...my Home is my Castle
Set-Location -Path $HOME

# ...pimp my Error
$a = (Get-Host).PrivateData
$a.ErrorBackgroundColor = "Red"
$a.ErrorForegroundColor = "White"

$CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
$IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# ...add some more colors
function prompt {

    $Location = (Get-Location -PSProvider FileSystem).ProviderPath
    $PromptText = "PS $Location"
    
    $Color = "Green"
    $Title = "$env:COMPUTERNAME"
    
    if ($IsAdmin -eq $true ) {
        $Color = "Red"
        $Title = "### ADMIN MODE: activated ### on " + $env:COMPUTERNAME
        }

    Write-Host $PromptText -NoNewLine -ForegroundColor $Color
    Return " > "
}

# ...add some PSDefaultParameters
$PSDefaultParameterValues = @{
    "New-ModuleManifest:Author" = "Wastl Kraus"
    "New-ModuleManifest:CompanyName" = "Wir-sind-die-Matrix.de"
    "New-ModuleManifest:Copyright" = "2016"
    "New-ModuleManifest:FunctionsToExport" = "*"
    "New-ModuleManifest:AliasesToExport" = "*"
    "New-ModuleManifest:VariablesToExport" = "*"
    }

#Script Browser Begin
#Version: 1.3.2
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\System.Windows.Interactivity.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\ScriptBrowser.dll'
Add-Type -Path 'C:\Program Files (x86)\Microsoft Corporation\Microsoft Script Browser\BestPractices.dll'
$scriptBrowser = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Browser', [ScriptExplorer.Views.MainView], $true)
$scriptAnalyzer = $psISE.CurrentPowerShellTab.VerticalAddOnTools.Add('Script Analyzer', [BestPractices.Views.BestPracticesView], $true)
$psISE.CurrentPowerShellTab.VisibleVerticalAddOnTools.SelectedAddOnTool = $scriptBrowser
#Script Browser End
