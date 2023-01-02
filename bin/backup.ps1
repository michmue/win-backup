<# FEATURES: BACKUP

    INTERNET EXPLORER
        backup ie settings needed for -UseBasicParsing

    GPO
        Liste "Zuletzt hinzugefügt" aus dem Startmenü entfernen
        Maximale Wartezeit für Scripts | Gruppenrichlinienskripts angeben
        windows defender antivirus | Ausschlüsse
        standardmäßig indizierte pfade
        disable guest?
        SEARCH INDEX
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search\CurrentPolicies\DefaultIndexedPaths]
            "C:\\projects\\"="C:\\projects\\"
            "C:\\tools\\"="C:\\tools\\"
            "C:\\term\\"="C:\\term\\"
            "C:\\bin\\"="C:\\bin\\"
            [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search\DefaultIndexedPaths]
            "C:\\projects\\"="C:\\projects\\"
            "C:\\tools\\"="C:\\tools\\"
            "C:\\term\\"="C:\\term\\"
            "C:\\bin\\"="C:\\bin\\"

            ; EXCLUDES
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search\CurrentPolicies\DefaultExcludedPaths]
            "C:\\tools\\*\\**"="C:\\tools\\*\\**"
            [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search\DefaultExcludedPaths]
            "C:\\tools\\*\\**"="C:\\tools\\*\\**"

            *.git ?


    EXPORT KEYS FOR PROGRAMS
		office

		windows (slmgr /dli, nirsoft "produckey.exe")
			bios (empty if no bios entry)
				wmic path softwarelicensingservice get OA3xOriginalProductKey
				(Get-WmiObject -query ’select * from SoftwareLicensingService‘).OA3xOriginalProductKey


    export & filter ENVS


    export context menu screenshot (and new file tree)


    OPEN FOLDERS TO CLEAN
		C:\term
        C:\bin
        C:\tools
        C:\scripts
        C:\code

#>

<# IMPROVMENTs: BACKUP

    GPO POLICYDEFINITIONS
        remvoe unused policy definitions to find needed keys quicker in gpedit.msc
        rsop.msc gpedit with chanced values only?, use to copy to new installation and manuel active needed policies
#>

$foldersToClean = @(
    $env:APPDATA
    $env:LOCALAPPDATA
    $env:USERPROFILE
    "C:\projects"
    "C:\vm"
)
#Add-Type -AssemblyName System.Windows.Forms

# sleep 1
#[System.Windows.Forms.Sendkeys]::SendWait("^({ESC})")
# sleep 1
# exit


function Get-Screenshot($path) {
    $size = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
    $bounds = [Drawing.Rectangle]::FromLTRB(0, 0, $size.width, $size.height)
    $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
    $graphics = [Drawing.Graphics]::FromImage($bmp)

    $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

    $bmp.Save($path)

    $graphics.Dispose()
    $bmp.Dispose()
}


$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$Mouse = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru
[system.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
function Get-ContextMenuScreenshot ([Switch]$ExtendedContexMenu) {
    $size = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
    $width = $size.width
    $height = $size.height
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($width, $height)

    # IMPR: shift for extended Context Menu: https://stackoverflow.com/questions/11071781/holding-shift-while-clicking
    $Mouse::mouse_event(0x00000002, 0, 0, 0, 0);
    $Mouse::mouse_event(0x00000004, 0, 0, 0, 0);

    sleep -Milliseconds 200
    # Write-Host $size
    # Write-Host "($size.width/2)"
    # Write-Host ($size.height/2)
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($width/2, $height*0.95)
    $Mouse::mouse_event(0x00000008, 0, 0, 0, 0);
    $Mouse::mouse_event(0x00000010, 0, 0, 0, 0);

    sleep -Milliseconds 200
    [System.Windows.Forms.Sendkeys]::SendWait("n")

    sleep -Milliseconds 500
    #[System.Windows.Forms.Sendkeys]::SendWait("{PrtSc}")
    Get-Screenshot "$PSScriptRoot\d2.png"
}

Get-ContextMenuScreenshot

exit

function main {
    echo "1. downloading drivers"
    downloadDrivers

    echo "2. Copying Configs"
    & $PSScriptRoot\backup_export.ps1 -EnableAll

    echo "3. Cleaning Folders"
    Invoke-GuidedFolderCleaning $foldersToClean
    echo "Check Folders for new Configs (Profile/Roaming/LocalAppData/Programs/etc...)"
    Pause
}

main


function downloadDrivers {
    . $PSScriptRoot\programs.ps1

    downloadDriver ([DriverType]::BIOS)
    # HINT: manuel download above at BIOS website
    # downloadDriver ([DriverType]::CHIPSET)
    # downloadDriver ([DriverType]::AUDIO_INTERN)
    downloadDriver ([DriverType]::LAN_REALTEK)
    downloadDriver ([DriverType]::NVIDIA)
    downloadDriver ([DriverType]::AUDIO_UNIX_XONAR)
}


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