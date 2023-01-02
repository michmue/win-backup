<# TODO's CLEANUP

    AUTOSTART
        msconfig
        autostart & common autostart?
        autoruns?
        schdtsk


    CONTEXT MENU
        shell & shellex nirsoft


    DISM
        drive properties cleanup
		drive properties as admin
        see @KNOWLEDGE


    ONE_DRIVE
        uninstall
        autostart


    clear c:\windows\servicing\LCU
	clear c:\windows\SoftwareDistribution


    REMOVE-PROVISIONEDAPPPACKAGE (& FOR NEW USERS)
		Remove-AppxPackage
		Remove-AppPackage
			-AllUsers
			cortana
			Microsoft.BingWeather
			Microsoft.GetHelp
			Microsoft.Microsoft3DViewer
			Microsoft.XboxApp
			Microsoft.Photos
			Microsoft.WindowsFeedbackHub
			Microsoft.ScreenSketch
			Microsoft.Office.OneNote
			Microsoft.Getstarted
			Microsoft.MicrosoftOfficeHub
			Microsoft.MicrosoftSolitaireCollection
			Microsoft.MicrosoftStickyNotes

    windows metro features cleanup
#>

$foldersToClean = @(
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

function main() {
    Invoke-GuidedFolderCleaning @$foldersToClean
}

main

function Invoke-GuidedFolderCleaning ([string[]] $folderPaths) {

    foreach ($path in $folderPaths) {

        Start-Process explorer.exe $path

        echo "Manuel cleaning of your folder $path" > $env:tmp\guide.txt
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