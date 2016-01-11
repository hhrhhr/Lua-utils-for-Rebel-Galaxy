@echo off

call 0-include.cmd

if not exist "%UNPACK%" mkdir "%UNPACK%"

rem вытащить только DAT-ы
lua unpack.lua "%RGDIR%\PAKS\DATA.PAK" "%UNPACK%" 15
lua unpack.lua "%RGDIR%\PAKS\DATA.PAK" "%UNPACK%" 25

pause
