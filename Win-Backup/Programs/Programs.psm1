# IMPR: check versions perodically
# IMPR: auto extract + extract if subfolder
# IMPR: on closing stop running .NET WebClient, how?

enum Programs  {
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
    VSCODE
    WEBSTORM
    ZIP7
}


enum DriverType {
    BIOS
    LAN_REALTEK
    CHIPSET
    NVIDIA
    AUDIO_UNIX_XONAR
    AUDIO_INTERN
}


class Driver {
    [DriverType]$Driver
    [DownloadType]$DownloadType
    [string]$Url
}


enum DownloadType {
    DIRECT
    WEBREQUEST
    REST
    BITS
    SEMI_AUTOMATIC
    MANUEL
}


$drivers = [Driver[]]@(
    @{ Driver = [DriverType]::BIOS;             DownloadType = [DownloadType]::MANUEL;  Url = "https://www.asus.com/de/motherboards-components/motherboards/prime/prime-b350-plus/helpdesk_bios/" }
    @{ Driver = [DriverType]::LAN_REALTEK;      DownloadType = [DownloadType]::MANUEL;  Url = "https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software" }
    @{ Driver = [DriverType]::NVIDIA;           DownloadType = [DownloadType]::MANUEL;  Url = "https://www.nvidia.de/Download/index.aspx?lang=de" }
    @{ Driver = [DriverType]::AUDIO_UNIX_XONAR; DownloadType = [DownloadType]::DIRECT;  Url = "https://maxedtech.com/wp-content/uploads/2016/11/UNi-Xonar-1822-v1.75a-r3.exe" }

)


class Program {
    [Programs]$Name
    [DownloadType]$DownloadType
    [string]$Url
}


Write-host "missing anki"
# TODO anki download
$progs = @(
    [Program]@{    "Name"=[Programs]::ADB;                  "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"    }
    [Program]@{    "Name"=[Programs]::ANDROIDSTUDIO;        "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://developer.android.com/studio"    }
    [Program]@{    "Name"=[Programs]::ANKI;                 "DownloadType"=[DownloadType]::BITS;        "Url"    =    ""    }
    [Program]@{    "Name"=[Programs]::FIREFOX;              "DownloadType"=[DownloadType]::WEBREQUEST;  "Url"    =    "https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=de"    }
    [Program]@{    "Name"=[Programs]::GIT;                  "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://git-scm.com/download/win.html"    }
    [Program]@{    "Name"=[Programs]::GO;                   "DownloadType"=[DownloadType]::WEBREQUEST;  "Url"    =    "https://go.dev/dl/"    }
    [Program]@{    "Name"=[Programs]::GOLAND;               "DownloadType"=[DownloadType]::REST;        "Url"    =    "https://data.services.jetbrains.com/products/releases?code=GO"    }
    [Program]@{    "Name"=[Programs]::INTELLIJ;             "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://data.services.jetbrains.com/products/releases?code=IIU^&latest=true^&type=release^&build="    }
    [Program]@{    "Name"=[Programs]::JAVA;                 "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"    }
    [Program]@{    "Name"=[Programs]::JDOWNLOADER;          "DownloadType"=[DownloadType]::BITS;        "Url"    =    ""    }
    [Program]@{    "Name"=[Programs]::NOTEPAD_PLUS_PLUS;    "DownloadType"=[DownloadType]::REST;        "Url"    =    "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"    }
    [Program]@{    "Name"=[Programs]::PAINTNET;             "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://github.com/paintdotnet/release/releases"    }
    [Program]@{    "Name"=[Programs]::PHPSTORM;             "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://data.services.jetbrains.com/products/releases?code=PS^&latest=true^&type=release"    }
    [Program]@{    "Name"=[Programs]::PYCHARM;              "DownloadType"=[DownloadType]::REST;        "Url"    =    "https://data.services.jetbrains.com/products?code=PCP"    }
    [Program]@{    "Name"=[Programs]::PYTHON;               "DownloadType"=[DownloadType]::WEBREQUEST;  "Url"    =    "https://www.python.org/downloads/windows/"    }
    [Program]@{    "Name"=[Programs]::SMARTGIT;             "DownloadType"=[DownloadType]::WEBREQUEST;  "Url"    =    "https://www.syntevo.com/smartgit/download/"    }
    [Program]@{    "Name"=[Programs]::SPOTIFY;              "DownloadType"=[DownloadType]::DIRECT;      "Url"    =    "https://download.scdn.co/SpotifySetup.exe"    }
    [Program]@{    "Name"=[Programs]::SYNCTHING;            "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://github.com/canton7/SyncTrayzor/releases"    }
    [Program]@{    "Name"=[Programs]::TEAMVIEWER;           "DownloadType"=[DownloadType]::DIRECT;      "Url"    =    "https://dl.teamviewer.com/download/TeamViewer_Setup.exe"    }
    [Program]@{    "Name"=[Programs]::TREE_FILE_SIZE;       "DownloadType"=[DownloadType]::DIRECT;      "Url"    =    "https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"    }
    [Program]@{    "Name"=[Programs]::VLCPLAYER;            "DownloadType"=[DownloadType]::BITS;        "Url"    =    "http://download.videolan.org/pub/videolan/vlc/last/win64/"    }
    [Program]@{    "Name"=[Programs]::VSCODE;               "DownloadType"=[DownloadType]::DIRECT;      "Url"    =    "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"    }
    [Program]@{    "Name"=[Programs]::WEBSTORM;             "DownloadType"=[DownloadType]::REST;        "Url"    =    "https://data.services.jetbrains.com/products/releases?code=WS"    }
    [Program]@{    "Name"=[Programs]::ZIP7;                 "DownloadType"=[DownloadType]::BITS;        "Url"    =    "https://7-zip.de/download.html"    }
)


