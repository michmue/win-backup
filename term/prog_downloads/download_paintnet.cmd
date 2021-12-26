@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://github.com/paintdotnet/release/releases"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R ".winmsi.x64.zip" %tmp_file%') do ( 
	set line=%%a
	goto break
)
:break
del %tmp_file%

set "line=%line:"=%"
set "line=%line:*/=%"
set "line=%line: rel="&rem %
REM line === paintdotnet/release/releases/download/v4.3.4/paint.net.4.3.4.winmsi.x64.zip



REM "https://github.com/paintdotnet/release/releases/download/v4.3.4/paint.net.4.3.4.winmsi.x64.zip"
set "download_url=https://github.com/%line%"

REM remove all up to character / five times
set "file_name=%line:*/=%"
set "file_name=%file_name:*/=%"
set "file_name=%file_name:*/=%"
set "file_name=%file_name:*/=%"
set "file_name=%file_name:*/=%"

set "file=%~dp0%file_name%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal