@echo off

call 0-include.cmd

if not exist "%WORK%" goto eof
if not exist "%UNPACK%_DAT" goto eof

set TMPFILE=%WORK%\%RANDOM%

echo dump strings:
setlocal ENABLEDELAYEDEXPANSION
echo from *.DAT...
for /r "%UNPACK%_DAT" %%i in (*.DAT) do (
    set A=%%i
    set B=!A:unpack=import!
    if exist !B! (
        lua find_all_strings.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings.lua "%%i" >> "%TMPFILE%"
    )
)

goto skip

echo from *.ANIMATION
for /r "%UNPACK%_ANIMATION" %%i in (*.ANIMATION) do (
    set A=%%i
    set B=!A:unpack=import!
    if exist !B! (
        lua find_all_strings.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings.lua "%%i" >> "%TMPFILE%"
    )
)
echo from *.IMAGESET
for /r "%UNPACK%_IMAGESET" %%i in (*.IMAGESET) do (
    set A=%%i
    set B=!A:unpack=import!
    if exist !B! (
        lua find_all_strings.lua "!B!" >> "%TMPFILE%"
    ) else (
        lua find_all_strings.lua "%%i" >> "%TMPFILE%"
    )
)

:skip

setlocal DISABLEDELAYEDEXPANSION

echo sort and remove duplicates...
lua remove_duplicates.lua "%TMPFILE%" > "%WORK%\z_list_all_string.txt"
del /q "%TMPFILE%"

echo generate original language table...
lua generate_lang.lua "%WORK%\z_list_all_string.txt" > "%WORK%\z_lang_original.lua"

echo find duplicated IDs...
lua find_broken_ids.lua "%WORK%\z_list_all_string.txt" duplicate > "%WORK%\z_list_duplicated_ids.lua"

echo find conflicted IDs...
lua find_broken_ids.lua "%WORK%\z_list_all_string.txt" conflict > "%WORK%\z_list_conflicted_ids.lua"


:eof
pause
