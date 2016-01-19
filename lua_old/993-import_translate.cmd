@echo off

call 0-include.cmd

if not exist "%WORK%" goto eof
if not exist "%TRANSLATE%_DAT" goto eof
if exist "%IMPORT%_DAT" rmdir /q /s "%IMPORT%_DAT"
mkdir "%IMPORT%_DAT"

echo copy structure of dirs...
xcopy /t "%TRANSLATE%_DAT" "%IMPORT%_DAT"

echo start import...
setlocal ENABLEDELAYEDEXPANSION
for /r "%TRANSLATE%_DAT" %%i in (*.LUA) do (
    set A=%%i
    set B=%%~dpni.DAT
    lua lua2dat.lua "!A!" "!B:translate=import!"
)
setlocal DISABLEDELAYEDEXPANSION


:eof
pause
