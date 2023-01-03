Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Import-Module .\Win-Backup -Force


Get-WBPrograms | ? Name -eq ([Programs]::ZIP7) | Install-WBProgram
