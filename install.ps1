$Url = "https://github.com/debaster2013/slivy/releases/download/game/MrHoppsPlayhouse2.exe"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с GitHub (это может занять немного времени)..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $Url -OutFile $OutputExe

Write-Host "Загрузка завершена! Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe