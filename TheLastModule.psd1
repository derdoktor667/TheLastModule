@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '0.3.0.1'

# ID used to uniquely identify this module
GUID = '926B03ED-9A30-4D03-BFA5-C072D39EBED2'

# Author of this module
Author = 'Wastl Kraus'

# Company or vendor of this module
CompanyName = 'Wir-sind-die-Matrix.de'

# Copyright statement for this module
Copyright = '(c) 2015 Wastl Kraus. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Will be the last module you need to install. in a distant future ^^'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = '3.5'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = ''

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = 'TheLastModule.psm1'

# Functions to export from this module
FunctionsToExport = 
	'Backup-GPwmiFilter',
	'Backup-LocalCertStore',
	'Get-BingDailyImage',
	'Install-Chocolatey',
	'Install-DesktopEssentials',
	'Install-GVLKClient',
	'Install-ServerEssentials',
	'Protect-PowerShellScripts',
	'Start-AdminPowerShell',
	'Update-ADMXCentralStore'

# Cmdlets to export from this module
# CmdletsToExport = ''

# Variables to export from this module
VariablesToExport = '$moduleRoot'

# Aliases to export from this module
# AliasesToExport = ''

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = ''

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
