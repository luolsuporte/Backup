@echo off

rem Verifica se a tarefa já existe
schtasks /query /TN "Backup Luol"

rem Caso ela não exista, cria uma tarefa diaria
if errorlevel 1 schtasks /create /SC DAILY /TN "Backup Luol" /TR "C:\Program Files (x86)\Store\BackupStore.bat" /ST (PREENCHER COM O HORARIO DO BACKUP)

pause