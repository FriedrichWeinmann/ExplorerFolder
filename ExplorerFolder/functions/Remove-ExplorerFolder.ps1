function Remove-ExplorerFolder
{
<#
	.SYNOPSIS
		Removes a registered named folder from the list of shown folders.
	
	.DESCRIPTION
		Removes a registered named folder from the list of shown folders.
		Use '-Force' to remove the overall whitelisting architecture.
	
	.PARAMETER Name
		Name of the folder to unlist.
	
	.PARAMETER Force
		Purge the entire registration key.
	
	.EXAMPLE
		PS C:\> Remove-ExplorerFolder -Name Desktop
		
		Removes the registration of the Desktop folder.
#>
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true, Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Name,
		
		[switch]
		$Force
	)
	
	begin
	{
		if (-not (Test-PSFPowerShell -Elevated))
		{
			Stop-PSFFunction -Message "This command requires elevation" -EnableException $EnableException -Cmdlet $PSCmdlet
			return
		}
		
		$allItems = Get-ExplorerFolder
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		foreach ($nameItem in $Name)
		{
			$item = $allItems | Where-Object Name -EQ $nameItem
			if (-not $item) { continue }
			if (-not $item.IsDefined) { continue }
			
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration" -Name $item.IDString
		}
	}
	end
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		if ($Force)
		{
			if (-not ($allItems | Where-Object IsDefined))
			{
				Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration" -Force
			}
		}
	}
}