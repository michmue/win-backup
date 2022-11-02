# MAJOR / MILESTONE
4.0 GUI: hooks to add/skip features
3.0 Powershell Module
2.0 Guided Installation ?
1.0 Full Automation
0.X manuel execution of batch and reg files

# FEATURE
	- Annotations: Get-Contenct read Comments
		# @Deprecated
		function XYZ {}
		
		function Deprecated () {
			write-host "XYZ is Deprecated"
		}
		
		
	- CommandLines Design & Font & clink, evtl. posh?
	- License vaiolation, downloading required tools instead of binary integration
	- explorer search lag, GPO: Explorer, Index search?, Cloud Search?
		disable index search on file explorer?
	
	## CLEANUP
	- GUIDED
		VMs
		Downloads
		Documents
		c:\
		Pictures
		Public Folders?
		hidden users?
	
	- per user %tmp%
	
	- AUTOSTART
		msconfig
		autostart & common autostart?
		autoruns?
		schdtsk
	
	- shell & shellex nirsoft
	
	- dism
	- drive properties cleanup
		drive properties as admin
	
	- disable guest ?
		
	- ONE_DRIVE
	
	- c:\windows\servicing\LCU
	- c:\windows\SoftwareDistribution
		
	- !! Remove-ProvisionedAppPackage !! (for new users)
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


	- windows metro features cleanup

# IMPROVMENT	(TWEAK / SETTINGS)

	## BACKUP
	- export keys for programs
		office

		windows (slmgr /dli, nirsoft "produckey.exe")
			bios (empty if no bios entry)
				wmic path softwarelicensingservice get OA3xOriginalProductKey
				(Get-WmiObject -query ’select * from SoftwareLicensingService‘).OA3xOriginalProductKey
				
	- export & filter ENVS
	- export context menu screenshot (and new file tree)
	- download drivers
		bios
		
		lan realtek (lagging problems?!?!?!)
			https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
			manuel extraction ?
		
		chipset
		nvidea & driver cleaner
		unix xona dgx uni driver
	
	- script open folders to clean
		C:\term, C:\projects, C:\bin, C:\vm, C:\tools, C:\scripts, C:\code
		users folders
			look at C:\Users\eno
			look at C:\Users\Michi
			
			
	## INSTALLATION
	- disable driver installation (gpo & system gui)
	- disable auto add network devices
	- disable media streaming
	

	## PROGRAMS
	- nvidea 144hz
		switch audio again
	
	- sound (lag ?)
		disable front mic
		dgx default communication (already default?)
		
	- edge disable startup boost & background in system & performance)
		data protection delete on close enable all
		disable cookies & preloading
		Startpage & search & new tab
		do not track
		
	- Photo Viewer
		FastStone Image Viewer
		IrfanView 
		XnView MP
	
	- office
		backstage disable
		std. save to PC
		std. save place to "Eigene Dateien"
		std. personal templates "Eigene Dateien"
		disable adobe plugin
	
	- np++ n&np shortcuts for cmd (:ENVS)
		XML plugin toolbar icons
		Markdown plugin (hide sections) ?
	
	- VM default place & default config place to c:\vm, c:\vm configs
	
	- Windows Photo Viewer?
	
	- adobe
		cleanup bat file
		disable adobe plugin office
		acrobat
			fit page
			centimeter
			single page
	
	
	## WINDOWS
	- FOLDER OPTIONS
		this pc (quick access)
		view hidden
		view ext
		folder detail view gpo | registry
			remove grouping (downloads etc. ?)
			right click customize folder
			for each folder in c:root
	
	- user icons
		folder
		login
	
	- ENVS:
		JD2_HOME	C:\Users\eno\AppData\Local\JDownloader 2.0
		PIPENV_VENV_IN_PROJECT	1
		PATH: c:\term;c:\bin;c:\tools;
		PATHEXT: .LNK
		
		### METRO SETTINGS
		
		### GPO
		- disable OneDrive
		- PC Windows Update
			Do not include drivers with Windows Updates
			Select when Preview Builds and Feature Updates are received
			Select when Quality Updates are received
		

# FIX


notepad++ 

- gpo
	- Liste "Zuletzt hinzugefügt" aus dem Startmen+ entfernen
	- Maximale Wartezeit für Gruüüenrichlinienskripts angeben
	- windows defender antivirus | Ausschlüsse
	- standardmäßig indizierte pfade


- markdown: FileTypesMan || reg file

- passwordless login: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device
	- DevicePasswordLessBuildVersion DWORD 0 == Windows Hello Disabled
	=> netplwiz.exe "User must enter a user name"
- clean shell:common startup + programs
	- clean shell:startup + programs
	
- del Firefox Privater Modus
- show remote desktop settings: start C:\Windows\System32\sysdm.cpl -ArgumentList ",3"
	disable remote assistant
	- open all settings by script and open editor side by side with actions to take
	
	
- Show-WindowsDeveloperLicenseRegistration
- 7zip file manager replace lnk after icon change
	- replace files in C: by script
	
- del bin\hashlnk.exe (xMenu not used)
- all consoles same theme
- JDownloader2Setup_windows-x64_jre17.exe -varfile response.varfile -q -splash "Installiere JDownloader" -dir %localappdata%\JDownloader
- SyncTrazor / Syncthing
- Eigene Dateien
- Hide UserFolder regedit
	hide Shell Folders in Explorer & UserFolder?!?! https://www.winhelponline.com/blog/show-hide-shell-folder-namespace-windows-10/
- disable autostarts
	- teams
	- onedrive
	- edge
	- adobe updater startup utility
	- AGCInvokerUtility


# Customization

	## NORMAL SETTINGS
		mouse accel

		pc name & group
			
		network settings
			private network
			network name
			sharing center
				disable auto add network devices

		time zone
			list seperator: ;
			date with dot
			apply system wide

		power options: disable fast startup?

	## METRO SETTINGS (ignore: devices, Phone, network & internet, time & language, ease of access)
		Permission & History
		
		Update & Security
			disable delivery optimization
			Developer Settings
		
		Personalization (all)
			color
			lock screen disable pic
			start menu
				disable recently
				disable jump lists
				show only settings
			taskbar
				remove search & etc
				replace powershell
				hide badges
				notification area
					show defender
					disable input indicator
					disable action center
			
			
		System
			notifications

			
		Search
			SafeSearch off
			cloud content search all off
		

		xbox game bar
		

		defender
			disable cloud delivery
			disable automatic sample submission		
			dismiss yellow icon
			reputaion based protection?


		focus assist: alarms only	
		multitasking: alt+tab (open windows only)



# MISC
xmenu
destructive naming convetion (remove vs disable)
Customize Places Bar Open/Save Dialog Box by regedit
	https://www.howtogeek.com/97824/how-to-customize-the-file-opensave-dialog-box-in-windows/

adobe pdf printer
	remove printer first
	precracked acrobat?
	free acroat dc?

# ICON's
icon for fileext & filetype
- .md
- .xml
- .json

# CMD's
backup  users, c:\ & etc. folders
extract single file from zip


# Programs
HxD

# CMD's
backup  users, c:\ & etc. folders

