# Lua-utils-for-Rebel-Galaxy

### требования
* Lua 5.3 (http://www.lua.org/download.html)
* lua-zlib (https://github.com/brimworks/lua-zlib)
* lua-lfs (https://github.com/keplerproject/luafilesystem)

для Win x64 имеется готовый комплект, [lua531_zlib_lfs_x64.zip](https://mega.nz/#!2wYmkRJK!iQvJd-n7zsm2z6nMhBhVM22I4I77EY7AbPUng_ikjlI).

### использование

#### распаковка
````
lua unpack.lua fullpath_to_PAK [output_dir]

output_dir : существующий выходной каталог. без его указания происходит сканирование архива.
````

#### упаковка
````
lua pack.lua fullpath_to_dir [output_file]

fullpath_to_dir : путь к распакованным ресурсам
output_file : имя выходного архива, по умолчанию — DATA2.PAK в текущем каталоге
````


#### конвертер DAT -> TXT
````
lua dat2txt.lua fullpath_to_DAT [> output_file]

по умолчанию вывод в консоль
````
