# TODO: Loop through all ignores in .dbignore
. ".\helpers.ps1"

# Call the function to get the Dropbox .dbignore path
$DBIgnorePath = Get-DBIgnorePath

# Display the path
Write-Host "Dropbox .dbignore Path: $DBIgnorePath"

# Check if the file exists
if (Test-Path $DBIgnorePath) {
    $lines = Get-Content -Path $DBIgnorePath

    foreach ($line in $lines) {
        Write-Host "Setting ignored for $line"

        Set-IgnoreFlag -Path $line
    }
} else {
    Write-Host "File not found: $DBIgnorePath"
}
