$html = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
$latestAsset = ($html.assets | ? browser_download_url -match ".Installer.x64.exe$")
$fileName = $latestAsset.name # npp.8.3.Installer.x64.exe
$downloadUrl = $latestAsset.browser_download_url

$mil = (Date).Millisecond
$sec = (Date).Second
$job_name = "$fileName_$sec_$mil"

bitsadmin.exe /transfer $job_name /download /priority foreground /dynamic $downloadUrl $PSScriptRoot/$fileName