function Win-Backup {
[CmdletBinding()]
    param (
        [Parameter()][switch]$TweakListAll,
        [Parameter()][Tweak[]]$TweakList,
        [Parameter()][switch]$TweakListEnabled,
        [Parameter()][switch]$TweakListDisabled,
        [Parameter()][switch]$TweakEnableAll,
        [Parameter()][Tweak[]]$TweakEnable,
        [Parameter()][Tweak[]]$TweakDisable,
        [Parameter()][switch]$TweakDisableAll
    )

        if ($TweakListAll)      { Tweak-List-All                }
        if ($TweakList)         { Tweak-List $TweakList         }
        if ($TweakListEnabled)  { Tweak-List-Enabled            }
        if ($TweakListDisabled) { Tweak-List-Disabled           }
        if ($TweakEnableAll)    { Tweak-Enable-All              }
        if ($TweakEnable)       { Tweak-Enable $TweakEnable     }
        if ($TweakDisableAll)   { Tweak-Disable-All             }
        if ($TweakDisable)      { Tweak-Disable $TweakDisable   }
}

function Tweak-List-All () {
    echo "$tweaks"

    return @([Tweak]@{
        Name = ""
        Scope = [Scope]::USER
        TakeOwner = $true
        TakeOwnerPaths = @("")
    })
}


function Tweak-List ([Tweak[]] $tweaks) {
    echo "listing []tweaks..."
}

# tweaks (list)
# tweaks list enabled
# tweaks list disabled
# tweaks enable all
# tweaks enable ABC, CDE, EFG

# #TODO: requires backup before enabled
# tweaks disable all
# tweaks disable ABC, CDE, EFG


# cleanup list
# cleanup list installed
# cleanup list uninstalled
# cleanup all
# cleanup ABC, CDE, EFG


# features list
# features list installed
# features list uninstalled
# features enable all
# features enable ABC, CDE, EFG

# programs list
# programs list installed
# programs list uninstalled
# programs install all
# programs install ABC, CDE, EFG

# # TODO: backup default settings
# settings list
# settings list enabled
# settings list disabled

# backup list
# backup list export
# backup list exported
# backup list import
# backup list imported
# backup export (all)
# backup export ABC, CDE, EFG
# backup import (all)
# backup import ABC, CDE, EFG

Export-ModuleMember -Function Win-Backup