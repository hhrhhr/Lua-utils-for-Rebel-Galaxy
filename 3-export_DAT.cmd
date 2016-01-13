@echo off

call 0-include.cmd

if not exist "%WORK%" goto eof
if not exist "%UNPACK%_DAT" goto eof
if not exist "%EXPORT%_DAT" mkdir "%EXPORT%_DAT"
if not exist "%EXPORT%_ANIMATION" mkdir "%EXPORT%_ANIMATION"
if not exist "%EXPORT%_IMAGESET" mkdir "%EXPORT%_IMAGESET"

if exist "%WORK%\dat2lua.err" del /q "%WORK%\dat2lua.err"

echo copy structure of dirs...
xcopy /t "%UNPACK%_DAT" "%EXPORT%_DAT"
xcopy /t "%UNPACK%_ANIMATION" "%EXPORT%_ANIMATION"
xcopy /t "%UNPACK%_IMAGESET" "%EXPORT%_IMAGESET"

echo start export:
echo from DAT...
setlocal ENABLEDELAYEDEXPANSION
for /r "%UNPACK%_DAT" %%i in (*.DAT) do (
    set A=%%i
    set B=%%~dpni.LUA
    lua dat2lua.lua "!A!" "!B:unpack=export!" 2>>"%WORK%\dat2lua.err"
)
echo from ANIMATION...
for /r "%UNPACK%_ANIMATION" %%i in (*.ANIMATION) do (
    set A=%%i
    set B=%%~dpni.LUA
    lua dat2lua.lua "!A!" "!B:unpack=export!" 2>>"%WORK%\dat2lua.err"
)
echo from IMAGESET...
for /r "%UNPACK%_IMAGESET" %%i in (*.IMAGESET) do (
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
