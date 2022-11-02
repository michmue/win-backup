param(
	[Switch]$UseDisabledDriverPOL,
	[Switch]$UseNotepadPlusPlus,
	[Switch]$UseJDownloader,
	[Switch]$UseFirefox,
	[Switch]$UsePowershell,
	[Switch]$UseZIP7,
	[Switch]$UseGit,
	[Switch]$UsePolicy,
	[Switch]$UseSyncthing,
	[Switch]$DisableAll,
	[Switch]$EnableAll
)

if ($DisableAll) {
	$UseNotepadPlusPlus = $false
	$UseJDownloader = $false
	$UseFirefox = $false
	$UsePowershell = $false
	$UseZIP7 = $false
	$UseGit = $false
	$UseSyncthing = $false
	$UsePolicy = $false
}

if ($EnableAll) {
	$UseNotepadPlusPlus = $true
	$UseJDownloader = $true
	$UseFirefox = $true
	$UsePowershell = $true
	$UseZIP7 = $true
	$UseGit = $true
	$UseSyncthing = $true
	$UsePolicy = $true
}

$CONFIG_DESTINATION_FOLDER = Read-Host -Prompt "Path where to save the configs"
$RESULT = @()

$MACHINE_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\Registry.pol"
$USER_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\User\Registry.pol"

$GIT_CONFIG_FILES = @(
    "$env:USERPROFILE\.gitconfig",
    "$env:USERPROFILE\.bash_history",
    "$env:USERPROFILE\.minttyrc",
    "$env:USERPROFILE\.inputrc"
    "$env:USERPROFILE\.bash_profile"
);


$NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"
$JDOWNLOADER_CONFIG_FOLDER = "$env:LOCALAPPDATA\JDownloader\cfg"
$FIREFOX_CONFIG_FOLDER = "$env:APPDATA\Mozilla\Firefox\Profiles"
$ZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"
$POWERSHELL_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowerShell"


if ( !(Test-Path $CONFIG_DESTINATION_FOLDER -PathType Container) ) {
    mkdir $CONFIG_DESTINATION_FOLDER
}


# POLICY
if ($UsePolicy) {
	copy $MACHINE_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\Machine_DisableDriver.pol
	copy $MACHINE_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\Machine.pol
	copy $USER_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\User.pol	
	$RESULT += "[X] Policies expoted"
}


# POWERSHELL
if ($UsePowershell) {
	if ( Test-Path $POWERSHELL_USER_PROFILE_FOLDER){ 
		copy $POWERSHELL_USER_PROFILE_FOLDER\ $CONFIG_DESTINATION_FOLDER\ -Recurse -Force -ErrorAction SilentlyContinue 
		$RESULT += "[X] Powershell User Profile expoted"
	} else { $RESULT += "[ ] Powershell User Profile not found" }
}


# GIT
if ($UseGit) {
	foreach ($path in $GIT_CONFIG_FILES) {
		mkdir $CONFIG_DESTINATION_FOLDER\git\ -ErrorAction SilentlyContinue > $null
		if ( Test-Path $path ) {
			copy $path $CONFIG_DESTINATION_FOLDER\git\
		}
	}
	$RESULT += "[X] GIT Configs exported"
}


# NOTEPAD++
if ($UseNotepadPlusPlus) {
	if ( Test-Path $NOTEPAD_PP_CONFIG_FODLER){ 
		copy $NOTEPAD_PP_CONFIG_FODLER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
		
		$RESULT += "[X] NOTEPAD++ Configs exported"
	} else { $RESULT += "[ ] NOTEPAD++ not installed" }
}


# 7-ZIP
if ($UseZIP7) {
	if ( Test-Path $ZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:") ) { 
		reg export $ZIP7_CONFIG_REGISTRY "$CONFIG_DESTINATION_FOLDER\7zip.reg" /y > $null
		
		$RESULT += "[X] 7-ZIP registry file exported"
	} else { $RESULT += "[ ] 7-ZIP++ not installed" }
}


# JDOWNLOADER
if ($UseJDownloader) {
	if ( Test-Path $JDOWNLOADER_CONFIG_FOLDER){
		copy $JDOWNLOADER_CONFIG_FOLDER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
		
		$RESULT += "[X] JDownloader cfg Folder exported"
	} else { $RESULT += "[ ] JDownloader not installed" }
}


# FIREFOX
if ($UseFirefox) {
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
}


# SYNCTHING
if ($UseSyncthing) {
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
}


# END
Write-Host "--------------------------------"
$RESULT