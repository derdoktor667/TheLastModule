# ...my Home is my Castle
Set-Location -Path $HOME

# ...pimp my Error
$a = (Get-Host).PrivateData
$a.ErrorBackgroundColor = "Red"
$a.ErrorForegroundColor = "White"
$a.ProgressForegroundColor = "Blue"
$a.ProgressBackgroundColor = "White"

# ...add some more colors
$CurrentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent([Security.Principal.TokenAccessLevels]'Query,Duplicate'))
$IsAdmin = $CurrentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function prompt {
    
    $Localtion = (Get-Location -PSProvider FileSystem).ProviderPath
    $PromptText = "PS $Localtion"
    
    $Color = "Green"
    $Title = "$env:COMPUTERNAME"
    
    if ($IsAdmin -eq $true ) {
        $Color = "Red"
        $Title = "### ADMIN MODE: activated ### on " + $env:COMPUTERNAME
        }

    Write-Host $PromptText -NoNewLine -ForegroundColor $Color
    $Host.UI.RawUI.WindowTitle = $Title
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
