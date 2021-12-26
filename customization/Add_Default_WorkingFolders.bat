@echo off

for %%i in (
	projects
	term
	tools
	vm
) do (
	mkdir c:\%%i 
	copy ..\res\icons_folders\%%i.ico c:\%%i\
	
	ECHO [.ShellClassInfo] > C:\%%i\desktop.in
	ECHO IconResource=C:\%%i\%%i.ico,0 >> C:\%%i\desktop.in
	move C:\%%i\desktop.in C:\%%i\desktop.ini
	attrib +S +H C:\%%i\desktop.ini	
	attrib +S +H C:\%%i\%%i.ico
)