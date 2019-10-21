@echo off

echo 1-Backup Local, 2-Backup de rede
set /p TipoBackup=Selecione o tipo de backup:

If %TipoBackup%==1 GOTO BackupLocal
If %TipoBackup%==2 GOTO BackupRede

:BackupLocal
If not exist "C:\Store" md "C:\Store"
copy BackupPostgresql.bat C:\Store\BackupPostgresql.bat
if errorlevel 1 GOTO CopyError
echo .
echo .
set /p NomeTarefa=Preencha o nome da tarefa a ser criada:
echo .
echo .
set /p HoraTarefa=Preencher com o horario do backup, (O horario deve ser preenchido no formato de 24h, ex: 8:00, 16:00, 14:30):
echo .
echo .
schtasks /create /SC DAILY /TN %NomeTarefa% /TR C:\Store\BackupPostgresql.bat /ST %HoraTarefa%
pause
exit

:BackupRede
If not exist "C:\Store" md "C:\Store"
copy BackupPostgresqlRede.bat C:\Progress\BackupPostgresql.bat
if errorlevel 1 GOTO CopyError
echo .
echo .
set /p NomeTarefa=Preencha o nome da tarefa a ser criada:
echo .
echo .
set /p HoraTarefa=Preencher com o horario do backup, (O horario deve ser preenchido no formato de 24h, ex: 8:00, 16:00, 14:30):
echo .
echo .
schtasks /create /SC DAILY /TN %NomeTarefa% /TR C:\Store\BackupPostgresql.bat /ST %HoraTarefa%
pause
exit

:CopyError
cls
echo Falha em copiar script de backup, script ou diretorio de destino nao encontrados
pause
exit