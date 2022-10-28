$CONFIG_DESTINATION_FOLDER = Read-Host -Prompt "Path where to save the configs"
$RESULT = @()

$MACHINE_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\registry.pol"
$USER_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\User\registry.pol"

$GIT_CONFIG_FILES = @(
    "$env:USERPROFILE\.gitconfig",
    "$env:USERPROFILE\.bash_history",
    "$env:USERPROFILE\.minttyrc",
    "$env:USERPROFILE\.inputrc"
    "$env:USERPROFILE\.bash_profile"
);


$NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"
$JDOWNLOADER_CONFIG_FOLDER = "$env:ProgramFiles\JDownloader\cfg"
$FIREFOX_CONFIG_FOLDER = "$env:APPDATA\Mozilla\Firefox\Profiles"
$ZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"
$POWERSHELL_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowerShell"


if ( !(Test-Path $CONFIG_DESTINATION_FOLDER -PathType Container) ) {
    mkdir $CONFIG_DESTINATION_FOLDER
}


# POLICY
Get-PolicyFileEntry -Path $MACHINE_POLICIE_FILE -All | Export-Clixml $CONFIG_DESTINATION_FOLDER\MachineRegistryPol.xml
Get-PolicyFileEntry -Path $USER_POLICIE_FILE -All | Export-Clixml $CONFIG_DESTINATION_FOLDER\UserRegistryPol.xml
$RESULT += "[X] Policies expoted"


# POWERSHELL
if ( Test-Path $POWERSHELL_USER_PROFILE_FOLDER){ 
    copy $POWERSHELL_USER_PROFILE_FOLDER\ $CONFIG_DESTINATION_FOLDER\ -Recurse -Force -ErrorAction SilentlyContinue 
    $RESULT += "[X] Powershell User Profile expoted"
} else { $RESULT += "[ ] Powershell User Profile not found" }


# GIT
foreach ($path in $GIT_CONFIG_FILES) {
    mkdir $CONFIG_DESTINATION_FOLDER\git\ -ErrorAction SilentlyContinue > $null
    if ( Test-Path $path ) {
        copy $path $CONFIG_DESTINATION_FOLDER\git\
    }
}
$RESULT += "[X] GIT Configs exported"

# NOTEPAD++
if ( Test-Path $NOTEPAD_PP_CONFIG_FODLER){ 
    copy $NOTEPAD_PP_CONFIG_FODLER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
    
    $RESULT += "[X] NOTEPAD++ Configs exported"
} else { $RESULT += "[ ] NOTEPAD++ not installed" }


# 7-ZIP
if ( Test-Path $ZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:") ) { 
    reg export $ZIP7_CONFIG_REGISTRY "$CONFIG_DESTINATION_FOLDER\7zip.reg" /y > $null
    
    $RESULT += "[X] 7-ZIP registry file exported"
} else { $RESULT += "[ ] 7-ZIP++ not installed" }


# JDOWNLOADER
if ( Test-Path $JDOWNLOADER_CONFIG_FOLDER){
    copy $JDOWNLOADER_CONFIG_FOLDER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
    
    $RESULT += "[X] JDownloader cfg Folder exported"
} else { $RESULT += "[ ] JDownloader not installed" }


# FIREFOX
$firefox_profile_folders = @(Get-ChildItem -Path $FIREFOX_CONFIG_FOLDER)
if ( $firefox_profile_folders.Length -gt 0 ) {
    foreach ($profile in $firefox_profile_folders) {
        if ($profile -match "default-release") {
            Write-Host "copying $profile to $CONFIG_DESTINATION_FOLDER ..."
            copy $FIREFOX_CONFIG_FOLDER\$profile\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
        
            $RESULT += "[X] Firefox profile exported"
        }
    }
} else { $RESULT += "[ ] Firefox not installed" }


# SYNCTHING
$SYNCTRAYZOR_CONFIG_FILE = "$env:APPDATA\SyncTrayzor\config.xml"
$SYNCTHING_CONFIG_FILE_1 = "$env:LOCALAPPDATA\Syncthing\config.xml"
#$SYNCTHING_CONFIG_FILE_2 = "$env:LOCALAPPDATA\Syncthing\config.xml.v36"
$SYNCTHING_CONFIG_FILE_3 = "$env:LOCALAPPDATA\Syncthing\key.pem"
$SYNCTHING_CONFIG_FILE_4 = "$env:LOCALAPPDATA\Syncthing\cert.pem"

if ( (Test-Path $SYNCTRAYZOR_CONFIG_FILE) -and
     (Test-Path $SYNCTHING_CONFIG_FILE_1) -and
     (Test-Path $SYNCTHING_CONFIG_FILE_3) -and
	 (Test-Path $SYNCTHING_CONFIG_FILE_4)){

    copy $SYNCTRAYZOR_CONFIG_FILE $CONFIG_DESTINATION_FOLDER\synctrayzor_config.xml
    copy $SYNCTHING_CONFIG_FILE_1 $CONFIG_DESTINATION_FOLDER
#    copy $SYNCTHING_CONFIG_FILE_2 $CONFIG_DESTINATION_FOLDER
    copy $SYNCTHING_CONFIG_FILE_3 $CONFIG_DESTINATION_FOLDER
    copy $SYNCTHING_CONFIG_FILE_4 $CONFIG_DESTINATION_FOLDER
    
    $RESULT += "[X] Syncthing exported"
} else { $RESULT += "[ ] Syncthing not installed" }


# END
Write-Host "--------------------------------"
$RESULT