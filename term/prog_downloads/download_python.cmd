@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal 

set "download_page=https://www.python.org/downloads/"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R ">Download.Python.*</a" %tmp_file%') do (
    set line=%%a
    goto :mybreak
)
:mybreak
del %tmp_file%

REM <a class="button" href="https://www.python.org/ftp/python/3.9.1/python-3.9.1-macosx10.9.pkg">Download Python 3.9.1</a>
SETLOCAL EnableDelayedExpansion
set "line=%line:*Python =%"
SET line=%line:~0,-4%
SETLOCAL DisableDelayedExpansion

REM https://www.python.org/ftp/python/3.9.1/python-3.9.1-amd64.exe
set "version=%line%"
set "download_url=https://www.python.org/ftp/python/%version%/python-%version%-amd64.exe"
set "file_name=python-%version%-amd64.exe"
set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal