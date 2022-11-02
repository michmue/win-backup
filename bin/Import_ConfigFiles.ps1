param(
	[Switch]$UseDisabledDriverPOL,
	[Switch]$UseBasePOL,
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


#$CONFIG_SOURCE_FOLDER = Read-Host -Prompt "Path to configs"
$CONFIG_SOURCE_FOLDER = "d:\configs"
$RESULT = @()

$MACHINE_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\Registry.pol"
$MACHINE_TMP_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\_Registry.pol"
$MACHINE_DISABLEDDRIVERS_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\Machine_DisabledDriver.pol"
$USER_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\User\Registry.pol"

$UseGit_CONFIG_FILES = @(
    ".gitconfig",
    ".bash_history",
    ".minttyrc",
    ".inputrc"
    ".bash_profile"
);

$NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"
$UseJDownloader_CONFIG_FOLDER = "$env:LOCALAPPDATA\swJDownloader\cfg"
$UseFirefox_CONFIG_FOLDER = "$env:APPDATA\Mozilla\swFirefox\Profiles"
$UseZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"
$UsePowershell_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowershell"


if ( !(Test-Path $CONFIG_SOURCE_FOLDER -PathType Container) ) {
    Write-Host "Config folder not existing: $CONFIG_SOURCE_FOLDER"
    exit
}


# POLICY
if ($UsePolicy) {
	
	$bothFilesExisting = (((Test-Path $MACHINE_DISABLEDDRIVERS_POLICIE_FILE) -and (Test-Path $MACHINE_POLICIE_FILE)) -or
						  ((Test-Path $MACHINE_POLICIE_FILE) -and (Test-Path $MACHINE_TMP_POLICIE_FILE)))
	$isActiveDisabledDrivers = (Test-Path $MACHINE_TMP_POLICIE_FILE) -and ((Test-Path $MACHINE_POLICIE_FILE))
	$isActiveBasePol = (Test-Path $MACHINE_DISABLEDDRIVERS_POLICIE_FILE) -and ((Test-Path $MACHINE_POLICIE_FILE))
		
	$machine_policies_src = "$CONFIG_SOURCE_FOLDER" 
	$machine_disabledDriver_policies_src = "$CONFIG_SOURCE_FOLDER\Machine_DisabledDriver.pol" 
	$user_policies_src = "$CONFIG_SOURCE_FOLDER\User.pol" 

	
	echo "bothFilesExisting: $bothFilesExisting"
	echo "existing DisabledDriverPOL & existing BasePOL: $(((Test-Path $MACHINE_DISABLEDDRIVERS_POLICIE_FILE) -and (Test-Path $MACHINE_POLICIE_FILE)))"
	echo "existing BasePOL & existing TMPPOL: $(((Test-Path $MACHINE_POLICIE_FILE) -and (Test-Path $MACHINE_TMP_POLICIE_FILE)))"

	if ( !$bothFilesExisting ) {	
		if (Test-Path $machine_policies_src\Machine.pol) {
			
			if (!(Test-Path $MACHINE_POLICIE_FILE) -or !(Test-Path $MACHINE_TMP_POLICIE_FILE)) {
				copy $machine_policies_src\Machine.pol $MACHINE_POLICIE_FILE -Force	
				$RESULT += "[X] Base Machine Policies imported"
			} else {
				$RESULT += "[X] skip import _Registry Base Machine Policies existing"
			}
		}
		
		if (Test-Path $machine_policies_src\Machine_DisabledDriver.pol) {	
			
			if (!(Test-Path $MACHINE_DISABLEDDRIVERS_POLICIE_FILE) -and !(Test-Path $MACHINE_TMP_POLICIE_FILE)) {
				copy $machine_policies_src\Machine_DisabledDriver.pol $MACHINE_DISABLEDDRIVERS_POLICIE_FILE -Force
				$RESULT += "[X] Machine_DisabledDrivers Policies imported"
			} else {
				$RESULT += "[X] skip import _Registry Machine_DisabledDrivers Policies existing"
			}
			
		}
	}
	
	if (Test-Path $user_policies_src) {	
		copy $user_policies_src $USER_POLICIE_FILE -Force
		$RESULT += "[X] User Policies imported"
	}
	
	if ( $UseBasePOL -and $isActiveDisabledDrivers) {
		Rename-Item $MACHINE_POLICIE_FILE "Machine_DisabledDriver.pol"
		Rename-Item $MACHINE_TMP_POLICIE_FILE "Registry.pol"
	}
	
	if ( $UseDisabledDriverPOL -and !$isActiveDisabledDrivers) {
		Rename-Item $MACHINE_POLICIE_FILE "_Registry.pol"
		Rename-Item $MACHINE_DISABLEDDRIVERS_POLICIE_FILE "Registry.pol"
	}
		
	if ( (Test-Path $machine_policies_src) -or (Test-Path $user_policies_src)) {
		Write-Host "Force update of policies..."
		#gpupdate /Force 1>$null
	}
}

# swPowershell
if ($UsePowershell) {
	if ( Test-Path $UsePowershell_USER_PROFILE_FOLDER ) {
		copy $CONFIG_SOURCE_FOLDER\WindowsswPowershell\* $UsePowershell_USER_PROFILE_FOLDER  -Recurse -Force

		$RESULT += "[X] swPowershell User Profile imported"
	} else { $RESULT += "[ ] swPowershell User Profile not found" }
}

# GIT
if ($UseGit) {
	foreach ($file in $UseGit_CONFIG_FILES) {
		if ( Test-Path $CONFIG_SOURCE_FOLDER\git\$file ) {
			copy $CONFIG_SOURCE_FOLDER\git\$file $env:USERPROFILE
		}    
	}
	$RESULT += "[X] GIT Configs imported"
}

# NOTEPAD++
if ($UseNotepadPlusPlus) {
	if ( (Test-Path $NOTEPAD_PP_CONFIG_FODLER) -AND (Test-Path $CONFIG_SOURCE_FOLDER\Notepad++)){
		Write-Host "close your notepad++ ..."
		Get-Process | WHERE ProcessName -eq "notepad++" | Wait-Process
		copy $CONFIG_SOURCE_FOLDER\Notepad++\* $NOTEPAD_PP_CONFIG_FODLER -Recurse -Force    
		
		$RESULT += "[X] NOTEPAD++ Configs imported"
	} else { $RESULT += "[ ] NOTEPAD++ not installed" }
}


# 7-ZIP
if ($UseZIP7) {
	if ( (Test-Path $UseZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:")) -AND (Test-Path $CONFIG_SOURCE_FOLDER\7zip.reg)) { 
		reg import $CONFIG_SOURCE_FOLDER\7zip.reg 2>$null 

		$RESULT += "[X] 7-ZIP registry file imported"
	} else { $RESULT += "[ ] 7-ZIP++ not installed" }
}

# swJDownloader
if ($UseJDownloader) {
	if ( (Test-Path $UseJDownloader_CONFIG_FOLDER) -AND (Test-Path $CONFIG_SOURCE_FOLDER\cfg)){
		copy $CONFIG_SOURCE_FOLDER\cfg\* $UseJDownloader_CONFIG_FOLDER -Recurse -Force -ErrorAction SilentlyContinue
		
		$RESULT += "[X] swJDownloader cfg Folder imported"
	} else { $RESULT += "[ ] swJDownloader not installed" }
}

# swFirefox
if ($UseFirefox) {
	$UseFirefox_profile_folder = Get-ChildItem -Path $UseFirefox_CONFIG_FOLDER | WHERE name -Match default-release
	$cfg_swFirefox_profile_folder = Get-ChildItem -Path $CONFIG_SOURCE_FOLDER | WHERE name -Match default-release
	if (($UseFirefox_CONFIG_FOLDER -ne $null) -and ($cfg_swFirefox_profile_folder -ne $null)) {
		Write-Host "close your swFirefox..."
		Get-Process | WHERE ProcessName -eq swFirefox | Wait-Process
		Write-Host "copying $cfg_swFirefox_profile_folder to $UseFirefox_profile_folder"
		copy $CONFIG_SOURCE_FOLDER\$cfg_swFirefox_profile_folder\* $UseFirefox_CONFIG_FOLDER\$UseFirefox_profile_folder -Recurse -Force
		
		$RESULT += "[X] swFirefox profile imported"
	} else { $RESULT += "[ ] swFirefox not installed" }
}

# SYNCTHING
if ($UseSyncthing) {
	$SYNCTRAYZOR_CONFIG_FILE = "$env:APPDATA\SyncTrayzor\config.xml"
	$UseSyncthing_CONFIG_FILE_1 = "$env:LOCALAPPDATA\Syncthing\config.xml"
	#$UseSyncthing_CONFIG_FILE_2 = "$env:LOCALAPPDATA\Syncthing\config.xml.v36"
	$UseSyncthing_CONFIG_FILE_3 = "$env:LOCALAPPDATA\Syncthing\key.pem"
	$UseSyncthing_CONFIG_FILE_4 = "$env:LOCALAPPDATA\Syncthing\cert.pem"


	if ( (Test-Path $SYNCTRAYZOR_CONFIG_FILE) -and
		 (Test-Path $UseSyncthing_CONFIG_FILE_1) -and
		 (Test-Path $UseSyncthing_CONFIG_FILE_3) -and
		 (Test-Path $UseSyncthing_CONFIG_FILE_4)){

		copy $CONFIG_SOURCE_FOLDER\synctrayzor_config.xml $SYNCTRAYZOR_CONFIG_FILE
		copy $CONFIG_SOURCE_FOLDER\config.xml $UseSyncthing_CONFIG_FILE_1 
	#    copy $CONFIG_SOURCE_FOLDER\config.xml.v36 $UseSyncthing_CONFIG_FILE_2 
		copy $CONFIG_SOURCE_FOLDER\cert.pem $UseSyncthing_CONFIG_FILE_3 
		copy $CONFIG_SOURCE_FOLDER\key.pem $UseSyncthing_CONFIG_FILE_4
		
		$RESULT += "[X] Syncthing imported"
	} else { $RESULT += "[ ] Syncthing not installed" }
}

# END
Write-Host "--------------------------------"
$RESULT