# IMPR: check for installed programs / path first; installtion after could override configs
function Import-WBBackup {
    [CmdletBinding()]
    param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if (-Not ($_ | Test-Path -PathType Container) ) {
                    throw "File or folder does not exist"
                }
                return $true
            })]
        $Path,
        [PSCustomObject] $AppsJsonConfig
    )

    foreach ($appConfig in $AppsJsonConfig) {


        $srcFolder = "$Path/$($appConfig.Name)"

        foreach ($folder in $appConfig.Folders) {
            if (-Not $folder) { continue; }

            $folder = $ExecutionContext.InvokeCommand.ExpandString($folder)


            if ($appConfig.Name -eq "Firefox") {
                # select first '../profiles/*default-release' to remove '*' in path
                try {
                    $folder = (gci $folder)[0]
                }
                catch {
                    Write-Warning "Firefox found no profile, skipping firefox import"
                    continue;
                }
            }

            if (Test-Path -Path $folder -PathType Container) {
                Write-Host "override folder: $folder"
            } else {
                Write-Host "create folder: $folder"
                New-Item $folder -ItemType Directory -Force > $null
            }
            copy $srcFolder/* $folder -Recurse -Force -ErrorAction Continue
        }


        foreach ($file in $appConfig.Files) {
            if (-Not $file) { continue; }

            $file = $ExecutionContext.InvokeCommand.ExpandString($file)
            $fileName = Split-Path -Path $file -Leaf
            $fileSrc = "$Path/$($appConfig.Name)/$fileName"

            if ($appConfig.Name -eq "Policy") {
                $parentFolder = (Split-Path $file) -split "\\" | Select -Last 1
                $fileSrc = "$Path/$($appConfig.Name)/$parentFolder/$fileName"
            }

            if (Test-Path -Path $file -PathType Leaf) {
                Write-Host "override file: $file"
            }
            else {
                Write-Host "create file: $file"
                New-Item -Path $file -ItemType File -Force > $null
            }
            copy $fileSrc $file -Force -ErrorAction Continue
        }


        # FEAT: add export regValue similar to regTree
        # FEAT: add export regKey similar to regTree
        foreach ($regTree in $appConfig.RegistryTrees) {
            if (-Not $regTree) { continue; }
            $regTree = $ExecutionContext.InvokeCommand.ExpandString($regTree)

            if (Test-Path $regTree -PathType Container) {
                Write-Host "override reg: $regTree"
            }
            else {
                Write-Host "create reg: $regTree"
            }
            $regTree = $regTree -replace ":", "\" -replace "/", "\"
            reg import "$($(gci "$srcFolder\$($appConfig.Name).reg").FullName)" 2>&1> $null
        }
    }
}

Export-ModuleMember -Function Import-WBBackup