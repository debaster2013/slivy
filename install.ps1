$Url = "https://github.com/debaster2013/slivy/raw/refs/tags/game/MrHoppsPlayhouse2.exe"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с GitHub (это может занять немного времени)..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $Url -OutFile $OutputExe

# Проверяем размер файла, чтобы убедиться, что он скачался полностью
$FileSize = (Get-Item $OutputExe).Length
Write-Host "Загрузка завершена! Размер файла: $([math]::Round($FileSize/1MB, 2)) МБ." -ForegroundColor Green

Write-Host "Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe