@echo off

call 0-include.cmd

if not exist "%UNPACK%_DAT" mkdir "%UNPACK%_DAT"
if not exist "%UNPACK%_IMAGESET" mkdir "%UNPACK%_IMAGESET"
if not exist "%UNPACK%_ANIMATION" mkdir "%UNPACK%_ANIMATION"

echo unpack *.DAT...
lua unpack.lua "%RGDIR%\PAKS\DATA.PAK" "%UNPACK%_DAT" 15

echo unpack *.IMAGESET...
lua unpack.lua "%RGDIR%\PAKS\DATA.PAK" "%UNPACK%_IMAGESET" 12

echo unpack *.ANIMATION...
lua unpack.lua "%RGDIR%\PAKS\DATA.PAK" "%UNPACK%_ANIMATION" 17


:eof
pause
