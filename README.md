# Description

Module that allows you to tune the folders that are shown in the explorer shell under "My Computer" ... but also the top level symbols, such as "My Computer" itself.
This now also includes commands to manage the Windows 11 "Gallery" integration at the top.

## Install

```powershell
# PowerShellGet
Install-Module ExplorerFolder -Scope CurrentUser

# Microsoft.PowerShell.PSResourceGet
Install-PSResource ExplorerFolder
```

## Profit

```powershell
Disable-EFGallery
```
