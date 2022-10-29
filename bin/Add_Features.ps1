Set-PSRepository PSGallery -InstallationPolicy Trusted
if (!(Get-InstalledModule PolicyFileEditor)) {
    Install-Module -Name PolicyFileEditor  -Scope CurrentUser
}

Get-WindowsCapability -online | where Name -Match "MediaFeaturePack" | Add-WindowsCapability -Online
Get-WindowsCapability -online | where Name -Match "OpenSSH.Client" | Add-WindowsCapability -Online


#Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Windows-Subsystem-Linux"      
Get-WindowsOptionalFeature -Online | where FeatureName -Match "NetFx3" | Enable-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online | where FeatureName -Match "NetFx4-AdvSrvs" | Enable-WindowsOptionalFeature -Online

Write-Host "Check if all Hyper-V's are installed"
Write-Host "Get-WindowsOptionalFeature -Online | where FeatureName -like '*Hyper*'"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-All" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Tools-All" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Management-PowerShell" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Hypervisor" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Services" | Enable-WindowsOptionalFeature -Online
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Management-Clients" | Enable-WindowsOptionalFeature -Online