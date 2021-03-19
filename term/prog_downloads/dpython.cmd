@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php

set tmp_file=%~dp0tmp_py.html
set "download_page=https://www.python.org/downloads/"
bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic %download_page% %tmp_file%

for /f "tokens=*" %%a in ('findstr /R ">Download.Python.*</a" %tmp_file%') do (
    set line=%%a
    goto :mybreak
)
:mybreak
del %tmp_file%

REM <a class="button" href="https://www.python.org/ftp/python/3.9.1/python-3.9.1-macosx10.9.pkg">Download Python 3.9.1</a>
SETLOCAL EnableDelayedExpansion
REM replace "
REM set "line=%line:"=%"
REM replace XXX
set "line=%line:*Python =%"
REM cut from right till XXX
REM set "line=%line:</a>=%"
SET line=%line:~0,-4%
SETLOCAL DisableDelayedExpansion


REM https://www.python.org/ftp/python/3.9.1/python-3.9.1-amd64.exe
set "version=%line%"
set "download_url=https://www.python.org/ftp/python/%version%/python-%version%-amd64.exe"
set "file_name=python-%version%-amd64.exe"
set "file=%~dp0%file_name%"

bitsadmin /transfer "downloading jdownloader" /download /priority foreground /dynamic %download_url% %file%
endlocal