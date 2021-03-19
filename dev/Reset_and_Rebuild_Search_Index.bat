@echo off
@Echo Reset and Rebuiild the Search Index by MajorGeeks.Com. This shouldn't take long.
net stop wsearch
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
:wsearch
net start wsearch
IF NOT %ERRORLEVEL%==0 (goto :wsearch) ELSE goto :END
:END