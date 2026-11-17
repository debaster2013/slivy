$FileID = "1Q64ZzqDgdzW9kY83Gm8LdJIt8ypkFstn"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с Google Диска..." -ForegroundColor Yellow

# Прямая ссылка с параметром confirm=t для обхода предупреждения о вирусах
$Url = "https://docs.google.com/uc?export=download&confirm=t&id=$FileID"

# Скачиваем файл с помощью .NET WebClient (он надежнее всего справляется с редиректами Google)
$WebClient = New-Object System.Net.WebClient
try {
    $WebClient.DownloadFile($Url, $OutputExe)
}
catch {
    Write-Host "Первый способ не сработал, пробую запасной..." -ForegroundColor Yellow
    $AlternateUrl = "https://drive.google.com/uc?export=download&id=$FileID"
    $WebClient.DownloadFile($AlternateUrl, $OutputExe)
}
finally {
    $WebClient.Dispose()
}

# Проверяем, скачался ли реальный exe (если весит меньше 10 КБ, значит скачалась ошибка/HTML)
$FileSize = (Get-Item $OutputExe).Length
if ($FileSize -lt 10000) {
    Write-Host "Ошибка: Google Диск заблокировал прямую скачку. Файл весит всего $FileSize байт." -ForegroundColor Red
    Write-Host "Решение: Залей этот .exe в GitHub Releases твоего репозитория — оттуда качается в 1 клик без танцев с бубном!" -ForegroundColor Yellow
    exit
}

Write-Host "Загрузка завершена! Размер файла: $([math]::Round($FileSize/1MB, 2)) МБ. Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe