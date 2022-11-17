<# FEATURES: TWEAKS REGISTRY

    ICONS
        FileTypesMan
        fileext (& filetype?)
        .md
        .xml
        .json
        SecurityHealthSSO.dll replace yellow Defender Icon

    REGISTRY
        SET POWERSHELL PRIVILAGES to take ownership https://www.pinvoke.net/default.aspx/ntdll/RtlAdjustPrivilege.html
        windows maximize?
        search chances for netplwiz/autologin
            HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

    HIDE USERFOLDER
        hide Shell Folders in Explorer & UserFolder?!?! https://www.winhelponline.com/blog/show-hide-shell-folder-namespace-windows-10/

    PASSWORDLESS LOGIN:
        HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device
        DevicePasswordLessBuildVersion DWORD 0 == Windows Hello Disabled
        netplwiz.exe "User must enter a user name"

    COPY PATH FOLDER BACKGROUND
        https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders
#>

enum Scope {
    MACHINE
    USER
}

class Tweak {
    [string]$Name
    [Scope]$Scope
    [string]$RegContent
    [bool]$TakeOwner = $false;
    [string[]]$TakeOwnerPaths = @();
}

$tweaks = @(
    [Tweak]@{
        Name = "Disable_NewMenu_AccessDB";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.mdb\ShellNew]
        "Command"=-
        "~Command"="msaccess.exe /NEWDB 1"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_AccessDB";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.accdb\Access.Application.16\ShellNew]
        "FileName"=-
        "~FileName"="C:\\Program Files\\Microsoft Office\\root\\Office16\\1031\\ACCESS12.ACC"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_Visio";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.vsdx\Visio.Drawing.15\ShellNew]
        "FileName"=-
        "~FileName"="C:\\Program Files\\Microsoft Office\\Root\\VFS\\Windows\\ShellNew\\visio.vsdx"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_RichTextFormat";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.rtf\ShellNew]
        "Data"=-
        "ItemName"=-
        "~Data"="{\\rtf1}"
        "~ItemName"=hex(2):40,00,25,00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,\
          69,00,6c,00,65,00,73,00,25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,\
          00,20,00,4e,00,54,00,5c,00,41,00,63,00,63,00,65,00,73,00,73,00,6f,00,72,00,\
          69,00,65,00,73,00,5c,00,57,00,4f,00,52,00,44,00,50,00,41,00,44,00,2e,00,45,\
          00,58,00,45,00,2c,00,2d,00,32,00,31,00,33,00,00,00
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_Publisher";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.pub\Publisher.Document.16\ShellNew]
        "FileName"=-
        "~FileName"="C:\\Program Files\\Microsoft Office\\Root\\VFS\\Windows\\ShellNew\\mspub.pub"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_PowerPoint";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.pptx\PowerPoint.Show.12\ShellNew]
        "FileName"=-
        "~FileName"="C:\\Program Files\\Microsoft Office\\Root\\VFS\\Windows\\ShellNew\\powerpoint.pptx"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_MSProject";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.mpp\MSProject.Project.9\ShellNew]
        "FileName"=-
        "~FileName"="C:\\Program Files\\Microsoft Office\\Root\\VFS\\Windows\\ShellNew\\msproj11.mpp"
'@}

    [Tweak]@{
        Name = "Disable_NewMenu_ZipFolder";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\.zip\CompressedFolder\ShellNew]
        "Data"=-
        "ItemName"=-
        "~Data"=hex:50,4b,05,06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        "~ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
          6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
          00,7a,00,69,00,70,00,66,00,6c,00,64,00,72,00,2e,00,64,00,6c,00,6c,00,2c,00,\
          2d,00,31,00,30,00,31,00,39,00,34,00,00,00
'@}

    [Tweak]@{
        Name = "Disable_Folders_InExplorer";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        ;; Created by: Shawn Brink
        ;; Created on: April 13th 2018
        ;; Tutorial: https://www.tenforums.com/tutorials/108032-hide-show-user-profile-personal-folders-windows-10-file-explorer.html


        ;; DOWNLOADS
        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; DESKTOP
        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}\PropertyBag]
        ;; "ThisPCPolicy"="Hide"

        ;; 3D-OBJECTS
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; SAVEDGAMES
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{4C5C32FF-BB9D-43b0-B5B4-2D72E54EAAA4}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{4C5C32FF-BB9D-43b0-B5B4-2D72E54EAAA4}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; FAVORITES
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{1777F761-68AD-4D8A-87BD-30B759FA33DD}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{1777F761-68AD-4D8A-87BD-30B759FA33DD}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; LINKS
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; SEARCHES
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d1d3a04-debb-4115-95cf-2f29da2920da}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d1d3a04-debb-4115-95cf-2f29da2920da}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; CONTACTS
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{56784854-C6CB-462B-8169-88E350ACB882}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{56784854-C6CB-462B-8169-88E350ACB882}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; VIDEOS
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; DOCUMENTS
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; FAVORITES
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{1777F761-68AD-4D8A-87BD-30B759FA33DD}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{1777F761-68AD-4D8A-87BD-30B759FA33DD}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; MUSIC
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag]
        "ThisPCPolicy"="Hide"


        ;; PICTURES
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag]
        "ThisPCPolicy"="Hide"

        [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag]
        "ThisPCPolicy"="Hide"
