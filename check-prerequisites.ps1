# Prerequisites Check Script for RWA Tokenization Platform

Write-Host "🔍 Checking Prerequisites..." -ForegroundColor Cyan
Write-Host ""

$allGood = $true

# Check Node.js
Write-Host "Checking Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js installed: $nodeVersion" -ForegroundColor Green
    
    # Check version (should be 18+)
    $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($versionNumber -lt 18) {
        Write-Host "⚠️  Warning: Node.js version should be 18 or higher" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Node.js not found. Please install Node.js 18+ from https://nodejs.org/" -ForegroundColor Red
    $allGood = $false
}

Write-Host ""

# Check npm
Write-Host "Checking npm..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version
    Write-Host "✅ npm installed: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm not found. npm usually comes with Node.js." -ForegroundColor Red
    $allGood = $false
}

Write-Host ""

# Check if .env file exists
Write-Host "Checking .env file..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "✅ .env file exists" -ForegroundColor Green
    
    # Check if PRIVATE_KEY is set
    $envContent = Get-Content ".env" -Raw
    if ($envContent -match "PRIVATE_KEY=your_private_key_here" -or $envContent -notmatch "PRIVATE_KEY=.+") {
        Write-Host "⚠️  Warning: PRIVATE_KEY not configured in .env file" -ForegroundColor Yellow
    } else {
        Write-Host "✅ PRIVATE_KEY appears to be configured" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️  .env file not found. Run 'npm run setup:env' after installing dependencies" -ForegroundColor Yellow
}

Write-Host ""

# Check if node_modules exists
Write-Host "Checking dependencies..." -ForegroundColor Yellow
if (Test-Path "node_modules") {
    Write-Host "✅ Dependencies installed (node_modules exists)" -ForegroundColor Green
} else {
    Write-Host "⚠️  Dependencies not installed. Run 'npm install' after installing Node.js" -ForegroundColor Yellow
}

Write-Host ""

# Check if contracts are compiled
Write-Host "Checking compiled contracts..." -ForegroundColor Yellow
if (Test-Path "artifacts/contracts/RWAToken.sol") {
    Write-Host "✅ Contracts compiled (artifacts exist)" -ForegroundColor Green
} else {
    Write-Host "⚠️  Contracts not compiled. Run 'npm run compile' after installing dependencies" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=" * 50
Write-Host ""

if ($allGood) {
    Write-Host "✅ All prerequisites met! You can proceed with deployment." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Ensure .env file is configured with your PRIVATE_KEY" -ForegroundColor White
    Write-Host "2. Run: npm run compile" -ForegroundColor White
    Write-Host "3. Run: npm run deploy:sepolia" -ForegroundColor White
} else {
    Write-Host "❌ Some prerequisites are missing. Please install them first." -ForegroundColor Red
    Write-Host ""
    Write-Host "Required:" -ForegroundColor Cyan
    Write-Host "1. Install Node.js 18+ from https://nodejs.org/" -ForegroundColor White
    Write-Host "2. Run: npm install" -ForegroundColor White
    Write-Host "3. Run: npm run setup:env" -ForegroundColor White
    Write-Host "4. Configure .env file with your PRIVATE_KEY" -ForegroundColor White
}

Write-Host ""

