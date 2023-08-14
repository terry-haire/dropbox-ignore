function Get-DBIgnorePath {
    $DBInfoPath = "$env:LOCALAPPDATA\Dropbox\info.json"
    $DBInfoContent = Get-Content -Path $DBInfoPath | ConvertFrom-Json
    $DBPath = $DBInfoContent.personal.path
    $DBIgnorePath = Join-Path -Path $DBPath -ChildPath ".dbignore"

    return $DBIgnorePath
}

function Set-IgnoreFlag {
    param(
        [string] $Path
    )

    if (-Not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType "directory"
    }

    Set-Content -Path $Path -Stream com.dropbox.ignored -Value 1

    Get-Content -Path $Path -Stream com.dropbox.ignored
}
