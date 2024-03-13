Remove-Module .\Win-Backup -Force -ErrorAction SilentlyContinue
Import-Module .\Win-Backup -Force


Get-WBProgram JDOWNLOADER | Install-WBProgram
# Get-WBProgram ZIP7 | Install-WBProgram
# Get-WBProgram GIT | Install-WBProgram
# Get-WBProgram NOTEPAD_PLUS_PLUS | Install-WBProgram
# Get-WBProgram PAINTNET | Install-WBProgram
# Get-WBProgram VLCPLAYER | Install-WBProgram
# Get-WBProgram SYNCTHING | Install-WBProgram

Remove-Module .\Win-Backup -Force -ErrorAction SilentlyContinue

