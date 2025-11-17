$ErrorActionPreference = "Stop"

$REPO = "nexroo-ai/nexroo-cli"
$INSTALL_DIR = "$env:USERPROFILE\.nexroo\bin"
$BINARY_NAME = "nexroo-cli.exe"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Nexroo CLI Installer" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$PLATFORM = "windows-amd64.exe"
Write-Host "Detected platform: Windows" -ForegroundColor Yellow
Write-Host ""

Write-Host "Fetching latest release..." -ForegroundColor Yellow
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$REPO/releases/latest"
$asset = $release.assets | Where-Object { $_.name -like "*nexroo-cli-$PLATFORM" }

if (-not $asset) {
    Write-Host "Error: Could not find binary for Windows" -ForegroundColor Red
    exit 1
}

$DOWNLOAD_URL = $asset.browser_download_url

Write-Host "Downloading nexroo-cli..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null
Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile "$INSTALL_DIR\$BINARY_NAME"

$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$INSTALL_DIR*") {
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "   Add to PATH" -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Adding $INSTALL_DIR to PATH..." -ForegroundColor White
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$INSTALL_DIR", "User")
    $env:Path = "$env:Path;$INSTALL_DIR"
    Write-Host "PATH updated. You may need to restart your terminal." -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "   Installation Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Installed to: $INSTALL_DIR\$BINARY_NAME" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Authenticate: nexroo-cli login" -ForegroundColor White
Write-Host "  2. Install Engine: nexroo-cli install" -ForegroundColor White
Write-Host "  3. Run workflow: nexroo-cli run workflow.json" -ForegroundColor White
Write-Host ""
