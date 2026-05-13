@echo off
if not exist "%TEMP_DIR%" (
    mkdir "%TEMP_DIR%"
)

cd /d "%TEMP_DIR%"

:: =====================================================
:: DOWNLOAD DO WAZUH AGENT
:: =====================================================

echo.
echo Baixando Wazuh Agent...

echo.

powershell -Command "Invoke-WebRequest -Uri 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.5-1.msi' -OutFile 'wazuh-agent.msi'"

if not exist wazuh-agent.msi (
    echo.
    echo [ERRO] Falha ao baixar o instalador.
    pause
    exit
)

:: =====================================================
:: INSTALACAO DO AGENTE
:: =====================================================

echo.
echo Instalando Wazuh Agent...

echo.

msiexec /i wazuh-agent.msi /q

:: =====================================================
:: FIREWALL
:: =====================================================

echo.
echo Configurando regras basicas de firewall...

netsh advfirewall firewall add rule name="Wazuh Agent" dir=out action=allow protocol=TCP localport=1514
netsh advfirewall firewall add rule name="Wazuh Agent API" dir=out action=allow protocol=TCP localport=1515

:: =====================================================
:: FINALIZACAO
:: =====================================================

echo.
echo =====================================================
echo           INSTALACAO FINALIZADA
 echo =====================================================
echo.
echo O Wazuh Agent foi instalado.
echo.
echo Agora configure o endereco do servidor Wazuh.
echo.
echo Pasta do agente:
echo C:\Program Files (x86)\ossec-agent

echo.
echo Recomendacoes:
echo - Reinicie o computador
 echo - Mantenha o Windows atualizado
 echo - Utilize senhas fortes

echo.
pause
