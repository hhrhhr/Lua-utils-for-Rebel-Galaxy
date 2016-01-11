@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%" mkdir "%WORK%"

set TMPFILE=%WORK%\%RANDOM%

echo dump strings...
for /r %UNPACK% %%i in (*.DAT) do (
    lua find_all_strings.lua "%%i" >> "%TMPFILE%"
)

echo sort and remove duplicates...
lua remove_duplicates.lua "%TMPFILE%" > "%WORK%\list_all_string.lua"
del /q "%TMPFILE%"

echo generate original language table...
lua generate_lang.lua "%WORK%\list_all_string.lua" > "%WORK%\lang_original.lua"

echo find duplicates IDs...
lua find_duped_ids.lua "%WORK%\list_all_string.lua" > "%WORK%\list_duped_ids.lua"

echo find conflicted IDs...
lua find_conflicted_ids.lua "%WORK%\list_all_string.lua" > "%WORK%\list_conflicted_ids.lua"


:eof
pause
