SOURCES != ls *.fnl | awk 'sub(".fnl$$", ".lua")'

%.lua: %.fnl
	fennel -c $< > .lua/$@

bin: ${SOURCES}
	zip redbean.com .init.lua .lua/*.lua

deps:
	curl https://redbean.dev/redbean-latest.com >redbean.com && chmod +x redbean.com
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	# sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"

run: bin
	ls redbean.com | entr -r ./redbean.com -u

dbg: bin
	DEBUG=1 ./redbean.com -u
