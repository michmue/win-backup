# IMPR: check versions perodically
# IMPR: auto extract + extract if subfolder
# IMPR: on closing stop .NET WebClient, how?

enum Program  {
	ADB
	ANDROIDSTUDIO
	ANKI
	DROPBOX
	FIREFOX
	GIT
	GO
	GOLAND
	INTELLIJ
	JAVA
	JDOWNLOADER
	NOTEPAD_PLUS_PLUS
	PAINTNET
	PHPSTORM
	PYCHARM
	PYTHON
	SMARTGIT
	SPOTIFY
	SYNCTHING
	TEAMVIEWER
    TREE_FILE_SIZE
	VLCPLAYER
	WEBSTORM
	ZIP7
}


enum DownloadType {
    DIRECT
    WEBREQUEST
    REST
    BITS
}

    
class ProgramDetails {
    [Program]$Program
    [DownloadType]$DownloadType
    [string]$Url
}


Write-host "missing anki & firefox url"
# TODO firefox multilanguage download choice
# TODO anki download
$progs = [PSCustomObject]@{
	[Program]::ADB				=	[ProgramDetails]@{	"Program"=[Program]::ADB;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"	}
	[Program]::ANDROIDSTUDIO	=	[ProgramDetails]@{	"Program"=[Program]::ANDROIDSTUDIO;		"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://developer.android.com/studio"	}
	[Program]::ANKI				=	[ProgramDetails]@{	"Program"=[Program]::ANKI;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	""	}
	[Program]::FIREFOX			=	[ProgramDetails]@{	"Program"=[Program]::FIREFOX;			"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=de"	}
	[Program]::GIT				=	[ProgramDetails]@{	"Program"=[Program]::GIT;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://git-scm.com/download/win.html"	}
	[Program]::GO				=	[ProgramDetails]@{	"Program"=[Program]::GO;				"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://go.dev/dl/"	}
	[Program]::GOLAND			=	[ProgramDetails]@{	"Program"=[Program]::GOLAND;			"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=GO"	}
	[Program]::INTELLIJ			=	[ProgramDetails]@{	"Program"=[Program]::INTELLIJ;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=IIU^&latest=true^&type=release^&build="	}
	[Program]::JAVA				=	[ProgramDetails]@{	"Program"=[Program]::JAVA;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"	}
	[Program]::JDOWNLOADER		=	[ProgramDetails]@{	"Program"=[Program]::JDOWNLOADER;		"DownloadType"=[DownloadType]::BITS;		"Url"	=	""	}
	[Program]::NOTEPAD_PLUS_PLUS=	[ProgramDetails]@{	"Program"=[Program]::NOTEPAD_PLUS_PLUS;	"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"	}
	[Program]::PAINTNET			=	[ProgramDetails]@{	"Program"=[Program]::PAINTNET;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/paintdotnet/release/releases"	}
	[Program]::PHPSTORM			=	[ProgramDetails]@{	"Program"=[Program]::PHPSTORM;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=PS^&latest=true^&type=release"	}
	[Program]::PYCHARM			=	[ProgramDetails]@{	"Program"=[Program]::PYCHARM;			"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://data.services.jetbrains.com/products?code=PCP"	}
	[Program]::PYTHON			=	[ProgramDetails]@{	"Program"=[Program]::PYTHON;			"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://www.python.org/downloads/windows/"	}
	[Program]::SMARTGIT			=	[ProgramDetails]@{	"Program"=[Program]::SMARTGIT;			"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://www.syntevo.com/smartgit/download/"	}
	[Program]::SPOTIFY			=	[ProgramDetails]@{	"Program"=[Program]::SPOTIFY;			"DownloadType"=[DownloadType]::DIRECT;		"Url"	=	"https://download.scdn.co/SpotifySetup.exe"	}
	[Program]::SYNCTHING		=	[ProgramDetails]@{	"Program"=[Program]::SYNCTHING;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/canton7/SyncTrayzor/releases"	}
	[Program]::TEAMVIEWER		=	[ProgramDetails]@{	"Program"=[Program]::TEAMVIEWER;		"DownloadType"=[DownloadType]::DIRECT;		"Url"	=	"https://dl.teamviewer.com/download/TeamViewer_Setup.exe"	}
	[Program]::TREE_FILE_SIZE	=	[ProgramDetails]@{	"Program"=[Program]::TREE_FILE_SIZE;	"DownloadType"=[DownloadType]::DIRECT;		"Url"	=	"https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"	}
	[Program]::VLCPLAYER		=	[ProgramDetails]@{	"Program"=[Program]::VLCPLAYER;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"http://download.videolan.org/pub/videolan/vlc/last/win64/"	}
	[Program]::WEBSTORM			=	[ProgramDetails]@{	"Program"=[Program]::WEBSTORM;			"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=WS"	}
	[Program]::ZIP7				=	[ProgramDetails]@{	"Program"=[Program]::ZIP7;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://7-zip.de/download.html"	}
}

        
function download( [ProgramDetails] $prog) {
    $url = ""
    $file = ""
    
    $wc = [net.webclient]::new() #New-Object net.webclient 

    switch ($prog.Program) {
        ([Program]::ADB) {
            $url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
            $file = $url.Split("/") | select -Last 1
        }


        # IMPR: safer, search table[class='download'] for Windows 64-bit
        ([Program]::ANDROIDSTUDIO) {
            $html = Invoke-WebRequest "https://developer.android.com/studio" -UseBasicParsing
            $url = @($html.links | ? { $_.href -match  "-windows.exe" } | select href | ? { $_ -notmatch "bundle" })[0].href
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::ANKI) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/ankitects/anki/releases/latest"
            $asset = $api.assets | ? name -Match "anki-.*?-windows-qt6\.exe"
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Program]::FIREFOX) {
            echo "1. Firefox en-US"
            echo "2. Firefox en-GB"
            echo "3. Firefox de"
            $lang = Read-Host -Prompt "Choose Firefox language [1, 2, 3]: "
            

            if ($lang -eq "1") {
	            $url = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
	            $file = "firefox_en-US.exe"
	        }

            if ($lang -eq "2") {
	            $url = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-GB"
	            $file = "firefox_en-GB.exe"
            }

            if ($lang -eq "3") {
                $url =  "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=de"
	            $file = "firefox_de.exe"
            }	        
        }


        ([Program]::GIT) {
            $html = Invoke-WebRequest -Uri "https://git-scm.com/download/win" -UseBasicParsing
            $url = ($html.links | ? href -match "-64-bit.exe").href
            $file = $url.split("/") | select -last 1
        }


        ([Program]::GO) {
            # TPUT get version from github, go.dev is slow            
            # $last_tag = (((Invoke-WebRequest "https://api.github.com/repos/golang/go/tags?page=1&per_page=1").headers.link.split(',')) | ? {$_.EndsWith('rel="last"')}).split(";")[0].replace("<","").replace(">","").replace(" ", "")

            $html = Invoke-WebRequest -Uri "https://go.dev/dl/" -UseBasicParsing
            $href = ($html.Links | ? href -Match "\.windows-amd64\.msi")[0].href
            $url = "https://go.dev$href"
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::GOLAND) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=GO"
            $url = ($api.GO | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::INTELLIJ) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build="
            $url = ($api.IIU | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::JAVA) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/adoptium/temurin11-binaries/releases/latest"
            $asset = ($api.assets | ? name -Match "OpenJDK.+?-jdk_x64_windows_hotspot_.+?\.msi$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Program]::JDOWNLOADER) {
            # TODO: JDownloader from mega.nz.co?
        }


        ([Program]::NOTEPAD_PLUS_PLUS) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
            $asset = ($api.assets | ? name -Match "\.Installer\.x64\.exe$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Program]::PAINTNET) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/paintdotnet/release/releases/latest"
            $asset = ($api.assets | ? name -Match "paint\.net\..+?\.install\.x64\.zip$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Program]::PHPSTORM) {
            
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=PS&latest=true&type=release"
            $url = ($api.PS | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::PYCHARM) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=PCP&latest=true&type=release"
            $url = ($api.PCP | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::PYTHON) {
            $html = Invoke-WebRequest -Uri "https://www.python.org/downloads/" -UseBasicParsing
            $url = ($html.Links | ? href -Match "-amd64.exe").href
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::SMARTGIT) {
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
        }


        ([Program]::SPOTIFY) {
            # IMPR: download supported spotx spotify
            $url = "https://download.spotify.com/SpotifyFullSetup.exe"
            $file = "SpotifyFullSetup.exe"
        }


        ([Program]::SYNCTHING) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/syncthing/syncthing/releases/latest"
            $asset = ($api.assets | ? name -Match "syncthing-windows-arm64-v.+?.zip$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Program]::TEAMVIEWER) {
            $url = "https://dl.teamviewer.com/download/TeamViewer_Setup.exe"
            $file = $url.split("/") | select -Last 1
        }


        ([Program]::TREE_FILE_SIZE) {
            $url = "https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"
            $file = $url.split("/") | select -Last 1

            # TODO: extract treefilesize
            # powershell -command "Expand-Archive -Force '%file%' '%~dp0\tmp'"
            # copy tmp\TreeSizeFree.exe .\TreeSizeFree.exe
            # rmdir tmp /Q /S
            # del TreeSizeFree-Portable.zip
        }


        ([Program]::VLCPLAYER) {
            $url = "http://download.videolan.org/pub/videolan/vlc/last/win64/"
            $html = Invoke-WebRequest $url
            $file = ($html.links | ? href -Match "vlc-.+?\.4-win64\.exe$").href
            $url = "$url$file"
        }


        ([Program]::WEBSTORM) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=WS"
            $url= ($api.WS | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Program]::ZIP7) {            
            $url = "https://7-zip.org/download.html"
            $html = Invoke-WebRequest $url
            $href = ($html.links | ? href -Match "7z.+?-x64.exe$")[0].href
            $file = $href.split("/") | select -Last 1
            $url = "https://7-zip.org/a/$file"
        }
    }

    $wc.DownloadFile($url, "$PSScriptRoot/$file")
    $wc.Dispose()
}

download $progs.TREe_FILE_SIZE

