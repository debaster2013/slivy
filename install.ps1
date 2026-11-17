$FileID = "1Q64ZzqDgdzW9kY83Gm8LdJIt8ypkFstn"
$Url = "https://drive.google.com/uc?export=download&id=$FileID"
$OutputDir = "$env:USERPROFILE\Desktop\MrHoppsGame"
$OutputExe = "$OutputDir\MrHoppsPlayhouse2.exe"

Write-Host "Создаю папку на рабочем столе..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Host "Качаю игру с Google Диска (это может занять время)..." -ForegroundColor Yellow

# Обход защиты Google Диска для больших файлов
$WebRequest = [System.Net.HttpWebRequest]::Create($Url)
$WebRequest.AllowAutoRedirect = $true
$Response = $WebRequest.GetResponse()
$Stream = $Response.GetResponseStream()
$TargetFile = [System.IO.File]::Create($OutputExe)
$Stream.CopyTo($TargetFile)
$TargetFile.Close()
$Stream.Close()
$Response.Close()

Write-Host "Загрузка завершена! Запускаю игру..." -ForegroundColor Green
Start-Process $OutputExe