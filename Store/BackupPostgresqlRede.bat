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

rem Este comando serve para armazenar a data no formato dia-mes-ano na variável Date;
for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a

echo "Aguarde, realizando o backup do Banco de Dados"

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32 || set OS=64

if OS==64 GOTO 64bits
if OS==32 GOTO 32bits

:32bits
rem Executa o backup do banco de dados e executavel para os diretorios descritos (em sistemas x86)
"C:\Program Files\PostgreSQL\8.1\bin\vacuumdb" -U postgres -d PREENCHER NOME DO BANCO DE DADOS
"C:\Program Files\PostgreSQL\8.1\bin\pg_dump" -U postgres -f C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out PREENCHER NOME DO BANCO DE DADOS
if errorlevel 1 GOTO DBError

copy C:\Store\Store.exe C:\backup\Luol\Exe\Store%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\Store\Facil.exe C:\backup\Luol\Exe\Facil%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out
if errorlevel 1 GOTO NetworkError

copy C:\Store\Store.exe \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Store%Date%.exe
if errorlevel 1 GOTO NetworkError

copy C:\Store\Facil.exe \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Facil%Date%.exe
if errorlevel 1 GOTO NetworkError

rem sair da tela depois do backup
exit

:64bits
rem Executa o backup do banco de dados e executavel para os diretorios descritos (em sistemas x64)
"C:\Program Files (x86)\PostgreSQL\8.1\bin\vacuumdb" -U postgres -d PREENCHER NOME DO BANCO DE DADOS
"C:\Program Files (x86)\PostgreSQL\8.1\bin\pg_dump" -U postgres -f C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out PREENCHER NOME DO BANCO DE DADOS
if errorlevel 1 GOTO DBError

copy C:\Store\Store.exe C:\backup\Luol\Exe\Store%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\Store\Facil.exe C:\backup\Luol\Exe\Facil%Date%.exe
if errorlevel 1 GOTO CopyError

copy C:\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Db\PREENCHER NOME DO BANCO DE DADOS%Date%.out
if errorlevel 1 GOTO NetworkError

copy C:\Store\Store.exe \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Store%Date%.exe
if errorlevel 1 GOTO NetworkError

copy C:\Store\Facil.exe \\NOME DO MICRO DE DESTINO DO BACKUP\backup\Luol\Exe\Facil%Date%.exe
if errorlevel 1 GOTO NetworkError

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

:NetworkError
cls
echo Falha ao realizar backup de rede
pause
exit