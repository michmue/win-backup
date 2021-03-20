@echo off & setlocal
REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php




REM Page where the actual download url will be found
set "download_page=http://download.videolan.org/pub/videolan/vlc/last/win64/"


set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%
set tmp_job_name=%time%_downloading_%file_name%

bitsadmin /transfer %tmp_job_name% /download /priority foreground /dynamic %download_page% %tmp_file%

REM find line of download url in download page
for /f "tokens=*" %%a in ('findstr "msi" %tmp_file%') do (
    set line=%%a
    goto :break
)
:break

del %tmp_file%



REM string manipulation to extract url and/or version
set "line=%line:<=%"
set "line=%line:>=%"
set "line=%line:*vlc=%"
set "line=%line:"="&rem %

set file_name=vlc%line%
set "download_url=http://download.videolan.org/pub/videolan/vlc/last/win64/%file_name%"
set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%


endlocal