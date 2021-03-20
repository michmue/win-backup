@echo off
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php
setlocal

echo 1. Firefox en-US
echo 2. Firefox en-GB
echo 3. Firefox de
choice /c 123 /m "Choose Firefox language "

if %ERRORLEVEL% EQU 1 (
	set "download_page=https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=en-US"
	set file_name=firefox_en-US.exe)
	
if %ERRORLEVEL% EQU 2 (
	set "download_page=https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=en-GB"
	set file_name=firefox_en-GB.exe)
if %ERRORLEVEL% EQU 3 (set "download_page=https://download.mozilla.org/?product=firefox-latest-ssl^&os=win64^&lang=de"
	set file_name=firefox_de.exe)
	
set file=%~dp0%file_name%
set job_name=%time%_downloading_%file_name%
	
bitsadmin /transfer %job_name% /download /priority foreground /dynamic %download_page% %file%

endlocal