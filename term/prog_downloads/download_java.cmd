@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

REM <a href="/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk11u-2021-03-19-09-18/OpenJDK11U-jdk_x64_windows_hotspot_2021-03-19-09-18.msi" rel="nofollow" class="d-flex flex-items-center min-width-0">
for /f "tokens=*" %%a in ('findstr /R "jdk_x64_windows_hotspot" %tmp_file%') do (
    set line=%%a
    goto :break
)
:break

del %tmp_file%

set "line=%line:"=%"
set "line=%line:*/=%"
set "line=%line: rel="&rem %

set "download_url=https://github.com/%line%"

set "line=%line:*/OpenJDK11u-=%"
set "file_name=OpenJDK11u-%line%"
set "file=%~dp0%file_name%"

echo %file%
echo %download_url%

bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%
endlocal