# physics.ps1
$url = "https://raw.githubusercontent.com/debaster2013/slivy/main/physics.html"
$output = "$env:TEMP\physics.html"

Write-Host "Скачиваем симулятор физики..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $output

Write-Host "Открываем в браузере..." -ForegroundColor Green
Start-Process $output