'@}
    [Tweak]@{
        Name = "Set_StartupDelayForPrograms_toZero";
        Scope = [Scope]::USER
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize]
        "StartupDelayInMSec"=dword:00000000
'@}


    [Tweak]@{
        Name = "Block_ContextMenu_PreviouseVersion";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
        "{596AB062-B4D2-4215-9F74-E9109B0A8153}"="PreviouseVersion"
'@}

    [Tweak]@{
        Name = "Block_ContextMenu_TroubleshootCompatibility";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
        "{1d27f844-3a1f-4410-85ac-14651078412d}"="TroubleshootCompatibility"
'@}

    [Tweak]@{
        Name = "Block_ContextMenu_Share";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
        "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"="Share"
'@}

    [Tweak]@{
        Name = "Block_ContextMenu_ScanWithDefender";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
        "{09A47860-11B0-4DA5-AFA5-26D86198A780}"="ScanWithDefender"
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_PinToTaskbar";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [-HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}]
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_IncludeInLibrary";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [-HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location]
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_PinToQuickAccess";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [-HKEY_CLASSES_ROOT\Folder\shell\pintohome]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome]
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_SentTo"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]
        [-HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_PinToStartScreen";
        Scope = [Scope]::MACHINE
        RegContent = @'
        Windows Registry Editor Version 5.00

        [-HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\PintoStartScreen]
        [-HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\PintoStartScreen]
        [-HKEY_CLASSES_ROOT\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen]
        [-HKEY_CLASSES_ROOT\mscfile\shellex\ContextMenuHandlers\PintoStartScreen
'@}

    [Tweak]@{
        # HINT: NonEnum can only hide TopLevel Items in Explorer SideBar
        Name = "Hide_Explorer_TopLevelDrives"
        Scope = [Scope]::USER
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum]
        "{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}"=dword:00000001
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_EditWithPaint3D"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gif\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jfif\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tif\Shell\3D Edit]
        [-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tiff\Shell\3D Edit]
'@}

    [Tweak]@{
        Name = "Delete_ContextMenu_EditWithPaint3D"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_CLASSES_ROOT\Allfilesystemobjects\shell\windows.copyaspath]
        @="&Pfad kopieren"
        "Icon"="imageres.dll,-5302"
        "InvokeCommandOnSelection"=dword:00000001
        "VerbHandler"="{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}"
        "VerbName"="copyaspath"
'@}
    [Tweak]@{
        Name = "Block_ContextMenu_GiveAccessTo"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
        "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"="GiveAccessTo"
'@}
    [Tweak]@{
        Name = "Replace_Notepad_With_Notepad++"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe]
        "Debugger"="\"C:\\Program Files\\Notepad++\\notepad++.exe\" -notepadStyleCmdline -z"
'@}

    [Tweak]@{
        Name = "Disable_WebSearchInStartMenu"
        Scope = [Scope]::USER
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
        "DisableSearchBoxSuggestions"=dword:00000001    ;;THIS OR

        [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
        "CortanaConsent"=dword:00000000
        "AllowSearchToUseLocation"=dword:00000000
        "BingSearchEnabled"=dword:00000000              ;;THIS, BOTH WORKING AFTER EXPLORER RESTART
'@}

    [Tweak]@{
        Name = "Disable_PasswordOnFirstLogin_netplwiz"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device]
        "DevicePasswordLessBuildVersion"=dword:00000000
'@}

    [Tweak]@{
        Name = "Disable_PasswordOnFirstLogin_netplwiz"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00
        ;; TODO: ? "FriendlyTypeName"="@C:\\Program Files\\Microsoft Office\\Root\\VFS\\ProgramFilesCommonX86\\Microsoft Shared\\Office16\\oregres.dll,-107"

        [HKEY_CLASSES_ROOT\Notepad++.MD]
        @="Notepad++ Markdown File"

        ;; TODO: chance icon path
        [HKEY_CLASSES_ROOT\Notepad++.MD\DefaultIcon]
        @="C:\\Program Files\\Microsoft Office\\root\\vfs\\Windows\\Installer\\{90160000-000F-0000-1000-0000000FF1CE}\\osmadminicon.exe,0"

        [HKEY_CLASSES_ROOT\Notepad++.MD\shell]
        @="Open"

        [HKEY_CLASSES_ROOT\Notepad++.MD\shell\Open\command]
        @="\"C:\\Program Files\\Notepad++\\notepad++.exe\" \"%1\""

        [HKEY_CLASSES_ROOT\.md]
        "Content Type"="text/plain"
        "PerceivedType"="text"
        @="Notepad++.MD"

        [HKEY_CLASSES_ROOT\.md\OpenWithProgids]
        "Notepad++.MD"=hex(0):
'@}

    [Tweak]@{
        Name = "Disable_PasswordOnFirstLogin_netplwiz"
        Scope = [Scope]::MACHINE
        RegContent =@'
        Windows Registry Editor Version 5.00

        ;; ;User Profile Home folder
        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f3ce0f7c-4901-4acc-8648-d5d44b04ef8f}]
        ;; "ParsingName"="C:\\\\Users\\\\::{59031a47-3f72-44a7-89c5-5595fe6b30ee}\\"
        ;; [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f3ce0f7c-4901-4acc-8648-d5d44b04ef8f}]
        ;; "ParsingName"="C:\\\\Users\\\\::{59031a47-3f72-44a7-89c5-5595fe6b30ee}\\"

        ;Desktop
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}]
        "ParsingName"=-

        ;Local Documents
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}]
        "ParsingName"=-

        ;Local Downloads
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}]
        "ParsingName"=-

        ;Local Music
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}]
        "ParsingName"=-

        ;Local Pictures
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}]
        "ParsingName"=-

        ;Local Videos
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}]
        "ParsingName"=-
