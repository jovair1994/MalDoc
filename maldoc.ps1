

$ErrorActionPreference = "Stop"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
Set-MpPreference -DisableRealtimeMonitoring $true
Add-MpPreference -ExclusionPath "C:\"
Add-MpPreference -ExclusionExtension ".exe"
Add-MpPreference -ExclusionExtension ".ps1"
Add-MpPreference -ExclusionExtension ".dll"
Add-MpPreference -ExclusionExtension ".doc"
Add-MpPreference -ExclusionExtension ".odt"

Set-MpPreference -ExclusionProcess "C:\Program Files\LibreOffice\program\swriter.exe"
Set-MpPreference -ExclusionProcess "powershell.exe"

net user automate A123456! /add

# Habilite o serviço SMB
Set-Service -Name "LanmanServer" -StartupType 'Automatic'
Start-Service -Name "LanmanServer"

# Habilite o serviço RDP

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

# Defina a URL do download do Autologon
$AutologonDownloadURL="https://download.sysinternals.com/files/AutoLogon.zip"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\Autologon.zip"

#Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $AutologonDownloadURL -OutFile $DownloadPath

New-Item -ItemType Directory -Path "C:\Windows\Temp\Autologon"

Expand-Archive -Path "C:\Windows\Temp\Autologon.zip" -DestinationPath "C:\Windows\Temp\Autologon\"

Start-Process -FilePath C:\Windows\Temp\Autologon\Autologon.exe -Wait

# Aqui o usuário automate já estará logado, a tarefa agendada do Writer só funciona assim

# Defina a URL do download do FileZilla
$FileZillaDownloadURL = "https://raw.githubusercontent.com/jovair1994/MalDoc/main/FileZilla_Server_1.8.0_win64-setup.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\FileZilla.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $FileZillaDownloadURL -OutFile $DownloadPath

Start-Sleep -Seconds 10
# Execute o instalador do FileZilla
Start-Process -FilePath $DownloadPath -Wait
Start-Sleep -Seconds 10

# Defina a URL do download do firefox
$UtorrentDownloadURL = "https://www.exploit-db.com/apps/e22b1d55b4d450a18bd7b9ddc8b395b7-Firefox_Setup_3.6.8.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\firefox.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $UtorrentDownloadURL -OutFile $DownloadPath

Start-Sleep -Seconds 10
# Execute o instalador do firefox
Start-Process -FilePath $DownloadPath -Wait
Start-Sleep -Seconds 10

cacls "C:\Program Files (x86)\Mozilla Firefox" /E /G Users:W

#Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute "C:\Program Files (x86)\Mozilla Firefox\firefox.exe") -Trigger (New-ScheduledTaskTrigger -AtStartup) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -TaskName "Firefox" -User "Administrator"

# Defina a URL do download do popcorn
$PopcornDownloadURL = "https://github.com/popcorn-official/popcorn-desktop/releases/download/v0.4.9/Popcorn-Time-0.4.9-win64-Setup.exe"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\popcorn.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $PopcornDownloadURL -OutFile $DownloadPath

Start-Sleep -Seconds 10
# Execute o instalador do uTorrent
Start-Process -FilePath $DownloadPath -Wait
Start-Sleep -Seconds 10

# Defina a URL do download do codemeter
$CodeMeterDownloadURL = "https://www.wibu.com/support/user/user-software/file/download/12529.html?tx_wibudownloads_downloadlist%5BdirectDownload%5D=directDownload&tx_wibudownloads_downloadlist%5BuseAwsS3%5D=0&cHash=8dba7ab094dec6267346f04fce2a2bcd"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\codemeter.exe"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $CodeMeterDownloadURL -OutFile $DownloadPath

Start-Sleep -Seconds 10
# Execute o instalador do codemeter
Start-Process -FilePath $DownloadPath -Wait
Start-Sleep -Seconds 10

Restart-Computer

Invoke-WebRequest -Uri "https://github.com/jovair1994/MalDoc/raw/main/instru%C3%A7%C3%B5es.txt" -Outfile C:\Users\automate\Documents\instruções.txt

Invoke-WebRequest -Uri "https://github.com/jovair1994/MalDoc/raw/main/jroberto.doc"  -Outfile C:\Users\automate\Documents\jroberto.odt

Start-Sleep -Seconds 10
# Defina a URL do download do LibreOffice
$LibreOfficeDownloadURL = "https://download.documentfoundation.org/libreoffice/stable/7.6.4/win/x86_64/LibreOffice_7.6.4_Win_x86-64.msi"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\libre.msi"

# Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $LibreOfficeDownloadURL -OutFile $DownloadPath

Start-Sleep -Seconds 10
# Execute o instalador do libreoffice
Start-Process -FilePath $DownloadPath -Wait

Start-Sleep -Seconds 10

# Caminho do diretório do usuário automate
$usuario = "automate"
$caminho = "C:\Users\$usuario\Desktop"

# Configurar a ação da tarefa (executar o swriter.exe em todos os arquivos .odt)
$acao = New-ScheduledTaskAction -Execute "cmd"  -Argument '/c for %F in (C:\Users\automate\Documents\*.odt) do start "" "C:\Program Files\LibreOffice\program\swriter.exe" "%F"'

# Configurar o gatilho da tarefa (inicial e repetição a cada 5 minutos)
$trigger = New-ScheduledTaskTrigger -AtStartup 

# Registrar a tarefa agendada
Register-ScheduledTask -Action $acao -Trigger $trigger -TaskName "ExeOdtCada5Min" -User "automate"

# Defina a URL do download do nssm
$AutologonDownloadURL="http://nssm.cc/release/nssm-2.24.zip"

# Defina o caminho de destino onde o arquivo será baixado
$DownloadPath = "C:\Windows\Temp\nssm.zip"

#Baixe o arquivo usando o URL
Invoke-WebRequest -Uri $AutologonDownloadURL -OutFile $DownloadPath

New-Item -ItemType Directory -Path "C:\Windows\Temp\nssm"

Expand-Archive -Path "C:\Windows\Temp\nssm.zip" -DestinationPath "C:\Windows\Temp\nssm\"

C:\Windows\Temp\nssm\nssm-2.24\win64\nssm.exe install Firefox-Update

echo 88c0e20683793760bcb20b902a16436f > C:\Users\Administrator\Desktop\proof.txt

echo cb8b20b7939036f8c0e2a16420683760 > C:\Users\automate\Desktop\flag.txt

Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

Restart-Computer
