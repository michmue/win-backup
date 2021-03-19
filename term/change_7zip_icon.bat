copy "C:\Program Files\7-Zip\7-zip.dll" %~dp07-zip.dll
copy "C:\Program Files\7-Zip\7z.dll" %~dp07z.dll
copy "C:\Program Files\7-Zip\7zFM.exe" %~dp07zFM.exe

REM 7zip context menu icon TODO 32bit dll?
..\bin\ResourceHacker.exe -open 7-zip.dll -save 7-zip.dll -action addoverwrite -res "..\res\icons_7zip\icon_7zip_7-zip.dll.ico" -mask BITMAP,190,1033

REM Main Program icon?
..\bin\ResourceHacker.exe -open 7zFM.exe -save 7zFM.exe -action addoverwrite -res "..\res\icons_7zip\icon_7zip_7zFM.exe.ico" -mask ICONGROUP,1,1033

REM actual rar icon?
..\bin\ResourceHacker.exe -open 7z.dll -save 7z.dll -action addoverwrite -res "..\res\icons_7zip\icon_7zip_7z.dll.ico" -mask ICONGROUP,3,1033

pause