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


    EXPORT KEYS FOR PROGRAMS
		office

		windows (slmgr /dli, nirsoft "produckey.exe")
			bios (empty if no bios entry)
				wmic path softwarelicensingservice get OA3xOriginalProductKey
				(Get-WmiObject -query ’select * from SoftwareLicensingService‘).OA3xOriginalProductKey


    export & filter ENVS


    export context menu screenshot (and new file tree)


    DOWNLOAD DRIVERS
		bios

		lan realtek (lagging problems?!?!?!)
			https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
			manuel extraction ?

		chipset
		nvidea & driver cleaner
		unix xona dgx uni driver
        motherboard intern sound driver

	OPEN FOLDERS TO CLEAN
		C:\term, C:\projects, C:\bin, C:\vm, C:\tools, C:\scripts, C:\code
		users folders
			look at C:\Users\eno
			look at C:\Users\Michi

#>

<# IMPROVMENTs: BACKUP

    GPO POLICYDEFINITIONS
        remvoe unused policy definitions to find needed keys quicker in gpedit.msc
        rsop.msc gpedit with chanced values only?, use to copy to new installation and manuel active needed policies
#>

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

Invoke-GuidedFolderCleaning @(
    "C:\projects",
    "C:\vm"
)