# Lua-utils-for-Rebel-Galaxy

### требования
* Lua 5.3 (http://www.lua.org/download.html)
* lua-zlib (https://github.com/brimworks/lua-zlib)

для Win x64 имеется готовый комплект, [lua531_lua_zlib_x64.zip](https://github.com/hhrhhr/Lua-utils-for-Witcher-3/releases/download/bin/lua531_lua_zlib_x64.zip).

### использование

#### распаковка
````
lua unpack.lua fullpath_to_PAK [output_dir|debug]

output_dir : выходной каталог, должен существовать. по умолчанию — текущий каталог. 
debug      : просто отладочный вывод.
````

#### конвертор DAT -> TXT
````
lua dat2txt.lua fullpath_to_DAT [> output_file]

по умолчанию вывод в консоль
````
