<# FEATURES: BACKUP

    INTERNET EXPLORER
        backup ie settings needed for -UseBasicParsing

    GPO
        Liste "Zuletzt hinzugefügt" aus dem Startmenü entfernen
        Maximale Wartezeit für Scripts | Gruppenrichlinienskripts angeben
        windows defender antivirus | Ausschlüsse
        standardmäßig indizierte pfade
        disable guest?

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