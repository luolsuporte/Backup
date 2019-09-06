@echo off

rem Este comando serve para armazenar a data no formato ano-mes-dia na variável backupdate;
set backupdate=%date:~-4%%date:~3,2%%date:~0,2%

rem Verifica e cria diretorio de backup caso necessario
if not exist "C:\backup\delivery\%backupdate%" md "C:\backup\delivery\%backupdate%"

echo "Aguarde, realizando o backup do Banco de Dados"

rem Executa o backup do banco de dados e excutaveis para os diretorios descritos
copy C:\deliverygdb\delivery.gdb "C:\backup\delivery\%backupdate%\delivery.gdb"
copy C:\deliverygdb\delivery.exe "C:\backup\delivery\%backupdate%\delivery.exe"

exit