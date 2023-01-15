Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Remove-Module Backup -Force -ErrorAction SilentlyContinue
Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
Remove-Module Features -Force -ErrorAction SilentlyContinue
Remove-Module Programs -Force -ErrorAction SilentlyContinue

Import-Module .\Win-Backup -Force

#Get-WBPrograms | ? Name -eq ([Programs]::ZIP7) | Install-WBProgram
#Get-WBFeatures | ? Name -Match pol | Enable-WBFeature
#Invoke-Command -ScriptBlock $d.InstallCommand

#. .\Win-Backup\Backup\Utils.psm1
#Get-ContextMenuScreenshot

$config = Read-WBBackupConfig .\BackupConfig.json
Import-WBBackup2 $config



Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Remove-Module Backup -Force -ErrorAction SilentlyContinue
Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
Remove-Module Features -Force -ErrorAction SilentlyContinue
Remove-Module Programs -Force -ErrorAction SilentlyContinue