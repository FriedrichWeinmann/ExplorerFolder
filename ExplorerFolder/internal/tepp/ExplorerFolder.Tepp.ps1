Register-PSFTeppScriptblock -Name 'explorer-knownfolder-names' -ScriptBlock {
	(Get-ExplorerFolder).Name
}
Register-PSFTeppScriptblock -Name 'explorer-knownfolder-names-defined' -ScriptBlock {
	(Get-ExplorerFolder | Where-Object IsDefined).Name
}
