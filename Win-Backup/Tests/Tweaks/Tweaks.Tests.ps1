Import-Module .\Win-Backup -wa SilentlyContinue

Describe 'Win-Backup -TweakListAll' {
    $properties = @(
        @{ propertyName = "Name";}
        @{ propertyName = "Scope"}
        @{ propertyName = "TakeOwner"}
        @{ propertyName = "TakeOwnerPaths"}
    )

    It "Tweak Objects contain property <propertyName>" -ForEach $properties {
        Win-Backup -TweakListAll | Get-Member $propertyName | Should -Not -Be $null
    }
}