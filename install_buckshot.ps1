$Url = "https://github.com/debaster2013/slivy/releases/download/game/buckshot.zip"
$OutputDir = "$env:USERPROFILE\Desktop\BuckshotGame"
$ZipFile = "$OutputDir\buckshot.zip"
$OutputExe = "$OutputDir\Buckshot Roulette.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю Buckshot Roulette с GitHub..." -ForegroundColor Yellow
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($Url, $ZipFile)

Write-Host "Распаковываю архив..." -ForegroundColor Yellow
Expand-Archive -Path $ZipFile -DestinationPath $OutputDir -Force

Write-Host "Удаляю временный архив..." -ForegroundColor Yellow
Remove-Item $ZipFile

Write-Host "Запускаю игру..." -ForegroundColor Green
Start-Process "$OutputExe"

# Автоматически закрываем окно PowerShell после запуска
exit