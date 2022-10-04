PROJECT = redbean.com

SOURCES = $(shell ls src/*.fnl | sed 's/.fnl$$/.lua/' | sed 's/^src/.lua/')

.lua/%.lua: src/%.fnl
	fennel --compile $< >$@

build: ${SOURCES}
	zip -r ${PROJECT} .init.lua .lua

clean:
	rm -f ${SOURCES} && zip -q -d ${PROJECT} ${SOURCES} || true

debug: clean
	DEBUG=1 ./${PROJECT} -u -D .

run: clean
	ls ${PROJECT} src/*.fnl | entr -r ./${PROJECT} -u -D .

repl: clean
	./${PROJECT} -F .init.lua -e "require'fennel'.repl()" -i

db:
	./sqlite3.com db.sqlite3 < schema.sql

deps:
	curl https://redbean.dev/redbean-latest.com >${PROJECT} && chmod +x ${PROJECT}
	curl https://redbean.dev/sqlite3.com > sqlite3.com && chmod +x sqlite3.com
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	cp ~/github/fennel/fennel.lua .lua/
	sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
