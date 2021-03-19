@echo off
REM Downloading newest teamviewer version (in x-bit ?)
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set app="VLC_Player"
set file_tmp=%~dp0tmp_%app%
set "job_name=%date%_%time%____________%app%____________"

set "url_links=http://download.videolan.org/pub/videolan/vlc/last/win64/"
REM bitsadmin /transfer %job_name% /download /priority foreground /dynamic %url_links% %file_tmp%

:: <li><a href="//get.videolan.org/vlc/3.0.12/win32/vlc-3.0.12-win32.7z">7zip package</a></li><li><a href="//get.videolan.org/vlc/3.0.12/win32/vlc-3.0.12-win32.zip">Zip package</a></li><li><a href="//get.videolan.org/vlc/3.0.12/win64/vlc-3.0.12-win64.exe">Installer for 64bit version</a></li><li><a href="http://people.videolan.org/~jb/Builds/ARM/vlc-4.0.0-dev-20180508-aarch64.zip">ARM 64 version</a></li><li><a href="download-sources.html">Source code</a></li>                <li role="separator" class="divider"></li>
:: for /f "tokens=*" %%a in ('findstr /R "Installers.Windows.IDE.only.\(64-bit\):.*" %tmp_file%') do (

REM findstr /R "64.exe<" tmp_VLC_Player > tmp_VLC_Player2
REM type tmp_VLC_Player2
REM FOR %%G IN ("type tmp_VLC_Player2") DO (
    REM SETLOCAL EnableDelayedExpansion
    REM SET "filInp=%%G"
    REM SET "doy=!filInp:~-10,4!"
    REM Convert Trimble GPS receiver observations to RINEX
    REM Changed your call to echo of the vars
    REM echo G: "%%G"; doy: "!doy!"
    REM endlocal
REM )
REM setlocal enabledelayedexpansion
for /f "tokens=*" %%a in ('findstr /R "64.exe<" tmp_VLC_Player2') do (
    set "line=%%a"
    REM set "line=%line:<=%"
    REM set "line=%line:>=%"
    REM echo %line%
)
REM echo %line%
    REM set bb=%%!a!:~5%%
    REM echo %bb%
REM )

echo %line%

exit /B
:: ,"windows":{"link":"https://download.jetbrains.com/python/pycharm-professional-2020.3.3.exe","size
set /p content=< tmp_%app%
DEL tmp_%app%

set "content=%content:*windows=%"
set "content=%content:":{"link":"=%"
set "content=%content:,=&rem %"

set "file_name=%content:*idea/=%"
set "file=%~dp0%file_name%"
set "url_download=%content%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic "%url_download%" "%file%"
endlocal
