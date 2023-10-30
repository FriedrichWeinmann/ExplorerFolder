# Guide for available variables and working with secrets:
# https://docs.microsoft.com/en-us/vsts/build-release/concepts/definitions/build/variables?tabs=powershell

# Needs to ensure things are Done Right and only legal commits to master get built

# Run internal pester tests
& "$PSScriptRoot\..\ExplorerFolder\tests\pester.ps1"

$filter = New-PSFFilter -Expression "EnvGithubAction" -ConditionSet (Get-PSFFilterConditionSet -Name Environment)
if ($filter.Evaluate()) {
	Stop-PSFRunspace -Name psframework.logging
}