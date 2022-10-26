$url = "https://download.scdn.co/SpotifySetup.exe"
$file = "SpotifySetup.exe"

$wc = New-Object net.webclient 
$wc.Downloadfile($url, "$PSScriptRoot/$file")