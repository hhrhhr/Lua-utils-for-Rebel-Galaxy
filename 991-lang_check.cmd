@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%" goto eof

set TMPFILE=%WORK%\%RANDOM%

echo dump strings...
setlocal ENABLEDELAYEDEXPANSION
for /r "%EXPORT%" %%i in (*.LUA) do (
    set A=%%i
    set B=!A:export=translate!
    if exist !B! (
        lua find_all_strings_in_lua.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings_in_lua.lua "%%i" >> "%TMPFILE%"
    )
)
setlocal DISABLEDELAYEDEXPANSION

echo sort and remove duplicates...
lua remove_duplicates.lua "%TMPFILE%" > "%WORK%\list_all_string_lang.txt"
del /q "%TMPFILE%"

echo check for conlicted IDs...
lua check_for_conflicted_ids.lua "%WORK%\list_all_string_lang.txt" "%WORK%\list_conflicted_ids.lua" > "%WORK%\list_conflicted_ids_lang.txt"

echo check for duplicates IDs...
lua check_for_duped_ids.lua "%WORK%\list_all_string_lang.txt" "%WORK%\lang_original.lua" > "%WORK%\list_duped_ids_lang.lua"

:eof
pause
