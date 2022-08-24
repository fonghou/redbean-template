.SUFFIXES: .fnl .lua
.PHONY: dev fnl

SOURCES != find -name \*.fnl | awk 'sub(".fnl$$", ".lua")'

.fnl.lua:
	fennel -c $< > $@

fnl: ${SOURCES}

dev:
	find -name \*.lua | entr -r ./redbean.com -u -D . -F fnl/hello.lua
