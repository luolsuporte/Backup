@echo off

rem TODAS LINHAS QUE POSSUEM "REM" NO INICIO, SERÃO IGNORADAS NA HORA DE RODAR O SCRIPT

rem Verifica e cria diretorio de backup caso necessario
if not exist "C:\backup\Luol\Db" md "C:\backup\Luol\Db"
if not exist "C:\backup\Luol\Exe" md "C:\backup\Luol\Exe"

rem As linha abaixo verificam e criam os diretorios de backup em diretorios de rede, é necessario preencher o nome do micro para qual será feito o backup
if not exist "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Db" md "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Db"
if not exist "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe" md "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe"

rem (Nome do usuário do PostgreSQL que executará o script, mesmo usuario utilizado para entrar no PgAdmin)
rem (Nome do usuario)
set PGUSER=postgres
rem (Senha do usuário)
set PGPASSWORD=luol2003

echo "Aguarde, realizando o backup do Banco de Dados"

rem Este comando serve para armazenar a data no formato dia-mes-ano na variável Date;
for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a

rem Executa o backup do banco de dados e executavel para os diretorios descritos
"C:\Program Files (x86)\PostgreSQL\8.1\bin\vacuumdb" -U postgres -d PREENCHER NOME DO BANCO DE DADOS
"C:\Program Files (x86)\PostgreSQL\8.1\bin\pg_dump" -U postgres -f "C:\backup\Luol\Db\PREENCHER NOME DO CLIENTE%Date%.out" PREENCHER NOME DO BANCO DE DADOS
copy "C:\Program Files (x86)\Progress\Progress.exe" "C:\backup\Luol\Exe\Progress%Date%.exe"
copy "C:\Program Files (x86)\Progress\Caixa.exe" "C:\backup\Luol\Exe\Caixa%Date%.exe"

copy "C:\backup\Luol\Db\PREENCHER NOME DO CLIENTE%Date%.out" "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Db\PREENCHER NOME DO CLIENTE%Date%.out"
copy "C:\Program Files (x86)\Progress\Progress.exe" "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Progress%Date%.exe"
copy "C:\Program Files (x86)\Progress\Caixa.exe" "\\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Caixa%Date%.exe"

rem (sair da tela depois do backup)
exit