'@}

[Tweak]@{
    Name = "Modify_ContextMenuExt_Powershell"
    Scope = [Scope]::MACHINE
    TakeOwner = $true
    TakeOwnerPaths = @(
        "HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell",
        "HKEY_CLASSES_ROOT\Directory\shell\Powershell"
    )
    RegContent =@'
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell]
        @="PowerShell Konsole"
        "Extended"=""
        "Icon"="powershell.exe"
        "NoWorkingDirectory"=""
        "ShowBasedOnVelocityId"=dword:00639bc8

        [HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell\command]
        @="powershell.exe -noexit -command Set-Location -literalPath '%V'"


        [HKEY_CLASSES_ROOT\Directory\shell\Powershell]
        @="PowerShell Konsole"
        "Extended"=""
        "Icon"="powershell.exe"
        "NoWorkingDirectory"=""
        "ShowBasedOnVelocityId"=dword:00639bc8

        [HKEY_CLASSES_ROOT\Directory\shell\Powershell\command]
        @="powershell.exe -noexit -command Set-Location -literalPath '%V'"


        [HKEY_CLASSES_ROOT\Drive\shell\Powershell]
        @="PowerShell Konsole"
        "Extended"=""
        "Icon"="powershell.exe"
        "NoWorkingDirectory"=""
        "ShowBasedOnVelocityId"=dword:00639bc8

        [HKEY_CLASSES_ROOT\Drive\shell\Powershell\command]
        @="powershell.exe -noexit -command Set-Location -literalPath '%V'"
