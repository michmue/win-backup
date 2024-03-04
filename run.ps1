#Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
#Remove-Module Backup -Force -ErrorAction SilentlyContinue
#Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
#Remove-Module Features -Force -ErrorAction SilentlyContinue
#Remove-Module Programs -Force -ErrorAction SilentlyContinue

Import-Module .\Win-Backup

#Get-WBPrograms | ? Name -eq ([Programs]::ZIP7) | Install-WBProgram
#Get-WBFeature | ? Name -Match pol | Enable-WBFeature
#Invoke-Command -ScriptBlock $d.InstallCommand

#. .\Win-Backup\Backup\Utils.psm1
#Get-ContextMenuScreenshot

#$config = Read-WBBackupConfig .\BackupConfig.json
#Export-WBBackup -Path d:\confgis3New $config
Remove-WBDefaultPrograms


#Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
#Remove-Module Backup -Force -ErrorAction SilentlyContinue
#Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
#Remove-Module Features -Force -ErrorAction SilentlyContinue
#Remove-Module Programs -Force -ErrorAction SilentlyContinue