Get-WindowsCapability -online | ? name -match "MediaFeaturePack" | Add-WindowsCapability -Online
Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
