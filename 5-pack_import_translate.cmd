@echo off

call 0-include.cmd

if not exist "%RGDIR%\PAKS" goto eof

echo start packing...
lua pack.lua "%IMPORT%" "%RGDIR%\PAKS\DATA_RUS.PAK" ".DAT"

:eof
pause
