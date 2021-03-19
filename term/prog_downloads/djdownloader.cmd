REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

@echo off
setlocal

set "file_name=JD2SilentSetup_x64.exe"
set tmp_file=%~dp0tmp_git.html
set "file=%~dp0%file_name%"
set "url=http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe"

bitsadmin /transfer "downloading jdownloader" /download /priority foreground /dynamic %url% %file%
endlocal
