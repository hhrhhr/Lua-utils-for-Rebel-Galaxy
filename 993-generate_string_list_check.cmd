@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%" mkdir "%WORK%"

set TMPFILE=%WORK%\%RANDOM%

echo dump strings...
setlocal ENABLEDELAYEDEXPANSION
for /r %UNPACK% %%i in (*.DAT) do (
    rem lua find_all_strings.lua "%%i" >> "%TMPFILE%"

    set A=%%i
    set B=!A:unpack=import!
    if exist !B! (
        lua find_all_strings.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings.lua "%%i" >> "%TMPFILE%"
    )
)
setlocal DISABLEDELAYEDEXPANSION

echo sort and remove duplicates...
lua remove_duplicates.lua "%TMPFILE%" > "%WORK%\_list_all_string.lua"
del /q "%TMPFILE%"

echo generate original language table...
lua generate_lang.lua "%WORK%\_list_all_string.lua" > "%WORK%\_lang_original.lua"

echo find duplicates IDs...
lua find_duped_ids.lua "%WORK%\_list_all_string.lua" > "%WORK%\_list_duped_ids.lua"

echo find conflicted IDs...
lua find_conflicted_ids.lua "%WORK%\_list_all_string.lua" > "%WORK%\_list_conflicted_ids.lua"


:eof
pause
