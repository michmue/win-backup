Get-NetAdapter Ethernet | Disable-NetAdapter -Confirm:$false

# INCLUDED IN REGISTRY_DISABLEDDRIVERS.POL
<# 
# HDAUDIO\FUNC_01&VEN_10DE&DEV_0084&SUBSYS_10DE1C03&REV_1001
# HDAUDIO\FUNC_01&VEN_10DE&DEV_0084&SUBSYS_10DE1C03
(Get-PnpDevice | ? FriendlyName -eq "NVIDIA High Definition Audio").HardwareID


# MMDEVAPI\AudioEndpoints
(Get-PnpDevice | ? FriendlyName -eq "XG2401 SERIES (NVIDIA High Definition Audio)").HardwareID


# PCI\VEN_13F6&DEV_8788&SUBSYS_85211043&REV_00
# PCI\VEN_13F6&DEV_8788&SUBSYS_85211043
# PCI\VEN_13F6&DEV_8788&CC_040100
# PCI\VEN_13F6&DEV_8788&CC_0401
# MMDEVAPI\AudioEndpoints
(Get-PnpDevice | ? FriendlyName -eq "Asus Xonar DGX Audio Device").HardwareID

# PCI\VEN_10EC&DEV_8168&SUBSYS_86771043&REV_15
# PCI\VEN_10EC&DEV_8168&SUBSYS_86771043
# PCI\VEN_10EC&DEV_8168&CC_020000
# PCI\VEN_10EC&DEV_8168&CC_0200
(Get-PnpDevice | ? FriendlyName -eq "Realtek PCIe GbE Family Controller").HardwareID

# Motherboard Audio (not dgx)
# HDAUDIO\FUNC_01&VEN_10EC&DEV_0887&SUBSYS_104386C7&REV_1003
# HDAUDIO\FUNC_01&VEN_10EC&DEV_0887&SUBSYS_104386C7
(Get-PnpDevice | ? FriendlyName -like "High Definition Audio-Gerät").HardwareID

# PCI\VEN_10DE&DEV_1C03&SUBSYS_1C0310DE&REV_A1
# PCI\VEN_10DE&DEV_1C03&SUBSYS_1C0310DE
# PCI\VEN_10DE&DEV_1C03&CC_030000
# PCI\VEN_10DE&DEV_1C03&CC_0300
(Get-PnpDevice | ? FriendlyName -eq "NVIDIA GeForce GTX 1060 6GB" | select HardwareId).HardwareId)

gpupdate /force
 #>
 
 .\Import_ConfigFiles.ps1 -UseBasePOL -UsePolicy	