@echo off

rem TODAS LINHAS QUE POSSUEM "REM" NO INICIO, SER�O IGNORADAS NA HORA DE RODAR O SCRIPT

rem Verifica e cria diretorio de backup caso necessario
if not exist C:\backup\delivery\Db md C:\backup\delivery\Db
if not exist C:\backup\delivery\Exe md C:\backup\delivery\Exe

rem As linha abaixo verificam e criam os diretorios de backup em diretorios de rede, � necessario preencher o nome do micro para qual ser� feito o backup
if not exist \\NOME DO MICRO DE DESTINO DO BACKUP\backup\delivery\Db md \\NOME DO MICRO DE DESTINO DO BACKUP\backup\delivery\Db
if not exist \\NOME DO MICRO DE DESTINO DO BACKUP\backup\delivery\Exe md \\NOME DO MICRO DE DESTINO DO BACKUP\backup\delivery\Exe

echo "Aguarde, realizando o backup do Banco de Dados"

rem Este comando serve para armazenar a data no formato dia-mes-ano na vari�vel Date;
for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a

rem Executa o backup do banco de dados e excutaveis para os diretorios descritos
copy C:\deliverygdb\delivery.gdb C:\backup\delivery\Db\delivery%Date%.gdb
if errorlevel 1 GOTO CopyError

copy C:\deliverygdb\delivery.exe C:\backup\delivery\exe\delivery%Date%.exe
if errorlevel 1 GOTO CopyError

rem Executa o backup do banco de dados e excutaveis para os diretorios de rede
copy C:\deliverygdb\delivery.gdb \\NOME DO MICRO DE DESTINO DO BACKUP\Backup\delivery\Db\delivery%date%.gdb
if errorlevel 1 GOTO NetworkError

copy C:\deliverygdb\delivery.exe \\NOME DO MICRO DE DESTINO DO BACKUP\Backup\delivery\exe\delivery%Date%.exe
if errorlevel 1 GOTO NetworkError

rem sair da tela depois do backup
exit

:CopyError
cls
echo Falha ao realizar backup
pause
exit

:NetworkError
cls
echo Falha ao realizar backup de rede
pause
exit