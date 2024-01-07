@echo off

REM Verifica se o número de argumentos é válido
if "%~1"=="" (
    echo Use: %0 ^<destination_directory^>
    exit /b 1
)

REM URL do diretório do GitHub
set "github_url=https://github.com/simplyYan/Blackpard/archive/refs/heads/main.zip"

REM Diretório temporário
set "temp_dir=%TEMP%\temp_dir_%RANDOM%"

REM Diretório de destino
set "dest_dir=%~1"

REM Baixa o arquivo zip do diretório do GitHub
powershell -command "& {Invoke-WebRequest '%github_url%' -OutFile '%temp_dir%\temp.zip'}"

REM Verifica se o download foi bem-sucedido
if %ERRORLEVEL% neq 0 (
    echo Error downloading file from GitHub.
    exit /b 1
)

REM Descompacta o arquivo zip para o diretório temporário
powershell -command "& {Expand-Archive -Path '%temp_dir%\temp.zip' -DestinationPath '%temp_dir%'}"

REM Move apenas a pasta "libs" para o diretório de destino
move "%temp_dir%\Blackpard-main\libs" "%dest_dir%" >nul

REM Remove o diretório temporário e o arquivo zip
rd /s /q "%temp_dir%"
del /q "%temp_dir%\temp.zip"

echo Installation completed. The Blackpard built-in libraries have been downloaded to the %dest_dir%