'@}

    [Tweak]@{
    Name = "Add_ContextMenuExt_CmdAdmin"
    Scope = [Scope]::MACHINE
    RegContent =@'
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\Directory\shell\OpenCmdHereAsAdmin]
        @="Cmd Konsole Admin"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "HasLUAShield"=""

        [HKEY_CLASSES_ROOT\Directory\shell\OpenCmdHereAsAdmin\command]
        @="cmd /c echo|set/p=\"%L\"|powershell -NoP -W 1 -NonI -NoL \"SaPs 'cmd' -Args '/c \"\"\"cd /d',$([char]34+$Input+[char]34),'^&^& start /b cmd.exe\"\"\"' -Verb RunAs\""

        [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenCmdHereAsAdmin]
        @="Cmd Konsole Admin"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "HasLUAShield"=""

        [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenCmdHereAsAdmin\command]
        @="cmd /c echo|set/p=\"%V\"|powershell -NoP -W 1 -NonI -NoL \"SaPs 'cmd' -Args '/c \"\"\"cd /d',$([char]34+$Input+[char]34),'^&^& start /b cmd.exe\"\"\"' -Verb RunAs\""

        [HKEY_CLASSES_ROOT\Drive\shell\OpenCmdHereAsAdmin]
        @="Cmd Konsole Admin"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "HasLUAShield"=""

        [HKEY_CLASSES_ROOT\Drive\shell\OpenCmdHereAsAdmin\command]
        @="cmd /c echo|set/p=\"%L\"|powershell -NoP -W 1 -NonI -NoL \"SaPs 'cmd' -Args '/c \"\"\"cd /d',$([char]34+$Input+[char]34),'^&^& start /b cmd.exe\"\"\"' -Verb RunAs\""

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
        "EnableLinkedConnections"=dword:00000001
'@}

    [Tweak]@{
    Name = "Add_ContextMenuExt_Cmd"
    Scope = [Scope]::MACHINE
    RegContent =@'
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\Directory\shell\OpenCmdHere]
        @="CMD Konsole"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "NoWorkingDirectory"=""

        [HKEY_CLASSES_ROOT\Directory\shell\OpenCmdHere\command]
        @="cmd.exe /s /k pushd \"%V\""


        [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenCmdHere]
        @="CMD Konsole"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "NoWorkingDirectory"=""

        [HKEY_CLASSES_ROOT\Directory\Background\shell\OpenCmdHere\command]
        @="cmd.exe /s /k pushd \"%V\""


        [HKEY_CLASSES_ROOT\Drive\shell\OpenCmdHere]
        @="CMD Konsole"
        "Extended"=""
        "Icon"="imageres.dll,-5323"
        "NoWorkingDirectory"=""

        [HKEY_CLASSES_ROOT\Drive\shell\OpenCmdHere\command]
        @="cmd.exe /s /k pushd \"%V\""
'@}

    [Tweak]@{
    Name = "Add_ContextMenuExt_PowershellAdmin"
    Scope = [Scope]::MACHINE
    RegContent =@'
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellAsAdmin]
        @="PowerShell Konsole Admin"
        "Extended"=""
        "HasLUAShield"=""
        "Icon"="powershell.exe"

        [HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellAsAdmin\command]
        @="PowerShell -windowstyle hidden -Command \"Start-Process cmd -ArgumentList '/s,/k,pushd,%V && start PowerShell && exit' -Verb RunAs\""

        [HKEY_CLASSES_ROOT\Directory\shell\PowerShellAsAdmin]
        @="PowerShell Konsole Admin"
        "Extended"=""
        "HasLUAShield"=""
        "Icon"="powershell.exe"

        [HKEY_CLASSES_ROOT\Directory\shell\PowerShellAsAdmin\command]
        @="PowerShell -windowstyle hidden -Command \"Start-Process cmd -ArgumentList '/s,/k,pushd,%V && start PowerShell && exit' -Verb RunAs\""

        [HKEY_CLASSES_ROOT\Drive\shell\PowerShellAsAdmin]
        @="PowerShell Konsole Admin"
        "Extended"=""
        "HasLUAShield"=""
        "Icon"="powershell.exe"

        [HKEY_CLASSES_ROOT\Drive\shell\PowerShellAsAdmin\command]
        @="PowerShell -windowstyle hidden -Command \"Start-Process cmd -ArgumentList '/s,/k,pushd,%V && start PowerShell && exit' -Verb RunAs\""

        ; To allow mapped drives to be available in elevated PowerShell
        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
        "EnableLinkedConnections"=dword:00000001
