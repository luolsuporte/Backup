@echo off

rem TODAS LINHAS QUE POSSUEM "REM" NO INICIO, SERÃO IGNORADAS NA HORA DE RODAR O SCRIPT

rem Verifica e cria diretorio de backup caso necessario
if not exist "C:\backup\Luol\Db" md "C:\backup\Luol\Db"
if not exist "C:\backup\Luol\Exe" md "C:\backup\Luol\Exe"

rem (Nome do usuário do PostgreSQL que executará o script, mesmo usuario utilizado para entrar no PgAdmin)
rem (Nome do usuario)
set PGUSER=postgres
rem (Senha do usuário)
set PGPASSWORD=luol2003

rem Este comando serve para armazenar a data no formato dia-mes-ano na variável Date;
for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a

echo "Aguarde, realizando o backup do Banco de Dados"

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32 || set OS=64

if %OS%==64 GOTO 64bits
if %OS%==32 GOTO 32bits

:32bits
rem Executa o backup do banco de dados e executavel para os diretorios descritos (em sistemas x86)
"C:\Program Files\PostgreSQL\8.1\bin\vacuumdb" -U postgres -d PREENCHER NOME DO BANCO DE DADOS
"C:\Program Files\PostgreSQL\8.1\bin\pg_dump" -U postgres -f C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out PREENCHER NOME DO BANCO DE DADOS
if errorlevel 1 GOTO DBError

copy C:\Progress\Progress.exe C:\backup\Luol\Exe\Progress%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\Progress\Caixa.exe C:\backup\Luol\Exe\Caixa%Date%.exe
if errorlevel 1 GOTO CopyError

rem sair da tela depois do backup
exit

:64bits
rem Executa o backup do banco de dados e executavel para os diretorios descritos (em sistemas x64)
"C:\Program Files (x86)\PostgreSQL\8.1\bin\vacuumdb" -U postgres -d PREENCHER NOME DO BANCO DE DADOS
"C:\Program Files (x86)\PostgreSQL\8.1\bin\pg_dump" -U postgres -f C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out PREENCHER NOME DO BANCO DE DADOS
if errorlevel 1 GOTO DBError

copy C:\Progress\Progress.exe C:\backup\Luol\Exe\Progress%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\Progress\Caixa.exe C:\backup\Luol\Exe\Caixa%Date%.exe
if errorlevel 1 GOTO CopyError

rem sair da tela depois do backup
exit

:DBError
cls
echo Falha ao conectar no banco de dados
pause
exit

:CopyError
cls
echo Falha ao copiar executaveis
pause
exit