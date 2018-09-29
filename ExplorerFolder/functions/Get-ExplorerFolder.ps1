function Get-ExplorerFolder
{
<#
	.SYNOPSIS
		Returns the current explorer folder configuration items.
	
	.DESCRIPTION
		Returns the current explorer folder configuration items.
	
	.PARAMETER Name
		The name to search by
	
	.EXAMPLE
		PS C:\> Get-ExplorerFolder
	
		Returns all folders and their settings.
	
	.EXAMPLE
		PS C:\> Get-ExplorerFolder -Name Desktop
	
		Returns the status of the desktop folder.
#>
	[CmdletBinding()]
	Param (
		[string]
		$Name = "*"
	)
	process
	{
		Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\ | Get-ItemProperty | Select-PSFObject @(
			'Name',
			'PSChildName as ID to Guid',
			'PSChildName as IDString'
		) -ScriptProperty @{
			"IsDefined" = {
				if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration")) { return $false }
				((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration").PSObject.Properties.Name -contains $this.IDString)
			}
			"Enabled"   = {
				if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration")) { return $false }
				[bool]((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration").$($this.IDString))
			}
		} -TypeName 'ExplorerFolder.FolderSetting' | Where-Object Name -Like $Name
	}
}