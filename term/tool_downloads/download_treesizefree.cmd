@echo off & setlocal
REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php


set file_name=%~n0
set file_name=%file_name:download_=%
set job_name=%time%_downloading_%file_name%


set "download_url=https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"
set "file=%~dp0TreeSizeFree-Portable.zip"


bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_url% %file%


powershell -command "Expand-Archive -Force '%file%' '%~dp0\tmp'"
copy tmp\TreeSizeFree.exe .\TreeSizeFree.exe
rmdir tmp /Q /S
del TreeSizeFree-Portable.zip

endlocal