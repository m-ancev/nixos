# Define the source and destination directories
$sourcePath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\nixos\common\nvim"
$destinationPath = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\nvim"
$oldDataPath = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\nvim-data"

# Remove all contents from the destination directory
Write-Host "deleting configuration files in: $destinationPath ..."
Remove-Item -Path "$destinationPath\*" -Recurse -Force
Write-Host "done`n"


$confirmation = Read-Host "also delete data files in ${oldDataPath}? (y/n)"
if ($confirmation -match '^[Yy]$') {
    Write-Host "deleting files in data path: $oldDataPath ..."
    Remove-Item -Path "$oldDataPath\*" -Recurse -Force
    Write-Host "done`n"
} else {
    Write-Host "data will persist`n"
}

# Copy all contents from the source directory to the destination directory
Write-Host "copying files from source path: $sourcePath into destination path: $destinationPath ..."
Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -Recurse -Force
Write-Host "done`n"

Write-Host "migration completed`n"
