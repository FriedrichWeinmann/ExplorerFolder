function Enable-EFGallery {
	<#
	.SYNOPSIS
		Enables the "Gallery" symbol from the Windows 11 explorer shell.
	
	.DESCRIPTION
		Enables the "Gallery" symbol from the Windows 11 explorer shell.
		Use this to undo the effects of Disable-EFGallery.
	
	.PARAMETER Force
		Don't ask for confirmation - just restart explorer to make it take effect _right now_.
	
	.EXAMPLE
		PS C:\> Enable-EFGallery
		
		Enables the "Gallery" symbol from the Windows 11 explorer shell.
	#>
	[CmdletBinding()]
	param (
		[switch]
		$Force
	)
	process {
		$path = "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}"
		if (-not (Test-Path -Path $path)) {
			$null = New-Item -Path $path
		}

		Set-ItemProperty -Path $path -Name 'System.IsPinnedToNameSpaceTree' -Value 1
		
		$choice = $null
		if ($PSBoundParameters.Keys -notcontains 'Force') {
			$param = @{
				Caption = 'Explorer Gallery Integration'
				Message = 'The Gallery symbol has been unhidden, the explorer process must be restarted for the change to take effect.'
				Options = 'Not now', 'Yes, do so'
			}
			$choice = Get-PSFUserChoice @param
		}

		if ($Force -or $choice) {
			Get-Process explorer | Stop-Process
		}
	}
}