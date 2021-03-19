@echo off
REM Downloading newest teamviewer version (in x-bit ?)
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

set "download_url=https://dl.teamviewer.com/download/TeamViewer_Setup.exe"
set binary_file=%~dp0%TeamViewer_Setup.exe

del %binary_file%

bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic %download_url% %~dp0%TeamViewer_Setup.exe