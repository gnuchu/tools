[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [String]
    [ValidateNotNullOrEmpty()]
    $ProjectName
)

$Clone = "git@github.com:gnuchu/ruby_starter.git"

try {
    $Git = (Get-Command -ErrorAction Continue git).source
}
catch [CommandNotFoundException],[System.SystemException] {
  Write-Host "Git not found. Please install."
  Write-Host $_
}

$CurrentPath = (Get-Location).path
$TargetPath = $CurrentPath + '\' + $ProjectName

New-Item -ItemType Directory -Path $TargetPath
Set-Location -Path $TargetPath

$Command = "& '${Git}' clone ${Clone} ."
Invoke-Expression -Command $Command

Remove-Item -force -recurse -Path ".git"
Write-Output "" > README.md 

$Command = "& '${Git}' init"
Invoke-Expression -Command $Command

$Command = "& '${Git}' add ."
Invoke-Expression -Command $Command

$Command = "& '${Git}' commit -am `"Initial Import`""
Invoke-Expression -Command $Command

Set-Location -Path $CurrentPath