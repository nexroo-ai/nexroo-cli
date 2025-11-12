$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Nexroo CLI Installer" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$pipCmd = $null
if (Get-Command pip -ErrorAction SilentlyContinue) {
    $pipCmd = "pip"
} elseif (Get-Command pip3 -ErrorAction SilentlyContinue) {
    $pipCmd = "pip3"
} else {
    Write-Host "Error: pip is not installed. Please install Python 3.10+ first." -ForegroundColor Red
    exit 1
}

Write-Host "Installing nexroo-cli..." -ForegroundColor Yellow
& $pipCmd install nexroo-cli

Write-Host ""
Write-Host "Installing ai-rooms-script binary..." -ForegroundColor Yellow
nexroo install

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "   Installation Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Authenticate: nexroo login" -ForegroundColor White
Write-Host "  2. Run workflow: nexroo run workflow.json" -ForegroundColor White
Write-Host ""
