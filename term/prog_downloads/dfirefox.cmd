@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set file=%~dp0firefox.exe
set "download_page=https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=en-US"
bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic %download_page% %file%

endlocal