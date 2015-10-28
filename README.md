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
к именам всех файлов добавляется цифровой префикс вида *XX_имяфайла*, где *XX* — внутригровой тип ресурса. это требуется для скрипта упаковки, чтобы не хранить тип в отдельном файле.

#### упаковка
````
lua pack.lua fullpath_to_dir [output_file]

fullpath_to_dir : путь к распакованным ресурсам
output_file : имя выходного архива, по умолчанию — DATA2.PAK в текущем каталоге
````
по указанному пути должен находится только каталог *MEDIA*.

#### конвертер DAT -> TXT
````
lua dat2txt.lua fullpath_to_DAT [> output_file]

по умолчанию вывод в консоль
````
в начале идет вывод строкового словаря в Lua-подобном формате, далее следует конвертированное содержание файла выглядящее примерно так:
````
local dict_ext = {
    [key1] = 'value1',
    [key2] = 'value2',
...
[tag1]
  <type>name:value
  [$key3]
    <type>name:$key2:value2
    <$key4>$key5:value
...
  [/$key3]
[/tag1]
````
значение или имя элемента подставляется из файла *dict.lua* или из встроенного словаря, иначе оно выглядит как *$xxxxxx*, где *x* — цифра. это позволяет провести обратную конвертацию (WIP).
