Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Remove-Module Backup -Force -ErrorAction SilentlyContinue
Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
Remove-Module Features -Force -ErrorAction SilentlyContinue
Remove-Module Programs -Force -ErrorAction SilentlyContinue

Import-Module .\Win-Backup -Force
# $d = Get-Content .\Win-Backup\Tweaks\tweaks.json | ConvertFrom-Json
# $prop = ($d.Keys.Properties | ? { $_.Type -eq "DWord" })[0]
#Set-ItemProperty -Path "HKCU:/Software/1My" -Type Boolean -Name $prop.Name -Value $prop.Value

(Get-WBTweak -Name *powershell*)

#Get-ValueKind $key.key $key.Properties[0].Name

Remove-Module Win-Backup -Force -ErrorAction SilentlyContinue
Remove-Module Backup -Force -ErrorAction SilentlyContinue
Remove-Module Cleanup -Force -ErrorAction SilentlyContinue
Remove-Module Features -Force -ErrorAction SilentlyContinue
Remove-Module Programs -Force -ErrorAction SilentlyContinue