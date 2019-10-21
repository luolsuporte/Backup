@echo off

rem TODAS LINHAS QUE POSSUEM "REM" NO INICIO, SER�O IGNORADAS NA HORA DE RODAR O SCRIPT

rem Verifica e cria diretorio de backup caso necessario
if not exist C:\backup\delivery\Db md C:\backup\delivery\Db
if not exist C:\backup\delivery\Exe md C:\backup\delivery\Exe

echo "Aguarde, realizando o backup do Banco de Dados"

rem Este comando serve para armazenar a data no formato dia-mes-ano na vari�vel Date;
for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a

rem Executa o backup do banco de dados e excutaveis para os diretorios descritos
copy C:\deliverygdb\delivery.gdb C:\backup\delivery\Db\delivery%Date%.gdb
if errorlevel 1 GOTO CopyError

copy C:\deliverygdb\delivery.exe C:\backup\delivery\exe\delivery%Date%.exe
if errorlevel 1 GOTO CopyError

rem sair da tela depois do backup
exit

:CopyError
cls
echo Falha ao realizar backup
pause
exit