#   input   process     validation      output
#   none    

$appxPrograms = @(
"microsoft.windowscommunicationsapps",
"Microsoft.BingWeather",
"Microsoft.Microsoft3DViewer",
"Microsoft.GetHelp",
"Microsoft.Getstarted",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.Office.OneNote",
"Microsoft.People",
"Microsoft.SkypeApp",
"Microsoft.YourPhone",
"Microsoft.ZuneMusic",
"Microsoft.ZuneVideo",
"Microsoft.WindowsMaps",
"Microsoft.549981C3F5F10", # cortana
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MixedReality.Portal",
"Microsoft.MSPaint",
"Microsoft.Wallet",
"Microsoft.Windows.Photos",
"Microsoft.WindowsFeedbackHub",
"Microsoft.WindowsSoundRecorder",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay"
)

function Remove-WBDefaultPrograms {
    
    $appxPrograms | % {
        Get-AppxPackage -AllUsers $_ | Remove-AppxPackage
        Get-ProvisionedAppPackage -Online | ? DisplayName -EQ $_ | Remove-ProvisionedAppPackage -Online -AllUsers >$null
    }
    
}

Export-ModuleMember -Function Remove-WBDefaultPrograms