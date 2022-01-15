$releases_url = "https://data.services.jetbrains.com/products/releases?code=GO"
		
$releases = Invoke-RestMethod -uri "$($releases_url)"
$release = ($releases.GO | ? type -Match "release")[0]
$url = $release.downloads.windows.link
$version = $release.version	

#$ProgressPreference = 'SilentlyContinue'
#Invoke-WebRequest -Uri $url -OutFile $PSScriptRoot/goland-$version.exe
#Start-BitsTransfer -Source $url -Destination $PSScriptRoot/goland-$version-2.exe
$wc = New-Object net.webclient
$wc.Downloadfile($url, "$PSScriptRoot/goland-$version.exe")