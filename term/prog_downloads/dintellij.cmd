@echo off
REM Downloading newest teamviewer version (in x-bit ?)
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

set app="Intellij Ultimate"
set file_tmp=%~dp0tmp_%app%
set "job_name=%date%_%time%____________%app%____________"

set "url_links=https://data.services.jetbrains.com/products/releases?code=IIU^&latest=true^&type=release^&build="
bitsadmin /transfer %job_name% /download /priority foreground /dynamic %url_links% %file_tmp%

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
