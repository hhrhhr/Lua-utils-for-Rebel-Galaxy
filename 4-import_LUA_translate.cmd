@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%" goto eof
if not exist "%TRANSLATE%" goto eof
if not exist "%IMPORT%" mkdir "%IMPORT%"

echo copy structure of dirs...
xcopy /t "%TRANSLATE%" "%IMPORT%"

echo start import...
setlocal ENABLEDELAYEDEXPANSION
for /r %TRANSLATE% %%i in (*.LUA) do (
    set A=%%i
    set B=%%~dpni.DAT
    lua lua2dat.lua "!A!" "!B:translate=import!"
)
setlocal DISABLEDELAYEDEXPANSION

:eof
pause
