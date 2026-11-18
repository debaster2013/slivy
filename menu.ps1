Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Создаем само окно
$form = New-Object System.Windows.Forms.Form
$form.Text = "Установщик игр | Дебастер"
$form.Size = New-Object System.Drawing.Size(400, 250)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Заголовок в окне
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
    $form.Close()
    
    $Url = "https://github.com/debaster2013/slivy/releases/download/game/buckshot.zip"
    $OutputDir = "$env:USERPROFILE\Desktop\BuckshotGame"
    $ZipFile = "$OutputDir\buckshot.zip"
    $OutputExe = "$OutputDir\Buckshot Roulette.exe"

    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
    
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($Url, $ZipFile)
    
    Expand-Archive -Path $ZipFile -DestinationPath $OutputDir -Force
    Remove-Item $ZipFile
    
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

# Показываем окошко
[void]$form.ShowDialog()