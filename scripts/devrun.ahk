#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance FORCE
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,2

firefox_script_title := "dev-script - Greasemonkey Benutzerskript-Editor - Mozilla Firefox"
global pc_user := A_ComputerName . "_" . A_UserName
StringLower, pc_user, pc_user

uri := readExtensionURI()
clipboard := uri


WinActivate, %firefox_script_title%
if not WinActive(firefox_script_title) {
    WinActivate, ahk_class MozillaWindowClass
    WinWaitActive, ahk_class MozillaWindowClass
    Send, ^t^v{enter}

    WinWaitActive %firefox_script_title%
}

FileRead, clipboard, addon-nh4.user.js

Send, ^l
sleep, 50
Send, {F6} ;^l{F6} Focus main page
sleep, 50
Send, {tab}^a ;focues actual content control & select all
sleep, 100
Send, ^v
sleep, 100
Send, ^s
sleep, 150
Send, ^w

WinWaitNotActive %firefox_script_title%
WinWaitActive, ahk_class MozillaWindowClass
Send, {F5}
return

readExtensionURI(){
        loop {
            FileReadLine, line, addon-nh4.user.js, % A_Index
            line := SubStr(line, 3)
            data := StrSplit(line, ",")
            pc_user_line := data[1]
            extension_uri := data[2]

            StringLower, pc_user_line, pc_user_line
            if (pc_user_line == pc_user)
                return extension_uri

            isExtensionURIParsed := InStr(line, "==UserScript==")
            if (isExtensionURIParsed)
                break
        }

    return
}