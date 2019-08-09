@echo off
if not exist "C:\backup" md "C:\backup"
net share Backup=C:\backup /grant:todos,change
pause