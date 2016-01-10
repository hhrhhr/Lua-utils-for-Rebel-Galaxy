@echo off

if .%1==. goto help

@copy /b "%1" + ,, > nul 2>&1
goto eof

:help
echo.
echo usage: touch.cmd ^<FILENAME^>
echo.
echo assign the current time and date to a file FILENAME
echo.
echo.

:eof
