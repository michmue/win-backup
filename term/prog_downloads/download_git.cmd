@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://git-scm.com/download/win.html"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R "downloading" %tmp_file%') do set line=%%a
del %tmp_file%

SETLOCAL EnableDelayedExpansion
set "line=%line:*(<strong>=%"
set "line=%line:<="&rem %

set version=!line!
SETLOCAL DisableDelayedExpansion

set file_name=git-%version%-64bit.exe
set file=%~dp0git-%version%-64bit.exe
set "download_url=https://github.com/git-for-windows/git/releases/download/v%version%.windows.1/Git-%version%-64-bit.exe"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal