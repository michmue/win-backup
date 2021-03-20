@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://7-zip.de/download.html"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%


set first_repeat=1
for /f "tokens=*" %%a in ('findstr /R x64.exe %tmp_file%') do (
    if defined first_repeat (
        set line=%%a
        set first_repeat=
    )
)

del %tmp_file%

REM <td><p><a class="reference external" href="https://7-zip.org/a/7z1900-x64.exe">Download</a></p></td>
SETLOCAL EnableDelayedExpansion
set "line=%line:*href=%"
REM set "line=%line:"="&rem %
set line=!line:~2,-23!
set "file=%line:/=" & set "file=%"
set file=!file!
set download_url=!line!
SETLOCAL DisableDelayedExpansion
set file=%~dp0%file%

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal