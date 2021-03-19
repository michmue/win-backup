@echo off
for /f "tokens=3 usebackq" %%a in (`reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" ^| findstr TEMP`)  do @echo System variable TEMP = %%a
for /f "tokens=3 usebackq" %%a in (`reg query "HKEY_CURRENT_USER\Environment" ^| findstr TEMP`)  do @echo Current user variable TEMP = %%a