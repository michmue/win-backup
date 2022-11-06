<# TODO's INSTALLTION

    WINDOWS
        COMMANDLINES 
            Design & Font 
            cmd clink (history + search)
            evtl. posh?
    
        disable OneDrive (GPO?)
        
        USER ICONS
            folder
            login

        disable driver installation (gpo & system gui)
        disable auto add network devices
        disable media streaming
        
        ENVS:
            JD2_HOME	C:\Users\eno\AppData\Local\JDownloader 2.0
            PIPENV_VENV_IN_PROJECT	1
            PATH: c:\term;c:\bin;c:\tools;
            PATHEXT: .LNK
    
    NVIDEA
        144hz
		switch audio again (install audio last?)
        
    SOUND (LAG ?)
        disable front mic
		dgx default communication (already default?)
        autostart one of the audio programs
        
    configer internet explorer for -BasicHtmlParsing
    
    EDGE 
        disable startup boost & background in system & performance)
		data protection delete on close enable all
		disable cookies & preloading
		Startpage & search & new tab
		do not track

    OFFICE
        disable background (circles & icons...)
		backstage disable
		std. save to PC
		std. save place to "Eigene Dateien"
		std. personal templates "Eigene Dateien"
		disable adobe plugin
        disable settings cloud save
        
    NOTEPAD++
        n&np shortcuts for cmd (:ENVS)
		XML plugin toolbar icons
		Markdown plugin (hide sections) ?
        
    HYPER-V
        default place
        default config place to c:\vm, c:\vm configs
        disable autostart vm
        
    ADOBE
		cleanup bat file
		disable adobe plugin office
		acrobat
			fit page
			centimeter
			single page
    
    7ZIP replace lnk in start menu after icon change
    
    JDOWNLOADER
        JDownloader2Setup_windows-x64_jre17.exe -varfile response.varfile -q -splash "Installiere JDownloader" -dir %localappdata%\JDownloader
        
    "EIGENE DATEIEN"
    
    ICONS SYSTEM TRAY
#>


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
 
 # .\Import_ConfigFiles.ps1 -EnableAll
 
 
 # .\settings.ps1 -EnableAll
 
 
 # .\customization.ps1 -EnableAll
 
 
 # .\programs.ps1 -InstallAll
 
 # run after programs, registry entries needed?
 # .\tweaks.ps1 -EnableAll
 
 # .\cleanup.ps1 -EnableAll
 
 