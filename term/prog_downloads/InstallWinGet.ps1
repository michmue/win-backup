$releases_url = "https://data.services.jetbrains.com/products/releases?code=IIU"
		
$releases = Invoke-RestMethod -uri "$($releases_url)"
$url = $releases.IIU[0].downloads.windows.link
$version = $releases.IIU[0].version	
		
Invoke-WebRequest -Uri $url -OutFile $PSScriptRoot/IntelliJ-IDEA-$version