<# FEATURES: TWEAKS REGISTRY

    ICONS
        FileTypesMan
        fileext (& filetype?)
        .md
        .xml
        .json
        .php
        SecurityHealthSSO.dll replace yellow Defender Icon

    REGISTRY
        windows maximize?
        search chances for netplwiz/autologin
            HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

    WHITELIST USERFOLDER
        https://www.winhelponline.com/blog/show-hide-shell-folder-namespace-windows-10/

    PASSWORDLESS LOGIN:
        HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device
        DevicePasswordLessBuildVersion DWORD 0 == Windows Hello Disabled
        netplwiz.exe "User must enter a user name"

    COPY PATH FOLDER BACKGROUND
        https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders
#>

class Property {
    [string]$Name
    [string]$Value
    [string]$Type
}

class Key {
    [string]$Key
    [string]$Comment
    [Property[]]$Properties
}

class Tweak {
    [string]$Name
    [Key[]]$Keys
}


function Take-Ownership ([string]$key) {
    $AdjustTokenPrivileges = @"
    using System;
    using System.Runtime.InteropServices;

    public class TokenManipulator {
        [DllImport("kernel32.dll", ExactSpelling = true)]
        internal static extern IntPtr GetCurrentProcess();

        [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
        internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall, ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);
        [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
        internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);
        [DllImport("advapi32.dll", SetLastError = true)]
        internal static extern bool LookupPrivilegeValue(string host, string name, ref long pluid);

        [StructLayout(LayoutKind.Sequential, Pack = 1)]
            internal struct TokPriv1Luid {
            public int Count;
            public long Luid;
            public int Attr;
        }

        internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
        internal const int TOKEN_QUERY = 0x00000008;
        internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;

        public static bool AddPrivilege(string privilege) {
            bool retVal;
            TokPriv1Luid tp;
            IntPtr hproc = GetCurrentProcess();
            IntPtr htok = IntPtr.Zero;
            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
            tp.Count = 1;
            tp.Luid = 0;
            tp.Attr = SE_PRIVILEGE_ENABLED;
            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);

            return retVal;
        }
  }
"@

    Add-Type $AdjustTokenPrivileges -PassThru > $null
    [void][TokenManipulator]::AddPrivilege("SeTakeOwnershipPrivilege")

    $admins = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-544")
    $admins = $admins.Translate([System.Security.Principal.NTAccount])

    switch ($key.Split("\")[0]) {
        "HKEY_CLASSES_ROOT" { $rootKey = [Microsoft.Win32.Registry]::ClassesRoot }
        "HKEY_CURRENT_USER" { $rootKey = [Microsoft.Win32.Registry]::CurrentUser }
        "HKEY_LOCAL_MACHINE" { $rootKey = [Microsoft.Win32.Registry]::LocalMachine }
    }

    $subKey = ($key.Split("\") | select -Skip 1) -join "\"
    $keyItem = $rootKey.OpenSubKey($subKey,
        [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
        [System.Security.AccessControl.RegistryRights]::TakeOwnership
    );

    $acl = $keyItem.GetAccessControl()
    $acl.SetOwner($admins)
    $keyItem.SetAccessControl($acl)

    $ruleR = $acl.Access | ? IdentityReference -eq VORDEFINIERT\Administratoren
    $ruleR | % { $acl.RemoveAccessRuleSpecific($_) }

    $rule = New-Object System.Security.AccessControl.RegistryAccessRule(
            $admins,
            [System.Security.AccessControl.RegistryRights]::FullControl,
            [System.Security.AccessControl.InheritanceFlags]::ContainerInherit,
            [System.Security.AccessControl.PropagationFlags]::None,
            [System.Security.AccessControl.AccessControlType]::Allow
    )

    $acl.AddAccessRule($rule)
    $keyItem.SetAccessControl($acl)
}


function Test-Administrator
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}


function Enable-WBTweak {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [Tweak[]]
        $Tweaks
        )

    begin {
        if (-Not (Test-Administrator)) {
            throw "Requires administrator rights"
            return
        }

        $Tweaks = @($Tweaks)
        if ($null -eq (Get-PSDrive "HKCR*")) {
            New-PSDrive HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        }
    }

    process {
        foreach ($tweak in $Tweaks)
        {
            foreach ($key in $tweak.Keys) {
                $path = $key.key

                foreach ($p in ($key.Properties)) {
                    try {
                        New-Item -Path $path -Force #creates missing subtree keys
                        Set-ItemProperty -Path $path -Name $p.Name -Value $p.Value -Type $p.Type -ErrorAction Stop

                    } catch [System.Management.Automation.ItemNotFoundException] {
                        throw "Subkeys not created, should not happen!"

                    } catch [System.Security.SecurityException] {
                        Write-Warning "Full Access Controll set for:`r`n$key"
                        Take-Ownership (Convert-Path $path)
                        Set-ItemProperty -Path $path -Name $p.Name -Value $p.Value -Type $p.Type
                    }
                }
            }
        }
    }
}

function Get-ValueKind ([string]$key, $ValueName) {
    $root = Split-Path $key -Qualifier
    $path = Convert-Path $key
    switch ($root) {
        "HKCU:" { $reg = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($path) }
        "HKCR:" { $reg = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey($path) }
        "HKLM:" { $reg = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($path) }
        Default {}
    }

    $valueKind = $reg.GetValueKind($ValueName)
    $reg.close()
    return $valueKind
}

function Get-WBTweak {
    [CmdletBinding()]
    param (
        [string[]]$Name,
        [string[]]$Key,
        [string[]]$EntrieName,
        [string[]]$EntrieValue,
        [string[]]$EntrieType
    )

        $filterdTweaks = [Tweak[]](Get-Content "$PSScriptRoot\tweaks.json" | ConvertFrom-Json)

        $Names = @($Name)
        $Keys = @($Key)
        $EntrieNames = @($EntrieName)
        $EntrieValues = @($EntrieValue)
        $EntrieTypes = @($EntrieType)

        foreach ($name in $Names) {
            if ($null -eq $name) { continue }
            $filterdTweaks = $filterdTweaks | ? Name -like $name
        }

        foreach ($key in $Keys) {
            if ($null -eq $key) { continue }
            $filterdTweaks = $filterdTweaks | ? { $_.Keys.Key -like $key }
        }

        foreach ($entrieName in $EntrieNames) {
            if ($null -eq $entrieName) { continue }
            $filterdTweaks = $filterdTweaks | ? { $_.Keys.Properties.Name -like $entrieName }
        }

        foreach ($entrieValue in $EntrieValues) {
            if ($null -eq $entrieValue) { continue }
            $filterdTweaks = $filterdTweaks | ? { $_.Keys.Properties.Value -like $entrieValue }
        }

        foreach ($entrieType in $EntrieTypes) {
            if ($null -eq $entrieType) { continue }
            $filterdTweaks = $filterdTweaks | ? { $_.Keys.Properties.Type -like $entrieType }
        }

        return $filterdTweaks
}

Export-ModuleMember -Function Get-WBTweak, Enable-WBTweak