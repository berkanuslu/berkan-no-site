Write-Host "Copying all photos to content root with category prefixes..." -ForegroundColor Cyan

# Create content directory if it doesn't exist
if (-not (Test-Path "content")) {
    New-Item -ItemType Directory -Force -Path "content" | Out-Null
}

# Remove old photos
Remove-Item content\*.webp -Force -ErrorAction SilentlyContinue
Remove-Item content\*.jpg -Force -ErrorAction SilentlyContinue

$totalCount = 0

# Function to copy and rename photos with category prefix
function Copy-PhotosWithPrefix {
    param(
        [string]$SourceDir,
        [string]$Prefix
    )
    
    $files = Get-ChildItem -Path $SourceDir -Filter *.webp -File -ErrorAction SilentlyContinue
    
    if ($files.Count -eq 0) {
        Write-Host "⚠️  No WebP photos found in $SourceDir" -ForegroundColor Yellow
        return 0
    }
    
    $count = 0
    foreach ($file in $files) {
        $newName = "${Prefix}_$($file.Name)"
        Copy-Item $file.FullName -Destination "content\$newName" -Force
        $count++
    }
    
    Write-Host "✅ Copied $count photos with prefix '$Prefix'" -ForegroundColor Green
    return $count
}

# Copy all photos with category prefixes
$totalCount += Copy-PhotosWithPrefix "static\images\analog\black-white" "analog-bw"
$totalCount += Copy-PhotosWithPrefix "static\images\analog\color" "analog-color"
$totalCount += Copy-PhotosWithPrefix "static\images\digital\black-white" "digital-bw"
$totalCount += Copy-PhotosWithPrefix "static\images\digital\color" "digital-color"

Write-Host "`n✅ Total photos copied: $totalCount" -ForegroundColor Green