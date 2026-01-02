Write-Host "🏗️  Building Hugo site..." -ForegroundColor Cyan
hugo --gc --minify

Write-Host "✅ Build complete! Output in public/" -ForegroundColor Green