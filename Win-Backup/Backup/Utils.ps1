$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$Mouse = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru
[system.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
function Get-ContextMenuScreenshot ([Switch]$ExtendedContexMenu) {
    $size = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
    $width = $size.width
    $height = $size.height
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($width, $height)

    # IMPR: shift for extended Context Menu: https://stackoverflow.com/questions/11071781/holding-shift-while-clicking
    $Mouse::mouse_event(0x00000002, 0, 0, 0, 0);
    $Mouse::mouse_event(0x00000004, 0, 0, 0, 0);

    sleep -Milliseconds 500
    $rightClickPosX = $width/2
    $rightClickPosY = $height*0.95
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($rightClickPosX, $rightClickPosY)
    $Mouse::mouse_event(0x00000008, 0, 0, 0, 0);
    $Mouse::mouse_event(0x00000010, 0, 0, 0, 0);

    sleep -Milliseconds 200
    [System.Windows.Forms.Sendkeys]::SendWait("n")

    sleep -Milliseconds 500
    [System.Windows.Forms.Sendkeys]::SendWait("{PrtSc}")
    [System.Windows.Forms.Sendkeys]::SendWait("{Win}{PrtSc}")

    get-clipboard -format image
    $img = get-clipboard -format image
    $img.save("$PSScriptRoot\ContextMenuEntries.png")
}