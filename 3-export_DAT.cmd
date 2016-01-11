@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%" goto eof
if not exist "%EXPORT%" mkdir "%EXPORT%"

if exist "%WORK%\dat2lua.err" del /q "%WORK%\dat2lua.err"

echo copy structure of dirs...
xcopy /t "%UNPACK%" "%EXPORT%"

echo start export...
setlocal ENABLEDELAYEDEXPANSION
for /r %UNPACK% %%i in (*.DAT) do (
    set A=%%i
    set B=%%~dpni.LUA
    lua dat2lua.lua "!A!" "!B:unpack=export!" 2>>"%WORK%\dat2lua.err"
)
setlocal DISABLEDELAYEDEXPANSION

echo parse errlog...
lua remove_duplicates.lua "%WORK%\dat2lua.err" > "%WORK%\list_missing_ids.txt"
del /q "%WORK%\dat2lua.err"

:eof
pause