'@}



)

function Take-Permissions {
    # Developed for PowerShell v4.0
    # Required Admin privileges
    # Links:
    #   http://shrekpoint.blogspot.ru/2012/08/taking-ownership-of-dcom-registry.html
    #   http://www.remkoweijnen.nl/blog/2012/01/16/take-ownership-of-a-registry-key-in-powershell/
    #   https://powertoe.wordpress.com/2010/08/28/controlling-registry-acl-permissions-with-powershell/

    param($rootKey, $key, [System.Security.Principal.SecurityIdentifier]$sid = 'S-1-5-32-545', $recurse = $true)

    switch -regex ($rootKey) {
        'HKCU|HKEY_CURRENT_USER'    { $rootKey = 'CurrentUser' }
        'HKLM|HKEY_LOCAL_MACHINE'   { $rootKey = 'LocalMachine' }
        'HKCR|HKEY_CLASSES_ROOT'    { $rootKey = 'ClassesRoot' }
        'HKCC|HKEY_CURRENT_CONFIG'  { $rootKey = 'CurrentConfig' }
        'HKU|HKEY_USERS'            { $rootKey = 'Users' }
    }

    ### Step 1 - escalate current process's privilege
    # get SeTakeOwnership, SeBackup and SeRestore privileges before executes next lines, script needs Admin privilege
    $import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
    $ntdll = Add-Type -Member $import -Name NtDll -PassThru
    $privileges = @{ SeTakeOwnership = 9; SeBackup =  17; SeRestore = 18 }
    foreach ($i in $privileges.Values) {
        $null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
    }

    function Take-KeyPermissions {
        param($rootKey, $key, $sid, $recurse, $recurseLevel = 0)

        ### Step 2 - get ownerships of key - it works only for current key
        $regKey = [Microsoft.Win32.Registry]::$rootKey.OpenSubKey($key, 'ReadWriteSubTree', 'TakeOwnership')
        $acl = New-Object System.Security.AccessControl.RegistrySecurity
        $acl.SetOwner($sid)
        $regKey.SetAccessControl($acl)

        ### Step 3 - enable inheritance of permissions (not ownership) for current key from parent
        $acl.SetAccessRuleProtection($false, $false)
        $regKey.SetAccessControl($acl)

        ### Step 4 - only for top-level key, change permissions for current key and propagate it for subkeys
        # to enable propagations for subkeys, it needs to execute Steps 2-3 for each subkey (Step 5)
        if ($recurseLevel -eq 0) {
            $regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
            $rule = New-Object System.Security.AccessControl.RegistryAccessRule($sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
            $acl.ResetAccessRule($rule)
            $regKey.SetAccessControl($acl)
        }

        ### Step 5 - recursively repeat steps 2-5 for subkeys
        if ($recurse) {
            foreach($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
                Take-KeyPermissions $rootKey ($key+'\'+$subKey) $sid $recurse ($recurseLevel+1)
            }
        }
    }
}

function takeOwnershipRegistryItem ([Tweak]$tweak) {
    $sid = (New-Object System.Security.Principal.NTAccount('eno')).Translate([System.Security.Principal.SecurityIdentifier]).Value

    foreach ($path in $tweak.TakeOwnerPaths) {
        $root = $path.split("\") | select -First 1
        $key = ($path.split("\") | select -Skip 1) -join "\"

        Take-Permissions $root $key
    }
    echo $tweak.TakeOwnerPaths
}

foreach ($tweak in $tweaks)
{
    $tweak.RegContent = $tweak.RegContent.Replace("        ", "");
}


foreach ($tweak in $tweaks)
{
    echo $tweak.RegContent | Out-File -FilePath $PSScriptRoot\tweak.reg
    if ($tweak.TakeOwner) {
        #takeOwnershipRegistryItem($tweak);
        echo "$tweak.Name needs TakeOwnership feature"
    }
    reg.exe import "$($PSScriptRoot)\tweak.reg" 2>$null
}

Remove-Item $PSScriptRoot\tweak.reg