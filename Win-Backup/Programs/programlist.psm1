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
    [string[]]$InstallerArguments
    [string]$AnswerFile
    [scriptblock]$Script
}


$progs = @(
    [Program]@{
        "Name"               = [Programs]::ADB;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"
    },
    [Program]@{
        "Name"               = [Programs]::ANDROIDSTUDIO;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://developer.android.com/studio"
    },
    [Program]@{
        "Name"               = [Programs]::ANKI;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = ""
    },
    [Program]@{
        "Name"               = [Programs]::FIREFOX;
        "DownloadType"       = [DownloadType]::WEBREQUEST;
        "InstallerArguments" = @("/", "/DesktopShortcut=false", "/PrivateBrowsingShortcut=false");
        "Url"                = "https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=de"
    },
    [Program]@{
        "Name"               = [Programs]::GIT;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @("/VERYSILENT", "/NORESTART", "/NOCANCEL", "/LOADINF=$PSScriptRoot\answerfile")
        "Url"                = "https://git-scm.com/download/win.html";
        "AnswerFile"         = @"
[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=ext,ext\shellhere,gitlfs,assoc,assoc_sh,windowsterminal,scalar
Tasks=
EditorOption=Nano
CustomEditorPath=
DefaultBranchOption=
PathOption=Cmd
SSHOption=OpenSSH
TortoiseOption=false
CURLOption=OpenSSL
CRLFOption=CRLFAlways
BashTerminalOption=MinTTY
GitPullBehaviorOption=Rebase
UseCredentialManager=Enabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Disabled
EnablePseudoConsoleSupport=Disabled
EnableFSMonitor=Disabled
"@
    },
    [Program]@{
        "Name"               = [Programs]::GO;
        "DownloadType"       = [DownloadType]::WEBREQUEST;
        "InstallerArguments" = @();
        "Url"                = "https://go.dev/dl/"
    },
    [Program]@{
        "Name"               = [Programs]::GOLAND;
        "DownloadType"       = [DownloadType]::REST;
        "InstallerArguments" = @();
        "Url"                = "https://data.services.jetbrains.com/products/releases?code=GO"
    },
    [Program]@{
        "Name"               = [Programs]::INTELLIJ;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://data.services.jetbrains.com/products/releases?code=IIU^&latest=true^&type=release^&build="
    },
    [Program]@{
        "Name"               = [Programs]::JAVA;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"
    },
    [Program]@{
        "Name"               = [Programs]::JDOWNLOADER;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = ""
    },
    [Program]@{
        "Name"               = [Programs]::NOTEPAD_PLUS_PLUS;
        "DownloadType"       = [DownloadType]::REST;
        "InstallerArguments" = @("/S");
        "Url"                = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"
        "Script"             = {

        }
    },
    [Program]@{
        "Name"               = [Programs]::PAINTNET;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://github.com/paintdotnet/release/releases"
    },
    [Program]@{
        "Name"               = [Programs]::PHPSTORM;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://data.services.jetbrains.com/products/releases?code=PS^&latest=true^&type=release"
    },
    [Program]@{
        "Name"               = [Programs]::PYCHARM;
        "DownloadType"       = [DownloadType]::REST;
        "InstallerArguments" = @();
        "Url"                = "https://data.services.jetbrains.com/products?code=PCP"
    },
    [Program]@{
        "Name"               = [Programs]::PYTHON;
        "DownloadType"       = [DownloadType]::WEBREQUEST;
        "InstallerArguments" = @();
        "Url"                = "https://www.python.org/downloads/windows/"
    },
    [Program]@{
        "Name"               = [Programs]::SMARTGIT;
        "DownloadType"       = [DownloadType]::WEBREQUEST;
        "InstallerArguments" = @();
        "Url"                = "https://www.syntevo.com/smartgit/download/"
    },
    [Program]@{
        "Name"               = [Programs]::SPOTIFY;
        "DownloadType"       = [DownloadType]::DIRECT;
        "InstallerArguments" = @();
        "Url"                = "https://download.scdn.co/SpotifySetup.exe"
    },
    [Program]@{
        "Name"               = [Programs]::SYNCTHING;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://github.com/canton7/SyncTrayzor/releases"
    },
    [Program]@{
        "Name"               = [Programs]::TEAMVIEWER;
        "DownloadType"       = [DownloadType]::DIRECT;
        "InstallerArguments" = @();
        "Url"                = "https://dl.teamviewer.com/download/TeamViewer_Setup.exe"
    },
    [Program]@{
        "Name"               = [Programs]::TREE_FILE_SIZE;
        "DownloadType"       = [DownloadType]::DIRECT;
        "InstallerArguments" = @();
        "Url"                = "https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"
    },
    [Program]@{
        "Name"               = [Programs]::VLCPLAYER;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "http://download.videolan.org/pub/videolan/vlc/last/win64/"
    },
    [Program]@{
        "Name"               = [Programs]::VSCODE;
        "DownloadType"       = [DownloadType]::DIRECT;
        "InstallerArguments" = @();
        "Url"                = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
    },
    [Program]@{
        "Name"               = [Programs]::WEBSTORM;
        "DownloadType"       = [DownloadType]::REST;
        "InstallerArguments" = @();
        "Url"                = "https://data.services.jetbrains.com/products/releases?code=WS"
    },
    [Program]@{
        "Name"               = [Programs]::ZIP7;
        "DownloadType"       = [DownloadType]::BITS;
        "InstallerArguments" = @();
        "Url"                = "https://7-zip.de/download.html"
    }
)

Export-ModuleMember -Variable drivers,progs