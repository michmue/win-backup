# IMPR: check versions perodically
# IMPR: auto extract + extract if subfolder
# IMPR: on closing stop running .NET WebClient, how?


using module ".\programlist.psm1"
Import-Module "$PSScriptRoot\programlist.psm1"

Write-host "missing anki"
# TODO anki download

function downloadProgram {
    [CmdletBinding(ConfirmImpact="none",SupportsShouldProcess=$true)]
    param(
        [Program]$prog,
        [switch]$Force
    )

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
            $url = @($html.links | ? { $_.href -match "-windows.exe" } | select href | ? { $_ -notmatch "bundle" })[0].href
            $file = $url.Split("/") | select -Last 1
        }


        ([Programs]::ANKI) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/ankitects/anki/releases/latest"
            $asset = $api.assets | ? name -Match "anki-.*?-windows-qt6\.exe"
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::FIREFOX) {
            Write-Host "1. Firefox en-US"
            Write-Host "2. Firefox en-GB"
            Write-Host "3. Firefox de"
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
                $url = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=de"
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

            if (-NOT (Test-Path "C:\Program Files\Mozilla Firefox\firefox.exe")) {
                Get-WBProgram FIREFOX | Install-WBProgram
            }

            if (-NOT (Test-Path "C:\bin\geckodriver.exe")) {
                $api = Invoke-RestMethod -Uri "https://api.github.com/repos/mozilla/geckodriver/releases/latest"
                $asset = ($api.assets | ? name -Match "geckodriver-v[\.,\d]+-win64.zip$")
                $file = $asset.name
                $url = $asset.browser_download_url
                $wc.DownloadFile($url, "$PSScriptRoot\$file");
                Expand-Archive -Path "$PSScriptRoot\$file" -DestinationPath "C:\bin" -Force
                Remove-Item "$PSScriptRoot\geckodriver*.zip" -Force
            }

            if (-Not (Get-PackageProvider | ? Name -eq NuGet)) {
                Install-PackageProvider -Name "NuGet" -Force -ForceBootstrap -Confirm:$false
            }

            if (-Not (get-PSRepository -Name PSGallery)) {
                Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
            }

            if (-not (Get-Module -Name Selenium)) {
                if (-not (Get-Module -ListAvailable -name Selenium)) {
                    Write-Host "Installing module selenium"
                    Install-Module Selenium -Force
                }

                Import-Module Selenium -Force
            }

            if (-Not ((Get-ChildItem  "$PSScriptRoot\JDownloader2Setup_windows-x64_jre??.exe" -File).Name)) {
            Write-Host "starting selenium/firefox"
            $driver = (Start-SeFirefox -StartURL "https://mega.nz/file/2IURAaRB#84RbercQS9rTzBiBBhbWuLvAtJ1pZdG4RhCMskuWDFY" -DefaultDownloadPath $PSScriptRoot -AsDefaultDriver -Headless -Quiet -WebDriverDirectory "C:\bin")
            Write-Host "waiting for download"
            $downloadBtn = Get-SeElement -By CssSelector ".js-default-download > span" -Wait
            $downloadBtn.Click()
            $downloadCompleteLbl = Get-SeElement -By CssSelector ".download.complete-block"
            while (!($downloadCompleteLbl.Displayed)) {
                Write-Host "sleeping"
                sleep -Milliseconds 500
                $downloadCompleteLbl = Get-SeElement -By CssSelector ".download.complete-block"
            }
        }

            sleep -Seconds 5
            $file = (Get-ChildItem  "$PSScriptRoot\JDownloader2Setup_windows-x64_jre??.exe" -File).Name
            Write-Host "++++++++"
            Write-Host $file
            Write-Host "++++++++"
        }


        ([Programs]::NOTEPAD_PLUS_PLUS) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
            $asset = ($api.assets | ? name -Match "\.Installer\.x64\.exe$")
            $file = $asset.name
            $url = $asset.browser_download_url
        }


        ([Programs]::PAINTNET) {
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/paintdotnet/release/releases/latest"
            $asset = ($api.assets | ? name -Match "paint\.net\..+?\.winmsi\.x64\.zip$")
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
            $api = Invoke-RestMethod -Uri "https://api.github.com/repos/bill-stewart/SyncthingWindowsSetup/releases/latest"
            $asset = ($api.assets | ? name -Match "syncthing-[\.,\d]+-setup\.exe$")
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
            $file = ($html.links | ? href -Match "vlc-.+?-win64\.exe$").href
            $url = "$url$file"
        }


        ([Programs]::VSCODE) {
            $url = $progs.VSCODE.Url
            $file = "VSCodeSetup-x64.exe"
        }


        ([Programs]::WEBSTORM) {
            $api = Invoke-RestMethod -uri "https://data.services.jetbrains.com/products/releases?code=WS"
            $url = ($api.WS | ? type -Match "release")[0].downloads.windows.link
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

    if (($url -and $file) -and
        -NOT ($file -Match "JDownloader.*")) {

            $wc.DownloadFile($url, "$PSScriptRoot/$file")
    }
    $wc.Dispose()


    while (-Not (Resolve-Path "$PSScriptRoot\$file").Path) {
        Write-Host "resolving"
        sleep -Milliseconds 50
    }

    return (Resolve-Path "$PSScriptRoot\$file")
}


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

function Get-WBProgram ($name) {
    return $progs | ? Name -Like $name
}



function Install-WBProgram {
    [CmdletBinding(ConfirmImpact="none",SupportsShouldProcess=$true)]

    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [Program]$programDetail,
        [switch]$Force
    )
    
    $resolve = downloadProgram $programDetail
    $filePath = $resolve.Path
    $fileName = Split-Path $filePath -Leaf

    if (($programDetail.AnswerFile.length -gt 0)) {
        $programDetail.AnswerFile | Out-File "$PSScriptRoot\answerfile" -Encoding ascii -Force
    }

    if ($fileName -like "*.zip") {
        Expand-Archive -Path $filePath -DestinationPath $PSScriptRoot -Verbose
        $fileNameZip = $fileName;
        $filePathZip = $filePath;

        $fileName = $fileName.Replace(".zip", ".exe")
        $filePath = $filePath.Replace(".zip", ".exe")

        if ( -Not (Test-Path $filePath)) {
            $fileName = $fileName.Replace(".exe", ".msi")
            $filePath = $filePath.Replace(".exe", ".msi")
        }
    }

    if (($null -ne $programDetail.InstallerArguments) -and ($programDetail.InstallerArguments.Length -gt 0)) {
        Write-Host "installing $fileName..."
        Start-Process -FilePath $filePath -ArgumentList $programDetail.InstallerArguments  -PassThru -Verbose -Wait
    }

    if (($null -ne $fileNameZip)) {
        Remove-Item $filePathZip
    }

    if ( Test-Path $filePath ) {
        Remove-Item $filePath
    }

    Write-Host "$fileName should be installed"
    if ( (Test-Path $PSScriptRoot\answerfile) ) {
        Remove-Item $PSScriptRoot\answerfile

    }
    if ( ($null -ne $programDetail.Script) ) {
        Write-Host "invoking for np++"
        Invoke-Command -ScriptBlock $programDetail.Script
    }
}

Export-ModuleMember -Function Get-WBProgram, Install-WBProgram