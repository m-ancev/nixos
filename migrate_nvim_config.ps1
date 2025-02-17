
# Define the source and destination directories
$sourcePath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop\nixos\common\nvim"
$destinationPath = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\nvim"
$oldDataPath = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\nvim-data"

# Remove all contents from the destination directory and old data path
Write-Host "deleting files in destination path: $destinationPath ..."
Remove-Item -Path "$destinationPath\*" -Recurse -Force
Write-Host "done"

Write-Host "deleting files in data path: $oldDataPath ..."
Remove-Item -Path "$oldDataPath\*" -Recurse -Force
Write-Host "done"

# Copy all contents from the source directory to the destination directory
Write-Host "copying files from source path: $sourcePath into destination path: $destinationPath ..."
Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -Recurse -Force
Write-Host "done"

Write-Host "migration complete"
