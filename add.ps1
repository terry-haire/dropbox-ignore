Param (
    # Parameter help description
    [Parameter(Mandatory)]
    [String]$Path
)

. ".\helpers.ps1"

# Make path absolute.
$Path = Resolve-Path -Path $Path

if ($PSVersionTable.PSVersion.Major -gt 5) {
    powershell -Version 5 -File $MyInvocation.MyCommand.Definition -Path $Path
    exit
}

Set-IgnoreFlag -Path $Path

# Add to .dbignore (Dropbox Ignore).
# TODO: Remove dropbox path prefix.
# TODO: Make path unix style.
# TODO: Trailing slash causes crash
$DBIgnorePath = Get-DBIgnorePath

Add-Content -Path $DBIgnorePath -Value ${Path}
