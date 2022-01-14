#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance FORCE
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,2 



FileReadLine, clipboard, addon-nh4.user.js, 1
clipboard := SubStr(clipboard, 3)

WinActivate, ahk_class MozillaWindowClass
WinWaitActive, ahk_class MozillaWindowClass

Send, ^t^v{enter}
Sleep, 550

FileRead, clipboard, addon-nh4.user.js
Send, ^a^v^s^w
Sleep, 100
Send, {F5}
return