$powershells = @("$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk")
$colorTool = "$PSScriptRoot\..\..\bin\ColorTool.exe"
$powershellColor = "$PSScriptRoot\..\..\res\terminal_colors\powershell.ini"

foreach ($ps in $powershells)
{
    start $ps -ArgumentList "$colorTool $powershellColor;Write-Host 'Set: size to 140x40, font to Meslo LGM NF';Pause"
}