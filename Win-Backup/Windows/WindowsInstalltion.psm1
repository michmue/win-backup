function Invoke-ProgramInstalltion {
  [CmdletBinding()]
  param(
    [parameter(ValueFromPipeline)]
    [Program]
    $program
  )

  process {
    Install $program
  }
}

function Install ([Program]$program) {

}

Export-ModuleMember -Function Invoke-ProgramInstalltion