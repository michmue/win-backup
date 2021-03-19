@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

set tmp_file=%~dp0tmp_git.html
bitsadmin /transfer "downloading git download page(html) for version parsing" /download /priority foreground /dynamic "https://git-scm.com/download/win.html" %tmp_file%

for /f "tokens=*" %%a in ('findstr /R "downloading" %tmp_file%') do set line=%%a
del %tmp_file%

SETLOCAL EnableDelayedExpansion
set "line=%line:*(<strong>=%"
set "line=%line:<="&rem %

set version=!line!
SETLOCAL DisableDelayedExpansion

set git_binary=git-%version%-64bit.exe
set "git_url=https://github.com/git-for-windows/git/releases/download/v%version%.windows.1/Git-%version%-64-bit.exe"

bitsadmin /transfer "downloading git binary" /download /priority foreground /dynamic %git_url% %~dp0%git_binary%