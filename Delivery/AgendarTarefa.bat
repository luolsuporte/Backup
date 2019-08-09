@echo off

rem Verifica se a tarefa já existe
schtasks /query /TN "Backup Luol"

set /p NomeTarefa=Preencha o nome da tarefa a ser criada:
set /p CaminhoScript=Preencha o caminho absoluto do script que sera executado:
set /p HoraTarefa=Preencher com o horario do backup, (deve seguir o seguinte formato hh:mm:ss):
schtasks /create /SC DAILY /TN %NomeTarefa% /TR %CaminhoScript% /ST %HoraTarefa%
pause