$releases = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products?code=PCP"
$release = ($releases.releases | ? type -Match "release")[0]
$url = $release.downloads.windows.link
$file = $url.Split("/") | select -Last 1

#$ProgressPreference = 'SilentlyContinue'
#Invoke-WebRequest -Uri $url -OutFile $PSScriptRoot/goland-$version.exe
#Start-BitsTransfer -Source $url -Destination $PSScriptRoot/goland-$version-2.exe
$wc = New-Object net.webclient
$wc.Downloadfile($url, "$PSScriptRoot/$file")