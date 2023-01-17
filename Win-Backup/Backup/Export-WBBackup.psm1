
function Export-WBBackup {
    [CmdletBinding()]
    param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        $Path,
        [PSCustomObject] $AppsJsonConfig
    )

    foreach ($appConfig in $AppsJsonConfig) {
        foreach ($folder in $appConfig.Folders) {
            if (-Not $folder) { continue; }

            $folder = $ExecutionContext.InvokeCommand.ExpandString($folder)
            if (Test-Path -Path $folder -PathType Container) {
                Write-Host "copy folder: $folder"
                $dirDestination = "$Path/$($appConfig.Name)"
                mkdir $dirDestination -Force > $null
                copy $folder/* "$Path/$($appConfig.Name)/" -Recurse -Force -ErrorAction Continue
            }
        }


        foreach ($file in $appConfig.Files) {
            if (-Not $file) { continue; }

            $file = $ExecutionContext.InvokeCommand.ExpandString($file)
            Write-Host "copy file: $file"

            $fileName = Split-Path -Path $file -Leaf
            $newItemPath = "$Path/$($appConfig.Name)/$fileName"

            if ($appConfig.Name -eq "Policy") {
                $parentFolder = (Split-Path $file) -split "\\" | Select -Last 1
                $newItemPath = "$Path/$($appConfig.Name)/$parentFolder/$fileName"
            }

            New-Item -Path $newItemPath -ItemType File -Force > $null
            copy $file $newItemPath -Force -ErrorAction Continue
        }


        # FEAT: add export regValue similar to regTree
        # FEAT: add export regKey similar to regTree
        foreach ($regTree in $appConfig.RegistryTrees) {
            if (-Not $regTree) { continue; }

            $regTree = $ExecutionContext.InvokeCommand.ExpandString($regTree)

            if (Test-Path $regTree -PathType Container) {
                $regTree = $regTree -replace ":", "\" -replace "/", "\"

                $dirDestination = "$Path\$($appConfig.Name)"
                mkdir $dirDestination -Force > $null

                reg export $regTree "$dirDestination\$($appConfig.Name).reg" /y > $null
            }
        }
    }
}

function Read-WBBackupConfig {
    [CmdletBinding()]
    param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "File or folder does not exist"
            }
            if ($_ -notmatch "\.json$") {
                throw "The file specified in the path argument must end with .json"
            }
            return $true
        })]
        $Path
    )

    $config = Get-Content -Path $Path | ConvertFrom-Json
    return $config
}


Export-ModuleMember -Function Export-WBBackup, Read-WBBackupConfig