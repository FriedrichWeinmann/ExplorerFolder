<#
# Example:
Register-PSFTeppArgumentCompleter -Command Get-Alcohol -Parameter Type -Name ExplorerFolder.alcohol
#>
Register-PSFTeppArgumentCompleter -Command Set-ExplorerFolder -Parameter Name -Name 'explorer-knownfolder-names'
Register-PSFTeppArgumentCompleter -Command Get-ExplorerFolder -Parameter Name -Name 'explorer-knownfolder-names'
Register-PSFTeppArgumentCompleter -Command Remove-ExplorerFolder -Parameter Name -Name 'explorer-knownfolder-names-defined'