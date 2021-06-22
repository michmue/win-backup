@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

set "download_url=https://dl.google.com/android/repository/platform-tools-latest-windows.zip"

set "file_name=adb.zip"
set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal