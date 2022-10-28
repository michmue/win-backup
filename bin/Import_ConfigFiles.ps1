$CONFIG_SOURCE_FOLDER = Read-Host -Prompt "Path to configs"
$RESULT = @()

$MACHINE_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\registry.pol"
$USER_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\User\registry.pol"

$GIT_CONFIG_FILES = @(
    ".gitconfig",
    ".bash_history",
    ".minttyrc",
    ".inputrc"
    ".bash_profile"
);

$NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"
$JDOWNLOADER_CONFIG_FOLDER = "$env:ProgramFiles\JDownloader\cfg"
$FIREFOX_CONFIG_FOLDER = "$env:APPDATA\Mozilla\Firefox\Profiles"
$ZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"
$POWERSHELL_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowerShell"


if ( !(Test-Path $CONFIG_SOURCE_FOLDER -PathType Container) ) {
    Write-Host "Config folder not existing: $CONFIG_SOURCE_FOLDER"
    exit
}


# POLICY
$machine_policies = Import-Clixml $CONFIG_SOURCE_FOLDER\MachineRegistryPol.xml 
$user_policies = Import-Clixml $CONFIG_SOURCE_FOLDER\UserRegistryPol.xml 

foreach ($pol in $machine_policies) { $pol | Set-PolicyFileEntry -Path $MACHINE_POLICIE_FILE }
foreach ($pol in $user_policies) { $pol | Set-PolicyFileEntry -Path $USER_POLICIE_FILE }

gpupdate /Force 1>$null
$RESULT += "[X] Policies imported"


# POWERSHELL
if ( Test-Path $POWERSHELL_USER_PROFILE_FOLDER ) {
    copy $CONFIG_SOURCE_FOLDER\WindowsPowerShell\* $POWERSHELL_USER_PROFILE_FOLDER  -Recurse -Force

    $RESULT += "[X] Powershell User Profile imported"
} else { $RESULT += "[ ] Powershell User Profile not found" }


# GIT
foreach ($file in $GIT_CONFIG_FILES) {
    if ( Test-Path $CONFIG_SOURCE_FOLDER\git\$file ) {
        copy $CONFIG_SOURCE_FOLDER\git\$file $env:USERPROFILE
    }    
}
$RESULT += "[X] GIT Configs imported"


# NOTEPAD++
if ( (Test-Path $NOTEPAD_PP_CONFIG_FODLER) -AND (Test-Path $CONFIG_SOURCE_FOLDER\Notepad++)){ 
    copy $CONFIG_SOURCE_FOLDER\Notepad++\* $NOTEPAD_PP_CONFIG_FODLER -Recurse -Force    
    
    $RESULT += "[X] NOTEPAD++ Configs imported"
} else { $RESULT += "[ ] NOTEPAD++ not installed" }


# 7-ZIP
if ( (Test-Path $ZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:")) -AND (Test-Path $CONFIG_SOURCE_FOLDER\7zip.reg)) { 
    reg import $CONFIG_SOURCE_FOLDER\7zip.reg 2>$null 

    $RESULT += "[X] 7-ZIP registry file imported"
} else { $RESULT += "[ ] 7-ZIP++ not installed" }


# JDOWNLOADER
if ( (Test-Path $JDOWNLOADER_CONFIG_FOLDER) -AND (Test-Path $CONFIG_SOURCE_FOLDER\cfg)){
    copy $CONFIG_SOURCE_FOLDER\cfg\* $JDOWNLOADER_CONFIG_FOLDER -Recurse -Force -ErrorAction SilentlyContinue
    
    $RESULT += "[X] JDownloader cfg Folder imported"
} else { $RESULT += "[ ] JDownloader not installed" }


# FIREFOX
$firefox_profile_folder = Get-ChildItem -Path $FIREFOX_CONFIG_FOLDER | WHERE name -Match default-release
$cfg_firefox_profile_folder = Get-ChildItem -Path $CONFIG_SOURCE_FOLDER | WHERE name -Match default-release
if (($FIREFOX_CONFIG_FOLDER -ne $null) -and ($cfg_firefox_profile_folder -ne $null)) {
    Write-Host "close your firefox..."
    Get-Process | WHERE ProcessName -eq firefox | Wait-Process
    Write-Host "copying $cfg_firefox_profile_folder to $firefox_profile_folder"
    copy $CONFIG_SOURCE_FOLDER\$cfg_firefox_profile_folder\* $FIREFOX_CONFIG_FOLDER\$firefox_profile_folder -Recurse -Force
    
    $RESULT += "[X] Firefox profile imported"
} else { $RESULT += "[ ] Firefox not installed" }


# SYNCTHING
$SYNCTRAYZOR_CONFIG_FILE = "$env:APPDATA\SyncTrayzor\config.xml"
$SYNCTHING_CONFIG_FILE_1 = "$env:LOCALAPPDATA\Syncthing\config.xml"
#$SYNCTHING_CONFIG_FILE_2 = "$env:LOCALAPPDATA\Syncthing\config.xml.v36"
$SYNCTHING_CONFIG_FILE_3 = "$env:LOCALAPPDATA\Syncthing\key.pem"
$SYNCTHING_CONFIG_FILE_4 = "$env:LOCALAPPDATA\Syncthing\cert.pem"

if ( (Test-Path $SYNCTRAYZOR_CONFIG_FILE) -and
     (Test-Path $SYNCTHING_CONFIG_FILE_1) -and
     (Test-Path $SYNCTHING_CONFIG_FILE_2)){

    copy $CONFIG_SOURCE_FOLDER\synctrayzor_config.xml $SYNCTRAYZOR_CONFIG_FILE
    copy $CONFIG_SOURCE_FOLDER\config.xml $SYNCTHING_CONFIG_FILE_1 
#    copy $CONFIG_SOURCE_FOLDER\config.xml.v36 $SYNCTHING_CONFIG_FILE_2 
    copy $CONFIG_SOURCE_FOLDER\cert.pem $SYNCTHING_CONFIG_FILE_3 
    copy $CONFIG_SOURCE_FOLDER\key.pem $SYNCTHING_CONFIG_FILE_4
    
    $RESULT += "[X] Syncthing imported"
} else { $RESULT += "[ ] Syncthing not installed" }


# NED
Write-Host "--------------------------------"
$RESULT