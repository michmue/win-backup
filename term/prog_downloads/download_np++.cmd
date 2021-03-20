@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://github.com/notepad-plus-plus/notepad-plus-plus/releases"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R "Link--muted" %tmp_file%') do (
    set line=%%a
    goto :break
)
:break

del %tmp_file%

REM <a href="/notepad-plus-plus/notepad-plus-plus/tree/v7.9.2" class="muted-link css-truncate" title="v7.9.2">
SETLOCAL EnableDelayedExpansion
set "line=%line:"=%"
set "line=%line:*/notepad-plus-plus/notepad-plus-plus/tree/v=%"
set "line=%line: class="&rem %
SETLOCAL DisableDelayedExpansion


REM https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.2/npp.7.9.2.Installer.x64.exe
set "version=%line%"
set "download_url=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v%version%/npp.%version%.Installer.x64.exe"
set "file_name=npp.%version%.Installer.x64.exe"
set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal