#Write-Host "installing windows capability: MediaFeaturePack ..."
#Get-WindowsCapability -online | where Name -Match "MediaFeaturePack" | Add-WindowsCapability -Online

#Write-Host "installing windows capability: OpenSSH.Client ..."
#Get-WindowsCapability -online | where Name -Match "OpenSSH.Client" | Add-WindowsCapability -Online

# Get-WindowsOptionalFeature -Online | where Name -Match "Microsoft-Windows-Subsystem-Linux"

#Write-Host "installing windows optional feature: dotNetFramkework 3 ..."
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "NetFx3" | Enable-WindowsOptionalFeature -Online
#Write-Host "installing windows optional feature: dotNetFramkework 4 ..."
#Get-WindowsOptionalFeature -Online | where FeatureName -Match "NetFx4-AdvSrvs" | Enable-WindowsOptionalFeature -Online


# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-All" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Tools-All" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Management-PowerShell" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Hypervisor" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Services" | Enable-WindowsOptionalFeature -Online
# Get-WindowsOptionalFeature -Online | where FeatureName -Match "Microsoft-Hyper-V-Management-Clients" | Enable-WindowsOptionalFeature -Online
#Write-Host "installing windows optional feature: Microsoft-Hyper-V -All ..."
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All


$features = @(
    @{ Name = "MediaFeaturePack";   FeatureName = "MediaFeaturePack"; InstallCommand = { Get-WindowsCapability -online | where {($_.Name -Match "MediaFeaturePack") -and ($_.State -ne "Installed")} | Add-WindowsCapability -Online } }
    @{ Name = "OpenSSH.Client";     FeatureName = "OpenSSH.Client"; InstallCommand = { Get-WindowsCapability -online | where {($_.Name -Match "OpenSSH.Client") -and ($_.State -ne "Installed")} | Add-WindowsCapability -Online } }
    @{ Name = "dotNetFramework 3";  FeatureName = "NetFx3"; InstallCommand = { Get-WindowsOptionalFeature -Online | where { ($_.FeatureName -Match "NetFx3") -and ($_.State -ne "Enabled") } | Enable-WindowsOptionalFeature -Online } }
    @{ Name = "dotNetFramework 4";  FeatureName = "NetFx4-AdvSrvs"; InstallCommand = { Get-WindowsOptionalFeature -Online | where { ($_.FeatureName -Match "NetFx4-AdvSrvs") -and ($_.State -ne "Enabled") } | Enable-WindowsOptionalFeature -Online } }
    @{ Name = "Microsoft-Hyper-V";  FeatureName = "Microsoft-Hyper-V-All"; InstallCommand = { Get-WindowsOptionalFeature -Online | where { ($_.FeatureName -Match "Microsoft-Hyper-V-All") -and ($_.State -ne "Enabled") } | Enable-WindowsOptionalFeature -Online -All } }
    @{ Name = "PolicyFileEditor";  FeatureName = "PolicyFileEditor"; InstallCommand = {
            Set-PSRepository PSGallery -InstallationPolicy Trusted
            if (!(Get-InstalledModule PolicyFileEditor -ea Ignore)) {
                Install-Module -Name PolicyFileEditor  -Scope CurrentUser
            }
        }
    }
)

function Enable-WBFeature {
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        $feature
    )

    process {
        Write-Host "Installing $($feature.Name) feature ..."
        Invoke-Command -ScriptBlock $feature.InstallCommand
        if ($feature.Name -eq "Microsoft-Hyper-V") {
            Write-Host "Check if all Hyper-V's are installed"
            Write-Host "Get-WindowsOptionalFeature -Online | where FeatureName -like '*Hyper*'"
            Start-Process appwiz.cpl -ArgumentList ",2"
            pause
        }
    }
}

function Get-WBFeature {
    return $features
}

Export-ModuleMember -Function Get-WBFeature, Enable-WBFeature -Variable features