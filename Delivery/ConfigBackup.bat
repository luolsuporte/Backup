@echo off

echo Selecione o tipo de backup:
set /p TipoBackup=1-Backup Local, 2-Backup de rede:

If %TipoBackup%==1 GOTO BackupLocal
If %TipoBackup%==2 GOTO BackupRede

:BackupLocal
copy BackupDelivery.bat C:\Deliverygdb\BackupDelivery.bat
set /p NomeTarefa=Preencha o nome da tarefa a ser criada:
set /p HoraTarefa=Preencher com o horario do backup, (O horario deve ser preenchido no formato de 24h, ex: 8:00, 16:00, 14:30):
schtasks /create /SC DAILY /TN %NomeTarefa% /TR C:\Deliverygdb\BackupDelivery.bat /ST %HoraTarefa%
pause
exit

:BackupRede
copy BackupDeliveryRede.bat C:\Deliverygdb\BackupDelivery.bat
set /p NomeTarefa=Preencha o nome da tarefa a ser criada:
set /p HoraTarefa=Preencher com o horario do backup, (O horario deve ser preenchido no formato de 24h, ex: 8:00, 16:00, 14:30):
schtasks /create /SC DAILY /TN %NomeTarefa% /TR C:\Deliverygdb\BackupDelivery.bat /ST %HoraTarefa%
pause
exit