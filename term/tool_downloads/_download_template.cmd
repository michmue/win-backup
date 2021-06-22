@echo off & setlocal
REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php




REM Page where the actual download url will be found
set "download_page=https://developer.android.com/studio"


set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%
set tmp_job_name=%time%_downloading_%file_name%

bitsadmin /transfer %tmp_job_name% /download /priority foreground /dynamic %download_page% %tmp_file%


REM find line of download url in download page
for /f "tokens=*" %%a in ('findstr /R "Installers.Windows.IDE.only.\(64-bit\):.*" %tmp_file%') do (
for /f "tokens=*" %%a in ('findstr "msi" %tmp_file%') do (
    set line=%%a
    goto :mybreak
)
:mybreak
DEL %tmp_file%



REM string manipulation to extract url and/or version
REM setlocal enabledelayedexpansion helps with file or command errors (auto escape > < fileDescriptors)
REM replace " with none
set "line=%line:"=%"
REM remove from left up to someString (included)
set "line=%line:*/someString=%"
REM remove from right up to someString (included)
set "line=%line: class="&rem %
REM set line=%line:~1%



set "download_url=%line%"
set "file_name=somethingFromLine"
set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%


endlocal