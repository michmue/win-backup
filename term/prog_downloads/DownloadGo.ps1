$html = Invoke-WebRequest -Uri "https://go.dev/dl/" -UseBasicParsing
$halfUrl = ($html.Links | ? href -Match "/dl/go.*amd64.msi")[0].href
$url = "https://go.dev$halfUrl"

$file = $halfUrl.Replace("/dl/","")

$wc = New-Object net.webclient 
$wc.Downloadfile($url, "$PSScriptRoot/$file")