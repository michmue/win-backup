@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php

set app="Intellij Ultimate"
set tmp_file=%~dp0tmp_%app%
set "job_name=%date%_%time%____________%app%____________"

set "download_page=https://developer.android.com/studio"
bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R "Installers.Windows.IDE.only.\(64-bit\):.*" %tmp_file%') do (
    set line=%%a
    goto :mybreak
)
:mybreak

del %tmp_file%

REM <div class="downloads"> Installers Windows IDE only (64-bit): <a href="https://redirector.gvt1.com/edgedl/android/studio/install/4.1.2.0/android-studio-ide-201.7042882-windows.exe"
SETLOCAL EnableDelayedExpansion
set "line=%line:"=%"
set "line=%line:*href=%"
set line=%line:~1%
SETLOCAL DisableDelayedExpansion


REM https://redirector.gvt1.com/edgedl/android/studio/install/4.1.2.0/android-studio-ide-201.7042882-windows.exe
set "download_url=%line%"

set "file_name=%line:*/android-studio-ide-=%"
set "file_name=android-studio-ide-%file_name%

set "file=%~dp0%file_name%"

bitsadmin /transfer "downloading jdownloader" /download /priority foreground /dynamic %download_url% %file%
endlocal