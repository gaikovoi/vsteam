function Get-VSTeamQuery {
   [CmdletBinding()]
   param(
      [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
      [vsteam_lib.ProjectValidateAttribute($false)]
      [ArgumentCompleter([vsteam_lib.ProjectCompleter])]
      [string] $ProjectName,

      [int] $Depth = 1, 

      [switch] $IncludeDeleted,

      [ValidateSet('all', 'clauses', 'minimal', 'none', 'wiql')]
      [string] $Expand = 'none'
   )

   process {
      $resp = _callAPI -ProjectName $projectName `
         -Area wit `
         -Resource queries `
         -QueryString @{ 
         '$depth'          = $Depth 
         '$expand'         = $Expand
         '$includeDeleted' = $IncludeDeleted.IsPresent
      } `
         -Version $(_getApiVersion Core)

      $obj = @()

      foreach ($item in $resp.value) {
         _applyTypes $item "Team.Query"
         $obj += $item
      }

      Write-Output $obj
   }
}