function downloadProgram( [Program] $prog) {
    $url
    $file

    $wc = [net.webclient]::new() #New-Object net.webclient

    switch ($prog.Name) {
        ([Programs]::ADB) {
            $url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
            $file = $url.Split("/") | select -Last 1
        }


        # IMPR: safer, search table[class='download'] for Windows 64-bit
        ([Programs]::ANDROIDSTUDIO) {
            $html = Invoke-WebRequest "https://developer.android.com/studio" -UseBasicParsing
            $url = @($html.links | ? { $_.href -match  "-windows.exe" } | select href | ? { $_ -notmatch "bundle" })[0].href
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::ANKI) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/ankitects/anki/releases/latest"
            $asset = $api.assets | ? name -Match "anki-.*?-windows-qt6\.exe"
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::FIREFOX) {
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


        ([Programs]::GIT) {
            $html = Invoke-WebRequest -Uri "https://git-scm.com/download/win" -UseBasicParsing
            $url = ($html.links | ? href -match "-64-bit.exe").href
            $file = $url.split("/") | select -last 1
        }


        ([Programs]::GO) {
            # TPUT get version from github, go.dev is slow
            # $last_tag = (((Invoke-WebRequest "https://api.github.com/repos/golang/go/tags?page=1&per_page=1").headers.link.split(',')) | ? {$_.EndsWith('rel="last"')}).split(";")[0].replace("<","").replace(">","").replace(" ", "")

            $html = Invoke-WebRequest -Uri "https://go.dev/dl/" -UseBasicParsing
            $href = ($html.Links | ? href -Match "\.windows-amd64\.msi")[0].href
            $url = "https://go.dev$href"
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::GOLAND) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=GO"
            $url = ($api.GO | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::INTELLIJ) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build="
            $url = ($api.IIU | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::JAVA) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/adoptium/temurin11-binaries/releases/latest"
            $asset = ($api.assets | ? name -Match "OpenJDK.+?-jdk_x64_windows_hotspot_.+?\.msi$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        # IMPR: SendKey to background window
        ([Programs]::JDOWNLOADER) {
            Add-Type -AssemblyName System.Windows.Forms
            Start-Process firefox.exe "https://mega.nz/file/2IURAaRB#84RbercQS9rTzBiBBhbWuLvAtJ1pZdG4RhCMskuWDFY"  -PassThru
            While ( Get-Process *firefox* | ? MainWindowTitle -match "Download - MEGA.*") {
                Start-Sleep -Milliseconds 200
            }
            Start-Sleep 5
            [System.Windows.Forms.SendKeys]::SendWait('+{TAB}')
            [System.Windows.Forms.SendKeys]::SendWait('+{TAB}')
            [System.Windows.Forms.SendKeys]::SendWait('+{TAB}')
            [System.Windows.Forms.SendKeys]::SendWait('+{TAB}')
            [System.Windows.Forms.SendKeys]::SendWait('+{enter}')

        }


        ([Programs]::NOTEPAD_PLUS_PLUS) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
            $asset = ($api.assets | ? name -Match "\.Installer\.x64\.exe$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::PAINTNET) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/paintdotnet/release/releases/latest"
            $asset = ($api.assets | ? name -Match "paint\.net\..+?\.install\.x64\.zip$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::PHPSTORM) {

            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=PS&latest=true&type=release"
            $url = ($api.PS | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::PYCHARM) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=PCP&latest=true&type=release"
            $url = ($api.PCP | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::PYTHON) {
            $html = Invoke-WebRequest -Uri "https://www.python.org/downloads/" -UseBasicParsing
            $url = ($html.Links | ? href -Match "-amd64.exe").href
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::SMARTGIT) {
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


        ([Programs]::SPOTIFY) {
            # IMPR: download supported spotx spotify
            $url = "https://download.spotify.com/SpotifyFullSetup.exe"
            $file = "SpotifyFullSetup.exe"
        }


        ([Programs]::SYNCTHING) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/syncthing/syncthing/releases/latest"
            $asset = ($api.assets | ? name -Match "syncthing-windows-arm64-v.+?.zip$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::TEAMVIEWER) {
            $url = "https://dl.teamviewer.com/download/TeamViewer_Setup.exe"
            $file = $url.split("/") | select -Last 1
        }


        ([Programs]::TREE_FILE_SIZE) {
            $url = "https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"
            $file = $url.split("/") | select -Last 1

            # IMRP: extract treefilesize
            # powershell -command "Expand-Archive -Force '%file%' '%~dp0\tmp'"
            # copy tmp\TreeSizeFree.exe .\TreeSizeFree.exe
            # rmdir tmp /Q /S
            # del TreeSizeFree-Portable.zip
        }


        ([Programs]::VLCPLAYER) {
            $url = "http://download.videolan.org/pub/videolan/vlc/last/win64/"
            $html = Invoke-WebRequest $url
            $file = ($html.links | ? href -Match "vlc-.+?\.4-win64\.exe$").href
            $url = "$url$file"
        }


        ([Programs]::VSCODE) {
            $url = $progs.VSCODE.Url
            $file = "VSCodeSetup-x64.exe"
        }


        ([Programs]::WEBSTORM) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=WS"
            $url= ($api.WS | ? type -Match "release")[0].downloads.windows.link
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::ZIP7) {
            $url = "https://7-zip.org/download.html"
            $html = Invoke-WebRequest $url
            $href = ($html.links | ? href -Match "7z.+?-x64.exe$")[0].href
            $file = $href.split("/") | select -Last 1
            $url = "https://7-zip.org/a/$file"
        }
    }

    if ($url -and $file) {
        $wc.DownloadFile($url, "$PSScriptRoot/$file")
    }
    $wc.Dispose()
}



#download $progs.VSCODE

function downloadDriver ( [DriverType] $driverType ) {
    [Driver]$driver = $drivers | ? Driver -eq $driverType
    $url
    $file

    $wc = [net.webclient]::new() #New-Object net.webclient

    switch ($driverType) {
        ([DriverType]::LAN_REALTEK) {
            # removed SEMI_AUTOMATIC download cookie problem disables download
            Start-Process firefox.exe $driver.Url
        }


        ([DriverType]::BIOS) {
            Start-Process firefox.exe $driver.Url
        }


        ([DriverType]::NVIDIA) {
            Start-Process firefox.exe $driver.Url
        }


        ([DriverType]::AUDIO_UNIX_XONAR) {
            $url = $driver.Url
            $file = $driver.Url.Split("/") | select -Last 1
        }
    }


    if ($url -and $file) {
        $wc.DownloadFile($url, "$PSScriptRoot\$file")
    }

    $wc.Dispose()
}

function Get-WBPrograms {
    return $progs
}

function Install-WBProgram {
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [Program]
        $programDetail
    )

    process {
        downloadProgram $programDetail
    }
}

Export-ModuleMember -Function Get-WBPrograms, Install-WBProgram