SOURCES != ls *.fnl | awk 'sub(".fnl$$", ".lua")'

%.lua: %.fnl
	fennel -c $< > .lua/$@

bin: ${SOURCES}
	zip redbean.com .init.lua .lua/*.lua

deps:
	curl https://redbean.dev/redbean-latest.com >redbean.com
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua

run: bin
	ls redbean.com | entr -r ./redbean.com -u
