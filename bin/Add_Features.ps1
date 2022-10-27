Set-PSRepository PSGallery -InstallationPolicy Trusted
if (!(Get-InstalledModule PolicyFileEditor)) {
    Install-Module -Name PolicyFileEditor  -Scope CurrentUser
}

Get-WindowsCapability -online | where $_.Name -Match "MediaFeaturePack" | Add-WindowsCapability -Online
Get-WindowsCapability -online | where $_.Name -Match "OpenSSH.Client" | Add-WindowsCapability -Online


#Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Windows-Subsystem-Linux"      
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-All" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-Tools-All" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-Management-PowerShell" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-Hypervisor" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-Services" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Hyper-V-Management-Clients" | Enable-WindowsOptionalFeature -Online