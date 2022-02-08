$version = Read-Host "Select normal (1) or portable (2)"

$baseUrl = "https://www.syntevo.com"
$html = Invoke-WebRequest -Uri "https://www.syntevo.com/smartgit/download/" -UseBasicParsing
if ($version -eq "1") {
    $url = ($html.Links | ? href -Match "smartgit-win-.*zip")[0].href
}
if ($version -eq "2") {
    $url = ($html.Links | ? href -Match "smartgit-portable-.*7z")[0].href
}
$url = $baseUrl + $url
$file = $url.Split("/") | select -Last 1

$wc = New-Object net.webclient 
$wc.Downloadfile($url, "$PSScriptRoot/$file")