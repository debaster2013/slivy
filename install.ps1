$Url = "https://github.com/debaster2013/slivy/releases/download/game/MrHoppsPlayhouse2.exe"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с GitHub (файл весит 76 МБ, подожди немного)..." -ForegroundColor Yellow

# Используем .NET WebClient, который качает бинарники напрямую без HTML-ошибок
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($Url, $OutputExe)

# Проверяем размер скачанного файла
$FileSize = (Get-Item $OutputExe).Length
Write-Host "Загрузка завершена! Размер файла: $([math]::Round($FileSize/1MB, 2)) МБ." -ForegroundColor Green

Write-Host "Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe