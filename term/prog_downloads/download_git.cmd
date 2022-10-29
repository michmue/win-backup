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

REM <strong><a href="https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe">64-bit Git for Windows Setup</a>.</strong>
for /f "tokens=*" %%a in ('findstr /R "\-64\-bit.exe" %tmp_file%') do set line=%%a
del %tmp_file%

set "line=%line:<=%"
set "line=%line:"=%"
set "line=%line:>64-bit="&rem %
set "line=%line:*https=%"
set "line=https%line%

set "download_url=%line%"

set "file_name=%line:*/download/=%"
set "file_name=%file_name:*/=%"
set file=%~dp0%file_name%

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal