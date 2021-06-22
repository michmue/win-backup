@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set "download_page=https://data.services.jetbrains.com/products/releases?code=PS^&latest=true^&type=release"

set file_name=%~n0
set file_name=%file_name:download_=%
set tmp_file=%~dp0tmp_%file_name%.html
set job_name=%time%_downloading_%file_name%

bitsadmin /transfer %job_name%_tmp /download /priority foreground /dynamic %download_page% %tmp_file%

::        "windows": {
::          "link": "https://download.jetbrains.com/webide/PhpStorm-2021.1.2.exe",
::          "size": 417181104,
::          "checksumLink": "https://download.jetbrains.com/webide/PhpStorm-2021.1.2.exe.sha256"
::        },
set /p content=< %tmp_file%
DEL %tmp_file%

set "content=%content:*windows=%"
set "content=%content:":{"link":"=%"
set "content=%content:,=&rem %"

set "file_name=%content:*webide/=%"
set "file=%~dp0%file_name%"
set "download_url=%content%"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic "%download_url%" "%file%"
endlocal
