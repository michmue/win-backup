@echo off
REM Downloading newest 7zip version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

set tmp_file=%~dp0tmp_7zip.html
bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic "https://7-zip.de/download.html" %tmp_file%


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

echo %file%
echo %download_url%
bitsadmin /transfer "downloading git binary" /download /priority foreground /dynamic %download_url% %~dp0%file%
