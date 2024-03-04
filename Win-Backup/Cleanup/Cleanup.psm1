using module .\Cleanup-Programs.psm1

$FOLDERS_TO_CLEAN = @(
    "shell:common startup"
    "shell:startup"
    "shell:common programs"
    "shell:programs"
    "$env:USERPROFILE\Downloads"
    "$env:USERPROFILE\Documents"
    "$env:USERPROFILE\Prictures"
    "c:\"
    "$env:TMP"
)

function Invoke-WBFolderCleaning () {
    Invoke-GuidedFolderCleaning $FOLDERS_TO_CLEAN
}

function Invoke-GuidedFolderCleaning ([string[]] $folderPaths) {

    foreach ($path in $folderPaths) {

        Start-Process explorer.exe $path

        echo "Clean manual: $path"
        echo "Clean manual: $path" > $env:tmp\guide.txt
        notepad.exe "$env:tmp\guide.txt"
        sleep 1
        Wait-ProcessTitle ($path.Split("\") | Select -Last 1)
    }
}

function Wait-ProcessTitle ($title) {
    while ( @(Get-Process explorer | ? MainWindowTitle -eq $title).length -ne 0 ) {
        Sleep -Seconds 0.5
    }
}