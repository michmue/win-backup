@echo off
REM Downloading newest git version in 64bit
REM Git binary gets downloaded into same folder as this script
REM Double click this file or call it from command line without arguments/parameter

REM https://ss64.com/nt/
REM https://www.robvanderwoude.com/escapechars.php
REM https://www.dostips.com/DtTipsStringManipulation.php

set file=%~dp0openjdk-11x64.msi
set "download_page=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10%%2B9/OpenJDK11U-jdk_x64_windows_hotspot_11.0.10_9.msi"
bitsadmin /transfer "%date%%time%_____%file%" /download /priority foreground /dynamic %download_page% %file%
