# terminal commands

assoc | findstr /i "txtfile"

for /f "tokens=3 usebackq" %%a in (`reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" ^| findstr TEMP`)  do @echo System variable TEMP = %%a
for /f "tokens=3 usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Environment" ^| findstr TEMP`)  do @echo Current user variable TEMP = %%a

# autostart & autoend
- C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown
- C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup

- C:\Windows\System32\GroupPolicy\User\Scripts\Shutdown
- C:\Windows\System32\GroupPolicy\User\Scripts\Startup

- C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
- C:\Users\eno\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

# dism
dism set default apps ?
dism image mounts
dism wim commands?
 capture wim?
 doskey
 net
eventcreate
 fc
 find vs findstr
 fltMC
fodhelper.exe
 forfiles
 fsutil / diskpart	
 ftp

dism /online /cleanup-image /AnalyzeComponentStore
dism /online /cleanup-image /CleanupComponentStore
dism /online /Get-DefaultAppAssociations
	remove photo app powershell
	remove corona app
	remove your phone

 /Remove-ProvisionedAppxPackage - Removes app packages (.appx or .appxbundle)
                            from the image. App packages will not be installed
                            when new user accounts are created.

/Get-AppInfo            - Displays information about a specific installed MSI
                            application.
  /Get-Apps               - Displays information about all installed MSI
                            applications.
/Get-Packages           - Displays information about all packages in
                            the image.
 /Get-Capabilities       - Get capabilities in the image.
/Get-ReservedStorageState - Gets the current state of reserved storage.

/Get-DefaultAppAssociations