function Export-WBBackup {
    param(
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

    <#
        VSCode
    #>
    Write-Host "VSCode missing" -ForegroundColor Red


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


    if ( !(Test-Path $CONFIG_DESTINATION_FOLDER -PathType Container) ) {
        mkdir $CONFIG_DESTINATION_FOLDER
    }


    # POLICY
    if ($UsePolicy) {
        $MACHINE_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\Machine\Registry.pol"
        $USER_POLICIE_FILE = "$env:systemroot\system32\GroupPolicy\User\Registry.pol"

        copy $MACHINE_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\Machine_DisableDriver.pol
        copy $MACHINE_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\Machine.pol
        copy $USER_POLICIE_FILE $CONFIG_DESTINATION_FOLDER\User.pol
        $RESULT += "[X] Policies expoted"
    }


    # POWERSHELL
    if ($UsePowershell) {
        $POWERSHELL_USER_PROFILE_FOLDER = [environment]::getfolderpath("mydocuments")+"\WindowsPowerShell"

        if ( Test-Path $POWERSHELL_USER_PROFILE_FOLDER){
            copy $POWERSHELL_USER_PROFILE_FOLDER\ $CONFIG_DESTINATION_FOLDER\ -Recurse -Force -ErrorAction SilentlyContinue
            $RESULT += "[X] Powershell User Profile expoted"
        } else { $RESULT += "[ ] Powershell User Profile not found" }
    }


    # GIT
    if ($UseGit) {
        $GIT_CONFIG_FILES = @(
            "$env:USERPROFILE\.gitconfig",
            "$env:USERPROFILE\.bash_history",
            "$env:USERPROFILE\.minttyrc",
            "$env:USERPROFILE\.inputrc"
            "$env:USERPROFILE\.bash_profile"
        );

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
        $NOTEPAD_PP_CONFIG_FODLER = "$env:APPDATA\Notepad++"

        if ( Test-Path $NOTEPAD_PP_CONFIG_FODLER){
            copy $NOTEPAD_PP_CONFIG_FODLER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue

            $RESULT += "[X] NOTEPAD++ Configs exported"
        } else { $RESULT += "[ ] NOTEPAD++ not installed" }
    }


    # 7-ZIP
    if ($UseZIP7) {
        $ZIP7_CONFIG_REGISTRY = "HKCU\Software\7-zip"

        if ( Test-Path $ZIP7_CONFIG_REGISTRY.Replace("HKCU\","HKCU:") ) {
            reg export $ZIP7_CONFIG_REGISTRY "$CONFIG_DESTINATION_FOLDER\7zip.reg" /y > $null

            $RESULT += "[X] 7-ZIP registry file exported"
        } else { $RESULT += "[ ] 7-ZIP++ not installed" }
    }


    # JDOWNLOADER
    if ($UseJDownloader) {
        $JDOWNLOADER_CONFIG_FOLDER = "$env:LOCALAPPDATA\JDownloader\cfg"

        if ( Test-Path $JDOWNLOADER_CONFIG_FOLDER){
            copy $JDOWNLOADER_CONFIG_FOLDER\ $CONFIG_DESTINATION_FOLDER -Recurse -Force -ErrorAction SilentlyContinue

            $RESULT += "[X] JDownloader cfg Folder exported"
        } else { $RESULT += "[ ] JDownloader not installed" }
    }


    # FIREFOX
    if ($UseFirefox) {
        $FIREFOX_CONFIG_FOLDER = "$env:APPDATA\Mozilla\Firefox\Profiles"

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
}

$CONFIG_DESTINATION_FOLDER = "d:\configsNew"
function Export-WBBackup2 ($appConfigs) {
    foreach ($appConfig in $appConfigs) {

        foreach ($folder in $appConfig.Folders) {
            if (-Not $folder) { continue; }

            $folder = $ExecutionContext.InvokeCommand.ExpandString($folder)
            if (Test-Path -Path $folder -PathType Container) {
                Write-Host "copy folder: $folder"
                $dirDestination = "$CONFIG_DESTINATION_FOLDER/$($appConfig.Name)"
                mkdir $dirDestination -Force > $null
                copy $folder/* "$CONFIG_DESTINATION_FOLDER/$($appConfig.Name)/" -Recurse -Force -ErrorAction Continue
            }
        }


        foreach ($file in $appConfig.Files) {
            if (-Not $file) { continue; }

            $file = $ExecutionContext.InvokeCommand.ExpandString($file)
            if (Test-Path -Path $file -PathType Leaf) {
                Write-Host "copy file: $file"

                $fileName = Split-Path -Path $file -Leaf
                $newItemPath = "$CONFIG_DESTINATION_FOLDER/$($appConfig.Name)/$fileName"
                New-Item -Path $newItemPath -ItemType File -Force > $null

                copy $file $newItemPath -Force -ErrorAction Continue
            }
        }


        # FEAT: add export regValue similar to regTree
        # FEAT: add export regKey similar to regTree
        foreach ($regTree in $appConfig.RegistryTrees) {
            if (-Not $regTree) { continue; }

            $regTree = $ExecutionContext.InvokeCommand.ExpandString($regTree)

            if (Test-Path $regTree -PathType Container) {
                $regTree = $regTree -replace ":", "\" -replace "/", "\"

                $dirDestination = "$CONFIG_DESTINATION_FOLDER\$($appConfig.Name)"
                mkdir $dirDestination -Force > $null

                reg export $regTree "$dirDestination\$($appConfig.Name).reg" /y > $null
            }
        }
    }
}

function Read-WBBackupConfig {
    [CmdletBinding()]
    param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "File or folder does not exist"
            }
            if ($_ -notmatch "\.json$") {
                throw "The file specified in the path argument must end with .json"
            }
            return $true
        })]
        $Path
    )

    $config = Get-Content -Path $Path | ConvertFrom-Json
    return $config
}


Export-ModuleMember -Function Export-WBBackup, Read-WBBackupConfig, Export-WBBackup2