function Set-ExplorerFolder
{
<#
	.SYNOPSIS
		Enables and disables folders to be displayed in the explorer shell.
	
	.DESCRIPTION
		Enables and disables folders to be displayed in the explorer shell.
	
	.PARAMETER Name
		Name of the folder to show or hide
	
	.PARAMETER Disable
		Disable it, rather than show it (default).
		Useful when enabling an entire category but selectively hiding members.
	
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		PS C:\> Set-ExplorerFolder -Name "Desktop"
	
		Enables the desktop folder to be shown in the desktop shell
#>
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline = $true, Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Name,
		
		[switch]
		$Disable,
		
		[switch]
		$EnableException
	)
	
	begin
	{
		if (-not (Test-PSFPowerShell -Elevated))
		{
			Stop-PSFFunction -Message "This command requires elevation" -EnableException $EnableException -Cmdlet $PSCmdlet
			return
		}
		
		$folders = Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\ | Get-ItemProperty | Select-Object Name, PSChildName
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		foreach ($nameItem in $Name)
		{
			$folder = $folders | Where-Object Name -EQ $nameItem
			if (-not $folder)
			{
				Stop-PSFFunction -Message "Could not resolve folder $nameItem!" -EnableException $EnableException -Cmdlet $PSCmdlet -Continue
			}
			
			if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration"))
			{
				$null = New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name AllowedEnumeration
			}
			
			if ($Disable) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration" -Name $folder.PSChildName -Value 0 }
			else { Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AllowedEnumeration" -Name $folder.PSChildName -Value 1 }
		}
	}
}