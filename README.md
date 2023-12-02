# win-backup tool
Big windows updates often override my registry tweaks or other windows settings.
Full backups are therefore suboptimal for my personal usage.
This tool will create a backup of all my config files.
After that I reinstall windows with the newest ISO file available.

Then multible scripts will clean windows apps (folders, shortcuts, start menu etc.), download and install all my needed programs, import registry tweaks, set my preferred windows settings and create my default folders.

## usage
Before windows reinstall export the configs:
```powershell
Import-Module .\Win-Backup -Force

$config = Read-WBBackupConfig .\BackupConfig.json
Export-WBBackup -Path d:\backup $config
```

After reinstall of windows:
```powershell
# not implemented
Invoke-WBFolderCleaning

# Install features like Hyper-V & dotNet Framework
Get-WBFeatures | Enable-WBFeature

# Add registry tweaks: file explorer hide specific folder which I don't use (Documents, 3D Objets, Music...)
Get-WBTweak | Enable-WBTweak

# Downloads my programs (installtion still missing)
Get-WBPrograms | Install-WBProgram
```
