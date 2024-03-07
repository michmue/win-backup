# Enable-VMIntegrationService -VMName MyTestVM -Name "Guest Service Interface"
# $prevHashes = @()
# Get-Content .\.vm\hashes -ErrorAction SilentlyContinue | % {
#     $item = $_.Split('  ')
#     $prevHashes += [pscustomobject]@{ 
#         "Path"= $item[0];
#         "Hash"= $item[1]
#     }
# }

# $currHashes = @()
# Get-ChildItem -File -Recurse | ? {@(".vm", ".vscode") -notcontains $_.Directory.Name} | % {
#     $hash = Get-FileHash $_.FullName
#     $currHashes += [pscustomobject]@{
#         "Path"= $_.FullName;
#         "Hash"= $hash.Hash
#     }
# }


# $currHashes | % {
#     "$($_.Path)  $($_.Hash)" >> .\.vm\hashes
# }

# $currHashes | ? {$_.Path -in $currHashes.Path} | % {

# }

$VMName = "Clean10"
#$CheckpointName = "fresh_install_network"
#$VM = Get-VM -Name $VMName
#$Checkpoint = Get-VMSnapshot -VM $VM -Name $CheckpointName
#Restore-VMSnapshot -VMSnapshot $Checkpoint -Confirm:$false



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