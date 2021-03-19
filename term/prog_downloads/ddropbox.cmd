@echo off

set file_name=dropboxinstaller.exe
set file=%~dp0%file_name%
set "job_name=%date%_%time%____________%file_name%____________"

bitsadmin /transfer %job_name% /download /priority foreground /dynamic https://www.dropbox.com/download?os=win %file%