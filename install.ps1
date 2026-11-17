$FileID = "1Q64ZzqDgdzW9kY83Gm8LdJIt8ypkFstn"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Получаю прямую ссылку на файл с Google Диска..." -ForegroundColor Yellow

# Создаем сессию, чтобы обойти предупреждение о вирусах для больших файлов
$Session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$InitialUrl = "https://drive.google.com/uc?export=download&id=$FileID"

# Делаем первый запрос, чтобы получить токен подтверждения
$Response = Invoke-WebRequest -Uri $InitialUrl -SessionVariable Session -Method Get -ErrorAction SilentlyContinue
$ConfirmToken = ""

if ($Response.Headers["Set-Cookie"] -match "download_warning_([0-9a-zA-Z_-]+)=([0-9a-zA-Z_-]+)") {
    $ConfirmToken = $Matches[1] + "=" + $Matches[2]
}

# Формируем итоговую ссылку с подтверждением
if ($ConfirmToken -ne "") {
    $DownloadUrl = "https://drive.google.com/uc?export=download&confirm=$ConfirmToken&id=$FileID"
} else {
    $DownloadUrl = $InitialUrl
}

Write-Host "Качаю игру (это может занять время)..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $DownloadUrl -OutFile $OutputExe -WebSession $Session

Write-Host "Загрузка завершена! Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe