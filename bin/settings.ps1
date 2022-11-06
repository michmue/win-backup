<# TODO's DEFAULT SETTINGS

    TIMELINE WIN+TAB DISABLE

    explorer options view (Ansicht) setting: 
        %windir%\system32\rundll32.exe shell32.dll,Options_RunDLL 7

    REMOTE DESKTOP
        start C:\Windows\System32\sysdm.cpl -ArgumentList ",5"
        disable remote assistant
        enable + net login

    FOLDER OPTIONS
        this pc (quick access)
        view hidden
        view ext
        search for folder detail view in gpo or registry
            remove grouping (downloads etc. ?)
            right click customize folder
            for each folder in c:root
            

    mouse accel


    pc name & group
			
    
    NETWORK SETTINGS
        private network
        network name
        sharing center
            disable auto add network devices

    
    [TIME ZONE]
        list seperator: ;
        date with dot
        apply system wide

    
    power options: disable fast startup?
            
#>
 
<# TODO's: METRO SETTINGS

    SHOW-WINDOWSDEVELOPERLICENSEREGISTRATION

    UWP: https://learn.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
    https://4sysops.com/wiki/list-of-ms-settings-uri-commands-to-open-specific-settings-in-windows-10/

    sign in option: never (win+l works); ms-settings:signinoptions
    
    DEFENDER
        disable cloud delivery
        disable automatic sample submission		
        dismiss yellow icon
        reputaion based protection?
        
    SETTINGS 
        IGNORE: DEVICES, PHONE, NETWORK & INTERNET, TIME & LANGUAGE, EASE OF ACCESS
		
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
		
		focus assist: alarms only	
		multitasking: alt+tab (open windows only)
#>