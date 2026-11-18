Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- ГЛАВНОЕ ОКНО МЕНЮ ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Установщик игр | DeBaster2013"
$form.Size = New-Object System.Drawing.Size(400, 250)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Заголовок
$label = New-Object System.Windows.Forms.Label
$label.Text = "Выбери игру для установки:"
$label.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
$label.Location = New-Object System.Drawing.Point(30, 25)
$label.Size = New-Object System.Drawing.Size(330, 30)
$form.Controls.Add($label)

# Кнопка для Buckshot Roulette
$btnBuckshot = New-Object System.Windows.Forms.Button
$btnBuckshot.Text = "Установить Buckshot Roulette"
$btnBuckshot.Location = New-Object System.Drawing.Point(50, 70)
$btnBuckshot.Size = New-Object System.Drawing.Size(280, 45)
$btnBuckshot.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$btnBuckshot.Add_Click({
    $form.Close() # Закрываем меню

    # --- ОКНО С ПРЕДУПРЕЖДЕНИЕМ ---
    $waitForm = New-Object System.Windows.Forms.Form
    $waitForm.Text = "Загрузка..."
    $waitForm.Size = New-Object System.Drawing.Size(420, 180)
    $waitForm.StartPosition = "CenterScreen"
    $waitForm.FormBorderStyle = "FixedDialog"
    $waitForm.MaximizeBox = $false
    $waitForm.MinimizeBox = $false

    $waitLabel = New-Object System.Windows.Forms.Label
    $waitLabel.Text = "Не закрывай PowerShell до запуска игры!`nИдет скачивание и распаковка..."
    $waitLabel.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $waitLabel.ForeColor = [System.Drawing.Color]::Red
    $waitLabel.Location = New-Object System.Drawing.Point(20, 30)
    $waitLabel.Size = New-Object System.Drawing.Size(380, 60)
    $waitForm.Controls.Add($waitLabel)

    # Запускаем окно предупреждения параллельно/асинхронно или показываем перед скачиванием
    $waitForm.Show()
    [System.Windows.Forms.Application]::DoEvents()

    # --- ПРОЦЕСС СКАЧИВАНИЯ ---
    $Url = "https://github.com/debaster2013/slivy/releases/download/game/buckshot.zip"
    $OutputDir = "$env:USERPROFILE\Desktop\BuckshotGame"
    $ZipFile = "$OutputDir\buckshot.zip"
    $OutputExe = "$OutputDir\Buckshot Roulette.exe"

    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
    
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($Url, $ZipFile)
    
    Expand-Archive -Path $ZipFile -DestinationPath $OutputDir -Force
    Remove-Item $ZipFile
    
    # Закрываем окно ожидания
    $waitForm.Close()

    # Запускаем игру
    Start-Process "$OutputExe"
    exit
})
$form.Controls.Add($btnBuckshot)

# Кнопка выхода
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Выход"
$btnExit.Location = New-Object System.Drawing.Point(50, 130)
$btnExit.Size = New-Object System.Drawing.Size(280, 35)
$btnExit.Add_Click({
    $form.Close()
    exit
})
$form.Controls.Add($btnExit)

# Показываем главное меню
[void]$form.ShowDialog()