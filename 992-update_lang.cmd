@echo off

call 0-include.cmd

if not exist "%UNPACK%" goto eof
if not exist "%WORK%\list_duped_ids_lang.lua" goto eof

set TMPFILE=%WORK%\%RANDOM%

for /r "%TRANSLATE%" %%i in (*.LUA) do (
    lua lua2dat.lua "%%i" "%TMPFILE%" "%WORK%\list_duped_ids_lang.lua"
    lua dat2lua.lua "%TMPFILE%" "%%i"
)

del /q "%TMPFILE%"
