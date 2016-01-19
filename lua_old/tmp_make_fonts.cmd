@echo off

set BMFONT=E:\soft\tools\BMFont\bmfont.exe
set IM=E:\soft\graphics\ImageMagick-6.9.1-Q16\convert.exe
set NV=E:\soft\tools\NVIDIA Texture Tools 2\bin\nvcompress.exe

set FDIR=z:\TEMP\RG\_fonts_raster\MEDIA\FONTS
set IDIR=z:\TEMP\RG\_fonts
set PDIR=f:\lalala\Rebel Galaxy\PAKS

"%BMFONT%" -c "%FDIR%\verdana.bmfc" -o "%FDIR%\verdana.fnt"
"%BMFONT%" -c "%FDIR%\trivial.bmfc" -o "%FDIR%\trivial.fnt"

"%IM%" -append "%FDIR%\verdana_0.tga" "%FDIR%\trivial_0.tga" "%FDIR%\font_ru.tga"

lua fnt2fontdef.lua "%FDIR%\verdana.fnt" Verdana font_ru.dds > "%IDIR%\MEDIA\FONTS\25_DUAL.FONTDEF"
lua fnt2fontdef.lua "%FDIR%\trivial.fnt" Trivial font_ru.dds 1024 > "%IDIR%\MEDIA\FONTS\25_TRIVIAL.FONTDEF"

"%NV%" -bc3 "%FDIR%\font_ru.tga"

copy /y "%FDIR%\font_ru.dds" "%IDIR%\MEDIA\FONTS\3_FONT_RU.DDS"

lua pack.lua "%IDIR%" "%PDIR%\DATA_RUS_FONTS.PAK"
