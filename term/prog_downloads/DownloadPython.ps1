$html = Invoke-WebRequest -Uri "https://www.python.org/downloads/windows/" -UseBasicParsing
$url = ($html.Links | ? href -Match "-amd64.exe")[0].href

$file = $url.Split("/") | select -Last 1

$wc = New-Object net.webclient 
$wc.Downloadfile($url, "$PSScriptRoot/$file")