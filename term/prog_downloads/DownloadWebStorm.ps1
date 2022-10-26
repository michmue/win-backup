$releases = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=WS"
$release = ($releases.WS | ? type -Match "release")[0]
$url = $release.downloads.windows.link
$file = $url.Split("/") | select -Last 1

#$ProgressPreference = 'SilentlyContinue'
#Invoke-WebRequest -Uri $url -OutFile $PSScriptRoot/goland-$version.exe
#Start-BitsTransfer -Source $url -Destination $PSScriptRoot/goland-$version-2.exe
#$wc = New-Object net.webclient
#$wc.Downloadfile($url, "$PSScriptRoot/$file")

$mil = (Date).Millisecond
$sec = (Date).Second
$job_name = "$file_$sec_$mil"

bitsadmin.exe /transfer $job_name /download /priority foreground /dynamic $url $PSScriptRoot/$file