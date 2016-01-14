@echo off

if %1.==. goto eof

call 0-include.cmd

set TMPFILE=%WORK%\%RANDOM%

cls

findstr /d:"%EXPORT%_DAT" /s /n /c:" v=%1 " *.LUA > %TMPFILE%

lua tmp_format_finded_id.lua %TMPFILE%

del /q /f %TMPFILE%

:eof
