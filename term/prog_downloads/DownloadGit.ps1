$html = Invoke-WebRequest -Uri "https://git-scm.com/download/win" -UseBasicParsing
$downloadUrl = ($html.links | ? href -match "-64-bit.exe").href
$fileName = $downloadUrl.split("/") | select -last 1

$mil = (Date).Millisecond
$sec = (Date).Second
$job_name = "$fileName_$sec_$mil"

bitsadmin.exe /transfer $job_name /download /priority foreground /dynamic $downloadUrl $PSScriptRoot/$fileName