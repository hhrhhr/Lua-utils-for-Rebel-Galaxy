@echo off

call 0-include.cmd

if not exist "%WORK%" goto eof
if not exist "%EXPORT%_DAT" goto eof
if not exist "%TRANSLATE%_DAT" goto eof

set TMPFILE=%WORK%\%RANDOM%

echo dump strings...
setlocal ENABLEDELAYEDEXPANSION
echo from DAT...
for /r "%EXPORT%_DAT" %%i in (*.LUA) do (
    set A=%%i
    set B=!A:export=translate!
    if exist !B! (
        lua find_all_strings_in_lua.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings_in_lua.lua "%%i" >> "%TMPFILE%"
    )
)

goto skip

for /r "%EXPORT%_ANIMATION" %%i in (*.LUA) do (
    set A=%%i
    set B=!A:export=translate!
    if exist !B! (
        lua find_all_strings_in_lua.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings_in_lua.lua "%%i" >> "%TMPFILE%"
    )
)
for /r "%EXPORT%_IMAGESET" %%i in (*.LUA) do (
    set A=%%i
    set B=!A:export=translate!
    if exist !B! (
        lua find_all_strings_in_lua.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings_in_lua.lua "%%i" >> "%TMPFILE%"
    )
)

:skip

setlocal DISABLEDELAYEDEXPANSION

echo sort and remove duplicates...
lua remove_duplicates.lua "%TMPFILE%" > "%WORK%\t_list_all_string.txt"
del /q "%TMPFILE%"

echo check for conlicted IDs...
lua check_for_conflicted_ids.lua "%WORK%\t_list_all_string.txt" "%WORK%\list_conflicted_ids.lua" > "%WORK%\t_list_conflicted_ids.txt"

echo check for duplicated IDs...
lua check_for_duplicated_ids.lua "%WORK%\t_list_all_string.txt" "%WORK%\lang_original.lua" > "%WORK%\t_list_duplicated_ids.lua"

:eof
pause
