# Enable-VMIntegrationService -VMName MyTestVM -Name "Guest Service Interface"

$VMName = "Clean10"
$CheckpointName = "fresh_install"

$VM = Get-VM -Name $VMName
$Checkpoint = Get-VMSnapshot -VM $VM -Name $CheckpointName
Restore-VMSnapshot -VMSnapshot $Checkpoint -Confirm:$false



# Define the source and destination paths
$source = "."
$destination = "C:\Users\eno\Desktop\Win-Backup"

$files = Get-ChildItem -Path $source -File -Recurse
$files | % {
    $file = $_
    $childDest = $file.FullName -replace [regex]::Escape(((Resolve-Path .\).ToString() + '\'))
    $dest = Join-Path -Path $destination -ChildPath $childDest
    Copy-VMFile -Name $VMName -SourcePath $file.FullName -DestinationPath $dest -CreateFullPath -FileSource Host -Force
}



$username = "eno"
$password = ConvertTo-SecureString "mischel1" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

Invoke-Command -VMName Clean10 -Credential $psCred -ScriptBlock {
    cd $env:USERPROFILE\Desktop\Win-Backup
    . .\run.ps1
}