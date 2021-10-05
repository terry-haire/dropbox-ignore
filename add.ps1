Param (
    # Parameter help description
    [Parameter(Mandatory)]
    [String]$Path
)

if ($PSVersionTable.PSVersion.Major -gt 5) {
    powershell -Version 5 -File $MyInvocation.MyCommand.Definition -Path $Path
    exit
}

if (-Not (Test-Path -Path $Path)) {
    New-Item -Path $Path -ItemType "directory"
}

Set-Content -Path $Path -Stream com.dropbox.ignored -Value 1

Get-Content -Path target -Stream com.dropbox.ignored

# Add to .dbignore (Dropbox Ignore).
# TODO: Remove dropbox path prefix.
# TODO: Make path unix style.
$DBPath = (ConvertFrom-Json -InputObject (Get-Content $env:LOCALAPPDATA\Dropbox\info.json)).personal.path
$DBIgnorePath = $DBPath + "\.dbignore"
Add-Content -Path $DBIgnorePath -Value ${Path}
