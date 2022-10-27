#$CONFIG_DESTINATION_FOLDER = Read-Host -Prompt "Path where to save the configs"
$CONFIG_DESTINATION_FOLDER = "d:\configs"
Write-Host "TODO: switch to ask for folder"


$GIT_CONFIG_FILES = @(
    "$env:USERPROFILE\.gitconfig",
    "$env:USERPROFILE\.bash_history",
    "$env:USERPROFILE\.minttyrc",
    "$env:USERPROFILE\.inputrc"
    "$env:USERPROFILE\.bash_profile"
);


$NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"
$JDOWNLOADER_CONFIG_FOLDER = "$env:ProgramFiles\JDownloader4\cfg"
$FIREFOX_CONFIG_FOLDER = "$env:APPDATA\Mozilla\Firefox\Profiles"
$ZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"
$POWERSHELL_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowerShell"


if ( !(Test-Path $CONFIG_DESTINATION_FOLDER -PathType Container) ) {
    mkdir $CONFIG_DESTINATION_FOLDER
}

if ( Test-Path $POWERSHELL_USER_PROFILE_FOLDER){ 
    copy $POWERSHELL_USER_PROFILE_FOLDER $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
}

foreach ($path in $GIT_CONFIG_FILES) {
    mkdir $CONFIG_DESTINATION_FOLDER\git\ -ErrorAction SilentlyContinue
    if ( Test-Path $path ) {
        copy $path $CONFIG_DESTINATION_FOLDER\git\
    }
}

if ( Test-Path $NOTEPAD_PP_CONFIG_FODLER){ 
    copy $NOTEPAD_PP_CONFIG_FODLER $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue 
}

if ( Test-Path $ZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:") ) { 
    reg export $ZIP7_CONFIG_REGISTRY "$CONFIG_DESTINATION_FOLDER\7zip.reg" /y > $null
}

if ( Test-Path $JDOWNLOADER_CONFIG_FOLDER){
    copy $JDOWNLOADER_CONFIG_FOLDER $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue
}


$firefox_profile_folders = Get-ChildItem -Path $FIREFOX_CONFIG_FOLDER
foreach ($profile in $firefox_profile_folders) {
    if ($profile -match "default-release") {
        Write-Host "copying $profile to $CONFIG_DESTINATION_FOLDER ..."
        #copy $FIREFOX_CONFIG_FOLDER\$profile $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue
    }
}