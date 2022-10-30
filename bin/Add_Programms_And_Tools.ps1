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
	NP
	PAINTNET
	PHPSTORM
	PYCHARM
	PYTHON
	SMARTGIT
	SPOTIFY
	SYNCTHING
	TEAMVIEWER
	VLCPLAYER
	WEBSTORM
	ZIP7
}


enum DownloadType {
    WEBCLIENT
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
	[Program]::NP				=	[ProgramDetails]@{	"Program"=[Program]::NP;				"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest"	}
	[Program]::PAINTNET			=	[ProgramDetails]@{	"Program"=[Program]::PAINTNET;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/paintdotnet/release/releases"	}
	[Program]::PHPSTORM			=	[ProgramDetails]@{	"Program"=[Program]::PHPSTORM;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=PS^&latest=true^&type=release"	}
	[Program]::PYCHARM			=	[ProgramDetails]@{	"Program"=[Program]::PYCHARM;			"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://data.services.jetbrains.com/products?code=PCP"	}
	[Program]::PYTHON			=	[ProgramDetails]@{	"Program"=[Program]::PYTHON;			"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://www.python.org/downloads/windows/"	}
	[Program]::SMARTGIT			=	[ProgramDetails]@{	"Program"=[Program]::SMARTGIT;			"DownloadType"=[DownloadType]::WEBREQUEST;	"Url"	=	"https://www.syntevo.com/smartgit/download/"	}
	[Program]::SPOTIFY			=	[ProgramDetails]@{	"Program"=[Program]::SPOTIFY;			"DownloadType"=[DownloadType]::WEBCLIENT;	"Url"	=	"https://download.scdn.co/SpotifySetup.exe"	}
	[Program]::SYNCTHING		=	[ProgramDetails]@{	"Program"=[Program]::SYNCTHING;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://github.com/canton7/SyncTrayzor/releases"	}
	[Program]::TEAMVIEWER		=	[ProgramDetails]@{	"Program"=[Program]::TEAMVIEWER;		"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://dl.teamviewer.com/download/TeamViewer_Setup.exe"	}
	[Program]::VLCPLAYER		=	[ProgramDetails]@{	"Program"=[Program]::VLCPLAYER;			"DownloadType"=[DownloadType]::BITS;		"Url"	=	"http://download.videolan.org/pub/videolan/vlc/last/win64/"	}
	[Program]::WEBSTORM			=	[ProgramDetails]@{	"Program"=[Program]::WEBSTORM;			"DownloadType"=[DownloadType]::REST;		"Url"	=	"https://data.services.jetbrains.com/products/releases?code=WS"	}
	[Program]::ZIP7				=	[ProgramDetails]@{	"Program"=[Program]::ZIP7;				"DownloadType"=[DownloadType]::BITS;		"Url"	=	"https://7-zip.de/download.html"	}
}


# TODO progressbar https://stackoverflow.com/questions/21422364/is-there-any-way-to-monitor-the-progress-of-a-download-using-a-webclient-object
function download_program( [ProgramDetails]$programDetails ) {
    switch ($programDetails.DownloadType) {
        ([DownloadType]::BITS)			{ download_by_bits $programDetails }
        ([DownloadType]::REST)			{ download_by_rest $programDetails }
        ([DownloadType]::WEBCLIENT)		{ download_by_webclient $programDetails }
        ([DownloadType]::WEBREQUEST)	{ download_by_webrequest $programDetails }
    }	
}

function download_by_bits( [ProgramDetails]$programDetails ) {
    echo downloading
}


function download_by_rest( [ProgramDetails]$programDetails ) {
    
}


function download_by_webclient( [ProgramDetails]$programDetails ) {

}


function download_by_webrequest( [ProgramDetails]$programDetails ) {

}

download_program($progs.ADB)
