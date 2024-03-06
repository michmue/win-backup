Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Remove-Module Backup -Force -ErrorAction SilentlyContinue
Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
Remove-Module Features -Force -ErrorAction SilentlyContinue
Remove-Module Programs -Force -ErrorAction SilentlyContinue

Import-Module .\Win-Backup

Get-WBProgram firefox | Install-WBProgram