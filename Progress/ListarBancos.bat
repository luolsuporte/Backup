@echo off
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS="C:\Program Files" || set OS="C:\Program Files (x86)"
cd "%OS%\PostgreSQL\8.1\bin"
psql -U postgres -l
pause