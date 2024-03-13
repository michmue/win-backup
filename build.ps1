$functions = @()
$nestedModules = @()

$modPaths = Get-ChildItem *.psm1 -Recurse -File
foreach ($modPath in $modPaths) {
    $fullPath = $modPath.FullName
    $moduleName = ($modPath.Name) -split '\.' | select -First 1


    if ($moduleName -eq "Win-Backup") {
        continue
    }

    cd .\Win-Backup
    $relativePath = (Resolve-Path -path $fullPath -Relative )
    cd ..

    Import-Module $fullPath
    $m = (Get-Module $moduleName)
    $functions += $m.ExportedCommands.Keys
    $nestedModules += $relativePath
    $m | Remove-Module -Force
}

$functions = $functions | select -Unique | sort
$nestedModules = $nestedModules | select -Unique | sort

New-ModuleManifest -Path ".\Win-Backup\Win-Backup.psd1" -NestedModules $nestedModules -RootModule ".\Win-Backup\Win-Backup.psm1" -FunctionsToExport $functions -Verbose
