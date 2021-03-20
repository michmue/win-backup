@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_url=http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe"

set file_name=JD2SilentSetup_x64.exe
set job_name=%time%_downloading_%file_name%

set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal
