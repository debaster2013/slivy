$Url = "https://github.com/debaster2013/slivy/raw/refs/tags/game/MrHoppsPlayhouse2.exe"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с GitHub (файл большой, подожди пару минут)..." -ForegroundColor Yellow

# Используем .NET WebClient с отключением таймаутов для больших файлов
$WebClient = New-Object System.Net.WebClient
$WebClient.Headers.Add("User-Agent", "Mozilla/5.0")

try {
    $WebClient.DownloadFile($Url, $OutputExe)
    Write-Host "Загрузка успешно завершена!" -ForegroundColor Green
}
catch {
    Write-Host "Ошибка при скачивании: $_" -ForegroundColor Red
    exit
}
finally {
    $WebClient.Dispose()
}

# Проверяем размер файла
if (Test-Path $OutputExe) {
    $FileSize = (Get-Item $OutputExe).Length
    Write-Host "Размер файла: $([math]::Round($FileSize/1MB, 2)) МБ." -ForegroundColor Cyan
    
    if ($FileSize -gt 1000000) {
        Write-Host "Запускаю игру..." -ForegroundColor Green
        Start-Process $OutputExe
    } else {
        Write-Host "Ошибка: файл скачался не полностью или поврежден." -ForegroundColor Red
    }
} else {
    Write-Host "Ошибка: файл не найден на диске." -ForegroundColor Red
}