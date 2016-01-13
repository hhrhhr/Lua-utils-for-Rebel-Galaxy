@echo off

call 0-include.cmd

if not exist "%WORK%" goto eof

echo recheck for conlicted IDs...
lua check_for_conflicted_ids.lua "%WORK%\t_list_all_string.txt" "%WORK%\list_conflicted_ids.lua" > "%WORK%\t_list_conflicted_ids.txt"

echo recheck for duplicated IDs...
lua check_for_duplicated_ids.lua "%WORK%\t_list_all_string.txt" "%WORK%\lang_original.lua" > "%WORK%\t_list_duplicated_ids.lua"

:eof
pause
