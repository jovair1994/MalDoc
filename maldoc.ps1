# DAR PERMISSÃO PASTA DO UTORRENT PRA AUTOMATE E CRIAR O REPO DO FILEZILLA PARA PASTA DO AUTOMATE

Set-MpPreference -DisableRealtimeMonitoring $true
Add-MpPreference -ExclusionPath "C:\"

net user automate Automate123456! /add

# Habilite o serviço SMB
Set-Service -Name "LanmanServer" -StartupType 'Automatic'
Start-Service -Name "LanmanServer"

# Habilite o serviço RDP

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

# Defina a URL do download do FileZilla
$FileZillaDownloadURL = "https://github.com/jovair1994/MalDoc/raw/main/FileZilla_Server_1.8.0_win64-setup.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\FileZilla.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $FileZillaDownloadURL -OutFile $DownloadPath

# Execute o instalador do FileZilla
Start-Process -FilePath $DownloadPath -Wait

# Aguarde a instalação ser concluída
Start-Sleep -Seconds 100  # Ajuste o tempo de espera conforme necessário

# Defina a URL do download do uTorrent
$UtorrentDownloadURL = "https://www.exploit-db.com/apps/0e2137502449143f04133498b9621a2e-utorrent.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\utorrent.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $UtorrentDownloadURL -OutFile $DownloadPath

# Execute o instalador do uTorrent
Start-Process -FilePath $DownloadPath -Wait

# Aguarde a instalação ser concluída
Start-Sleep -Seconds 100  # Ajuste o tempo de espera conforme necessário

# Defina a URL do download do popcorn
$PopcornDownloadURL = "https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.9/Popcorn-Time-0.4.9-win64-Setup.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\popcorn.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $PopcornDownloadURL -OutFile $DownloadPath

# Execute o instalador do uTorrent
Start-Process -FilePath $DownloadPath -Wait

# Aguarde a instalação ser concluída
Start-Sleep -Seconds 100  # Ajuste o tempo de espera conforme necessário

# Defina a URL do download do codemeter
$CodeMeterDownloadURL = "https://www.wibu.com/support/user/user-software/file/download/12529.html?tx_wibudownloads_downloadlist%5BdirectDownload%5D=directDownload&tx_wibudownloads_downloadlist%5BuseAwsS3%5D=0&cHash=8dba7ab094dec6267346f04fce2a2bcd"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\codemeter.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $CodeMeterDownloadURL -OutFile $DownloadPath

# Execute o instalador do codemeter
Start-Process -FilePath $DownloadPath -Wait

# Aguarde a instalação ser concluída
Start-Sleep -Seconds 100  # Ajuste o tempo de espera conforme necessário

Invoke-WebRequest -Uri "https://github.com/jovair1994/MalDoc/raw/main/instru%C3%A7%C3%B5es.txt" -Outfile C:\Users\automate\Desktop\instruções.txt

### LINK PARA DOWNLOAD DO OFFICE 2016 - INSTALAR WORD E EXCEL ###
### https://drive.google.com/open?id=1tXH6amC9lOibnBLKt_K_6OPI6mjbdUj3&authuser=0 ###

# Caminho do diretório do usuário automate
$usuario = "automate"
$caminho = "C:\Users\$usuario\Desktop"

# Configurar a ação da tarefa (executar o winword.exe em todos os arquivos .doc)
$acao = New-ScheduledTaskAction -Execute "cmd"  -Argument '/c for %F in (C:\Users\automate\Desktop\*.doc) do start "" "C:\Program Files\Microsoft Office\Office16\WINWORD.EXE" "%F"'

# Definir a data e hora de início
$startTime = (Get-Date).AddMinutes(1)

# Configurar o gatilho da tarefa (inicial e repetição a cada 1 minuto)
$trigger = New-ScheduledTaskTrigger -Once -At $startTime -RepetitionInterval ([TimeSpan]::FromMinutes(1))

# Registrar a tarefa agendada
Register-ScheduledTask -Action $acao -Trigger $trigger -TaskName "ExeWordCadaMin"  -User "automate"

# Criar tarefa agendada
$acao = New-ScheduledTaskAction -Execute "C:\Program Files (x86)\uTorrent\uTorrent.exe"
$trigger = New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -Action $acao -Trigger $trigger -TaskName "uTorrentStartupTask" -User "NT AUTHORITY\SYSTEM"

